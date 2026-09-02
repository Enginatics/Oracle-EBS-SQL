/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: OTL Timecard Upload
-- Description: OTL Timecard Upload
===================
Create, update and delete Oracle Time and Labor (OTL / HXC) timecards via the public TimeStore deposit API hxc_timestore_deposit, as an Excel-based alternative to self-service time entry.

Row model
=========
One spreadsheet row per timecard line and day: Employee, Date, classification and Hours. Rows are grouped into timecards by employee and the OTL timecard period (e.g. the weekly period from the employee's OTL preferences) containing the Date. Rows of the same employee and period must be contiguous and are deposited together as one timecard. The Period Starting column fills automatically once Employee and Date are entered.

Classification
==============
Each line is classified either for Projects (Project, Task and Expenditure Type - straight time) or for Payroll (Hours Type = payroll element). The deposit derives the employee's application set, approval style and security context from the OTL preferences, exactly like self-service time entry.

Run the upload under a responsibility whose operating unit context matches the projects being charged (e.g. the OTL or Projects responsibility the employees use) - the deposit validates the project, task, expenditure type and expenditure organization under the session's operating unit, exactly like self-service time entry.

Save and submit
===============
Leave Submit blank to save the timecard in Working status. Set Submit to Yes on any row of a timecard to submit it for approval (the OTL approval workflow starts, e.g. HR supervisor approval). Updating a timecard that is already Submitted or Approved re-submits it for approval automatically.

Updates and deletes
===================
Downloaded lines carry hidden building block ids and are updated through the OTL deposit API, which creates a new timecard version and re-routes approval. Set Delete Line to Yes to remove a line; deleting all lines of a timecard deletes the whole timecard. Timecards already transferred to a recipient application (Projects, Payroll/BEE or Purchasing) are protected and cannot be modified by the upload.

Upload modes
============
Create - empty template for new timecards.
Create, Update - downloads existing timecards (project and payroll element lines) for review, correction, resubmission or deletion.
-- Excel Examle Output: https://www.enginatics.com/example/otl-timecard-upload/
-- Library Link: https://www.enginatics.com/reports/otl-timecard-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
row_number() over (order by x.employee, x.period_starting, x.date_worked, x.detail_bb_id) upload_row,
x.employee,
x.employee_number,
x.approval_status,
x.transferred,
x.period_starting,
x.date_worked,
x.project,
x.task,
x.expenditure_type,
x.hours_type,
x.hours,
x.line_comment,
x.submit_timecard,
x.delete_line,
x.timecard_bb_id,
x.detail_bb_id
from
(
select
papf.full_name employee,
papf.employee_number,
xxen_util.meaning(hts.approval_status,'HXC_APPROVAL_STATUS',3) approval_status,
xxen_util.yes(case when exists (select null from hxc_transaction_details htd, hxc_transactions ht where htd.time_building_block_id=htbb_det.time_building_block_id and htd.time_building_block_ovn=htbb_det.object_version_number and htd.status='SUCCESS' and htd.transaction_id=ht.transaction_id and ht.type='RETRIEVAL' and ht.status='SUCCESS') then 'Y' end) transferred,
trunc(hts.start_time) period_starting,
trunc(htbb_day.start_time) date_worked,
ppa.segment1 project,
pt.task_number task,
decode(hta.attribute_category,'PROJECTS',hta.attribute3) expenditure_type,
petf.element_name hours_type,
htbb_det.measure hours,
htbb_det.comment_text line_comment,
null submit_timecard,
null delete_line,
hts.timecard_id timecard_bb_id,
htbb_det.time_building_block_id detail_bb_id
from
hxc_timecard_summary hts,
hxc_time_building_blocks htbb_day,
hxc_time_building_blocks htbb_det,
hxc_time_attribute_usages htau,
hxc_time_attributes hta,
per_all_people_f papf,
pa_projects_all ppa,
pa_tasks pt,
pay_element_types_f petf
where
:p_upload_mode like '%'||xxen_upload.action_update and
hts.resource_id=papf.person_id and
hts.start_time between papf.effective_start_date and papf.effective_end_date and
htbb_day.parent_building_block_id=hts.timecard_id and
htbb_day.parent_building_block_ovn=hts.timecard_ovn and
htbb_day.scope='DAY' and
htbb_day.date_to=to_date('4712-12-31','YYYY-MM-DD') and
htbb_det.parent_building_block_id=htbb_day.time_building_block_id and
htbb_det.parent_building_block_ovn=htbb_day.object_version_number and
htbb_det.scope='DETAIL' and
htbb_det.date_to=to_date('4712-12-31','YYYY-MM-DD') and
htau.time_building_block_id=htbb_det.time_building_block_id and
htau.time_building_block_ovn=htbb_det.object_version_number and
htau.time_attribute_id=hta.time_attribute_id and
(hta.attribute_category='PROJECTS' or hta.attribute_category like 'ELEMENT - %') and
ppa.project_id(+)=decode(hta.attribute_category,'PROJECTS',to_number(hta.attribute1)) and
pt.task_id(+)=decode(hta.attribute_category,'PROJECTS',to_number(hta.attribute2)) and
petf.element_type_id(+)=case when hta.attribute_category like 'ELEMENT - %' then to_number(substr(hta.attribute_category,11)) end and
htbb_day.start_time between petf.effective_start_date(+) and petf.effective_end_date(+)
) x
where
1=1
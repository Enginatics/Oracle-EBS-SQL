/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Payroll Element Entries Upload
-- Description: PER Payroll Element Entries Upload
==================
Use this upload to upload new or update existing PER Payroll Element Entries.
-- Excel Examle Output: https://www.enginatics.com/example/per-payroll-element-entries-upload/
-- Library Link: https://www.enginatics.com/reports/per-payroll-element-entries-upload/
-- Run Report: https://demo.enginatics.com/

with input_values as
(select * from
(
select peevf.element_entry_id,pivf.name,pivf.input_value_id,peevf.screen_entry_value entry_value, row_number() over (partition by pivf.element_type_id,peevf.element_entry_id order by pivf.display_sequence) rnum from 
pay_input_values_f pivf,
pay_element_entry_values_f peevf
where 
trunc(sysdate) between pivf.effective_start_date and pivf.effective_end_date and
trunc(sysdate) between peevf.effective_start_date and peevf.effective_end_date and 
pivf.input_value_id=peevf.input_value_id
)
pivot ( 
  max(name) value_name, max(input_value_id) value_id,max(entry_value) entry_value
  for rnum in
   (
    1 input1, 2 input2, 3 input3, 4 input4, 5 input5,6 input6, 7 input7, 8 input8, 9 input9, 10 input10, 11 input11, 12 input12, 13 input13, 14 input14, 15 input15 
   )
  )
  )
select 
null action_,
null status_,
null message_,
pbg.name business_group,
pbg.business_group_id,
papf.full_name employee_name,
paaf.assignment_id,
papf.employee_number,
petf.element_name,
pelf.element_link_id,
peef.element_entry_id,
peef.entry_type,
null delete_element_entry,
null datetrack_update_mode,
peef.object_version_number,
to_date(null) effective_date,
peef.effective_start_date effective_start_date, 
peef.effective_end_date effective_end_date,
input1_value_name,
input1_value_id,
input1_entry_value,
input2_value_name,
input2_value_id,
input2_entry_value,
input3_value_name,
input3_value_id,
input3_entry_value,
input4_value_name,
input4_value_id,
input4_entry_value,
input5_value_name,
input5_value_id,
input5_entry_value,
input6_value_name,
input6_value_id,
input6_entry_value,
input7_value_name,
input7_value_id,
input7_entry_value,
input8_value_name,
input8_value_id,
input8_entry_value,
input9_value_name,
input9_value_id,
input9_entry_value,
input10_value_name,
input10_value_id,
input10_entry_value,
input11_value_name,
input11_value_id,
input11_entry_value,
input12_value_name,
input12_value_id,
input12_entry_value,
input13_value_name,
input13_value_id,
input13_entry_value,
input14_value_name,
input14_value_id,
input14_entry_value,
input15_value_name,
input15_value_id,
input15_entry_value
from
per_all_People_f papf,
per_all_assignments_f paaf,
pay_element_entries_f peef,
per_business_groups  pbg,
pay_element_links_f pelf,
pay_element_types_f petf,
input_values iv
where
1=1 and
pbg.business_group_id=papf.business_group_id and
papf.person_id=paaf.person_id and
trunc(sysdate) between papf.effective_start_date and papf.effective_end_date and 
trunc(sysdate) between paaf.effective_start_date and paaf.effective_end_date and
trunc(sysdate) between peef.effective_start_date and peef.effective_end_date and
trunc(sysdate) between pelf.effective_start_date and pelf.effective_end_date and
pelf.element_type_id=peef.element_type_id and
petf.element_type_id=peef.element_type_id and
pelf.business_group_id=pbg.business_group_id and
paaf.assignment_id=peef.assignment_id and
peef.creator_type<>'UT' and
--papf.person_id=28158 and
peef.element_link_id=pelf.element_link_id and
iv.element_entry_id=peef.element_entry_id and
paaf.assignment_type='E' and
not exists
(
select 1
from    
apps.per_periods_of_service ppos   
where
ppos.person_id=papf.person_id and
ppos.period_of_service_id=(select max(period_of_service_id) from per_periods_of_service where person_id = papf.person_id) and
ppos.actual_termination_date < trunc(sysdate)
)
&not_use_first_block
&report_table_select &report_table_name &report_table_where_clause
&processed_run
order by 6,9
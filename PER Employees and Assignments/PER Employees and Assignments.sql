/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Employees and Assignments
-- Description: Human resources employees, assignments and supervisors
-- Excel Examle Output: https://www.enginatics.com/example/per-employees-and-assignments
-- Library Link: https://www.enginatics.com/reports/per-employees-and-assignments
-- Run Report: https://demo.enginatics.com/


select
papf.first_name,
papf.last_name,
(select distinct listagg(xxen_util.user_name(fu.user_id),', ') within group (order by xxen_util.user_name(fu.user_id)) over (partition by fu.employee_id) user_name from fnd_user fu where papf.person_id=fu.employee_id) user_name,
xxen_util.meaning(papf.sex,'SEX',3) gender,
pptv.user_person_type person_type,
papf.employee_number,
papf.national_identifier social_security,
papf.date_of_birth birth_date,
trunc(months_between(sysdate,papf.date_of_birth)/12) age,
xxen_util.meaning(papf.marital_status,'MAR_STATUS',3) status,
xxen_util.meaning(papf.nationality,'NATIONALITY',3) nationality,
papf.effective_start_date,
decode(papf.effective_end_date,to_date('31.12.4712','DD.MM.YYYY'),null,papf.effective_end_date) effective_end_date,
papf.email_address,
paaf.assignment_number,
pjv.name job,
pp.name position,
papf2.full_name supervisor,
haou2.name assignment_organization,
gl.name ledger,
xxen_util.concatenated_segments(paaf.default_code_comb_id) expense_account,
xxen_util.segments_description(paaf.default_code_comb_id) expense_account_description,
hla.location_code,
hla.description location_desc,
pastv.user_status assignment_status,
xxen_util.meaning(pastv.active_flag,'YES_NO',0) active,
xxen_util.meaning(paaf.primary_flag,'YES_NO',0) primary,
xxen_util.meaning(paaf.employment_category,'EMP_CAT',3) employment_category,
xxen_util.meaning(paaf.employee_category,'EMPLOYEE_CATG',3) employee_category,
haou.name business_group,
xxen_util.user_name(papf.created_by) person_created_by,
xxen_util.client_time(papf.creation_date) person_creation_date,
xxen_util.user_name(papf.last_updated_by) person_last_updated_by,
xxen_util.client_time(papf.last_update_date) person_last_update_date,
xxen_util.user_name(paaf.created_by) assignment_created_by,
xxen_util.client_time(paaf.creation_date) asssignment_creation_date,
xxen_util.user_name(paaf.last_updated_by) asssignment_last_updated_by,
xxen_util.client_time(paaf.last_update_date) assignment_last_update_date
from
hr_all_organization_units haou,
(select papf.* from per_all_people_f papf where :effective_date>=papf.effective_start_date and :effective_date<papf.effective_end_date+1) papf,
(select papf.* from per_all_people_f papf where :effective_date>=papf.effective_start_date and :effective_date<papf.effective_end_date+1) papf2,
per_person_types_v pptv,
(select paaf.* from per_all_assignments_f paaf where :effective_date>=paaf.effective_start_date and :effective_date<paaf.effective_end_date+1) paaf,
per_assignment_status_types_v pastv,
hr_all_organization_units haou2,
per_jobs_vl pjv,
per_positions pp,
hr_locations_all hla,
gl_ledgers gl
where
1=1 and
papf.person_type_id=pptv.person_type_id and
papf.business_group_id=haou.organization_id and
papf.person_id=paaf.person_id(+) and
paaf.assignment_status_type_id=pastv.assignment_status_type_id(+) and
paaf.organization_id=haou2.organization_id(+) and
paaf.job_id=pjv.job_id(+) and
paaf.position_id=pp.position_id(+) and
paaf.supervisor_id=papf2.person_id(+) and
paaf.location_id=hla.location_id(+) and
paaf.set_of_books_id=gl.ledger_id(+)
order by
haou.name,
papf.last_name,
papf.first_name,
paaf.assignment_number desc

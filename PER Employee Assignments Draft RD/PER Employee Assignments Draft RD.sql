/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Employee Assignments - Draft RD
-- Description: Employees and their assignment details.
-- Excel Examle Output: https://www.enginatics.com/example/per-employee-assignments-draft-rd
-- Library Link: https://www.enginatics.com/reports/per-employee-assignments-draft-rd
-- Run Report: https://demo.enginatics.com/


select  
papf.person_id,
papf.employee_number,
paaf.location_id,
papf.title,
papf.first_name,
papf.last_name,
papf.full_name,
papf_sup.full_name Supervisor_name,
to_char(papf.date_of_birth,'DD-MON-RRRR') birth_Date,
trunc(months_between(sysdate, papf.date_of_birth)/12) Age,
papf.national_identifier,
papf.email_address,
to_char(papf.effective_start_date,'DD-MON-RRRR') Start_date,
to_char(papf.effective_end_date,'DD-MON-RRRR') End_date,
to_char(papf.original_date_of_hire,'DD-MON-RRRR') Hire_date,
pptt.user_person_type,
xxen_util.meaning(papf.sex,'SEX',3) gender,
xxen_util.meaning(papf.nationality,'NATIONALITY',3) Nationality,
xxen_util.meaning(papf.marital_status,'MAR_STATUS',3) Marital_status,
xxen_util.meaning(papf.per_information1,'US_ETHNIC_GROUP',3) Ethnic_Origin,
paaf.assignment_id,
paaf.assignment_number,
to_char(paaf.effective_start_date,'DD-MON-RRRR') Assignment_Start_date,
to_char(paaf.effective_end_date,'DD-MON-RRRR') Assignment_End_date,
paaf.normal_hours,
xxen_util.meaning(paaf.frequency,'FREQUENCY',3) Frequency,
paaf.time_normal_start,
paaf.time_normal_finish,
hr_general.decode_lookup('EMP_CAT',paaf.employment_category) Assignment_Category,
hr_general.decode_lookup('EMPLOYEE_CATG',paaf.employment_category) Employee_category,
paaf.probation_period,
hr_general.decode_lookup ('QUALIFYING_UNITS',paaf.probation_unit) probation_units,
paaf.date_probation_end,
paaf.notice_period,
hr_general.decode_lookup ('QUALIFYING_UNITS',paaf.notice_period_uom) notice_period_units,
paaf.internal_address_line,
hr_general.decode_lookup ('EMP_ASSIGN_REASON',paaf.change_reason) Assignment_Change_Reason,
paaf.primary_flag,
paaf.manager_flag,
&show_addl_assgn_details
past.user_status Assignment_Status,
--papyf.payroll_name,
pj.name job,
pap.name Position,
pg.name Grade,
hr_general.decode_pay_basis(paaf.pay_basis_id) salary_basis,
haou.name Organization,
pbg.name Business_Group,
xxen_util.meaning(pa.address_type,'ADDRESS_TYPE',3) Address_Type,
pa.address_line1||chr(10)||pa.address_line2||chr(10)||pa.address_line3 Primary_Address,
pa.postal_code,
ftt.territory_short_name Country,
ftt.description Country_name
from
per_all_people_f papf,
per_all_assignments_f paaf,
per_all_people_f papf_sup,
per_assignment_status_types past,
--pay_all_payrolls_f papyf,
per_jobs pj,
per_all_positions pap,
per_Grades pg,
per_person_types_tl pptt,
per_business_groups pbg,
hr_all_organization_units haou,
per_addresses pa,
fnd_territories_tl ftt
where
1=1 and
papf.employee_number is not null and
trunc(sysdate) between papf.effective_start_date and papf.effective_end_date and
papf.person_id=paaf.person_id and
trunc(sysdate) between paaf.effective_start_date and paaf.effective_end_date and
paaf.supervisor_id=papf_sup.person_id and
trunc(sysdate) between papf_sup.effective_start_date and papf_sup.effective_end_date and
papf.person_type_id=pptt.person_type_id and
pptt.language=userenv('lang') and 
--papf.person_id=11396 and
paaf.assignment_status_type_id=past.assignment_status_type_id and 
--paaf.payroll_id=papyf.payroll_id and
--paaf.effective_start_date+1 between papyf.effective_start_date and papyf.effective_end_date and
paaf.business_group_id=haou.business_group_id and
paaf.business_group_id=pbg.business_group_id and
paaf.organization_id=haou.organization_id and
paaf.job_id=pj.job_id(+) and
paaf.position_id=pap.position_id(+) and
paaf.grade_id=pg.grade_id(+) and
paaf.person_id=pa.person_id and
paaf.business_group_id=pa.business_group_id and
pa.date_to is null and
pa.primary_flag='Y' and
ftt.territory_code=pa.country and
ftt.language=userenv('lang')
order by papf.person_id
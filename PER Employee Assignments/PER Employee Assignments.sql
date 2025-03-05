/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Employee Assignments
-- Description: Master data report showing the employee demographic information including name, gender SSN, birthdate, age, nationality, effective start date, and additional profile information.
-- Excel Examle Output: https://www.enginatics.com/example/per-employee-assignments/
-- Library Link: https://www.enginatics.com/reports/per-employee-assignments/
-- Run Report: https://demo.enginatics.com/

select
haouv.name business_group,
papf.title,
papf.first_name,
papf.last_name,
papf.full_name,
(select distinct listagg(xxen_util.user_name(fu.user_id),', ') within group (order by xxen_util.user_name(fu.user_id)) over (partition by fu.employee_id) user_name from fnd_user fu where papf.person_id=fu.employee_id) user_name,
xxen_util.meaning(papf.sex,'SEX',3) gender,
pptv.user_person_type person_type,
papf.employee_number,
papf.national_identifier social_security,
papf.date_of_birth birth_date,
trunc(months_between(sysdate,papf.date_of_birth)/12) age,
xxen_util.meaning(papf.marital_status,'MAR_STATUS',3) marital_status,
xxen_util.meaning(papf.nationality,'NATIONALITY',3) nationality,
papf.effective_start_date start_date,
decode(papf.effective_end_date,to_date('31.12.4712','DD.MM.YYYY'),null,papf.effective_end_date) end_date,
papf.original_date_of_hire hire_date,
trunc(months_between(sysdate,papf.start_date)/12) service_yrs,
round(mod(months_between(sysdate,papf.start_date),12)) service_months,
papf.email_address,
(
select distinct
listagg(xxen_util.meaning(pp.phone_type,'PHONE_TYPE',3)||': '||pp.phone_number,chr(10)) within group (order by pp.phone_type) over (partition by pp.parent_id) phone_number
from
per_phones pp
where
papf.person_id=pp.parent_id and
pp.parent_table='PER_ALL_PEOPLE_F' and
:effective_date between pp.date_from and nvl(pp.date_to,sysdate)
) phone_number,
papf2.full_name supervisor_name,
papf2.email_address supervisor_email,
paaf.assignment_number,
decode(paaf.assignment_type,
'A','Applicant',
'B','Benefits Record',
'C','Contingent Worker',
'CT','Contingent Worker Terms Record',
'E','Employee',
'ET','Employee Terms Record',
'N','Non Worker',
'NT','Non Worker Terms Record',
'P','Pending Worker',
'PT','Pending Worker Terms Record',
'O','Offer',
'OT','Offer Terms Record',
paaf.assignment_type
) assignment_type,
paaf.effective_start_date assignment_start_date,
decode(paaf.effective_end_date,to_date('31.12.4712','DD.MM.YYYY'),null,paaf.effective_end_date) assignment_end_date,
paaf.normal_hours,
xxen_util.meaning(paaf.frequency,'FREQUENCY',3) Frequency,
paaf.time_normal_start,
paaf.time_normal_finish,
pjv.name job,
hapft.name position,
pgv.name grade,
(select ppb.name from per_pay_bases ppb where paaf.pay_basis_id=ppb.pay_basis_id) salary_basis,
paypf.payroll_name,
haouv2.name assignment_organization,
gl.name ledger,
xxen_util.concatenated_segments(paaf.default_code_comb_id) expense_account,
xxen_util.segments_description(paaf.default_code_comb_id) expense_account_description,
hla.location_code,
hla.description location_desc,
hla.region_1,
pastv.user_status assignment_status,
xxen_util.meaning(pastv.active_flag,'YES_NO',0) active,
xxen_util.meaning(paaf.primary_flag,'YES_NO',0) primary,
xxen_util.meaning(paaf.manager_flag,'YES_NO',0) manager,
xxen_util.meaning(paaf.employment_category,'EMP_CAT',3) employment_category,
xxen_util.meaning(paaf.employee_category,'EMPLOYEE_CATG',3) employee_category,
paaf.probation_period,
xxen_util.meaning(paaf.probation_unit,'QUALIFYING_UNITS',3) probation_uom,
paaf.date_probation_end,
paaf.notice_period,
xxen_util.meaning(paaf.notice_period_uom,'QUALIFYING_UNITS',3) notice_period_uom,
paaf.internal_address_line,
xxen_util.meaning(paaf.change_reason,'EMP_ASSIGN_REASON',3) assignment_change_reason,
&flexfield_columns
xxen_util.meaning(pa.address_type,'ADDRESS_TYPE',3) address_type,
pa.address_line1,
pa.address_line2,
pa.address_line3,
pa.postal_code,
ftv.territory_short_name country,
pa.country country_code,
papf.per_information_category,
decode(papf.per_information_category,'ZA',papf.per_information1) za_income_tax_number,
decode(papf.per_information_category,'ZA',papf.per_information2) za_passport_number,
decode(papf.per_information_category,'ZA',papf.per_information10) za_country_of_passport_issue,
decode(papf.per_information_category,'ZA',xxen_util.meaning(papf.per_information9,'YES_NO',0)) za_foreign_national,
decode(papf.per_information_category,'ZA',papf.per_information3) za_work_permit_number,
decode(papf.per_information_category,'ZA',fnd_date.canonical_to_date(papf.per_information8)) za_work_permit_expiry_date,
decode(papf.per_information_category,'ZA',fnd_date.canonical_to_date(papf.per_information11)) za_date_of_naturalization,
decode(papf.per_information_category,'ZA',xxen_util.meaning(papf.per_information4,'ZA_RACE',3)) za_race,
decode(papf.per_information_category,'ZA',papf.per_information5) za_ethnic_origin,
decode(papf.per_information_category,'ZA',papf.per_information6) za_language_preference,
decode(papf.per_information_category,'ZA',papf.per_information7) za_religion,
decode(papf.per_information_category,'ZA',papf.per_information12) za_nature_of_person,
xxen_util.user_name(papf.created_by) person_created_by,
xxen_util.client_time(papf.creation_date) person_creation_date,
xxen_util.user_name(papf.last_updated_by) person_last_updated_by,
xxen_util.client_time(papf.last_update_date) person_last_update_date,
xxen_util.user_name(paaf.created_by) assignment_created_by,
xxen_util.client_time(paaf.creation_date) asssignment_creation_date,
xxen_util.user_name(paaf.last_updated_by) asssignment_last_updated_by,
xxen_util.client_time(paaf.last_update_date) assignment_last_update_date
from
hr_all_organization_units_vl haouv,
(select papf.* from per_all_people_f papf where :effective_date between papf.effective_start_date and papf.effective_end_date) papf,
(select papf.* from per_all_people_f papf where :effective_date between papf.effective_start_date and papf.effective_end_date) papf2,
per_person_types_v pptv,
(select paaf.* from per_all_assignments_f paaf where :effective_date between paaf.effective_start_date and paaf.effective_end_date) paaf,
per_assignment_status_types_v pastv,
hr_all_organization_units_vl haouv2,
per_jobs_vl pjv,
per_all_positions pap,
hr_all_positions_f_tl hapft,
per_grades_vl pgv,
hr_locations_all hla,
gl_ledgers gl,
(select pa.* from per_addresses pa where pa.primary_flag='Y' and :effective_date between pa.date_from and nvl(pa.date_to,:effective_date)) pa,
fnd_territories_vl ftv,
(select paypf.* from pay_all_payrolls_f paypf where :effective_date between paypf.effective_start_date and paypf.effective_end_date) paypf
where
1=1 and
papf.person_type_id=pptv.person_type_id and
papf.business_group_id=haouv.organization_id and
papf.person_id=paaf.person_id(+) and
paaf.assignment_status_type_id=pastv.assignment_status_type_id(+) and
paaf.organization_id=haouv2.organization_id(+) and
paaf.job_id=pjv.job_id(+) and
paaf.position_id=pap.position_id(+) and
pap.position_id=hapft.position_id(+) and
hapft.language(+)=userenv('lang') and
paaf.grade_id=pgv.grade_id(+) and
paaf.supervisor_id=papf2.person_id(+) and
paaf.location_id=hla.location_id(+) and
paaf.set_of_books_id=gl.ledger_id(+) and
papf.business_group_id=pa.business_group_id(+) and
papf.person_id=pa.person_id(+) and
pa.country=ftv.territory_code(+) and
paaf.payroll_id=paypf.payroll_id(+)
order by
haouv.name,
papf.last_name,
papf.first_name,
paaf.assignment_number desc
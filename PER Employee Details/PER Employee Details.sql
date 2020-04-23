/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Employee Details
-- Excel Examle Output: https://www.enginatics.com/example/per-employee-details
-- Library Link: https://www.enginatics.com/reports/per-employee-details
-- Run Report: https://demo.enginatics.com/


select distinct
pad.primary_flag,
papf.employee_number,
papf.title,
papf.first_name,
papf.last_name,
to_char(papf.date_of_birth,'DD-MON-RRRR') birth_Date,
trunc(months_between(sysdate, papf.date_of_birth)/12) Age,
hrlsex.meaning gender,
ppt.user_person_type,
papf.national_identifier,
hrlnat.meaning Nationality,
hrlms.meaning Marital_status,
papf.email_address,
to_char(papf.effective_start_date,'DD-MON-RRRR') Start_date,
to_char(papf.effective_end_date,'DD-MON-RRRR') End_date,
to_char(papf.original_date_of_hire,'DD-MON-RRRR') Hire_date,
pjobs.name Job,
ppos.name Position,
pgrade.name Grade,
haou.name Organization,
pbus.name Business_Group,
hrlat.meaning Address_type,
pad.address_line1 || chr(10) || pad.address_line2 || chr(10) || pad.address_line3 Address,
pad.postal_code,
ftt.territory_short_name Country,
ftt.description Country_name,
hrleg.meaning Ethnic_Origin
from
per_all_people_f papf,
per_all_assignments_f paaf,
per_person_types_tl ppt,
hr_lookups hrlsex,
hr_lookups hrlnat,
hr_lookups hrlms,
hr_lookups hrleg,
hr_lookups hrlat,
per_jobs pjobs,
per_all_positions ppos,
per_addresses pad,
per_grades_tl pgrade,
per_business_groups pbus,
hr_all_organization_units haou,
fnd_territories_tl ftt
where
1=1 and
hrlat.lookup_code(+) = pad.address_type and
hrlat.lookup_type(+) = 'ADDRESS_TYPE' and
hrlsex.lookup_code(+) = papf.sex and
hrlsex.lookup_type(+) = 'SEX' and
hrlnat.lookup_code(+) = papf.nationality and
hrlnat.lookup_type(+) = 'NATIONALITY' and
hrlms.lookup_code(+) = papf.marital_status and
hrlms.lookup_type(+) = 'MAR_STATUS' and
hrleg.lookup_code(+) = papf.per_information1 and
hrleg.lookup_type(+) = 'US_ETHNIC_GROUP' and
ftt.territory_code(+) = pad.country and
pad.business_group_id(+) = papf.business_group_id and
pad.date_to is null and
pad.person_id(+) = papf.person_id and
pgrade.grade_id(+) = paaf.grade_id and
haou.organization_id(+) = paaf.organization_id and
haou.business_group_id(+) = paaf.business_group_id and
pbus.business_group_id(+) = paaf.business_group_id and
ppos.position_id(+) = paaf.position_id and
pjobs.job_id(+) = paaf.job_id and
ppt.person_type_id(+) = papf.person_type_id and
trunc(sysdate) between paaf.effective_start_date and paaf.effective_end_date and
paaf.person_id = papf.person_id and 
trunc(sysdate) between papf.effective_start_date and papf.effective_end_date
/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Employee Contacts and Dependents
-- Description: Employee contact relationships including dependents, beneficiaries, and emergency contacts. Shows contact person details (name, phone, email, address), relationship type, and flags for dependent, beneficiary, emergency contact, and third party payment. Useful for benefits administration, emergency preparedness, and employee records management.
-- Excel Examle Output: https://www.enginatics.com/example/per-employee-contacts-and-dependents/
-- Library Link: https://www.enginatics.com/reports/per-employee-contacts-and-dependents/
-- Run Report: https://demo.enginatics.com/

select
haouv.name business_group,
papf.employee_number,
papf.full_name employee_name,
haouv2.name organization,
hla.location_code location,
xxen_util.meaning(pcr.contact_type,'CONTACT',3) relationship,
papf2.full_name contact_name,
papf2.date_of_birth contact_date_of_birth,
xxen_util.meaning(papf2.sex,'SEX',3) contact_gender,
decode(pcr.primary_contact_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) primary_contact,
decode(pcr.dependent_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) dependent,
decode(pcr.beneficiary_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) beneficiary,
decode(pcr.personal_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) emergency_contact,
decode(pcr.third_party_pay_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) third_party_payment,
pcr.date_start relationship_start_date,
pcr.date_end relationship_end_date,
(
select distinct
listagg(xxen_util.meaning(pp.phone_type,'PHONE_TYPE',3)||': '||pp.phone_number,chr(10)) within group (order by pp.phone_type) over (partition by pp.parent_id) phone_number
from
per_phones pp
where
papf2.person_id=pp.parent_id and
pp.parent_table='PER_ALL_PEOPLE_F' and
sysdate between pp.date_from and nvl(pp.date_to,sysdate)
) contact_phone,
papf2.email_address contact_email,
pa.address_line1 contact_address_line1,
pa.address_line2 contact_address_line2,
pa.town_or_city contact_city,
pa.region_1 contact_state,
pa.postal_code contact_postal_code,
ftv.territory_short_name contact_country,
pcr.sequence_number,
xxen_util.user_name(pcr.created_by) created_by,
xxen_util.client_time(pcr.creation_date) creation_date
from
hr_all_organization_units_vl haouv,
(select papf.* from per_all_people_f papf where sysdate between papf.effective_start_date and papf.effective_end_date) papf,
per_contact_relationships pcr,
(select papf.* from per_all_people_f papf where sysdate between papf.effective_start_date and papf.effective_end_date) papf2,
(select paaf.* from per_all_assignments_f paaf where sysdate between paaf.effective_start_date and paaf.effective_end_date) paaf,
hr_all_organization_units_vl haouv2,
hr_locations_all hla,
(select pa.* from per_addresses pa where pa.primary_flag='Y' and sysdate between pa.date_from and nvl(pa.date_to,sysdate)) pa,
fnd_territories_vl ftv
where
1=1 and
pcr.person_id=papf.person_id and
papf.business_group_id=haouv.organization_id and
pcr.contact_person_id=papf2.person_id and
nvl(pcr.date_end,sysdate+1)>sysdate and
papf.person_id=paaf.person_id(+) and
paaf.primary_flag(+)='Y' and
paaf.assignment_type(+)='E' and
paaf.organization_id=haouv2.organization_id(+) and
paaf.location_id=hla.location_id(+) and
papf2.person_id=pa.person_id(+) and
papf2.business_group_id=pa.business_group_id(+) and
pa.country=ftv.territory_code(+)
order by
haouv.name,
papf.full_name,
pcr.sequence_number,
papf2.full_name
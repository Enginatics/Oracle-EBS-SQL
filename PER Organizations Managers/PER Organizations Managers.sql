/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Organizations & Managers
-- Description: Organizations, their locations, their managers.
-- Excel Examle Output: https://www.enginatics.com/example/per-organizations-managers/
-- Library Link: https://www.enginatics.com/reports/per-organizations-managers/
-- Run Report: https://demo.enginatics.com/

select 
haout.name Organization_name, 
xxen_util.meaning(haou.type,'ORG_TYPE',3) Organization_type,
hl.location_code||'|'||hl.description Org_location,
papf.person_id, 
papf.full_name Manager_name,
paaf.effective_start_date,
hl1.location_code||'|'||hl1.description Manager_location,
pg.name Manager_Grade,
pj.name Job_Title,
pap.name position_Title
from
hr_organization_information hoi,
hr_all_organization_units haou,
hr_locations hl,
hr_all_organization_units_tl haout,
per_all_people_f papf,
per_all_assignments_f paaf,
hr_locations hl1,
per_grades pg,
per_jobs pj,
per_all_positions pap
where 1=1 and
hoi.org_information_context='Organization Name Alias' and
hoi.organization_id=haou.organization_id and
haou.location_id=hl.location_id and
haou.organization_id=haout.organization_id and
hoi.org_information2=to_char(papf.person_id(+)) and
haout.language=userenv('LANG') and
papf.current_employee_flag='Y' and 
sysdate between papf.effective_start_date and papf.effective_end_date and
papf.person_id=paaf.person_id and
sysdate between paaf.effective_start_date and paaf.effective_end_date and
paaf.location_id=hl1.location_id and
paaf.grade_id=pg.grade_id(+) and
paaf.job_id=pj.job_id(+) and
paaf.position_id=pap.position_id(+)
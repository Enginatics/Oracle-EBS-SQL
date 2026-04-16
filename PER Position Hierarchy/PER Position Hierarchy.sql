/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Position Hierarchy
-- Description: Position hierarchy showing the reporting structure of positions with hierarchy level, organization, job, grade, location, budgeted vs actual headcount, vacancy count, and current incumbent names. Useful for position control, staffing analysis, and org chart construction.
-- Excel Examle Output: https://www.enginatics.com/example/per-position-hierarchy/
-- Library Link: https://www.enginatics.com/reports/per-position-hierarchy/
-- Run Report: https://demo.enginatics.com/

select
haouv.name business_group,
ppst.name hierarchy_name,
ppst.version_number hierarchy_version,
level hierarchy_level,
lpad(' ',(level-1)*3)||hapft.name position_name,
hapft.name position,
haouv2.name position_organization,
pjv.name position_job,
pgv.name position_grade,
hla.location_code position_location,
pap.fte,
nvl(pap.max_persons,1) budgeted_headcount,
(
select count(*)
from
per_all_assignments_f paaf,
per_assignment_status_types past
where
pap.position_id=paaf.position_id and
sysdate between paaf.effective_start_date and paaf.effective_end_date and
paaf.primary_flag='Y' and
paaf.assignment_type='E' and
paaf.assignment_status_type_id=past.assignment_status_type_id and
past.per_system_status='ACTIVE_ASSIGN'
) actual_headcount,
nvl(pap.max_persons,1)-(
select count(*)
from
per_all_assignments_f paaf,
per_assignment_status_types past
where
pap.position_id=paaf.position_id and
sysdate between paaf.effective_start_date and paaf.effective_end_date and
paaf.primary_flag='Y' and
paaf.assignment_type='E' and
paaf.assignment_status_type_id=past.assignment_status_type_id and
past.per_system_status='ACTIVE_ASSIGN'
) vacancy_count,
(
select
listagg(papf.full_name,', ') within group (order by papf.full_name)
from
per_all_assignments_f paaf,
per_assignment_status_types past,
per_all_people_f papf
where
pap.position_id=paaf.position_id and
sysdate between paaf.effective_start_date and paaf.effective_end_date and
paaf.primary_flag='Y' and
paaf.assignment_type='E' and
paaf.assignment_status_type_id=past.assignment_status_type_id and
past.per_system_status='ACTIVE_ASSIGN' and
paaf.person_id=papf.person_id and
sysdate between papf.effective_start_date and papf.effective_end_date
) incumbents,
pap.date_effective position_start_date,
pap.date_end position_end_date,
xxen_util.meaning(pap.status,'POSITION_STATUS',800) position_status
from
hr_all_organization_units_vl haouv,
per_pos_structure_versions ppsv,
per_pos_structure_elements ppse,
(select hapf.* from hr_all_positions_f hapf where sysdate between hapf.effective_start_date and hapf.effective_end_date) pap,
hr_all_positions_f_tl hapft,
hr_all_organization_units_vl haouv2,
per_jobs_vl pjv,
per_grades_vl pgv,
hr_locations_all hla,
(
select
ppst.*,
ppsv.version_number,
ppsv.pos_structure_version_id
from
per_position_structures ppst,
per_pos_structure_versions ppsv
where
ppst.position_structure_id=ppsv.position_structure_id and
sysdate between ppsv.date_from and nvl(ppsv.date_to,sysdate)
) ppst
where
1=1 and
ppst.business_group_id=haouv.organization_id and
ppst.pos_structure_version_id=ppsv.pos_structure_version_id and
ppsv.pos_structure_version_id=ppse.pos_structure_version_id and
ppse.subordinate_position_id=pap.position_id and
pap.position_id=hapft.position_id and
hapft.language=userenv('lang') and
pap.organization_id=haouv2.organization_id and
pap.job_id=pjv.job_id(+) and
pap.entry_grade_id=pgv.grade_id(+) and
pap.location_id=hla.location_id(+)
start with
ppse.parent_position_id not in (select ppse2.subordinate_position_id from per_pos_structure_elements ppse2 where ppse2.pos_structure_version_id=ppsv.pos_structure_version_id)
connect by
prior ppse.subordinate_position_id=ppse.parent_position_id and
prior ppse.pos_structure_version_id=ppse.pos_structure_version_id
order siblings by
hapft.name
/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Jobs and Positions
-- Description: Positions valid at the Effective Date with their job, organization, status, valid grades, FTE, maximum persons, headcount and incumbent FTE, plus the jobs that have no position valid at the Effective Date, for enterprises that use jobs only.
-- Headcount counts the active and suspended employee and contingent worker assignments of the position, or for a job without positions, the assignments of the job without a position. Incumbent FTE sums their FTE assignment budget values. Vacancies is the maximum persons of the position, one if blank, minus its headcount.
-- Detail Level Incumbents adds one row per incumbent assignment. Detail Level Extra Information lists one row per position or job extra information record, a position row also showing the extra information of its job. Select an Information Type to show its segments as columns.
-- Excel Example Output: https://www.enginatics.com/example/per-jobs-and-positions/
-- Library Link: https://www.enginatics.com/reports/per-jobs-and-positions/
-- Run Report: https://demo.enginatics.com/

select
x.business_group,
x.record_type,
x.job,
x.position,
x.position_type,
x.position_status,
x.organization,
x.location,
x.entry_grade,
x.valid_grades,
x.permanent,
x.fte,
x.max_persons,
x.headcount,
x.incumbent_fte,
x.vacancies,
x.working_hours,
x.frequency,
x.earliest_hire_date,
x.fill_by_date,
x.supervisor_position,
x.date_from,
x.date_to,
&detail_columns
x.last_updated_by,
x.last_update_date
from
(
select
y.*,
inc.headcount,
inc.incumbent_fte,
case when y.record_type_code='P' then greatest(nvl(y.max_persons,1)-nvl(inc.headcount,0),0) end vacancies
from
(
select
haouv.name business_group,
'P' record_type_code,
'Position' record_type,
'P'||hapfv.position_id incumbent_key,
hapfv.position_id,
hapfv.job_id,
pjv.name job,
hapfv.name position,
xxen_util.meaning(hapfv.position_type,'POSITION_TYPE',3) position_type,
pstv.shared_type_name position_status,
pstv.system_type_cd position_status_code,
haouv2.name organization,
hla.location_code location,
(select pgv.name from per_grades_vl pgv where hapfv.entry_grade_id=pgv.grade_id) entry_grade,
(select listagg(z.name,', ') within group (order by z.sequence, z.name) from (select y.*, sum(lengthb(y.name)+2) over (partition by y.position_id order by y.sequence, y.name) length from (select pvg.position_id, pgv.name, min(pgv.sequence) sequence from per_valid_grades pvg, per_grades_vl pgv where :effective_date between pvg.date_from and nvl(pvg.date_to,:effective_date) and pvg.grade_id=pgv.grade_id group by pvg.position_id, pgv.name) y) z where hapfv.position_id=z.position_id and z.length<=4000) valid_grades,
xxen_util.yes(hapfv.permanent_temporary_flag) permanent,
hapfv.fte,
hapfv.max_persons,
hapfv.working_hours,
xxen_util.meaning(hapfv.frequency,'FREQUENCY',3) frequency,
hapfv.earliest_hire_date,
hapfv.fill_by_date,
(select hapfv2.name from hr_all_positions_f_vl hapfv2 where hapfv.supervisor_position_id=hapfv2.position_id and :effective_date between hapfv2.effective_start_date and hapfv2.effective_end_date) supervisor_position,
hapfv.date_effective date_from,
hapfv.date_end date_to,
xxen_util.user_name(hapfv.last_updated_by) last_updated_by,
xxen_util.client_time(hapfv.last_update_date) last_update_date
from
hr_all_positions_f_vl hapfv,
hr_all_organization_units_vl haouv,
per_jobs_vl pjv,
per_shared_types_vl pstv,
hr_all_organization_units_vl haouv2,
hr_locations_all hla
where
:effective_date between hapfv.effective_start_date and hapfv.effective_end_date and
hapfv.business_group_id=haouv.organization_id and
hapfv.job_id=pjv.job_id and
hapfv.availability_status_id=pstv.shared_type_id(+) and
hapfv.organization_id=haouv2.organization_id and
hapfv.location_id=hla.location_id(+)
union all
select
haouv.name business_group,
'J' record_type_code,
'Job without Positions' record_type,
'J'||pjv.job_id incumbent_key,
to_number(null) position_id,
pjv.job_id,
pjv.name job,
null position,
null position_type,
null position_status,
null position_status_code,
null organization,
null location,
null entry_grade,
(select listagg(z.name,', ') within group (order by z.sequence, z.name) from (select y.*, sum(lengthb(y.name)+2) over (partition by y.job_id order by y.sequence, y.name) length from (select pvg.job_id, pgv.name, min(pgv.sequence) sequence from per_valid_grades pvg, per_grades_vl pgv where :effective_date between pvg.date_from and nvl(pvg.date_to,:effective_date) and pvg.grade_id=pgv.grade_id group by pvg.job_id, pgv.name) y) z where pjv.job_id=z.job_id and z.length<=4000) valid_grades,
null permanent,
to_number(null) fte,
to_number(null) max_persons,
to_number(null) working_hours,
null frequency,
to_date(null) earliest_hire_date,
to_date(null) fill_by_date,
null supervisor_position,
pjv.date_from,
pjv.date_to,
xxen_util.user_name(pjv.last_updated_by) last_updated_by,
xxen_util.client_time(pjv.last_update_date) last_update_date
from
per_jobs_vl pjv,
hr_all_organization_units_vl haouv
where
:effective_date between pjv.date_from and nvl(pjv.date_to,:effective_date) and
pjv.business_group_id=haouv.organization_id and
pjv.job_id not in (select hapf.job_id from hr_all_positions_f hapf where :effective_date between hapf.effective_start_date and hapf.effective_end_date)
) y,
(
select
nvl2(paaf.position_id,'P'||paaf.position_id,'J'||paaf.job_id) incumbent_key,
count(*) headcount,
sum((select pabvf.value from per_assignment_budget_values_f pabvf where paaf.assignment_id=pabvf.assignment_id and pabvf.unit='FTE' and :effective_date between pabvf.effective_start_date and pabvf.effective_end_date)) incumbent_fte
from
per_all_assignments_f paaf,
per_assignment_status_types past
where
:effective_date between paaf.effective_start_date and paaf.effective_end_date and
paaf.assignment_type in ('E','C') and
paaf.assignment_status_type_id=past.assignment_status_type_id and
past.per_system_status in ('ACTIVE_ASSIGN','SUSP_ASSIGN','ACTIVE_CWK','SUSP_CWK_ASG') and
(paaf.position_id is not null or paaf.job_id is not null)
group by
nvl2(paaf.position_id,'P'||paaf.position_id,'J'||paaf.job_id)
) inc
where
y.incumbent_key=inc.incumbent_key(+)
) x
&detail_from
where
3=3
&detail_where
order by
x.business_group,
x.job,
x.position nulls first

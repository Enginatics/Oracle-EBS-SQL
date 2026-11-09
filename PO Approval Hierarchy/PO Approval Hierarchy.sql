/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Approval Hierarchy
-- Description: Purchasing approval hierarchy: for each employee, the approvers above them level by level, with each approver's approval groups and document total limit for the selected document type.
-- The operating unit's Use Approval Hierarchies option (Financials Options) decides the hierarchy: the position hierarchy, which defaults to the document type's default approval hierarchy, or else the supervisor chain of the primary assignments. Both are read as of the As of Date. The approval workflow reads the position hierarchy from the copy built by the Fill Employee Hierarchy program, so run that program when routing differs from this report.
-- One row per employee, level, approver and approval group. Level 0 is the employee's own approval authority. A position held by several people shows one row per holder, a vacant position shows the position without an approver. Employees at the top of the hierarchy appear only as approvers.
-- Approval Amount From is the highest document total limit below that level in the employee's chain, so each approver row shows the amount band it approves. Template By Position shows the approval chain per initiator position instead of per employee.
-- Approval groups are those assigned to the approver's position (position hierarchy) or job (supervisor hierarchy) for the document type in Approval Assignments. Document Total Limit is the amount limit of the group's Document Total rule; account, item and location rules are listed by PO Approval Assignments with Show Approval Group Amounts.
-- Use the Approver parameter to list everyone a person approves for. HR Organization includes the organizations below it in the Organization Hierarchy, which defaults to the business group's primary reporting hierarchy; leave Organization Hierarchy blank to select the HR Organization alone.
-- Excel Example Output: https://www.enginatics.com/example/po-approval-hierarchy/
-- Library Link: https://www.enginatics.com/reports/po-approval-hierarchy/
-- Run Report: https://demo.enginatics.com/

select
xxen_util.meaning(z.hierarchy_mode,'PQH_MEMBER_CD',3) hierarchy_type,
pps.name hierarchy,
papf_i.full_name employee,
papf_i.employee_number,
pp_i.name employee_position,
pjv_i.name employee_job,
haouv_i.name employee_organization,
z.approval_level,
lpad(' ',2*z.approval_level)||papf_a.full_name approver,
papf_a.employee_number approver_number,
pp_a.name approver_position,
pjv_a.name approver_job,
haouv_a.name approver_organization,
papf_a.email_address approver_email,
z.approval_group,
z.approval_amount_from,
z.document_total_limit
from
(
select
x.*,
ag.control_group_name approval_group,
nvl(max(ag.document_total_limit) over (partition by x.person_id order by x.approval_level range between unbounded preceding and 1 preceding),nvl2(ag.control_group_name,0,null)) approval_amount_from, --lower bound of the approval band, computed before the run-screen filters remove the lower levels
ag.document_total_limit
from
(
select /*+ no_merge leading(h) no_merge(ai) no_merge(aa) use_hash(ai aa) */
h.hierarchy_mode,
h.position_structure_id,
h.approval_level,
ai.person_id,
ai.position_id,
ai.job_id,
ai.organization_id,
aa.person_id approver_person_id,
decode(h.hierarchy_mode,'P',h.approver_node_id,aa.position_id) approver_position_id,
aa.job_id approver_job_id,
aa.organization_id approver_organization_id
from
(
select
y.hierarchy_mode,
y.position_structure_id,
y.root_id,
decode(rowgen.column_value,1,y.approval_level-1,y.approval_level) approval_level, --each walk row gives the approver one level below it, the last row of a chain also the top approver
decode(rowgen.column_value,1,y.node_id,y.parent_id) approver_node_id
from
(
select
connect_by_root s.node_id root_id,
level approval_level,
connect_by_isleaf is_leaf,
s.*
from
(
select
'P' hierarchy_mode,
pps.position_structure_id,
ppse.subordinate_position_id node_id,
ppse.parent_position_id parent_id
from
hr_operating_units hou,
financials_system_params_all fspa,
po_document_types_all_vl pdtav,
per_position_structures pps,
per_pos_structure_versions ppsv,
per_pos_structure_elements ppse
where
hou.name=:operating_unit and
hou.organization_id=fspa.org_id and
fspa.use_positions_flag='Y' and
hou.organization_id=pdtav.org_id and
pdtav.type_name=:document_type and
hou.business_group_id=pps.business_group_id and
(pps.name=:hierarchy or :hierarchy is null and pdtav.default_approval_path_id=pps.position_structure_id) and
pps.position_structure_id=ppsv.position_structure_id and
:as_of_date between ppsv.date_from and nvl(ppsv.date_to,:as_of_date) and
ppsv.pos_structure_version_id=ppse.pos_structure_version_id
union all
select
'S' hierarchy_mode,
null position_structure_id,
paaf.person_id node_id,
paaf.supervisor_id parent_id
from
hr_operating_units hou,
financials_system_params_all fspa,
per_all_assignments_f paaf
where
hou.name=:operating_unit and
hou.organization_id=fspa.org_id and
fspa.use_positions_flag='N' and
hou.business_group_id=paaf.business_group_id and
:as_of_date between paaf.effective_start_date and paaf.effective_end_date and
paaf.primary_flag='Y' and
paaf.assignment_type in ('E','C') and
paaf.supervisor_id is not null
) s
connect by nocycle
prior s.parent_id=s.node_id and
level<=nvl(:max_levels,level)
) y,
table(xxen_util.rowgen(y.is_leaf+1)) rowgen
) h,
(
select
paaf.person_id,
decode(fspa.use_positions_flag,'Y',paaf.position_id,paaf.person_id) node_id,
paaf.position_id,
paaf.job_id,
paaf.organization_id
from
hr_operating_units hou,
financials_system_params_all fspa,
per_all_assignments_f paaf
where
hou.name=:operating_unit and
hou.organization_id=fspa.org_id and
:as_of_date between paaf.effective_start_date and paaf.effective_end_date and
paaf.primary_flag='Y' and
paaf.assignment_type in ('E','C')
) ai,
(
select
paaf.person_id,
decode(fspa.use_positions_flag,'Y',paaf.position_id,paaf.person_id) node_id,
paaf.position_id,
paaf.job_id,
paaf.organization_id
from
hr_operating_units hou,
financials_system_params_all fspa,
per_all_assignments_f paaf
where
hou.name=:operating_unit and
hou.organization_id=fspa.org_id and
:as_of_date between paaf.effective_start_date and paaf.effective_end_date and
paaf.primary_flag='Y' and
paaf.assignment_type in ('E','C')
) aa
where
h.root_id=ai.node_id and
h.approver_node_id=aa.node_id(+) and
(h.approval_level>0 or ai.person_id=aa.person_id)
) x,
(
select
nvl2(ppca.position_id,'P','S') hierarchy_mode,
nvl(ppca.position_id,ppca.job_id) key_id,
pcga.control_group_name,
(
select
max(pcr.amount_limit)
from
po_control_rules pcr
where
pcga.control_group_id=pcr.control_group_id and
pcr.object_code='DOCUMENT_TOTAL' and
pcr.rule_type_code='INCLUDE' and
(pcr.inactive_date is null or pcr.inactive_date>:as_of_date)
) document_total_limit
from
hr_operating_units hou,
po_document_types_all_vl pdtav,
po_control_functions pcf,
po_position_controls_all ppca,
po_control_groups_all pcga
where
hou.name=:operating_unit and
hou.organization_id=pdtav.org_id and
pdtav.type_name=:document_type and
pdtav.document_type_code=pcf.document_type_code and
pdtav.document_subtype=pcf.document_subtype and
pcf.action_type_code='APPROVE' and
pcf.control_function_id=ppca.control_function_id and
hou.organization_id=ppca.org_id and
:as_of_date between ppca.start_date and nvl(ppca.end_date,:as_of_date) and
ppca.control_group_id=pcga.control_group_id and
pcga.enabled_flag='Y'
) ag
where
x.hierarchy_mode=ag.hierarchy_mode(+) and
decode(x.hierarchy_mode,'P',x.approver_position_id,x.approver_job_id)=ag.key_id(+)
) z,
per_position_structures pps,
per_all_people_f papf_i,
per_positions pp_i,
per_jobs_vl pjv_i,
hr_all_organization_units_vl haouv_i,
per_all_people_f papf_a,
per_positions pp_a,
per_jobs_vl pjv_a,
hr_all_organization_units_vl haouv_a
where
1=1 and
z.position_structure_id=pps.position_structure_id(+) and
z.person_id=papf_i.person_id and
:as_of_date between papf_i.effective_start_date and papf_i.effective_end_date and
z.position_id=pp_i.position_id(+) and
z.job_id=pjv_i.job_id(+) and
z.organization_id=haouv_i.organization_id and
z.approver_person_id=papf_a.person_id(+) and
:as_of_date between papf_a.effective_start_date(+) and papf_a.effective_end_date(+) and
z.approver_position_id=pp_a.position_id(+) and
z.approver_job_id=pjv_a.job_id(+) and
z.approver_organization_id=haouv_a.organization_id(+)
order by
papf_i.full_name,
papf_i.employee_number,
z.approval_level,
papf_a.full_name,
z.approval_group

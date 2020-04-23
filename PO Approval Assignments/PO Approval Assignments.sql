/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Approval Assignments
-- Description: HR jobs, positions and PO document approval group assignments
-- Excel Examle Output: https://www.enginatics.com/example/po-approval-assignments
-- Library Link: https://www.enginatics.com/reports/po-approval-assignments
-- Run Report: https://demo.enginatics.com/


select
haou.name ou,
haou2.name hr_organization,
pp.name position,
pjv.name job,
pcf.control_function_name document_type,
pcga.control_group_name approval_group,
pcga.description approval_group_description,
ppca.start_date,
ppca.end_date
from
po_position_controls_all ppca,
hr_all_organization_units haou,
hr_all_organization_units haou2,
per_jobs_vl pjv,
(select pp.* from per_positions pp where sysdate between pp.date_effective and nvl (pp.date_end, sysdate)) pp,
po_control_groups_all pcga,
po_control_functions pcf
where
1=1 and
ppca.org_id=haou.organization_id and
ppca.organization_id=haou2.organization_id(+) and
ppca.job_id=pjv.job_id(+) and
ppca.position_id=pp.position_id(+) and
ppca.control_group_id=pcga.control_group_id(+) and
ppca.control_function_id=pcf.control_function_id(+)
order by
haou.name,
pjv.name,
pp.name,
pcga.control_group_name,
pcf.control_function_name
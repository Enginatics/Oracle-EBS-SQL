/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Approval Assignments
-- Description: Active PO document approval group assignments with HR jobs or positions
-- Excel Examle Output: https://www.enginatics.com/example/po-approval-assignments/
-- Library Link: https://www.enginatics.com/reports/po-approval-assignments/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
haouv2.name hr_organization,
pp.name position,
pjv.name job,
pcf.control_function_name document_type,
pcga.control_group_name approval_group,
pcga.description approval_group_description,
ppca.start_date,
xxen_util.user_name(ppca.created_by) created_by,
xxen_util.client_time(ppca.creation_date) creation_date,
xxen_util.user_name(ppca.last_updated_by) last_updated_by,
xxen_util.client_time(ppca.last_update_date) last_update_date,
xxen_util.meaning(pcf.document_type_code,'DOCUMENT TYPE',201) document_type_,
xxen_util.meaning(pcf.document_subtype,'NTN_DOC_TYPE',0) document_subtype
from
po_position_controls_all ppca,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv2,
(select pjv.* from per_jobs_vl pjv where sysdate between pjv.date_from and nvl (pjv.date_to, sysdate)) pjv,
(select pp.* from per_positions pp where sysdate between pp.date_effective and nvl (pp.date_end, sysdate)) pp,
po_control_groups_all pcga,
po_control_functions pcf
where
1=1 and
sysdate between ppca.start_date and nvl(ppca.end_date,sysdate) and
ppca.org_id=haouv.organization_id and
ppca.organization_id=haouv2.organization_id(+) and
ppca.job_id=pjv.job_id(+) and
ppca.position_id=pp.position_id(+) and
ppca.control_group_id=pcga.control_group_id(+) and
ppca.control_function_id=pcf.control_function_id(+)
order by
haouv.name,
pjv.name,
pp.name,
pcga.control_group_name,
pcf.control_function_name
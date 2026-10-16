/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Approval History
-- Description: Approval and action history of purchase orders, releases, agreements and requisitions: one row per entry of the document's action history (submit, forward, approve, reject, return, reserve, cancel, close, hold), in sequence.
-- The pending step of a document awaiting approval is shown with action Pending and the current approver as performer. Days Since Previous Action is measured from the previous history entry, for a pending step until today. Submitted Date is the latest submission up to that step.
-- For a release, Document Number is the number of its blanket agreement.
-- Excel Example Output: https://www.enginatics.com/example/po-approval-history/
-- Library Link: https://www.enginatics.com/reports/po-approval-history/
-- Run Report: https://demo.enginatics.com/

select
x.operating_unit,
x.document_type,
x.document_number,
x.release_number,
x.revision,
x.document_description,
x.supplier,
x.document_status,
x.sequence_num,
x.action,
x.performer,
x.action_date,
x.previous_action_date,
x.days_since_previous_action,
x.submitted_date,
x.approval_path,
x.note,
x.buyer_or_preparer,
x.document_created_by,
x.document_creation_date
from
(
select
haouv.name operating_unit,
(select pdtav.type_name from po_document_types_all_vl pdtav where pah.object_type_code=pdtav.document_type_code and pah.object_sub_type_code=pdtav.document_subtype and coalesce(pha.org_id,pra.org_id,prha.org_id)=pdtav.org_id) document_type,
coalesce(pha.segment1,pha_rel.segment1,prha.segment1) document_number,
pra.release_num release_number,
pah.object_revision_num revision,
coalesce(pha.comments,prha.description) document_description,
(select aps.vendor_name from ap_suppliers aps where coalesce(pha.vendor_id,pha_rel.vendor_id)=aps.vendor_id) supplier,
xxen_util.meaning(coalesce(pha.authorization_status,pra.authorization_status,prha.authorization_status),'AUTHORIZATION STATUS',201) document_status,
pah.sequence_num,
nvl(coalesce(xxen_util.meaning(pah.action_code,'APPR_HIST_ACTIONS',201),xxen_util.meaning(pah.action_code,'APPROVER ACTIONS',201),xxen_util.meaning(pah.action_code,'CONTROL ACTIONS',201),pah.action_code),xxen_util.meaning('PENDING','APPR_HIST_ACTIONS',201)) action,
pah.action_code,
(select max(papf.full_name) keep (dense_rank last order by papf.effective_start_date) from per_all_people_f papf where pah.employee_id=papf.person_id) performer,
case when pah.action_code is not null then pah.action_date end action_date,
lag(pah.action_date) over (partition by pah.object_type_code, pah.object_id order by pah.sequence_num) previous_action_date,
trunc(case when pah.action_code is not null then pah.action_date else sysdate end-lag(pah.action_date) over (partition by pah.object_type_code, pah.object_id order by pah.sequence_num),1) days_since_previous_action,
max(case when pah.action_code='SUBMIT' then pah.action_date end) over (partition by pah.object_type_code, pah.object_id order by pah.sequence_num rows unbounded preceding) submitted_date,
(select pps.name from per_position_structures pps where pah.approval_path_id=pps.position_structure_id) approval_path,
pah.note,
(select max(papf.full_name) keep (dense_rank last order by papf.effective_start_date) from per_all_people_f papf where coalesce(pha.agent_id,pra.agent_id,prha.preparer_id)=papf.person_id) buyer_or_preparer,
xxen_util.user_name(coalesce(pha.created_by,pra.created_by,prha.created_by)) document_created_by,
xxen_util.client_time(coalesce(pha.creation_date,pra.creation_date,prha.creation_date)) document_creation_date
from
po_action_history pah,
po_headers_all pha,
po_releases_all pra,
po_headers_all pha_rel,
po_requisition_headers_all prha,
hr_all_organization_units_vl haouv
where
1=1 and
pah.object_type_code in ('PO','PA','RELEASE','REQUISITION') and
decode(pah.object_type_code,'PO',pah.object_id,'PA',pah.object_id)=pha.po_header_id(+) and
decode(pah.object_type_code,'RELEASE',pah.object_id)=pra.po_release_id(+) and
pra.po_header_id=pha_rel.po_header_id(+) and
decode(pah.object_type_code,'REQUISITION',pah.object_id)=prha.requisition_header_id(+) and
coalesce(pha.org_id,pra.org_id,prha.org_id) in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
coalesce(pha.org_id,pra.org_id,prha.org_id)=haouv.organization_id
) x
where
2=2
order by
x.operating_unit,
x.document_type,
x.document_number,
x.release_number,
x.sequence_num

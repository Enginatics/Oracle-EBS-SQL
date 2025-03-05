/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Acceptance Upload
-- Description: This upload allows users to create new PO Acceptances (Acknowledgments)
-- Excel Examle Output: https://www.enginatics.com/example/po-acceptance-upload/
-- Library Link: https://www.enginatics.com/reports/po-acceptance-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
pav.acceptance_id,
--
hou.name operating_unit,
asu.vendor_name supplier,
asu.segment1 supplier_number,
assa.vendor_site_code supplier_site,
nvl(pha2.segment1,pha.segment1) po_number,
pra.release_num release,
pav.revision_num revision,
pav.action,
pav.action_date,
xxen_util.meaning(pav.accepted_flag,'YES_NO',0) accepted,
pav.acceptance_type,
xxen_util.meaning(pav.accepting_party,'ACCEPTANCE_PARTY',201) acceptance_party,
case when pav.employee_id is not null
then pav.full_name
else po_inq_sv.get_party_vendor_name(pav.created_by)
end accepted_by_employee,
pav.employee_num accepted_by_employee_num,
pav.role,
&lp_note_column comments,
xxen_util.meaning(pav.signature_flag,'YES_NO',0) signature, -- not relevant for buyer acceptances
pav.erecord_id, -- not relevant for buyer acceptances
--
xxen_util.display_flexfield_context(201,'PO_ACCEPTANCES',pav.attribute_category) attribute_category,
xxen_util.display_flexfield_value(201,'PO_ACCEPTANCES',pav.attribute_category,'ATTRIBUTE1',pav.row_id,pav.attribute1) po_acceptance_attribute1,
xxen_util.display_flexfield_value(201,'PO_ACCEPTANCES',pav.attribute_category,'ATTRIBUTE2',pav.row_id,pav.attribute2) po_acceptance_attribute2,
xxen_util.display_flexfield_value(201,'PO_ACCEPTANCES',pav.attribute_category,'ATTRIBUTE3',pav.row_id,pav.attribute3) po_acceptance_attribute3,
xxen_util.display_flexfield_value(201,'PO_ACCEPTANCES',pav.attribute_category,'ATTRIBUTE4',pav.row_id,pav.attribute4) po_acceptance_attribute4,
xxen_util.display_flexfield_value(201,'PO_ACCEPTANCES',pav.attribute_category,'ATTRIBUTE5',pav.row_id,pav.attribute5) po_acceptance_attribute5,
xxen_util.display_flexfield_value(201,'PO_ACCEPTANCES',pav.attribute_category,'ATTRIBUTE6',pav.row_id,pav.attribute6) po_acceptance_attribute6,
xxen_util.display_flexfield_value(201,'PO_ACCEPTANCES',pav.attribute_category,'ATTRIBUTE7',pav.row_id,pav.attribute7) po_acceptance_attribute7,
xxen_util.display_flexfield_value(201,'PO_ACCEPTANCES',pav.attribute_category,'ATTRIBUTE8',pav.row_id,pav.attribute8) po_acceptance_attribute8,
xxen_util.display_flexfield_value(201,'PO_ACCEPTANCES',pav.attribute_category,'ATTRIBUTE9',pav.row_id,pav.attribute9) po_acceptance_attribute9,
xxen_util.display_flexfield_value(201,'PO_ACCEPTANCES',pav.attribute_category,'ATTRIBUTE10',pav.row_id,pav.attribute10) po_acceptance_attribute10,
xxen_util.display_flexfield_value(201,'PO_ACCEPTANCES',pav.attribute_category,'ATTRIBUTE11',pav.row_id,pav.attribute11) po_acceptance_attribute11,
xxen_util.display_flexfield_value(201,'PO_ACCEPTANCES',pav.attribute_category,'ATTRIBUTE12',pav.row_id,pav.attribute12) po_acceptance_attribute12,
xxen_util.display_flexfield_value(201,'PO_ACCEPTANCES',pav.attribute_category,'ATTRIBUTE13',pav.row_id,pav.attribute13) po_acceptance_attribute13,
xxen_util.display_flexfield_value(201,'PO_ACCEPTANCES',pav.attribute_category,'ATTRIBUTE14',pav.row_id,pav.attribute14) po_acceptance_attribute14,
xxen_util.display_flexfield_value(201,'PO_ACCEPTANCES',pav.attribute_category,'ATTRIBUTE15',pav.row_id,pav.attribute15) po_acceptance_attribute15,
--
:p_default_action default_action,
:p_default_date default_action_date,
1 seq
from
po_acceptances_v pav,
po_headers_all pha,
po_releases_all pra,
po_headers_all pha2,
ap_suppliers asu,
ap_supplier_sites_all assa,
hr_operating_units hou
where
-- this upload only supports upload of new buyer acceptances
'X'='Y' and
:p_upload_mode = :p_upload_mode and
hou.name = :p_operating_unit and
nvl(pav.accepting_party,'B') = 'B' and
pav.po_header_id = pha.po_header_id (+) and
pav.po_release_id = pra.po_release_id (+) and
pra.po_header_id = pha2.po_header_id (+) and
nvl(pha2.vendor_id,pha.vendor_id) = asu.vendor_id and
nvl(pha2.vendor_site_id,pha.vendor_site_id) = assa.vendor_site_id and
nvl(pha2.org_id,pha.org_id) = hou.organization_id
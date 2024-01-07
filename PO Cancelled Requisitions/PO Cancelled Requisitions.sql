/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Cancelled Requisitions
-- Description: Application: Purchasing
Source: Cancelled Requisition Report (XML)
Short Name: POXRQCRQ_XML
DB package: PO_POXRQCRQ_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/po-cancelled-requisitions/
-- Library Link: https://www.enginatics.com/reports/po-cancelled-requisitions/
-- Run Report: https://demo.enginatics.com/

select
x.operating_unit,
x.requisition_number,
x.requisition_type,
x.requisition_date,
x.created_by,
x.preparer,
x.cancelled_date,
x.cancelled_by,
x.cancelled_reason
 -- line
&lp_line_cols
from
(
select
 -- header
 mgoat.organization_name operating_unit,
 prh.segment1 requisition_number,
 t.type_name requisition_type,
 trunc(prh.creation_date) requisition_date,
 nvl(papf3.full_name,fu.user_name || ' (' || fu.description || ')') created_by,
 papf.full_name preparer,
 trunc(pah.action_date) cancelled_date,
 papf2.full_name cancelled_by,
 pah.note cancelled_reason,
 -- line
 prl.line_num line_number,
 mc.concatenated_segments category,
 msi.concatenated_segments item,
 prl.item_revision item_revision,
 prl.item_description line_description,
 prl.unit_meas_lookup_code uom,
 prl.quantity quantity,
 prl.unit_price unit_price,
 papf4.full_name requestor,
 trunc(prl.cancel_date) line_cancelled_date,
 prl.cancel_reason line_cancelled_reason,
 --
 decode(psp1.manual_req_num_type, 'NUMERIC' ,null, prh.segment1) ord_sort_1,
 decode(psp1.manual_req_num_type, 'NUMERIC' ,to_number(prh.segment1), null) ord_sort_2
from
 po_requisition_headers_all prh,
 fnd_user fu,
 per_all_people_f papf,
 per_all_people_f papf2,
 per_all_people_f papf3,
 po_action_history pah,
 po_document_types_all_tl t,
 po_document_types_all_b b,
 po_system_parameters_all psp1,
 mo_glob_org_access_tmp mgoat,
 --
 financials_system_params_all fspa,
 (select prl.*
  from po_requisition_lines_all prl
  where :p_show_lines = 'Y'
 ) prl,
 per_all_people_f papf4,
 mtl_categories_kfv mc,
 mtl_system_items_vl msi
where
     1=1
 and prh.org_id = psp1.org_id
 and prh.org_id = mgoat.organization_id
 and pah.object_id = prh.requisition_header_id
 and pah.object_type_code = 'REQUISITION'
 and pah.action_code = 'CANCEL'
 and prh.type_lookup_code = b.document_subtype
 and b.document_type_code = t.document_type_code
 and b.document_subtype = t.document_subtype
 and b.org_id = t.org_id
 and b.org_id = prh.org_id
 and t.language = userenv('LANG')
 and b.document_type_code = 'REQUISITION'
 and nvl(prh.contractor_requisition_flag, 'N') <> 'Y'
 and papf.person_id = prh.preparer_id
 and papf2.person_id = pah.employee_id
 and fu.user_id = prh.created_by
 and papf3.person_id(+) = fu.employee_id
 --
 and fspa.org_id = prh.org_id
 and prl.requisition_header_id(+)= prh.requisition_header_id
 and nvl(prl.modified_by_agent_flag,'N') = 'N'
 and mc.category_id(+) = prl.category_id
 and msi.inventory_item_id(+) = prl.item_id
 and nvl(msi.organization_id,fspa.inventory_organization_id) = fspa.inventory_organization_id
 and papf4.person_id(+) = prl.to_person_id
 --
 and trunc(sysdate) between papf.effective_start_date and papf.effective_end_date
 and decode(hr_general.get_xbg_profile,'Y', papf.business_group_id , hr_general.get_business_group_id) = papf.business_group_id
 and trunc(sysdate) between papf2.effective_start_date and papf2.effective_end_date
 and decode(hr_general.get_xbg_profile,'Y', papf2.business_group_id , hr_general.get_business_group_id) = papf2.business_group_id
 and trunc(sysdate) between papf3.effective_start_date (+) and papf3.effective_end_date (+)
 and decode(hr_general.get_xbg_profile,'Y', papf3.business_group_id(+) , hr_general.get_business_group_id) = papf3.business_group_id(+)
 and trunc(sysdate) between papf4.effective_start_date (+) and papf4.effective_end_date (+)
 and decode(hr_general.get_xbg_profile,'Y', papf4.business_group_id(+) , hr_general.get_business_group_id) = papf4.business_group_id(+)
) x
order by
x.ord_sort_1,
x.ord_sort_2,
x.line_number
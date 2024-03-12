/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Purchasing Document Upload
-- Description: Upload to create and update purchase documents
-- Excel Examle Output: https://www.enginatics.com/example/po-purchasing-document-upload/
-- Library Link: https://www.enginatics.com/reports/po-purchasing-document-upload/
-- Run Report: https://demo.enginatics.com/

with reporting_table as
( select * from &report_table_name),
document_types_ as
(
select
distinct
case when pdtat.document_type_code='QUOTATION' then pdtat.document_type_code else pdtat.document_subtype end document_type,
pdtat.type_name document_type_name
from
po_document_types_all_tl pdtat,
po_document_types_all_b pdtab,
hr_all_organization_units_vl haouv
where
2=2 and
3=3 and
pdtab.org_id=haouv.organization_id and
pdtab.org_id=pdtat.org_id and
pdtab.document_type_code in ('PO','PA','QUOTATION') and
pdtab.document_subtype in ('BLANKET','CONTRACT','STANDARD') and
pdtab.document_type_code=pdtat.document_type_code and
pdtab.document_subtype=pdtat.document_subtype and
pdtat.language=userenv ('lang')
),
po_lines_ as
(
select
pla.po_line_id,
pla.line_reference_num,
pla.po_header_id,
pla.line_num,
pltt.line_type,
msiv.concatenated_segments item,
pla.unit_meas_lookup_code unit_of_measure,
pla.unit_price,
pla.quantity line_quantity,
pla.item_description description,
mcv.category_concat_segs category
from
po_lines_all pla,
po_line_types_tl pltt,
mtl_categories_v mcv,
mtl_system_items_vl msiv
where
nvl(pla.cancel_flag,'N') = 'N' and
nvl(pla.closed_code,'OPEN') != 'FINALLY CLOSED' and
pltt.language=userenv('lang') and
pltt.line_type_id=pla.line_type_id and
pla.category_id=mcv.category_id(+) and
msiv.inventory_item_id(+) = pla.item_id and
msiv.organization_id(+) = po_lines_sv4.get_inventory_orgid(pla.org_id)
),
po_line_locations_ as
(
select
plla.po_line_id,
plla.line_location_id,
plla.shipment_num,
plla.quantity ship_quantity,
plla.price_override break_price,
plla.unit_meas_lookup_code break_unit_of_measure,
plla.price_discount discount,
mp.organization_code ship_to_organization_code,
hla.location_code ship_to_location_code,
plla.need_by_date,
plla.promised_date
from
po_line_locations_all plla,
mtl_parameters mp,
hr_locations_all hla
where
plla.ship_to_location_id=hla.location_id(+) and
plla.ship_to_organization_id=mp.organization_id(+)
)
select
null action_,
null status_,
null message_,
pha.org_id,
to_number(null) request_id_,
to_number(null) interface_header_id,
pha.po_header_id,
pha.segment1 po_number,
null group_,
pha.revision_num,
pha.creation_date,
pt.document_type_name document_type,
pha.authorization_status approval_status,
pha.currency_code,
pha.reference_num header_reference_num,
pha.comments header_description,
papf.full_name buyer,
pv.vendor_name supplier_name,
pvsa.vendor_site_code supplier_site,
pha.blanket_total_amount amount_agreed,
hla2.location_code header_ship_to_location,
hla1.location_code header_bill_to_location,
to_number(null) interface_line_id,
pl.po_line_id,
pl.line_num,
pl.line_reference_num,
pl.line_type,
pl.item,
pl.category,
pl.description,
pl.unit_of_measure,
pl.unit_price price,
pl.line_quantity, 
to_number(null) interface_line_location_id,
pll.line_location_id,
pll.shipment_num,
pll.ship_quantity,
pll.break_price,
pll.break_unit_of_measure,
--pll.discount,
pll.ship_to_organization_code,
pll.ship_to_location_code,
pll.need_by_date,
pll.promised_date,
to_number(null) interface_distribution_id,
pda.po_distribution_id,
pda.distribution_num,
pda.quantity_ordered,
gcck.concatenated_segments charge_account,
null create_or_update_items,
null group_lines
from
po_headers_all pha,
per_all_people_f papf,
po_vendors pv,
po_vendor_sites_all pvsa,
hr_locations_all hla1,
hr_locations_all hla2,
po_distributions_all pda,
gl_code_combinations_kfv gcck,
hr_all_organization_units_vl haouv,
document_types_ pt,
po_lines_ pl,
po_line_locations_ pll
where
1=1 and
2=2 and
pha.org_id=haouv.organization_id and
pha.type_lookup_code=pt.document_type and
papf.person_id=pha.agent_id and
trunc(sysdate) between papf.effective_start_date and papf.effective_end_date and
pha.vendor_id=pv.vendor_id(+) and
pha.vendor_site_id=pvsa.vendor_site_id(+) and
pha.bill_to_location_id=hla1.location_id(+) and
pha.ship_to_location_id=hla2.location_id(+) and
pha.po_header_id=pl.po_header_id(+) and
pl.po_line_id=pll.po_line_id(+) and
pll.line_location_id=pda.line_location_id(+) and
pda.code_combination_id=gcck.code_combination_id(+)
&not_use_first_block
&report_table_select &report_table_where_clause &success_records
&processed_run
order by 7,11,25,36,46
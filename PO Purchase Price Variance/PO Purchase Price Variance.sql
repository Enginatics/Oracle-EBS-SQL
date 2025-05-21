/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Purchase Price Variance
-- Description: Imported Oracle standard Purchase Price Variance report
Source: Purchase Price Variance Report (XML)
Short Name: POXRCPPV_XML
DB package: PO_POXRCPPV_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/po-purchase-price-variance/
-- Library Link: https://www.enginatics.com/reports/po-purchase-price-variance/
-- Run Report: https://demo.enginatics.com/

with x as (
select
hou.organization_id,
gl.name ledger,
hou.name operating_unit,
fc.precision,
nvl(fc.extended_precision,fc.precision) extended_precision,
fspa.inventory_organization_id
from
hr_operating_units hou,
gl_ledgers gl,
fnd_currencies fc,
financials_system_params_all fspa
where
2=2 and
hou.set_of_books_id=gl.ledger_id and
gl.currency_code=fc.currency_code and
hou.set_of_books_id=fspa.set_of_books_id and
hou.organization_id=fspa.org_id
),
papf as (
select papf.person_id, papf.full_name from per_all_people_f papf where
(papf.employee_number is not null or papf.npw_number is not null) and
trunc(sysdate) between papf.effective_start_date and papf.effective_end_date and
decode(hr_security.view_all ,'Y' , 'TRUE', hr_security.show_record('PER_ALL_PEOPLE_F',papf.person_id, papf.person_type_id, papf.employee_number,papf.applicant_number ))='TRUE' and
decode(hr_general.get_xbg_profile,'Y', papf.business_group_id , hr_general.get_business_group_id)=papf.business_group_id
)
select
'Receiving PPV' type,
x.ledger,
x.operating_unit,
mp.organization_code,
mcv.category_concat_segs category,
msiv.concatenated_segments item,
msiv.description item_description,
aps.vendor_name vendor,
papf.full_name buyer,
decode(pha.type_lookup_code, 'BLANKET', pha.segment1||' - '||pra.release_num, 'PLANNED', pha.segment1||' - '||pra.release_num, pha.segment1) po_number,
pha.currency_code currency,
pla.line_num line,
rsh.shipment_num shipment,
rt.transaction_date receipt_date,
rsh.receipt_num receipt_number,
round(mmt.primary_quantity,:p_qty_precision) quantity_received,
rt.primary_unit_of_measure unit,
round(nvl(mmt.transaction_cost,0)/nvl(mmt.currency_conversion_rate,1),x.extended_precision) po_unit_price,
round(nvl(mmt.transaction_cost,0),x.extended_precision) po_functional_price,
round(nvl(mmt.actual_cost,0),x.extended_precision) std_unit_cost,
round(nvl(mcacd1.actual_cost,0),x.extended_precision) material_unit_cost,
round(decode(mta.accounting_line_type,3,nvl(mcacd2.actual_cost,0),0),x.extended_precision) material_overhead_unit_cost,
po_poxrcppv_xmlp_pkg.c_price_varianceformula(round(nvl(mmt.transaction_cost,0),x.extended_precision),round(nvl(mmt.actual_cost,0),x.extended_precision),round(decode(mta.accounting_line_type,3,nvl(mcacd2.actual_cost,0),0),x.extended_precision),round(mmt.primary_quantity,:p_qty_precision ),x.precision) purchase_price_variance,
mp.process_enabled_flag,
rt.transaction_id rcv_transaction_id,
pla.item_id
from
x,
rcv_transactions rt,
rcv_shipment_headers rsh,
po_headers_all pha,
po_lines_all pla,
po_line_locations_all plla,
po_distributions_all pda,
po_releases_all pra,
ap_suppliers aps,
mtl_system_items_vl msiv,
mtl_categories_v mcv,
mtl_parameters mp,
papf,
mtl_material_transactions mmt,
mtl_transaction_accounts mta,
mtl_cst_actual_cost_details mcacd1,
mtl_cst_actual_cost_details mcacd2
where
3=3 and
rt.shipment_header_id=rsh.shipment_header_id and
x.organization_id=pha.org_id and
rt.po_header_id=pha.po_header_id and
rt.po_line_id=pla.po_line_id and
rt.po_line_location_id=plla.line_location_id and
rt.po_distribution_id=pda.po_distribution_id and
pda.destination_type_code='INVENTORY' and
plla.po_release_id=pra.po_release_id(+) and
pha.vendor_id=aps.vendor_id and
pla.item_id=msiv.inventory_item_id(+) and
x.inventory_organization_id=msiv.organization_id(+) and
rt.organization_id=mp.organization_id and
mp.process_enabled_flag='N' and
pla.category_id=mcv.category_id(+) and
pha.agent_id=papf.person_id and
rt.transaction_id=mmt.rcv_transaction_id and
rt.organization_id=mmt.organization_id and
exists (select null from mtl_transaction_accounts mta1 where mmt.transaction_id=mta1.transaction_id and mta1.accounting_line_type=6) and
mmt.transaction_id=mta.transaction_id (+) and
mta.accounting_line_type(+)=3 and
mmt.transaction_id=mcacd1.transaction_id(+) and
mmt.transaction_id=mcacd2.transaction_id(+) and
mmt.organization_id=mcacd1.organization_id(+) and
mmt.organization_id=mcacd2.organization_id(+) and
mcacd1.layer_id(+)=-1 and
mcacd2.layer_id(+)=-1 and
mcacd1.cost_element_id(+)=1 and
mcacd2.cost_element_id(+)=2 and
mcacd1.level_type(+)=1 and
mcacd2.level_type(+)=1 and
mmt.transaction_action_id=mcacd1.transaction_action_id(+) and
mmt.transaction_action_id=mcacd2.transaction_action_id(+)
union
select
'Receiving PPV' type,
x.ledger,
x.operating_unit,
mp.organization_code,
mcv.category_concat_segs category,
msiv.concatenated_segments item,
msiv.description description,
aps.vendor_name vendor,
papf.full_name buyer,
decode(pha.type_lookup_code, 'BLANKET', pha.segment1||' - '||pra.release_num, 'PLANNED', pha.segment1||' - '||pra.release_num, pha.segment1) po_number_release,
pha.currency_code currency,
pla.line_num line,
rsh.shipment_num shipment,
rt.transaction_date receipt_date,
rsh.receipt_num receipt_number,
round(decode(rt.transaction_type, 'RETURN TO RECEIVING', rt.primary_quantity * -1, rt.primary_quantity), :p_qty_precision) quantity_received,
rt.primary_unit_of_measure unit,
rt.po_unit_price*(rt.source_doc_quantity/rt.primary_quantity)+nvl(pda.nonrecoverable_tax,0)/decode(pda.quantity_ordered,0,1,pda.quantity_ordered)*(rt.source_doc_quantity/rt.primary_quantity) unit_price,
round(nvl(rt.currency_conversion_rate,1)*nvl(rt.po_unit_price*(rt.source_doc_quantity/rt.primary_quantity),0)+( (nvl(pda.nonrecoverable_tax,0)*nvl(rt.currency_conversion_rate,1))/decode(pda.quantity_ordered,0,1,pda.quantity_ordered)*(rt.source_doc_quantity/rt.primary_quantity)),x.extended_precision) po_functional_price,
round(&p_select_wip,x.extended_precision) std_unit_cost_f,
0 material_cost_f,
0 moh_absorbed_per_unit,
po_poxrcppv_xmlp_pkg.c_price_varianceformula(round(nvl(rt.currency_conversion_rate,1)*nvl(rt.po_unit_price*(rt.source_doc_quantity/rt.primary_quantity),0) + nvl(pda.nonrecoverable_tax,0)*nvl(rt.currency_conversion_rate,1)/decode(pda.quantity_ordered,0,1,pda.quantity_ordered)*(rt.source_doc_quantity/rt.primary_quantity),x.extended_precision),round(&p_select_wip,x.extended_precision ),0,round(decode(rt.transaction_type,'RETURN TO RECEIVING',rt.primary_quantity*-1,rt.primary_quantity),:p_qty_precision),x.precision) c_price_variance,
mp.process_enabled_flag,
rt.transaction_id rct_id,
pla.item_id
from
x,
rcv_transactions rt,
rcv_shipment_headers rsh,
po_headers_all pha,
po_lines_all pla,
po_line_locations_all plla,
po_distributions_all pda,
po_releases_all pra,
ap_suppliers aps,
mtl_system_items_vl msiv,
mtl_categories_v mcv,
mtl_parameters mp,
papf &p_from_wip
where
3=3 and
rt.shipment_header_id=rsh.shipment_header_id and
x.organization_id=pha.org_id and
rt.po_header_id=pha.po_header_id and
rt.po_line_id=pla.po_line_id and
rt.po_line_location_id=plla.line_location_id and
rt.po_distribution_id=pda.po_distribution_id and
pda.destination_type_code='SHOP FLOOR' and
plla.po_release_id=pra.po_release_id(+) and
pha.vendor_id=aps.vendor_id and
pla.item_id=msiv.inventory_item_id(+) and
x.inventory_organization_id=msiv.organization_id(+) and
rt.organization_id=mp.organization_id and
mp.process_enabled_flag='N' and
pla.category_id=mcv.category_id(+) and
pha.agent_id=papf.person_id &p_where_wip
union all
select
'Receiving PPV' type,
x.ledger,
x.operating_unit,
mp.organization_code,
mcv.category_concat_segs category,
msiv.concatenated_segments item,
msiv.description description,
aps.vendor_name vendor,
papf.full_name buyer,
decode(pha.type_lookup_code, 'BLANKET', pha.segment1||' - '||pra.release_num, 'PLANNED', pha.segment1||' - '||pra.release_num, pha.segment1) po_number_release,
pha.currency_code currency,
pla.line_num line,
rsh.shipment_num shipment,
rt.transaction_date receipt_date,
rsh.receipt_num receipt_number,
round(decode(rt.transaction_type,'RETURN TO RECEIVING',rt.primary_quantity*-1,'RETURN TO  VENDOR',rt.primary_quantity*-1,rt.primary_quantity),:p_qty_precision) quantity_received,
rt.primary_unit_of_measure unit,
rt.po_unit_price*(rt.source_doc_quantity/rt.primary_quantity ) + (nvl(pda.nonrecoverable_tax,0)/decode(pda.quantity_ordered,0,1, pda.quantity_ordered)*(rt.source_doc_quantity/rt.primary_quantity)) unit_price,
round(nvl(rt.currency_conversion_rate,1)*nvl(rt.po_unit_price* (rt.source_doc_quantity / rt.primary_quantity),0) + nvl(pda.nonrecoverable_tax,0)*nvl(rt.currency_conversion_rate,1)/decode(pda.quantity_ordered,0,1,pda.quantity_ordered)*(rt.source_doc_quantity/rt.primary_quantity),x.extended_precision) po_functional_price,
po_poxrcppv_xmlp_pkg.std_unit_cost_fformula(pla.item_id,decode(mp.process_enabled_flag,'Y',rt.organization_id,x.inventory_organization_id),rt.transaction_date,mp.process_enabled_flag,0,x.extended_precision) std_unit_cost_f,
0 material_cost_f,
0 moh_absorbed_per_unit,
po_poxrcppv_xmlp_pkg.c_price_varianceformula(round(nvl(rt.currency_conversion_rate,1)*nvl(rt.po_unit_price*(rt.source_doc_quantity/rt.primary_quantity),0) + nvl(pda.nonrecoverable_tax,0)*nvl(rt.currency_conversion_rate,1)/decode(pda.quantity_ordered,0,1,pda.quantity_ordered)*(rt.source_doc_quantity/rt.primary_quantity),x.extended_precision), po_poxrcppv_xmlp_pkg.std_unit_cost_fformula(pla.item_id, decode(mp.process_enabled_flag, 'Y', rt.organization_id, x.inventory_organization_id), rt.transaction_date, mp.process_enabled_flag, 0, x.extended_precision), 0, round(decode(rt.transaction_type,'RETURN TO RECEIVING', rt.primary_quantity * -1,rt.primary_quantity), :p_qty_precision), x.precision) c_price_variance,
mp.process_enabled_flag,
rt.transaction_id rct_id,
pla.item_id
from
x,
rcv_transactions rt,
rcv_shipment_headers rsh,
po_headers_all pha,
po_lines_all pla,
po_line_locations_all plla,
po_distributions_all pda,
po_releases_all pra,
ap_suppliers aps,
mtl_system_items_vl msiv,
mtl_categories_v mcv,
mtl_parameters mp,
papf
where
3=3 and
rt.shipment_header_id=rsh.shipment_header_id and
x.organization_id=pha.org_id and
rt.po_header_id=pha.po_header_id and
rt.po_line_id=pla.po_line_id and
rt.po_line_location_id=plla.line_location_id and
rt.po_distribution_id=pda.po_distribution_id and
pda.destination_type_code in ('INVENTORY','SHOP FLOOR') and
(nvl(plla.lcm_flag,'N')='N' or plla.lcm_flag='Y' and rt.lcm_shipment_line_id is null) and
rt.destination_type_code<>'RECEIVING' and
plla.po_release_id=pra.po_release_id(+) and
pha.vendor_id=aps.vendor_id and
pla.item_id=msiv.inventory_item_id(+) and
x.inventory_organization_id=msiv.organization_id(+) and
rt.organization_id=mp.organization_id and
mp.process_enabled_flag='Y' and
pla.category_id=mcv.category_id(+) and
pha.agent_id=papf.person_id
union all
/* lcm-opm integration added below query  bug 8642337, pmarada */
select distinct
'Receiving PPV' type,
x.ledger,
x.operating_unit,
mp.organization_code,
mcv.category_concat_segs category,
msiv.concatenated_segments item,
msiv.description description,
aps.vendor_name vendor,
papf.full_name buyer,
decode(pha.type_lookup_code, 'BLANKET', pha.segment1||' - '||pra.release_num, 'PLANNED', pha.segment1||' - '||pra.release_num, pha.segment1) po_number_release,
pha.currency_code currency,
pla.line_num line,
rsh.shipment_num shipment,
glat.transaction_date receipt_date,
rsh.receipt_num receipt_number,
round(glat.primary_quantity,:p_qty_precision) quantity_received,
glat.primary_uom_code unit,
rt.po_unit_price*(rt.source_doc_quantity/rt.primary_quantity) + (nvl(pda.nonrecoverable_tax,0)/pda.quantity_ordered)*(rt.source_doc_quantity/rt.primary_quantity) unit_price,
round(nvl(rt.currency_conversion_rate,1)*nvl(rt.po_unit_price*rt.source_doc_quantity/rt.primary_quantity,0) + nvl(pda.nonrecoverable_tax,0)*nvl(rt.currency_conversion_rate,1)/pda.quantity_ordered*(rt.source_doc_quantity/rt.primary_quantity),x.extended_precision) po_functional_price,
po_poxrcppv_xmlp_pkg.std_unit_cost_fformula(pla.item_id, decode(mp.process_enabled_flag, 'Y', rt.organization_id, x.inventory_organization_id), rt.transaction_date, mp.process_enabled_flag, 0 , x.extended_precision) std_unit_cost_f,
0 material_cost_f,
0 moh_absorbed_per_unit,
po_poxrcppv_xmlp_pkg.c_price_varianceformula( round(nvl(rt.currency_conversion_rate,1) * nvl(rt.po_unit_price* (rt.source_doc_quantity / rt.primary_quantity),0) + (( (nvl(pda.nonrecoverable_tax,0) * nvl(rt.currency_conversion_rate,1))/decode (pda.quantity_ordered,0,1,pda.quantity_ordered)) *(rt.source_doc_quantity/rt.primary_quantity)), x.extended_precision), po_poxrcppv_xmlp_pkg.std_unit_cost_fformula(pla.item_id, decode(mp.process_enabled_flag, 'Y', rt.organization_id, x.inventory_organization_id), rt.transaction_date, mp.process_enabled_flag, 0, x.extended_precision), 0, round(decode(rt.transaction_type,'RETURN TO RECEIVING', rt.primary_quantity * -1,rt.primary_quantity), :p_qty_precision), x.precision) c_price_variance,
mp.process_enabled_flag,
rt.transaction_id rct_id,
pla.item_id
from
x,
rcv_transactions rt,
rcv_shipment_headers rsh,
po_headers_all pha,
po_lines_all pla,
po_line_locations_all plla,
po_distributions_all pda,
po_releases_all pra,
ap_suppliers aps,
mtl_system_items_vl msiv,
mtl_categories_v mcv,
mtl_parameters mp,
papf,
gmf_lc_adj_transactions glat
where
3=3 and
4=4 and
rt.shipment_header_id=rsh.shipment_header_id and
x.organization_id=pha.org_id and
rt.po_header_id=pha.po_header_id and
rt.po_line_id=pla.po_line_id and
rt.po_line_location_id=plla.line_location_id and
rt.po_distribution_id=pda.po_distribution_id and
pda.destination_type_code='INVENTORY' and
plla.lcm_flag='Y' and
rt.destination_type_code<>'RECEIVING' and
rt.destination_type_code<>'RECEIVING' and
plla.po_release_id=pra.po_release_id(+) and
pha.vendor_id=aps.vendor_id and
pla.item_id=msiv.inventory_item_id(+) and
x.inventory_organization_id=msiv.organization_id(+) and
rt.transaction_id=glat.rcv_transaction_id and
glat.event_type in (16,17) and
glat.organization_id=mp.organization_id and
mp.process_enabled_flag='Y' and
pla.category_id=mcv.category_id(+) and
pha.agent_id=papf.person_id
union all
select
'Ownership Transfer PPV' type,
gl.name ledger,
hou.name operating_unit,
mp.organization_code,
mcv.category_concat_segs category,
msiv.concatenated_segments item,
msiv.description description,
aps.vendor_name vendor,
papf.full_name buyer,
pha.segment1 po_number_release,
pha.currency_code currency,
null line,
null shipment,
mmt.transaction_date receipt_date,
null receipt_number,
round(mmt.primary_quantity,:p_qty_precision) quantity_received,
msiv.primary_unit_of_measure unit,
round((nvl(mmt.transaction_cost,0)/nvl(mmt.currency_conversion_rate,1)),fc.extended_precision) unit_price,
round(nvl(mmt.transaction_cost,0),fc.extended_precision) po_functional_price,
round(nvl(mmt.actual_cost,0),fc.extended_precision) std_unit_cost_f,
null material_cost_f,
round(case when (select count(*) from mtl_transaction_accounts where transaction_id = mmt.transaction_id and accounting_line_type = 3) > 0 then nvl(mcacd2.actual_cost,0) else 0 end,fc.extended_precision) moh_absorbed_per_unit, 
po_poxrcppv_xmlp_pkg.c_price_variance1formula
(round(nvl(mmt.transaction_cost,0),
 fc.extended_precision),
 round(nvl(mmt.actual_cost,0),fc.extended_precision),
 round(case when (select count(*) from mtl_transaction_accounts where transaction_id = mmt.transaction_id and accounting_line_type = 3) > 0 then nvl(mcacd2.actual_cost,0) else 0 end,fc.extended_precision),
 round(mmt.primary_quantity,:p_qty_precision ),fc.precision
) c_price_variance,
mp.process_enabled_flag,
null rct_id,
mmt.inventory_item_id
from
gl_ledgers gl,
(select fc.currency_code, fc.precision, nvl(fc.extended_precision,fc.precision) extended_precision from fnd_currencies fc) fc,
hr_operating_units hou,
po_headers_all pha,
ap_suppliers aps,
mtl_system_items_vl msiv,
mtl_default_category_sets mdcs,
mtl_item_categories mic,
mtl_categories_v mcv,
mtl_parameters mp,
papf,
mtl_material_transactions mmt,
mtl_cst_actual_cost_details mcacd2
where
2=2 and
5=5 and
gl.currency_code=fc.currency_code and
gl.ledger_id=hou.set_of_books_id and
hou.organization_id=pha.org_id and
pha.vendor_id=aps.vendor_id and
mmt.inventory_item_id=msiv.inventory_item_id and
msiv.organization_id=(select fspa.inventory_organization_id from financials_system_params_all fspa where hou.set_of_books_id=fspa.set_of_books_id and pha.org_id=fspa.org_id) and
mdcs.functional_area_id=2 and
mdcs.category_set_id=mic.category_set_id and
msiv.inventory_item_id=mic.inventory_item_id and
msiv.organization_id=mic.organization_id and
mic.category_id=mcv.category_id(+) and
pha.agent_id=papf.person_id and
pha.po_header_id=mmt.transaction_source_id and
mmt.transaction_action_id=6 and
exists (select null from mtl_transaction_accounts mta1 where mmt.transaction_id=mta1.transaction_id and mta1.accounting_line_type=6) and
mmt.organization_id=mp.organization_id and
mp.process_enabled_flag='N' and
mmt.transaction_id=mcacd2.transaction_id(+) and
mmt.organization_id=mcacd2.organization_id(+) and
mcacd2.layer_id(+)=-1 and
mcacd2.cost_element_id(+)=2 and
mcacd2.level_type(+)=1 and
mmt.transaction_action_id=mcacd2.transaction_action_id(+)
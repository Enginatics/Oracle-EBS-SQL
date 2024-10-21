/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Open Purchase Orders
-- Description: Report to show open purchase orders and related information.  This report will convert any foreign currency purchases into the currency of the general ledger (defaulted from the inventory organization for this session).  Use the To and From Transaction Date parameters to create an average receipt cost and use the Comparison Cost Type parameter to show a comparison 
amounts from another cost type.

Parameters:
===========
Comparison Cost Type: enter the cost type for a comparison against the purchase order prices (optional).  Defaulted from your Costing Method.
Transaction Date From:  starting transaction date for averaging the purchase order receipts (mandatory).  Use these averages for comparing to the PO unit prices.
Transaction Date To:  ending transaction date for averaging the purchase order receipts (mandatory).  Use these averages for comparing to the PO unit prices.
Currency Conversion Date:  enter the currency conversion date to use for converting foreign currency purchases into the currency of the general ledger (mandatory).
Currency Conversion Type:  enter the currency conversion type to use for converting foreign currency purchases into the currency of hhe general ledger (mandatory).
Supplier Name:  specific vendor or supplier you wish to report (optional).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2020 - 2023 Douglas Volz Consulting, Inc. 
-- | All rights reserved. 
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this
-- | permission.
-- +=============================================================================+
-- |        
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  open_po_rept.sql
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     09 Sep 2020 Douglas Volz   Initial Coding based on Purchase Price 
-- |                                     variance report, xxx_ppv_lot_rept.sql
-- |  1.1     10 Sep 2020 Douglas Volz   Added inspection flag.
-- |  1.2     01 Dec 2020 Douglas Volz   Added variance and charge accounts
-- |  1.3     20 Dec 2020 Douglas Volz   Added promise date, Need By Date, project,
-- |                                     Expected Receipt Date, Target Price (PO List Price),
-- |                                     Customer Name and difference columns.
-- |                                     And added Minimum Cost Difference parameter.
-- |  1.4     03 Feb 2021 Douglas Volz   Merged OSP with stock purchase orders.
-- |  1.5     05 Feb 2021 Douglas Volz   Added PO averages and item cost information.
-- |  1.6     07 Jul 2022 Douglas Volz   Add multi-language item status.
-- |  1.7     28 Nov 2023 Andy Haack     Remove tabs, add org access controls, fix for G/L Daily Rates, outer joins. 
-- |  1.8     15 Dec 2023 Douglas Volz   Setting the comparison cost type as mandatory, to
-- |                                     prevent a multiple rows error for the comparison cost type.  
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-open-purchase-orders/
-- Library Link: https://www.enginatics.com/reports/cac-open-purchase-orders/
-- Run Report: https://demo.enginatics.com/

select
plla.ledger,
plla.operating_unit,
mp.organization_code org_code,
aps.vendor_name supplier,
hr.full_name buyer,
msiv.concatenated_segments item_number,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
misv.inventory_item_status_code item_status,
&category_columns
xxen_util.meaning(pda.destination_type_code,'DESTINATION TYPE',201) po_destination_type,
cic.resource_code osp_resource,
pla.vendor_product_num supplier_item,
round(msiv.list_price_per_unit,5) target_or_list_price,
plla.pha_po_number po_number,
pla.line_num po_line,
coalesce(
xxen_util.meaning(plla.closed_code,'DOCUMENT STATE',201),
xxen_util.meaning(pla.closed_code,'DOCUMENT STATE',201),
xxen_util.meaning(plla.pha_closed_code,'DOCUMENT STATE',201) 
) po_line_status,
ppa.segment1 project_number,
ppa.name project_name,
plla.creation_date creation_date,
plla.promised_date promise_date,
plla.need_by_date need_by_date,
to_char(pra.release_num) po_release,
pra.release_date release_date,
(select max(ms.expected_delivery_date) from mtl_supply ms where pda.po_distribution_id=ms.po_distribution_id and ms.supply_type_code in ('PO','RECEIVING','SHIPMENT') and ms.destination_type_code in ('INVENTORY','SHOP FLOOR')) expected_receipt_date,
xxen_util.meaning(decode(plla.inspection_required_flag,'Y','Y'),'YES_NO',0) inspection_required,
muomv_po.uom_code po_uom,
nvl(plla.gl_currency_code,plla.gl_currency_code) po_currency_code,
nvl(plla.price_override,pla.unit_price) po_unit_price,
decode(plla.match_option,'P',trunc(nvl(pda.rate_date,plla.creation_date)),:conversion_date) currency_rate_date,
round(decode(plla.match_option,'P',nvl(pda.rate,1),gdr.conversion_rate),6) po_exchange_rate,
plla.gl_currency_code,
round(decode(plla.match_option,'P',nvl(pda.rate,1),gdr.conversion_rate) * nvl(plla.price_override,pla.unit_price),6) converted_po_unit_price,
mucv.conversion_rate po_uom_conversion_rate,
round(decode(plla.match_option,'P',nvl(pda.rate,1),gdr.conversion_rate) * nvl(plla.price_override,pla.unit_price) * mucv.conversion_rate,6) converted_po_at_primary_uom,
muomv_msi.uom_code uom_code,
round(nvl(cic.unburdened_cost,0),5) unburdened_unit_cost,
round(decode(plla.match_option,'P',nvl(pda.rate,1),gdr.conversion_rate) * nvl(plla.price_override,pla.unit_price) - nvl(cic.unburdened_cost,0),5) unit_cost_difference,
round((decode(plla.match_option,'P',nvl(pda.rate,1),gdr.conversion_rate) * nvl(plla.price_override,pla.unit_price) - nvl(cic.unburdened_cost,0)) * nvl(plla.quantity,0),2) extended_cost_difference,
case
when round(decode(plla.match_option,'P',nvl(pda.rate,1),gdr.conversion_rate * nvl(plla.price_override, pla.unit_price)) - nvl(cic.unburdened_cost,0),5) = 0 then 0 --difference = 0
when round(nvl(cic.unburdened_cost,0),5) = 0 then 100 --item cost = 0
when round(decode(plla.match_option,'P',nvl(pda.rate,1),gdr.conversion_rate) * nvl(plla.price_override, pla.unit_price),5) = 0 then -100 --PO unit price = 0
else round((decode(plla.match_option,'P', nvl(pda.rate,1),gdr.conversion_rate) * nvl(plla.price_override, pla.unit_price) - nvl(cic.unburdened_cost,0)) / xxen_util.zero_to_null(cic.unburdened_cost) * 100,2) --PO Price - item cost / item cost
end percent_difference,
(select cct.cost_type from cst_cost_types cct where mp.primary_cost_method=cct.cost_type_id) current_cost_type,
round(cic.material_cost,5) material_cost,
round(cic.material_overhead_cost,5) material_overhead_cost,
round(cic.resource_cost,5) resource_cost,
round(cic.outside_processing_cost,5) outside_processing_cost,
round(cic.overhead_cost,5) overhead_cost,
round(cic.item_cost,5) current_item_cost,
(select round(cic.material_cost-cic.tl_material_overhead,5) from cst_item_costs cic where pla.item_id=cic.inventory_item_id and plla.ship_to_organization_id=cic.organization_id and cic.cost_type_id=:comparison_cost_type_id) comparison_material_cost,
mmt.receipt_qty average_receipt_quantity,
round(mmt.receipt_amount,2) average_receipt_amount,
round(mmt.receipt_amount/xxen_util.zero_to_null(mmt.receipt_qty),5) average_receipt_cost,
plla.quantity quantity_ordered,
plla.quantity_received quantity_received,
plla.quantity_billed quantity_invoiced,
round(nvl(pda.rate,1) * plla.price_override * plla.quantity * mucv.conversion_rate,2) total_po_amount,
&sla_columns
&segment_columns
pla.creation_date po_line_creation_date
from
po_lines_all pla,
(
select
gl.ledger_id,
gl.name ledger,
haouv.name operating_unit,
gl.currency_code gl_currency_code,
pha.currency_code pha_currency_code,
pha.vendor_id pha_vendor_id,
pha.agent_id pha_agent_id,
pha.closed_code pha_closed_code,
pha.segment1 pha_po_number,
plla.*
from
po_line_locations_all plla,
po_headers_all pha,
org_organization_definitions ood,
hr_all_organization_units_vl haouv,
gl_ledgers gl
where
1=1 and
(nvl(fnd_profile.value('XXEN_REPORT_USE_LEDGER_SECURITY'),'N')='N' or ood.set_of_books_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))) and
(nvl(fnd_profile.value('XXEN_REPORT_USE_OPERATING_UNIT_SECURITY'),'N')='N' or ood.operating_unit in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)) and
plla.ship_to_organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
pha.closed_date is null and
plla.closed_date is null and
plla.po_header_id=pha.po_header_id and
plla.ship_to_organization_id=ood.organization_id and
ood.operating_unit=haouv.organization_id and
ood.set_of_books_id=gl.ledger_id
) plla,
po_distributions_all pda,
&sla_tables
po_releases_all pra,
mtl_parameters mp,
ap_suppliers aps,
mtl_system_items_vl msiv,
mtl_item_status_vl misv,
mtl_uom_conversions_view mucv,
mtl_units_of_measure_vl muomv_po,
mtl_units_of_measure_vl muomv_msi,
wip_entities we,
pa_projects_all ppa,
hr_employees hr,
(select gdr.* from gl_daily_rates gdr where gdr.conversion_date=:conversion_date and gdr.conversion_type=:conversion_type) gdr, --Set of currency rates to translate the PO Price into the GL Currency
gl_code_combinations gcc1,
gl_code_combinations gcc2,
gl_code_combinations gcc3,
( --Item or resource cost
select
cic.organization_id,
cic.inventory_item_id,
cic.cost_type_id,
null resource_code,
-999 resource_id,
cic.material_cost,
cic.material_overhead_cost,
cic.resource_cost,
cic.outside_processing_cost,
cic.overhead_cost,
cic.item_cost,
cic.unburdened_cost
from
cst_item_costs cic
union all
select
br.organization_id,
br.purchase_item_id,
crc.cost_type_id,
br.resource_code,
br.resource_id,
0 material_cost,
0 material_overhead_cost,
0 resource_cost,
nvl(crc.resource_rate,0) outside_processing_cost,
0 overhead_cost,
nvl(crc.resource_rate,0) item_cost,
nvl(crc.resource_rate,0) unburdened_cost
from
bom_resources br,
cst_resource_costs crc
where
br.cost_element_id=4 and
br.resource_id=crc.resource_id
) cic,
( --Average PO receipt cost over a date range
select distinct
mmt.organization_id,
mmt.inventory_item_id,
sum(mmt.primary_quantity) over (partition by mmt.organization_id, mmt.inventory_item_id) receipt_qty,
sum(mmt.transaction_cost*mmt.primary_quantity) over (partition by mmt.organization_id, mmt.inventory_item_id) receipt_amount
from
mtl_material_transactions mmt
where
mmt.transaction_date>=:transaction_from and
mmt.transaction_date<:transaction_date_to+1 and
mmt.transaction_source_type_id=1 and --purchase orders
mmt.transaction_cost<>0
) mmt
where
2=2 and
pla.po_line_id=plla.po_line_id and
plla.line_location_id=pda.line_location_id and
pda.destination_type_code in ('SHOP FLOOR','INVENTORY') and
pla.closed_date is null and
plla.po_release_id=pra.po_release_id(+) and
plla.ship_to_organization_id=mp.organization_id and
plla.pha_vendor_id=aps.vendor_id and
pla.item_id=msiv.inventory_item_id and 
plla.ship_to_organization_id=msiv.organization_id and
msiv.inventory_item_status_code=misv.inventory_item_status_code and
pla.unit_meas_lookup_code=mucv.unit_of_measure and
pla.item_id=mucv.inventory_item_id and
plla.ship_to_organization_id=mucv.organization_id and
mucv.uom_code=muomv_po.uom_code and
msiv.primary_uom_code=muomv_msi.uom_code and
pda.wip_entity_id=we.wip_entity_id(+) and
pda.project_id=ppa.project_id(+) and
plla.pha_agent_id=hr.employee_id(+) and
plla.pha_currency_code=gdr.from_currency(+) and
plla.gl_currency_code=gdr.to_currency(+) and
&sla_join
pda.variance_account_id=gcc2.code_combination_id(+) and
pda.accrual_account_id=gcc3.code_combination_id(+) and
plla.ship_to_organization_id=cic.organization_id and
pla.item_id=cic.inventory_item_id and
mp.primary_cost_method=cic.cost_type_id and
nvl(pda.bom_resource_id,-999)=nvl(cic.resource_id,-999) and
decode(msiv.inventory_asset_flag,'Y',msiv.organization_id)=mmt.organization_id(+) and 
decode(msiv.inventory_asset_flag,'Y',msiv.inventory_item_id)=mmt.inventory_item_id(+)
/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC PO Price vs. Costing Method Comparison
-- Description: Report to compare the open purchase order lines and unit prices with the costing method item cost in Oracle (Average, Standard, FIFO or LIFO). Used by the buyers and cost accounting to check the accuracy of the recently created purchase orders and run using a range of purchase order line creation dates. Foreign currency purchase orders convert to the inventory organization's currency by either using the original purchase order exchange rate, if the Invoice Match Option is "Purchase Order" or by using the latest exchange rate date if the Invoice Match Option is "Receipt".
-- / +=============================================================================+
-- -- | Copyright 2006-2024 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this
-- -- | permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 02 APR 2006 Douglas Volz Initial Coding
-- -- | 1.17 13 Jun 2017 Douglas Volz Added OSP Resource Code
-- -- | 1.18 19 Aug 2019 Douglas Volz Removed non-generic item categories
-- -- | 1.19 27 Jan 2020 Douglas Volz Changed to multi-language views for the item
-- -- | master, inventory orgs and operating units.
-- -- | Added project number to report.
-- -- | 1.20 19 Dec 2020 Douglas Volz Add these columns: PO Need By Date, PO Promise Date,
-- -- | PO Expected Receipt Date, Target Price (PO List Price),
-- -- | Customer Name (description for category set 1).
-- -- | And added Minimum Cost Difference parameter.
-- -- | 1.21 22 Dec 2020 Douglas Volz Changed the item cost "union all" to just "union",
-- -- | which eliminated a full table scan on cstitemcosts.
-- -- | 1.22 02 Nov 2023 Douglas Volz Add Cost Type as a parameter, remove tabs and
-- -- | add org access controls.
-- -- | 1.23 18 Jul 2024 Douglas Volz Fix for Percent Difference calculation.
-- -- | 1.24 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- | 1.25 24 Oct 2026 Andy Haack Price per primary unit of measure divided by the conversion rate.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-po-price-vs-costing-method-comparison/
-- Library Link: https://www.enginatics.com/reports/cac-po-price-vs-costing-method-comparison/
-- Run Report: https://demo.enginatics.com/

select
x.ledger,
x.operating_unit,
x.org_code,
x.supplier,
x.buyer,
x.item_number,
x.item_description,
xxen_util.meaning(x.item_type,'ITEM_TYPE',3) item_type,
x.item_status,
xxen_util.meaning(x.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
&category_columns
x.osp_resource,
x.supplier_item,
x.target_or_list_price,
x.po_number,
x.po_line,
x.project_number,
x.project_name,
x.creation_date,
x.promised_date,
x.need_by_date,
x.po_release,
x.release_date,
x.expected_receipt_date,
x.po_uom,
x.po_quantity,
x.po_quantity_received,
x.po_currency_code,
x.po_unit_price,
x.currency_rate_date,
x.po_exchange_rate,
x.gl_currency_code,
x.po_exchange_rate*x.po_unit_price converted_po_unit_price,
x.po_uom_conversion_rate,
x.po_exchange_rate*x.po_unit_price/x.po_uom_conversion_rate converted_po_at_primary_uom,
x.uom_code,
x.cost_type,
x.unburdened_unit_cost,
round(x.po_exchange_rate*x.po_unit_price-x.unburdened_unit_cost,5) unit_cost_difference,
round((x.po_exchange_rate*x.po_unit_price-x.unburdened_unit_cost)*nvl(x.po_quantity,0),2) extended_cost_difference,
case
when round(x.po_exchange_rate*x.po_unit_price-x.unburdened_unit_cost,5)=0 then 0
when round(x.unburdened_unit_cost,5)=0 then 100*sign(x.po_unit_price)
when round(x.po_exchange_rate*x.po_unit_price,5)=0 then -100*sign(x.unburdened_unit_cost)
else round((x.po_exchange_rate*x.po_unit_price-x.unburdened_unit_cost)/x.unburdened_unit_cost*100,2)
end percent_difference,
x.cost_type,
x.material_cost,
x.material_overhead_cost,
x.resource_cost,
x.outside_processing_cost,
x.overhead_cost,
x.item_cost
from
(
select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
aps.vendor_name supplier,
(select he.full_name from hr_employees he where pha.agent_id=he.employee_id) buyer,
msiv.organization_id,
msiv.inventory_item_id,
msiv.concatenated_segments item_number,
msiv.description item_description,
msiv.item_type,
msiv.inventory_item_status_code item_status,
msiv.planning_make_buy_code,
cic.resource_code osp_resource,
pla.vendor_product_num supplier_item,
round(msiv.list_price_per_unit,5) target_or_list_price,
pha.segment1 po_number,
to_char(pla.line_num) po_line,
ppa.segment1 project_number,
ppa.name project_name,
plla.creation_date,
plla.promised_date,
plla.need_by_date,
to_char(pra.release_num) po_release,
pra.release_date,
(select max(ms.expected_delivery_date) from mtl_supply ms where pda.po_distribution_id=ms.po_distribution_id and ms.supply_type_code in ('PO','RECEIVING','SHIPMENT') and ms.item_id=msiv.inventory_item_id and ms.to_organization_id=msiv.organization_id and ms.destination_type_code in ('INVENTORY','SHOP FLOOR')) expected_receipt_date,
muomv.uom_code po_uom,
plla.quantity po_quantity,
plla.quantity_received po_quantity_received,
pha.currency_code po_currency_code,
nvl(plla.price_override,pla.unit_price) po_unit_price,
decode(plla.match_option,'P',trunc(nvl(pda.rate_date,plla.creation_date)),trunc(:p_curr_conv_date1)) currency_rate_date,
decode(plla.match_option,'P',nvl(pda.rate,1),decode(pha.currency_code,gl.currency_code,1,(select gdr.conversion_rate from gl_daily_rates gdr, gl_daily_conversion_types gdct where pha.currency_code=gdr.from_currency and gl.currency_code=gdr.to_currency and 4=4 and gdr.conversion_type=gdct.conversion_type and 5=5))) po_exchange_rate,
gl.currency_code gl_currency_code,
mucv.conversion_rate po_uom_conversion_rate,
msiv.primary_uom_code uom_code,
cic.cost_type,
cic.unburdened_cost unburdened_unit_cost,
cic.material_cost,
cic.material_overhead_cost,
cic.resource_cost,
cic.outside_processing_cost,
cic.overhead_cost,
cic.item_cost
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
po_line_locations_all plla,
po_lines_all pla,
po_headers_all pha,
po_distributions_all pda,
po_releases_all pra,
ap_suppliers aps,
pa_projects_all ppa,
mtl_system_items_vl msiv,
mtl_uom_conversions_view mucv,
mtl_units_of_measure_vl muomv,
(
select
crc.organization_id,
br.purchase_item_id inventory_item_id,
cct.cost_type,
br.resource_code,
0 material_cost,
0 material_overhead_cost,
0 resource_cost,
nvl(crc.resource_rate,0) outside_processing_cost,
0 overhead_cost,
nvl(crc.resource_rate,0) unburdened_cost,
nvl(crc.resource_rate,0) item_cost
from
cst_resource_costs crc,
cst_cost_types cct,
bom_resources br,
mtl_system_items_b msib
where
3=3 and
crc.cost_type_id=cct.cost_type_id and
crc.resource_id=br.resource_id and
br.organization_id=msib.organization_id and
br.purchase_item_id=msib.inventory_item_id and
msib.item_type='OP'
union all
select
cic.organization_id,
cic.inventory_item_id,
cct.cost_type,
null resource_code,
nvl(cic.material_cost,0),
nvl(cic.material_overhead_cost,0),
nvl(cic.resource_cost,0),
nvl(cic.outside_processing_cost,0),
nvl(cic.overhead_cost,0),
nvl(cic.unburdened_cost,0),
nvl(cic.item_cost,0)
from
cst_item_costs cic,
cst_cost_types cct,
mtl_system_items_b msib
where
3=3 and
cic.cost_type_id=cct.cost_type_id and
cic.organization_id=msib.organization_id and
cic.inventory_item_id=msib.inventory_item_id and
nvl(msib.item_type,'x')<>'OP'
) cic
where
1=1 and
2=2 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=plla.ship_to_organization_id and
plla.closed_code='OPEN' and
plla.po_line_id=pla.po_line_id and
pla.po_header_id=pha.po_header_id and
plla.line_location_id=pda.line_location_id and
pda.po_release_id=pra.po_release_id(+) and
pha.vendor_id=aps.vendor_id and
pda.project_id=ppa.project_id(+) and
plla.ship_to_organization_id=msiv.organization_id and
pla.item_id=msiv.inventory_item_id and
msiv.organization_id=mucv.organization_id and
msiv.inventory_item_id=mucv.inventory_item_id and
pla.unit_meas_lookup_code=mucv.unit_of_measure and
plla.unit_meas_lookup_code=muomv.unit_of_measure and
msiv.organization_id=cic.organization_id and
msiv.inventory_item_id=cic.inventory_item_id
) x
where
6=6
order by
x.ledger,
x.operating_unit,
x.org_code,
x.supplier,
x.item_number,
x.supplier_item,
x.po_number,
x.po_line,
x.po_release

/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Item List Price vs. Item Cost
-- Description: Compare item master list price against any cost type (Cost Type 1) and also list the Standard Price (Market Price), Last PO Price, Converted Last PO Price and a secondary cost type (Cost Type 2). All item costs and prices are in the primary UOM, using the To Currency Code.
-- -- | Program Name: xxxitemtargetcostreviewrept.sql
-- -- |
-- -- | Parameters:
-- -- | pcosttype1 -- The first comparison cost type you wish to report
-- -- | pcosttype2 -- The second comparison cost type you wish to report
-- -- | pitemnumber -- Enter the specific item number you wish to report
-- -- | porgcode -- specific organization code, works with
-- -- | null or valid organization codes
-- -- | poperatingunit -- Operating Unit you wish to report, leave blank for all
-- -- | operating units (optional)
-- -- | pledger -- general ledger you wish to report, leave blank for all
-- -- | ledgers (optional)
-- -- | pincludeuncosteditems -- Yes/No flag to include or not include non-costed items
-- -- | pcategoryset1 -- The first item category set to report, typically the
-- -- | Cost or Product Line Category Set
-- -- | pcategoryset2 -- The second item category set to report, typically the
-- -- | Inventory Category Set
-- -- |
-- -- | Description:
-- -- | Report to show item costs in any cost type
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 29 Sep 2020 Douglas Volz Initial Coding based on Item Cost Summary Report
-- -- | 1.1 22 Oct 2020 Douglas Volz Added the Master Target Price
-- -- | 1.2 26 Oct 2020 Douglas Volz Changed as List Price is always in a common, global
-- -- | currency, translate to this "tocurrency" currency
-- -- | 1.3 28 Oct 2020 Douglas Volz Fixes for the last PO, need to exclude Cancelled
-- -- | PO Lines.
-- -- | 1.4 30 Oct 2020 Douglas Volz Add To Currency Code as a visible parameter and
-- -- | show all item costs in that currency
-- -- | 1.5 04 Dec 2020 Douglas Volz Outer join fix for PO joins to item master and
-- -- | currency exchange rates.
-- -- | 1.6 06 Dec 2020 Douglas Volz Added Target Price Percent Difference column.
-- +=============================================================================+/
-- -- | 1.7 24 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards, price per primary unit of measure divided by the conversion rate.
-- Excel Example Output: https://www.enginatics.com/example/cac-item-list-price-vs-item-cost/
-- Library Link: https://www.enginatics.com/reports/cac-item-list-price-vs-item-cost/
-- Run Report: https://demo.enginatics.com/

select
x.ledger,
x.operating_unit,
x.org_code,
x.item_number,
x.item_description,
x.uom_code,
xxen_util.meaning(x.item_type,'ITEM_TYPE',3) item_type,
x.item_status,
xxen_util.meaning(x.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
&category_columns
xxen_util.yes(x.costing_enabled_flag) allow_costs,
xxen_util.yes(x.inventory_asset_flag) inventory_asset,
x.based_on_rollup,
x.shrinkage_rate,
x.from_currency_code,
:p_currency_code to_currency_code,
x.conversion_rate,
round(x.market_price*x.conversion_rate,5) market_price,
round(x.master_list_price*x.conversion_rate,5) master_target_or_list_price,
round(x.list_price*x.conversion_rate,5) bu_target_or_list_price,
round(x.unburdened_cost1*x.conversion_rate,5) "&Cost_Type1 Unburdened Cost",
round((nvl(x.list_price,0)-nvl(x.unburdened_cost1,0))*x.conversion_rate,5) target_price_difference,
case
when round(nvl(x.list_price,0)-nvl(x.unburdened_cost1,0),5)=0 then 0
when round(nvl(x.unburdened_cost1,0),5)=0 then 100
else round((nvl(x.list_price,0)-nvl(x.unburdened_cost1,0))/x.unburdened_cost1*100,1)
end percent_difference,
x.last_purchase_order,
x.last_po_line,
x.last_po_date,
x.last_po_currency_code,
x.last_po_price,
x.last_po_price*x.po_conversion_rate converted_last_po_price,
x.cost_type_1,
round(x.material_cost1*x.conversion_rate,5) material_cost1,
round(x.material_overhead_cost1*x.conversion_rate,5) material_overhead_cost1,
round(x.resource_cost1*x.conversion_rate,5) resource_cost1,
round(x.outside_processing_cost1*x.conversion_rate,5) outside_processing_cost1,
round(x.overhead_cost1*x.conversion_rate,5) overhead_cost1,
round(x.item_cost1*x.conversion_rate,5) item_cost1,
x.cost_creation_date1,
x.last_cost_update_date1,
x.cost_type_2,
round(x.unburdened_cost2*x.conversion_rate,5) unburdened_cost2,
round(x.material_cost2*x.conversion_rate,5) material_cost2,
round(x.material_overhead_cost2*x.conversion_rate,5) material_overhead_cost2,
round(x.resource_cost2*x.conversion_rate,5) resource_cost2,
round(x.outside_processing_cost2*x.conversion_rate,5) outside_processing_cost2,
round(x.overhead_cost2*x.conversion_rate,5) overhead_cost2,
round(x.item_cost2*x.conversion_rate,5) item_cost2,
x.cost_creation_date2,
x.last_cost_update_date2
from
(
select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
msiv.organization_id,
msiv.inventory_item_id,
msiv.concatenated_segments item_number,
msiv.description item_description,
msiv.primary_uom_code uom_code,
msiv.item_type,
msiv.inventory_item_status_code item_status,
msiv.planning_make_buy_code,
msiv.costing_enabled_flag,
decode(cic1.inventory_item_id,null,msiv.inventory_asset_flag,decode(cic1.inventory_asset_flag,1,'Y')) inventory_asset_flag,
decode(cic1.inventory_item_id,null,'N/A',xxen_util.meaning(cic1.based_on_rollup_flag,'CST_BONROLLUP_VAL',700)) based_on_rollup,
cic1.shrinkage_rate,
gl.currency_code from_currency_code,
decode(gl.currency_code,:p_currency_code,1,(select gdr.conversion_rate from gl_daily_rates gdr, gl_daily_conversion_types gdct where gl.currency_code=gdr.from_currency and gdr.to_currency=:p_currency_code and gdr.conversion_date=:conversion_date and gdr.conversion_type=gdct.conversion_type and gdct.user_conversion_type=:user_conversion_type)) conversion_rate,
msiv.market_price,
msib_mas.list_price_per_unit master_list_price,
msiv.list_price_per_unit list_price,
po.last_purchase_order,
po.last_po_line,
po.last_po_date,
po.last_po_currency_code,
po.last_po_price,
decode(po.last_po_currency_code,:p_currency_code,1,(select gdr.conversion_rate from gl_daily_rates gdr, gl_daily_conversion_types gdct where po.last_po_currency_code=gdr.from_currency and gdr.to_currency=:p_currency_code and gdr.conversion_date=:conversion_date and gdr.conversion_type=gdct.conversion_type and gdct.user_conversion_type=:user_conversion_type)) po_conversion_rate,
cic1.cost_type cost_type_1,
cic1.unburdened_cost unburdened_cost1,
cic1.material_cost material_cost1,
cic1.material_overhead_cost material_overhead_cost1,
cic1.resource_cost resource_cost1,
cic1.outside_processing_cost outside_processing_cost1,
cic1.overhead_cost overhead_cost1,
cic1.item_cost item_cost1,
cic1.creation_date cost_creation_date1,
cic1.last_update_date last_cost_update_date1,
cic2.cost_type cost_type_2,
cic2.unburdened_cost unburdened_cost2,
cic2.material_cost material_cost2,
cic2.material_overhead_cost material_overhead_cost2,
cic2.resource_cost resource_cost2,
cic2.outside_processing_cost outside_processing_cost2,
cic2.overhead_cost overhead_cost2,
cic2.item_cost item_cost2,
cic2.creation_date cost_creation_date2,
cic2.last_update_date last_cost_update_date2
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
mtl_system_items_vl msiv,
mtl_system_items_b msib_mas,
(
select
cic.organization_id,
cic.inventory_item_id,
cct1.cost_type,
cic.inventory_asset_flag,
cic.based_on_rollup_flag,
cic.shrinkage_rate,
nvl(cic.unburdened_cost,0) unburdened_cost,
nvl(cic.material_cost,0) material_cost,
nvl(cic.material_overhead_cost,0) material_overhead_cost,
nvl(cic.resource_cost,0) resource_cost,
nvl(cic.outside_processing_cost,0) outside_processing_cost,
nvl(cic.overhead_cost,0) overhead_cost,
nvl(cic.item_cost,0) item_cost,
cic.creation_date,
cic.last_update_date
from
cst_item_costs cic,
cst_cost_types cct1
where
4=4 and
cic.cost_type_id=cct1.cost_type_id
) cic1,
(
select
cic.organization_id,
cic.inventory_item_id,
cct2.cost_type,
nvl(cic.unburdened_cost,0) unburdened_cost,
nvl(cic.material_cost,0) material_cost,
nvl(cic.material_overhead_cost,0) material_overhead_cost,
nvl(cic.resource_cost,0) resource_cost,
nvl(cic.outside_processing_cost,0) outside_processing_cost,
nvl(cic.overhead_cost,0) overhead_cost,
nvl(cic.item_cost,0) item_cost,
cic.creation_date,
cic.last_update_date
from
cst_item_costs cic,
cst_cost_types cct2
where
5=5 and
cic.cost_type_id=cct2.cost_type_id
) cic2,
(
select
y.organization_id,
y.inventory_item_id,
y.last_purchase_order,
y.last_po_line,
y.last_po_date,
y.last_po_currency_code,
round(y.unit_price/mucv.conversion_rate,6) last_po_price
from
(
select
plla.ship_to_organization_id organization_id,
pla.item_id inventory_item_id,
pha.segment1 last_purchase_order,
pla.line_num last_po_line,
coalesce(plla.promised_date,plla.need_by_date,plla.last_update_date) last_po_date,
pha.currency_code last_po_currency_code,
nvl(plla.price_override,pla.unit_price) unit_price,
pla.unit_meas_lookup_code,
row_number() over (partition by plla.ship_to_organization_id,pla.item_id order by coalesce(plla.promised_date,plla.need_by_date,plla.last_update_date) desc,pda.po_distribution_id desc) rn
from
po_headers_all pha,
po_lines_all pla,
po_line_locations_all plla,
po_distributions_all pda
where
11=11 and
pha.authorization_status='APPROVED' and
pha.po_header_id=pla.po_header_id and
pla.item_id is not null and
pla.closed_code not in ('CANCELLED','INCOMPLETE','ON HOLD','REJECTED','RETURNED') and
pla.po_line_id=plla.po_line_id and
plla.ship_to_organization_id is not null and
plla.line_location_id=pda.line_location_id and
pda.destination_type_code='INVENTORY'
) y,
mtl_uom_conversions_view mucv
where
y.rn=1 and
y.organization_id=mucv.organization_id(+) and
y.inventory_item_id=mucv.inventory_item_id(+) and
y.unit_meas_lookup_code=mucv.unit_of_measure(+)
) po
where
1=1 and
6=6 and
7=7 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=msiv.organization_id and
mp.master_organization_id=msib_mas.organization_id and
msiv.inventory_item_id=msib_mas.inventory_item_id and
msiv.organization_id=cic1.organization_id(+) and
msiv.inventory_item_id=cic1.inventory_item_id(+) and
(cic1.inventory_item_id is not null or msiv.costing_enabled_flag='N' and 10=10) and
msiv.organization_id=cic2.organization_id(+) and
msiv.inventory_item_id=cic2.inventory_item_id(+) and
msiv.organization_id=po.organization_id(+) and
msiv.inventory_item_id=po.inventory_item_id(+)
) x
order by
x.ledger,
x.operating_unit,
x.org_code,
x.item_number,
x.item_description

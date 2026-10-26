/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Calculate Average Item Costs
-- Description: Using purchase order receipts, calculate average item costs over a specified transaction date range and compare against the Comparison Cost Type. In addition, with the Use Default Material Overheads parameter you can choose which material overheads to use on this report. Select Yes to use the Default Material Overhead setups. Set to No to use the material overheads from the specified Comparison Cost Type. And if planning to use roll up these item costs, to avoid doubling up rolled up material costs on assemblies, choose Yes for the parameter Exclude Rolled Up Items, to avoid having manually defined material costs and rolled up material costs.
-- -- | Copyright 2006 - 2023 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 05 Jan 2019 Douglas Volz Initial Coding based on itemcosthistory.sql
-- -- | 1.15 10 Jan 2023 Douglas Volz Fix for Average Cost calculations, UOM issue.
-- -- | 1.16 21 Aug 2023 Douglas Volz Remove tabs and restrict to only orgs you have access to,
-- -- | Add last payables invoice and purchase order price information.
-- -- | 1.17 25 Sep 2023 Douglas Volz Fix for the Last PO and Last A/P information
-- -- | 1.18 13 Oct 2023 Andy Haack Fix for G/L Daily Rates, outer joins
-- -- | 1.19 24 Nov 2023 Douglas Volz Fixed item number parameter for last PO information
-- -- | and fix Last A/P Invoice info for G/L Daily Rates
-- -- | 1.20 08 Dec 2023 Douglas Volz Added G/L and Operating Unit security restrictions.
-- -- | 1.21 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-calculate-average-item-costs/
-- Library Link: https://www.enginatics.com/reports/cac-calculate-average-item-costs/
-- Run Report: https://demo.enginatics.com/

with r as (
select /*+ materialize*/
mmt.organization_id,
mmt.inventory_item_id,
sum(mmt.primary_quantity) sum_primary_quantity,
round(sum(mmt.transaction_cost*mmt.primary_quantity),2) sum_po_receipts,
round(sum(mmt.transaction_cost*mmt.primary_quantity)/sum(mmt.primary_quantity),5) average_material_cost
from
mtl_parameters mp,
mtl_material_transactions mmt,
rcv_transactions rt,
ap_suppliers aps,
mtl_system_items_vl msiv
where
2=2 and
3=3 and
5=5 and
9=9 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=mmt.organization_id and
(mmt.transaction_source_type_id,mmt.transaction_action_id,mmt.transaction_type_id) in ((1,27,18),(1,29,71),(1,1,36),(1,6,74),(13,6,75)) and
mmt.transaction_cost<>0 and
mmt.rcv_transaction_id=rt.transaction_id and
rt.vendor_id=aps.vendor_id(+) and
mmt.organization_id=msiv.organization_id and
mmt.inventory_item_id=msiv.inventory_item_id and
msiv.inventory_asset_flag='Y'
group by
mmt.organization_id,
mmt.inventory_item_id
having
sum(mmt.primary_quantity)>0
)
select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
msiv.concatenated_segments item_number,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
xxen_util.meaning(y.based_on_rollup_flag,'CST_BONROLLUP_VAL',700) based_on_rollup,
(select misv.inventory_item_status_code_tl from mtl_item_status_vl misv where msiv.inventory_item_status_code=misv.inventory_item_status_code) item_status,
y.lot_size,
&category_columns
msiv.primary_uom_code uom_code,
y.sum_primary_quantity,
gl.currency_code,
y.sum_po_receipts,
y.average_material_cost,
y.comparison_cost_type,
round(y.unburdened_cost,5) comparison_material_cost,
y.average_material_cost-round(y.unburdened_cost,5) material_cost_difference,
round(
case
when y.average_material_cost=y.unburdened_cost then 0
when y.unburdened_cost=0 then 100
when y.average_material_cost=0 then -100
else (y.average_material_cost-y.unburdened_cost)/y.unburdened_cost*100
end,3) percent_difference,
y.material_overhead_cost,
y.average_material_cost+y.material_overhead_cost total_average_item_cost,
y.item_cost total_comparison_item_cost,
y.average_material_cost+y.material_overhead_cost-y.item_cost total_cost_difference,
po.last_purchase_order,
po.last_po_line,
po.last_po_date,
po.last_po_currency_code,
po.last_po_price,
round(po.last_po_price*decode(po.last_po_currency_code,gl.currency_code,1,(select gdr.conversion_rate from gl_daily_rates gdr, gl_daily_conversion_types gdct where po.last_po_currency_code=gdr.from_currency and gl.currency_code=gdr.to_currency and gdr.conversion_date=:p_curr_conv_date and gdr.conversion_type=gdct.conversion_type and gdct.user_conversion_type=:p_curr_conv_type)),6) converted_last_po_price,
&last_ap_invoice_columns
msiv.list_price_per_unit item_master_list_price
from
(
select
r.*,
cic.comparison_cost_type,
cic.lot_size,
cic.unburdened_cost,
cic.item_cost,
cic.based_on_rollup_flag,
nvl(round(moh.item_rate,5)+round(moh.lot_rate/nvl(nullif(cic.lot_size,0),1),5)+round(r.average_material_cost*moh.total_value_rate,5)+round(moh.activity_rate,5),0) material_overhead_cost
from
r,
(
select
cic.organization_id,
cic.inventory_item_id,
max(cct.cost_type) keep (dense_rank first order by decode(cct.cost_type,:p_cost_type,1,2)) comparison_cost_type,
max(cic.lot_size) keep (dense_rank first order by decode(cct.cost_type,:p_cost_type,1,2)) lot_size,
nvl(max(cic.unburdened_cost) keep (dense_rank first order by decode(cct.cost_type,:p_cost_type,1,2)),0) unburdened_cost,
nvl(max(cic.item_cost) keep (dense_rank first order by decode(cct.cost_type,:p_cost_type,1,2)),0) item_cost,
nvl(max(cic.based_on_rollup_flag) keep (dense_rank first order by decode(cct.cost_type,:p_cost_type,1,2)),2) based_on_rollup_flag
from
cst_item_costs cic,
cst_cost_types cct,
mtl_parameters mp
where
(cic.organization_id,cic.inventory_item_id) in (select r.organization_id,r.inventory_item_id from r) and
cic.cost_type_id=cct.cost_type_id and
cic.organization_id=mp.organization_id and
(cct.cost_type=:p_cost_type or cic.cost_type_id=mp.primary_cost_method)
group by
cic.organization_id,
cic.inventory_item_id
) cic,
(
select
r.organization_id,
r.inventory_item_id,
sum(decode(ciod.basis_type,1,ciod.usage_rate_or_amount,0)) item_rate,
sum(decode(ciod.basis_type,2,ciod.usage_rate_or_amount,0)) lot_rate,
sum(decode(ciod.basis_type,5,ciod.usage_rate_or_amount,0)) total_value_rate,
sum(decode(ciod.basis_type,6,ciod.usage_rate_or_amount*nvl(ciod.activity_units,0)/nvl(nullif(ciod.item_units,0),1),0)) activity_rate
from
r,
mtl_system_items_b msib,
cst_item_overhead_defaults ciod,
bom_resources br
where
:p_use_default_matl_ovhds='Y' and
r.organization_id=msib.organization_id and
r.inventory_item_id=msib.inventory_item_id and
r.organization_id=ciod.organization_id and
ciod.item_type in (3,msib.planning_make_buy_code) and
(ciod.category_set_id is null or (ciod.category_set_id,ciod.category_id) in (select mic.category_set_id,mic.category_id from mtl_item_categories mic where r.organization_id=mic.organization_id and r.inventory_item_id=mic.inventory_item_id)) and
ciod.material_overhead_id=br.resource_id and
br.cost_element_id=2 and
(:p_only_active='N' or br.disable_date is null or br.disable_date>=trunc(sysdate))
group by
r.organization_id,
r.inventory_item_id
union all
select
cicd.organization_id,
cicd.inventory_item_id,
sum(decode(cicd.basis_type,1,cicd.usage_rate_or_amount,0)) item_rate,
sum(decode(cicd.basis_type,2,cicd.usage_rate_or_amount,0)) lot_rate,
sum(decode(cicd.basis_type,5,cicd.usage_rate_or_amount,0)) total_value_rate,
sum(decode(cicd.basis_type,6,cicd.usage_rate_or_amount*nvl(cicd.activity_units,0)/nvl(nullif(cicd.item_units,0),1),0)) activity_rate
from
cst_cost_types cct,
cst_item_cost_details cicd,
mtl_parameters mp
where
:p_use_default_matl_ovhds='N' and
cct.cost_type=:p_cost_type and
(cicd.organization_id,cicd.inventory_item_id) in (select r.organization_id,r.inventory_item_id from r) and
cicd.organization_id=mp.organization_id and
cicd.cost_type_id=decode(cct.cost_type_id,mp.primary_cost_method,decode(mp.primary_cost_method,1,cct.cost_type_id,mp.avg_rates_cost_type_id),cct.cost_type_id) and
cicd.level_type=1 and
cicd.cost_element_id=2
group by
cicd.organization_id,
cicd.inventory_item_id
) moh
where
6=6 and
r.organization_id=cic.organization_id and
r.inventory_item_id=cic.inventory_item_id and
r.organization_id=moh.organization_id(+) and
r.inventory_item_id=moh.inventory_item_id(+)
) y,
mtl_system_items_vl msiv,
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
(
select
z.*,
round(z.po_unit_price/mucv.conversion_rate,6) last_po_price
from
(
select
plla.ship_to_organization_id organization_id,
pla.item_id inventory_item_id,
max(pha.segment1) keep (dense_rank last order by coalesce(plla.promised_date,plla.need_by_date,plla.last_update_date),pda.po_distribution_id) last_purchase_order,
max(pla.line_num) keep (dense_rank last order by coalesce(plla.promised_date,plla.need_by_date,plla.last_update_date),pda.po_distribution_id) last_po_line,
max(coalesce(plla.promised_date,plla.need_by_date,plla.last_update_date)) last_po_date,
max(pha.currency_code) keep (dense_rank last order by coalesce(plla.promised_date,plla.need_by_date,plla.last_update_date),pda.po_distribution_id) last_po_currency_code,
max(nvl(plla.price_override,pla.unit_price)) keep (dense_rank last order by coalesce(plla.promised_date,plla.need_by_date,plla.last_update_date),pda.po_distribution_id) po_unit_price,
max(pla.unit_meas_lookup_code) keep (dense_rank last order by coalesce(plla.promised_date,plla.need_by_date,plla.last_update_date),pda.po_distribution_id) unit_meas_lookup_code
from
po_headers_all pha,
po_lines_all pla,
po_line_locations_all plla,
po_distributions_all pda
where
(plla.ship_to_organization_id,pla.item_id) in (select r.organization_id,r.inventory_item_id from r) and
pha.authorization_status='APPROVED' and
nvl(pla.closed_code,'OPEN') not in ('CANCELLED','INCOMPLETE','ON HOLD','REJECTED','RETURNED') and
pha.po_header_id=pla.po_header_id and
pla.po_line_id=plla.po_line_id and
plla.line_location_id=pda.line_location_id and
pda.destination_type_code='INVENTORY'
group by
plla.ship_to_organization_id,
pla.item_id
) z,
mtl_uom_conversions_view mucv
where
z.unit_meas_lookup_code=mucv.unit_of_measure(+) and
z.inventory_item_id=mucv.inventory_item_id(+) and
z.organization_id=mucv.organization_id(+)
) po
&p_last_ap_invoice_sql
where
1=1 and
10=10 and
y.organization_id=msiv.organization_id and
y.inventory_item_id=msiv.inventory_item_id and
y.organization_id=mp.organization_id and
y.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haouv.organization_id and
sysdate<nvl(haouv.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
y.organization_id=po.organization_id(+) and
y.inventory_item_id=po.inventory_item_id(+)
order by
ledger,
operating_unit,
org_code,
item_number

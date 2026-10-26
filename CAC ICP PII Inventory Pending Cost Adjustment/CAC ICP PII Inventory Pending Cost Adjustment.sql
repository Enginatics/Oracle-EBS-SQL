/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC ICP PII Inventory Pending Cost Adjustment
-- Description: Report showing potential standard cost changes for onhand and intransit inventory value which you own, for gross, profit in inventory and net inventory values. If you enter a period name this report uses quantities from the month-end snapshot; if you leave the period name blank it uses the real-time quantities. The Cost Type (Old) defaults to your Costing Method Cost Type (Average, Standard, etc.), the Currency Conversion Dates default to the current accounting period, and the To Currency Code and the Organization Code default from the organization code set for this session. And to use the quantities from the month-end snapshot, you can only choose closed accounting periods as the month-end snapshot is created when you close the inventory accounting period.
-- Note: If using this report for reporting after the standard cost update this report requires both the before and after cost types available after the standard cost update is run.
-- Please save your frozen costs to another Cost Type before running the standard cost update, using the item cost copy.
-- Hidden Parameters:
-- Sign PII: hidden parameter to set the sign of the profit in inventory amounts. This parameter determines if PII is normally entered as a positive or negative amount.
-- Default value for this report assumes PII costs are entered as positive amounts.
-- -- | Copyright 2008-2024 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- | Version Modified on Modified by Desc
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 21 Nov 2010 Douglas Volz Created initial Report for prior client based on BBCIINVVALUESTDADJFXREPT1.7.sql
-- -- | 1.14 07 Feb 2024 Douglas Volz Add item master and costing lot sizes, use default controls,
-- -- | based on rollup and shrinkage rate columns. Added in GL and OU security restrictions.
-- -- | 1.15 25 Jun 2024 Douglas Volz Reinstalled missing parameter, To Currency Code. Commented out GL and OU security restrictions.
-- -- | 1.17 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================
-- Excel Example Output: https://www.enginatics.com/example/cac-icp-pii-inventory-pending-cost-adjustment/
-- Library Link: https://www.enginatics.com/reports/cac-icp-pii-inventory-pending-cost-adjustment/
-- Run Report: https://demo.enginatics.com/

select
w.ledger,
w.operating_unit,
w.org_code,
w.organization_name,
:p_period_name period_name,
&segment_columns
w.item_number,
w.item_description,
xxen_util.meaning(w.item_type,'ITEM_TYPE',3) item_type,
w.item_status,
xxen_util.meaning(w.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
w.std_lot_size,
&category_columns
xxen_util.yes(decode(w.defaulted_flag,1,'Y')) use_default_controls,
xxen_util.meaning(w.based_on_rollup_flag,'CST_BONROLLUP_VAL',700) based_on_rollup,
w.lot_size costing_lot_size,
w.shrinkage_rate,
w.currency_code,
round(w.material1,5) new_material_cost,
round(w.material2,5) old_material_cost,
round(w.material_overhead1,5) new_material_overhead_cost,
round(w.material_overhead2,5) old_material_overhead_cost,
round(w.resource1,5) new_resource_cost,
round(w.resource2,5) old_resource_cost,
round(w.outside_processing1,5) new_outside_processing_cost,
round(w.outside_processing2,5) old_outside_processing_cost,
round(w.overhead1,5) new_overhead_cost,
round(w.overhead2,5) old_overhead_cost,
round(w.item_cost1,5) new_item_cost,
round(w.item_cost2,5) old_item_cost,
round(w.pii1,5) new_pii_cost,
round(w.pii2,5) old_pii_cost,
round(w.item_cost1,5)-w.pii_sign*round(w.pii1,5) new_net_item_cost,
round(w.item_cost2,5)-w.pii_sign*round(w.pii2,5) old_net_item_cost,
round(w.item_cost1,5)-round(w.item_cost2,5) gross_item_cost_difference,
case
when round(w.item_cost1-w.item_cost2,5)=0 then 0
when round(w.item_cost1-w.item_cost2,5)=round(w.item_cost1,5) then 100
else round((w.item_cost1-w.item_cost2)/w.item_cost2*100,1)
end gross_percent_difference,
round(w.pii1,5)-round(w.pii2,5) pii_item_cost_difference,
case
when round(w.pii1-w.pii2,5)=0 then 0
when round(w.pii1-w.pii2,5)=round(w.pii1,5) then 100
else round((w.pii1-w.pii2)/w.pii2*100,1)
end pii_percent_difference,
round(w.item_cost1,5)-w.pii_sign*round(w.pii1,5)-(round(w.item_cost2,5)-w.pii_sign*round(w.pii2,5)) net_item_cost_difference,
w.subinventory_or_intransit,
w.subinventory_description,
w.uom_code,
w.quantity onhand_quantity,
round(w.item_cost1*w.quantity,2) new_gross_onhand_value,
round(w.pii1*w.pii_sign*w.quantity,2) new_pii_value,
round((w.item_cost1-w.pii_sign*w.pii1)*w.quantity,2) new_net_onhand_value,
round(w.item_cost2*w.quantity,2) old_gross_onhand_value,
round(w.pii2*w.pii_sign*w.quantity,2) old_pii_value,
round((w.item_cost2-w.pii_sign*w.pii2)*w.quantity,2) old_net_onhand_value,
round((w.item_cost1-w.item_cost2)*w.quantity,2) gross_onhand_value_diff,
round((w.pii1-w.pii2)*w.quantity,2) pii_value_difference,
round((w.item_cost1-w.item_cost2-w.pii_sign*(w.pii1-w.pii2))*w.quantity,2) net_onhand_value_difference,
w.rate1 new_fx_rate,
w.rate2 old_fx_rate,
w.rate1-w.rate2 exchange_rate_difference,
round(w.material1*w.rate1*w.quantity,2) "&p_to_currency_code New Material Value",
round(w.material2*w.rate2*w.quantity,2) "&p_to_currency_code Old Material Value",
round(w.material_overhead1*w.rate1*w.quantity,2) "&p_to_currency_code New Material Ovhd Value",
round(w.material_overhead2*w.rate2*w.quantity,2) "&p_to_currency_code Old Material Ovhd Value",
round(w.resource1*w.rate1*w.quantity,2) "&p_to_currency_code New Resource Value",
round(w.resource2*w.rate2*w.quantity,2) "&p_to_currency_code Old Resource Value",
round(w.outside_processing1*w.rate1*w.quantity,2) "&p_to_currency_code New OSP Value",
round(w.outside_processing2*w.rate2*w.quantity,2) "&p_to_currency_code Old OSP Value",
round(w.overhead1*w.rate1*w.quantity,2) "&p_to_currency_code New Overhead Value",
round(w.overhead2*w.rate2*w.quantity,2) "&p_to_currency_code Old Overhead Value",
round(w.item_cost1*w.rate1*w.quantity,2) "&p_to_currency_code New Gross Onhand Value",
round(w.item_cost2*w.rate2*w.quantity,2) "&p_to_currency_code Old Gross Onhand Value",
round((w.item_cost1*w.rate1-w.item_cost2*w.rate2)*w.quantity,2) "&p_to_currency_code Gross Onhand Value Diff",
round(w.pii1*w.rate1*w.quantity,2) "&p_to_currency_code New PII Value",
round(w.pii2*w.rate2*w.quantity,2) "&p_to_currency_code Old PII Value",
round((w.pii1*w.rate1-w.pii2*w.rate2)*w.quantity,2) "&p_to_currency_code PII Value Difference",
round((w.item_cost1-w.pii_sign*w.pii1)*w.rate1*w.quantity,2) "&p_to_currency_code New Net Value",
round((w.item_cost2-w.pii_sign*w.pii2)*w.rate2*w.quantity,2) "&p_to_currency_code Old Net Value",
round(((w.item_cost1-w.pii_sign*w.pii1)*w.rate1-(w.item_cost2-w.pii_sign*w.pii2)*w.rate2)*w.quantity,2) "&p_to_currency_code Net Value Difference",
round((w.item_cost1-w.item_cost2)*w.rate1*w.quantity,2) "&p_to_currency_code Gross Value Diff-New Rate",
round((w.pii1-w.pii2)*w.rate1*w.quantity,2) "&p_to_currency_code PII Value Diff-New Rate",
round((w.item_cost1-w.item_cost2)*w.rate1*w.quantity,2)-round(w.pii_sign*(w.pii1-w.pii2)*w.rate1*w.quantity,2) "&p_to_currency_code Net Value Diff-New Rate",
round((w.item_cost1-w.item_cost2)*w.rate2*w.quantity,2) "&p_to_currency_code Gross Value Diff-Old Rate",
round((w.pii1-w.pii2)*w.rate2*w.quantity,2) "&p_to_currency_code PII Value Diff-Old Rate",
round((w.item_cost1-w.item_cost2)*w.rate2*w.quantity,2)-round(w.pii_sign*(w.pii1-w.pii2)*w.rate2*w.quantity,2) "&p_to_currency_code Net Value Diff-Old Rate",
round((w.item_cost1-w.item_cost2)*w.rate1*w.quantity,2)-round((w.item_cost1-w.item_cost2)*w.rate2*w.quantity,2) "&p_to_currency_code Gross Value FX Diff",
round((w.pii1-w.pii2)*w.rate1*w.quantity,2)-round((w.pii1-w.pii2)*w.rate2*w.quantity,2) "&p_to_currency_code PII Value FX Diff",
round((w.item_cost1-w.item_cost2)*w.rate1*w.quantity,2)-round(w.pii_sign*(w.pii1-w.pii2)*w.rate1*w.quantity,2)-(round((w.item_cost1-w.item_cost2)*w.rate2*w.quantity,2)-round(w.pii_sign*(w.pii1-w.pii2)*w.rate2*w.quantity,2)) "&p_to_currency_code Net Value FX Diff"
from
(
select
z.*,
msiv.concatenated_segments item_number,
msiv.description item_description,
msiv.item_type,
misv.inventory_item_status_code_tl item_status,
msiv.planning_make_buy_code,
msiv.std_lot_size,
msiv.primary_uom_code uom_code,
cic1.defaulted_flag,
cic1.based_on_rollup_flag,
cic1.lot_size,
cic1.shrinkage_rate,
nvl(cic1.material_cost,0) material1,
nvl(cic1.material_overhead_cost,0) material_overhead1,
nvl(cic1.resource_cost,0) resource1,
nvl(cic1.outside_processing_cost,0) outside_processing1,
nvl(cic1.overhead_cost,0) overhead1,
nvl(cic1.item_cost,0) item_cost1,
nvl(cic2.material_cost,0) material2,
nvl(cic2.material_overhead_cost,0) material_overhead2,
nvl(cic2.resource_cost,0) resource2,
nvl(cic2.outside_processing_cost,0) outside_processing2,
nvl(cic2.overhead_cost,0) overhead2,
nvl(cic2.item_cost,0) item_cost2,
decode(msiv.inventory_asset_flag,'Y',nvl((select sum(cicd.item_cost) from cst_cost_types cct, cst_item_cost_details cicd, bom_resources br where 16=16 and 18=18 and cct.cost_type_id=cicd.cost_type_id and z.organization_id=cicd.organization_id and z.inventory_item_id=cicd.inventory_item_id and cicd.resource_id=br.resource_id),0),0) pii1,
decode(msiv.inventory_asset_flag,'Y',nvl((select sum(cicd.item_cost) from cst_cost_types cct, cst_item_cost_details cicd, bom_resources br where 17=17 and 18=18 and cct.cost_type_id=cicd.cost_type_id and z.organization_id=cicd.organization_id and z.inventory_item_id=cicd.inventory_item_id and cicd.resource_id=br.resource_id),0),0) pii2,
decode(sign(:p_sign_pii),-1,-1,1) pii_sign
from
(
select
y.*,
decode(y.intransit,'Y',xxen_util.meaning(3,'MSC_CALENDAR_TYPE',700),y.subinventory_code) subinventory_or_intransit,
decode(y.intransit,'Y',xxen_util.meaning(3,'MSC_CALENDAR_TYPE',700),msub.description) subinventory_description,
nvl(y.quantity_,0) quantity,
case
when y.intransit='Y' then nvl(y.intransit_account,(select min(mip.intransit_inv_account) from mtl_interorg_parameters mip where mip.fob_point=1 and mip.to_organization_id=y.organization_id or mip.fob_point=2 and mip.from_organization_id=y.organization_id))
when y.category_set_id is not null then
(
select
max(mca.material_account) keep (dense_rank first order by mca.subinventory_code nulls last)
from
mtl_item_categories mic,
mtl_category_accounts mca
where
y.organization_id=mic.organization_id and
y.inventory_item_id=mic.inventory_item_id and
y.category_set_id=mic.category_set_id and
mic.organization_id=mca.organization_id and
mic.category_id=mca.category_id and
(mca.subinventory_code=y.subinventory_code or mca.subinventory_code is null)
)
when y.cost_group_accounting=1 then (select ccga.material_account from cst_cost_group_accounts ccga where nvl(msub.default_cost_group_id,y.default_cost_group_id)=ccga.cost_group_id and y.organization_id=ccga.organization_id)
when y.primary_cost_method=1 then msub.material_account
else y.org_material_account
end material_account,
decode(y.currency_code,:p_to_currency,1,gdr1.conversion_rate) rate1,
decode(y.currency_code,:p_to_currency,1,gdr2.conversion_rate) rate2
from
(
select
x.ledger,
x.operating_unit,
x.org_code,
x.organization_name,
x.currency_code,
x.organization_id,
x.primary_cost_method,
x.cost_group_accounting,
x.default_cost_group_id,
x.org_material_account,
x.category_set_id,
x.inventory_item_id,
x.cost_type_id1,
x.cost_type_id2,
q.subinventory_code,
q.intransit,
q.intransit_account,
sum(q.quantity) quantity_
from
(
select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
haou.name organization_name,
gl.currency_code,
mp.organization_id,
mp.primary_cost_method,
mp.cost_group_accounting,
mp.default_cost_group_id,
mp.material_account org_material_account,
(select max(mca.category_set_id) from mtl_category_accounts mca where mp.organization_id=mca.organization_id) category_set_id,
msiv.inventory_item_id,
nvl((select cic.cost_type_id from cst_cost_types cct, cst_item_costs cic where cct.cost_type=:p_cost_type1 and cct.cost_type_id=cic.cost_type_id and msiv.organization_id=cic.organization_id and msiv.inventory_item_id=cic.inventory_item_id),mp.primary_cost_method) cost_type_id1,
nvl((select cic.cost_type_id from cst_cost_types cct, cst_item_costs cic where cct.cost_type=:p_cost_type2 and cct.cost_type_id=cic.cost_type_id and msiv.organization_id=cic.organization_id and msiv.inventory_item_id=cic.inventory_item_id),mp.primary_cost_method) cost_type_id2
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
mtl_system_items_vl msiv
where
1=1 and
9=9 and
15=15 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=msiv.organization_id
) x,
(
select
cpcs.organization_id,
cpcs.inventory_item_id,
cpcs.subinventory_code,
decode(cpcs.subinventory_code,null,'Y') intransit,
to_number(null) intransit_account,
cpcs.rollback_quantity quantity
from
org_acct_periods oap,
cst_period_close_summary cpcs
where
11=11 and
:p_period_name is not null and
oap.acct_period_id=cpcs.acct_period_id and
cpcs.rollback_quantity<>0
union all
select
moqd.organization_id,
moqd.inventory_item_id,
moqd.subinventory_code,
null intransit,
null intransit_account,
moqd.primary_transaction_quantity quantity
from
mtl_onhand_quantities_detail moqd,
mtl_secondary_inventories msub
where
:p_period_name is null and
moqd.is_consigned=2 and
moqd.organization_id=msub.organization_id and
moqd.subinventory_code=msub.secondary_inventory_name and
msub.asset_inventory=1
union all
select
ms.intransit_owning_org_id organization_id,
ms.item_id inventory_item_id,
null subinventory_code,
'Y' intransit,
mip.intransit_inv_account intransit_account,
ms.to_org_primary_quantity quantity
from
mtl_supply ms,
mtl_interorg_parameters mip
where
:p_period_name is null and
ms.supply_type_code in ('SHIPMENT','RECEIVING') and
ms.from_organization_id=mip.from_organization_id and
ms.to_organization_id=mip.to_organization_id
) q
where
x.organization_id=q.organization_id(+) and
x.inventory_item_id=q.inventory_item_id(+)
group by
x.ledger,
x.operating_unit,
x.org_code,
x.organization_name,
x.currency_code,
x.organization_id,
x.primary_cost_method,
x.cost_group_accounting,
x.default_cost_group_id,
x.org_material_account,
x.category_set_id,
x.inventory_item_id,
x.cost_type_id1,
x.cost_type_id2,
q.subinventory_code,
q.intransit,
q.intransit_account
) y,
mtl_secondary_inventories msub,
(select gdr.from_currency, gdr.conversion_rate from gl_daily_conversion_types gdct, gl_daily_rates gdr where gdct.user_conversion_type=:user_conversion_type1 and gdct.conversion_type=gdr.conversion_type and gdr.conversion_date=:conversion_date1 and gdr.to_currency=:p_to_currency) gdr1,
(select gdr.from_currency, gdr.conversion_rate from gl_daily_conversion_types gdct, gl_daily_rates gdr where gdct.user_conversion_type=:user_conversion_type2 and gdct.conversion_type=gdr.conversion_type and gdr.conversion_date=:conversion_date2 and gdr.to_currency=:p_to_currency) gdr2
where
y.organization_id=msub.organization_id(+) and
y.subinventory_code=msub.secondary_inventory_name(+) and
y.currency_code=gdr1.from_currency(+) and
y.currency_code=gdr2.from_currency(+)
) z,
mtl_system_items_vl msiv,
mtl_item_status_vl misv,
cst_item_costs cic1,
cst_item_costs cic2
where
z.organization_id=msiv.organization_id and
z.inventory_item_id=msiv.inventory_item_id and
msiv.inventory_item_status_code=misv.inventory_item_status_code and
z.organization_id=cic1.organization_id and
z.inventory_item_id=cic1.inventory_item_id and
z.cost_type_id1=cic1.cost_type_id and
z.organization_id=cic2.organization_id(+) and
z.inventory_item_id=cic2.inventory_item_id(+) and
z.cost_type_id2=cic2.cost_type_id(+)
) w,
gl_code_combinations gcc
where
13=13 and
14=14 and
w.material_account=gcc.code_combination_id(+)
order by
w.ledger,
w.operating_unit,
w.org_code,
w.item_number,
w.subinventory_or_intransit

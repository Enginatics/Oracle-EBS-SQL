/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inventory Pending Cost Adjustment - No Currencies
-- Description: Report showing the potential standard cost changes for onhand and intransit inventory value which you own. If you enter a period name this report uses the quantities from the month-end snapshot; if you leave the period name blank it uses the real-time quantities. The Cost Type (Old) defaults to your Costing Method Cost Type (Average, Standard, etc.); and the To Currency Code and the Organization Code default from the organization code set for this session. Unlike the CAC Inventory Pending Cost Adjustment report, this version does not display any cost differences due to changes in foreign currency rates (FX). If you want to see the impact of FX changes, please use the CAC Inventory Pending Cost Adjustment report.
-- If using this report for reporting after the standard cost update has run this report requires both the before and after cost types available for reporting purposes. Using the item cost copy please save your Frozen costs before running the standard cost update.
-- Parameters:
-- ===========
-- Period Name (Closed): to use the month-end quantities, choose a closed inventory accounting period (optional).
-- Cost Type (New): enter the Cost Type that has the revised or new item costs (mandatory).
-- Cost Type (Old): enter the Cost Type that has the existing or current item costs, defaults to the Frozen Cost Type (mandatory).
-- Category Set 1: the first item category set to report, typically the Cost or Product Line Category Set (optional).
-- Category Set 2: The second item category set to report, typically the Inventory Category Set (optional).
-- Only Items in New Cost Type: enter Yes to only report the items in the New Cost Type. Specify No if you want to use this report to reconcile overall inventory value (mandatory).
-- Include Items With No Quantities: enter Yes to report items that do not have onhand quantities (mandatory).
-- Include Zero Item Cost Differences: enter Yes to include items with a zero item cost difference (mandatory).
-- Item Number: specific buy or make item you wish to report (optional).
-- Organization Code: enter the inventory organization(s) you wish to report, defaults to your session's inventory organization (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2008-2023 Douglas Volz Consulting, Inc
-- -- | All rights reserved
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxstdcostpendingadjrept.sql
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 21 Nov 2010 Douglas Volz Created initial Report for prior client
-- -- | 1.11 05 Jun 2022 Douglas Volz Fix for category accounts (valuation accounts) and
-- -- | added subinventory description.
-- -- | 1.12 23 Sep 2023 Douglas Volz Add parameter to not include zero item cost differences,
-- -- | removed tabs and added org access controls.
-- -- | 1.13 09 Nov 2023 Douglas Volz Add item master and costing lot sizes, use default controls,
-- -- | based on rollup and shrinkage rate columns
-- -- | 1.14 04 Dec 2023 Douglas Volz Added G/L and Operating Unit security restrictions.
-- -- | 1.16 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-inventory-pending-cost-adjustment-no-currencies/
-- Library Link: https://www.enginatics.com/reports/cac-inventory-pending-cost-adjustment-no-currencies/
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
round(w.material1,5)-round(w.material2,5) material_cost_diff,
case
when round(w.material1-w.material2,5)=0 then 0
when round(w.material1-w.material2,5)=round(w.material1,5) then 100
else round((w.material1-w.material2)/w.material2*100,1)
end material_percent_diff,
round(w.material_overhead1,5) new_material_overhead_cost,
round(w.material_overhead2,5) old_material_overhead_cost,
round(w.material_overhead1,5)-round(w.material_overhead2,5) material_overhead_cost_diff,
case
when round(w.material_overhead1-w.material_overhead2,5)=0 then 0
when round(w.material_overhead1-w.material_overhead2,5)=round(w.material_overhead1,5) then 100
else round((w.material_overhead1-w.material_overhead2)/w.material_overhead2*100,1)
end material_ovhd_percent_diff,
round(w.resource1,5) new_resource_cost,
round(w.resource2,5) old_resource_cost,
round(w.resource1,5)-round(w.resource2,5) resource_cost_diff,
case
when round(w.resource1-w.resource2,5)=0 then 0
when round(w.resource1-w.resource2,5)=round(w.resource1,5) then 100
else round((w.resource1-w.resource2)/w.resource2*100,1)
end resource_percent_diff,
round(w.outside_processing1,5) new_outside_processing_cost,
round(w.outside_processing2,5) old_outside_processing_cost,
round(w.outside_processing1,5)-round(w.outside_processing2,5) osp_cost_diff,
case
when round(w.outside_processing1-w.outside_processing2,5)=0 then 0
when round(w.outside_processing1-w.outside_processing2,5)=round(w.outside_processing1,5) then 100
else round((w.outside_processing1-w.outside_processing2)/w.outside_processing2*100,1)
end osp_percent_diff,
round(w.overhead1,5) new_overhead_cost,
round(w.overhead2,5) old_overhead_cost,
round(w.overhead1,5)-round(w.overhead2,5) overhead_cost_diff,
case
when round(w.overhead1-w.overhead2,5)=0 then 0
when round(w.overhead1-w.overhead2,5)=round(w.overhead1,5) then 100
else round((w.overhead1-w.overhead2)/w.overhead2*100,1)
end overhead_percent_diff,
round(w.item_cost1,5) new_item_cost,
round(w.item_cost2,5) old_item_cost,
round(w.item_cost1,5)-round(w.item_cost2,5) item_cost_difference,
case
when round(w.item_cost1-w.item_cost2,5)=0 then 0
when round(w.item_cost1-w.item_cost2,5)=round(w.item_cost1,5) then 100
else round((w.item_cost1-w.item_cost2)/w.item_cost2*100,1)
end percent_difference,
w.subinventory_or_intransit,
w.subinventory_description,
w.uom_code,
w.quantity onhand_quantity,
round(w.item_cost1*w.quantity,2) new_onhand_value,
round(w.item_cost2*w.quantity,2) old_onhand_value,
round((w.item_cost1-w.item_cost2)*w.quantity,2) onhand_value_difference
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
nvl(cic2.item_cost,0) item_cost2
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
end material_account
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
mtl_secondary_inventories msub
where
y.organization_id=msub.organization_id(+) and
y.subinventory_code=msub.secondary_inventory_name(+)
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

/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Slow Moving Inventory
-- Description: Slow moving, excess and obsolete inventory. Lists items still holding stock as of a chosen date that have had no material movement over a chosen period, with their value, usage rate and months of supply, for obsolescence provisioning.
-- On Hand is the quantity as of the As of Date, not the current quantity. It is rolled back like Oracle's Transaction Historical Summary report, by reversing every material transaction posted after that date. Values use the item cost of the organization's primary cost method.
-- The no activity test is made per item, so an item is dropped as a whole as soon as any of its subinventories moved. Ignore Adjustment Transactions excludes cycle count adjustments, physical inventory adjustments and cost updates from that test and from Last Transaction Date. Logical transactions never count as activity.
-- Usage Quantity is the quantity issued out of stock over the Usage Months preceding the As of Date. Months of Supply stays empty where there was no usage at all, which identifies the items that have not moved once in the whole window.
-- Rows are per subinventory; Item On Hand and Item On Hand Value are the item totals across subinventories.
-- Excel Example Output: https://www.enginatics.com/example/inv-slow-moving-inventory/
-- Library Link: https://www.enginatics.com/reports/inv-slow-moving-inventory/
-- Run Report: https://demo.enginatics.com/

select
x.organization_code,
x.organization_name,
x.subinventory,
x.subinventory_description,
x.subinventory_type,
x.asset_subinventory,
x.item,
x.item_description,
x.item_status,
x.user_item_type,
x.make_buy,
x.planner,
x.uom,
&category_columns
x.as_of_date,
x.on_hand,
x.item_on_hand,
x.cost_type,
x.item_cost,
x.on_hand_value,
x.item_on_hand_value,
x.last_transaction_date,
x.last_transaction_type,
x.days_since_last_transaction,
x.usage_quantity,
x.avg_monthly_usage,
x.months_of_supply,
x.organization_id,
x.inventory_item_id
from
(
select
mp.organization_code,
haouv.name organization_name,
y.subinventory_code subinventory,
msi.description subinventory_description,
xxen_util.meaning(nvl(msi.subinventory_type,1),'MTL_SUB_TYPES',700) subinventory_type,
xxen_util.meaning(msi.asset_inventory,'SYS_YES_NO',700) asset_subinventory,
msiv.concatenated_segments item,
msiv.description item_description,
msiv.inventory_item_status_code item_status,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy,
msiv.planner_code planner,
msiv.primary_uom_code uom,
trunc(:as_of_date) as_of_date,
y.on_hand,
y.item_on_hand,
cct.cost_type,
cic.item_cost,
round(y.on_hand*cic.item_cost,2) on_hand_value,
round(y.item_on_hand*cic.item_cost,2) item_on_hand_value,
y.last_transaction_date,
mtt.transaction_type_name last_transaction_type,
trunc(:as_of_date)-trunc(y.last_transaction_date) days_since_last_transaction,
y.usage_quantity,
round(y.usage_quantity/:usage_months,6) avg_monthly_usage,
case when y.usage_quantity>0 then round(y.item_on_hand*:usage_months/y.usage_quantity,1) end months_of_supply,
y.organization_id,
y.inventory_item_id
from
(
select
z.organization_id,
z.inventory_item_id,
z.subinventory_code,
z.on_hand,
sum(z.on_hand) over (partition by z.organization_id, z.inventory_item_id) item_on_hand,
sum(z.usage_quantity) over (partition by z.organization_id, z.inventory_item_id) usage_quantity,
max(z.last_transaction_date) over (partition by z.organization_id, z.inventory_item_id) last_transaction_date,
max(z.last_transaction_type_id) keep (dense_rank last order by z.last_transaction_date nulls first) over (partition by z.organization_id, z.inventory_item_id) last_transaction_type_id,
sum(z.activity_count) over (partition by z.organization_id, z.inventory_item_id) activity_count
from
(
select
u.organization_id,
u.inventory_item_id,
u.subinventory_code,
sum(u.on_hand) on_hand,
sum(u.usage_quantity) usage_quantity,
max(u.last_transaction_date) last_transaction_date,
max(u.transaction_type_id) keep (dense_rank last order by u.last_transaction_date nulls first) last_transaction_type_id,
sum(u.activity_count) activity_count
from
(
select
moqd.organization_id,
moqd.inventory_item_id,
moqd.subinventory_code,
moqd.primary_transaction_quantity on_hand,
to_number(null) usage_quantity,
cast(null as date) last_transaction_date,
to_number(null) transaction_type_id,
0 activity_count
from
mtl_onhand_quantities_detail moqd,
mtl_parameters mp
where
2=2 and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
moqd.organization_id=mp.organization_id
union all
select
mmt.organization_id,
mmt.inventory_item_id,
mmt.subinventory_code,
case when mmt.transaction_date>=trunc(:as_of_date)+1 then -mmt.primary_quantity end,
case when mmt.transaction_date<trunc(:as_of_date)+1 and mmt.transaction_date>=add_months(trunc(:as_of_date)+1,-:usage_months) and mmt.transaction_action_id in (1,3,21,32,34) then -mmt.primary_quantity end,
case when mmt.transaction_date<trunc(:as_of_date)+1 and (nvl(:ignore_adjustments,'Y')<>'Y' or mmt.transaction_action_id not in (4,8,24)) then mmt.transaction_date end,
case when mmt.transaction_date<trunc(:as_of_date)+1 and (nvl(:ignore_adjustments,'Y')<>'Y' or mmt.transaction_action_id not in (4,8,24)) then mmt.transaction_type_id end,
case when mmt.transaction_date>=trunc(:no_activity_since) and mmt.transaction_date<trunc(:as_of_date)+1 and (nvl(:ignore_adjustments,'Y')<>'Y' or mmt.transaction_action_id not in (4,8,24)) then 1 else 0 end
from
mtl_material_transactions mmt,
mtl_parameters mp
where
3=3 and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mmt.organization_id=mp.organization_id and
nvl(mmt.logical_transaction,2)<>1
) u
group by
u.organization_id,
u.inventory_item_id,
u.subinventory_code
) z
) y,
mtl_parameters mp,
hr_all_organization_units_vl haouv,
mtl_secondary_inventories msi,
mtl_system_items_vl msiv,
cst_item_costs cic,
cst_cost_types cct,
mtl_transaction_types mtt
where
1=1 and
y.on_hand<>0 and
y.activity_count=0 and
y.organization_id=mp.organization_id and
mp.organization_id=haouv.organization_id and
y.organization_id=msi.organization_id(+) and
y.subinventory_code=msi.secondary_inventory_name(+) and
y.organization_id=msiv.organization_id and
y.inventory_item_id=msiv.inventory_item_id and
mp.cost_organization_id=cic.organization_id(+) and
y.inventory_item_id=cic.inventory_item_id(+) and
mp.primary_cost_method=cic.cost_type_id(+) and
cic.cost_type_id=cct.cost_type_id(+) and
y.last_transaction_type_id=mtt.transaction_type_id(+)
) x
order by
x.organization_code,
x.item_on_hand_value desc nulls last,
x.item,
x.subinventory

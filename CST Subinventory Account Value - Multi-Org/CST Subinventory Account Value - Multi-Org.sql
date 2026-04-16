/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Subinventory Account Value - Multi-Org
-- Description: Report: CST Subinventory Account Value - Multi-Org

Description:
Shows onhand inventory value broken down by GL account and cost element across multiple organizations.

For each subinventory, the report unpivots inventory value into separate rows per cost element (Material, Material Overhead, Resource, Outside Processing, Overhead), each showing the GL account where that cost element is recorded.

Asset subinventories show 5 rows per item (one per cost element).
Expense subinventories show 1 row per item with total cost under the expense account.

Account determination follows Oracle standard costing rules:
- Standard costing: accounts from subinventory setup (mtl_secondary_inventories)
- Average/FIFO/LIFO costing: accounts from organization defaults (mtl_parameters)
- Cost group accounting: accounts from cost group accounts (cst_cost_group_accounts)

Corresponds to Oracle standard report: Subinventory Account Value Report (CSTRSAVR)

The report can be run across multiple Inventory Organizations.

DB package: XXEN_INV_VALUE
-- Excel Examle Output: https://www.enginatics.com/example/cst-subinventory-account-value-multi-org/
-- Library Link: https://www.enginatics.com/reports/cst-subinventory-account-value-multi-org/
-- Run Report: https://demo.enginatics.com/

select
gsob.name ledger,
haou.name operating_unit,
y.organization_code,
y.subinventory,
y.subinventory_desc,
y.asset_subinventory,
y.cost_group,
y.cost_element,
gcck.concatenated_segments account,
y.item,
y.item_description,
y.category,
y.user_item_type,
y.uom,
y.item_status,
y.inventory_asset,
y.make_buy,
y.planning_method,
y.revision,
y.qty,
y.element_value value,
y.item||' - '||y.item_description item_label,
y.subinventory||' - '||y.subinventory_desc subinventory_label,
ood.organization_code||' - '||ood.organization_name organization_label,
sysdate report_run_date
from
(
select
x.*,
decode(ce.element,6,'Expense',xxen_util.meaning(ce.element,'CST_COST_CODE_TYPE',700)) cost_element,
case ce.element
when 1 then x.material_acct_id
when 2 then x.moh_acct_id
when 3 then x.resource_acct_id
when 4 then x.osp_acct_id
when 5 then x.overhead_acct_id
when 6 then x.expense_acct_id
end account_id,
case ce.element
when 1 then x.material_value
when 2 then x.moh_value
when 3 then x.resource_value
when 4 then x.osp_value
when 5 then x.overhead_value
when 6 then x.expense_value
end element_value
from
(
select
mp.organization_id,
mp.organization_code,
msi.concatenated_segments item,
msi.description item_description,
mc.concatenated_segments category,
xxen_util.meaning(msi.item_type,'ITEM_TYPE',3) user_item_type,
msi.primary_uom_code uom,
msi.inventory_item_status_code item_status,
xxen_util.meaning(cict.inventory_asset_flag,'SYS_YES_NO',700) inventory_asset,
xxen_util.meaning(msi.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy,
decode(msi.inventory_planning_code,6,xxen_util.meaning(nvl(msi.mrp_planning_code,6),'MRP_PLANNING_CODE',700),xxen_util.meaning(nvl(msi.inventory_planning_code,6),'MTL_MATERIAL_PLANNING',700)) planning_method,
decode(:p_item_revision,1,ciqt.revision,null) revision,
ciqt.subinventory_code subinventory,
sec.description subinventory_desc,
xxen_util.meaning(sec.asset_inventory,'SYS_YES_NO',700) asset_subinventory,
nvl(sec.asset_inventory,1) asset_inventory_flag,
ccg.cost_group,
round(sum(nvl(ciqt.rollback_qty,0)),:p_qty_precision) qty,
--
case
when nvl(mp.cost_group_accounting,2)=1 then max(ccga.material_account)
when mp.primary_cost_method=1 then max(sec.material_account)
else max(mp.material_account)
end material_acct_id,
case
when nvl(mp.cost_group_accounting,2)=1 then max(ccga.material_overhead_account)
when mp.primary_cost_method=1 then max(sec.material_overhead_account)
else max(mp.material_overhead_account)
end moh_acct_id,
case
when nvl(mp.cost_group_accounting,2)=1 then max(ccga.resource_account)
when mp.primary_cost_method=1 then max(sec.resource_account)
else max(mp.resource_account)
end resource_acct_id,
case
when nvl(mp.cost_group_accounting,2)=1 then max(ccga.overhead_account)
when mp.primary_cost_method=1 then max(sec.overhead_account)
else max(mp.overhead_account)
end overhead_acct_id,
case
when nvl(mp.cost_group_accounting,2)=1 then max(ccga.outside_processing_account)
when mp.primary_cost_method=1 then max(sec.outside_processing_account)
else max(mp.outside_processing_account)
end osp_acct_id,
max(sec.expense_account) expense_acct_id,
--
sum(ciqt.rollback_qty*nvl(cict.material_cost,0)*decode(sec.asset_inventory,2,0,1)*:p_exchange_rate) material_value,
sum(ciqt.rollback_qty*nvl(cict.material_overhead_cost,0)*decode(sec.asset_inventory,2,0,1)*:p_exchange_rate) moh_value,
sum(ciqt.rollback_qty*nvl(cict.resource_cost,0)*decode(sec.asset_inventory,2,0,1)*:p_exchange_rate) resource_value,
sum(ciqt.rollback_qty*nvl(cict.overhead_cost,0)*decode(sec.asset_inventory,2,0,1)*:p_exchange_rate) overhead_value,
sum(ciqt.rollback_qty*nvl(cict.outside_processing_cost,0)*decode(sec.asset_inventory,2,0,1)*:p_exchange_rate) osp_value,
sum(ciqt.rollback_qty*nvl(cict.item_cost,0)*decode(sec.asset_inventory,2,1,0)*:p_exchange_rate) expense_value
from
cst_inv_qty_temp ciqt,
cst_inv_cost_temp cict,
mtl_parameters mp,
mtl_secondary_inventories sec,
mtl_system_items_vl msi,
mtl_categories_b_kfv mc,
cst_cost_groups ccg,
cst_cost_group_accounts ccga
where
ciqt.qty_source in (3,4,5) and
cict.organization_id=ciqt.organization_id and
cict.inventory_item_id=ciqt.inventory_item_id and
cict.cost_source in (1,2) and
(mp.primary_cost_method=1 or cict.cost_group_id=ciqt.cost_group_id) and
mp.organization_id=ciqt.organization_id and
sec.organization_id(+)=ciqt.organization_id and
sec.secondary_inventory_name(+)=ciqt.subinventory_code and
msi.organization_id=ciqt.organization_id and
msi.inventory_item_id=ciqt.inventory_item_id and
mc.category_id=ciqt.category_id and
ccg.cost_group_id(+)=coalesce(ciqt.cost_group_id,cict.cost_group_id,mp.default_cost_group_id) and
ccga.organization_id(+)=ciqt.organization_id and
ccga.cost_group_id(+)=coalesce(ciqt.cost_group_id,mp.default_cost_group_id)
group by
mp.organization_id,
mp.organization_code,
mp.primary_cost_method,
mp.cost_group_accounting,
msi.concatenated_segments,
msi.description,
mc.concatenated_segments,
xxen_util.meaning(msi.item_type,'ITEM_TYPE',3),
msi.primary_uom_code,
msi.inventory_item_status_code,
cict.inventory_asset_flag,
msi.planning_make_buy_code,
decode(msi.inventory_planning_code,6,xxen_util.meaning(nvl(msi.mrp_planning_code,6),'MRP_PLANNING_CODE',700),xxen_util.meaning(nvl(msi.inventory_planning_code,6),'MTL_MATERIAL_PLANNING',700)),
decode(:p_item_revision,1,ciqt.revision,null),
ciqt.subinventory_code,
sec.description,
sec.asset_inventory,
ccg.cost_group
having
decode(:p_neg_qty,1,1,2)=decode(:p_neg_qty,1,decode(sign(sum(ciqt.rollback_qty)),'-1',1,2),2) and
decode(:p_zero_qty,2,round(sum(nvl(ciqt.rollback_qty,0)),:p_qty_precision),1)<>0
) x,
(select 1 element from dual union all
select 2 from dual union all
select 3 from dual union all
select 4 from dual union all
select 5 from dual union all
select 6 from dual) ce
where
(nvl(x.asset_inventory_flag,1)<>2 and ce.element between 1 and 5 or
nvl(x.asset_inventory_flag,1)=2 and ce.element=6) and
case ce.element
when 1 then x.material_value
when 2 then x.moh_value
when 3 then x.resource_value
when 4 then x.osp_value
when 5 then x.overhead_value
when 6 then x.expense_value
end<>0
) y,
gl_code_combinations_kfv gcck,
org_organization_definitions ood,
hr_all_organization_units haou,
gl_sets_of_books gsob
where
1=1 and
y.account_id=gcck.code_combination_id(+) and
y.organization_id=ood.organization_id and
ood.operating_unit=haou.organization_id and
ood.set_of_books_id=gsob.set_of_books_id
order by
y.organization_code,
y.subinventory,
gcck.concatenated_segments,
y.cost_element,
y.item,
y.revision
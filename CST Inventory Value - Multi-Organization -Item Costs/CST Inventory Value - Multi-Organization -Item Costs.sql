/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Inventory Value - Multi-Organization (Item Costs)
-- Description: Report: CST Inventory Value - Multi-Organization (Item Costs)

Description: 
This Inventory Value Report reports Inventory Value at the Item Cost level, and can be used to analyze inventory value by Ledger, Operating Unit, Organization, Subinventory, Item Category

The report can be run across multiple Inventory Organizations

Provided Templates:
* Pivot - Category, Item, Organization, Subinventory
  Inventory Value summarised by Item Category, Item, Inventory Organization, Subinventory
* Pivot - Item, Organization, Subinventory
  Inventory Value summarised by Item, Inventory Organization, Subinventory
* Pivot - Organization, Subinventory, Item
  Inventory Value summarised by Inventory Organization, Subinventory, Item

DB package: XXEN_INV_VALUE

-- Excel Examle Output: https://www.enginatics.com/example/cst-inventory-value-multi-organization-item-costs/
-- Library Link: https://www.enginatics.com/reports/cst-inventory-value-multi-organization-item-costs/
-- Run Report: https://demo.enginatics.com/

select
gsob.name ledger,
haou.name operating_unit,
mp.organization_code,
msi.concatenated_segments item,
msi.description item_description,
mc.concatenated_segments category,
xxen_util.meaning(msi.item_type,'ITEM_TYPE',3) user_item_type,
msi.primary_uom_code uom,
msi.inventory_item_status_code item_status,
xxen_util.meaning(cict.inventory_asset_flag,'SYS_YES_NO',700) inventory_asset,
xxen_util.meaning(msi.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy,
decode(msi.inventory_planning_code,6, xxen_util.meaning(nvl(msi.mrp_planning_code,6),'MRP_PLANNING_CODE',700), xxen_util.meaning(nvl(msi.inventory_planning_code,6),'MTL_MATERIAL_PLANNING',700)) planning_method,
decode(:p_item_revision, 1, ciqt.revision, null) revision,
ciqt.subinventory_code subinventory,
sec.description subinventory_desc,
xxen_util.meaning(sec.asset_inventory,'SYS_YES_NO',700) asset_subinventory,
decode(ciqt.subinventory_code,null,'Intransit','On-hand') type,
round(sum(nvl(ciqt.rollback_qty,0)),:p_qty_precision) qty,
--
round(nvl(cict.item_cost,0)*:p_exchange_rate, :p_ext_precision) item_unit_cost,
--
sum(ciqt.rollback_qty * nvl(cict.item_cost,0)               * decode(sec.asset_inventory,2,0,1) * :p_exchange_rate) total_cost,
sum(ciqt.rollback_qty * nvl(cict.material_cost,0)           * decode(sec.asset_inventory,2,0,1) * :p_exchange_rate) material_cost,
sum(ciqt.rollback_qty * nvl(cict.material_overhead_cost,0)  * decode(sec.asset_inventory,2,0,1) * :p_exchange_rate) material_overhead_cost,
sum(ciqt.rollback_qty * nvl(cict.resource_cost,0)           * decode(sec.asset_inventory,2,0,1) * :p_exchange_rate) resource_cost,
sum(ciqt.rollback_qty * nvl(cict.outside_processing_cost,0) * decode(sec.asset_inventory,2,0,1) * :p_exchange_rate) outside_processing_cost,
sum(ciqt.rollback_qty * nvl(cict.overhead_cost,0)           * decode(sec.asset_inventory,2,0,1) * :p_exchange_rate) overhead_cost,
--
msi.concatenated_segments || ' - ' || msi.description item_label,
ciqt.subinventory_code || ' - ' || sec.description subinventory_label,
mp.organization_code || ' - ' || ood.organization_name organization_label
from
mtl_categories_b_kfv mc,
mtl_system_items_vl msi,
mtl_secondary_inventories sec,
cst_inv_qty_temp ciqt,
cst_inv_cost_temp cict,
mtl_parameters mp,
org_organization_definitions ood,
org_access_view oav,
hr_all_organization_units haou,
gl_sets_of_books gsob,
cst_item_costs cic
where
1=1 and
oav.organization_id = ciqt.organization_id and
oav.resp_application_id = fnd_global.resp_appl_id and
oav.responsibility_id = fnd_global.resp_id and
msi.organization_id = ciqt.organization_id and
msi.inventory_item_id = ciqt.inventory_item_id and
mp.organization_id = ciqt.organization_id and
ood.organization_id = ciqt.organization_id and
haou.organization_id = ood.operating_unit and
gsob.set_of_books_id = ood.set_of_books_id and
cict.organization_id = ciqt.organization_id and
cict.inventory_item_id = ciqt.inventory_item_id and
(cict.cost_group_id = ciqt.cost_group_id or mp.primary_cost_method = 1) and
sec.organization_id(+) = ciqt.organization_id and
sec.secondary_inventory_name(+) = ciqt.subinventory_code and
mc.category_id = ciqt.category_id and
cic.organization_id = ciqt.organization_id and
cic.inventory_item_id = ciqt.inventory_item_id and
cic.cost_type_id = cict.cost_type_id
group by
gsob.name,
haou.name,
mp.organization_code,
ood.organization_name,
msi.concatenated_segments,
msi.description,
mc.concatenated_segments,
xxen_util.meaning(msi.item_type,'ITEM_TYPE',3),
msi.primary_uom_code,
msi.inventory_item_status_code,
cict.inventory_asset_flag,
msi.planning_make_buy_code,
decode(msi.inventory_planning_code,6, xxen_util.meaning(nvl(msi.mrp_planning_code,6),'MRP_PLANNING_CODE',700), xxen_util.meaning(nvl(msi.inventory_planning_code,6),'MTL_MATERIAL_PLANNING',700)),
decode(:p_item_revision, 1, ciqt.revision, null),
ciqt.subinventory_code,
decode(ciqt.subinventory_code,null,'Intransit','On-hand'),
sec.description,
sec.asset_inventory,
round(nvl(cict.item_cost,0) * :p_exchange_rate, :p_ext_precision)
having
2=2 and
decode(:p_neg_qty,1,1,2) = decode(:p_neg_qty,1,decode(sign(sum(ciqt.rollback_qty)),'-1',1,2),2) and
decode(:p_zero_qty,2,round(sum(nvl(ciqt.rollback_qty,0)),:p_qty_precision),1) <> 0
order by
ciqt.subinventory_code,
msi.concatenated_segments,
revision
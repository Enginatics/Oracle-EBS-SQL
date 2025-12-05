/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Inventory Value Report - by Subinventory (Item Cost)
-- Description: Imported Oracle standard inventory value subinventory report by item cost
Source: Inventory Value Report - by Subinventory (XML)
Short Name: CSTRINVR_XML
DB package: BOM_CSTRINVR_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/cst-inventory-value-report-by-subinventory-item-cost/
-- Library Link: https://www.enginatics.com/reports/cst-inventory-value-report-by-subinventory-item-cost/
-- Run Report: https://demo.enginatics.com/

select
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
ccg.cost_group,
:p_as_of_date as_of_date,
round(sum(nvl(ciqt.rollback_qty,0)),:p_qty_precision) qty,
--
round(  sum(nvl(ciqt.rollback_qty,0) * decode(nvl(sec.asset_inventory,1),1,nvl(cict.item_cost,0),0) * :p_exchange_rate)
      / xxen_util.zero_to_null(round(sum(nvl(ciqt.rollback_qty,0)),:p_qty_precision))
     , :p_ext_precision) item_unit_cost,
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
sysdate report_run_date
from
mtl_categories_b_kfv mc,
mtl_system_items_vl msi,
mtl_secondary_inventories sec,
cst_inv_qty_temp ciqt,
cst_inv_cost_temp cict,
mtl_parameters mp,
cst_item_costs cic,
cst_cost_groups ccg
where
1=1 and
msi.organization_id = ciqt.organization_id and
msi.inventory_item_id = ciqt.inventory_item_id and
mp.organization_id = ciqt.organization_id and
cict.organization_id = ciqt.organization_id and
cict.inventory_item_id = ciqt.inventory_item_id and
(cict.cost_group_id = ciqt.cost_group_id or mp.primary_cost_method = 1) and
sec.organization_id(+) = ciqt.organization_id and
sec.secondary_inventory_name(+) = ciqt.subinventory_code and
mc.category_id = ciqt.category_id and
cic.organization_id = ciqt.organization_id and
cic.inventory_item_id = ciqt.inventory_item_id and
cic.cost_type_id = cict.cost_type_id and
ccg.cost_group_id (+) = nvl(ciqt.cost_group_id,cict.cost_group_id)
group by
xxen_util.meaning(msi.item_type,'ITEM_TYPE',3),
msi.concatenated_segments,
msi.description,
mc.concatenated_segments,
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
ccg.cost_group,
round(nvl(cict.item_cost,0) * :p_exchange_rate, :p_ext_precision),
sysdate
having
2=2 and
decode(:p_neg_qty,1,1,2) = decode(:p_neg_qty,1,decode(sign(sum(ciqt.rollback_qty)),'-1',1,2),2) and
decode(:p_zero_qty,2,round(sum(nvl(ciqt.rollback_qty,0)),:p_qty_precision),1) <> 0
order by
ciqt.subinventory_code,
msi.concatenated_segments,
revision
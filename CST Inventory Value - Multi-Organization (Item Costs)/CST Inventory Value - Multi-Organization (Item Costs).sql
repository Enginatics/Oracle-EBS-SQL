/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Inventory Value - Multi-Organization (Item Costs)
-- Description: Report: CST Inventory Value - Multi-Organization (Item Costs)

Description: 
The Inventory Value Report can be used to report  Inventory Value by 
- Elemental Item Cost level 
- Quantity Type (Onhand, Intransit, Receiving)

The report can be used to analyze inventory value by Ledger, Operating Unit, Organization, Subinventory, Item Category, Cost Group

The report corresponds to the following standard Oracle Reports
- Elemental Inventory Value Report
- All Inventories Value Report 

The report can be run across multiple Inventory Organizations

Templates are provided that match the existing standard Oracle Reports of the same name:
- All Inventories Value
- All Inventories Value by Cost Group
- Elemental Inventory Value
- Elemental Inventory Value by Subinventory
- Elemental Inventory Value by Cost Group

DB package: XXEN_INV_VALUE

Notes:
To run the report including non-costed items the As of Date parameter must be left blank (current date). The report cannot be run historically when including non-costed items due to a bug in the Oracle API uses to populate the interminm costing tables used by the report. The API will error with the following error, however the report will complete but  return no data: ORA-01403: no data found in Package CST_Inventory_PVT Procedure Calculate_InventoryCost

-- Excel Examle Output: https://www.enginatics.com/example/cst-inventory-value-multi-organization-item-costs/
-- Library Link: https://www.enginatics.com/reports/cst-inventory-value-multi-organization-item-costs/
-- Run Report: https://demo.enginatics.com/

select
 gsob.name ledger,
 haou.name operating_unit,
 x.organization_code,
 x.item,
 x.item_description,
 x.category,
 x.user_item_type,
 x.uom,
 x.item_status,
 x.inventory_asset,
 x.costing_enabled,
 x.make_buy,
 x.planning_method,
 x.revision,
 x.subinventory,
 x.subinventory_desc,
 x.asset_subinventory,
 ccg.cost_group,
 x.quantity_type,
 x.total_qty,
 --
 x.item_unit_cost,
 --
 x.total_cost,
 x.material_cost,
 x.material_overhead_cost,
 x.resource_cost,
 x.outside_processing_cost,
 x.overhead_cost,
 --
 x.onhand_qty,
 x.onhand_cost,
 x.intransit_qty,
 x.intransit_cost,
 x.receiving_qty,
 x.receiving_cost,
 --
 --
 x.item|| ' - ' || x.item_description item_label,
 x.subinventory || ' - ' || x.subinventory_desc subinventory_label,
 ood.organization_code || ' - ' || ood.organization_name organization_label,
 sysdate report_run_date
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
  xxen_util.meaning(msi.costing_enabled_flag,'YES_NO',0) costing_enabled, 
  xxen_util.meaning(msi.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy,
  decode(msi.inventory_planning_code,6, xxen_util.meaning(nvl(msi.mrp_planning_code,6),'MRP_PLANNING_CODE',700), xxen_util.meaning(nvl(msi.inventory_planning_code,6),'MTL_MATERIAL_PLANNING',700)) planning_method,
  decode(:p_item_revision, 1, ciqt.revision, null) revision,
  ciqt.subinventory_code subinventory,
  sec.description subinventory_desc,
  xxen_util.meaning(sec.asset_inventory,'SYS_YES_NO',700) asset_subinventory,
  coalesce(ciqt.cost_group_id,cict.cost_group_id,mp.default_cost_group_id) cost_group_id,
  case
   when ciqt.qty_source in (3,4,5) then 'Onhand'
   when ciqt.qty_source in (6,7,8) then 'Intransit'
   else 'Receiving'
  end quantity_type,
  round(sum(nvl(ciqt.rollback_qty,0)),:p_qty_precision) total_qty,
  --
  round(nvl(cict.item_cost,0)*:p_exchange_rate, :p_ext_precision) item_unit_cost,
  --
  sum(ciqt.rollback_qty * nvl(cict.item_cost,0)               * case when ciqt.qty_source in (3,4,5) then decode(sec.asset_inventory,2,0,1) else 1 end * :p_exchange_rate) total_cost,
  sum(ciqt.rollback_qty * nvl(cict.material_cost,0)           * case when ciqt.qty_source in (3,4,5) then decode(sec.asset_inventory,2,0,1) else 1 end * :p_exchange_rate) material_cost,
  sum(ciqt.rollback_qty * nvl(cict.material_overhead_cost,0)  * case when ciqt.qty_source in (3,4,5) then decode(sec.asset_inventory,2,0,1) else 1 end * :p_exchange_rate) material_overhead_cost,
  sum(ciqt.rollback_qty * nvl(cict.resource_cost,0)           * case when ciqt.qty_source in (3,4,5) then decode(sec.asset_inventory,2,0,1) else 1 end * :p_exchange_rate) resource_cost,
  sum(ciqt.rollback_qty * nvl(cict.outside_processing_cost,0) * case when ciqt.qty_source in (3,4,5) then decode(sec.asset_inventory,2,0,1) else 1 end * :p_exchange_rate) outside_processing_cost,
  sum(ciqt.rollback_qty * nvl(cict.overhead_cost,0)           * case when ciqt.qty_source in (3,4,5) then decode(sec.asset_inventory,2,0,1) else 1 end * :p_exchange_rate) overhead_cost,
  --
  round(sum(case when ciqt.qty_source in (3,4,5) then nvl(ciqt.rollback_qty,0) else null end),:p_qty_precision) onhand_qty,
  sum(case when ciqt.qty_source in (3,4,5) then nvl(ciqt.rollback_qty,0) else null end * nvl(cict.item_cost,0) * decode(sec.asset_inventory,2,0,1) * :p_exchange_rate) onhand_cost,
  round(sum(case when ciqt.qty_source in (6,7,8) then nvl(ciqt.rollback_qty,0) else null end),:p_qty_precision) intransit_qty,
  sum(case when ciqt.qty_source in (6,7,8) then nvl(ciqt.rollback_qty,0) else null end * nvl(cict.item_cost,0) * :p_exchange_rate) intransit_cost,
  round(sum(case when ciqt.qty_source in (9,10) then nvl(ciqt.rollback_qty,0) else null end),:p_qty_precision) receiving_qty,
  sum(case when ciqt.qty_source in (9,10) then nvl(ciqt.rollback_qty,0) else null end * nvl(cict.item_cost,0) * :p_exchange_rate) receiving_cost
 from
  cst_inv_qty_temp ciqt,
  cst_inv_cost_temp cict,
  mtl_parameters mp,
  mtl_secondary_inventories sec,
  mtl_system_items_vl msi,
  mtl_categories_b_kfv mc
 where
  ciqt.organization_id in
   (select
     oav.organization_id
    from
     org_access_view oav
    where
     oav.resp_application_id=fnd_global.resp_appl_id and
     oav.responsibility_id=fnd_global.resp_id
  ) and
  --
  cict.organization_id (+) = ciqt.organization_id and
  cict.inventory_item_id (+) = ciqt.inventory_item_id and
  --
  mp.organization_id = ciqt.organization_id and
  --
  sec.organization_id(+) = ciqt.organization_id and
  sec.secondary_inventory_name(+) = ciqt.subinventory_code and
  --
  msi.organization_id = ciqt.organization_id and
  msi.inventory_item_id = ciqt.inventory_item_id and
  --
  mc.category_id = ciqt.category_id and
  --
  ( -- Q1
    ( ciqt.qty_source in (3,4,5) and
      cict.cost_source in (1,2) and
      ( mp.primary_cost_method = 1 or cict.cost_group_id = ciqt.cost_group_id)
    ) or
    -- Q2/Q3
    ( ciqt.qty_source in (6,7,8) and
      cict.cost_source in (1,2) and
      ( (mp.primary_cost_method <> 1 and cict.cost_group_id = ciqt.cost_group_id) or
         mp.primary_cost_method = 1
      )
    ) or
    -- Q4
    (  ciqt.qty_source in (9,10) and
       cict.cost_source in (3,4) and
       cict.rcv_transaction_id = ciqt.rcv_transaction_id
    ) or
   -- Non Costed
   ( :p_cost_enabled_only = '2' and
     nvl(msi.costing_enabled_flag,'N') = 'N' 
   ) 
  )
 group by
  mp.organization_id,
  mp.organization_code,
  msi.concatenated_segments,
  msi.description,
  mc.concatenated_segments,
  xxen_util.meaning(msi.item_type,'ITEM_TYPE',3),
  msi.primary_uom_code,
  msi.inventory_item_status_code,
  cict.inventory_asset_flag,
  xxen_util.meaning(msi.costing_enabled_flag,'YES_NO',0),
  msi.planning_make_buy_code,
  decode(msi.inventory_planning_code,6, xxen_util.meaning(nvl(msi.mrp_planning_code,6),'MRP_PLANNING_CODE',700), xxen_util.meaning(nvl(msi.inventory_planning_code,6),'MTL_MATERIAL_PLANNING',700)),
  decode(:p_item_revision, 1, ciqt.revision, null),
  ciqt.subinventory_code,
  coalesce(ciqt.cost_group_id,cict.cost_group_id,mp.default_cost_group_id),
  case
   when ciqt.qty_source in (3,4,5) then 'Onhand'
   when ciqt.qty_source in (6,7,8) then 'Intransit'
   else 'Receiving'
  end,
  sec.description,
  sec.asset_inventory,
  round(nvl(cict.item_cost,0) * :p_exchange_rate, :p_ext_precision)
 having
  decode(:p_neg_qty,1,1,2) = decode(:p_neg_qty,1,decode(sign(sum(ciqt.rollback_qty)),'-1',1,2),2) and
  decode(:p_zero_qty,2,round(sum(nvl(ciqt.rollback_qty,0)),:p_qty_precision),1) <> 0
) x,
org_organization_definitions ood,
hr_all_organization_units haou,
gl_sets_of_books gsob,
cst_cost_groups ccg
where
1=1 and
x.organization_id = ood.organization_id  and
ood.operating_unit = haou.organization_id and
ood.set_of_books_id = gsob.set_of_books_id and
x.cost_group_id = ccg.cost_group_id (+)
order by
x.organization_code,
x.subinventory,
x.item,
x.revision
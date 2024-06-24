/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Inventory Value - Multi-Organization (Element Costs) 11i
-- Description: Report: CST Inventory Value - Multi-Organization (Element Costs)

Description: 
This Inventory Value Report reports Inventory Value at the Cost Element level, and can be used to analyze inventory value by Cost Element Account and/or by Cost Element.

The report can be run across multiple Inventory Organizations.

Provided Templates:
* Pivot - Account Summary 
  Inventory Value summarised by Cost Element Account 
* Pivot - Account, Organization, Subinventory, Item
  Inventory Value summarised by Cost Element Account, Inventory Organization, SubInventory, Item 
* Pivot - Cost Element, Organization, Subinventory, Item
  Inventory Value summarised by Cost Element, Inventory Organization, SubInventory, Item 

DB package: XXEN_INV_VALUE
-- Excel Examle Output: https://www.enginatics.com/example/cst-inventory-value-multi-organization-element-costs-11i/
-- Library Link: https://www.enginatics.com/reports/cst-inventory-value-multi-organization-element-costs-11i/
-- Run Report: https://demo.enginatics.com/

select
gsob.name ledger,
haou.name operating_unit,
mp.organization_code,
msi.concatenated_segments item,
msi.description item_description,
decode(:p_item_revision, 1, ciqt.revision, null) revision,
mc.concatenated_segments category,
xxen_util.meaning(msi.item_type,'ITEM_TYPE',3) user_item_type,
msi.primary_uom_code uom,
msi.inventory_item_status_code item_status,
xxen_util.meaning(cict.inventory_asset_flag,'SYS_YES_NO',700) inventory_asset,
xxen_util.meaning(msi.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy,
decode(msi.inventory_planning_code,6, xxen_util.meaning(nvl(msi.mrp_planning_code,6),'MRP_PLANNING_CODE',700), xxen_util.meaning(nvl(msi.inventory_planning_code,6),'MTL_MATERIAL_PLANNING',700)) planning_method,
ciqt.subinventory_code subinventory,
sec.description subinventory_description,
xxen_util.meaning(sec.asset_inventory,'SYS_YES_NO',700) asset_subinventory,
decode(ciqt.subinventory_code,null,'Intransit','On-hand') type,
ccg.cost_group,
--
nvl(:p_currency_code,gsob.currency_code) currency,
:p_exchange_rate exchange_rate,
round(nvl(cict.item_cost,0)*:p_exchange_rate, :p_ext_precision) item_unit_cost,
--
round(sum(nvl(ciqt.rollback_qty,0)),:p_qty_precision) element_qty,
--
case rowgen.column_value
 when 1 then gcc1.concatenated_segments
 when 2 then gcc2.concatenated_segments
 when 3 then gcc3.concatenated_segments
 when 4 then gcc4.concatenated_segments
 when 5 then gcc5.concatenated_segments
 end account,
case rowgen.column_value
 when 1 then 'Material'
 when 2 then 'Material Overhead'
 when 3 then 'Resource'
 when 4 then 'Outside Processing'
 when 5 then 'Overhead'
 end cost_element,
--
round(case rowgen.column_value
      when 1 then sum(ciqt.rollback_qty * decode(nvl(sec.asset_inventory,1),1,1,0) * nvl(cict.material_cost,0))
      when 2 then sum(ciqt.rollback_qty * decode(nvl(sec.asset_inventory,1),1,1,0) * nvl(cict.material_overhead_cost,0))
      when 3 then sum(ciqt.rollback_qty * decode(nvl(sec.asset_inventory,1),1,1,0) * nvl(cict.resource_cost,0))
      when 4 then sum(ciqt.rollback_qty * decode(nvl(sec.asset_inventory,1),1,1,0) * nvl(cict.outside_processing_cost,0))
      when 5 then sum(ciqt.rollback_qty * decode(nvl(sec.asset_inventory,1),1,1,0) * nvl(cict.overhead_cost,0))
      end * :p_exchange_rate / xxen_util.zero_to_null(sum(nvl(ciqt.rollback_qty,0)))
     , :p_ext_precision) element_unit_cost,
case rowgen.column_value
      when 1 then sum(ciqt.rollback_qty * decode(nvl(sec.asset_inventory,1),1,1,0) * nvl(cict.material_cost,0))
      when 2 then sum(ciqt.rollback_qty * decode(nvl(sec.asset_inventory,1),1,1,0) * nvl(cict.material_overhead_cost,0))
      when 3 then sum(ciqt.rollback_qty * decode(nvl(sec.asset_inventory,1),1,1,0) * nvl(cict.resource_cost,0))
      when 4 then sum(ciqt.rollback_qty * decode(nvl(sec.asset_inventory,1),1,1,0) * nvl(cict.outside_processing_cost,0))
      when 5 then sum(ciqt.rollback_qty * decode(nvl(sec.asset_inventory,1),1,1,0) * nvl(cict.overhead_cost,0))
      end * :p_exchange_rate  element_extended_value,
--
msi.concatenated_segments || ' - ' || msi.description item_label,
ciqt.subinventory_code || ' - ' || sec.description subinventory_label,
mp.organization_code || ' - ' || ood.organization_name organization_label,
case rowgen.column_value
 when 1 then 'Material (' || gcc1.concatenated_segments || ')'
 when 2 then 'Material Overhead (' || gcc2.concatenated_segments || ')'
 when 3 then 'Resource (' || gcc3.concatenated_segments || ')'
 when 4 then 'Outside Processing (' || gcc4.concatenated_segments || ')'
 when 5 then 'Overhead (' || gcc5.concatenated_segments || ')'
 end cost_element_label
from
mtl_categories_b_kfv mc,
mtl_system_items_vl msi,
mtl_secondary_inventories sec,
cst_inv_qty_temp ciqt,
cst_inv_cost_temp cict,
cst_item_costs cic,
cst_cost_groups ccg,
mtl_parameters mp,
org_organization_definitions ood,
hr_all_organization_units haou,
gl_sets_of_books gsob,
--
gl_code_combinations_kfv   gcc1,
gl_code_combinations_kfv   gcc2,
gl_code_combinations_kfv   gcc3,
gl_code_combinations_kfv   gcc4,
gl_code_combinations_kfv   gcc5,
table(xxen_util.rowgen(5)) rowgen
where
1=1 and
ciqt.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
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
ccg.cost_group_id (+) = ciqt.cost_group_id and
ood.organization_id = ciqt.organization_id and
gsob.set_of_books_id = ood.set_of_books_id and
haou.organization_id = ood.operating_unit and
gcc1.code_combination_id = sec.material_account and
gcc2.code_combination_id(+) = sec.material_overhead_account and
gcc3.code_combination_id(+) = sec.resource_account and
gcc4.code_combination_id(+) = sec.outside_processing_account and
gcc5.code_combination_id(+) = sec.overhead_account
group by
gsob.name,
haou.name,
mp.organization_code,
ood.organization_name,
nvl(:p_currency_code,gsob.currency_code),
xxen_util.meaning(msi.item_type,'ITEM_TYPE',3),
msi.concatenated_segments,
msi.description,
decode(:p_item_revision, 1, ciqt.revision, null),
mc.concatenated_segments,
msi.primary_uom_code,
msi.inventory_item_status_code,
cict.inventory_asset_flag,
msi.planning_make_buy_code,
decode(msi.inventory_planning_code,6, xxen_util.meaning(nvl(msi.mrp_planning_code,6),'MRP_PLANNING_CODE',700), xxen_util.meaning(nvl(msi.inventory_planning_code,6),'MTL_MATERIAL_PLANNING',700)),
ciqt.subinventory_code,
decode(ciqt.subinventory_code,null,'Intransit','On-hand'),
sec.description,
sec.asset_inventory,
ccg.cost_group,
decode(cict.cost_type_id, :p_cost_type_id, ' ', '*'),
round(nvl(cict.item_cost,0) * :p_exchange_rate, :p_ext_precision),
rowgen.column_value,
case rowgen.column_value
 when 1 then gcc1.concatenated_segments
 when 2 then gcc2.concatenated_segments
 when 3 then gcc3.concatenated_segments
 when 4 then gcc4.concatenated_segments
 when 5 then gcc5.concatenated_segments
 end,
case rowgen.column_value
 when 1 then 'Material (' || gcc1.concatenated_segments || ')'
 when 2 then 'Material Overhead (' || gcc2.concatenated_segments || ')'
 when 3 then 'Resource (' || gcc3.concatenated_segments || ')'
 when 4 then 'Outside Processing (' || gcc4.concatenated_segments || ')'
 when 5 then 'Overhead (' || gcc5.concatenated_segments || ')'
 end,
case rowgen.column_value
 when 1 then round(nvl(cict.material_cost,0)*:p_exchange_rate, :p_ext_precision)
 when 2 then round(nvl(cict.material_overhead_cost,0)*:p_exchange_rate, :p_ext_precision)
 when 3 then round(nvl(cict.resource_cost,0)*:p_exchange_rate, :p_ext_precision)
 when 4 then round(nvl(cict.outside_processing_cost,0)*:p_exchange_rate, :p_ext_precision)
 when 5 then round(nvl(cict.overhead_cost,0)*:p_exchange_rate, :p_ext_precision)
 end
having
2=2 and
decode(:p_neg_qty,1,1,2) = decode(:p_neg_qty,1,decode(sign(sum(ciqt.rollback_qty)),'-1',1,2),2) and
decode(:p_zero_qty,2,round(sum(nvl(ciqt.rollback_qty,0)),:p_qty_precision),1) <> 0
order by
ciqt.subinventory_code,
msi.concatenated_segments,
decode(:p_item_revision, 1, ciqt.revision, null)
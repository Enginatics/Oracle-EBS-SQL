/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Inventory Value Report - by Subinventory (Subinventory)
-- Description: Imported Oracle standard inventory value subinventory report by subinventory
Source: Inventory Value Report - by Subinventory (XML)
Short Name: CSTRINVR_XML
DB package: BOM_CSTRINVR_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/cst-inventory-value-report-by-subinventory-subinventory/
-- Library Link: https://www.enginatics.com/reports/cst-inventory-value-report-by-subinventory-subinventory/
-- Run Report: https://demo.enginatics.com/

select 
       ciqt.subinventory_code subinventory
,      sec.description subinventory_description
,      fnd_flex_xml_publisher_apis.process_kff_combination_1('p_item_seg', 'INV', 'MSTK', 101, msi.organization_id, msi.inventory_item_id, 'ALL', 'Y', 'VALUE') item
,      msi.description item_description
,      fnd_flex_xml_publisher_apis.process_kff_combination_1('p_cat_seg', 'INV', 'MCAT', mc.structure_id, null, mc.category_id, 'ALL', 'Y', 'VALUE') category
,      msi.primary_uom_code uom
,      decode(:p_item_revision, 1, ciqt.revision, null) revision
,      msi.inventory_item_status_code item_status
,      xxen_util.meaning(cict.inventory_asset_flag,'SYS_YES_NO',700) inv_asset
,      xxen_util.meaning(msi.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy
,      decode(msi.inventory_planning_code,6, xxen_util.meaning(nvl(msi.mrp_planning_code,6),'MRP_PLANNING_CODE',700), xxen_util.meaning(nvl(msi.inventory_planning_code,6),'MTL_MATERIAL_PLANNING',700)) planning_method
,      round(sum(ciqt.rollback_qty),:p_qty_precision) qty
,      round((sum(nvl(cict.item_cost,0)) * :p_exchange_rate), :p_ext_precision)    unit_cost    -- changed to round by extended precision
,      round(sum(nvl(ciqt.rollback_qty,0) * decode(nvl(sec.asset_inventory,1), 1, nvl(cict.item_cost,0), 0) * :p_exchange_rate) / round(sum(nvl(ciqt.rollback_qty,0)),:p_qty_precision), :p_ext_precision)    unit_cost_1   -- calculated as value/qty
,      decode(cict.cost_type_id, :p_cost_type_id, ' ', '*')   defaulted
,      round(sum(ciqt.rollback_qty * nvl(cict.material_cost,0) * decode(sec.asset_inventory, 2, 0, 1) * :p_exchange_rate) / :round_unit) * :round_unit   matl_cost
,      round(sum(ciqt.rollback_qty * nvl(cict.material_overhead_cost,0) * decode(sec.asset_inventory, 2, 0, 1) * :p_exchange_rate) / :round_unit) * :round_unit   movh_cost
,      round(sum(ciqt.rollback_qty * nvl(cict.resource_cost,0) * decode(sec.asset_inventory, 2, 0, 1) * :p_exchange_rate) / :round_unit) * :round_unit   res_cost
,      round(sum(ciqt.rollback_qty * nvl(cict.outside_processing_cost,0) * decode(sec.asset_inventory, 2, 0, 1) * :p_exchange_rate) / :round_unit) * :round_unit   osp_cost
,      round(sum(ciqt.rollback_qty * nvl(cict.overhead_cost,0) * decode(sec.asset_inventory, 2, 0, 1) * :p_exchange_rate) / :round_unit) * :round_unit   ovhd_cost
,      round(sum(nvl(ciqt.rollback_qty,0) * nvl(cict.item_cost,0) * decode(sec.asset_inventory,2,0,1) * :p_exchange_rate) / :round_unit)*:round_unit      total_cost
from    mtl_categories_b mc
,       mtl_system_items_vl msi
,       mtl_secondary_inventories sec
,       cst_inv_qty_temp ciqt
,       cst_inv_cost_temp cict
,       mtl_parameters mp
,       cst_item_costs cic
where   sec.organization_id = ciqt.organization_id
and     sec.secondary_inventory_name = ciqt.subinventory_code
and     msi.organization_id = ciqt.organization_id
and     msi.inventory_item_id = ciqt.inventory_item_id
and     mp.organization_id = ciqt.organization_id
and     mc.category_id = ciqt.category_id
and     cict.organization_id = ciqt.organization_id 
and     cict.inventory_item_id = ciqt.inventory_item_id 
and     (cict.cost_group_id = ciqt.cost_group_id or mp.primary_cost_method = 1)
and     cic.organization_id = ciqt.organization_id
and     cic.inventory_item_id = ciqt.inventory_item_id
and     cic.cost_type_id   = cict.cost_type_id
group by ciqt.subinventory_code
,      fnd_flex_xml_publisher_apis.process_kff_combination_1('p_item_seg', 'INV', 'MSTK', 101, msi.organization_id, msi.inventory_item_id, 'ALL', 'Y', 'VALUE')
,      fnd_flex_xml_publisher_apis.process_kff_combination_1('p_cat_seg', 'INV', 'MCAT', mc.structure_id, null, mc.category_id, 'ALL', 'Y', 'VALUE')
,      msi.description
,      msi.primary_uom_code
,      decode(:p_item_revision, 1, ciqt.revision, null)
,      msi.inventory_item_status_code
,      xxen_util.meaning(cict.inventory_asset_flag,'SYS_YES_NO',700)
,      xxen_util.meaning(msi.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700)
,      decode(msi.inventory_planning_code,6, xxen_util.meaning(nvl(msi.mrp_planning_code,6),'MRP_PLANNING_CODE',700), xxen_util.meaning(nvl(msi.inventory_planning_code,6),'MTL_MATERIAL_PLANNING',700))
,      decode(cict.cost_type_id, :p_cost_type_id, ' ', '*')
,      sec.description   
,      sec.asset_inventory 
having decode(&p_neg_qty,1,1,2) =  decode(&p_neg_qty,1,decode(sign(sum(ciqt.rollback_qty)),'-1',1,2),2)
       and  sum(ciqt.rollback_qty) <> 0
order by
&order_by
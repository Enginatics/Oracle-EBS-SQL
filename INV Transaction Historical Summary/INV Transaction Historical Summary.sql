/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Transaction Historical Summary
-- Description: Application: Inventory
Description: Transaction Historical Summary Report

This report provides equivalent functionality to the Oracle standard Transaction historical summary (XML) report.

Templates
Quantity/Value Template ? for use with the Quantity and Value Selection Option
Balance Template ? for use with the Balance Selection Option

The templates provide a summary pivot based on the selected sort option parameter with drill down to the detail data.

Sort Option Category: Pivot by Category, Subinventory/Cost Group
All Others: Pivot by Subinventory/Cost Group, Category

Source: Transaction historical summary (XML)
Short Name: INVTRHAN_XML
DB package: INV_INVTRHAN_XMLP_PKG

-- Excel Examle Output: https://www.enginatics.com/example/inv-transaction-historical-summary/
-- Library Link: https://www.enginatics.com/reports/inv-transaction-historical-summary/
-- Run Report: https://demo.enginatics.com/

select
 :p_org_code organization,
 x.subinventory "Subinventory/Cost Group",
 x.asset_inventory,
 x.category,
 x.item,
 x.item_description,
 x.uom,
 --
 :p_hist_date        rollback_date,
 :p_selection_dsp    report_type,
 case :p_selection
 when '1' then
  inv_invtrhan_xmlp_pkg.c_target_qty_valformula
   (:c_cost_type,
    x.ass_inv,
    x.target_quantity,
    x.current_quantity_value_old,
    inv_invtrhan_xmlp_pkg.cur_qty_valformula(x.ass_inv,x.current_quantity_value_old,x.source_type1,x.source_type2,x.source_type3,x.source_type4,x.other_type),
    x.source_type1,
    x.source_type2,
    x.source_type3,
    x.source_type4,
    x.source_type5,
    x.other_type,
    x.inventory_item_id,
    x.subinventory,
    :c_std_prec
   )
 else
    x.target_quantity
 end "Rollback Date Quantity",
 case :p_selection
 when '1' then x.current_quantity_value_old
 else x.current_quantity
 end "Current Quantity",
 x.change_quantity,
 --
 &lp_template_dummy_columns
 &lp_source_columns
 --
 inv_invtrhan_xmlp_pkg.c_othersformula
  (x.other_type,
   :c_cost_type,
   x.inventory_item_id,
   x.subinventory,
   x.target_quantity,
   x.source_type1,
   x.source_type2,
   x.source_type3,
   x.source_type4,
   :c_std_prec,
   inv_invtrhan_xmlp_pkg.cur_qty_valformula(x.ass_inv,x.current_quantity_value_old,x.source_type1,x.source_type2,x.source_type3,x.source_type4,x.other_type)
  ) other_types,
 --
 case when :p_selection in ('2','3')
 then
  inv_invtrhan_xmlp_pkg.c_target_qty_valformula
   (:c_cost_type,
    x.ass_inv,
    x.target_quantity,
    x.current_quantity_value_old,
    inv_invtrhan_xmlp_pkg.cur_qty_valformula(x.ass_inv,x.current_quantity_value_old,x.source_type1,x.source_type2,x.source_type3,x.source_type4,x.other_type),
    x.source_type1,
    x.source_type2,
    x.source_type3,
    x.source_type4,
    x.source_type5,
    x.other_type,
    x.inventory_item_id,
    x.subinventory,
    :c_std_prec
   )
 end "Rollback Date Value",
 --
 case when :p_selection in ('2','3')
 then inv_invtrhan_xmlp_pkg.cur_qty_valformula(x.ass_inv,x.current_quantity_value_old,x.source_type1,x.source_type2,x.source_type3,x.source_type4,x.other_type)
 end "Current Value",
 --
 inv_invtrhan_xmlp_pkg.c_change_valformula
  (inv_invtrhan_xmlp_pkg.c_target_qty_valformula
    (:c_cost_type,
     x.ass_inv,
     x.target_quantity,
     x.current_quantity_value_old,
     inv_invtrhan_xmlp_pkg.cur_qty_valformula(x.ass_inv,x.current_quantity_value_old,x.source_type1,x.source_type2,x.source_type3,x.source_type4,x.other_type),
     x.source_type1,
     x.source_type2,
     x.source_type3,
     x.source_type4,
     x.source_type5,
     x.other_type,
     x.inventory_item_id,
     x.subinventory,
     :c_std_prec
    ),
   inv_invtrhan_xmlp_pkg.cur_qty_valformula(x.ass_inv,x.current_quantity_value_old,x.source_type1,x.source_type2,x.source_type3,x.source_type4,x.other_type)
  ) "Change Value",
 --
 case :p_sort_id
 when '1' then x.subinventory -- subinventory
 when '2' then x.subinventory -- item
 when '3' then x.category     -- category     
 when '4' then x.subinventory -- costgroup
 end pivot_key1,
 case :p_sort_id
 when '1' then x.category     -- subinventory
 when '2' then x.category     -- item
 when '3' then x.subinventory -- category     
 when '4' then x.category     -- costgroup
 end pivot_key2
from
 (select
   v.subinv subinventory,
   msub.asset_inventory ass_inv,
   xxen_util.meaning(msub.asset_inventory,'SYS_YES_NO',700) asset_inventory,
   mck.concatenated_segments category,
   msiv.concatenated_segments item,
   msiv.description item_description,
   msiv.primary_uom_code uom,
   msiv.inventory_item_id,
   --
   sum(nvl(target_qty,0)) target_quantity,
   sum(nvl(cur_qty,0)) current_quantity,
   inv_invtrhan_xmlp_pkg.c_change_qtyformula(sum(nvl(cur_qty,0)),sum(nvl(target_qty,0))) change_quantity,
   decode(:p_selection,1,sum(nvl(cur_qty_val,0)),round(sum(nvl(cur_qty_val,0)),:c_std_prec)) current_quantity_value_old,
   --
   decode(:p_selection,
          2,decode(:c_cost_type,2,round(sum(nvl(source_type1,0))*v.item_cost,:c_std_prec),round(sum(nvl(source_type1,0)),:c_std_prec)),
          3,round(sum(nvl(source_type1,0)),:c_std_prec),
            sum(nvl(source_type1,0))
         ) source_type1,
   decode(:p_selection,
          2,decode(:c_cost_type,2,round(sum(nvl(source_type2,0))*v.item_cost,:c_std_prec),round(sum(nvl(source_type2,0)),:c_std_prec)),
          3,round(sum(nvl(source_type2,0)),:c_std_prec),
            sum(nvl(source_type2,0))
         ) source_type2,
   decode(:p_selection,
          2,decode(:c_cost_type,2,round(sum(nvl(source_type3,0))*v.item_cost,:c_std_prec),round(sum(nvl(source_type3,0)),:c_std_prec)),
          3,round(sum(nvl(source_type3,0)),:c_std_prec),
            sum(nvl(source_type3,0))
         ) source_type3,
   decode(:p_selection,
          2,decode(:c_cost_type,2,round(sum(nvl(source_type4,0))*v.item_cost,:c_std_prec),round(sum(nvl(source_type4,0)),:c_std_prec)),
          3,round(sum(nvl(source_type4,0)),:c_std_prec),
            sum(nvl(source_type4,0))
         ) source_type4,
   decode(:p_selection,
          2,decode(:c_cost_type,2,round(sum(nvl(source_type5,0))*v.item_cost,:c_std_prec),round(sum(nvl(source_type5,0)),:c_std_prec)),
          3,round(sum(nvl(source_type5,0)),:c_std_prec),
            sum(nvl(source_type5,0))
         ) source_type5,
   decode(:p_selection,
          2,decode(:c_cost_type,2,round(sum(nvl(other,0))*v.item_cost,:c_std_prec),round(sum(nvl(other,0)),:c_std_prec)),
          3,round(sum(nvl(other,0)),:c_std_prec),
            sum(nvl(other,0))
         ) other_type
  from
   mtl_secondary_inventories msub,
   mtl_system_items_vl msiv,
   mtl_item_categories mic,
   mtl_categories_kfv mck,
   &p_view &lp_template_dummy_view v
  where
   v.item_id=msiv.inventory_item_id and
   msub.organization_id=:p_org_id and
   msub.secondary_inventory_name=v.subinv and
   msub.asset_inventory in (1,2) and
   msub.quantity_tracked=1 and
   (:p_selection=1 or :p_selection<>1 and msub.asset_inventory=1) and
   msiv.inventory_item_id = mic.inventory_item_id and 
   mic.category_id = mck.category_id and 
   mic.organization_id = to_char(:p_org_id) and 
   mic.category_set_id = to_char(:p_cat_set_id) and
   msiv.organization_id=:p_org_id and
   decode(:p_selection ,1 ,'N' ,:p_wms_pjm_enabled)='N' and
   1=1
  group by
   v.subinv,
   mck.concatenated_segments,
   msiv.concatenated_segments,
   v.item_cost,
   msiv.description,
   msiv.primary_uom_code,
   msub.asset_inventory,
   xxen_util.meaning(msub.asset_inventory,'SYS_YES_NO',700),
   msiv.inventory_item_id
  union
  select
   ccg.cost_group subinventory,
   0 ass_inv,
   null asset_inventory,
   mck.concatenated_segments category,
   msiv.concatenated_segments item,
   msiv.description item_description,
   msiv.primary_uom_code uom,
   msiv.inventory_item_id item_id,
   --
   sum(ciqt.rollback_qty ) target_quantity,
   sum(decode(ciqt.qty_source,3,ciqt.rollback_qty,4,ciqt.rollback_qty,6,ciqt.rollback_qty,7,ciqt.rollback_qty,0)) current_quantity,
   inv_invtrhan_xmlp_pkg.c_change_qtyformula
    (sum(decode(ciqt.qty_source,3,ciqt.rollback_qty,4,ciqt.rollback_qty,6,ciqt.rollback_qty,7,ciqt.rollback_qty,0)),
     sum(ciqt.rollback_qty)
    ) change_quantity,
   round(sum(ciqt.rollback_qty) * past_cost.item_cost,:c_std_prec) current_quantity_value_old,
   --
   round(sum(decode(ciqt.txn_source_type_id,:p_stype1,nvl(ciqt.rollback_value,0),0)),:c_std_prec) source_type1,
   round(sum(decode(ciqt.txn_source_type_id,:p_stype2,nvl(ciqt.rollback_value,0),0)),:c_std_prec) source_type2,
   round(sum(decode(ciqt.txn_source_type_id,:p_stype3,nvl(ciqt.rollback_value,0),0)),:c_std_prec) source_type3,
   round(sum(decode(ciqt.txn_source_type_id,:p_stype4,nvl(ciqt.rollback_value,0),0)),:c_std_prec) source_type4,
   0 source_type5,
   round(sum(decode(ciqt.qty_source,3 ,ciqt.rollback_qty ,4 ,ciqt.rollback_qty ,6 ,ciqt.rollback_qty ,7 ,ciqt.rollback_qty ,0 ) * current_cost.item_cost),:c_std_prec)
    - round(sum(ciqt.rollback_qty) * past_cost.item_cost,:c_std_prec)
    - round(sum(decode(ciqt.txn_source_type_id,:p_stype1,nvl(ciqt.rollback_value,0),0)),:c_std_prec)
    - round(sum(decode(ciqt.txn_source_type_id,:p_stype2,nvl(ciqt.rollback_value,0),0)),:c_std_prec)
    - round(sum(decode(ciqt.txn_source_type_id,:p_stype3,nvl(ciqt.rollback_value,0),0)),:c_std_prec )
    - round(sum(decode(ciqt.txn_source_type_id,:p_stype4,nvl(ciqt.rollback_value,0),0)),:c_std_prec) other_type
  from
   cst_inv_qty_temp ciqt,
   cst_inv_cost_temp current_cost,
   cst_inv_cost_temp past_cost,
   mtl_system_items_vl msiv,
   mtl_categories_kfv mck,
   cst_cost_groups ccg
  where
   current_cost.organization_id=ciqt.organization_id and
   current_cost.inventory_item_id=ciqt.inventory_item_id and
   current_cost.cost_source=1 and
   past_cost.organization_id=ciqt.organization_id and
   past_cost.inventory_item_id=ciqt.inventory_item_id and
   past_cost.cost_source= 2 and
   msiv.organization_id=ciqt.organization_id and
   msiv.inventory_item_id=ciqt.inventory_item_id and
   mck.category_id=ciqt.category_id and
   ccg.cost_group_id=ciqt.cost_group_id and
   decode(:p_selection ,1 ,'N' ,:p_wms_pjm_enabled)='Y' and
   2=2
  group by
   ccg.cost_group,
   mck.concatenated_segments,
   msiv.concatenated_segments,
   msiv.description,
   msiv.primary_uom_code,
   msiv.inventory_item_id,
   past_cost.item_cost
 ) x
order by
 case :p_sort_id
 when '1' then x.subinventory -- subinventory
 when '2' then null           -- item
 when '3' then x.category     -- category     
 when '4' then x.subinventory -- costgroup
 end,
 case :p_sort_id
 when '1' then x.category     -- subinventory
 when '2' then null           -- item
 when '3' then x.subinventory -- category     
 when '4' then x.category     -- costgroup
 end,
 x.item
/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Lot Transaction Register
-- Description: Imported from BI Publisher
Description: Lot transaction register
Application: Inventory
Source: Lot transaction register (XML)
Short Name: INVTRLNT_XML
DB package: INV_INVTRLNT_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/inv-lot-transaction-register/
-- Library Link: https://www.enginatics.com/reports/inv-lot-transaction-register/
-- Run Report: https://demo.enginatics.com/

with q_body as
(
select
 msi.inventory_item_id break_item_id,
 msi.description break_item_desc,
 mtln.transaction_date txn_date,
 mtln.lot_number lot_number,
 mmt.vendor_lot_number vend_lot,
 mmt.revision rev,
 mtxt.transaction_type_name txn_type_name,
 mtln.transaction_source_id txn_source_id,
 decode(mtln.transaction_source_type_id,
  1, poh.segment1,
  2, null,
  3, null,
  5, wipe.wip_entity_name,
  6, null,
  7, porh.segment1,
  8, mkts.concatenated_segments,
  9, cch.cycle_count_header_name,
  10,mpi.physical_inventory_name,
  11,cupd.description,
  12,mkts.concatenated_segments,
     mtln.transaction_source_name
 ) txn_source_data,
 mmt.subinventory_code subinv,
 sum(decode(:p_rpt_uom,
            1, round(nvl(mtln.transaction_quantity,0),:p_qty_precision),
            2, round(nvl(mtln.primary_quantity,0),:p_qty_precision),
               round(nvl(mtln.transaction_quantity,0),:p_qty_precision)
           )
 ) rpt_qty,
 decode (:p_rpt_uom, 1,mmt.transaction_uom, 2,msi.primary_uom_code, mmt.transaction_uom) uom,
 sum(round((round(nvl(mmt.actual_cost,0),:c_ext_precision) * round(nvl(mtln.primary_quantity,0),:p_qty_precision)),:c_std_precision)) extd_cost,
 mcat.category_id catg_id,
 mtln.transaction_id txn_id,
 mmt.transaction_set_id txn_set_id,
 mtln.created_by txn_create_by1,
 fndu.user_name txn_user_name,
 trunc(mtln.creation_date) txn_create_dt,
 mmt.transaction_reference txn_ref,
 mtr.reason_name reason_name,
 mmt.locator_id locator_id,
 mtln.transaction_source_type_id txn_src_type_id,
 sum(round(nvl(mtln.secondary_transaction_quantity,0), :p_qty_precision)) sec_qty,
 msi.secondary_uom_code,
 mtln.grade_code,
 msi.concatenated_segments c_break_item_value,
 decode(mtln.transaction_source_type_id,
        2, mkts.concatenated_segments,
        3, glcc.concatenated_segments,
        6, mdsp.concatenated_segments,
        8, mkts.concatenated_segments,
        12,mkts.concatenated_segments,
           decode(mtln.transaction_source_type_id,
                  1, poh.segment1,
                  2, null,
                  3, null,
                  5, wipe.wip_entity_name,
                  6, null,
                  7, porh.segment1,
                  8, mkts.concatenated_segments,
                  9, cch.cycle_count_header_name,
                  10,mpi.physical_inventory_name,
                  11,cupd.description,
                  12,mkts.concatenated_segments,
                     mtln.transaction_source_name
                 )
 ) c_txn_src_value,
 inv_invtrlnt_xmlp_pkg.c_secondary_uomformula(msi.inventory_item_id, sum(round(nvl(mtln.secondary_transaction_quantity,0),:p_qty_precision)), msi.secondary_uom_code) c_secondary_uom,
 inv_invtrlnt_xmlp_pkg.calc_unit_cost
  (sum(decode(:p_rpt_uom,
              1, round(nvl(mtln.transaction_quantity,0),:p_qty_precision),
              2, round(nvl(mtln.primary_quantity,0),:p_qty_precision),
                 round(nvl(mtln.transaction_quantity,0),:p_qty_precision)
             )
      ),
   sum(round((round(nvl(mmt.actual_cost,0),:c_ext_precision) * round(nvl(mtln.primary_quantity,0),:p_qty_precision)),:c_std_precision)),
   :c_ext_precision
  ) c_unit_cost,
 mil.concatenated_segments c_locator_value,
 mcat.concatenated_segments c_catg_value,
 inv_invtrlnt_xmlp_pkg.cp_sec_qty_p cp_sec_qty
from
 mtl_transaction_lot_numbers mtln,
 mtl_system_items_vl msi,
 mtl_material_transactions mmt,
 mtl_transaction_types mtxt,
 mtl_transaction_reasons mtr,
 mtl_item_categories micat,
 mtl_item_locations_kfv mil,
 mtl_categories_kfv mcat,
 fnd_user fndu,
 po_headers_all poh,
 mtl_sales_orders_kfv mkts,
 gl_code_combinations_kfv glcc,
 wip_entities wipe,
 mtl_generic_dispositions_kfv mdsp,
 cst_cost_updates cupd,
 mtl_cycle_count_headers cch,
 mtl_physical_inventories mpi,
 po_requisition_headers_all porh
where
 1=1 and
 mmt.reason_id = mtr.reason_id (+) and
 mtln.created_by = fndu.user_id (+) and
 mmt.transaction_type_id = mtxt.transaction_type_id (+) and
 mmt.locator_id = mil.inventory_location_id (+) and
 mmt.organization_id = mil.organization_id(+) and
 mtln.transaction_source_type_id != 11 and
 mtln.transaction_source_id = poh.po_header_id (+) and
 mtln.transaction_source_id = mkts.sales_order_id (+) and
 mtln.transaction_source_id = glcc.code_combination_id (+) and
 mtln.transaction_source_id = wipe.wip_entity_id (+) and
 mtln.organization_id = wipe.organization_id (+) and
 mtln.transaction_source_id = mdsp.disposition_id (+) and
 mtln.transaction_source_id = porh.requisition_header_id (+) and
 mtln.transaction_source_id = cch.cycle_count_header_id (+) and
 mtln.organization_id = cch.organization_id (+) and
 mtln.transaction_source_id = mpi.physical_inventory_id (+) and
 mtln.organization_id = mpi.organization_id (+) and
 mtln.transaction_source_id = cupd.cost_update_id (+) and
 mtln.organization_id = cupd.organization_id (+) and
 mtln.inventory_item_id = msi.inventory_item_id and
 mtln.organization_id = msi.organization_id and
 micat.category_id = mcat.category_id and
 mtln.inventory_item_id = micat.inventory_item_id and
 micat.category_set_id = :p_catg_set_id and
 mtln.organization_id = micat.organization_id and
 mtln.transaction_id = mmt.transaction_id and
 mtln.transaction_date >= :p_txn_date_lo and
 mtln.transaction_date < :p_txn_date_hi+1 and
 mtln.organization_id = :p_org
group by
 msi.inventory_item_id,
 msi.description,
 mtln.transaction_date,
 mtln.lot_number,
 mmt.vendor_lot_number,
 mmt.revision,
 mtxt.transaction_type_name,
 mtln.transaction_source_id,
 decode(mtln.transaction_source_type_id,
        1, poh.segment1,
        2, null,
        3, null,
        5, wipe.wip_entity_name,
        6, null,
        7, porh.segment1,
        8, mkts.concatenated_segments,
        9, cch.cycle_count_header_name,
        10,mpi.physical_inventory_name,
        11,cupd.description,
        12,mkts.concatenated_segments,
           mtln.transaction_source_name
 ),
 mmt.subinventory_code,
 decode (:p_rpt_uom, 1,mmt.transaction_uom, 2,msi.primary_uom_code, mmt.transaction_uom),
 mcat.category_id,
 null,
 mtln.transaction_id,
 mmt.transaction_set_id,
 mtln.created_by,
 fndu.user_name,
 trunc(mtln.creation_date),
 mmt.transaction_reference,
 mtr.reason_name,
 mmt.locator_id,
 mtln.transaction_source_type_id,
 msi.secondary_uom_code,
 mtln.grade_code,
 msi.concatenated_segments,
 decode(mtln.transaction_source_type_id,
        2, mkts.concatenated_segments,
        3, glcc.concatenated_segments,
        6, mdsp.concatenated_segments,
        8, mkts.concatenated_segments,
        12,mkts.concatenated_segments,
           decode(mtln.transaction_source_type_id,
                  1, poh.segment1,
                  2, null,
                  3, null,
                  5, wipe.wip_entity_name,
                  6, null,
                  7, porh.segment1,
                  8, mkts.concatenated_segments,
                  9, cch.cycle_count_header_name,
                  10,mpi.physical_inventory_name,
                  11,cupd.description,
                  12,mkts.concatenated_segments,
                     mtln.transaction_source_name
                 )
 ),
 mil.concatenated_segments,
 mcat.concatenated_segments
),
q_serial as
(
select
 mtln.transaction_id  mtln_txn_id,
 mtln.lot_number mtln_lot_number,
 mut.serial_number serial_number
from
 mtl_transaction_lot_numbers mtln,
 mtl_unit_transactions mut
where
 mtln.serial_transaction_id = mut.transaction_id(+) and
 :p_serial_detail = 1
)
--
-- Main Query starts here
--
select
qb.c_break_item_value item,
qb.break_item_desc item_description,
qb.lot_number lot_number,
qb.vend_lot vendor_lot,
qb.txn_date,
qb.rev,
qb.txn_type_name transaction_type,
qb.c_txn_src_value transaction_source,
qb.subinv subinventory,
case when 1 = row_number() over (partition by qb.break_item_id,qb.lot_number,qb.txn_id order by qs.serial_number)
then qb.rpt_qty
else null
end quantity,
case when 1 = row_number() over (partition by qb.break_item_id,qb.lot_number,qb.txn_id order by qs.serial_number)
then qb.uom
else null
end uom,
case when 1 = row_number() over (partition by qb.break_item_id,qb.lot_number,qb.txn_id order by qs.serial_number)
then qb.cp_sec_qty
else null
end secondary_quantity,
case when 1 = row_number() over (partition by qb.break_item_id,qb.lot_number,qb.txn_id order by qs.serial_number)
then qb.c_secondary_uom
else null
end secondary_uom,
case when 1 = row_number() over (partition by qb.break_item_id,qb.lot_number,qb.txn_id order by qs.serial_number)
then qb.c_unit_cost
else null
end unit_cost,
case when 1 = row_number() over (partition by qb.break_item_id,qb.lot_number,qb.txn_id order by qs.serial_number)
then qb.extd_cost
else null
end value,
-- audit detail
qb.txn_set_id,
qb.txn_id transaction_number,
qb.txn_user_name created_by,
qb.txn_create_dt creation_date,
-- reason detail
qb.txn_ref reference,
qb.reason_name reason,
-- location detail
qb.grade_code grade,
qb.c_locator_value locator,
-- category
(select mcs.category_set_name from mtl_category_sets mcs where mcs.category_set_id = :p_catg_set_id) category_set,
qb.c_catg_value category,
-- serial_number detail
qs.serial_number
from
q_body qb,
q_serial qs
where
 qb.txn_id = qs.mtln_txn_id (+) and
 qb.lot_number = qs.mtln_lot_number (+)
order by
 qb.c_break_item_value,
 qb.lot_number,
 qb.txn_date,
 qb.txn_id,
 qs.serial_number
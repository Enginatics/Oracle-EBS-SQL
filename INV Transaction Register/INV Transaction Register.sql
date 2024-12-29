/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Transaction Register
-- Description: Imported from BI Publisher
Description: Transaction register
Application: Inventory
Source: Transaction register (XML)
Short Name: INVTRREG_XML
DB package: INV_INVTRREG_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/inv-transaction-register/
-- Library Link: https://www.enginatics.com/reports/inv-transaction-register/
-- Run Report: https://demo.enginatics.com/

select /*+ push_pred(mut2) */
oav.organization_name organization,
oav.organization_code,
trunc(mmt.transaction_date) transaction_date,
mmt.transaction_id,
msi.concatenated_segments item,
msi.description item_description,
:p_catg_set_name category_set,
mcat.concatenated_segments category,
mmt.revision  revision,
mmt.subinventory_code subinventory,
mil.concatenated_segments locator,
mtxt.transaction_type_name transaction_type,
mtst.transaction_source_type_name transaction_source_type,
decode(mmt.transaction_source_type_id,
  1,poh.segment1,
  2,mkts.concatenated_segments,
  3,glc.concatenated_segments,
  4,mtrh.request_number,
  5,wipe.wip_entity_name,
  6,mdsp.concatenated_segments,
  7,porh.segment1,
  8,mkts.concatenated_segments,
  9,cch.cycle_count_header_name,
 10,mpi.physical_inventory_name,
 11,cupd.description,
 12,mkts.concatenated_segments,
    mmt.transaction_source_name
)  transaction_source,
poh.comments po_description,
mmt.transaction_reference,
mtr.reason_name reason,
decode(:p_rpt_uom,
 1,mmt.transaction_uom,
 2,msi.primary_uom_code
) uom,
case when row_number() over (partition by mmt.transaction_id order by mmt.transaction_id) = 1
then decode(:p_rpt_uom,
      1,round(nvl(mmt.transaction_quantity,0),:p_qty_precision),
      2,round(nvl(mmt.primary_quantity,0),:p_qty_precision),
        round(nvl(mmt.transaction_quantity,0),:p_qty_precision)
     )
end quantity,
case when row_number() over (partition by mmt.transaction_id order by mmt.transaction_id) = 1 then round((nvl(mmt.actual_cost,0) * nvl(mmt.primary_quantity,0)),nvl(fndc.precision,0)) end total_value,
case when row_number() over (partition by mmt.transaction_id order by mmt.transaction_id) = 1
then inv_invtrreg_xmlp_pkg.calc_unit_cost
     ( decode(:p_rpt_uom,1,nvl(mmt.transaction_quantity,0),2,nvl(mmt.primary_quantity,0),nvl(mmt.transaction_quantity,0))
     , nvl(mmt.actual_cost,0) * nvl(mmt.primary_quantity,0)
     , nvl(fndc.extended_precision,0)
     )
end unit_cost,
case when row_number() over (partition by mmt.transaction_id order by mmt.transaction_id) = 1 then decode(msi.tracking_quantity_ind,'PS',mmt.secondary_uom_code) end sec_uom,
case when row_number() over (partition by mmt.transaction_id order by mmt.transaction_id) = 1 then decode(msi.tracking_quantity_ind,'PS',round(nvl(mmt.secondary_transaction_quantity,0),:p_qty_precision)) end sec_qty,
decode(:p_lot_detail,1,nvl(mtln.lot_number,mut2.lot_number)) lot_number,
decode(:p_lot_detail,1,nvl(mtln.grade_code,mut2.grade_code)) grade_code,
decode(:p_serial_detail,1,nvl(mut.serial_number,mut2.serial_number)) serial_number,
fndu.user_name created_by,
mmt.creation_date creation_date,
mmt.transaction_date transaction_date_time,
case when row_number() over (partition by mmt.transaction_id order by mmt.transaction_id) = 1
then decode(:p_rpt_uom,
      1,nvl(mmt.transaction_quantity,0),
      2,nvl(mmt.primary_quantity,0),
        nvl(mmt.transaction_quantity,0)
     )
end unrounded_quantity,
case when row_number() over (partition by mmt.transaction_id order by mmt.transaction_id) = 1 then nvl(mmt.actual_cost,0) * nvl(mmt.primary_quantity,0) end unrounded_value,
mmt.transaction_set_id,
mmt.inventory_item_id,
mcat.category_id,
mmt.transaction_source_type_id,
mmt.transaction_source_id,
mmt.locator_id,
row_number() over (partition by mmt.transaction_id order by mmt.transaction_id) trx_seq
from
org_access_view              oav,
mtl_system_items_vl          msi,
mtl_transaction_types        mtxt,
mtl_transaction_reasons      mtr,
mtl_item_categories          micat,
mtl_item_locations_kfv       mil,
mtl_categories_kfv           mcat,
mtl_material_transactions    mmt,
fnd_user                     fndu,
po_headers_all               poh,
mtl_sales_orders_kfv         mkts,
gl_code_combinations_kfv     glc,
wip_entities                 wipe,
mtl_generic_dispositions_kfv mdsp,
cst_cost_updates             cupd,
mtl_cycle_count_headers      cch,
mtl_physical_inventories     mpi,
po_requisition_headers_all   porh,
mtl_txn_request_headers      mtrh,
mtl_txn_source_types         mtst,
gl_sets_of_books             gsob,
fnd_currencies               fndc,
mtl_transaction_lot_numbers  mtln,
mtl_unit_transactions        mut,
(select
 mtln.transaction_id,
 mtln.lot_number,
 mtln.grade_code,
 mut.serial_number
 from
 mtl_transaction_lot_numbers  mtln,
 mtl_unit_transactions        mut
 where
     mtln.serial_transaction_id = mut.transaction_id (+)
 and :p_serial_detail = 1
) mut2
where 1=1
and oav.organization_id = mmt.organization_id
and oav.responsibility_id = fnd_global.resp_id
and oav.resp_application_id = fnd_global.resp_appl_id
and mmt.reason_id = mtr.reason_id (+)
and mmt.created_by = fndu.user_id (+)
and mmt.transaction_type_id = mtxt.transaction_type_id
and mmt.locator_id = mil.inventory_location_id (+)
and mmt.organization_id = mil.organization_id(+)
and mmt.transaction_source_type_id != 11
and (mmt.transaction_source_type_id != 13 or mmt.transaction_type_id != 80)
and mmt.transaction_source_type_id = mtst.transaction_source_type_id
and case when :p_lot_detail = 1 and :p_serial_detail = 2 then mmt.transaction_id else null end = mtln.transaction_id (+)
and case when :p_serial_detail = 1 then mmt.transaction_id else null end = mut.transaction_id (+)
and case when :p_serial_detail = 1 then mmt.transaction_id else null end = mut2.transaction_id (+)
and case when mmt.transaction_source_type_id = 1 then mmt.transaction_source_id else null end = poh.po_header_id (+)
and case when mmt.transaction_source_type_id in (2,8,12) then mmt.transaction_source_id else null end = mkts.sales_order_id (+)
and case when mmt.transaction_source_type_id = 3 then mmt.transaction_source_id else null end = glc.code_combination_id (+)
and case when mmt.transaction_source_type_id = 5 then mmt.transaction_source_id else null end = wipe.wip_entity_id (+)
and case when mmt.transaction_source_type_id = 5 then mmt.organization_id else null end = wipe.organization_id (+)
and case when mmt.transaction_source_type_id = 6 then mmt.transaction_source_id else null end = mdsp.disposition_id (+)
and case when mmt.transaction_source_type_id = 7 then mmt.transaction_source_id else null end = porh.requisition_header_id (+)
and case when mmt.transaction_source_type_id = 9 then mmt.transaction_source_id else null end = cch.cycle_count_header_id (+)
and case when mmt.transaction_source_type_id = 9 then mmt.organization_id else null end = cch.organization_id (+)
and case when mmt.transaction_source_type_id = 4 then mmt.transaction_source_id else null end = mtrh.header_id(+)
and case when mmt.transaction_source_type_id = 10 then mmt.transaction_source_id else null end = mpi.physical_inventory_id (+)
and case when mmt.transaction_source_type_id = 10 then mmt.organization_id else null end = mpi.organization_id (+)
and case when mmt.transaction_source_type_id = 11 then mmt.transaction_source_id else null end = cupd.cost_update_id (+)
and case when mmt.transaction_source_type_id = 11 then mmt.organization_id else null end = cupd.organization_id (+)
and mmt.inventory_item_id = msi.inventory_item_id
and mmt.organization_id = msi.organization_id
and micat.category_id = mcat.category_id
and mmt.inventory_item_id = micat.inventory_item_id
and micat.category_set_id = :p_catg_set_id
and mmt.organization_id = micat.organization_id
and oav.set_of_books_id = gsob.set_of_books_id
and gsob.currency_code = fndc.currency_code
and mmt.transaction_date >= :p_txn_date_lo
and mmt.transaction_date < :p_txn_date_hi+1
and nvl(mmt.logical_transaction,2) = 2
order by
organization_name,
transaction_date,
transaction_id,
trx_seq
/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Material Transactions
-- Description: Inventory material transactions
-- Excel Examle Output: https://www.enginatics.com/example/inv-material-transactions/
-- Library Link: https://www.enginatics.com/reports/inv-material-transactions/
-- Run Report: https://demo.enginatics.com/

select
mp.organization_code org,
xxen_util.client_time(mmt.transaction_date) transaction_date,
msiv.concatenated_segments item,
msiv.description item_desc,
mmt.transaction_quantity,
mmt.transaction_uom,
mmt.primary_quantity,
mmt.secondary_transaction_quantity secondary_quantity,
mmt.secondary_uom_code secondary_uom,
mmt.subinventory_code subinventory,
inv_project.get_locator(mmt.locator_id,mmt.organization_id) locator,
decode(inv_check_product_install.check_cse_install,'Y',nvl(hl.clli_code,substr(hl.city,1,10)||substr(hl.location_id,1,10)),substr(hl.city,1,10)||substr(hl.location_id,1,10)) location,
mmt.revision,
&lot_columns
mmt.transfer_subinventory,
inv_project.get_locator(mmt.transfer_locator_id,mmt.transfer_organization_id) transfer_locator,
mp2.organization_code transfer_org,
mp3.organization_code||'-'||haouv3.name owning_party,
mp4.organization_code||'-'||haouv4.name planning_party,
mtst.transaction_source_type_name source_type,
case
when mmt.transaction_source_type_id=6 then mgd.segment1 --Account Alias
when mmt.transaction_source_type_id in (2,8,12) then mso.segment1||'.'||mso.segment2||'.'||mso.segment3 --Sales Order, Internal Order, RMA
when mmt.transaction_source_type_id=11 then ccu.description --Cost Update
when mmt.transaction_source_type_id=9 then mcch.cycle_count_header_name --Cycle Count
when mmt.transaction_source_type_id=3 then gcck.concatenated_segments --Account
when mmt.transaction_source_type_id=13 or mmt.transaction_source_type_id>100 then mmt.transaction_source_name --Inventory
when mmt.transaction_source_type_id=10 then mpi.physical_inventory_name --Physical Inventory
when mmt.transaction_source_type_id=1 then pha.segment1 --PO
when mmt.transaction_source_type_id=16 then okhab.contract_number --Project Contracts
when mmt.transaction_source_type_id=7 then prha.segment1 --Requisition
when mmt.transaction_source_type_id=5 then we.wip_entity_name --WIP Job or Schedule
when mmt.transaction_source_type_id=4 then mtrh.request_number --Move Order
end source,
mtt.transaction_type_name transaction_type,
xxen_util.meaning(mmt.transaction_action_id,'MTL_TRANSACTION_ACTION',700) transaction_action,
mtr.reason_name reason,
mtr.description reason_description,
mmt.source_line_id,
mmt.transaction_id,
mmt.rcv_transaction_id receiving_transaction_id,
xxen_util.user_name(mmt.created_by) created_by,
xxen_util.client_time(mmt.creation_date) creation_date,
sum(mmt.transaction_quantity) over (partition by mmt.inventory_item_id order by mmt.transaction_date,mmt.transaction_id) sum_transaction_quantity
from
mtl_parameters mp,
mtl_material_transactions mmt,
mtl_transaction_types mtt,
mtl_txn_source_types mtst,
mtl_system_items_vl msiv,
mtl_parameters mp2,
hz_locations hl,
mtl_parameters mp3,
mtl_parameters mp4,
hr_all_organization_units_vl haouv3,
hr_all_organization_units_vl haouv4,
mtl_transaction_reasons mtr,
mtl_generic_dispositions mgd,
mtl_sales_orders mso,
cst_cost_updates ccu,
mtl_cycle_count_headers mcch,
gl_code_combinations_kfv gcck,
mtl_physical_inventories mpi,
po_headers_all pha,
okc_k_headers_all_b okhab,
po_requisition_headers_all prha,
wip_entities we,
&xrrpv_table
mtl_txn_request_headers mtrh,
(select mtln.* from mtl_transaction_lot_numbers mtln where '&show_lots'='Y') mtln
where
1=1 and
mp.organization_id=mmt.organization_id and
mmt.transaction_type_id=mtt.transaction_type_id and
mmt.transaction_source_type_id=mtst.transaction_source_type_id(+) and
mmt.organization_id=msiv.organization_id(+) and
mmt.inventory_item_id=msiv.inventory_item_id(+) and
mmt.transfer_organization_id=mp2.organization_id(+) and
mmt.ship_to_location_id=hl.location_id(+) and
mmt.owning_organization_id=mp3.organization_id(+) and
mmt.owning_organization_id=haouv3.organization_id(+) and
mmt.planning_organization_id=mp4.organization_id(+) and
mmt.planning_organization_id=haouv4.organization_id(+) and
mmt.reason_id=mtr.reason_id(+) and
decode(mmt.transaction_source_type_id,6,mmt.transaction_source_id)=mgd.disposition_id(+) and
decode(mmt.transaction_source_type_id,6,mmt.organization_id)=mgd.organization_id(+) and
case when mmt.transaction_source_type_id in (2,8,12) then mmt.transaction_source_id end=mso.sales_order_id(+) and
decode(mmt.transaction_source_type_id,11,mmt.transaction_source_id)=ccu.cost_update_id(+) and
decode(mmt.transaction_source_type_id,9,mmt.transaction_source_id)=mcch.cycle_count_header_id(+) and
decode(mmt.transaction_source_type_id,3,mmt.transaction_source_id)=gcck.code_combination_id(+) and
decode(mmt.transaction_source_type_id,10,mmt.transaction_source_id)=mpi.physical_inventory_id(+) and
decode(mmt.transaction_source_type_id,10,mmt.organization_id)=mpi.organization_id(+) and
decode(mmt.transaction_source_type_id,1,mmt.transaction_source_id)=pha.po_header_id(+) and
decode(mmt.transaction_source_type_id,16,mmt.transaction_source_id)=okhab.id(+) and
decode(mmt.transaction_source_type_id,7,mmt.transaction_source_id)=prha.requisition_header_id(+) and
decode(mmt.transaction_source_type_id,5,mmt.transaction_source_id)=we.wip_entity_id(+) and
decode(mmt.transaction_source_type_id,4,mmt.transaction_source_id)=mtrh.header_id(+) and
mmt.transaction_id=mtln.transaction_id(+)
order by
mp.organization_code,
msiv.concatenated_segments,
mmt.transaction_date desc,
mmt.transaction_id desc
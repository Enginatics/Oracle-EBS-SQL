/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Onhand Quantities
-- Description: Detail report inventory item quantities by org, sub inventory, location, unit of measure, quantity on hand, quantity reserved, quantity unpacked, lot number, lot expiration, planning information, serial control, availability type, date received, list price, min / max and safety stock.
-- Excel Examle Output: https://www.enginatics.com/example/inv-onhand-quantities/
-- Library Link: https://www.enginatics.com/reports/inv-onhand-quantities/
-- Run Report: https://demo.enginatics.com/

select distinct
ood.organization_name,
ood.organization_code,
msi.secondary_inventory_name subinventory,
xxen_util.meaning(nvl(msi.subinventory_type, 1),'MTL_SUB_TYPES',700) subinventory_type,
inv_project.get_locator(moqd.locator_id,moqd.organization_id) locator,
xxen_util.meaning(mil.inventory_location_type,'MTL_LOCATOR_TYPES',700) locator_type,
mmsv.status_code status,
msiv.concatenated_segments item,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
mck.concatenated_segments item_category,
mck.segment1 item_category1,
mck.segment2 item_category2,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy,
moqd.revision,
muot.unit_of_measure_tl unit_of_measure,
sum(moqd.primary_transaction_quantity) over (partition by moqd.organization_id, moqd.inventory_item_id, moqd.revision, moqd.lot_number, moqd.cost_group_id, moqd.subinventory_code, moqd.locator_id, moqd.lpn_id, moqd.project_id, moqd.task_id, moqd.owning_tp_type, moqd.owning_organization_id, moqd.planning_tp_type, moqd.planning_organization_id) on_hand,
cic.cost_type,
cic.item_cost,
round(sum(moqd.primary_transaction_quantity * nvl(cic.item_cost,0)) over (partition by moqd.organization_id, moqd.inventory_item_id, moqd.revision, moqd.lot_number, moqd.cost_group_id, moqd.subinventory_code, moqd.locator_id, moqd.lpn_id, moqd.project_id, moqd.task_id, moqd.owning_tp_type, moqd.owning_organization_id, moqd.planning_tp_type, moqd.planning_organization_id),2) on_hand_value,
mr.reserved,
sum(decode(moqd.containerized_flag,1,0,moqd.primary_transaction_quantity)) over (partition by moqd.organization_id, moqd.inventory_item_id, moqd.revision, moqd.lot_number, moqd.cost_group_id, moqd.subinventory_code, moqd.locator_id, moqd.lpn_id, moqd.project_id, moqd.task_id, moqd.owning_tp_type, moqd.owning_organization_id, moqd.planning_tp_type, moqd.planning_organization_id) unpacked,
sum(decode(moqd.containerized_flag,1,moqd.primary_transaction_quantity,0)) over (partition by moqd.organization_id, moqd.inventory_item_id, moqd.revision, moqd.lot_number, moqd.cost_group_id, moqd.subinventory_code, moqd.locator_id, moqd.lpn_id, moqd.project_id, moqd.task_id, moqd.owning_tp_type, moqd.owning_organization_id, moqd.planning_tp_type, moqd.planning_organization_id) packed,
wlpn.license_plate_number,
moqd.lot_number,
mln.expiration_date lot_expiration_date,
ccg.cost_group,
ppa.project_number project,
pt.task_number task,
xxen_util.meaning(moqd.owning_tp_type,'MTL_TP_TYPES',3) owning_tp_type,
aps.vendor_name||nvl2(assa.vendor_site_code,'-',null)||assa.vendor_site_code owning_party,
xxen_util.meaning(moqd.planning_tp_type,'MTL_TP_TYPES',3) planning_tp_type,
decode(moqd.planning_tp_type,2,mp2.organization_code,1,assa2.vendor_site_code,moqd.planning_organization_id) planning_org,
nvl(xxen_util.meaning(msiv.serial_number_control_code,'CSP_INV_ITEM_SERIAL_CONTROL',0),xxen_util.meaning(msiv.serial_number_control_code,'MTL_SERIAL_NUMBER',700)) serial_control,
xxen_util.meaning(msiv.lot_control_code,'MTL_LOT_CONTROL',700) lot_control,
xxen_util.meaning(msi.availability_type,'MTL_AVAILABILITY',700) availability_type,
max(moqd.date_received) over (partition by moqd.organization_id, moqd.inventory_item_id, moqd.revision, moqd.lot_number, moqd.cost_group_id, moqd.subinventory_code, moqd.locator_id, moqd.lpn_id, moqd.project_id, moqd.task_id, moqd.owning_tp_type, moqd.owning_organization_id, moqd.planning_tp_type, moqd.planning_organization_id) date_received,
msiv.list_price_per_unit,
msiv.min_minmax_quantity,
msiv.max_minmax_quantity,
(select distinct max(mss.safety_stock_quantity) keep (dense_rank last order by mss.effectivity_date) over (partition by mss.organization_id,mss.inventory_item_id) safety_stock from mtl_safety_stocks mss where moqd.organization_id=mss.organization_id and moqd.inventory_item_id=mss.inventory_item_id and mss.effectivity_date<=sysdate) safety_stock,
moqd.inventory_item_id,
moqd.organization_id,
moqd.subinventory_code,
sum(moqd.primary_transaction_quantity) over (partition by moqd.inventory_item_id) on_hand_sum,
round(sum(moqd.primary_transaction_quantity * nvl(cic.item_cost,0)) over (partition by moqd.inventory_item_id),2) on_hand_value_sum,
mmt.stock_out_3m,
mmt.stock_out_6m,
mmt.stock_out_12m,
mmt.stock_out_24m,
mmt.stock_out_36m,
mmt.stock_in_3m,
mmt.stock_in_6m,
mmt.stock_in_12m,
mmt.stock_in_24m,
mmt.stock_in_36m,
mmt.stock_mvmt_3m,
mmt.stock_mvmt_6m,
mmt.stock_mvmt_12m,
mmt.stock_mvmt_24m,
mmt.stock_mvmt_36m,
mmt.stock_out_3m   *  nvl(cic.item_cost,0) value_out_3m,
mmt.stock_out_6m   *  nvl(cic.item_cost,0) value_out_6m,
mmt.stock_out_12m  *  nvl(cic.item_cost,0) value_out_12m,
mmt.stock_out_24m  *  nvl(cic.item_cost,0) value_out_24m,
mmt.stock_out_36m  *  nvl(cic.item_cost,0) value_out_36m,
mmt.stock_out_3m   *  nvl(cic.item_cost,0) value_in_3m,
mmt.stock_out_6m   *  nvl(cic.item_cost,0) value_in_6m,
mmt.stock_out_12m  *  nvl(cic.item_cost,0) value_in_12m,
mmt.stock_out_24m  *  nvl(cic.item_cost,0) value_in_24m,
mmt.stock_out_36m  *  nvl(cic.item_cost,0) value_in_36m,
mmt.stock_mvmt_3m  *  nvl(cic.item_cost,0) value_mvmt_3m,
mmt.stock_mvmt_6m  *  nvl(cic.item_cost,0) value_mvmt_6m,
mmt.stock_mvmt_12m *  nvl(cic.item_cost,0) value_mvmt_12m,
mmt.stock_mvmt_24m *  nvl(cic.item_cost,0) value_mvmt_24m,
mmt.stock_mvmt_36m *  nvl(cic.item_cost,0) value_mvmt_36m
from
org_organization_definitions ood,
mtl_onhand_quantities_detail moqd,
mtl_secondary_inventories msi,
mtl_item_locations mil,
mtl_material_statuses_vl mmsv,
wms_license_plate_numbers wlpn,
mtl_category_sets mcs,
mtl_item_categories mic,
mtl_categories_kfv mck,
mtl_system_items_vl msiv,
mtl_units_of_measure_tl muot,
ap_supplier_sites_all assa,
ap_suppliers aps,
mtl_parameters mp2,
ap_supplier_sites_all assa2,
mtl_lot_numbers mln,
cst_cost_groups ccg,
(
select ppa.project_id, ppa.segment1 project_number from pa_projects_all ppa union
select psm.project_id, psm.project_number from pjm_seiban_numbers psm
) ppa,
pa_tasks pt,
(
select distinct
sum(mr.primary_reservation_quantity) over (partition by mr.inventory_item_id, mr.organization_id, mr.subinventory_code) reserved,
mr.inventory_item_id,
mr.organization_id,
mr.subinventory_code
from
mtl_reservations mr
) mr,
(
select
sum(case when mmt.transaction_action_id in (1,21) and mmt.transaction_date>add_months(sysdate,-3) then nvl(mtln.primary_quantity,mmt.primary_quantity) end) stock_out_3m,
sum(case when mmt.transaction_action_id in (1,21) and mmt.transaction_date>add_months(sysdate,-6) and mmt.transaction_date<=add_months(sysdate,-3) then nvl(mtln.primary_quantity,mmt.primary_quantity) end) stock_out_6m,
sum(case when mmt.transaction_action_id in (1,21) and mmt.transaction_date>add_months(sysdate,-12) and mmt.transaction_date<=add_months(sysdate,-6) then nvl(mtln.primary_quantity,mmt.primary_quantity) end) stock_out_12m,
sum(case when mmt.transaction_action_id in (1,21) and mmt.transaction_date>add_months(sysdate,-24) and mmt.transaction_date<=add_months(sysdate,-12) then nvl(mtln.primary_quantity,mmt.primary_quantity) end) stock_out_24m,
sum(case when mmt.transaction_action_id in (1,21) and mmt.transaction_date>add_months(sysdate,-36) and mmt.transaction_date<=add_months(sysdate,-24) then nvl(mtln.primary_quantity,mmt.primary_quantity) end) stock_out_36m,
sum(case when mmt.transaction_action_id in (27) and mmt.transaction_date>add_months(sysdate,-3) then nvl(mtln.primary_quantity,mmt.primary_quantity) end) stock_in_3m,
sum(case when mmt.transaction_action_id in (27) and mmt.transaction_date>add_months(sysdate,-6) and mmt.transaction_date<=add_months(sysdate,-3) then nvl(mtln.primary_quantity,mmt.primary_quantity) end) stock_in_6m,
sum(case when mmt.transaction_action_id in (27) and mmt.transaction_date>add_months(sysdate,-12) and mmt.transaction_date<=add_months(sysdate,-6) then nvl(mtln.primary_quantity,mmt.primary_quantity) end) stock_in_12m,
sum(case when mmt.transaction_action_id in (27) and mmt.transaction_date>add_months(sysdate,-24) and mmt.transaction_date<=add_months(sysdate,-12) then nvl(mtln.primary_quantity,mmt.primary_quantity) end) stock_in_24m,
sum(case when mmt.transaction_action_id in (27) and mmt.transaction_date>add_months(sysdate,-36) and mmt.transaction_date<=add_months(sysdate,-24) then nvl(mtln.primary_quantity,mmt.primary_quantity) end) stock_in_36m,
sum(case when mmt.transaction_date>add_months(sysdate,-3) then nvl(mtln.primary_quantity,mmt.primary_quantity) end) stock_mvmt_3m,
sum(case when mmt.transaction_date>add_months(sysdate,-6) and mmt.transaction_date<=add_months(sysdate,-3) then nvl(mtln.primary_quantity,mmt.primary_quantity) end) stock_mvmt_6m,
sum(case when mmt.transaction_date>add_months(sysdate,-12) and mmt.transaction_date<=add_months(sysdate,-6) then nvl(mtln.primary_quantity,mmt.primary_quantity) end) stock_mvmt_12m,
sum(case when mmt.transaction_date>add_months(sysdate,-24) and mmt.transaction_date<=add_months(sysdate,-12) then nvl(mtln.primary_quantity,mmt.primary_quantity) end) stock_mvmt_24m,
sum(case when mmt.transaction_date>add_months(sysdate,-36) and mmt.transaction_date<=add_months(sysdate,-24) then nvl(mtln.primary_quantity,mmt.primary_quantity) end) stock_mvmt_36m,
mmt.inventory_item_id,
mmt.organization_id,
mmt.subinventory_code,
mmt.revision,
mmt.cost_group_id,
mmt.locator_id,
mmt.lpn_id,
mmt.project_id,
mmt.task_id,
mmt.owning_tp_type,
mmt.owning_organization_id,
mmt.planning_tp_type,
mmt.planning_organization_id,
mtln.lot_number
from
mtl_material_transactions mmt,
mtl_transaction_lot_numbers mtln
where
'&p_show_trx_hist'='Y' and
mmt.transaction_id=mtln.transaction_id(+) and
mmt.transaction_action_id in (1,21,27) and
mmt.transaction_date>add_months(sysdate,-36)
group by
mmt.inventory_item_id,
mmt.organization_id,
mmt.subinventory_code,
mmt.revision,
mmt.cost_group_id,
mmt.locator_id,
mmt.lpn_id,
mmt.project_id,
mmt.task_id,
mmt.owning_tp_type,
mmt.owning_organization_id,
mmt.planning_tp_type,
mmt.planning_organization_id,
mtln.lot_number
) mmt,
(
select
cic.organization_id,
cic.inventory_item_id,
cct.cost_type,
cic.item_cost
from
mtl_parameters mp,
cst_cost_types cct,
cst_item_costs cic
where
cic.organization_id=mp.organization_id and
cic.cost_type_id=mp.primary_cost_method and
cic.cost_type_id=cct.cost_type_id
) cic
where
1=1 and
ood.organization_id=moqd.organization_id and
moqd.organization_id=msi.organization_id(+) and
moqd.subinventory_code=msi.secondary_inventory_name(+) and
moqd.organization_id=mil.organization_id(+) and
moqd.locator_id=mil.inventory_location_id(+) and
mil.status_id=mmsv.status_id(+) and
moqd.lpn_id=wlpn.lpn_id(+) and
mcs.category_set_name=nvl(:p_cat_set_name,(select mcsv.category_set_name from mtl_default_category_sets mdcs, mtl_category_sets_v mcsv where mdcs.functional_area_id=1 and mdcs.category_set_id=mcsv.category_set_id)) and
mcs.category_set_id=mic.category_set_id and
moqd.organization_id=mic.organization_id and
moqd.inventory_item_id=mic.inventory_item_id and
mic.category_id=mck.category_id and
moqd.organization_id=msiv.organization_id and
moqd.inventory_item_id=msiv.inventory_item_id and
msiv.primary_uom_code=muot.uom_code(+) and
muot.language(+)=userenv('lang') and
decode(moqd.owning_tp_type,1,moqd.owning_organization_id)=assa.vendor_site_id(+) and
assa.vendor_id=aps.vendor_id(+) and
decode(moqd.planning_tp_type,2,moqd.planning_organization_id)=mp2.organization_id(+) and
decode(moqd.planning_tp_type,1,moqd.planning_organization_id)=assa2.vendor_site_id(+) and
moqd.inventory_item_id=mln.inventory_item_id(+) and
moqd.organization_id=mln.organization_id(+) and
moqd.lot_number=mln.lot_number(+) and
moqd.cost_group_id=ccg.cost_group_id(+) and
moqd.project_id=ppa.project_id(+) and
moqd.task_id=pt.task_id(+) and
moqd.inventory_item_id=mr.inventory_item_id(+) and
moqd.organization_id=mr.organization_id(+) and
moqd.subinventory_code=mr.subinventory_code(+) and
moqd.inventory_item_id=mmt.inventory_item_id(+) and
moqd.organization_id=mmt.organization_id(+) and
moqd.subinventory_code=mmt.subinventory_code(+) and
moqd.cost_group_id=nvl(mmt.cost_group_id(+),-1) and
nvl(moqd.revision,-1)= nvl(mmt.revision(+),-1) and
nvl(moqd.lot_number,'?')=nvl(mmt.lot_number(+),'?') and
nvl(moqd.locator_id,-1)=nvl(mmt.locator_id(+),-1) and
nvl(moqd.lpn_id,-1)=nvl(mmt.lpn_id(+),-1) and
nvl(moqd.project_id,-1)=nvl(mmt.project_id(+),-1) and
nvl(moqd.task_id,-1)=nvl(mmt.task_id(+),-1) and
nvl(moqd.owning_tp_type,-1)=nvl(mmt.owning_tp_type(+),-1) and
nvl(moqd.owning_organization_id,-1)=nvl(mmt.owning_organization_id(+),-1) and
nvl(moqd.planning_tp_type,-1)=nvl(mmt.planning_tp_type(+),-1) and
nvl(moqd.planning_organization_id,-1)=nvl(mmt.planning_organization_id(+),-1) and
moqd.organization_id=cic.organization_id(+)and
moqd.inventory_item_id=cic.inventory_item_id(+)
order by
ood.organization_code,
on_hand_sum desc,
item,
on_hand desc
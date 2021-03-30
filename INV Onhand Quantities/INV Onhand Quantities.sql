/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
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
moqd.revision,
muot.unit_of_measure_tl unit_of_measure,
sum(moqd.primary_transaction_quantity) over (partition by moqd.organization_id, moqd.inventory_item_id, moqd.revision, moqd.lot_number, moqd.cost_group_id, moqd.subinventory_code, moqd.locator_id, moqd.lpn_id, moqd.project_id, moqd.task_id, moqd.owning_tp_type, moqd.owning_organization_id, moqd.planning_tp_type, moqd.planning_organization_id) on_hand,
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
sum(moqd.primary_transaction_quantity) over (partition by moqd.inventory_item_id) on_hand_sum
from
org_organization_definitions ood,
mtl_onhand_quantities_detail moqd,
mtl_secondary_inventories msi,
mtl_item_locations mil,
mtl_material_statuses_vl mmsv,
wms_license_plate_numbers wlpn,
&xrrpv_table
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
) mr
where
1=1 and
ood.organization_id=moqd.organization_id and
moqd.organization_id=msi.organization_id(+) and
moqd.subinventory_code=msi.secondary_inventory_name(+) and
moqd.organization_id=mil.organization_id(+) and
moqd.locator_id=mil.inventory_location_id(+) and
mil.status_id=mmsv.status_id(+) and
moqd.lpn_id=wlpn.lpn_id(+) and
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
moqd.subinventory_code=mr.subinventory_code(+)
order by
ood.organization_code,
on_hand_sum desc,
item,
on_hand desc
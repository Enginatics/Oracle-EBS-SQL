/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: WIP Required Components
-- Description: Detailed project WIP report that lists discrete jobs and required components. The parameter 'Show Shortage List' can be used to show a shortage list of existing discrete jobs (similar to Oracle's 'Discrete Job Shortage Report'. 
 

-- Excel Examle Output: https://www.enginatics.com/example/wip-required-components/
-- Library Link: https://www.enginatics.com/reports/wip-required-components/
-- Run Report: https://demo.enginatics.com/

select
ood.organization_code,
mso.segment1 sales_order,
ppa.segment1 project,
we.wip_entity_name job,
xxen_util.meaning(wdj.status_type,'WIP_JOB_STATUS',700) wip_status,
wl.line_code,
msiv0.concatenated_segments assembly,
msiv0.description assembly_description,
xxen_util.meaning(msiv0.item_type,'ITEM_TYPE',3) assembly_item_type,
bd.department_code department,
bd.description department_desc,
wdj.scheduled_start_date,
wdj.scheduled_completion_date,
wdj.start_quantity job_start_qty,
wsg.schedule_group_name,
wdj.build_sequence,
bcb.item_num item_sequence,
wro.operation_seq_num,
msiv.concatenated_segments component,
msiv.description component_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) component_item_type,
muot.unit_of_measure_tl primary_uom,
-- quantities as per view wip_requirement_operations_v
wro.quantity_per_assembly,
wro.required_quantity,
decode(wro.quantity_issued, 0,to_number(null), wro.quantity_issued) quantity_issued,
decode((wro.required_quantity-wro.quantity_issued),0,
         null,
         decode(sign(wro.required_quantity),-1*sign(wro.quantity_issued),
                (wro.required_quantity - wro.quantity_issued),
                decode(sign(abs(wro.required_quantity) - abs(wro.quantity_issued)),-1,
                       null,
                       (wro.required_quantity-wro.quantity_issued)
                      )
               )
) quantity_open,
decode(wip_picking_pub.quantity_allocated(wro.wip_entity_id, wro.operation_seq_num,wro.organization_id, wro.inventory_item_id, wro.repetitive_schedule_id, wro.quantity_issued),0,
       to_number(null),
       wip_picking_pub.quantity_allocated(wro.wip_entity_id, wro.operation_seq_num,wro.organization_id, wro.inventory_item_id, wro.repetitive_schedule_id, wro.quantity_issued)
) quantity_allocated,
wro.released_quantity quantity_released,
decode(mr.primary_reservation_quantity, 0,null, mr.primary_reservation_quantity) quantity_reserved,
--
moqd.on_hand,
wro.date_required,
xxen_util.meaning(wro.wip_supply_type,'WIP_SUPPLY',700) supply_type,
xxen_util.meaning(msiv.atp_flag,'ATP_FLAG',3) atp_flag,
xxen_util.meaning(wro.mrp_net_flag,'SYS_YES_NO',700) mrp_net_flag,
wro.supply_subinventory supply_subinv,
milk.concatenated_segments supply_locator,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy,
msiv.planner_code planner_code,
mp.description planner,
ppx.full_name buyer,
ood.organization_name organization,
we.wip_entity_id,
wro.inventory_item_id
from
org_organization_definitions ood,
wip_entities we,
mtl_reservations mr,
mtl_sales_orders mso,
wip_discrete_jobs wdj,
wip_lines wl,
mtl_system_items_vl msiv0,
bom_departments bd,
wip_schedule_groups wsg,
pa_projects_all ppa,
wip_requirement_operations wro,
bom_components_b bcb,
mtl_system_items_vl msiv,
mtl_units_of_measure_tl muot,
mtl_item_locations_kfv milk,
mtl_planners mp,
per_people_x ppx,
(
select
sum(moqd.primary_transaction_quantity) on_hand,
moqd.organization_id,
moqd.inventory_item_id
from
mtl_onhand_quantities_detail moqd,
mtl_secondary_inventories msi
where
moqd.subinventory_code=msi.secondary_inventory_name and
moqd.organization_id=msi.organization_id and
msi.availability_type=1
group by
moqd.organization_id,
moqd.inventory_item_id
) moqd
where
1=1 and
we.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
ood.organization_id=we.organization_id and
wro.wip_entity_id=mr.supply_source_header_id(+) and
wro.organization_id=mr.organization_id(+) and
mr.demand_source_type_id(+)=5 and
wro.operation_seq_num=mr.demand_source_line_id(+) and
wro.inventory_item_id=mr.inventory_item_id(+) and
mr.demand_source_header_id=mso.sales_order_id(+) and
we.wip_entity_id=wdj.wip_entity_id and
wdj.line_id=wl.line_id(+) and
wdj.primary_item_id=msiv0.inventory_item_id(+) and
wdj.organization_id=msiv0.organization_id(+) and
wro.department_id=bd.department_id(+) and
wdj.schedule_group_id=wsg.schedule_group_id(+) and
wdj.project_id=ppa.project_id(+) and
wdj.wip_entity_id=wro.wip_entity_id and
wdj.organization_id=wro.organization_id and
wro.component_sequence_id=bcb.component_sequence_id(+) and
wro.inventory_item_id=msiv.inventory_item_id and
wro.organization_id=msiv.organization_id and
msiv.primary_uom_code=muot.uom_code and
muot.language=userenv('lang') and
wro.supply_locator_id=milk.inventory_location_id(+) and
wro.organization_id=milk.organization_id(+) and
msiv.planner_code=mp.planner_code(+) and
msiv.organization_id=mp.organization_id(+) and
msiv.buyer_id=ppx.person_id(+) and
wro.inventory_item_id=moqd.inventory_item_id(+) and
wro.organization_id=moqd.organization_id(+)
order by
ood.organization_code,
we.wip_entity_name,
wro.operation_seq_num,
msiv.concatenated_segments
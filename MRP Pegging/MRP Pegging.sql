/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MRP Pegging
-- Description: Detail report for MRP planning pegging showing the hierarchy from demand, including forecast, sales orders, work order to supply (WIP jobs, purchase orders and on hand stock)
-- Excel Examle Output: https://www.enginatics.com/example/mrp-pegging/
-- Library Link: https://www.enginatics.com/reports/mrp-pegging/
-- Run Report: https://demo.enginatics.com/

select
z.origination_type,
z.demand_number,
z.order_line,
z.ship_set,
z.line_status,
z.demand_description,
z.created_by,
z.project,
z.task,
z.level_,
z.item,
z.item_description,
z.item_type,
z.pegging,
z.planner_code,
z.planner,
z.buyer,
z.end_demand_pegged_qty,
z.demand_quantity,
z.pegged_quantity,
z.uom,
z.plan_demand_date,
z.plan_start_date,
z.plan_supply_date,
z.plan_delay,
z.make_or_buy,
z.supply_quantity,
z.supply_type,
z.supply_number,
z.supply_line,
z.demand_date,
z.supply_date,
z.demand_date-z.supply_date delay,
xxen_util.client_time(z.need_by_date) need_by_date,
xxen_util.client_time(z.promised_date) promised_date,
xxen_util.client_time(z.receipt_date) receipt_date,
z.department_code,
z.operation_sequence,
z.operation_code,
z.operation_description,
z.resource_code,
z.resource_description,
xxen_util.client_time(z.date_last_moved) date_last_moved,
z.in_queue,
z.running,
z.to_move,
z.rejected,
z.scrapped,
z.completed,
z.action,
z.reschedule_date,
z.exception,
z.supplier_name,
z.frozen_cost,
z.pending_cost,
z.on_hand,
z.safety_stock,
z.min_minmax_quantity,
z.forecast,
z.preprocessing_lead_time,
z.cum_manufacturing_lead_time,
z.cumulative_total_lead_time,
z.postprocessing_lead_time,
xxen_util.client_time(z.schedule_ship_date) schedule_ship_date,
z.item_,
z.supply_type_,
z.item_path,
z.item_description_path,
nvl(z.demand_date,z.plan_demand_date) nvl_demand_date,
nvl(z.supply_date,z.plan_supply_date) nvl_supply_date,
z.plan,
z.organization_code,
z.end_pegging_id,
z.pegging_id,
z.prev_pegging_id,
z.inventory_item_id,
z.order_line_id,
z.vendor_id,
z.supply_line_id
from
(
select
max(nvl2(y.prev_pegging_id,null,y.origination_type)) over (partition by y.end_pegging_id) origination_type,
max(nvl2(y.prev_pegging_id,null,y.demand_number)) over (partition by y.end_pegging_id) demand_number,
max(nvl2(y.prev_pegging_id,null,y.order_line)) over (partition by y.end_pegging_id) order_line,
max(nvl2(y.prev_pegging_id,null,y.ship_set)) over (partition by y.end_pegging_id) ship_set,
max(nvl2(y.prev_pegging_id,null,y.line_status)) over (partition by y.end_pegging_id) line_status,
max(nvl2(y.prev_pegging_id,null,y.demand_description)) over (partition by y.end_pegging_id) demand_description,
max(nvl2(y.prev_pegging_id,null,y.created_by)) over (partition by y.end_pegging_id) created_by,
max(nvl2(y.prev_pegging_id,null,y.project)) over (partition by y.end_pegging_id) project,
max(nvl2(y.prev_pegging_id,null,y.task)) over (partition by y.end_pegging_id) task,
y.level_,
y.item,
y.item_description,
y.item_type,
y.pegging,
y.planner_code,
y.planner,
y.buyer,
y.end_demand_pegged_qty,
y.demand_quantity,
y.pegged_quantity,
y.uom,
y.plan_demand_date,
y.plan_start_date,
y.plan_supply_date,
y.plan_delay,
y.make_or_buy,
y.supply_quantity,
y.supply_type,
y.supply_number,
nvl(pla.line_num,prla.line_num) supply_line,
trunc(xxen_util.client_time(y.demand_date)) demand_date,
(
select
bcd1.calendar_date
from
bom_calendar_dates bcd,
bom_calendar_dates bcd1
where
trunc(xxen_util.client_time(coalesce(y.scheduled_completion_date,plla.promised_date,plla.need_by_date,prla.need_by_date)))=bcd.calendar_date and
bcd.next_seq_num+nvl(y.postprocessing_lead_time,0)=bcd1.seq_num and
y.calendar_code=bcd.calendar_code and
y.calendar_code=bcd1.calendar_code and
bcd.exception_set_id=-1 and
bcd1.exception_set_id=-1
) supply_date,
nvl(plla.need_by_date,prla.need_by_date) need_by_date,
plla.promised_date,
(select max(rt.transaction_date) from rcv_transactions rt where plla.line_location_id=rt.po_line_location_id and rt.transaction_type='RECEIVE') receipt_date,
y.department_code,
y.operation_sequence,
y.operation_code,
y.operation_description,
y.resource_code,
y.resource_description,
y.date_last_moved,
y.in_queue,
y.running,
y.to_move,
y.rejected,
y.scrapped,
y.completed,
xxen_util.meaning(y.action_id,'MRP_ACTIONS',700) action,
y.reschedule_date,
y.exception,
aps.vendor_name supplier_name,
y.frozen_cost,
y.pending_cost,
y.on_hand,
y.safety_stock,
y.min_minmax_quantity,
y.forecast,
y.preprocessing_lead_time,
y.cum_manufacturing_lead_time,
y.cumulative_total_lead_time,
y.postprocessing_lead_time,
y.schedule_ship_date,
y.item_,
y.supply_type_,
y.item_path,
y.item_description_path,
y.plan,
y.organization_code,
y.end_pegging_id,
y.pegging_id,
y.prev_pegging_id,
y.inventory_item_id,
y.order_line_id,
y.vendor_id,
y.supply_line_id
from
(
select
nvl2(x.prev_pegging_id,null,xxen_util.meaning(
case when x.demand_id<0 then x.demand_id else mgr.origination_type end,
case when x.demand_id<0 then 'MRP_FLP_SUPPLY_DEMAND_TYPE' else 'MRP_DEMAND_ORIGINATION' end,700)||
nvl2(flv.meaning,'/'||flv.meaning,null)) origination_type,
coalesce(we0.wip_entity_name,mipo0.po_number,to_char(ooha.order_number)) demand_number,
rtrim(oola.line_number||'.'||oola.shipment_number||'.'||oola.option_number||'.'||oola.component_number||'.'||oola.service_number,'.') order_line,
(select os.set_name from oe_sets os where oola.ship_set_id=os.set_id) ship_set,
xxen_util.meaning(oola.flow_status_code,'LINE_FLOW_STATUS',660) line_status,
nvl(ottt.name,msiv0.concatenated_segments||' '||msiv0.description) demand_description,
xxen_util.user_name(nvl(we0.created_by,ooha.created_by)) created_by,
nvl2(x.prev_pegging_id,null,case when x.demand_id in (-1,-3) then mrp_get_project.project(x.project_id) else mrp_get_project.project(mgr.project_id) end) project,
nvl2(x.prev_pegging_id,null,case when x.demand_id in (-1,-3) then mrp_get_project.task(x.task_id) else mrp_get_project.task(mgr.task_id) end) task,
lpad(' ',2*(x.level__-1))||(x.level__-1) level_,
lpad(' ',2*(x.level__-1))||x.item item,
x.item_description,
xxen_util.meaning(x.item_type,'ITEM_TYPE',3) item_type,
xxen_util.meaning(x.end_assembly_pegging_flag,'ASSEMBLY_PEGGING_CODE',0) pegging,
x.planner_code,
mpl.description planner,
(select ppx.full_name from per_people_x ppx where x.buyer_id=ppx.person_id and rownum=1) buyer,
round(nvl(x.allocated_quantity/xxen_util.zero_to_null(x.end_item_usage),0),4) end_demand_pegged_qty,
round(x.demand_quantity,4) demand_quantity,
round(x.allocated_quantity,4) pegged_quantity,
muot.unit_of_measure_tl uom,
x.demand_date plan_demand_date,
mr.new_wip_start_date plan_start_date,
x.supply_date plan_supply_date,
x.demand_date-x.supply_date plan_delay,
xxen_util.meaning(x.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_or_buy,
round(x.supply_quantity,4) supply_quantity,
lpad(' ',2*(x.level__-1))||xxen_util.meaning(x.supply_type,'MRP_ORDER_TYPE',700) supply_type,
nvl(we.wip_entity_name,mipo.po_number) supply_number,
wdj0.scheduled_start_date demand_date,
wdj.scheduled_completion_date,
bd.department_code,
wo.operation_seq_num operation_sequence,
bso.operation_code,
wo.description operation_description,
br.resource_code,
br.description resource_description,
wo.date_last_moved,
wo.in_queue,
wo.running,
wo.to_move,
wo.rejected,
wo.scrapped,
wo.completed,
case
when
x.bom_item_type in (1,2,3,5) or x.base_item_id is not null and mwdo.orders_release_configs='N' or
x.wip_supply_type=6 and mwdo.orders_release_phantoms='N' or
mr.order_type in (14,15,16,17,18,19) or
mr.rescheduled_flag=1 and nvl(mr.release_status,2)=2
then null --None
when mr.disposition_status_type=2 then 1 --Cancel
when mr.new_schedule_date>mr.old_schedule_date then 3 --Reschedule Out
when mr.new_schedule_date<mr.old_schedule_date then 2 --Reschedule In
when mr.order_type=5 then --Planned order
case when nvl(mr.implemented_quantity,0)+nvl(mr.quantity_in_process,0)>=nvl(mr.firm_quantity,mr.new_order_quantity) and nvl(mr.release_status,2)=2 then null --None, planned order has been released
else 4 --Release
end
else
null --None
end action_id,
case when mr.new_schedule_date<>mr.old_schedule_date then decode(x.planning_make_buy_code,1,mr.new_wip_start_date,mr.new_dock_date) end reschedule_date,
(
select distinct
listagg(med.exception_type_meaning,', ') within group (order by med.exception_type_meaning) over ()
from
(
select distinct
med.number1,
med.inventory_item_id,
med.compile_designator,
med.organization_id,
xxen_util.meaning(med.exception_type,'MRP_EXCEPTION_CODE_TYPE',700) exception_type_meaning
from
mrp_exception_details med
where
med.exception_type in (1,2,3,4,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29)
) med
where
x.transaction_id=med.number1 and
x.inventory_item_id=med.inventory_item_id and
x.compile_designator=med.compile_designator and
x.organization_id=med.organization_id
) exception,
cic1.item_cost frozen_cost,
cic3.item_cost pending_cost,
moqd.on_hand,
(select distinct max(mss.safety_stock_quantity) keep (dense_rank last order by mss.effectivity_date) over (partition by mss.organization_id,mss.inventory_item_id) safety_stock from mtl_safety_stocks mss where x.organization_id=mss.organization_id and x.inventory_item_id=mss.inventory_item_id and mss.effectivity_date<=sysdate) safety_stock,
x.min_minmax_quantity,
(
select
sum(mfd.current_forecast_quantity)
from
mrp_forecast_designators mfds,
mrp_forecast_dates mfd
where
x.organization_id=mfds.organization_id and
mfds.forecast_designator=mfd.forecast_designator and
x.organization_id=mfd.organization_id and
x.inventory_item_id=mfd.inventory_item_id
) forecast,
x.preprocessing_lead_time,
x.cum_manufacturing_lead_time,
x.cumulative_total_lead_time,
x.postprocessing_lead_time,
oola.schedule_ship_date,
x.item item_,
xxen_util.meaning(x.supply_type,'MRP_ORDER_TYPE',700) supply_type_,
x.item_path,
x.item_description_path,
x.compile_designator plan,
mp.organization_code,
mp.calendar_code,
x.end_pegging_id,
x.pegging_id,
x.prev_pegging_id,
x.inventory_item_id,
decode(mgr.origination_type,6,mgr.reservation_id) order_line_id,
x.supply_type supply_type_id,
nvl(mipo.vendor_id,msa.vendor_id) vendor_id,
case
when mr.order_type in (1,8) then ( --try to find matching po line_location_id as MRP unfortunately only tracks the line_id, but not line_location_id
select
plla.line_location_id
from
(select count(*) over (partition by plla.po_line_id) dupl_count, plla.* from po_line_locations_all plla) plla
where
mipo.line_id=plla.po_line_id and
(
plla.dupl_count=1 or
mipo.po_uom_delivery_balance=plla.quantity or
mipo.po_uom_delivery_balance=plla.quantity-nvl(plla.quantity_received,0)
) and
rownum=1
)
when mr.order_type in (2,11,12) then mipo.line_id
end supply_line_id
from
(
select
level level__,
msibk.planner_code,
msibk.planning_make_buy_code,
msibk.primary_uom_code,
msibk.item_type,
msibk.end_assembly_pegging_flag,
msibk.bom_item_type,
decode(msibk.min_minmax_quantity,0,to_number(null),msibk.min_minmax_quantity) min_minmax_quantity,
msibk.preprocessing_lead_time,
msibk.cum_manufacturing_lead_time,
msibk.cumulative_total_lead_time,
msibk.postprocessing_lead_time,
msibk.base_item_id,
msibk.wip_supply_type,
msibk.concatenated_segments item,
msit.description item_description,
msibk.buyer_id,
substr(sys_connect_by_path(msibk.concatenated_segments,'-> '),4) item_path,
substr(sys_connect_by_path(replace(msit.description,'-> ','->'),'-> '),4) item_description_path,
mfp.*
from
(
select
mfp.*
from
mrp_full_pegging mfp
where
1=1
) mfp,
&xrrpv_table
mtl_system_items_b_kfv msibk,
mtl_system_items_tl msit
where
mfp.organization_id=msibk.organization_id(+) and
mfp.inventory_item_id=msibk.inventory_item_id(+) and
mfp.organization_id=msit.organization_id(+) and
mfp.inventory_item_id=msit.inventory_item_id(+) and
msit.language(+)=userenv('lang')
connect by
prior mfp.pegging_id=mfp.prev_pegging_id
start with
2=2 and
mfp.prev_pegging_id is null
) x,
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
) moqd,
(
select
nvl(mwdo.orders_release_phantoms,'N') orders_release_phantoms,
nvl(mwdo.orders_release_configs,'N') orders_release_configs
from
(select fnd_global.user_id user_id from dual) x,
mrp_workbench_display_options mwdo
where
x.user_id=mwdo.user_id(+) and
rownum=1
) mwdo,
(
select
msa.inventory_item_id,
msa.organization_id,
min(msso.vendor_id) vendor_id
from
mrp_sr_assignments msa,
mrp_sr_receipt_org msro,
mrp_sr_source_org msso
where
msa.sourcing_rule_id=msro.sourcing_rule_id and
msa.organization_id=msro.receipt_organization_id and
sysdate between msro.effective_date and nvl(msro.disable_date,sysdate) and
msro.sr_receipt_id=msso.sr_receipt_id and
msso.rank=1
group by
msa.inventory_item_id,
msa.organization_id
) msa,
mtl_units_of_measure_tl muot,
mtl_planners mpl,
fnd_lookup_values flv,
mrp_recommendations mr,
mrp_item_purchase_orders mipo,
wip_entities we,
wip_discrete_jobs wdj,
mrp_gross_requirements mgr,
oe_order_lines_all oola,
oe_order_headers_all ooha,
oe_transaction_types_tl ottt,
wip_entities we0,
wip_discrete_jobs wdj0,
mtl_system_items_vl msiv0,
mrp_item_purchase_orders mipo0,
mtl_parameters mp,
cst_item_costs cic1,
cst_item_costs cic3,
(
select distinct
wo.wip_entity_id,
wo.organization_id,
wo.repetitive_schedule_id,
min(wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) operation_seq_num,
max(wo.department_id) keep (dense_rank first order by wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) department_id,
max(wo.standard_operation_id) keep (dense_rank first order by wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) standard_operation_id,
max(wo.description) keep (dense_rank first order by wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) description,
max(wo.date_last_moved) keep (dense_rank first order by wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) date_last_moved,
max(decode(wo.quantity_in_queue,0,null,wo.quantity_in_queue)) keep (dense_rank first order by wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) in_queue,
max(decode(wo.quantity_running,0,null,wo.quantity_running)) keep (dense_rank first order by wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) running,
max(decode(wo.quantity_waiting_to_move,0,null,wo.quantity_waiting_to_move)) keep (dense_rank first order by wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) to_move,
max(decode(wo.quantity_rejected,0,null,wo.quantity_rejected)) keep (dense_rank first order by wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) rejected,
max(decode(wo.quantity_scrapped,0,null,wo.quantity_scrapped)) keep (dense_rank first order by wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) scrapped,
max(decode(wo.quantity_completed,0,null,wo.quantity_completed)) keep (dense_rank first order by wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) completed
from
wip_operations wo
where
wo.quantity_in_queue>0 or wo.quantity_running>0 or wo.quantity_waiting_to_move>0
) wo,
bom_departments bd,
(select bso.* from bom_standard_operations bso where nvl(bso.operation_type,1)=1 and bso.line_id is null) bso,
(
select distinct
wor.organization_id,
wor.wip_entity_id,
wor.operation_seq_num,
max(wor.resource_id) keep (dense_rank first order by wor.resource_seq_num) over (partition by wor.wip_entity_id, wor.organization_id, wor.operation_seq_num, wor.repetitive_schedule_id) resource_id
from
wip_operation_resources wor
) wor,
bom_resources br
where
x.organization_id=moqd.organization_id(+) and
x.inventory_item_id=moqd.inventory_item_id(+) and
case when x.planning_make_buy_code=2 and x.supply_type=5 then x.organization_id end=msa.organization_id(+) and
case when x.planning_make_buy_code=2 and x.supply_type=5 then x.inventory_item_id end=msa.inventory_item_id(+) and
x.primary_uom_code=muot.uom_code(+) and
muot.language(+)=userenv('lang') and
x.planner_code=mpl.planner_code(+) and
x.organization_id=mpl.organization_id(+) and
case when x.demand_id=-1 and x.prev_pegging_id is null then to_char(case when x.supply_type in (10,13) then 5 else x.supply_type end) end=flv.lookup_code(+) and
flv.lookup_type(+) in ('MRP_FLP_SUPPLY_DEMAND_TYPE','MRP_ORDER_TYPE') and
flv.language(+)=userenv('lang') and
flv.view_application_id(+)=700 and
flv.security_group_id(+)=0 and
not (flv.lookup_code(+)='18' and flv.lookup_type(+)='MRP_FLP_SUPPLY_DEMAND_TYPE') and
x.transaction_id=mr.transaction_id(+) and
case when mr.order_type in (1,2,8,11,12) then mr.disposition_id end=mipo.transaction_id(+) and
case when mr.order_type in (3,7,14,15,27,28) then mr.disposition_id end=we.wip_entity_id(+) and
we.wip_entity_id=wdj.wip_entity_id(+) and
we.organization_id=wdj.organization_id(+) and
x.demand_id=mgr.demand_id(+) and
decode(mgr.origination_type,6,mgr.reservation_id)=oola.line_id(+) and
oola.header_id=ooha.header_id(+) and
ooha.order_type_id=ottt.transaction_type_id(+) and
ottt.language(+)=userenv('lang') and
case when mgr.origination_type in (2,3,17,25,26) then mgr.disposition_id end=we0.wip_entity_id(+) and
we0.wip_entity_id=wdj0.wip_entity_id(+) and
we0.organization_id=wdj0.organization_id(+) and
we0.primary_item_id=msiv0.inventory_item_id(+) and
we0.organization_id=msiv0.organization_id(+) and
case when mgr.origination_type in (18,19,20,23,24) then mgr.disposition_id end=mipo0.transaction_id(+) and
x.organization_id=mp.organization_id(+) and
x.organization_id=cic1.organization_id(+) and
x.organization_id=cic3.organization_id(+) and
x.inventory_item_id=cic1.inventory_item_id(+) and
x.inventory_item_id=cic3.inventory_item_id(+) and
cic1.cost_type_id(+)=1 and
cic3.cost_type_id(+)=3 and
we.wip_entity_id=wo.wip_entity_id(+) and
we.organization_id=wo.organization_id(+) and
wo.department_id=bd.department_id(+) and
wo.standard_operation_id=bso.standard_operation_id(+) and
wo.wip_entity_id=wor.wip_entity_id(+) and
wo.organization_id=wor.organization_id(+) and
wo.operation_seq_num=wor.operation_seq_num(+) and
wor.resource_id=br.resource_id(+)
) y,
po_line_locations_all plla,
po_lines_all pla,
po_requisition_lines_all prla,
ap_suppliers aps
where
case when y.supply_type_id in (1,8) then y.supply_line_id end=plla.line_location_id(+) and
plla.po_line_id=pla.po_line_id(+) and
decode(y.supply_type_id,2,y.supply_line_id)=prla.requisition_line_id(+) and
y.vendor_id=aps.vendor_id(+)
) z
where
3=3
order by
organization_code,
plan,
origination_type,
demand_number,
end_pegging_id,
item_path
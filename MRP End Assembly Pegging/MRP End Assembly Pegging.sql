/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MRP End Assembly Pegging
-- Description: Detail report for MRP pegging from final assembly to each component, including: planner, end demand pegged qty, demand and plan dates, supply quantity, and supply date.
-- Excel Examle Output: https://www.enginatics.com/example/mrp-end-assembly-pegging/
-- Library Link: https://www.enginatics.com/reports/mrp-end-assembly-pegging/
-- Run Report: https://demo.enginatics.com/

select
xxen_util.meaning(
case when mfp0.demand_id<0 then mfp0.demand_id else mgr.origination_type end,
case when mfp0.demand_id<0 then 'MRP_FLP_SUPPLY_DEMAND_TYPE' else 'MRP_DEMAND_ORIGINATION' end,700)||
nvl2(flv.meaning,'/'||flv.meaning,null) origination_type,
coalesce(we0.wip_entity_name,mipo0.po_number,to_char(ooha.order_number)) demand_number,
rtrim(oola.line_number||'.'||oola.shipment_number||'.'||oola.option_number||'.'||oola.component_number||'.'||oola.service_number,'.') order_line,
(select os.set_name from oe_sets os where oola.ship_set_id=os.set_id) ship_set,
xxen_util.meaning(oola.flow_status_code,'LINE_FLOW_STATUS',660) line_status,
nvl(ottt.name,msiv0.concatenated_segments||' '||msiv0.description) demand_description,
xxen_util.user_name(nvl(we0.created_by,ooha.created_by)) created_by,
case when mfp0.demand_id in (-1,-3) then mrp_get_project.project(mfp0.project_id) else mrp_get_project.project(mgr.project_id) end project,
case when mfp0.demand_id in (-1,-3) then mrp_get_project.task(mfp0.task_id) else mrp_get_project.task(mgr.task_id) end task,
msiv0.concatenated_segments end_asembly,
msiv0.description end_asembly_description,
msiv1.concatenated_segments component,
msiv1.description component_description,
xxen_util.meaning(msiv1.item_type,'ITEM_TYPE',3) item_type,
xxen_util.meaning(msiv1.end_assembly_pegging_flag,'ASSEMBLY_PEGGING_CODE',0) pegging,
msiv1.planner_code,
mpl.description planner,
ppx.full_name buyer,
round(nvl(mfp1.allocated_quantity/xxen_util.zero_to_null(mfp1.end_item_usage),0),4) end_demand_pegged_qty,
round(mfp1.demand_quantity,4) demand_quantity,
round(mfp1.allocated_quantity,4) pegged_quantity,
muot.unit_of_measure_tl uom,
mfp1.demand_date plan_demand_date,
mr.new_wip_start_date plan_start_date,
mfp1.supply_date plan_supply_date,
mfp1.demand_date-mfp1.supply_date plan_delay,
xxen_util.meaning(msiv1.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_or_buy,
round(mfp1.supply_quantity,4) supply_quantity,
xxen_util.meaning(mfp1.supply_type,'MRP_ORDER_TYPE',700) supply_type,
nvl(we.wip_entity_name,mipo.po_number) supply_number,
wdj0.scheduled_start_date demand_date,
wdj.scheduled_completion_date,
case when mipo.order_type in (1,8)
then
 (select
  pdtav.type_name
  from
  po_headers_all pha,
  po_document_types_all_vl pdtav
  where
  pha.po_header_id=mipo.purchase_order_id and
  pha.type_lookup_code=pdtav.document_subtype and
  pha.org_id=pdtav.org_id and
  pdtav.document_type_code in ('PO','PA')
  )
else null
end po_type,
case when mipo.order_type in (1,8)
then po_headers_sv3.get_po_status(mipo.purchase_order_id) 
else null
end po_status,
case when mipo.order_type in (1,8)
then (select pha.segment1 from po_headers_all pha,po_lines_all pla where pla.po_line_id = mipo.line_id and pha.po_header_id = pla.contract_id) 
else null
end po_contract
from
mtl_parameters mp,
mrp_full_pegging mfp0,
mrp_full_pegging mfp1,
mtl_system_items_vl msiv0,
mtl_system_items_vl msiv1,
mtl_units_of_measure_tl muot,
per_people_x ppx,
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
mrp_item_purchase_orders mipo0
where
1=1 and
mp.organization_code=:organization_code and
mfp0.compile_designator=:compile_designator and
mp.organization_id=mfp0.organization_id and
mfp0.pegging_id=mfp1.end_pegging_id and
mfp1.end_pegging_id<>mfp1.pegging_id and
mfp1.prev_pegging_id is not null and
mfp0.inventory_item_id=msiv0.inventory_item_id and
mfp1.inventory_item_id=msiv1.inventory_item_id and
mfp0.organization_id=msiv0.organization_id and
mfp1.organization_id=msiv1.organization_id and
msiv1.primary_uom_code=muot.uom_code(+) and
muot.language(+)=userenv('lang') and
msiv1.buyer_id=ppx.person_id(+) and
msiv1.planner_code=mpl.planner_code(+) and
msiv1.organization_id=mpl.organization_id(+) and
case when mfp0.demand_id=-1 and mfp0.prev_pegging_id is null then to_char(case when mfp0.supply_type in (10,13) then 5 else mfp0.supply_type end) end=flv.lookup_code(+) and
flv.lookup_type(+) in ('MRP_FLP_SUPPLY_DEMAND_TYPE','MRP_ORDER_TYPE') and
flv.language(+)=userenv('lang') and
flv.view_application_id(+)=700 and
flv.security_group_id(+)=0 and
not (flv.lookup_code(+)='18' and flv.lookup_type(+)='MRP_FLP_SUPPLY_DEMAND_TYPE') and
mfp1.transaction_id=mr.transaction_id(+) and
case when mr.order_type in (1,2,8,11,12) then mr.disposition_id end=mipo.transaction_id(+) and
case when mr.order_type in (3,7,14,15,27,28) then mr.disposition_id end=we.wip_entity_id(+) and
we.wip_entity_id=wdj.wip_entity_id(+) and
we.organization_id=wdj.organization_id(+) and
mfp0.demand_id=mgr.demand_id(+) and
decode(mgr.origination_type,6,mgr.reservation_id)=oola.line_id(+) and
oola.header_id=ooha.header_id(+) and
ooha.order_type_id=ottt.transaction_type_id(+) and
ottt.language(+)=userenv('lang') and
case when mgr.origination_type in (2,3,17,25,26) then mgr.disposition_id end=we0.wip_entity_id(+) and
we0.wip_entity_id=wdj0.wip_entity_id(+) and
we0.organization_id=wdj0.organization_id(+) and
case when mgr.origination_type in (18,19,20,23,24) then mgr.disposition_id end=mipo0.transaction_id(+)
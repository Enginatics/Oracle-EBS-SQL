/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MRP Plan Orders
-- Description: MRP: Export Supply and Demand Orders from the Planners Workbench.

-- Excel Examle Output: https://www.enginatics.com/example/mrp-plan-orders/
-- Library Link: https://www.enginatics.com/reports/mrp-plan-orders/
-- Run Report: https://demo.enginatics.com/

select
mosv.compile_designator plan,
mosv.organization_code organization,
mosv.item_segments item,
mosv.description description,
(select mck.concatenated_segments from mtl_categories_kfv mck where mck.category_id = mosv.category) category,
xxen_util.meaning(decode(mosv.source_table,'MRP_GROSS_REQUIREMENTS','DEMAND','SUPPLY'),'MSC_QUESTION_TYPE',3) supply_demand,
mosv.order_type_text order_type,
mosv.new_due_date suggested_due_date,
mosv.days_from_today,
mosv.quantity_rate,
mosv.order_number,
case
when mosv.source_table = 'MRP_GROSS_REQUIREMENTS'
then
  xxen_util.meaning(5,'MRP_ACTIONS',700)
else
  xxen_util.meaning(
  case
  when mosv.bom_item_type in (1,2,3,5) or
       (mosv.base_item_id is not null and
        mwdo.orders_release_configs  = 'N'
       ) or
       (mosv.wip_supply_type = 6 and
        mwdo.orders_release_phantoms = 'N'
       ) or
       mosv.order_type in (14,15,16,17,18,19) or
       (mosv.rescheduled_flag = 1 and
        nvl(mosv.release_status,2) = 2
       )
  then 6 --none
  when mosv.disposition_status_type = 2 then 1 --cancel
  when mosv.new_due_date > mosv.old_due_date then 3 --reschedule out
  when mosv.new_due_date < mosv.old_due_date then 2 --reschedule in
  when mosv.order_type = 5
  then --planned order
       case
       when nvl(mosv.implemented_quantity,0) + nvl(mosv.quantity_in_process,0) >= nvl(mosv.firm_quantity,mosv.quantity_rate) and  nvl(mosv.release_status,2)=2
       then 6 --none, planned order has been released
       else 4 --release
       end
  else 6 --none
  end,'MRP_ACTIONS',700)
end action,
xxen_util.meaning(nvl2(mosv.firm_date,'Y',null),'YES_NO',0) firm,
mosv.firm_date,
mosv.firm_quantity,
mosv.schedule_compression_days,
mosv.supply_avail_date,
xxen_util.meaning(decode(mosv.release_status,1,'Y',null),'YES_NO',0) selected_for_release,
xxen_util.meaning(decode(mosv.rescheduled_flag,1,'Y',null),'YES_NO',0) rescheduled_flag,
mosv.new_processing_days,
mosv.implement_date,
mosv.implement_quantity_rate implement_quantity,
mosv.implement_as_text implement_as,
(select hl.location_code from hr_locations hl where hl.location_id = mosv.implement_location_id) implement_location,
mosv.quantity_in_process,
mosv.implemented_quantity,
--
mosv.source_organization_code,
mosv.source_vendor_name,
mosv.source_vendor_site_code,
xxen_util.meaning(decode(mosv.in_source_plan,1,'Y',null),'YES_NO',0) in_source_plan,
mosv.source_schedule,
--
(select msiv.concatenated_segments from mtl_system_items_vl msiv where msiv.organization_id = mosv.organization_id and msiv.inventory_item_id = mosv.using_assembly_item_id) using_assembly,
--
mosv.planner_code planner,
mosv.buyer_name buyer,
xxen_util.meaning(mosv.bom_item_type,'BOM_ITEM_TYPE',700) bom_item_type,
xxen_util.meaning(mosv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy,
xxen_util.meaning(decode(mosv.purchasing_enabled_flag,1,'Y',null),'YES_NO',0) purchasable,
xxen_util.meaning(decode(mosv.build_in_wip_flag,1,'Y',null),'YES_NO',0) build_in_wip_flag,
xxen_util.meaning(mosv.wip_supply_type,'WIP_SUPPLY',700) wip_supply_type,
xxen_util.meaning(mosv.mrp_planning_code,'MRP_PLANNING_CODE',700) mrp_planning_method,
xxen_util.meaning(mosv.release_time_fence_code,'MTL_RELEASE_TIME_FENCE',700) release_time_fence,
mosv.planning_group,
--
mosv.alternate_bom_designator,
mosv.alternate_routing_designator,
xxen_util.meaning(decode(mosv.cfm_routing_flag,1,'Y',null),'YES_NO',0) cfm_routing,
--
mosv.project_number,
mosv.task_number,
mosv.unit_number,
--
mosv.old_order_quantity,
mosv.old_due_date,
mosv.old_dock_date,
mosv.new_due_date,
mosv.new_dock_date,
mosv.new_order_date,
mosv.new_start_date,
mosv.first_unit_start_date,
mosv.last_unit_start_date,
mosv.last_unit_completion_date,
--
xxen_util.meaning(decode(mosv.implement_firm,1,'Y',null),'YES_NO',0) implement_firm,
mosv.implement_wip_class_code,
mosv.implement_job_name,
mosv.implement_demand_class,
mosv.implement_alternate_bom,
mosv.implement_build_sequence,
mosv.implement_alternate_routing,
mosv.schedule_group_name wip_schedule_group,
mosv.build_sequence wip_build_sequence,
mosv.line_code wip_line_code,
mosv.implement_alternate_bom,
mosv.implement_alternate_routing,
mrp_get_project.project(mosv.implement_project_id) implement_project,
mrp_get_project.task(mosv.implement_task_id) implement_task,
mosv.implement_unit_number,
mosv.implement_processing_days,
mosv.release_errors,
-- item dff attributes
&lp_item_dff_cols
mosv.transaction_id
from
mrp_orders_sc_v mosv,
( select
  nvl(mwdo.orders_release_phantoms,'N') orders_release_phantoms,
  nvl(mwdo.orders_release_configs,'N') orders_release_configs
  from
  (select fnd_global.user_id user_id from dual) x,
  mrp_workbench_display_options mwdo
  where
  x.user_id = mwdo.user_id(+) and
  rownum=1
) mwdo
where
1=1 and
(mosv.compile_designator,mosv.organization_id) in
(select
 mpsv.compile_designator,mpsv.organization_id
 from
 mrp_plans_sc_v mpsv
 where
 2=2 and
 mpsv.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
 nvl(mpsv.disable_date,sysdate)>=sysdate and
 mpsv.data_completion_date is not null and
 nvl(mpsv.plan_type,mpsv.curr_plan_type) in (1,2,3,4)
)
order by
plan,
organization,
planner,
item,
suggested_due_date,
supply_demand,
order_type,
order_number
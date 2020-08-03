/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MSC Supply and Demand Orders
-- Description: ASCP: Export Supply and Demand Orders from the Planners Workbench.

-- Excel Examle Output: https://www.enginatics.com/example/msc-supply-and-demand-orders/
-- Library Link: https://www.enginatics.com/reports/msc-supply-and-demand-orders/
-- Run Report: https://demo.enginatics.com/

select 
 :instance_code planning_instance,
 mp.compile_designator                           plan_name,
 mov.planner_code                                planner,
 mov.buyer_name                                  buyer_name,
 mov.order_type_text                             order_type,
 mov.item_segments                               product,
 mov.description                                 item_description,
 mov.using_assembly_segments                     using_assembly,
 mov.quantity_rate                               quantity_rate,
 mov.implemented_quantity                        released_qty,
 trunc(mov.new_start_date)                     suggested_plan_date,
 trunc(mov.new_due_date)                       suggested_due_date,
 mov.organization_code                           destination_organization,
 mcs.category_set_name                           category_set,
 mov.category_name                               category,
 mov.source_organization_code                    source_organization,
 mov.supplier_name                               supplier,
 mov.action                                      action_required,
 xxen_util.meaning(mov.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) "Make/Buy",
 mov.intransit_lead_time                         intransit_lt,
 trunc(mov.promise_date)                       promised_arrival_date,
 trunc(mov.need_by_date)                      need_by_date,
 mov.order_number                                order_number,
 trunc(msi.planning_time_fence_date)     planning_time_fence_date,
 msi.fixed_lead_time                             fixed_lt,
 msi.variable_lead_time                          variable_lt,
 msi.preprocessing_lead_time                     pre_processing_lt,
 msi.postprocessing_lead_time                    post_processing_lt,
 msi.full_lead_time                              full_lt,
 mov.days_from_today                             days_from_today,
 mov.schedule_compression_days                   schedule_compression_days,
 mov.organization_code                           inventory_organization,
 mov.subinventory_code                           subinventory,
 decode(mov.release_status
       , 2, null, 1, 'Yes', mov.release_status)  for_release,
 decode(nvl(mov.implemented_quantity, -999)
       , -999, null, 'Released')                 released_status,
 mov.abc_class                                   abc_class,
 mov.supplier_site_code                          source_supplier_site_code,

 mov.reschedule_days                             reschedule_days,
 decode(mov.firm_planned_type
    , 2, null
    , 1, 'Yes'
       ,mov.firm_planned_type)                   firm,
 trunc(mov.firm_date)                               new_firm_date,
 mov.firm_quantity                                  new_firm_quantity,
 mov.demand_priority                             order_priority,
 mov.last_update_date                            last_update_date,
 xxen_util.user_name(mov.last_updated_by)    last_updated_by
from 
 msc_plans         mp,
 msc_orders_v      mov,
 msc_system_items  msi,
 msc_category_sets mcs 
where 
    mp.sr_instance_id     = mov.sr_instance_id
and mp.plan_id            = mov.plan_id
and mov.category_set_id   = mcs.category_set_id
and mov.sr_instance_id    = msi.sr_instance_id
and mov.plan_id           = msi.plan_id
and mov.organization_id   = msi.organization_id
and mov.inventory_item_id = msi.inventory_item_id
&sr_instance_id
and mp.compile_designator = :plan_name
and 1=1
and mcs.category_set_name = :cat_set
order by 
 :instance_code,
 mp.compile_designator,
 mov.planner_code,
 mov.organization_code,
 mov.order_type_text,
 mov.order_number,
 mov.item_segments
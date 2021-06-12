/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MSC Supply and Demand Orders
-- Description: ASCP: Export Supply and Demand Orders from the Planners Workbench.

-- Excel Examle Output: https://www.enginatics.com/example/msc-supply-and-demand-orders/
-- Library Link: https://www.enginatics.com/reports/msc-supply-and-demand-orders/
-- Run Report: https://demo.enginatics.com/

select 
 mai.instance_code                               planning_instance,
 mp.compile_designator                           plan_name,
 mov.planner_code                                planner,
 mov.buyer_name                                  buyer_name,
 mov.order_type_text                             order_type,
 mov.item_segments                               product,
 mov.description                                 item_description,
 mov.using_assembly_segments                     using_assembly,
 mov.quantity_rate                               quantity_rate,
 mov.implemented_quantity                        released_qty,
 trunc(mov.new_start_date)                       suggested_plan_date,
 trunc(mov.new_due_date)                         suggested_due_date,
 mov.organization_code                           destination_organization,
 mcs.category_set_name                           category_set,
 mov.category_name                               category,
 mov.source_organization_code                    source_organization,
 mov.supplier_name                               supplier,
 mov.action                                      action_required,
 msc_get_name.lookup_meaning@A2M_DBLINK('MTL_PLANNING_MAKE_BUY',mov.planning_make_buy_code)  "Make/Buy",
 mov.intransit_lead_time                         intransit_lt,
 trunc(mov.promise_date)                         promised_arrival_date,
 trunc(mov.need_by_date)                         need_by_date,
 mov.order_number                                order_number,
 (select trunc(msi.planning_time_fence_date)
  from   msc_system_items@A2M_DBLINK     msi
  where msi.sr_instance_id    = mov.sr_instance_id
    and msi.plan_id           = mov.plan_id
    and msi.organization_id   = mov.organization_id
    and msi.inventory_item_id = mov.inventory_item_id
 )                                               planning_time_fence_date,
 (select msi.fixed_lead_time
  from   msc_system_items@A2M_DBLINK     msi
  where msi.sr_instance_id    = mov.sr_instance_id
    and msi.plan_id           = mov.plan_id
    and msi.organization_id   = mov.organization_id
    and msi.inventory_item_id = mov.inventory_item_id
 )                                               fixed_lt,
 (select msi.variable_lead_time
  from   msc_system_items@A2M_DBLINK     msi
  where msi.sr_instance_id    = mov.sr_instance_id
    and msi.plan_id           = mov.plan_id
    and msi.organization_id   = mov.organization_id
    and msi.inventory_item_id = mov.inventory_item_id
 )                                               variable_lt,
 (select msi.preprocessing_lead_time
  from   msc_system_items@A2M_DBLINK     msi
  where msi.sr_instance_id    = mov.sr_instance_id
    and msi.plan_id           = mov.plan_id
    and msi.organization_id   = mov.organization_id
    and msi.inventory_item_id = mov.inventory_item_id
 )                                               pre_processing_lt,
 (select msi.postprocessing_lead_time
  from   msc_system_items@A2M_DBLINK     msi
  where msi.sr_instance_id    = mov.sr_instance_id
    and msi.plan_id           = mov.plan_id
    and msi.organization_id   = mov.organization_id
    and msi.inventory_item_id = mov.inventory_item_id
 )                                               post_processing_lt,
 (select msi.full_lead_time
  from   msc_system_items@A2M_DBLINK     msi
  where msi.sr_instance_id    = mov.sr_instance_id
    and msi.plan_id           = mov.plan_id
    and msi.organization_id   = mov.organization_id
    and msi.inventory_item_id = mov.inventory_item_id
 )                                               full_lt,
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
 trunc(mov.firm_date)                            new_firm_date,
 mov.firm_quantity                               new_firm_quantity,
 mov.demand_priority                             order_priority,
 mov.last_update_date                            last_update_date
from 
 msc_apps_instances@A2M_DBLINK   mai,
 msc_plans@A2M_DBLINK            mp,
 msc_orders_v@A2M_DBLINK         mov,
 msc_category_sets@A2M_DBLINK    mcs 
where 
    mai.instance_id       = mp.sr_instance_id 
and mp.sr_instance_id     = mov.sr_instance_id
and mp.plan_id            = mov.plan_id
and mov.category_set_id   = mcs.category_set_id
and mai.instance_code = :p_instance_code
and mp.compile_designator = :p_plan_name
and mcs.category_set_name = :p_cat_set_name
and 1=1
order by 
 mai.instance_code,
 mp.compile_designator,
 mov.planner_code,
 mov.organization_code,
 mov.order_type_text,
 mov.order_number,
 mov.item_segments
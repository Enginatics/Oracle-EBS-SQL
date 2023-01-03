/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MSC Plan Orders
-- Description: ASCP: Export Supply and Demand Orders from the Planners Workbench.

-- Excel Examle Output: https://www.enginatics.com/example/msc-plan-orders/
-- Library Link: https://www.enginatics.com/reports/msc-plan-orders/
-- Run Report: https://demo.enginatics.com/

 select
 mov.instance,
 mov.plan,
 mov.organization,
 mov.subinventory,
 mov.project_number,
 mov.task_number,
 &lp_custom_attributes
 mov.planner,
 mov.buyer_name,
 mov.make_buy,
 mov.item,
 mov.item_description,
 mov.category_set,
 mov.category,
 regexp_substr(mov.category,'[^.]+',1,1) category1,
 regexp_substr(mov.category,'[^.]+',1,2) category2,
 mov.safety_stock,
 --
 mov.suggested_due_date,
 mov.supply_demand,
 mov.order_type,
 mov.order_number,
 --
 mov.suggested_order_date,
 mov.suggested_start_date,
 mov.days_from_today,
 mov.need_by_date,
 mov.promise_date,
 mov.old_due_date,
 mov.old_need_by_date,
 --
 mov.qty,
 mov.released_qty,
 --
 mov.firm,
 mov.firm_date,
 mov.firm_quantity,
 --
 mov.source_organization,
 mov.supplier,
 mov.supplier_site,
 --
 mov.action_required,
 mov.for_release,
 mov.released_status,
 mov.schedule_compression_days,
 mov.reschedule_days,
 --
 mov.order_priority,
 mov.using_assembly,
 --
 mov.intransit_lt,
 mov.planning_time_fence_date,
 mov.fixed_lt,
 mov.variable_lt,
 mov.pre_processing_lt,
 mov.post_processing_lt,
 mov.full_lt,
 mov.abc_class,
 -- item dff attributes
 &lp_item_dff_cols
 --
 -- pegged to order
 --
 nvl(mfpd.allocated_quantity,mfps.allocated_quantity)             peg_allocated_quantity,
 case
 when mfpd.pegging_id is not null then xxen_util.meaning('DEMAND','MSC_QUESTION_TYPE',3)
 when mfps.pegging_id is not null then xxen_util.meaning('SUPPLY','MSC_QUESTION_TYPE',3)
 else null
 end                                                              peg_supply_demand,
 --
 case
 when mfpd.pegging_id is not null
 then
   case when mfpd.demand_id < 0
   then msc_get_name.lookup_meaning&a2m_dblink ('MRP_FLP_SUPPLY_DEMAND_TYPE',mfpd.demand_id)
   else msc_get_name.lookup_meaning&a2m_dblink ('MSC_DEMAND_ORIGINATION',decode(md.origination_type, 70, 50, 92, 50, md.origination_type))
   end
 when mfps.pegging_id is not null
 then
   case
   when mov.plan_type = 8
   then case when ms.order_type = 1  then msc_get_name.lookup_meaning&a2m_dblink ('SRP_CHANGED_ORDER_TYPE', ms.order_type)
             when ms.order_type = 2  and ms.source_organization_id is null then msc_get_name.lookup_meaning&a2m_dblink ('SRP_CHANGED_ORDER_TYPE', ms.order_type)
             when ms.order_type = 2  and ms.source_organization_id is not null then msc_get_name.lookup_meaning&a2m_dblink ('MRP_ORDER_TYPE',53)
             when ms.order_type = 53 then msc_get_name.lookup_meaning&a2m_dblink ('SRP_CHANGED_ORDER_TYPE', ms.order_type)
             else msc_get_name.lookup_meaning&a2m_dblink ('MRP_ORDER_TYPE',case ms.order_type when 92 then 70 else ms.order_type end)
             end
   else msc_get_name.lookup_meaning&a2m_dblink ('MRP_ORDER_TYPE',case ms.order_type when 92 then 70 else ms.order_type end)
   end
 else
   null
 end                                                              peg_order_type,
 case
 when mfpd.pegging_id is not null
 then
   nvl(md.order_number
      ,decode(md.origination_type
             , 1 , to_char(md.disposition_id)
             , 3 , msc_get_name.job_name&a2m_dblink (md.disposition_id, md.plan_id, md.sr_instance_id)
             , 22, to_char(md.disposition_id)
             , 50, msc_get_name.maintenance_plan&a2m_dblink (md.schedule_designator_id)
             , 70, msc_get_name.maintenance_plan&a2m_dblink (md.schedule_designator_id)
             , 92, msc_get_name.maintenance_plan&a2m_dblink (md.schedule_designator_id )
             , 29, decode(md.plan_id
                         ,-11, msc_get_name.designator&a2m_dblink (md.schedule_designator_id)
                             , decode(mov.in_source_plan
                                     ,1,msc_get_name.designator&a2m_dblink (md.schedule_designator_id, md.forecast_set_id )
                                     , msc_get_name.scenario_designator&a2m_dblink (md.forecast_set_id, md.plan_id, md.organization_id, md.sr_instance_id)
                                       || decode(msc_get_name.designator&a2m_dblink (md.schedule_designator_id,md.forecast_set_id )
                                                , null, null
                                                      , '/'||msc_get_name.designator&a2m_dblink (md.schedule_designator_id,md.forecast_set_id )
                                                )
                                     )
                         )
             , 78, to_char(md.disposition_id)
                 , msc_get_name.designator&a2m_dblink (md.schedule_designator_id)
             )
      )
 when mfps.pegging_id is not null
 then
   msc_get_name.supply_order_number&a2m_dblink
    (ms.order_type
    ,ms.order_number
    ,ms.plan_id
    ,ms.sr_instance_id
    ,ms.transaction_id
    ,ms.disposition_id
    )
 else
   null
 end                                                              peg_order_number,
 nvl(-nvl(md.daily_demand_rate,md.using_requirement_quantity)
    ,nvl(ms.daily_rate,ms.new_order_quantity)
    )                                                             peg_order_qty,
 ms.implemented_quantity                                          peg_released_qty,
 trunc(nvl(md.using_assembly_demand_date,ms.new_schedule_date))   peg_suggested_due_date,
 trunc(nvl(ms.new_order_placement_date,ms.firm_date))             peg_suggested_order_date,
 trunc(ms.new_wip_start_date)                                     peg_suggested_start_date,
 case when mfpd.pegging_id is not null
 then
   round(greatest(0,md.using_assembly_demand_date - (trunc(sysdate))),2)
 else
   round(greatest(0,ms.new_order_placement_date - (trunc(sysdate))),2)
 end                                                              peg_days_from_today,
 trunc(ms.need_by_date)                                           peg_need_by_date,
 trunc(nvl(md.promise_date,ms.promised_date))                     peg_promise_date,
 trunc(nvl(md.old_demand_date,ms.old_schedule_date))              peg_old_due_date,
 trunc(decode(ms.order_type,1,ms.old_dock_date,ms.old_need_by_date)) peg_old_need_by_date,
 case
 when mfpd.pegging_id is not null
 then
   decode(md.supply_id
         , null, decode(md.origination_type
                       ,6 , decode(msc_get_name.order_type&a2m_dblink (md.plan_id, md.disposition_id, md.sr_instance_id)
                                 ,2, null
                                   , msc_get_name.org_code&a2m_dblink (md.source_organization_id,md.source_org_instance_id)
                                 )
                       ,30, decode(msc_get_name.order_type&a2m_dblink (md.plan_id, md.disposition_id, md.sr_instance_id), 2, null, msc_get_name.org_code&a2m_dblink (md.source_organization_id,md.source_org_instance_id))
                       ,1 , decode(mov.plan_type, 5, null, msc_get_name.org_code&a2m_dblink (md.source_organization_id, md.source_org_instance_id))
                          , msc_get_name.org_code&a2m_dblink (md.source_organization_id, md.source_org_instance_id)
                       )
               , null
         )
 when mfps.pegging_id is not null
 then
   msc_get_name.org_code&a2m_dblink (ms.source_organization_id,ms.source_sr_instance_id)
 else
   null
 end                                                            peg_source_organization,
 msc_get_name.supplier&a2m_dblink (ms.supplier_id)              peg_supplier,
 msc_get_name.supplier_site&a2m_dblink (ms.supplier_site_id)    peg_supplier_site,
 case
 when mfpd.pegging_id is not null
 then
   msc_get_name.action&a2m_dblink
    ( 'MSC_DEMANDS'
    , mov.plan_type
    , decode(md.plan_id,-1,md.supply_id,md.disposition_id)
    , decode(md.source_org_instance_id,null,md.sr_instance_id,-23453,md.sr_instance_id,md.source_org_instance_id)
    , md.origination_type
    , md.reschedule_flag
    , md.demand_id
    , null
    , null
    , md.sales_order_line_split
    , md.fill_kill_flag
    , null
    , md.inventory_item_id
    , md.prev_subst_item
    , null
    , md.plan_id
    )
 when mfps.pegging_id is not null
 then
   msc_get_name.action&a2m_dblink
    ( 'MSC_SUPPLIES'
    , mov.bom_item_type
    , mov.base_item_id
    , mov.wip_supply_type
    , ms.order_type
    , ms.reschedule_flag
    , ms.disposition_status_type
    , ms.new_schedule_date
    , ms.old_schedule_date
    , ms.implemented_quantity
    , ms.quantity_in_process
    , ms.new_order_quantity
    , mov.release_time_fence_code
    , ms.reschedule_days
    , ms.firm_quantity
    , ms.plan_id
    , mov.critical_component_flag
    , mov.mrp_planning_code
    , mov.lots_exist
    , ms.item_type_value
    , ms.transaction_id
    )
 else
   null
 end                                                              peg_order_action,
 decode(nvl(md.release_status,ms.release_status)
       , 2, null
       , 1, xxen_util.meaning('Y','YES_NO',0)
          , nvl(md.release_status,ms.release_status)
       )                                                          peg_order_for_release,
 decode(nvl(ms.implemented_quantity,-999),-999,null,'Released') peg_order_released_status,
 --
 mov.transaction_id,
 mov.demand_id,
 nvl(mfpd.pegging_id,mfps.pegging_id) pegging_id,
 nvl(mfpd.end_pegging_id,mfps.end_pegging_id) end_pegging_id,
 mfpd.demand_id peg_demand_id,
 mfps.transaction_id peg_transaction_id,
 mov.supply_qty,
 mov.demand_qty,
 mov.abs_qty,
 mov.supply_cnt,
 mov.demand_cnt
from
 (select /*+ push_pred(mov)*/
   nvl(:p_instance_code,mai.instance_code)         instance,
   nvl(:p_plan_name,mov.compile_designator)        plan,
   mov.organization_code                           organization,
   mov.subinventory_code                           subinventory,
   mov.planner_code                                planner,
   mov.buyer_name                                  buyer_name,
   mov.project_number                              project_number,
   mov.task_number                                 task_number,
   --
   msc_get_name.lookup_meaning&a2m_dblink ('MTL_PLANNING_MAKE_BUY',mov.planning_make_buy_code)
                                                   make_buy,
   mov.item_segments                               item,
   mov.description                                 item_description,
   :p_category_set_name                            category_set,
   mov.category_name                               category,
   (select distinct
      max(mss.safety_stock_quantity) keep (dense_rank last order by mss.period_start_date) over (partition by mss.organization_id,mss.inventory_item_id) safety_stock
    from
     msc_safety_stocks&a2m_dblink mss
    where
        mss.sr_instance_id     = mov.sr_instance_id
    and mss.plan_id            = mov.plan_id
    and mss.organization_id    = mov.organization_id
    and mss.inventory_item_id  = mov.inventory_item_id
    and mss.period_start_date <= sysdate
   ) safety_stock,
   --
   trunc(mov.new_due_date)                         suggested_due_date,
   xxen_util.meaning(decode(mov.source_table,'MSC_SUPPLIES','SUPPLY','DEMAND'),'MSC_QUESTION_TYPE',3)
                                                   supply_demand,
   mov.order_type_text                             order_type,
   mov.order_number                                order_number,
   --
   trunc(mov.new_order_date)                       suggested_order_date,
   trunc(mov.new_start_date)                       suggested_start_date,
   mov.days_from_today                             days_from_today,
   trunc(mov.need_by_date)                         need_by_date,
   trunc(mov.promise_date)                         promise_date,
   trunc(mov.old_due_date)                         old_due_date,
   trunc(mov.old_need_by_date)                     old_need_by_date,
   --
   mov.quantity_rate                               qty,
   mov.implemented_quantity                        released_qty,
   --
   decode(mov.firm_planned_type
      , 2, null
      , 1, 'Yes'
         ,mov.firm_planned_type)                   firm,
   trunc(mov.firm_date)                            firm_date,
   mov.firm_quantity                               firm_quantity,
   --
   mov.source_organization_code                    source_organization,
   mov.supplier_name                               supplier,
   mov.supplier_site_code                          supplier_site,
   --
   mov.action                                      action_required,
   decode(mov.release_status
         , 2, null, 1, xxen_util.meaning('Y','YES_NO',0), mov.release_status)
                                                   for_release,
   decode(nvl(mov.implemented_quantity, -999)
         , -999, null, 'Released')                 released_status,
   mov.schedule_compression_days                   schedule_compression_days,
   mov.reschedule_days                             reschedule_days,
   --
   mov.demand_priority                             order_priority,
   mov.using_assembly_segments                     using_assembly,
   --
   mov.intransit_lead_time                         intransit_lt,
   trunc(msi.planning_time_fence_date)             planning_time_fence_date,
   msi.fixed_lead_time                             fixed_lt,
   msi.variable_lead_time                          variable_lt,
   msi.preprocessing_lead_time                     pre_processing_lt,
   msi.postprocessing_lead_time                    post_processing_lt,
   msi.full_lead_time                              full_lt,
   mov.abc_class                                   abc_class,
   decode(mov.source_table,'MSC_SUPPLIES','S','D') s_d_flag,
   decode(mov.source_table,'MSC_SUPPLIES',mov.transaction_id,null)
                                                   transaction_id,
   decode(mov.source_table,'MSC_DEMANDS',mov.transaction_id,null)
                                                   demand_id,
   mov.sr_instance_id,
   mov.plan_id,
   mov.organization_id,
   msi.inventory_item_id,
   msi.sr_inventory_item_id,
   mp.plan_type,
   msi.in_source_plan,
   msi.bom_item_type,
   msi.base_item_id,
   msi.wip_supply_type,
   msi.release_time_fence_code,
   msi.critical_component_flag,
   msi.mrp_planning_code,
   msi.lots_exist,
   --
   case when mov.source_table = 'MSC_SUPPLIES'
   then mov.quantity_rate
   else null
   end                                             supply_qty,
   case when mov.source_table = 'MSC_DEMANDS'
   then -mov.quantity_rate
   else null
   end                                             demand_qty,
   abs(mov.quantity_rate)                          abs_qty,
   case when mov.source_table = 'MSC_SUPPLIES'
   then 1
   else null
   end                                             supply_cnt,
   case when mov.source_table = 'MSC_DEMANDS'
   then 1
   else null
   end                                             demand_cnt   
  from
   msc_orders_v&a2m_dblink          mov,
   msc_apps_instances&a2m_dblink    mai,
   msc_plans&a2m_dblink             mp,
   msc_system_items&a2m_dblink      msi
  where
      mov.sr_instance_id    = mai.instance_id
  and mov.plan_id           = mp.plan_id
  and mov.category_set_id   = nvl(:p_category_set_id,(select mcs.category_set_id from msc_category_sets&a2m_dblink mcs where mcs.sr_instance_id = mov.sr_instance_id and mcs.default_flag = 1))
  and mov.sr_instance_id    = msi.sr_instance_id
  and mov.plan_id           = msi.plan_id
  and mov.organization_id   = msi.organization_id
  and mov.inventory_item_id = msi.inventory_item_id
  and (   (mov.order_type NOT IN ( 18, 6, 7, 30, 31))
        or (mov.order_type IN (18, 6, 7, 30) and mov.quantity_rate <> 0)
        or (mov.order_type = 30 and (mov.fill_kill_flag = 1 or mov.so_line_split =1))
        or (mov.order_type = 31 and mov.quantity <> 0)
      )
  and mov.order_type <> 60
  and 1=1
 ) mov,
 msc_full_pegging&a2m_dblink mfpd,
 msc_demands&a2m_dblink md,
 msc_full_pegging&a2m_dblink mfps,
 msc_supplies&a2m_dblink ms
where
-- demand pegged to supply
    mfpd.sr_instance_id (+) = nvl2(:p_show_pegging,mov.sr_instance_id,null)
and mfpd.plan_id (+) = nvl2(:p_show_pegging,mov.plan_id,null)
and mfpd.transaction_id (+) = nvl2(:p_show_pegging,mov.transaction_id,null)
and md.sr_instance_id (+) = mfpd.sr_instance_id
and md.plan_id (+) = mfpd.plan_id
and md.demand_id (+) = mfpd.demand_id
-- supply pegged to demand
and mfps.sr_instance_id (+) = nvl2(:p_show_pegging,mov.sr_instance_id,null)
and mfps.plan_id (+) = nvl2(:p_show_pegging,mov.plan_id,null)
and mfps.demand_id (+) = nvl2(:p_show_pegging,mov.demand_id,null)
and ms.sr_instance_id (+) = mfps.sr_instance_id
and ms.plan_id (+) = mfps.plan_id
and ms.transaction_id (+) = mfps.transaction_id
--
order by
 instance,
 plan,
 organization,
 planner,
 item,
 suggested_due_date,
 supply_demand,
 order_type,
 order_number
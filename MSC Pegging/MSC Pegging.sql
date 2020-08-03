/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MSC Pegging
-- Description: ASCP: Export Pegging Trees from the Planners Workbench.
-- Excel Examle Output: https://www.enginatics.com/example/msc-pegging/
-- Library Link: https://www.enginatics.com/reports/msc-pegging/
-- Run Report: https://demo.enginatics.com/

select
 :instance_code                     planning_instance,
 mp.compile_designator         plan_name,
 mpo.organization_code         organization_code,
 msi.planner_code,
 msi.buyer_name,
 msi.planning_exception_set,
 msi.item_name item,
 mcs.category_set_name,
 mic.category_name,
 xxen_util.meaning(msi.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) "Make/Buy",
 xxen_util.meaning(ms.order_type,'MRP_ORDER_TYPE',700)                          supply_type,
 msc_get_name.supply_order_number ( ms.order_type ,ms.order_number ,ms.plan_id ,ms.sr_instance_id ,ms.transaction_id ,ms.disposition_id ) order_number,
 msc_get_name.action('MSC_SUPPLIES', msi.bom_item_type, msi.base_item_id, msi.wip_supply_type, ms.order_type, ms.reschedule_flag
                    , ms.disposition_status_type, ms.new_schedule_date, ms.old_schedule_date, ms.implemented_quantity
                    , ms.quantity_in_process, ms.new_order_quantity, msi.release_time_fence_code, ms.reschedule_days, ms.firm_quantity
                    , ms.plan_id, msi.critical_component_flag, msi.mrp_planning_code, msi.lots_exist, ms.item_type_value, ms.transaction_id
                    )                                                                                             action,
 mfp.supply_quantity                                                                                     supply_qty,
 mfp.allocated_quantity                                                                                 allocated_qty,
 round(mfp.allocated_quantity, 1)                                                                   pegged_qty,
 mfp.demand_quantity                                                                                   demand_qty,
 xxen_util.meaning(md.origination_type,'MSC_DEMAND_ORIGINATION',700)    peg_type,
 case when mfp.demand_id < 0
 then xxen_util.meaning(mfp.demand_id,'MRP_FLP_SUPPLY_DEMAND_TYPE',700)
 else null
 end                                                                                                   peg_other,
 nvl(md.order_number,
      decode(md.origination_type
            , 1, to_char(md.disposition_id)
            , 3, msc_get_name.job_name(md.disposition_id, md.plan_id, md.sr_instance_id)
            , 22, to_char(md.disposition_id)
            , 50, msc_get_name.maintenance_plan(md.schedule_designator_id)
            , 70, msc_get_name.maintenance_plan(md.schedule_designator_id)
            , 92, msc_get_name.maintenance_plan(md.schedule_designator_id )
            , 29,decode(md.plan_id
                       , -11, msc_get_name.designator(md.schedule_designator_id)
                            , decode(msi.in_source_plan
                                    ,1,msc_get_name.designator(md.schedule_designator_id, md.forecast_set_id )
                                    , msc_get_name.scenario_designator(md.forecast_set_id, md.plan_id, md.organization_id, md.sr_instance_id)
                                      || decode(msc_get_name.designator(md.schedule_designator_id,md.forecast_set_id )
                                               , null, null
                                                     , '/'||msc_get_name.designator(md.schedule_designator_id,md.forecast_set_id )
                                               )
                                    )
                       )
            , 78, to_char(md.disposition_id)
                , msc_get_name.designator(md.schedule_designator_id)
            )
      ) demand_order_number,
 nvl(md.demand_priority,md2.demand_priority)                                                           demand_priority,
 nvl(trunc(md.using_assembly_demand_date) ,mfp.demand_date)                               demand_date,
 trunc(md.old_demand_date)                                                                                    old_demand_date,
 trunc(ms.new_schedule_date)                                                                                 new_supply_schedule_date,
 trunc(ms.firm_date)                                                                                                firm_supply_date,
 ms.firm_quantity                                                                                                    firm_supply_qty,
 -- prev pegging
 msi2.item_name                                                                                                     using_assembly_item,
 xxen_util.meaning(md2.origination_type,'MSC_DEMAND_ORIGINATION',700)             assembly_peg_type,
 nvl(md2.order_number,
      decode(md2.origination_type
            , 1, to_char(md2.disposition_id)
            , 3, msc_get_name.job_name(md2.disposition_id, md2.plan_id, md2.sr_instance_id)
            , 22, to_char(md2.disposition_id)
            , 50, msc_get_name.maintenance_plan(md2.schedule_designator_id)
            , 70, msc_get_name.maintenance_plan(md2.schedule_designator_id)
            , 92, msc_get_name.maintenance_plan(md2.schedule_designator_id )
            , 29,decode(md2.plan_id
                       , -11, msc_get_name.designator(md2.schedule_designator_id)
                            , decode(msi2.in_source_plan
                                    ,1,msc_get_name.designator(md2.schedule_designator_id, md2.forecast_set_id )
                                    , msc_get_name.scenario_designator(md2.forecast_set_id, md2.plan_id, md2.organization_id, md2.sr_instance_id)
                                      || decode(msc_get_name.designator(md2.schedule_designator_id,md2.forecast_set_id )
                                               , null, null
                                                     , '/'||msc_get_name.designator(md2.schedule_designator_id,md2.forecast_set_id )
                                               )
                                    )
                       )
            , 78, to_char(md2.disposition_id)
                , msc_get_name.designator(md2.schedule_designator_id)
            )
      )                                                                                                assembly_demand_order,
 trunc(md2.using_assembly_demand_date)                                                                 assembly_demand_date,
 md2.request_ship_date                                                                                 assembly_req_ship_date,
 round((md2.dmd_satisfied_date - md2.using_assembly_demand_date), 1)                                   assembly_days_late,
 md2.demand_priority                                                                                   assembly_demand_priority,
 round(mfp2.demand_quantity, 1)                                                                        assembly_demand_qty,
 round(mfp2.allocated_quantity, 1)                                                                     assembly_allocated_qty
from
 msc_plans                   mp,
 msc_plan_organizations      mpo,
 msc_system_items            msi,
 msc_item_categories         mic,
 msc_category_sets           mcs,
 msc_supplies                ms,
 msc_demands                 md,
 msc_full_pegging            mfp,
 --
 msc_full_pegging            mfp2,
 msc_demands                 md2,
 msc_system_items            msi2
 --
where
    mp.sr_instance_id      = mpo.sr_instance_id
and mp.plan_id               = mpo.plan_id
--
and mpo.sr_instance_id     = msi.sr_instance_id
and mpo.plan_id                = msi.plan_id
and mpo.organization_id    = msi.organization_id
--
and msi.sr_instance_id       = mic.sr_instance_id
and msi.organization_id      = mic.organization_id
and msi.inventory_item_id   = mic.inventory_item_id
and mic.sr_instance_id       = mcs.sr_instance_id
and mic.category_set_id     = mcs.category_set_id 
and mcs.category_set_name   = :cat_set
--
and msi.sr_instance_id      = ms.sr_instance_id
and msi.plan_id                 = ms.plan_id
and msi.organization_id     = ms.organization_id
and msi.inventory_item_id  = ms.inventory_item_id
--
and ms.sr_instance_id      = mfp.sr_instance_id
and ms.plan_id                 = mfp.plan_id
and ms.organization_id     = mfp.organization_id
and ms.transaction_id      = mfp.transaction_id
--
and mfp.sr_instance_id    = md.sr_instance_id (+)
and mfp.plan_id               = md.plan_id (+)
and mfp.organization_id   = md.organization_id (+)
and mfp.demand_id         = md.demand_id (+)
--
and mfp.sr_instance_id    = mfp2.sr_instance_id (+)
and mfp.plan_id               = mfp2.plan_id (+)
and mfp.organization_id   = mfp2.organization_id (+)
and mfp.prev_pegging_id  = mfp2.pegging_id (+)
--
and mfp2.sr_instance_id  = md2.sr_instance_id (+)
and mfp2.plan_id             = md2.plan_id (+)
and mfp2.organization_id = md2.organization_id (+)
and mfp2.demand_id       = md2.demand_id (+)
--
and mfp2.sr_instance_id     = msi2.sr_instance_id (+)
and mfp2.plan_id                = msi2.plan_id (+)
and mfp2.organization_id     = msi2.organization_id (+)
and mfp2.inventory_item_id = msi2.inventory_item_id (+)
--
&sr_instance_id
and mp.compile_designator = :plan_name
and 1=1
order by
 :instance_code,
 mp.compile_designator,
 mpo.organization_code,
 msi.item_name
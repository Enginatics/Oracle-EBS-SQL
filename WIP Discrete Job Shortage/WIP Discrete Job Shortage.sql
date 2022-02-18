/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: WIP Discrete Job Shortage
-- Description: WIP report that lists discrete job Open Requirements and/or Shortages.

Report Modes 
==========
The report can be run in the following modes:
1. Open Requirements - Reports all Open Requirements
2. Shortage based on Net QOH - Reports requirements with shortages against Nettable Quantity Onhand
3. Shortage based on QOH - Reports requirements with shortages against Total Quantity Onhand
4. Shortage based on Supply Sub/Loc - Reports requirements with Shortages against Onhand Quantity in the same supply Subinventory/Locator as specified in the job requirement.

Shortages
=======
The report displays the Total Open Requirements, Onhand Supply, and Shortage by Component.Additionally the report includes the cumulative shortage by date required for each component. 

Display Pegged Supply
=================
If the MRP Plan parameter is specified, the report will show any supply that is pegged to the job components by the MRP Plan.

Report Templates
=============
The following templates are available to restrict the report to showing Total Quantity Onhand, Nettable Quantity Onhand, or Subinventory/Locator matched Quantity Onhand.

1. Nettable QOH - Displays Nettable Onhand Quantities only
2. Nettable QOH with Pegged Supply - Displays Nettable Onhand Quantities only and Pegged Supply 
3. Subinventory/Locator Match QOH - Displays Subinventory/Locator Matched Onhand Quantities only
4. Subinventory/Locator Match QOH with Pegged Supply - Displays Subinventory/Locator Matched Onhand Quantities and any Pegged Supply
5. Total QOH - Displays Total (Nettable and Non-Nettable) Onhand Quantities only 
6. Total QOH with Pegged Supply - Displays Total (Nettable and Non-Nettable) Onhand Quantities only and any Pegged Supply  

-- Excel Examle Output: https://www.enginatics.com/example/wip-discrete-job-shortage/
-- Library Link: https://www.enginatics.com/reports/wip-discrete-job-shortage/
-- Run Report: https://demo.enginatics.com/

with wip_detail as
  ( select
      mp.organization_code                           organization_code
    , wdj.organization_id                            organization_id
    , we.wip_entity_name                             job
    , we.wip_entity_id                               job_id
    , we.description                                 job_desc
    , trunc(wdj.scheduled_start_date)                job_scheduled_start
    , trunc(wdj.scheduled_completion_date)           job_scheduled_complete
    , trunc(wdj.date_released)                       job_released_date
    , trunc(wdj.date_completed)                      job_completed_date
    , trunc(wdj.date_closed)                         job_closed_date
    , wdj.start_quantity                             job_start_qty
    , xxen_util.meaning(wdj.job_type
                       ,'WIP_DISCRETE_JOB',700)      job_type
    , xxen_util.meaning(wdj.status_type
                       ,'WIP_JOB_STATUS',700)        job_status
    , ppa.segment1                                   project
    , mso.segment1                                   sales_order_reservation
    , wsg.schedule_group_name                        schedule_group_name
    , wdj.build_sequence                             build_sequence
    , wro.operation_seq_num                          operation_seq_num
    , wl.line_code                                   wip_line_code
    , msiv1.concatenated_segments                    assembly
    , msiv1.description                              assembly_desc
    , xxen_util.meaning(msiv1.item_type
                       ,'ITEM_TYPE',3)               assembly_type
    , (select
         mck.concatenated_segments
       from
         mtl_default_category_sets mdcs
       , mtl_item_categories       mic
       , mtl_categories_kfv        mck
       where
           mdcs.functional_area_id = 5
       and mic.category_set_id     = mdcs.category_set_id
       and mic.organization_id     = wdj.organization_id
       and mic.inventory_item_id   = wdj.primary_item_id
       and mck.category_id         = mic.category_id
       and rownum <= 1
      )                                              assembly_costing_category
    , msiv1.inventory_item_id                        assembly_id
    , trunc(wro.date_required)                       date_required
    , bd.department_code                             department
    , bd.description                                 department_desc
    , bcb.item_num                                   component_seq_num
    , msiv2.concatenated_segments                    component
    , msiv2.description                              component_desc
    , xxen_util.meaning(msiv2.item_type
                       ,'ITEM_TYPE',3)               component_type
    , msiv2.inventory_item_id                        component_id
    , xxen_util.meaning(msiv2.planning_make_buy_code
                       ,'MTL_PLANNING_MAKE_BUY',700) make_or_buy
    , xxen_util.meaning(wro.wip_supply_type
                       ,'WIP_SUPPLY',700)            wip_supply_type
    , xxen_util.meaning(wro.mrp_net_flag
                       ,'SYS_YES_NO',700)            mrp_net_flag
    , msiv2.planner_code                             planner
    , ppx.full_name                                  buyer
    , wro.supply_subinventory                        supply_subinventory
    , milk.concatenated_segments                     supply_locator
    , milk.inventory_location_id                     locator_id
    --
    , msiv2.primary_uom_code                         uom
    , wro.quantity_per_assembly                      wro_qty_per_assembly
    , wro.required_quantity                          wro_qty_required
    , wro.quantity_issued                            wro_qty_issued
    , greatest(wro.required_quantity - wro.quantity_issued,0)
                                                     wro_qty_open
    --
    , nvl(miqv1.quantity,0)                          total_qty
    , nvl(miqv1.nettable_quantity,0)                 net_total_qty
    , nvl(miqv2.quantity,0)                          subloc_total_qty
    from
      mtl_parameters              mp
    , wip_discrete_jobs           wdj
    , wip_entities                we
    , wip_lines                   wl
    , wip_requirement_operations  wro
    , wip_schedule_groups         wsg
    , bom_departments             bd
    , bom_components_b            bcb
    --
    , mtl_system_items_vl         msiv1
    , mtl_system_items_vl         msiv2
    --
    , ( select
          miqv.organization_id
        , miqv.inventory_item_id
        , nvl(sum(miqv.quantity),0) quantity
        , nvl(sum(miqv.quantity * decode(msi.availability_type,1,1,0))
             ,0)                    nettable_quantity
        from
          mtl_item_quantities_view    miqv
        , mtl_secondary_inventories   msi
        where
            msi.organization_id            = miqv.organization_id
        and msi.secondary_inventory_name   = miqv.subinventory_code
        and nvl(msi.disable_date,sysdate) >= sysdate
        group by
          miqv.organization_id
        , miqv.inventory_item_id
      ) miqv1
    , ( select
          miqv.organization_id
        , miqv.inventory_item_id
        , miqv.subinventory_code
        , miqv.locator_id
        , nvl(sum(miqv.quantity),0) quantity
        from
          mtl_item_quantities_view    miqv
        , mtl_secondary_inventories   msi
        where
            msi.organization_id            = miqv.organization_id
        and msi.secondary_inventory_name   = miqv.subinventory_code
        and nvl(msi.disable_date,sysdate) >= sysdate
        group by
          miqv.organization_id
        , miqv.inventory_item_id
        , miqv.subinventory_code
        , miqv.locator_id
      ) miqv2
    , mtl_item_locations_kfv      milk
    , mtl_reservations            mr
    , mtl_sales_orders            mso
    , per_people_x                ppx
    , pa_projects_all             ppa
    where
        2=2
    and wdj.organization_id              = mp.organization_id
    and wdj.status_type                 in (1,3,4,6)
    and we.wip_entity_id                 = wdj.wip_entity_id
    and we.organization_id               = wdj.organization_id
    and we.entity_type                  in (1,5)
    and wl.line_id                   (+) = wdj.line_id
    and wl.organization_id           (+) = wdj.organization_id
    and wro.wip_entity_id                = wdj.wip_entity_id
    and wro.organization_id              = wdj.organization_id
    and wro.wip_supply_type             != 6
    and wro.required_quantity            > 0
    and wsg.organization_id          (+) = wdj.organization_id
    and wsg.schedule_group_id        (+) = wdj.schedule_group_id
    and wro.required_quantity            > wro.quantity_issued
    and bd.organization_id           (+) = wro.organization_id
    and bd.department_id             (+) = wro.department_id
    and bcb.component_sequence_id    (+) = wro.component_sequence_id
    --
    and msiv1.organization_id        (+) = wdj.organization_id
    and msiv1.inventory_item_id      (+) = wdj.primary_item_id
    and msiv2.organization_id            = wro.organization_id
    and msiv2.inventory_item_id          = wro.inventory_item_id
    --
    and miqv1.organization_id        (+) = wro.organization_id
    and miqv1.inventory_item_id      (+) = wro.inventory_item_id
    and miqv2.organization_id        (+) = wro.organization_id
    and miqv2.inventory_item_id      (+) = wro.inventory_item_id
    and miqv2.subinventory_code      (+) = nvl(wro.supply_subinventory,'@@@')
    and nvl(miqv2.locator_id,-1)         = nvl(wro.supply_locator_id,-1)
    --
    and milk.organization_id         (+) = wro.organization_id
    and milk.inventory_location_id   (+) = wro.supply_locator_id
    --
    and mr.supply_source_header_id   (+) = we.wip_entity_id
    and mr.organization_id           (+) = we.organization_id
    and mr.supply_source_type_id     (+) = 5 -- job or schedule
    and mr.demand_source_type_id     (+) = 2 -- sales order
    and mso.sales_order_id           (+) = mr.demand_source_header_id
    --
    and ppx.person_id                (+) = msiv2.buyer_id
    --
    and ppa.project_id               (+) = wdj.project_id
  )
, wip_total as
  ( select
      wro.organization_id
    , wro.inventory_item_id
    , nvl(wro.supply_subinventory,'@@@') supply_subinventory
    , nvl(wro.supply_locator_id,-1)      supply_locator_id
    , sum(wro.required_quantity)
       - sum(wro.quantity_issued)
       &lp_wip_reservations_api_call open_quantity
    from
      wip_requirement_operations wro
    where
        3=3
    and wro.required_quantity > 0
    and wro.required_quantity > wro.quantity_issued
    and (   (    wro.repetitive_schedule_id is null
             and exists
               ( select null
                 from   wip_discrete_jobs wdj
                 where  wdj.wip_entity_id = wro.wip_entity_id
                 and    wdj.organization_id = wro.organization_id
                 and    wdj.status_type in (1,3,4,6)
               )
            )
         or (    wro.repetitive_schedule_id is not null
             and exists
               ( select null
                 from   wip_repetitive_schedules wrs
                 where  wrs.organization_id = wro.organization_id
                 and    wrs.repetitive_schedule_id = wro.repetitive_schedule_id
                 and wrs.status_type in (1,3,4,6)
               )
            )
        )
    group by
      wro.organization_id
    , wro.inventory_item_id
    , nvl(wro.supply_subinventory,'@@@')
    , nvl(wro.supply_locator_id,-1)
  )
, mrp_supply as
  ( select
      mgr.disposition_id
    , mgr.organization_id
    , mgr.inventory_item_id
    , mosv.order_type_text           supply_type
    , mosv.buyer_name                supply_buyer_name
    , mosv.order_number              supply_order_number
    , mosv.source_vendor_name        supply_vendor_name
    , mosv.source_vendor_site_code   supply_vendor_site
    , trunc(mfp.supply_date)         supply_date
    , mfp.supply_quantity            supply_qty
    , mfp.allocated_quantity         allocated_qty
    from
      mrp_gross_requirements mgr
    , mrp_full_pegging       mfp
    , mrp_orders_sc_v        mosv
    where
        mgr.origination_type   in (2,3,17,25,26)
    and mfp.demand_id           = mgr.demand_id
    and mfp.compile_designator  = :p_compile_designator
    and mosv.transaction_id     = mfp.transaction_id
    and mosv.order_type         = mfp.supply_type
    and mosv.source_table       = 'MRP_RECOMMENDATIONS'
  )
--
-- Main Query Starts here
--
select
  wip_dtl.organization_code
, wip_dtl.job
, wip_dtl.job_desc
, wip_dtl.job_scheduled_start
, wip_dtl.job_scheduled_complete
, wip_dtl.job_released_date
, wip_dtl.job_completed_date
, wip_dtl.job_closed_date
, wip_dtl.job_start_qty
, wip_dtl.job_type
, wip_dtl.job_status
, wip_dtl.project
, wip_dtl.sales_order_reservation
, wip_dtl.schedule_group_name
, wip_dtl.build_sequence
, wip_dtl.operation_seq_num
, wip_dtl.wip_line_code
, wip_dtl.assembly
, wip_dtl.assembly_desc
, wip_dtl.assembly_type
, wip_dtl.assembly_costing_category
, wip_dtl.date_required
, wip_dtl.department
, wip_dtl.department_desc
, wip_dtl.component_seq_num
, wip_dtl.component
, wip_dtl.component_desc
, wip_dtl.component_type
, wip_dtl.make_or_buy
, wip_dtl.wip_supply_type
, wip_dtl.mrp_net_flag
, wip_dtl.planner
, wip_dtl.buyer
, wip_dtl.supply_subinventory
, wip_dtl.supply_locator
, wip_dtl.uom
, wip_dtl.wro_qty_per_assembly
, wip_dtl.wro_qty_issued
, wip_dtl.wro_qty_required
, wip_dtl.wro_qty_open
--
, wip_dtl.total_open_qty          component_open_qty
, wip_dtl.total_qty               component_onhand_qty
, wip_dtl.component_short_qty
, wip_dtl.date_req_cum_short_qty
--
, wip_dtl.net_total_qty           component_net_onhand_qty
, wip_dtl.component_net_short_qty
, wip_dtl.date_req_cum_net_short_qty
--
, case when wip_dtl.supply_subinventory is not null
  then    wip_dtl.subloc_total_open_qty
  else null
  end                             sub_loc_open_qty
, case when wip_dtl.supply_subinventory is not null
  then wip_dtl.subloc_total_qty
  else null
  end                             sub_loc_onhand_qty
, case when wip_dtl.supply_subinventory is not null
  then wip_dtl.sub_loc_short_qty
  else null
  end                             sub_loc_short_qty
, case when wip_dtl.supply_subinventory is not null
  then wip_dtl.date_req_cum_sub_loc_short_qty
  else null
  end                             date_req_cum_sub_loc_short_qty
-- mrp pegged suply
, mrp_supply.supply_type
, mrp_supply.supply_buyer_name
, mrp_supply.supply_order_number
, mrp_supply.supply_vendor_name
, mrp_supply.supply_vendor_site
, mrp_supply.supply_date
, mrp_supply.supply_qty
, mrp_supply.allocated_qty
from
  ( select
      wip_dtl2.*
    , wip_dtl2.total_open_qty - wip_dtl2.total_qty  component_short_qty
    , sum(wip_dtl2.wro_qty_open) over (partition by wip_dtl2.organization_code,wip_dtl2.component order by wip_dtl2.date_required,wip_dtl2.job rows between unbounded preceding and current row)
       - wip_dtl2.total_qty date_req_cum_short_qty
    , wip_dtl2.total_open_qty - wip_dtl2.net_total_qty component_net_short_qty
    , sum(wip_dtl2.wro_qty_open) over (partition by wip_dtl2.organization_code,wip_dtl2.component order by wip_dtl2.date_required,wip_dtl2.job rows between unbounded preceding and current row)
       - wip_dtl2.net_total_qty date_req_cum_net_short_qty
    , wip_dtl2.subloc_total_open_qty - wip_dtl2.subloc_total_qty sub_loc_short_qty
    , sum(wip_dtl2.wro_qty_open) over (partition by wip_dtl2.organization_code,wip_dtl2.supply_subinventory,wip_dtl2.supply_locator,wip_dtl2.component order by wip_dtl2.date_required,wip_dtl2.job rows between unbounded preceding and current row)
       - wip_dtl2.subloc_total_qty date_req_cum_sub_loc_short_qty
    from
      ( select
         wip_dtl3.*
       --
       , (select nvl(sum(wip_tot.open_quantity),0)
          from   wip_total wip_tot
          where  wip_tot.organization_id     = wip_dtl3.organization_id
          and    wip_tot.inventory_item_id   = wip_dtl3.component_id
         )   total_open_qty
       , (select nvl(sum(wip_tot.open_quantity),0)
          from   wip_total wip_tot
          where  wip_tot.organization_id     = wip_dtl3.organization_id
          and    wip_tot.inventory_item_id   = wip_dtl3.component_id
          and    wip_tot.supply_subinventory = wip_dtl3.supply_subinventory
          and    wip_tot.supply_locator_id   = nvl(wip_dtl3.locator_id,-1)
         )   subloc_total_open_qty
        from
          wip_detail   wip_dtl3
      ) wip_dtl2
    )           wip_dtl
, mrp_supply
where
    mrp_supply.disposition_id    (+) = wip_dtl.job_id
and mrp_supply.organization_id   (+) = wip_dtl.organization_id
and mrp_supply.inventory_item_id (+) = wip_dtl.component_id
and 1=1
order by
  wip_dtl.organization_code
, wip_dtl.job
, wip_dtl.operation_seq_num
, wip_dtl.component
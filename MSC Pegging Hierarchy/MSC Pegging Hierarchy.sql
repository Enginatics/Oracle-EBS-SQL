/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MSC Pegging Hierarchy
-- Description: ASCP Pegging Hierarchy. This reports shows the pegging hierarchy from the Top Level Demand.
-- Excel Examle Output: https://www.enginatics.com/example/msc-pegging-hierarchy/
-- Library Link: https://www.enginatics.com/reports/msc-pegging-hierarchy/
-- Run Report: https://demo.enginatics.com/

with
q_msc_full_pegging as
(
 select
  level-1 level_,
  rownum seq,
  substr(sys_connect_by_path(msi.item_name,'-> '),4) item_path,
  substr(sys_connect_by_path(replace(msi.description,'-> ','->'),'-> '),4) item_description_path,
  msi.item_name,
  msi.description item_description,
  msi.planner_code,
  msi.planning_make_buy_code,
  msi.buyer_name,
  msi.uom_code,
  msi.end_assembly_pegging_flag,
  msi.bom_item_type,
  decode(msi.min_minmax_quantity,0,to_number(null),msi.min_minmax_quantity) min_minmax_quantity,
  msi.preprocessing_lead_time,
  msi.cum_manufacturing_lead_time,
  msi.cumulative_total_lead_time,
  msi.postprocessing_lead_time,
  msi.base_item_id,
  msi.wip_supply_type,
  msi.planning_exception_set,
  msi.release_time_fence_code,
  msi.critical_component_flag,
  msi.mrp_planning_code,
  msi.lots_exist,
  msi.in_source_plan,
  msi.sr_inventory_item_id,
  mfp.*
 from
  (select
    mfp.*
   from
    msc_full_pegging&a2m_dblink mfp
   where
     2=2
  ) mfp,
  msc_system_items&a2m_dblink msi
 where
     mfp.sr_instance_id    = msi.sr_instance_id (+)
 and mfp.plan_id           = msi.plan_id (+)
 and mfp.organization_id   = msi.organization_id (+)
 and mfp.inventory_item_id = msi.inventory_item_id (+)
 connect by
  prior mfp.pegging_id=mfp.prev_pegging_id and
  prior mfp.sr_instance_id=mfp.sr_instance_id and
  prior mfp.plan_id=mfp.plan_id
  &show_source_org_pegging
 start with
  3=3 and
  (   mfp.prev_pegging_id is null
   or not exists (select null
                  from   msc_full_pegging&a2m_dblink mfp2
                  where  mfp2.sr_instance_id = mfp.sr_instance_id
                  and    mfp2.plan_id = mfp.plan_id
                  and    mfp2.pegging_id = mfp.prev_pegging_id
                  &org_restriction
                 )
  )
),
q_mtl_system_items_b as
(
 select
  rowidtochar(msib.rowid) row_id,
  msib.attribute_category,
  msib.inventory_item_id,
  msib.organization_id
 from
  mtl_system_items_b&m2a_dblink msib
 where
  :p_show_item_dff is not null
)
----------------------------------------------------
-- Main Query Starts Here
----------------------------------------------------
select
y.*,
--
-- tree view columns
--
y.end_assembly || '|' || y.end_demand_origination || '|' || y.end_demand_order_number || '|' || to_char(y.end_peg_demand_date,'YYYY/MM/DD') tv_eao_key,
case nvl(end_assembly_plan_ord_qoh_sts,'N/A')
when 'Full' then '1 Full'
when 'Partial' then '2 Partial'
when 'None' then '3 None'
else '4 N/A'
end tv_ea_po_qohs
from
(
select
 nvl(:p_instance_code,x.instance) instance,
 nvl(:p_plan_name,x.plan) plan,
 --
 -- end peg demand
 --
 x.end_assembly,
 x.end_peg_demand_organization,
 x.end_peg_demand_project,
 x.end_peg_demand_task,
 &lp_custom_attributes
 --
 x.end_demand_origination || nvl2(x.end_peg_other_supply_type,'/'||x.end_peg_other_supply_type,null) end_peg_demand_origination,
 nvl(x.end_demand_order_number,nvl2(x.end_peg_other_supply_order,x.end_peg_other_supply_order,null)) end_peg_demand_order_number,
 --
 x.end_demand_origination,
 x.end_demand_order_number,
 --
 x.end_demand_order_qty,
 x.end_peg_demand_qty,
 --
 x.end_peg_demand_date,
 x.end_peg_supply_date,
 x.end_peg_days_late,
 --
 x.end_demand_priority,
 x.end_demand_due_date,
 x.end_demand_sugg_due_date,
 x.end_demand_req_ship_date,
 x.end_demand_days_late,
 --
 case
 when x.end_peg_demand_id > 0 and x.end_assembly is not null
 then
  case
  when max(x.po_qoh_fulfillment) over (partition by x.end_demand_origination,end_demand_order_number,x.end_peg_demand_date,x.end_assembly) !=
       min(x.po_qoh_fulfillment) over (partition by x.end_demand_origination,end_demand_order_number,x.end_peg_demand_date,x.end_assembly)
  then 'Partial'
  when max(x.po_qoh_fulfillment) over (partition by x.end_demand_origination,end_demand_order_number,x.end_peg_demand_date,x.end_assembly) = 1
  then 'Full'
  else 'None'
  end
 else
  null
 end end_assembly_plan_ord_qoh_sts,
 --
 case
 when max(x.po_qoh_fulfillment) over (partition by x.end_pegging_id) !=
      min(x.po_qoh_fulfillment) over (partition by x.end_pegging_id)
 then 'Partial'
 when max(x.po_qoh_fulfillment) over (partition by x.end_pegging_id) = 1
 then 'Full'
 else 'None'
 end end_peg_plan_ord_qoh_sts,
 --
 x.demand_organization,
 x.source_organization,
 lpad(' ',2*(x.level_))||(x.level_) peg_level,
 lpad(' ',2*(x.level_))||x.item  pegged_item,
 x.item_path item_path,
 x.item_description item_description,
 x.uom uom,
 -- pegging info
 x.peg_days_late,
 x.peg_demand_origination_type || nvl2(x.peg_other_supply_type,'/'||x.peg_other_supply_type,null) peg_demand_origination,
 nvl(x.demand_order_number,nvl2(x.supply_order_number,/*'/'||*/x.supply_order_number,null)) peg_demand_order,
 x.peg_demand_date,
 x.peg_demand_qty,
 x.peg_pegged_qty,
 x.peg_supply_qty,
 x.peg_supply_type,
 x.supply_order_number peg_supply_order,
 x.peg_supply_date,
 case when x.peg_supply_type_id = 5
 then
  case max(nvl(x.supply_qoh_fulfillment,-1)) over (partition by x.peg_supply_type,x.supply_order_number,x.peg_supply_date)
  when -1 then null
  when min(x.supply_qoh_fulfillment) over (partition by x.peg_supply_type,x.supply_order_number,x.peg_supply_date)
  then case max(x.supply_qoh_fulfillment) over (partition by x.peg_supply_type,x.supply_order_number,x.peg_supply_date)
       when 1   then 'Full'
       when 0.5 then 'Partial'
                else 'None'
       end
  else 'Partial'
  end
 else
  null
 end supply_plan_ord_qoh_sts,
 x.supply_action,
 x.supply_reschedule_date,
 -- item details
 x.category_set_name,
 x.category_name,
 x.planner_code,
 x.buyer_name,
 x.make_buy,
 x.bom_item_type,
 x.is_bom,
 x.safety_stock,
 x.pegging_type,
 x.min_minmax_quantity,
 x.preprocessing_lead_time,
 x.cum_manufacturing_lead_time,
 x.cumulative_total_lead_time,
 x.postprocessing_lead_time,
 -- demand details
 x.demand_project,
 x.demand_task,
 nvl(x.demand_origination_type,x.peg_demand_origination_type || nvl2(x.peg_other_supply_type,'/'||x.peg_other_supply_type,null)) demand_origination,
 x.demand_order_number,
 x.demand_order_qty,
 x.demand_priority,
 x.demand_due_date,
 x.demand_days_late,
 x.demand_sugg_due_date,
 x.demand_need_by_date,
 x.demand_req_ship_date,
 x.demand_sch_ship_date,
 x.demand_customer,
 x.demand_customer_site,
 x.demand_ship_set,
 -- supply details
 x.supply_project,
 x.supply_task,
 x.supply_order_type,
 x.supply_order_number,
 x.supply_line_num,
 x.supply_order_qty,
 x.supply_firm_qty,
 x.supply_due_date,
 x.supply_days_late,
 x.supply_sugg_due_date,
 x.supply_firm_date,
 x.supply_old_need_by_date,
 x.supply_need_by_date,
 x.supply_promise_date,
 x.supply_wip_status,
 x.supply_vendor,
 x.supply_vendor_site,
 -- exceptions
 x.planning_exception_set,
 x.exceptions,
 -- item dff attributes
 &lp_end_ass_dff_cols
 &lp_item_dff_cols
 -- ids
 x.end_pegging_id,
 x.pegging_id,
 x.prev_pegging_id,
 x.demand_id,
 x.transaction_id,
 x.peg_supply_type_id,
 x.demand_origination_type_id,
 x.supply_order_type_id,
 x.peg_end_item_usage,
 --
 x.level_ "Level",
 x.item item,
 x.item_description_path item_description_path,
 x.seq,
 x.is_end_peg,
 x.po_qoh_fulfillment,
 -- For Pivot to control the supply type ordering as 1.Onhand 2.Planned Supply 3.Existing Supply
 case
 when x.peg_supply_type_id = 18 then '1 '
 when x.peg_supply_type_id in (5,13,51,76,77,78,79) then '2 '
 else '3 ' end || x.peg_supply_type peg_supply_type_label
from
-- start x
(select
  mfp.sr_instance_id,
  mfp.plan_id,
  mai.instance_code                                        instance,
  mp.compile_designator                                    plan,
  mfp.demand_id,
  mfp.transaction_id,
  mfp.pegging_id,
  mfp.prev_pegging_id,
  mfp.end_pegging_id,
  mfp.seq,
  mfp.organization_id,
  mfp.inventory_item_id,
  mfp.sr_inventory_item_id,
  --
  mfp.level_,
  mpo.organization_code                                    demand_organization,
  mfp.item_name                                            item,
  mfp.item_description                                     item_description,
  mfp.item_path                                            item_path,
  mfp.item_description_path                                item_description_path,
  mfp.uom_code                                             uom,
  xxen_util.meaning(mfp.end_assembly_pegging_flag,'ASSEMBLY_PEGGING_CODE',0)
                                                           pegging_type,
  mfp.planner_code                                         planner_code,
  mfp.buyer_name                                           buyer_name,
  mcs.category_set_name                                    category_set_name,
  mic.category_name                                        category_name,
  msc_get_name.lookup_meaning&a2m_dblink ('MTL_PLANNING_MAKE_BUY',mfp.planning_make_buy_code)
                                                           make_buy,
  msc_get_name.lookup_meaning&a2m_dblink ('BOM_ITEM_TYPE',mfp.bom_item_type)
                                                           bom_item_type,
  mfp.min_minmax_quantity,
  mfp.preprocessing_lead_time,
  mfp.cum_manufacturing_lead_time,
  mfp.cumulative_total_lead_time,
  mfp.postprocessing_lead_time,
  nvl((select
        'Y'
       from
        msc_boms&a2m_dblink mb
       where
           mb.sr_instance_id   = mfp.sr_instance_id
       and mb.plan_id          = mfp.plan_id
       and mb.organization_id  = mfp.organization_id
       and mb.assembly_item_id = nvl(md.using_assembly_item_id,mfp.inventory_item_id)
       and rownum <= 1
      ),'N')                                               is_bom,
  (select distinct
    max(mss.safety_stock_quantity) keep (dense_rank last order by mss.period_start_date) over (partition by mss.organization_id,mss.inventory_item_id) safety_stock
   from
    msc_safety_stocks&a2m_dblink mss
   where
       mss.sr_instance_id     = mfp.sr_instance_id
   and mss.plan_id            = mfp.plan_id
   and mss.organization_id    = mfp.organization_id
   and mss.inventory_item_id  = mfp.inventory_item_id
   and mss.period_start_date <= sysdate
  ) safety_stock,
  -- pegginq types / quantities
  case when mfp.demand_id < 0
  then msc_get_name.lookup_meaning&a2m_dblink ('MRP_FLP_SUPPLY_DEMAND_TYPE',mfp.demand_id)
  else msc_get_name.lookup_meaning&a2m_dblink ('MSC_DEMAND_ORIGINATION',decode(md.origination_type, 70, 50, 92, 50, md.origination_type))
  end                                                      peg_demand_origination_type,
  case
  when mfp.demand_id < 0
  then msc_get_name.lookup_meaning&a2m_dblink ('MRP_FLP_SUPPLY_DEMAND_TYPE',mfp.demand_id)
  when mfp.end_origination_type < 0
  then msc_get_name.lookup_meaning&a2m_dblink ('MRP_FLP_SUPPLY_DEMAND_TYPE',mfp.end_origination_type)
  else msc_get_name.lookup_meaning&a2m_dblink ('MSC_DEMAND_ORIGINATION',mfp.end_origination_type)
  end                                                      peg_demand_end_origination,
  mfp.supply_type                                          peg_supply_type_id,
  case
  when mfp.supply_type < 0
  then msc_get_name.lookup_meaning&a2m_dblink ('MRP_FLP_SUPPLY_DEMAND_TYPE',mfp.demand_id)
  else msc_get_name.lookup_meaning&a2m_dblink ('MRP_ORDER_TYPE',mfp.supply_type)
  end                                                      peg_supply_type,
  case
  when mfp.demand_id < 0 and mfp.prev_pegging_id is null and mfp.supply_type < 0
  then msc_get_name.lookup_meaning&a2m_dblink ('MRP_FLP_SUPPLY_DEMAND_TYPE',mfp.supply_type)
  when mfp.demand_id < 0 and mfp.prev_pegging_id is null and mfp.supply_type > 0
  then msc_get_name.lookup_meaning&a2m_dblink ('MRP_ORDER_TYPE',mfp.supply_type)
  else null
  end                                                      peg_other_supply_type,
  case
  when mfp.demand_id = -1 and mfp.prev_pegging_id is null and mfp.supply_type < 0
  then msc_get_name.lookup_meaning&a2m_dblink ('MRP_FLP_SUPPLY_DEMAND_TYPE',mfp.supply_type)
  when mfp.demand_id = -1 and mfp.prev_pegging_id is null and mfp.supply_type > 0
  then msc_get_name.lookup_meaning&a2m_dblink ('MRP_ORDER_TYPE',mfp.supply_type)
  else null
  end                                                      peg_excess_supply_type,
  mfp.demand_quantity                                      peg_demand_qty,
  mfp.supply_quantity                                      peg_supply_qty,
  mfp.allocated_quantity                                   peg_pegged_qty,
  trunc(mfp.demand_date)                                   peg_demand_date,
  trunc(mfp.supply_date)                                   peg_supply_date,
  mfp.end_item_usage                                       peg_end_item_usage,
  case when trunc(mfp.supply_date) <= trunc(mfp.demand_date)
  then to_number(null)
  else trunc(mfp.supply_date) - trunc(mfp.demand_date)
  end                                                      peg_days_late,
  --
  -- Planned Order QOH Fulfillment
  --
  case
  when mfp.supply_type = 18 -- onhand
  then 1
  when mfp.supply_type = 5 -- planned order
  then
    case
    when :show_source_org_pegging = 'N'
    and  0 < (select count(*) from msc_full_pegging&a2m_dblink mfp2 where mfp2.sr_instance_id = mfp.sr_instance_id and mfp2.plan_id = mfp.plan_id and mfp2.prev_pegging_id = mfp.pegging_id and mfp2.organization_id != mfp.organization_id)
    then 0 -- planned order demand in a different source org and source org pegging is not being show => no visibility if planned order can be fullfilled from onhand in the soure org.
    when 0 = (select count(*) from msc_full_pegging&a2m_dblink mfp2 where mfp2.sr_instance_id = mfp.sr_instance_id and mfp2.plan_id = mfp.plan_id and mfp2.prev_pegging_id = mfp.pegging_id)
    then 0 -- no planned order demand.
    else to_number(null) -- planned order with planned order demand. Ignore the Planned order and determine QOH fulfillment from the Planned Order Demand
    end
  else 0
  end                                                      po_qoh_fulfillment,
  --
  case when mfp.supply_type in (5) -- Planned Order
  then
   nvl(
   (select distinct
     case
     when max(
              case
              when mfp2.supply_type = 18 -- onhand
              then 1
              when mfp2.supply_type = 5 -- planned order
              then
                case
                when :show_source_org_pegging = 'N'
                and  0 < (select count(*) from msc_full_pegging&a2m_dblink mfp3 where mfp3.sr_instance_id = mfp2.sr_instance_id and mfp3.plan_id = mfp2.plan_id and mfp3.prev_pegging_id = mfp2.pegging_id and mfp3.organization_id != mfp2.organization_id)
                then 0 -- planned order demand in a different source org and source org pegging is not being show => no visibility if planned order can be fullfilled from onhand in the soure org.
                when 0 = (select count(*) from msc_full_pegging&a2m_dblink mfp3 where mfp3.sr_instance_id = mfp2.sr_instance_id and mfp3.plan_id = mfp2.plan_id and mfp3.prev_pegging_id = mfp2.pegging_id)
                then 0 -- no planned order demand.
                else to_number(null) -- planned order with planned order demand. Ignore the Planned order and determine QOH fulfillment from the Planned Order Demand
                end
              else 0
              end
             ) over () !=
          min(
              case
              when mfp2.supply_type = 18 -- onhand
              then 1
              when mfp2.supply_type = 5 -- planned order
              then
                case
                when :show_source_org_pegging = 'N'
                and  0 < (select count(*) from msc_full_pegging&a2m_dblink mfp3 where mfp3.sr_instance_id = mfp2.sr_instance_id and mfp3.plan_id = mfp2.plan_id and mfp3.prev_pegging_id = mfp2.pegging_id and mfp3.organization_id != mfp2.organization_id)
                then 0 -- planned order demand in a different source org and source org pegging is not being show => no visibility if planned order can be fullfilled from onhand in the soure org.
                when 0 = (select count(*) from msc_full_pegging&a2m_dblink mfp3 where mfp3.sr_instance_id = mfp2.sr_instance_id and mfp3.plan_id = mfp2.plan_id and mfp3.prev_pegging_id = mfp2.pegging_id)
                then 0 -- no planned order demand.
                else to_number(null) -- planned order with planned order demand. Ignore the Planned order and determine QOH fulfillment from the Planned Order Demand
                end
              else 0
              end
             ) over ()
     then 0.5 --Partial
     when max(
              case
              when mfp2.supply_type = 18 -- onhand
              then 1
              when mfp2.supply_type = 5 -- planned order
              then
                case
                when :show_source_org_pegging = 'N'
                and  0 < (select count(*) from msc_full_pegging&a2m_dblink mfp3 where mfp3.sr_instance_id = mfp2.sr_instance_id and mfp3.plan_id = mfp2.plan_id and mfp3.prev_pegging_id = mfp2.pegging_id and mfp3.organization_id != mfp2.organization_id)
                then 0 -- planned order demand in a different source org and source org pegging is not being show => no visibility if planned order can be fullfilled from onhand in the soure org.
                when 0 = (select count(*) from msc_full_pegging&a2m_dblink mfp3 where mfp3.sr_instance_id = mfp2.sr_instance_id and mfp3.plan_id = mfp2.plan_id and mfp3.prev_pegging_id = mfp2.pegging_id)
                then 0 -- no planned order demand.
                else to_number(null) -- planned order with planned order demand. Ignore the Planned order and determine QOH fulfillment from the Planned Order Demand
                end
              else 0
              end
             ) over () = 1
     then 1 -- Full
     else 0 -- None
     end
   from
    msc_full_pegging&a2m_dblink mfp2
   connect by
    prior decode(mfp2.supply_type,5,mfp2.pegging_id,0)=mfp2.prev_pegging_id and
    prior mfp2.sr_instance_id=mfp2.sr_instance_id and
    prior mfp2.plan_id=mfp2.plan_id
    &show_source_org_pegging2
   start with
    mfp2.sr_instance_id=mfp.sr_instance_id and
    mfp2.plan_id=mfp.plan_id and
    mfp2.prev_pegging_id=mfp.pegging_id
   ),0)
  else
   -1 -- ignore
  end                                                      supply_qoh_fulfillment,
  --
  nvl2(mfp.prev_pegging_id,null,'Y')                       is_end_peg,
  --
  -- demand
  --
  case
  when mfp.demand_id < 0 then msc_get_name.project&a2m_dblink (mfp.project_id, mfp.organization_id, mfp.plan_id, mfp.sr_instance_id)
  else msc_get_name.project&a2m_dblink (md.project_id, md.organization_id, md.plan_id, md.sr_instance_id)
  end                                                      demand_project,
  case
  when mfp.demand_id < 0 then msc_get_name.task&a2m_dblink (mfp.task_id, mfp.project_id, mfp.organization_id, mfp.plan_id, mfp.sr_instance_id)
  else msc_get_name.task&a2m_dblink (md.task_id, md.project_id, md.organization_id, md.plan_id, md.sr_instance_id)
  end                                                      demand_task,
  msc_get_name.item_name&a2m_dblink (md.using_assembly_item_id,null,null,null)
                                                           using_assembly_segments,
  decode(md.origination_type,92,50,md.origination_type)    demand_origination_type_id,
  msc_get_name.lookup_meaning&a2m_dblink ('MSC_DEMAND_ORIGINATION',decode(md.origination_type, 70, 50, 92, 50, md.origination_type))
                                                           demand_origination_type,
  --md.order_number
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
                            , decode(mfp.in_source_plan
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
     )                                                     demand_order_number,
  --
  -(nvl(md.daily_demand_rate,md.using_requirement_quantity)) * nvl(md.probability, 1)
                                                           demand_order_qty,
  md.demand_priority                                       demand_priority,
  trunc(md.old_demand_date)                                demand_due_date,
  trunc(md.using_assembly_demand_date)                     demand_sugg_due_date,
  trunc(to_date(null))                                     demand_need_by_date,
  trunc(md.request_ship_date)                              demand_req_ship_date,
  trunc(md.schedule_ship_date)                             demand_sch_ship_date,
  --md.late_days
  round(decode
   (
    sign(md.dmd_satisfied_date - md.using_assembly_demand_date)
   ,-1,least(md.dmd_satisfied_date - md.using_assembly_demand_date,-0.01)
   , 1,greatest(md.dmd_satisfied_date - md.using_assembly_demand_date,0.01)
      , 0
   ),2)                                                    demand_days_late,
  decode(md.customer_id
        , null,msc_get_name.get_other_customers&a2m_dblink (md.plan_id,md.schedule_designator_id)
              ,msc_get_name.customer&a2m_dblink (md.customer_id)
        )                                                  demand_customer,
  decode(md.customer_site_id
        ,null,msc_get_name.get_other_customers&a2m_dblink (md.plan_id,md.schedule_designator_id)
             ,msc_get_name.customer_site&a2m_dblink (md.customer_site_id)
        )                                                  demand_customer_site,
  md.ship_set_name                                         demand_ship_set,
  -- supply
  -- ms.order_type id
  msc_get_name.project&a2m_dblink (ms.project_id, ms.organization_id, ms.plan_id, ms.sr_instance_id) supply_project,
  msc_get_name.task&a2m_dblink (ms.task_id, ms.project_id, ms.organization_id, ms.plan_id, ms.sr_instance_id) supply_task,
  decode(ms.order_type,92,70,ms.order_type)                supply_order_type_id,
  --  ms.order_type_text
  case
  when mp.plan_type = 8
  then case when ms.order_type = 1  then msc_get_name.lookup_meaning&a2m_dblink ('SRP_CHANGED_ORDER_TYPE', ms.order_type)
            when ms.order_type = 2  and ms.source_organization_id is null then msc_get_name.lookup_meaning&a2m_dblink ('SRP_CHANGED_ORDER_TYPE', ms.order_type)
            when ms.order_type = 2  and ms.source_organization_id is not null then msc_get_name.lookup_meaning&a2m_dblink ('MRP_ORDER_TYPE',53)
            when ms.order_type = 53 then msc_get_name.lookup_meaning&a2m_dblink ('SRP_CHANGED_ORDER_TYPE', ms.order_type)
            else msc_get_name.lookup_meaning&a2m_dblink ('MRP_ORDER_TYPE',case ms.order_type when 92 then 70 else ms.order_type end)
            end
  else msc_get_name.lookup_meaning&a2m_dblink ('MRP_ORDER_TYPE',case ms.order_type when 92 then 70 else ms.order_type end)
  end                                                      supply_order_type,
  --ms.order_number
  msc_get_name.supply_order_number&a2m_dblink
   (ms.order_type
   ,ms.order_number
   ,ms.plan_id
   ,ms.sr_instance_id
   ,ms.transaction_id
   ,ms.disposition_id
   )                                                       supply_order_number,
  --
  ms.purch_line_num                                        supply_line_num,
  nvl(ms.daily_rate,ms.new_order_quantity)                 supply_order_qty,
  ms.firm_quantity                                         supply_firm_qty,
  --ms.action
  msc_get_name.action&a2m_dblink
   ('MSC_SUPPLIES'
   ,mfp.bom_item_type
   ,mfp.base_item_id
   ,mfp.wip_supply_type
   ,ms.order_type
   ,ms.reschedule_flag
   ,ms.disposition_status_type
   ,ms.new_schedule_date
   ,ms.old_schedule_date
   ,ms.implemented_quantity
   ,ms.quantity_in_process
   ,ms.new_order_quantity
   ,mfp.release_time_fence_code
   ,ms.reschedule_days
   ,ms.firm_quantity
   ,ms.plan_id
   ,mfp.critical_component_flag
   ,mfp.mrp_planning_code
   ,mfp.lots_exist
   ,ms.item_type_value
   ,ms.transaction_id
   )                                                       supply_action,
  --
  case when ms.old_schedule_date <> ms.new_schedule_date
  then trunc(ms.new_schedule_date) else null end           supply_reschedule_date,
  trunc(ms.old_schedule_date)                              supply_due_date,
  trunc(ms.new_schedule_date)                              supply_sugg_due_date,
  trunc(ms.firm_date)                                      supply_firm_date,
  trunc(ms.old_need_by_date)                               supply_old_need_by_date,
  trunc(ms.need_by_date)                                   supply_need_by_date,
  trunc(ms.promised_date)                                  supply_promise_date,
  round(nvl(ms.earliest_completion_date-ms.need_by_date,0),2)
                                                           supply_days_late,
  msc_get_name.lookup_meaning&a2m_dblink ('WIP_JOB_STATUS',ms.wip_status_code)
                                                           supply_wip_status,
  msc_get_name.org_code&a2m_dblink (ms.source_organization_id,ms.source_sr_instance_id)
                                                           source_organization,
  msc_get_name.supplier&a2m_dblink (ms.supplier_id)                    supply_vendor,
  msc_get_name.supplier_site&a2m_dblink (ms.supplier_site_id)          supply_vendor_site,
  --
  -- end peg demand
  --
  case when mfpe.demand_id > 0
  then mfpe.demand_id
  else mfpe.transaction_id
  end                                                      end_peg_partition_id,
  mfpe.organization_id                                     end_peg_org_id,
  mfpe.inventory_item_id                                   end_peg_item_id,
  msie.sr_inventory_item_id                                end_peg_sr_item_id,
  mfpe.demand_id                                           end_peg_demand_id,
  mfpe.transaction_id                                      end_peg_transaction_id,
  msie.item_name                                           end_assembly,
  -- project
  case
  when mfpe.demand_id < 0 then msc_get_name.project&a2m_dblink (mfpe.project_id, mfpe.organization_id, mfpe.plan_id, mfpe.sr_instance_id)
  else msc_get_name.project&a2m_dblink (mde.project_id, mde.organization_id, mde.plan_id, mde.sr_instance_id)
  end                                                      end_peg_demand_project,
  case
  when mfpe.demand_id < 0 then msc_get_name.task&a2m_dblink (mfpe.task_id, mfpe.project_id, mfpe.organization_id, mfpe.plan_id, mfpe.sr_instance_id)
  else msc_get_name.task&a2m_dblink (mde.task_id, mde.project_id, mde.organization_id, mde.plan_id, mde.sr_instance_id)
  end                                                      end_peg_demand_task,
  mpoe.organization_code                                   end_peg_demand_organization,
  case when mfpe.demand_id < 0
  then msc_get_name.lookup_meaning&a2m_dblink ('MRP_FLP_SUPPLY_DEMAND_TYPE',mfpe.demand_id)
  else msc_get_name.lookup_meaning&a2m_dblink ('MSC_DEMAND_ORIGINATION',decode(mde.origination_type, 70, 50, 92, 50, mde.origination_type))
  end                                                      end_demand_origination,
  case
  when mfp.supply_type < 0
  then msc_get_name.lookup_meaning&a2m_dblink ('MRP_FLP_SUPPLY_DEMAND_TYPE',mfpe.demand_id)
  else msc_get_name.lookup_meaning&a2m_dblink ('MRP_ORDER_TYPE',mfpe.supply_type)
  end                                                      end_peg_supply_type,
  case
  when mfpe.demand_id < 0 and mfpe.supply_type < 0
  then msc_get_name.lookup_meaning&a2m_dblink ('MRP_FLP_SUPPLY_DEMAND_TYPE',mfpe.supply_type)
  when mfpe.demand_id < 0 and mfpe.supply_type > 0
  then msc_get_name.lookup_meaning&a2m_dblink ('MRP_ORDER_TYPE',mfpe.supply_type)
  else null
  end                                                      end_peg_other_supply_type,
  case
  when mfpe.demand_id = -1 and mfpe.supply_type < 0
  then msc_get_name.lookup_meaning&a2m_dblink ('MRP_FLP_SUPPLY_DEMAND_TYPE',mfpe.supply_type)
  when mfpe.demand_id = -1 and mfpe.supply_type > 0
  then msc_get_name.lookup_meaning&a2m_dblink ('MRP_ORDER_TYPE',mfpe.supply_type)
  else null
  end                                                      end_peg_excess_supply_type,
  nvl(mde.order_number
     ,decode(mde.origination_type
            , 1 , to_char(mde.disposition_id)
            , 3 , msc_get_name.job_name&a2m_dblink (mde.disposition_id, mde.plan_id, mde.sr_instance_id)
            , 22, to_char(mde.disposition_id)
            , 50, msc_get_name.maintenance_plan&a2m_dblink (mde.schedule_designator_id)
            , 70, msc_get_name.maintenance_plan&a2m_dblink (mde.schedule_designator_id)
            , 92, msc_get_name.maintenance_plan&a2m_dblink (mde.schedule_designator_id )
            , 29, decode(mde.plan_id
                        ,-11, msc_get_name.designator&a2m_dblink (mde.schedule_designator_id)
                            , decode(msie.in_source_plan
                                    ,1,msc_get_name.designator&a2m_dblink (mde.schedule_designator_id, mde.forecast_set_id )
                                    , msc_get_name.scenario_designator&a2m_dblink (mde.forecast_set_id, mde.plan_id, mde.organization_id, mde.sr_instance_id)
                                      || decode(msc_get_name.designator&a2m_dblink (mde.schedule_designator_id,mde.forecast_set_id )
                                               , null, null
                                                     , '/'||msc_get_name.designator&a2m_dblink (mde.schedule_designator_id,mde.forecast_set_id )
                                               )
                                    )
                        )
            , 78, to_char(mde.disposition_id)
                , msc_get_name.designator&a2m_dblink (mde.schedule_designator_id)
            )
     )                                                     end_demand_order_number,
  case when mfpe.demand_id < 0
  then
   (select
     msc_get_name.supply_order_number&a2m_dblink
      (mse.order_type
      ,mse.order_number
      ,mse.plan_id
      ,mse.sr_instance_id
      ,mse.transaction_id
      ,mse.disposition_id
      )
    from
     msc_supplies&a2m_dblink mse
    where
        mse.sr_instance_id = mfpe.sr_instance_id
    and mse.plan_id = mfpe.plan_id
    and mse.transaction_id = mfpe.transaction_id
   )
  else
   null
  end                                                      end_peg_other_supply_order,
  mde.demand_priority                                      end_demand_priority,
  trunc(mfpe.demand_date)                                  end_peg_demand_date,
  trunc(mfpe.supply_date)                                  end_peg_supply_date,
  case when trunc(mfpe.supply_date) <= trunc(mfpe.demand_date)
  then to_number(null)
  else trunc(mfpe.supply_date) - trunc(mfpe.demand_date)
  end                                                      end_peg_days_late,
  trunc(mde.old_demand_date)                               end_demand_due_date,
  trunc(mde.using_assembly_demand_date)                    end_demand_sugg_due_date,
  trunc(mde.request_ship_date)                             end_demand_req_ship_date,
  -(nvl(mde.daily_demand_rate,mde.using_requirement_quantity)) * nvl(mde.probability, 1)
                                                           end_demand_order_qty,
  mfpe.demand_quantity                                     end_peg_demand_qty,
  round(decode
   (
    sign(mde.dmd_satisfied_date - mde.using_assembly_demand_date)
   ,-1,least(mde.dmd_satisfied_date - mde.using_assembly_demand_date,-0.01)
   , 1,greatest(mde.dmd_satisfied_date - mde.using_assembly_demand_date,0.01)
      , 0
   ),2)                                                    end_demand_days_late,
  -- exceptions
  mfp.planning_exception_set,
  (se
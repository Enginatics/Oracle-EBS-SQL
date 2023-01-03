/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MRP Horizontal Plan
-- Description: MRP: Horizontal Plan from the Planners Workbench.
- The report can be run for multiple organizations and items within a selected plan
- The report can be used to explode BOMS and display the HP for all components 
  within the BOM
- Select a template to choose to either display the HP by individual components, or by 
  End Assemblies, Components.

-- Excel Examle Output: https://www.enginatics.com/example/mrp-horizontal-plan/
-- Library Link: https://www.enginatics.com/reports/mrp-horizontal-plan/
-- Run Report: https://demo.enginatics.com/

with
mmp as
(
select
  mmp.plan_id
, mmp.organization_id
, mmp.compile_designator
, mmp.inventory_item_id
, mmp.item_segments
, mmp.horizontal_plan_type
, mmp.bucket_type
, mmp.horizontal_plan_type_text
, mmp.plan_organization_id
, mmp.organization_code
, case seq.column_value
  when 1  then (mwbd.date1)
  when 2  then (mwbd.date2)
  when 3  then (mwbd.date3)
  when 4  then (mwbd.date4)
  when 5  then (mwbd.date5)
  when 6  then (mwbd.date6)
  when 7  then (mwbd.date7)
  when 8  then (mwbd.date8)
  when 9  then (mwbd.date9)
  when 10 then (mwbd.date10)
  when 11 then (mwbd.date11)
  when 12 then (mwbd.date12)
  when 13 then (mwbd.date13)
  when 14 then (mwbd.date14)
  when 15 then (mwbd.date15)
  when 16 then (mwbd.date16)
  when 17 then (mwbd.date17)
  when 18 then (mwbd.date18)
  when 19 then (mwbd.date19)
  when 20 then (mwbd.date20)
  when 21 then (mwbd.date21)
  when 22 then (mwbd.date22)
  when 23 then (mwbd.date23)
  when 24 then (mwbd.date24)
  when 25 then (mwbd.date25)
  when 26 then (mwbd.date26)
  when 27 then (mwbd.date27)
  when 28 then (mwbd.date28)
  when 29 then (mwbd.date29)
  when 30 then (mwbd.date30)
  when 31 then (mwbd.date31)
  when 32 then (mwbd.date32)
  when 33 then (mwbd.date33)
  when 34 then (mwbd.date34)
  when 35 then (mwbd.date35)
  when 36 then (mwbd.date36)
  else to_date(null)
  end bucket_date
, to_number(xxen_mrp_horizplan.format_quantity
  (
   case seq.column_value
   when 1  then (mmp.quantity1)
   when 2  then (mmp.quantity2)
   when 3  then (mmp.quantity3)
   when 4  then (mmp.quantity4)
   when 5  then (mmp.quantity5)
   when 6  then (mmp.quantity6)
   when 7  then (mmp.quantity7)
   when 8  then (mmp.quantity8)
   when 9  then (mmp.quantity9)
   when 10 then (mmp.quantity10)
   when 11 then (mmp.quantity11)
   when 12 then (mmp.quantity12)
   when 13 then (mmp.quantity13)
   when 14 then (mmp.quantity14)
   when 15 then (mmp.quantity15)
   when 16 then (mmp.quantity16)
   when 17 then (mmp.quantity17)
   when 18 then (mmp.quantity18)
   when 19 then (mmp.quantity19)
   when 20 then (mmp.quantity20)
   when 21 then (mmp.quantity21)
   when 22 then (mmp.quantity22)
   when 23 then (mmp.quantity23)
   when 24 then (mmp.quantity24)
   when 25 then (mmp.quantity25)
   when 26 then (mmp.quantity26)
   when 27 then (mmp.quantity27)
   when 28 then (mmp.quantity28)
   when 29 then (mmp.quantity29)
   when 30 then (mmp.quantity30)
   when 31 then (mmp.quantity31)
   when 32 then (mmp.quantity32)
   when 33 then (mmp.quantity33)
   when 34 then (mmp.quantity34)
   when 35 then (mmp.quantity35)
   when 36 then (mmp.quantity36)
   else to_number(null)
   end
  )) bucket_quantity
from
  mrp_material_plans mmp
, mrp_workbench_bucket_dates mwbd
, table(xxen_util.rowgen(36)) seq
where
    mmp.plan_id                 = xxen_mrp_horizplan.get_hp_plan_id
and mmp.bucket_type             = xxen_mrp_horizplan.get_hp_bucket_type
and xxen_mrp_horizplan.hp_source_enabled(mmp.horizontal_plan_type) = 'Y'
and mwbd.compile_designator     = xxen_mrp_horizplan.get_compile_designator
and mwbd.organization_id        = xxen_mrp_horizplan.get_plan_organization_id
and nvl(mwbd.planned_organization
       ,mwbd.organization_id)   = xxen_mrp_horizplan.get_planned_organization_id
and mwbd.bucket_type            = xxen_mrp_horizplan.get_hp_bucket_type
)
--
--
select
  hp.*
from
(
select
  mmp.compile_designator                             plan
, mmp.organization_code                              organization_code
, nvl( mea.end_assembly
     , case when xxen_mrp_horizplan.is_end_assembly(mmp.compile_designator,mmp.organization_id,mmp.inventory_item_id)='Y'
       then msiv.concatenated_segments
       else null
       end
     )                                               end_assembly
, nvl( mea.end_assembly_desc
     , case when xxen_mrp_horizplan.is_end_assembly(mmp.compile_designator,mmp.organization_id,mmp.inventory_item_id)='Y'
       then msiv.description
       else null
       end
     )                                               end_assembly_description
, case when mea.end_assembly_id is not null
  then xxen_mrp_horizplan.get_bom_level(mmp.organization_id,mea.end_assembly_id,msiv.inventory_item_id)
  else case when xxen_mrp_horizplan.is_end_assembly(mmp.compile_designator,mmp.organization_id,mmp.inventory_item_id)='Y'
  then xxen_mrp_horizplan.get_bom_level(mmp.organization_id,msiv.inventory_item_id,msiv.inventory_item_id)
  else null
  end end                                            bom_level
, mmp.item_segments                                  item
, msiv.description                                   item_description
, xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3)    item_type
, msiv.primary_unit_of_measure                       uom
, mck.concatenated_segments                          category
, msiv.preprocessing_lead_time
, msiv.full_lead_time
, msiv.postprocessing_lead_time
, msiv.cumulative_total_lead_time
, msiv.cum_manufacturing_lead_time                   cumulative_mfg_lead_time
, (select asu.vendor_name
   from   mrp_system_items msi
      ,   ap_suppliers asu
   where  msi.compile_designator = mmp.compile_designator
   and    msi.organization_id    = mmp.organization_id
   and    msi.inventory_item_id  = mmp.inventory_item_id
   and    asu.vendor_id          = msi.primary_vendor_id
  )                                                  primary_supplier
, (select ppx.full_name
   from   per_people_x ppx
   where ppx.person_id = msiv.buyer_id
   and   rownum=1
  )                                                  buyer
, xxen_util.meaning(msiv.planning_make_buy_code
                   ,'MTL_PLANNING_MAKE_BUY',700)     make_or_buy
, xxen_util.meaning(msiv.wip_supply_type
                   ,'WIP_SUPPLY',700)                wip_supply_type
, msiv.planner_code
, mpl.description                                    planner_description
, xxen_util.meaning(msiv.mrp_planning_code
                   ,'MRP_PLANNING_CODE',700)         planning_method
, xxen_util.meaning(msiv.ato_forecast_control
                   ,'MRP_ATO_FORECAST_CONTROL',700)  forecast_control
, xxen_util.meaning(msiv.end_assembly_pegging_flag
                   ,'ASSEMBLY_PEGGING_CODE',0)       pegging
, xxen_util.meaning(msiv.planning_time_fence_code
                   ,'MTL_TIME_FENCE',700)            planning_time_fence
, xxen_mrp_horizplan.get_end_assemblies(mmp.compile_designator,mmp.organization_id,mmp.inventory_item_id)
                                                     end_assemblies
, mmp.horizontal_plan_type_text                      source_type_text
, mmp.bucket_date
, mmp.bucket_quantity
, mmp.horizontal_plan_type                           source_type
, case when mea.end_assembly_id is not null
  then xxen_mrp_horizplan.get_bom_sort_order(mmp.organization_id,mea.end_assembly_id,msiv.inventory_item_id)
  else case when xxen_mrp_horizplan.is_end_assembly(mmp.compile_designator,mmp.organization_id,mmp.inventory_item_id)='Y'
  then xxen_mrp_horizplan.get_bom_sort_order(mmp.organization_id,msiv.inventory_item_id,msiv.inventory_item_id)
  else null
  end end                                            bom_sort_order
from
  mmp                 mmp
, mtl_system_items_vl  msiv
, mtl_item_categories  mic
, mtl_categories_kfv   mck
, mtl_planners         mpl
, ( select
      mea2.compile_designator
    , mea2.organization_id
    , mea2.inventory_item_id
    , mea2.end_assembly_id
    , msiv2.concatenated_segments end_assembly
    , msiv2.description           end_assembly_desc
    from
      mrp_end_assemblies   mea2
    , mtl_system_items_vl  msiv2
    where
        msiv2.organization_id   = mea2.organization_id
    and msiv2.inventory_item_id = mea2.end_assembly_id
    and msiv2.bom_item_type    in (1,2,3,4)
  )                    mea
where
    msiv.organization_id        = mmp.organization_id
and msiv.inventory_item_id      = mmp.inventory_item_id
and mic.category_set_id     (+) = xxen_mrp_horizplan.get_category_set_id
and mic.organization_id     (+) = mmp.organization_id
and mic.inventory_item_id   (+) = mmp.inventory_item_id
and mck.category_id         (+) = mic.category_id
and mpl.planner_code        (+) = msiv.planner_code
and mpl.organization_id     (+) = msiv.organization_id
and mea.compile_designator  (+) = mmp.compile_designator
and mea.organization_id     (+) = mmp.organization_id
and mea.inventory_item_id   (+) = mmp.inventory_item_id
)  hp
where
  1=1
order by
  hp.plan
, hp.organization_code
, hp.end_assembly
, hp.bom_sort_order
, hp.item
, hp.source_type
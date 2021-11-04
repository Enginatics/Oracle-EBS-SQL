/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
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

with hp as
( select
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
  , xxen_mrp_horizplan.format_quantity(mmp.quantity1)  bucket1
  , xxen_mrp_horizplan.format_quantity(mmp.quantity2)  bucket2
  , xxen_mrp_horizplan.format_quantity(mmp.quantity3)  bucket3
  , xxen_mrp_horizplan.format_quantity(mmp.quantity4)  bucket4
  , xxen_mrp_horizplan.format_quantity(mmp.quantity5)  bucket5
  , xxen_mrp_horizplan.format_quantity(mmp.quantity6)  bucket6
  , xxen_mrp_horizplan.format_quantity(mmp.quantity7)  bucket7
  , xxen_mrp_horizplan.format_quantity(mmp.quantity8)  bucket8
  , xxen_mrp_horizplan.format_quantity(mmp.quantity9)  bucket9
  , xxen_mrp_horizplan.format_quantity(mmp.quantity10) bucket10
  , xxen_mrp_horizplan.format_quantity(mmp.quantity11) bucket11
  , xxen_mrp_horizplan.format_quantity(mmp.quantity12) bucket12
  , xxen_mrp_horizplan.format_quantity(mmp.quantity13) bucket13
  , xxen_mrp_horizplan.format_quantity(mmp.quantity14) bucket14
  , xxen_mrp_horizplan.format_quantity(mmp.quantity15) bucket15
  , xxen_mrp_horizplan.format_quantity(mmp.quantity16) bucket16
  , xxen_mrp_horizplan.format_quantity(mmp.quantity17) bucket17
  , xxen_mrp_horizplan.format_quantity(mmp.quantity18) bucket18
  , xxen_mrp_horizplan.format_quantity(mmp.quantity19) bucket19
  , xxen_mrp_horizplan.format_quantity(mmp.quantity20) bucket20
  , xxen_mrp_horizplan.format_quantity(mmp.quantity21) bucket21
  , xxen_mrp_horizplan.format_quantity(mmp.quantity22) bucket22
  , xxen_mrp_horizplan.format_quantity(mmp.quantity23) bucket23
  , xxen_mrp_horizplan.format_quantity(mmp.quantity24) bucket24
  , xxen_mrp_horizplan.format_quantity(mmp.quantity25) bucket25
  , xxen_mrp_horizplan.format_quantity(mmp.quantity26) bucket26
  , xxen_mrp_horizplan.format_quantity(mmp.quantity27) bucket27
  , xxen_mrp_horizplan.format_quantity(mmp.quantity28) bucket28
  , xxen_mrp_horizplan.format_quantity(mmp.quantity29) bucket29
  , xxen_mrp_horizplan.format_quantity(mmp.quantity30) bucket30
  , xxen_mrp_horizplan.format_quantity(mmp.quantity31) bucket31
  , xxen_mrp_horizplan.format_quantity(mmp.quantity32) bucket32
  , xxen_mrp_horizplan.format_quantity(mmp.quantity33) bucket33
  , xxen_mrp_horizplan.format_quantity(mmp.quantity34) bucket34
  , xxen_mrp_horizplan.format_quantity(mmp.quantity35) bucket35
  , xxen_mrp_horizplan.format_quantity(mmp.quantity36) bucket36
  , 2                                                  rec_type
  , mmp.horizontal_plan_type                           source_type
  , case when mea.end_assembly_id is not null
    then xxen_mrp_horizplan.get_bom_sort_order(mmp.organization_id,mea.end_assembly_id,msiv.inventory_item_id)
    else case when xxen_mrp_horizplan.is_end_assembly(mmp.compile_designator,mmp.organization_id,mmp.inventory_item_id)='Y'
    then xxen_mrp_horizplan.get_bom_sort_order(mmp.organization_id,msiv.inventory_item_id,msiv.inventory_item_id)
    else null
    end end                                            bom_sort_order
  from
    mrp_material_plans   mmp
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
  and mmp.plan_id                 = xxen_mrp_horizplan.get_hp_plan_id
  and mmp.bucket_type             = xxen_mrp_horizplan.get_hp_bucket_type
  and xxen_mrp_horizplan.hp_source_enabled(mmp.horizontal_plan_type) = 'Y'
  union
  -- this query just returns the buck dates which will appear at the start of the Blitz Report
  select
    mwbd.compile_designator                   plan
  , null                                      organization_code
  , null                                      end_assembly
  , null                                      end_assembly_description
  , null                                      bom_level
  , null                                      item
  , null                                      item_description
  , null                                      item_type
  , null                                      uom
  , null                                      category
  , null                                      preprocessing_lead_time
  , null                                      full_lead_time
  , null                                      postprocessing_lead_time
  , null                                      cumulative_total_lead_time
  , null                                      cumulative_mfg_lead_time
  , null                                      primary_supplier
  , null                                      buyer
  , null                                      make_or_buy
  , null                                      wip_supply_type
  , null                                      planner_code
  , null                                      planner_description
  , null                                      planning_method
  , null                                      forecast_control
  , null                                      pegging
  , null                                      planning_time_fence
  , null                                      end_assemblies
  , xxen_mrp_horizplan.get_bucket_type_name
     || ' Bucket Dates'                       source_type_text
  , fnd_date.date_to_displaydate(mwbd.date1)  bucket1
  , fnd_date.date_to_displaydate(mwbd.date2)  bucket2
  , fnd_date.date_to_displaydate(mwbd.date3)  bucket3
  , fnd_date.date_to_displaydate(mwbd.date4)  bucket4
  , fnd_date.date_to_displaydate(mwbd.date5)  bucket5
  , fnd_date.date_to_displaydate(mwbd.date6)  bucket6
  , fnd_date.date_to_displaydate(mwbd.date7)  bucket7
  , fnd_date.date_to_displaydate(mwbd.date8)  bucket8
  , fnd_date.date_to_displaydate(mwbd.date9)  bucket9
  , fnd_date.date_to_displaydate(mwbd.date10) bucket10
  , fnd_date.date_to_displaydate(mwbd.date11) bucket11
  , fnd_date.date_to_displaydate(mwbd.date12) bucket12
  , fnd_date.date_to_displaydate(mwbd.date13) bucket13
  , fnd_date.date_to_displaydate(mwbd.date14) bucket14
  , fnd_date.date_to_displaydate(mwbd.date15) bucket15
  , fnd_date.date_to_displaydate(mwbd.date16) bucket16
  , fnd_date.date_to_displaydate(mwbd.date17) bucket17
  , fnd_date.date_to_displaydate(mwbd.date18) bucket18
  , fnd_date.date_to_displaydate(mwbd.date19) bucket19
  , fnd_date.date_to_displaydate(mwbd.date20) bucket20
  , fnd_date.date_to_displaydate(mwbd.date21) bucket21
  , fnd_date.date_to_displaydate(mwbd.date22) bucket22
  , fnd_date.date_to_displaydate(mwbd.date23) bucket23
  , fnd_date.date_to_displaydate(mwbd.date24) bucket24
  , fnd_date.date_to_displaydate(mwbd.date25) bucket25
  , fnd_date.date_to_displaydate(mwbd.date26) bucket26
  , fnd_date.date_to_displaydate(mwbd.date27) bucket27
  , fnd_date.date_to_displaydate(mwbd.date28) bucket28
  , fnd_date.date_to_displaydate(mwbd.date29) bucket29
  , fnd_date.date_to_displaydate(mwbd.date30) bucket30
  , fnd_date.date_to_displaydate(mwbd.date31) bucket31
  , fnd_date.date_to_displaydate(mwbd.date32) bucket32
  , fnd_date.date_to_displaydate(mwbd.date33) bucket33
  , fnd_date.date_to_displaydate(mwbd.date34) bucket34
  , fnd_date.date_to_displaydate(mwbd.date35) bucket35
  , fnd_date.date_to_displaydate(mwbd.date36) bucket36
  , 1                                         rec_type
  , null                                      source_type
  , null                                      bom_sort_order
  from
    mrp_workbench_bucket_dates mwbd
  where
      mwbd.compile_designator   = xxen_mrp_horizplan.get_compile_designator
  and mwbd.organization_id      = xxen_mrp_horizplan.get_plan_organization_id
  and nvl(mwbd.planned_organization
         ,mwbd.organization_id) = xxen_mrp_horizplan.get_planned_organization_id
  and mwbd.bucket_type          = xxen_mrp_horizplan.get_hp_bucket_type
)
--
-- Main Query Starts Here
--
select
  hp.*
from
  hp
where
  1=1
order by
  hp.rec_type
, hp.plan
, hp.organization_code
, hp.end_assembly
, hp.bom_sort_order
, hp.item
, hp.source_type
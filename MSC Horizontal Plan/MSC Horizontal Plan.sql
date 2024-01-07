/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MSC Horizontal Plan
-- Description: ASCP: Horizontal Plan from the Planners Workbench.

Note: 
The number of Items included in the HP is restricted by the parameter ‘Item Restriction Limit’. This parameter defaults from the profile option ‘MSC: HP Maximum Displayed Item Count’ in the ASCP Planning Instance. The value set in the Item Restriction Limit parameter will override the value specified in profile option.

-- Excel Examle Output: https://www.enginatics.com/example/msc-horizontal-plan/
-- Library Link: https://www.enginatics.com/reports/msc-horizontal-plan/
-- Run Report: https://demo.enginatics.com/

with
  mfg_sd_lookups as
  ( select
     ml.lookup_code,
     ml.meaning 
    from
     msc_apps_instances&a2m_dblink  mai,
     msc_plans&a2m_dblink           mp,
     mfg_lookups&a2m_dblink         ml
    where
        mp.sr_instance_id = mai.instance_id
    and mp.compile_designator = :p_plan_name
    and mai.instance_code = :p_instance_code
    and (
             (    mp.plan_type != 4 -- ASCP Plan
              and ml.lookup_type = 'MRP_HORIZONTAL_PLAN_TYPE_SC'
              and ml.lookup_code not in (97,82,125,170,180,190)
              and ((    nvl(fnd_profile.value&a2m_dblink ('MSC_ASCP_IGNORE_CMRO_EAM_WO'),1) = 1 
                    and ml.lookup_code not in (295,330,305,310,315,320,325,335,340,345,350)
                   )
                   or
                   (nvl(fnd_profile.value&a2m_dblink ('MSC_ASCP_IGNORE_CMRO_EAM_WO'),1) = 2
                   )
                  )
              and ((    fnd_profile.value&a2m_dblink ('MSC_HP_EXTENSION_PROGRAM') is null
                    and ml.lookup_code not in (500) -- custom user defined
                   )
                   or
                   (fnd_profile.value&a2m_dblink ('MSC_HP_EXTENSION_PROGRAM') is not null
                   )
                  ) 
              and NVL(xxen_msc_horizplan.get_pref_option(mp.plan_type,:p_pref_name,ml.lookup_type,ml.lookup_code),'Y') = 'Y'
             ) 
          or
             (    mp.plan_type = 4 -- IO Plan
              and ml.lookup_type = 'MSC_HORIZONTAL_PLAN_TYPE_IO'
              and ((    fnd_profile.value&a2m_dblink ('MSC_HP_EXTENSION_PROGRAM') is null
                    and ml.lookup_code not in (500) -- custom user defined
                   )
                   or
                   (fnd_profile.value&a2m_dblink ('MSC_HP_EXTENSION_PROGRAM') is not null
                   )
                  )
              and NVL(xxen_msc_horizplan.get_pref_option(mp.plan_type,:p_pref_name,ml.lookup_type,ml.lookup_code),'Y') = 'Y'
             )
        )
    union
    select
     900 lookup_code,
     'PAB Days Stock Cover' meaning
    from
     dual&a2m_dblink
    where
     nvl(:p_metric,'Horizontal Plan') = 'PAB Days Stock Cover'
  ),
  hp3 as
  ( select
     hp2.planning_instance,
     hp2.plan_name,
     hp2.organization,
     hp2.organization_name,
     hp2.operating_unit,
     hp2.item,
     hp2.item_description,
     hp2.category_set,
     hp2.category,
     hp2.item_uom,
     hp2.report_uom,
     hp2.uom_conversion,
     hp2.make_buy "Make/Buy",
     hp2.planner,
     hp2.buyer,
     hp2.dashboard_metric,
     hp2.supply_demand_code,
     hp2.supply_demand_type,
     hp2.aggregation_level,
     hp2.aggregation_label,
     hp2.bucket_date,
     hp2.pn period_num,
     hp2.wn week_num,
     hp2.dn day_num,
     --
     -- quantities
     --
     hp2.quantity,
     --
     case hp2.supply_demand_code
     when 110 then hp2.week_qty_last
     when 120 then hp2.week_qty_last
     when 130 then hp2.week_qty_last
     when 150 then hp2.week_qty_last
     when 175 then hp2.week_qty_last
     when 177 then hp2.week_qty_last
     when 178 then hp2.week_qty_last
     when 180 then hp2.week_qty_last
     when 183 then hp2.week_qty_last
     when 184 then hp2.week_qty_last
     when 185 then hp2.week_qty_last
     when 186 then hp2.week_qty_last
     when 190 then hp2.week_qty_last
     when 200 then hp2.week_qty_last
     when 210 then hp2.week_qty_last
     when 220 then hp2.week_qty_last
     when 230 then hp2.week_qty_last
     when 240 then hp2.week_qty_last
     when 250 then hp2.week_qty_last
     when 260 then hp2.week_qty_last
     when 270 then hp2.week_qty_last
     when 280 then hp2.week_qty_last
     when 290 then hp2.week_qty_last
     when 300 then hp2.week_qty_last
     when 900 then hp2.week_qty_last
     else hp2.week_qty_sum
     end week_quantity,
     --
     case hp2.supply_demand_code
     when 110 then hp2.period_qty_last
     when 120 then hp2.period_qty_last
     when 130 then hp2.period_qty_last
     when 150 then hp2.period_qty_last
     when 175 then hp2.period_qty_last
     when 177 then hp2.period_qty_last
     when 180 then hp2.period_qty_last
     when 183 then hp2.period_qty_last
     when 184 then hp2.period_qty_last
     when 185 then hp2.period_qty_last
     when 186 then hp2.period_qty_last
     when 190 then hp2.period_qty_last
     when 200 then hp2.period_qty_last
     when 210 then hp2.period_qty_last
     when 220 then hp2.period_qty_last
     when 230 then hp2.period_qty_last
     when 240 then hp2.period_qty_last
     when 250 then hp2.period_qty_last
     when 260 then hp2.period_qty_last
     when 270 then hp2.period_qty_last
     when 280 then hp2.period_qty_last
     when 290 then hp2.period_qty_last
     when 300 then hp2.period_qty_last
     when 900 then hp2.period_qty_last
     else hp2.period_qty_sum
     end period_quantity,
     --
     case hp2.supply_demand_code
     when 110 then hp2.year_qty_last
     when 120 then hp2.year_qty_last
     when 130 then hp2.year_qty_last
     when 150 then hp2.year_qty_last
     when 175 then hp2.year_qty_last
     when 177 then hp2.year_qty_last
     when 178 then hp2.year_qty_last
     when 180 then hp2.year_qty_last
     when 183 then hp2.year_qty_last
     when 184 then hp2.year_qty_last
     when 185 then hp2.year_qty_last
     when 186 then hp2.year_qty_last
     when 190 then hp2.year_qty_last
     when 200 then hp2.year_qty_last
     when 210 then hp2.year_qty_last
     when 220 then hp2.year_qty_last
     when 230 then hp2.year_qty_last
     when 240 then hp2.year_qty_last
     when 250 then hp2.year_qty_last
     when 260 then hp2.year_qty_last
     when 270 then hp2.year_qty_last
     when 280 then hp2.year_qty_last
     when 290 then hp2.year_qty_last
     when 300 then hp2.year_qty_last
     when 900 then hp2.year_qty_last
     else hp2.year_qty_sum
     end year_quantity,
     --
     -- values
     --
     hp2.standard_cost,
     hp2.value,
     --
     case hp2.supply_demand_code
     when 110 then hp2.week_value_last
     when 120 then hp2.week_value_last
     when 130 then hp2.week_value_last
     when 150 then hp2.week_value_last
     when 175 then hp2.week_value_last
     when 177 then hp2.week_value_last
     when 178 then hp2.week_value_last
     when 180 then hp2.week_value_last
     when 183 then hp2.week_value_last
     when 184 then hp2.week_value_last
     when 185 then hp2.week_value_last
     when 186 then hp2.week_value_last
     when 190 then hp2.week_value_last
     when 200 then hp2.week_value_last
     when 210 then hp2.week_value_last
     when 220 then hp2.week_value_last
     when 230 then hp2.week_value_last
     when 240 then hp2.week_value_last
     when 250 then hp2.week_value_last
     when 260 then hp2.week_value_last
     when 270 then hp2.week_value_last
     when 280 then hp2.week_value_last
     when 290 then hp2.week_value_last
     when 300 then hp2.week_value_last
     when 900 then hp2.week_value_last
     else hp2.week_value_sum
     end week_value,
     --
     case hp2.supply_demand_code
     when 110 then hp2.period_value_last
     when 120 then hp2.period_value_last
     when 130 then hp2.period_value_last
     when 150 then hp2.period_value_last
     when 175 then hp2.period_value_last
     when 177 then hp2.period_value_last
     when 178 then hp2.period_value_last
     when 180 then hp2.period_value_last
     when 183 then hp2.period_value_last
     when 184 then hp2.period_value_last
     when 185 then hp2.period_value_last
     when 186 then hp2.period_value_last
     when 190 then hp2.period_value_last
     when 200 then hp2.period_value_last
     when 210 then hp2.period_value_last
     when 220 then hp2.period_value_last
     when 230 then hp2.period_value_last
     when 240 then hp2.period_value_last
     when 250 then hp2.period_value_last
     when 260 then hp2.period_value_last
     when 270 then hp2.period_value_last
     when 280 then hp2.period_value_last
     when 290 then hp2.period_value_last
     when 300 then hp2.period_value_last
     when 900 then hp2.period_value_last
     else hp2.period_value_sum
     end period_value,
     --
     case hp2.supply_demand_code
     when 110 then hp2.year_value_last
     when 120 then hp2.year_value_last
     when 130 then hp2.year_value_last
     when 150 then hp2.year_value_last
     when 175 then hp2.year_value_last
     when 177 then hp2.year_value_last
     when 178 then hp2.year_value_last
     when 180 then hp2.year_value_last
     when 183 then hp2.year_value_last
     when 184 then hp2.year_value_last
     when 185 then hp2.year_value_last
     when 186 then hp2.year_value_last
     when 190 then hp2.year_value_last
     when 200 then hp2.year_value_last
     when 210 then hp2.year_value_last
     when 220 then hp2.year_value_last
     when 230 then hp2.year_value_last
     when 240 then hp2.year_value_last
     when 250 then hp2.year_value_last
     when 260 then hp2.year_value_last
     when 270 then hp2.year_value_last
     when 280 then hp2.year_value_last
     when 290 then hp2.year_value_last
     when 300 then hp2.year_value_last
     when 900 then hp2.year_value_last
     else hp2.year_value_sum
     end year_value,
     --
     --
     hp2.using_assemblies,
     -- item dff attributes
     &lp_item_dff_cols
     --
     --
     ltrim(to_char(hp2.supply_demand_code,'000')) || ' ' || hp2.supply_demand_type supply_demand_label,
     --
     case substr(:p_summary_level,1,1)
     when 'A' 
     then case 
          when hp2.wn <  xxen_msc_horizplan.get_week_bucket_cutoff_wn
          then to_char(hp2.bucket_date,'YYYY/MM/DD') || ' P:' || hp2.pn || ' W:' || hp2.wn || ' D:' || hp2.dn
          when hp2.wn >= xxen_msc_horizplan.get_week_bucket_cutoff_wn
          and  hp2.wn  < xxen_msc_horizplan.get_period_bucket_cutoff_wn
          then to_char(hp2.bucket_date,'YYYY/MM/DD') || ' W:' || hp2.wn || ' P:' || hp2.pn
          else to_char(hp2.bucket_date,'YYYY/MM/DD') || ' P:' || hp2.pn
          end
     when 'P' then to_char(hp2.bucket_date,'YYYY/MM/DD') || ' P:' || hp2.pn
     when 'W' then to_char(hp2.bucket_date,'YYYY/MM/DD') || ' P:' || hp2.pn || ' W:' || hp2.wn
              else to_char(hp2.bucket_date,'YYYY/MM/DD') || ' P:' || hp2.pn || ' W:' || hp2.wn || ' D:' || hp2.dn
     end bucket_label,
     --
     to_char(hp2.bucket_date,'YYYY') year_chart_label,
     'P:' || ltrim(to_char(hp2.pn,'000')) || ' ' || to_char(hp2.period_date,'DD-MON-YY') period_chart_label,
     case substr(:p_summary_level,1,1)
     when 'A'
     then case when hp2.wn >= xxen_msc_horizplan.get_period_bucket_cutoff_wn
          then 'P:' || ltrim(to_char(hp2.pn,'000')) || ' ' || to_char(hp2.period_date,'DD-MON-YY')
          else 'W:' || ltrim(to_char(hp2.wn,'000')) || ' ' || to_char(hp2.week_date,'DD-MON-YY')
          end 
     else  'W:' || ltrim(to_char(hp2.wn,'000')) || ' ' || to_char(hp2.week_date,'DD-MON-YY')
     end week_chart_label,
     case substr(:p_summary_level,1,1)
     when 'A'
     then case 
          when hp2.wn < xxen_msc_horizplan.get_week_bucket_cutoff_wn
          then 'D:' || ltrim(to_char(hp2.dn,'000')) || ' ' || to_char(hp2.bucket_date,'DD-MON-YY') 
          when hp2.wn >= xxen_msc_horizplan.get_week_bucket_cutoff_wn
          and  hp2.wn  < xxen_msc_horizplan.get_period_bucket_cutoff_wn
          then 'W:' || ltrim(to_char(hp2.wn,'000')) || ' ' || to_char(hp2.week_date,'DD-MON-YY')
          else 'P:' || ltrim(to_char(hp2.pn,'000')) || ' ' || to_char(hp2.period_date,'DD-MON-YY')
          end 
     else  'D:' || ltrim(to_char(hp2.dn,'000')) || ' ' || to_char(hp2.bucket_date,'DD-MON-YY')
     end day_chart_label,
     --
     row_number() over (partition by hp2.planning_instance,hp2.plan_name,hp2.aggregation_level,hp2.dashboard_metric,hp2.aggregation_level,hp2.operating_unit,hp2.organization,hp2.category,hp2.item,hp2.supply_demand_code,to_char(hp2.bucket_date,'YYYY') order by hp2.bucket_date) yn_seq,
     row_number() over (partition by hp2.planning_instance,hp2.plan_name,hp2.aggregation_level,hp2.dashboard_metric,hp2.aggregation_level,hp2.operating_unit,hp2.organization,hp2.category,hp2.item,hp2.supply_demand_code,hp2.pn order by hp2.bucket_date) pn_seq,
     row_number() over (partition by hp2.planning_instance,hp2.plan_name,hp2.aggregation_level,hp2.dashboard_metric,hp2.aggregation_level,hp2.operating_unit,hp2.organization,hp2.category,hp2.item,hp2.supply_demand_code,hp2.wn order by hp2.bucket_date) wn_seq
    from
      (select
        hp.planning_instance
       ,hp.plan_name
       ,hp.organization
       ,hp.organization_name
       ,hp.operating_unit
       ,hp.item
       ,hp.item_description
       ,hp.category_set
       ,hp.category
       ,hp.item_uom
       ,hp.report_uom
       ,hp.uom_conversion
       ,hp.make_buy
       ,hp.planner
       ,hp.buyer
       ,hp.standard_cost
       ,hp.using_assemblies
       ,hp.dashboard_metric
       ,hp.supply_demand_code
       ,hp.supply_demand_type
       ,hp.aggregation_level
       ,case hp.horizontal_plan_type_text
        when 'IU' then hp.operating_unit || ' - ' || hp.item
        when 'IA' then hp.item
        when 'CO' then replace(hp.organization,hp.planning_instance || ':','') || ' - ' || hp.category
        when 'CU' then hp.operating_unit || ' - ' || hp.category
        when 'CA' then hp.category
                  else replace(hp.organization,hp.planning_instance || ':','') || ' - ' || hp.item
        end  aggregation_label
       ,hp.bucket_date
       --
       ,hp.pn
       ,hp.wn
       ,hp.dn
       ,first_value(hp.bucket_date) over (partition by hp.planning_instance,hp.plan_name,hp.aggregation_level,hp.operating_unit,hp.organization,hp.category,hp.item,hp.supply_demand_code,hp.pn order by hp.bucket_date range between unbounded preceding and unbounded following) period_date
       ,first_value(hp.bucket_date) over (partition by hp.planning_instance,hp.plan_name,hp.aggregation_level,hp.operating_unit,hp.organization,hp.category,hp.item,hp.supply_demand_code,hp.wn order by hp.bucket_date range between unbounded preceding and unbounded following) week_date
       --
       ,hp.quantity
       ,last_value(hp.quantity) over (partition by hp.planning_instance,hp.plan_name,hp.aggregation_level,hp.operating_unit,hp.organization,hp.category,hp.item,hp.supply_demand_code,hp.pn order by hp.bucket_date range between unbounded preceding and unbounded following) period_qty_last
       ,last_value(hp.quantity) over (partition by hp.planning_instance,hp.plan_name,hp.aggregation_level,hp.operating_unit,hp.organization,hp.category,hp.item,hp.supply_demand_code,hp.wn order by hp.bucket_date range between unbounded preceding and unbounded following) week_qty_last
       ,last_value(hp.quantity) over (partition by hp.planning_instance,hp.plan_name,hp.aggregation_level,hp.operating_unit,hp.organization,hp.category,hp.item,hp.supply_demand_code,to_char(hp.bucket_date,'YYYY') order by hp.bucket_date range between unbounded preceding and unbounded following) year_qty_last
       ,sum(hp.quantity)        over (partition by hp.planning_instance,hp.plan_name,hp.aggregation_level,hp.operating_unit,hp.organization,hp.category,hp.item,hp.supply_demand_code,hp.pn) period_qty_sum
       ,sum(hp.quantity)        over (partition by hp.planning_instance,hp.plan_name,hp.aggregation_level,hp.operating_unit,hp.organization,hp.category,hp.item,hp.supply_demand_code,hp.wn) week_qty_sum
       ,sum(hp.quantity)        over (partition by hp.planning_instance,hp.plan_name,hp.aggregation_level,hp.operating_unit,hp.organization,hp.category,hp.item,hp.supply_demand_code,to_char(hp.bucket_date,'YYYY')) year_qty_sum
       --
       ,hp.value
       ,last_value(hp.value) over (partition by hp.planning_instance,hp.plan_name,hp.aggregation_level,hp.operating_unit,hp.organization,hp.category,hp.item,hp.supply_demand_code,hp.pn order by hp.bucket_date range between unbounded preceding and unbounded following) period_value_last
       ,last_value(hp.value) over (partition by hp.planning_instance,hp.plan_name,hp.aggregation_level,hp.operating_unit,hp.organization,hp.category,hp.item,hp.supply_demand_code,hp.wn order by hp.bucket_date range between unbounded preceding and unbounded following) week_value_last
       ,last_value(hp.value) over (partition by hp.planning_instance,hp.plan_name,hp.aggregation_level,hp.operating_unit,hp.organization,hp.category,hp.item,hp.supply_demand_code,to_char(hp.bucket_date,'YYYY') order by hp.bucket_date range between unbounded preceding and unbounded following) year_value_last
       ,sum(hp.value)        over (partition by hp.planning_instance,hp.plan_name,hp.aggregation_level,hp.operating_unit,hp.organization,hp.category,hp.item,hp.supply_demand_code,hp.pn) period_value_sum
       ,sum(hp.value)        over (partition by hp.planning_instance,hp.plan_name,hp.aggregation_level,hp.operating_unit,hp.organization,hp.category,hp.item,hp.supply_demand_code,hp.wn) week_value_sum
       ,sum(hp.value)        over (partition by hp.planning_instance,hp.plan_name,hp.aggregation_level,hp.operating_unit,hp.organization,hp.category,hp.item,hp.supply_demand_code,to_char(hp.bucket_date,'YYYY')) year_value_sum
       --
       ,hp.sr_instance_id
       ,hp.plan_id
       ,hp.organization_id
       ,hp.inventory_item_id
       ,hp.sr_inventory_item_id 
       from
         (select
           -- hp organization id would be -1 for all org aggregation, however not using this opton in this code as we always pass the list of Org IDs even for all orgs
           -- hp inventory item id will be negative for product family details when display product family details = True
           mai.instance_code             planning_instance
          ,mp.compile_designator         plan_name
          ,case when mmp.horizontal_plan_type_text in ('IU','IA','CU','CA') then '(Aggregated)' else decode(mmp.organization_id,-1,'All Orgs',mpo.organization_code) end organization
          ,case when mmp.horizontal_plan_type_text in ('IU','IA','CU','CA') then null else nvl(mtp.partner_name,'All Orgs') end organization_name
          ,case when mmp.horizontal_plan_type_text not in ('IA','CA') then mtp.operating_unit_name else '(Aggregated)' end operating_unit
          ,case when mmp.horizontal_plan_type_text not in ('CO','CU','CA')
           then case sign(mmp.inventory_item_id)
                when -1 then
                  (select mfq.char2
                   from   msc_form_query&a2m_dblink  mfq
                   where  mfq.query_id = abs(mmp.query_id)
                   and    mfq.number4  = mmp.plan_id
                   and    mfq.number3  = mmp.sr_instance_id
                   and    mfq.number6  = mmp.organization_id
                   and    mfq.number5  = mmp.inventory_item_id
                   and    rownum      <= 1
                  )
                else msi.item_name
                end
           else '(Aggregated)'
           end                           item
          ,case when mmp.horizontal_plan_type_text not in ('CO','CU','CA') then msi.description end item_description
          ,:p_cat_set_name category_set
          ,mic.category_name category
          ,case when mmp.horizontal_plan_type_text not in ('CO','CU','CA') then msi.uom_code end item_uom
          ,nvl(:p_uom_code,'Primary') report_uom
          ,nvl2(:p_uom_code,xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code),null) uom_conversion
          ,case when mmp.horizontal_plan_type_text not in ('CO','CU','CA') then msc_get_name.lookup_meaning&a2m_dblink ('MTL_PLANNING_MAKE_BUY',msi.planning_make_buy_code) end make_buy
          ,case when mmp.horizontal_plan_type_text not in ('CO','CU','CA') then msi.planner_code end planner
          ,case when mmp.horizontal_plan_type_text not in ('CO','CU','CA') then msi.buyer_name end buyer
          ,case when mmp.horizontal_plan_type_text not in ('IA','IU','CO','CU','CA') then msi.standard_cost end standard_cost
          ,case when mmp.horizontal_plan_type_text not in ('IA','IU','CO','CU','CA') then mmp.item_segments end using_assemblies
          ,:p_metric                    dashboard_metric
          ,ml.lookup_code               supply_demand_code
          ,ml.meaning                   supply_demand_type
          ,case mmp.horizontal_plan_type_text
           when 'IU' then 'Item: Operating Unit'
           when 'IA' then 'Item: All Organizations'
           when 'CO' then 'Category: Organization'
           when 'CU' then 'Category: Operating Unit'
           when 'CA' then 'Category: All Organizations'
                     else 'Item: Organization'
           end                          aggregation_level
          ,substr(mmp.organization_code,1,instr(mmp.organization_code,'|',1,1)-1)  pn
          ,substr(mmp.organization_code,instr(mmp.organization_code,'|',1,1)+1,length(mmp.organization_code)) wn
          ,mmp.bucket_date - (decode(mp.plan_id,-1,trunc(sysdate),trunc(mp.curr_start_date))-1) dn
          ,mmp.bucket_date bucket_date
          -- Quantity
          ,round(
           case ml.lookup_code
           -- common to SC and IO Horizontal Plans
           when 10  then mmp.quantity1  * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 20  then mmp.quantity2  * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 25  then mmp.quantity3  * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 30  then mmp.quantity4  * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 40  then mmp.quantity5  * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 45  then mmp.quantity6  * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 50  then mmp.quantity7  * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 70  then mmp.quantity8  * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 81  then mmp.quantity9  * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 83  then mmp.quantity10 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 85  then mmp.quantity11 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 87  then mmp.quantity12 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 89  then mmp.quantity13 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 90  then mmp.quantity14 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 95  then mmp.quantity15 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 100 then mmp.quantity16 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 105 then mmp.quantity17 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 110 then mmp.quantity18 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 120 then mmp.quantity19 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 130 then mmp.quantity20 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 140 then mmp.quantity21 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 150 then mmp.quantity22 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 160 then mmp.quantity23 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           -- SC HP CMRO_EAM_WO specific
           when 295 then mmp.quantity46 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 305 then mmp.quantity48 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 310 then mmp.quantity49 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 315 then mmp.quantity50 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 320 then mmp.quantity51 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 325 then mmp.quantity52 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 330 then mmp.quantity47 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 335 then mmp.quantity53 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 340 then mmp.quantity54 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 345 then mmp.quantity55 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 350 then mmp.quantity56 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           -- IO HP Specific
           when 175 then mmp.quantity25 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 177 then mmp.quantity26 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 178 then mmp.quantity36 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 180 then mmp.quantity19 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 183 then mmp.quantity37
           when 184 then mmp.quantity38
           when 185 then mmp.quantity39
           when 186 then mmp.quantity40
           when 190 then mmp.quantity27
           when 200 then mmp.quantity28
           when 210 then mmp.quantity24 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 220 then mmp.quantity29
           when 230 then mmp.quantity30
           when 240 then mmp.quantity31 * xxen_msc_horizplan.get_uom_conversion(msi.organization_id,msi.inventory_item_id,:p_uom_code,msi.uom_code)
           when 250 then mmp.quantity32
           when 260 then mmp.quantity33
           when 270 then mmp.quantity34
           when 280 then mmp.quantity35
           when 290 then mmp.quantity41
           when 300 then mmp.quantity42
           -- common user defined
           when 500 then mmp.quantity45 -- this could be a qty or some other unit, so we won't uom convert this
           -- PAB Days Stock Cover is captured in quantity 43
           -- However for higher level aggreagations it needs to be reclated across the aggregation level
           when 900 then mmp.quantity43
           end
           , nvl(to_number('&p_decimal_places'),1)
           )  quantity
          -- Value
          ,case ml.lookup_code
           when 10  then mmp.quantity1  * nvl(msi.standard_cost,0)
           when 20  then mmp.quantity2  * nvl(msi.standard_cost,0)
           when 25  then mmp.quantity3  * nvl(msi.standard_cost,0)
           when 30  then mmp.quantity4  * nvl(msi.standard_cost,0)
           when 40  then mmp.quantity5  * nvl(msi.standard_cost,0)
           when 45  then mmp.quantity6  * nvl(msi.standard_cost,0)
           when 50  then mmp.quantity7  * nvl(msi.standard_cost,0)
           when 70  then mmp.quantity8  * nvl(msi.standard_cost,0)
           when 81  then mmp.quantity9  * nvl(msi.standard_cost,0)
           when 83  then mmp.quantity10 * nvl(msi.standard_cost,0)
           when 85  then mmp.quantity11 * nvl(msi.standard_cost,0)
           when 87  then mmp.quantity12 * nvl(msi.standard_cost,0)
           when 89  then mmp.quantity13 * nvl(msi.standard_cost,0)
           when 90  then mmp.quantity14 * nvl(msi.standard_cost,0)
           when 95  then mmp.quantity15 * nvl(msi.standard_cost,0)
           when 100 then mmp.quantity16 * nvl(msi.standard_cost,0)
           when 105 then mmp.quantity17 * nvl(msi.standard_cost,0)
           when 110 then mmp.quantity18 * nvl(msi.standard_cost,0)
           when 120 then mmp.quantity19 * nvl(msi.standard_cost,0)
           when 130 then mmp.quantity20 * nvl(msi.standard_cost,0)
           when 140 then mmp.quantity21 * nvl(msi.standard_cost,0)
           when 150 then mmp.quantity22 * nvl(msi.standard_cost,0)
           when 160 then mmp.quantity23 * nvl(msi.standard_cost,0)
           -- SC HP CMRO_EAM_WO specific
           when 295 then mmp.quantity46 * nvl(msi.standard_cost,0)
           when 305 then mmp.quantity48 * nvl(msi.standard_cost,0)
           when 310 then mmp.quantity49 * nvl(msi.standard_cost,0)
           when 315 then mmp.quantity50 * nvl(msi.standard_cost,0)
           when 320 then mmp.quantity51 * nvl(msi.standard_cost,0)
           when 325 then mmp.quantity52 * nvl(msi.standard_cost,0)
           when 330 then mmp.quantity47 * nvl(msi.standard_cost,0)
           when 335 then mmp.quantity53 * nvl(msi.standard_cost,0)
           when 340 then mmp.quantity54 * nvl(msi.standard_cost,0)
           when 345 then mmp.quantity55 * nvl(msi.standard_cost,0)
           when 350 then mmp.quantity56 * nvl(msi.standard_cost,0)
           -- IO HP Specific
           when 175 then mmp.quantity25 * nvl(msi.standard_cost,0)
           when 177 then mmp.quantity26 * nvl(msi.standard_cost,0)
           when 178 then mmp.quantity36 * nvl(msi.standard_cost,0)
           when 180 then mmp.quantity19 * nvl(msi.standard_cost,0)
           when 183 then mmp.quantity37
           when 184 then mmp.quantity38
           when 185 then mmp.quantity39
           when 186 then mmp.quantity40
           when 190 then mmp.quantity27
           when 200 then mmp.quantity28
           when 210 then mmp.quantity24 * nvl(msi.standard_cost,0)
           when 220 then mmp.quantity29
           when 230 then mmp.quantity30
           when 240 then mmp.quantity31 * nvl(msi.standard_cost,0)
           when 250 then mmp.quantity32
           when 260 then mmp.quantity33
           when 270 then mmp.quantity34
           when 280 then mmp.quantity35
           when 290 then mmp.quantity41
           when 300 then mmp.quantity42
           -- common user defined
           when 500 then mmp.quantity45 -- this could be a qty or some other unit, so we won't include in std cost
           -- PAB Days Stock Cover
           when 900 then null -- No value for the Days Stock Cover metric
           end value
           --
          ,mmp.sr_instance_id
          ,mmp.plan_id
          ,case when mmp.horizontal_plan_type_text in ('IU','IA','CU','CA') then null else mmp.organization_id end organization_id
          ,case when mmp.horizontal_plan_type_text not in ('CO','CU','CA') then msi.inventory_item_id end inventory_item_id
          ,case when mmp.horizontal_plan_type_text not in ('CO','CU','CA') then msi.sr_inventory_item_id end sr_inventory_item_id
          ,case when mmp.horizontal_plan_type_text not in ('IA','CA') then mtp.operating_unit end operating_unit_id
          ,mmp.horizontal_plan_type_text
          from
           mfg_sd_lookups                          ml,
           msc_apps_instances&a2m_dblink           mai,
           msc_plans&a2m_dblink                    mp,
           msc_plan_organizations&a2m_dblink       mpo,
           msc_system_items&a2m_dblink             msi,
           msc_item_categories&a2m_dblink          mi
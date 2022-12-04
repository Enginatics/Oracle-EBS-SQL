/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MSC Horizontal Plan
-- Description: ASCP: Horizontal Plan from the Planners Workbench.
-- Excel Examle Output: https://www.enginatics.com/example/msc-horizontal-plan/
-- Library Link: https://www.enginatics.com/reports/msc-horizontal-plan/
-- Run Report: https://demo.enginatics.com/

with
  hp3 as
  ( select
     hp2.planning_instance,
     hp2.plan_name,
     hp2.organization,
     hp2.item,
     hp2.item_description,
     -- item dff attributes
     &lp_item_dff_cols
     hp2.category_set,
     hp2.category,
     hp2.make_buy "Make/Buy",
     hp2.planner,
     hp2.buyer,
     hp2.using_assemblies,
     hp2.supply_demand_code,
     hp2.supply_demand_type,
     decode(substr(:p_summary_level,1,1),'P',hp2.period_date,'W',hp2.week_date,hp2.bucket_date) bucket_date,
     hp2.pn period_num,
     hp2.wn week_num,
     hp2.dn day_num,
     case substr(:p_summary_level,1,1)
     when 'P' then case hp2.supply_demand_code
                   when 110 then hp2.period_qty_last
                   when 130 then hp2.period_qty_last
                   when 150 then hp2.period_qty_last
                   when 178 then hp2.period_qty_last
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
                   when 250 then hp2.period_qty_last
                   when 260 then hp2.period_qty_last
                   when 270 then hp2.period_qty_last
                   when 280 then hp2.period_qty_last
                   when 290 then hp2.period_qty_last
                   when 300 then hp2.period_qty_last
                            else hp2.period_qty_sum
                   end
     when 'W' then case hp2.supply_demand_code
                   when 110 then hp2.week_qty_last
                   when 130 then hp2.week_qty_last
                   when 150 then hp2.week_qty_last
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
                   when 250 then hp2.week_qty_last
                   when 260 then hp2.week_qty_last
                   when 270 then hp2.week_qty_last
                   when 280 then hp2.week_qty_last
                   when 290 then hp2.week_qty_last
                   when 300 then hp2.week_qty_last
                            else hp2.week_qty_sum
                   end
     else hp2.quantity
     end  quantity,
     --
     case hp2.supply_demand_code
     when 110 then hp2.week_qty_last
     when 130 then hp2.week_qty_last
     when 150 then hp2.week_qty_last
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
     when 250 then hp2.week_qty_last
     when 260 then hp2.week_qty_last
     when 270 then hp2.week_qty_last
     when 280 then hp2.week_qty_last
     when 290 then hp2.week_qty_last
     when 300 then hp2.week_qty_last
              else hp2.week_qty_sum
     end week_quantity,
     case hp2.supply_demand_code
     when 110 then hp2.period_qty_last
     when 130 then hp2.period_qty_last
     when 150 then hp2.period_qty_last
     when 178 then hp2.period_qty_last
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
     when 250 then hp2.period_qty_last
     when 260 then hp2.period_qty_last
     when 270 then hp2.period_qty_last
     when 280 then hp2.period_qty_last
     when 290 then hp2.period_qty_last
     when 300 then hp2.period_qty_last
              else hp2.period_qty_sum
     end period_quantity,
     case hp2.supply_demand_code
     when 110 then hp2.year_qty_last
     when 130 then hp2.year_qty_last
     when 150 then hp2.year_qty_last
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
     when 250 then hp2.year_qty_last
     when 260 then hp2.year_qty_last
     when 270 then hp2.year_qty_last
     when 280 then hp2.year_qty_last
     when 290 then hp2.year_qty_last
     when 300 then hp2.year_qty_last
              else hp2.year_qty_sum
     end year_quantity,
     --
     ltrim(to_char(hp2.supply_demand_code,'000')) || ' ' || hp2.supply_demand_type supply_demand_label,
     to_char(decode(substr(:p_summary_level,1,1),'P',hp2.period_date,'W',hp2.week_date,hp2.bucket_date),'YYYY/MM/DD')
     || ' P:' || hp2.pn
     || decode(substr(:p_summary_level,1,1),'P',null,' W:' || hp2.wn)
     || decode(substr(:p_summary_level,1,1),'D',' D:' || hp2.dn) bucket_label,
     to_char(hp2.bucket_date,'YYYY') year_char,
     'P:' || ltrim(to_char(hp2.pn,'00')) || ' ' ||
     case when hp2.pn > 0
     then
        (select
         cal.period_name
         from
         msc_period_start_dates&a2m_dblink cal,
         msc_trading_partners&a2m_dblink mtp
         where
         mtp.sr_tp_id = hp2.organization_id and
         mtp.sr_instance_id  = hp2.sr_instance_id and
         mtp.partner_type    = 3 and
         mtp.calendar_code   = cal.calendar_code and
         mtp.sr_instance_id  = cal.sr_instance_id and
         mtp.calendar_exception_set_id = cal.exception_set_id and
         trunc(hp2.period_date) between cal.period_start_date and cal.next_date-1
        )
     else null
     end period_char,
     'W:' || ltrim(to_char(hp2.wn,'000')) || ' ' || to_char(hp2.week_date,'DD-MON-YY') week_char
    from
      (select
        hp.planning_instance
       ,hp.plan_name
       ,hp.organization
       ,hp.item
       ,hp.item_description
       ,hp.category_set
       ,hp.category
       ,hp.make_buy
       ,hp.planner
       ,hp.buyer
       ,hp.using_assemblies
       ,hp.supply_demand_code
       ,hp.supply_demand_type
       ,hp.pn
       ,hp.wn
       ,hp.dn
       ,hp.bucket_date
       ,hp.quantity
       ,first_value(hp.bucket_date) over (partition by hp.planning_instance, hp.plan_name, hp.organization, hp.item, hp.supply_demand_code, hp.pn order by hp.bucket_date range between unbounded preceding and unbounded following) period_date
       ,first_value(hp.bucket_date) over (partition by hp.planning_instance, hp.plan_name, hp.organization, hp.item, hp.supply_demand_code, hp.wn order by hp.bucket_date range between unbounded preceding and unbounded following) week_date
       ,last_value(hp.bucket_date) over (partition by hp.planning_instance, hp.plan_name, hp.organization, hp.item, hp.supply_demand_code, hp.pn order by hp.bucket_date range between unbounded preceding and unbounded following) period_date_last
       ,last_value(hp.bucket_date) over (partition by hp.planning_instance, hp.plan_name, hp.organization, hp.item, hp.supply_demand_code, hp.wn order by hp.bucket_date range between unbounded preceding and unbounded following) week_date_last
       ,last_value(hp.quantity) over (partition by hp.planning_instance, hp.plan_name, hp.organization, hp.item, hp.supply_demand_code, hp.pn order by hp.bucket_date range between unbounded preceding and unbounded following) period_qty_last
       ,last_value(hp.quantity) over (partition by hp.planning_instance, hp.plan_name, hp.organization, hp.item, hp.supply_demand_code, hp.wn order by hp.bucket_date range between unbounded preceding and unbounded following) week_qty_last
       ,last_value(hp.quantity) over (partition by hp.planning_instance, hp.plan_name, hp.organization, hp.item, hp.supply_demand_code, to_char(hp.bucket_date,'YYYY') order by hp.bucket_date range between unbounded preceding and unbounded following) year_qty_last
       ,sum(hp.quantity) over (partition by hp.planning_instance, hp.plan_name, hp.organization, hp.item, hp.supply_demand_code, hp.pn) period_qty_sum
       ,sum(hp.quantity) over (partition by hp.planning_instance, hp.plan_name, hp.organization, hp.item, hp.supply_demand_code, hp.wn) week_qty_sum
       ,sum(hp.quantity) over (partition by hp.planning_instance, hp.plan_name, hp.organization, hp.item, hp.supply_demand_code, to_char(hp.bucket_date,'YYYY')) year_qty_sum
       ,hp.sr_instance_id
       ,hp.plan_id
       ,hp.organization_id
       ,hp.inventory_item_id
       ,hp.sr_inventory_item_id
       from
         (select
           mai.instance_code             planning_instance
          ,mp.compile_designator         plan_name
          ,case mmp.organization_id
           when -1 then (select mfq.char1
                         from   msc_form_query&a2m_dblink  mfq
                         where  mfq.query_id = mmp.query_id
                         and    mfq.number4  = mmp.plan_id
                         and    mfq.number3  = mmp.sr_instance_id
                         and    mfq.number6  = mmp.organization_id
                         and    mfq.number5  = mmp.inventory_item_id
                         and    rownum      <= 1
                        )
                   else mpo.organization_code
           end                           organization
          ,case sign(mmp.inventory_item_id)
           when -1 then (select mfq.char2
                         from   msc_form_query&a2m_dblink  mfq
                         where  mfq.query_id = mmp.query_id
                         and    mfq.number4  = mmp.plan_id
                         and    mfq.number3  = mmp.sr_instance_id
                         and    mfq.number6  = mmp.organization_id
                         and    mfq.number5  = mmp.inventory_item_id
                         and    rownum      <= 1
                        )
                   else msi.item_name
           end                           item
          ,msi.description               item_description
          ,mcs.category_set_name         category_set
          ,mic.category_name             category
          ,msc_get_name.lookup_meaning&a2m_dblink ('MTL_PLANNING_MAKE_BUY',msi.planning_make_buy_code) make_buy
          ,msi.planner_code              planner
          ,msi.buyer_name                buyer
          ,mmp.item_segments             using_assemblies
          ,ml.lookup_code                supply_demand_code
          ,ml.meaning                    supply_demand_type
          ,substr(mmp.organization_code,1,instr(mmp.organization_code,'|',1,1)-1)  pn
          ,substr(mmp.organization_code,instr(mmp.organization_code,'|',1,1)+1,length(mmp.organization_code)) wn
          ,(dense_rank() over (order by mmp.bucket_date))-1 dn
          ,mmp.bucket_date bucket_date
          ,round(
           case ml.lookup_code
           when 10  then mmp.quantity1
           when 20  then mmp.quantity2
           when 25  then mmp.quantity3
           when 30  then mmp.quantity4
           when 40  then mmp.quantity5
           when 45  then mmp.quantity6
           when 50  then mmp.quantity7
           when 70  then mmp.quantity8
           when 81  then mmp.quantity9
           when 83  then mmp.quantity10
           when 85  then mmp.quantity11
           when 87  then mmp.quantity12
           when 89  then mmp.quantity13
           when 90  then mmp.quantity14
           when 95  then mmp.quantity15
           when 100 then mmp.quantity16
           when 105 then mmp.quantity17
           when 110 then mmp.quantity18
           when 120 then mmp.quantity19
           when 180 then mmp.quantity19
           when 130 then mmp.quantity20
           when 140 then mmp.quantity21
           when 150 then mmp.quantity22
           when 160 then mmp.quantity23
           when 210 then mmp.quantity24
           when 175 then mmp.quantity25
           when 177 then mmp.quantity26
           when 190 then mmp.quantity27
           when 200 then mmp.quantity28
           when 220 then mmp.quantity29
           when 230 then mmp.quantity30
           when 240 then mmp.quantity31
           when 250 then mmp.quantity32
           when 260 then mmp.quantity33
           when 270 then mmp.quantity34
           when 280 then mmp.quantity35
           when 178 then mmp.quantity36
           when 183 then mmp.quantity37
           when 184 then mmp.quantity38
           when 185 then mmp.quantity39
           when 186 then mmp.quantity40
           when 290 then mmp.quantity41
           when 300 then mmp.quantity42
           -- columns 43,44 are not populated by msc_horizontal_plan_sc
           when 500 then mmp.quantity45
           when 295 then mmp.quantity46
           when 330 then mmp.quantity47
           when 305 then mmp.quantity48
           when 310 then mmp.quantity49
           when 315 then mmp.quantity50
           when 320 then mmp.quantity51
           when 325 then mmp.quantity52
           when 335 then mmp.quantity53
           when 340 then mmp.quantity54
           when 345 then mmp.quantity55
           when 350 then mmp.quantity56
           end,nvl(to_number('&p_decimal_places'),1))  quantity
          ,mmp.sr_instance_id
          ,mmp.plan_id
          ,case mmp.organization_id
           when -1 then (select mfq.number2
                         from   msc_form_query&a2m_dblink  mfq
                         where  mfq.query_id = mmp.query_id
                         and    mfq.number4  = mmp.plan_id
                         and    mfq.number3  = mmp.sr_instance_id
                         and    mfq.number6  = mmp.organization_id
                         and    mfq.number5  = mmp.inventory_item_id
                         and    rownum      <= 1
                        )
                   else mmp.organization_id
           end organization_id
          ,msi.inventory_item_id
          ,msi.sr_inventory_item_id
          --
          from
           mfg_lookups&a2m_dblink                  ml,
           msc_apps_instances&a2m_dblink           mai,
           msc_plans&a2m_dblink                    mp,
           msc_plan_organizations&a2m_dblink       mpo,
           msc_system_items&a2m_dblink             msi,
           msc_item_categories&a2m_dblink          mic,
           msc_category_sets&a2m_dblink            mcs,
           msc_material_plans&a2m_dblink           mmp,
           dual&a2m_dblink d
          where
              mmp.sr_instance_id     = mai.instance_id
          and mmp.sr_instance_id     = mp.sr_instance_id
          and mmp.plan_id            = mp.plan_id
          --
          and mmp.sr_instance_id     = mpo.sr_instance_id
          and mmp.plan_id            = mpo.plan_id
          and decode(mmp.organization_id,-1,mp.organization_id,mmp.organization_id)
                                     = mpo.organization_id
          --
          and mmp.sr_instance_id     = msi.sr_instance_id
          and mmp.plan_id            = msi.plan_id
          and decode(mmp.organization_id,-1,mp.organization_id,mmp.organization_id)
                                     = msi.organization_id
          and abs(mmp.inventory_item_id)
                                     = msi.inventory_item_id
          --
          and msi.sr_instance_id     = mic.sr_instance_id
          and msi.organization_id    = mic.organization_id
          and msi.inventory_item_id  = mic.inventory_item_id
          and mic.sr_instance_id     = mcs.sr_instance_id
          and mic.category_set_id    = mcs.category_set_id
          and mcs.category_set_name  = :p_cat_set_name
          --
          and ml.lookup_type  = '&msc_lookup_type'
          and ml.lookup_code in (&msc_lookup_codes)
          and (   (    nvl('&p_disp_pf','N') = 'Y'
                   and mmp.inventory_item_id > 0
                   and msi.bom_item_type in (2,5)
                   and ml.lookup_code in (20,70,90,100,110)
                  )
               or
                  (    nvl('&p_disp_pf','N') != 'Y'
                   or  mmp.inventory_item_id < 0
                   or  msi.bom_item_type not in (2,5)
                  )
              )
          --
          and 1=1
         ) hp
      ) hp2
    where
      hp2.bucket_date = decode(substr(:p_summary_level,1,1),'P',hp2.period_date_last,'W',hp2.week_date_last,hp2.bucket_date)
  )
select
 hp3.*
from
  hp3
order by
 hp3.planning_instance
,hp3.plan_name
,hp3.organization
,hp3.item
,hp3.supply_demand_code
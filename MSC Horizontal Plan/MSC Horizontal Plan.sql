/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
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
     hp2.planning_instance
    ,hp2.plan_name
    ,hp2.organization
    ,hp2.item
    ,hp2.category_set
    ,hp2.category_name
    ,hp2.make_buy "Make/Buy"
    ,hp2.planner
    ,hp2.buyer
    ,hp2.using_assemblies
    ,hp2.supply_demand_code
    ,hp2.supply_demand_type
    ,to_char(decode(substr(:p_summary_level,1,1),'P',hp2.pe_date,'W',hp2.we_date,hp2.bucket_date),'YYYY/MM/DD') bucket_date
    ,case substr(:p_summary_level,1,1)
     when 'P' then case hp2.supply_demand_code
                   when 110 then hp2.pe_qty_last
                   when 130 then hp2.pe_qty_last
                   when 150 then hp2.pe_qty_last
                   when 178 then hp2.pe_qty_last
                   when 180 then hp2.pe_qty_last
                   when 183 then hp2.pe_qty_last
                   when 184 then hp2.pe_qty_last
                   when 185 then hp2.pe_qty_last
                   when 186 then hp2.pe_qty_last
                   when 190 then hp2.pe_qty_last
                   when 200 then hp2.pe_qty_last
                   when 210 then hp2.pe_qty_last
                   when 220 then hp2.pe_qty_last
                   when 230 then hp2.pe_qty_last
                   when 250 then hp2.pe_qty_last
                   when 260 then hp2.pe_qty_last
                   when 270 then hp2.pe_qty_last
                   when 280 then hp2.pe_qty_last
                   when 290 then hp2.pe_qty_last
                   when 300 then hp2.pe_qty_last
                            else hp2.pe_qty_sum
                   end
     when 'W' then case hp2.supply_demand_code
                   when 110 then hp2.we_qty_last
                   when 130 then hp2.we_qty_last
                   when 150 then hp2.we_qty_last
                   when 178 then hp2.we_qty_last
                   when 180 then hp2.we_qty_last
                   when 183 then hp2.we_qty_last
                   when 184 then hp2.we_qty_last
                   when 185 then hp2.we_qty_last
                   when 186 then hp2.we_qty_last
                   when 190 then hp2.we_qty_last
                   when 200 then hp2.we_qty_last
                   when 210 then hp2.we_qty_last
                   when 220 then hp2.we_qty_last
                   when 230 then hp2.we_qty_last
                   when 250 then hp2.we_qty_last
                   when 260 then hp2.we_qty_last
                   when 270 then hp2.we_qty_last
                   when 280 then hp2.we_qty_last
                   when 290 then hp2.we_qty_last
                   when 300 then hp2.we_qty_last
                            else hp2.we_qty_sum
                   end
     else hp2.quantity
     end  quantity  
    from
      (select
        hp.planning_instance
       ,hp.plan_name
       ,hp.organization
       ,hp.item
       ,hp.category_set
       ,hp.category_name
       ,hp.make_buy
       ,hp.planner
       ,hp.buyer
       ,hp.using_assemblies
       ,hp.supply_demand_code
       ,hp.supply_demand_type
       ,hp.pn
       ,hp.wn
       ,hp.bucket_date
       ,hp.quantity
       ,max(hp.bucket_date) keep (dense_rank last order by hp.bucket_date) over (partition by hp.planning_instance, hp.plan_name, hp.organization, hp.item, hp.supply_demand_code, hp.pn) pe_date
       ,max(hp.bucket_date) keep (dense_rank last order by hp.bucket_date) over (partition by hp.planning_instance, hp.plan_name, hp.organization, hp.item, hp.supply_demand_code, hp.wn) we_date
       ,max(hp.quantity) keep (dense_rank last order by hp.bucket_date) over (partition by hp.planning_instance, hp.plan_name, hp.organization, hp.item, hp.supply_demand_code, hp.pn) pe_qty_last
       ,max(hp.quantity) keep (dense_rank last order by hp.bucket_date) over (partition by hp.planning_instance, hp.plan_name, hp.organization, hp.item, hp.supply_demand_code, hp.wn) we_qty_last
       ,sum(hp.quantity) over (partition by hp.planning_instance, hp.plan_name, hp.organization, hp.item, hp.supply_demand_code, hp.pn) pe_qty_sum
       ,sum(hp.quantity) over (partition by hp.planning_instance, hp.plan_name, hp.organization, hp.item, hp.supply_demand_code, hp.wn) we_qty_sum  
       from
         (select
           mai.instance_code             planning_instance
          ,mp.compile_designator         plan_name
          ,case mmp.organization_id
           when -1 then (select mfq.char1
                         from   msc_form_query  mfq
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
                         from   msc_form_query  mfq
                         where  mfq.query_id = mmp.query_id
                         and    mfq.number4  = mmp.plan_id
                         and    mfq.number3  = mmp.sr_instance_id
                         and    mfq.number6  = mmp.organization_id
                         and    mfq.number5  = mmp.inventory_item_id
                         and    rownum      <= 1
                        )
                   else msi.item_name
           end                           item
          ,mcs.category_set_name         category_set
          ,mic.category_name
          ,msc_get_name.lookup_meaning ('MTL_PLANNING_MAKE_BUY',msi.planning_make_buy_code) make_buy
          ,msi.planner_code              planner
          ,msi.buyer_name                buyer
          ,mmp.item_segments             using_assemblies
          ,ml.lookup_code                supply_demand_code
          ,ml.meaning                    supply_demand_type
          ,substr(mmp.organization_code,1,instr(mmp.organization_code,'|',1,1)-1)                             pn
          ,substr(mmp.organization_code,instr(mmp.organization_code,'|',1,1)+1,length(mmp.organization_code)) wn
          ,mmp.bucket_date bucket_date
          ,round(
           CASE ml.lookup_code
           WHEN 10  THEN mmp.quantity1
           WHEN 20  THEN mmp.quantity2 
           WHEN 25  THEN mmp.quantity3 
           WHEN 30  THEN mmp.quantity4
           WHEN 40  THEN mmp.quantity5
           WHEN 45  THEN mmp.quantity6
           WHEN 50  THEN mmp.quantity7
           WHEN 70  THEN mmp.quantity8
           WHEN 81  THEN mmp.quantity9
           WHEN 83  THEN mmp.quantity10
           WHEN 85  THEN mmp.quantity11
           WHEN 87  THEN mmp.quantity12
           WHEN 89  THEN mmp.quantity13
           WHEN 90  THEN mmp.quantity14
           WHEN 95  THEN mmp.quantity15
           WHEN 100 THEN mmp.quantity16
           WHEN 105 THEN mmp.quantity17
           WHEN 110 THEN mmp.quantity18
           WHEN 120 THEN mmp.quantity19
           WHEN 180 THEN mmp.quantity19
           WHEN 130 THEN mmp.quantity20
           WHEN 140 THEN mmp.quantity21
           WHEN 150 THEN mmp.quantity22
           WHEN 160 THEN mmp.quantity23
           WHEN 210 THEN mmp.quantity24
           WHEN 175 THEN mmp.quantity25
           WHEN 177 THEN mmp.quantity26
           WHEN 190 THEN mmp.quantity27
           WHEN 200 THEN mmp.quantity28
           WHEN 220 THEN mmp.quantity29
           WHEN 230 THEN mmp.quantity30
           WHEN 240 THEN mmp.quantity31
           WHEN 250 THEN mmp.quantity32
           WHEN 260 THEN mmp.quantity33
           WHEN 270 THEN mmp.quantity34
           WHEN 280 THEN mmp.quantity35
           WHEN 178 THEN mmp.quantity36
           WHEN 183 THEN mmp.quantity37
           WHEN 184 THEN mmp.quantity38
           WHEN 185 THEN mmp.quantity39
           WHEN 186 THEN mmp.quantity40
           WHEN 290 THEN mmp.quantity41
           WHEN 300 THEN mmp.quantity42
           -- Columns 43,44 are not populated by MSC_HORIZONTAL_PLAN_SC
           WHEN 500 THEN mmp.quantity45
           WHEN 295 THEN mmp.quantity46
           WHEN 330 THEN mmp.quantity47
           WHEN 305 THEN mmp.quantity48
           WHEN 310 THEN mmp.quantity49
           WHEN 315 THEN mmp.quantity50
           WHEN 320 THEN mmp.quantity51
           WHEN 325 THEN mmp.quantity52
           WHEN 335 THEN mmp.quantity53
           WHEN 340 THEN mmp.quantity54
           WHEN 345 THEN mmp.quantity55
           WHEN 350 THEN mmp.quantity56
           END,nvl(to_number('&p_decimal_places'),1))  quantity
          --
          from 
           mfg_lookups                  ml,
           msc_apps_instances           mai,
           msc_plans                    mp,
           msc_plan_organizations       mpo,
           msc_system_items             msi,
           msc_item_categories          mic,
           msc_category_sets            mcs,
           msc_material_plans           mmp,
		   dual d
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
  )
select 
 hp4.*
from
  hp3
  pivot 
  ( max(quantity) for bucket_date in ( &pivot_columns ) 
  ) hp4
order by
 hp4.planning_instance
,hp4.plan_name
,hp4.organization
,hp4.item 
,hp4.supply_demand_code
/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MSC Vertical Plan
-- Description: ASCP: Vertical Plan from the Planners Workbench.
-- Excel Examle Output: https://www.enginatics.com/example/msc-vertical-plan/
-- Library Link: https://www.enginatics.com/reports/msc-vertical-plan/
-- Run Report: https://demo.enginatics.com/

select
 vp.*
from
(
select
 :p_instance_code planning_instance,
 :p_plan_name plan,
 mvpv.organization_code,
 nvl2(mvpv.project_id,msc_get_name.project&a2m_dblink (mvpv.project_id,mvpv.organization_id,mvpv.plan_id,mvpv.sr_instance_id),null) project_number,
 nvl2(mvpv.task_id,msc_get_name.task&a2m_dblink (mvpv.task_id,mvpv.project_id,mvpv.organization_id,mvpv.plan_id,mvpv.sr_instance_id),null) task_number,
 -- custom attributes
 &lp_custom_attributes
 --
 mvpv.item_segments item,
 -- item dff attributes
 &lp_item_dff_cols
 decode(mvpv.dummy_sort,1,'1. Onhand',decode(mvpv.source_flag,1,'2. Supply','3. Demand')) source,
 mvpv.order_type_text order_type,
 mvpv.order_number,
 trunc(mvpv.new_due_date) new_due_date,
 mvpv.quantity_rate quantity,
 sum(mvpv.quantity_rate) over
 (partition by mvpv.sr_instance_id,mvpv.plan_id,mvpv.organization_id,mvpv.inventory_item_id
  order by  mvpv.new_due_date, mvpv.dummy_sort,mvpv.source_flag,mvpv.source_flag,mvpv.order_type,mvpv.order_number,mvpv.transaction_id
 ) cumulative_quantity,
 mvpv.description,
 --
 mcs.category_set_name category_set,
 mic.category_name category,
 mvpv.part_condition,
 mvpv.probability,
 mvpv.product_family_name,
 mvpv.using_requirement_quantity,
 mvpv.transaction_id,
 row_number() over
 (partition by mvpv.sr_instance_id,mvpv.plan_id,mvpv.organization_id,mvpv.inventory_item_id
  order by mvpv.new_due_date, mvpv.dummy_sort,mvpv.source_flag,mvpv.source_flag,mvpv.order_type,mvpv.order_number,mvpv.transaction_id
 ) seq,
 case when trunc(mvpv.new_due_date) <= trunc(mp.curr_start_date)-1
 then to_char(mp.curr_start_date-1,'YYYY')
 else to_char(mvpv.new_due_date,'YYYY')
 end year_char,
 'P:'|| case when trunc(mvpv.new_due_date) <= trunc(mp.curr_start_date)-1
        then '00'
        else ltrim(to_char(xxen_msc_horizplan.get_period_num(mvpv.plan_id,mvpv.new_due_date),'00')) || ' ' ||
        (select
         cal.period_name
         from
         msc_period_start_dates&a2m_dblink cal,
         msc_trading_partners&a2m_dblink mtp
         where
         mtp.sr_tp_id = mvpv.organization_id and
         mtp.sr_instance_id  = mvpv.sr_instance_id and
         mtp.partner_type    = 3 and
         mtp.calendar_code   = cal.calendar_code and
         mtp.sr_instance_id  = cal.sr_instance_id and
         mtp.calendar_exception_set_id = cal.exception_set_id and
         trunc(mvpv.new_due_date) between cal.period_start_date and cal.next_date-1
        )
        end  period_char,
 'W:'|| case when trunc(mvpv.new_due_date) <= trunc(mp.curr_start_date)-1
        then '000'
        else ltrim(to_char(xxen_msc_horizplan.get_week_num(mvpv.plan_id,mvpv.new_due_date),'000')) || ' ' ||
        (select
         to_char(cal.week_start_date,'DD-MON-YY')
         from
         msc_cal_week_start_dates&a2m_dblink cal,
         msc_trading_partners&a2m_dblink mtp
         where
         mtp.sr_tp_id = mvpv.organization_id and
         mtp.sr_instance_id  = mvpv.sr_instance_id and
         mtp.partner_type    = 3 and
         mtp.calendar_code   = cal.calendar_code and
         mtp.sr_instance_id  = cal.sr_instance_id and
         mtp.calendar_exception_set_id = cal.exception_set_id and
         trunc(mvpv.new_due_date) between cal.week_start_date and cal.next_date-1
        )
        end week_char,
 case when trunc(mvpv.new_due_date) <= trunc(mp.curr_start_date)-1
 then trunc(mp.curr_start_date)-1
 else trunc(mvpv.new_due_date)
 end bucket_date
from
 msc_vertical_plan_v&a2m_dblink    mvpv,
 msc_apps_instances&a2m_dblink     mai,
 msc_plans&a2m_dblink              mp,
 msc_system_items&a2m_dblink       msi,
 msc_item_categories&a2m_dblink    mic,
 msc_category_sets&a2m_dblink      mcs
where
 mvpv.sr_instance_id       = mai.instance_id and
 mvpv.sr_instance_id       = mp.sr_instance_id and
 mvpv.plan_id              = mp.plan_id and
 mvpv.sr_instance_id       = msi.sr_instance_id and
 mvpv.plan_id              = msi.plan_id and
 mvpv.organization_id      = msi.organization_id and
 mvpv.inventory_item_id    = msi.inventory_item_id and 
 mvpv.sr_instance_id       = mic.sr_instance_id and
 mvpv.organization_id      = mic.organization_id and
 mvpv.inventory_item_id    = mic.inventory_item_id and
 mic.category_set_id       = mcs.category_set_id and
 (mcs.category_set_name    = :p_category_set_name or
  (:p_category_set_name   is null and mcs.default_flag = 1)
 ) and
 ((mvpv.order_type <> 18) or (mvpv.order_type = 18 and mvpv.quantity_rate <> 0)) and
 1=1
order by
 mvpv.organization_code,
 mvpv.item_segments,
 mvpv.dummy_sort,
 mvpv.new_due_date,
 mvpv.source_flag,
 mvpv.order_type,
 mvpv.order_number,
 mvpv.transaction_id
) vp
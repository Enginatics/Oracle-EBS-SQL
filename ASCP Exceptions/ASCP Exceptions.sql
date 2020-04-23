/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ASCP - Exceptions
-- Description: Report to list exceptions by type and planner
-- Excel Examle Output: https://www.enginatics.com/example/ascp-exceptions
-- Library Link: https://www.enginatics.com/reports/ascp-exceptions
-- Run Report: https://demo.enginatics.com/


select medv.exception_type_text,
       medv.item_segments,
       medv.item_description,
       medv.planner_code,
       medv.order_number,
       medv.order_type,    
       medv.customer_name,
       medv.quantity qty,    
       trunc(medv.exception_value) Value,
       medv.demand_class,
       medv.supply_order_type,
       medv.demand_organization_code,
       medv.buyer_name,
       medv.category_name,
       medv.customer_name,
       medv.demand_quantity,
       round(medv.days_late) days_late,
       round(medv.days_late_arrival) days_late_arrival,
       round(medv.days_early_before_ladate) day_early_b4_ladate,
       round(medv.days_early_arrival) da_earl_arriv,
       medv.new_dock_date,
       medv.dmd_satisfied_date,
       medv.supply_item_segments,
       medv.supply_supplier_name,
       medv.supply_source_org_code,
       medv.orig_sched_ship_date,
       medv.sched_ship_date,
       medv.request_ship_date,
       medv.promise_ship_date,
       medv.dmd_schedule_due_date      
  from msc_exception_details_v medv,    apps.msc_plans mp 
  where 1=1
   and medv.plan_id = mp.plan_id
   and medv.sr_instance_id = mp.sr_instance_id
   and medv.category_set_id=2
   --and medv.order_number='69363.Mixed.ORDER ENTRY(1.1)'
   and medv.item_description <>'Hard Drive Production Planning Family' 
 order by 1, 2, 3
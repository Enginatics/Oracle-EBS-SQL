/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ASCP - Export Supply and Demand Orders - PWB
-- Description: Use this to export all order types from the Planner Workbench without waiting

-- Excel Examle Output: https://www.enginatics.com/example/ascp-export-supply-and-demand-orders-pwb/
-- Library Link: https://www.enginatics.com/reports/ascp-export-supply-and-demand-orders-pwb/
-- Run Report: https://demo.enginatics.com/

SELECT mp.compile_designator "Plan Name",
       mov.planner_code "Planner",
       mov.order_type_text "Order Type",
       mov.item_segments "Product",
       mov.description AS item_description,
       mov.using_assembly_segments AS using_assembly,
       mov.quantity_rate,
       mov.implemented_quantity AS released_qty,
       mov.new_start_date "Sugg Plan Date",
       mov.new_due_date "Sugg Due Date",
       mov.organization_code "Dest WHS",
       (SELECT category_set_name
          FROM msc_category_sets mcs
         WHERE mcs.category_set_id = mov.category_set_id) "Cat Set",
       mov.category_name "Category",
       mov.source_organization_code "Source_org",
       mov.supplier_name "Supplier",
       mov.action "Action Required",
       to_char(decode(mov.planning_make_buy_code, 1, 'Make', 2, 'Buy')) "Make/Buy",
       mov.intransit_lead_time "Intransit LT",
       mov.promise_date "Prom Arrive Date",
       mov.need_by_date,
       mov.order_number "Order Num",
       mi.planning_time_fence_date "Plan Time Fence",
       mi.fixed_lead_time FIX_LT,
       mi.variable_lead_time VARIABLE_LT,
       mi.preprocessing_lead_time PRE_PROC_LT,
       mi.postprocessing_lead_time POST_LT,
       mi.full_lead_time FULL_LT,
       mov.days_from_today DYS_FRM_TDY,
       mov.schedule_compression_days SCED_COMP,
       mov.organization_code AS inventory_org,
       decode(mov.release_status, 2, NULL, 1, 'YES', mov.release_status) AS for_release,
       decode(NVL(mov.implemented_quantity, -999), -999, NULL, 'Released') AS released_status,
       mov.abc_class,
       mov.supplier_site_code AS src_supplier_site_code,
       mov.subinventory_code AS subinventory,
       mov.schedule_compression_days AS compression,
       mov.action,
       mov.reschedule_days AS reschedule,
       mov.firm_date AS new_date,
       mov.firm_quantity AS new_qty,
       mov.demand_priority AS order_priority,
       mov.last_update_date,
       mov.last_updated_by,
       decode(mov.firm_planned_type,
              2,
              NULL,
              1,
              'YES',
              mov.firm_planned_type) AS firm

--fu.user_name AS updt_by
  FROM apps.msc_orders_v mov, apps.msc_plans mp, apps.msc_system_items mi
 WHERE 1=1 
   and mov.plan_id = mp.plan_id
   and mov.sr_instance_id = mp.sr_instance_id
   and mp.sr_instance_id = 21
 --  and mov.organization_code = 'TST:M1'
 --  and mp.compile_designator = 'ATP'
   and mp.plan_id = mov.plan_id
  -- and mov.order_type_text = 'Planned order'
   and mov.category_set_id =
       (SELECT category_set_id
          FROM msc_category_sets
         WHERE category_set_name = 'Inv.Items')
      --and mov.item_segments = 'CM34211'
      -- and trunc(mov.new_start_date) = trunc(mov.new_due_date)
      --and mov.new_start_date between sysdate
   and mi.inventory_item_id = mov.inventory_item_id
   and mi.organization_id = mov.organization_id
   and mi.plan_id = mov.plan_id
   and mov.sr_instance_id = mi.sr_instance_id
 ORDER BY mov.order_type_text, mov.item_segments
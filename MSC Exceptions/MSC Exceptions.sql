/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MSC Exceptions
-- Description: ASCP: Export Planning Exceptions from the Planners Workbench.
-- Excel Examle Output: https://www.enginatics.com/example/msc-exceptions/
-- Library Link: https://www.enginatics.com/reports/msc-exceptions/
-- Run Report: https://demo.enginatics.com/

select /*+ push_pred(medv)*/
mai.instance_code planning_instance,
mp.compile_designator plan_name,
medv.organization_code,
medv.project_number,
medv.task_number,
&lp_custom_attributes
medv.planner_code,
medv.buyer_name, 
msc_phub_util.get_exception_group&a2m_dblink (medv.exception_type) exception_group,
medv.exception_type_text exception_type,
msc_get_name.lookup_meaning&a2m_dblink ('MSC_ADI_YES_NO',medv.action_taken)  action_taken,
-- item
medv.item_segments item,
medv.item_description,
(select mcs.category_set_name from msc_category_sets&a2m_dblink mcs where medv.category_set_id=mcs.category_set_id) category_set_name,
medv.category_name,
regexp_substr(medv.category_name,'[^.]+',1,1) category1,
regexp_substr(medv.category_name,'[^.]+',1,2) category2,
medv.end_item_segments                end_item,
-- order details
medv.quantity                         quantity, 
medv.order_number                     order_number,
coalesce(medv.order_type,msc_get_name.lookup_meaning&a2m_dblink ('MSC_DEMAND_ORIGINATION',md.origination_type)) order_type,
medv.end_order_number,
medv.firm_type,
medv.order_priority                   order_priority,    
-- dates
trunc(medv.old_due_date)              old_due_date,
trunc(medv.due_date)                  due_date,
trunc(medv.dmd_schedule_due_date)     demand_scheduled_due_date,
trunc(medv.dmd_satisfied_date)        demand_satisfied_date, 
trunc(medv.curr_date)                 current_date,
trunc(medv.from_date)                 from_date,
trunc(medv.to_date)                   to_date,
trunc(medv.request_ship_date)         request_ship_date,
trunc(medv.promise_ship_date)         promise_ship_date,
trunc(medv.orig_sched_ship_date)      orig_sched_ship_date,
trunc(medv.sched_ship_date)           sched_ship_date,
trunc(medv.sched_arrival_date)        sched_arrival_date,
trunc(medv.new_dock_date)             new_dock_date,
trunc(medv.comp_demand_date)          comp_demand_date,
--kpis
medv.days_late                        days_late,
medv.days_late_arrival                days_late_arrival,
medv.days_early_before_ladate         days_early_b4_ladate,
medv.days_early_arrival               days_early_arriv,
medv.compression_days                 compression_days,
medv.days_compressed                  days_compressed,
medv.compression_pct,
medv.constraint_pct,
-- customer
medv.customer_name,
medv.customer_site,
medv.customer_item_name,
medv.customer_fcst_qty,
medv.customer_order_fcst_qty,
medv.customer_po,
medv.customer_po_release,
medv.customer_po_line,
medv.customer_po_quantity,
medv.customer_po_creation_date,
medv.customer_po_updated_date,
medv.customer_po_cancel_date,
medv.customer_po_need_by_date,
medv.customer_po_receipt_date,
-- demand
medv.demand_class,
medv.demand_organization_code,
medv.demand_quantity,
medv.demand_date_quantity,
medv.dmd_schedule_item_name           demand_schedule_item_name,
medv.dmd_schedule_order_number        demand_schedule_order_number,
medv.dmd_schedule_org_code            demand_schedule_org_code,
medv.dmd_schedule_qty                 demand_schedule_qty,
-- source
medv.source_organization_code,
-- supply
medv.supply_organization_code,
medv.supply_commit_qty,
medv.supply_item_segments,
medv.supply_order_type,
medv.supply_planner_code,
medv.supply_planning_group,
medv.supply_project_number,
medv.supply_task_number,
medv.supply_source_org_code,
medv.supply_supplier_name,
medv.supply_supplier_site,
-- supplier details
medv.supplier_name,
medv.supplier_site,
medv.supplier_so,
medv.supplier_so_creation_date,
medv.supplier_so_line,
medv.supplier_item_name,
medv.supplier_so_quantity,
medv.supplier_so_receipt_date,
medv.supplier_so_ship_date,
medv.supplier_supply_commit_qty,
medv.supplier_fcst_qty,
-- resource
medv.department_line_code,
medv.resource_type_code,
medv.resource_code,
medv.utilization_rate load_ratio,
-- counts
count(distinct medv.item_segments) over () item_count,
count(distinct medv.end_item_segments) over () end_item_count,
count(distinct medv.order_type || ':' || medv.order_number) over () order_count,
-- item dff attributes
&lp_item_dff_cols
'.' last_col_flag
from 
msc_apps_instances&a2m_dblink mai
,msc_plans&a2m_dblink mp 
,msc_exception_details_v&a2m_dblink medv
,msc_system_items&a2m_dblink msi
,msc_demands&a2m_dblink md
where
1=1
and mai.instance_id        = mp.sr_instance_id 
and mp.plan_id             = medv.plan_id
and mp.sr_instance_id      = medv.sr_instance_id
and medv.sr_instance_id    = msi.sr_instance_id
and medv.plan_id           = msi.plan_id
and medv.organization_id   = msi.organization_id
and medv.inventory_item_id = msi.inventory_item_id
and medv.sr_instance_id    = md.sr_instance_id (+)
and medv.plan_id           = md.plan_id (+)
and medv.demand_id         = md.demand_id (+)
and mai.instance_code      = :p_instance_code
and mp.compile_designator  = :p_plan_name
order by
mai.instance_code,
mp.compile_designator,
medv.organization_code,
medv.planner_code,
exception_group,
medv.exception_type_text,
medv.item_segments,
medv.from_date,
medv.due_date
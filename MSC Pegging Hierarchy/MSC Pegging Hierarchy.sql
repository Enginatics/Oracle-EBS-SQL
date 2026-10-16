/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: MSC Pegging Hierarchy
-- Description: ASCP Pegging Hierarchy. This reports shows the pegging hierarchy from the Top Level Demand.
-- Excel Example Output: https://www.enginatics.com/example/msc-pegging-hierarchy/
-- Library Link: https://www.enginatics.com/reports/msc-pegging-hierarchy/
-- Run Report: https://demo.enginatics.com/

select
z.*,
z.end_assembly||'|'||z.end_demand_origination||'|'||z.end_demand_order_number||'|'||to_char(z.end_peg_demand_date,'YYYY/MM/DD') tv_eao_key,
case z.end_assembly_plan_ord_qoh_sts
when 'Full' then '1 Full'
when 'Partial' then '2 Partial'
when 'None' then '3 None'
else '4 N/A'
end tv_ea_po_qohs
from
(
select /*+ no_merge(y) */ --y executes on the planning server when accessed through a database link, which a computed date in its select list would prevent
y.instance,
y.plan,
y.end_assembly,
y.end_peg_demand_organization,
y.end_peg_demand_project,
y.end_peg_demand_task,
&lp_custom_attributes
y.end_demand_origination||case when y.end_peg_other_supply_type is not null then '/'||y.end_peg_other_supply_type end end_peg_demand_origination,
nvl(y.end_demand_order_number,y.end_peg_other_supply_order) end_peg_demand_order_number,
y.end_demand_origination,
y.end_demand_order_number,
y.end_demand_order_qty,
y.end_peg_demand_qty,
trunc(y.end_peg_demand_date) end_peg_demand_date,
trunc(y.end_peg_supply_date) end_peg_supply_date,
y.end_peg_days_late,
y.end_demand_priority,
trunc(y.end_demand_due_date) end_demand_due_date,
trunc(y.end_demand_sugg_due_date) end_demand_sugg_due_date,
trunc(y.end_demand_req_ship_date) end_demand_req_ship_date,
y.end_demand_days_late,
case
when y.end_peg_demand_id>0 and y.end_assembly is not null then
  case
  when min(y.po_qoh_fulfillment) over (partition by y.end_demand_origination,y.end_demand_order_number,trunc(y.end_peg_demand_date),y.end_assembly)=1 then 'Full'
  when max(y.po_qoh_fulfillment) over (partition by y.end_demand_origination,y.end_demand_order_number,trunc(y.end_peg_demand_date),y.end_assembly)=1 then 'Partial'
  else 'None'
  end
end end_assembly_plan_ord_qoh_sts,
case
when min(y.po_qoh_fulfillment) over (partition by y.end_pegging_id)=1 then 'Full'
when max(y.po_qoh_fulfillment) over (partition by y.end_pegging_id)=1 then 'Partial'
else 'None'
end end_peg_plan_ord_qoh_sts,
y.demand_organization,
y.source_organization,
lpad(' ',2*y.level_)||y.level_ peg_level,
lpad(' ',2*y.level_)||y.item pegged_item,
y.item_path,
y.item_description,
y.uom,
y.peg_days_late,
y.peg_demand_origination_type||case when y.peg_other_supply_type is not null then '/'||y.peg_other_supply_type end peg_demand_origination,
nvl(y.demand_order_number,y.supply_order_number) peg_demand_order,
trunc(y.peg_demand_date) peg_demand_date,
y.peg_demand_qty,
y.peg_pegged_qty,
y.peg_supply_qty,
y.peg_supply_type,
y.supply_order_number peg_supply_order,
trunc(y.peg_supply_date) peg_supply_date,
case
when y.peg_supply_type_id=5 then
  case
  when max(y.supply_qoh_fulfillment) over (partition by y.peg_supply_type,y.supply_order_number,trunc(y.peg_supply_date))=0 then 'None'
  when min(y.supply_qoh_fulfillment) over (partition by y.peg_supply_type,y.supply_order_number,trunc(y.peg_supply_date))=1 then 'Full'
  else 'Partial'
  end
end supply_plan_ord_qoh_sts,
y.supply_action,
trunc(y.supply_reschedule_date) supply_reschedule_date,
y.category_set_name,
y.category_name,
y.planner_code,
y.buyer_name,
y.make_buy,
y.bom_item_type,
y.is_bom,
y.safety_stock,
y.pegging_type,
y.min_minmax_quantity,
y.preprocessing_lead_time,
y.cum_manufacturing_lead_time,
y.cumulative_total_lead_time,
y.postprocessing_lead_time,
y.demand_project,
y.demand_task,
coalesce(y.demand_origination_type,y.peg_demand_origination_type||case when y.peg_other_supply_type is not null then '/'||y.peg_other_supply_type end) demand_origination,
y.demand_order_number,
y.demand_order_qty,
y.demand_priority,
trunc(y.demand_due_date) demand_due_date,
y.demand_days_late,
trunc(y.demand_sugg_due_date) demand_sugg_due_date,
to_date(null) demand_need_by_date,
trunc(y.demand_req_ship_date) demand_req_ship_date,
trunc(y.demand_sch_ship_date) demand_sch_ship_date,
y.demand_customer,
y.demand_customer_site,
y.demand_ship_set,
y.supply_project,
y.supply_task,
y.supply_order_type,
y.supply_order_number,
y.supply_line_num,
y.supply_order_qty,
y.supply_firm_qty,
trunc(y.supply_due_date) supply_due_date,
y.supply_days_late,
trunc(y.supply_sugg_due_date) supply_sugg_due_date,
trunc(y.supply_firm_date) supply_firm_date,
trunc(y.supply_old_need_by_date) supply_old_need_by_date,
trunc(y.supply_need_by_date) supply_need_by_date,
trunc(y.supply_promise_date) supply_promise_date,
y.supply_wip_status,
y.supply_vendor,
y.supply_vendor_site,
y.planning_exception_set,
y.exceptions,
&lp_end_ass_dff_cols
&lp_item_dff_cols
y.end_pegging_id,
y.pegging_id,
y.prev_pegging_id,
y.demand_id,
y.transaction_id,
y.peg_supply_type_id,
y.demand_origination_type_id,
y.supply_order_type_id,
y.peg_end_item_usage,
y.level_ "Level",
y.item,
y.item_description_path,
y.seq,
y.is_end_peg,
y.po_qoh_fulfillment,
case
when y.peg_supply_type_id=18 then '1 '
when y.peg_supply_type_id in (5,13,51,76,77,78,79) then '2 '
else '3 '
end||y.peg_supply_type peg_supply_type_label --pivot order: on hand, planned supply, existing supply
from
(
select
:p_instance_code instance,
:p_plan_name plan,
x.sr_instance_id,
x.plan_id,
x.organization_id,
x.sr_inventory_item_id,
x.level_,
x.seq,
x.pegging_id,
x.prev_pegging_id,
x.end_pegging_id,
x.demand_id,
x.transaction_id,
mpo.organization_code demand_organization,
x.item_name item,
x.item_description,
x.item_path,
x.item_description_path,
x.uom_code uom,
xxen_util.meaning&a2m_dblink(x.end_assembly_pegging_flag,'ASSEMBLY_PEGGING_CODE',0) pegging_type,
x.planner_code,
x.buyer_name,
mcs.category_set_name,
mic.category_name,
msc_get_name.lookup_meaning&a2m_dblink('MTL_PLANNING_MAKE_BUY',x.planning_make_buy_code) make_buy,
msc_get_name.lookup_meaning&a2m_dblink('BOM_ITEM_TYPE',x.bom_item_type) bom_item_type,
x.min_minmax_quantity,
x.preprocessing_lead_time,
x.cum_manufacturing_lead_time,
x.cumulative_total_lead_time,
x.postprocessing_lead_time,
case when nvl(md.using_assembly_item_id,x.inventory_item_id) in (select mb.assembly_item_id from msc_boms&a2m_dblink mb where x.plan_id=mb.plan_id and x.sr_instance_id=mb.sr_instance_id and x.organization_id=mb.organization_id) then 'Y' else 'N' end is_bom,
(
select
max(mss.safety_stock_quantity) keep (dense_rank last order by mss.period_start_date)
from
msc_safety_stocks&a2m_dblink mss
where
x.plan_id=mss.plan_id and
x.sr_instance_id=mss.sr_instance_id and
x.organization_id=mss.organization_id and
x.inventory_item_id=mss.inventory_item_id and
mss.period_start_date<=sysdate
) safety_stock,
case
when x.demand_id<0 then msc_get_name.lookup_meaning&a2m_dblink('MRP_FLP_SUPPLY_DEMAND_TYPE',x.demand_id)
else msc_get_name.lookup_meaning&a2m_dblink('MSC_DEMAND_ORIGINATION',decode(md.origination_type,70,50,92,50,md.origination_type))
end peg_demand_origination_type,
case
when x.demand_id<0 and x.prev_pegging_id is null and x.supply_type<0 then msc_get_name.lookup_meaning&a2m_dblink('MRP_FLP_SUPPLY_DEMAND_TYPE',x.supply_type)
when x.demand_id<0 and x.prev_pegging_id is null and x.supply_type>0 then msc_get_name.lookup_meaning&a2m_dblink('MRP_ORDER_TYPE',x.supply_type)
end peg_other_supply_type,
x.supply_type peg_supply_type_id,
case
when x.supply_type<0 then msc_get_name.lookup_meaning&a2m_dblink('MRP_FLP_SUPPLY_DEMAND_TYPE',x.demand_id)
else msc_get_name.lookup_meaning&a2m_dblink('MRP_ORDER_TYPE',x.supply_type)
end peg_supply_type,
x.demand_quantity peg_demand_qty,
x.supply_quantity peg_supply_qty,
x.allocated_quantity peg_pegged_qty,
x.demand_date peg_demand_date,
x.supply_date peg_supply_date,
x.end_item_usage peg_end_item_usage,
case when trunc(x.supply_date)>trunc(x.demand_date) then trunc(x.supply_date)-trunc(x.demand_date) end peg_days_late,
decode(x.supply_type,18,1,5,qqf.po_qoh_fulfillment,0) po_qoh_fulfillment,
decode(x.supply_type,5,qqf.supply_qoh_fulfillment,-1) supply_qoh_fulfillment,
case when x.prev_pegging_id is null then 'Y' end is_end_peg,
case
when x.demand_id<0 then msc_get_name.project&a2m_dblink(x.project_id,x.organization_id,x.plan_id,x.sr_instance_id)
else msc_get_name.project&a2m_dblink(md.project_id,md.organization_id,md.plan_id,md.sr_instance_id)
end demand_project,
case
when x.demand_id<0 then msc_get_name.task&a2m_dblink(x.task_id,x.project_id,x.organization_id,x.plan_id,x.sr_instance_id)
else msc_get_name.task&a2m_dblink(md.task_id,md.project_id,md.organization_id,md.plan_id,md.sr_instance_id)
end demand_task,
decode(md.origination_type,92,50,md.origination_type) demand_origination_type_id,
msc_get_name.lookup_meaning&a2m_dblink('MSC_DEMAND_ORIGINATION',decode(md.origination_type,70,50,92,50,md.origination_type)) demand_origination_type,
coalesce(md.order_number,
case
when md.origination_type in (1,22,78) then to_char(md.disposition_id)
when md.origination_type=3 then msc_get_name.job_name&a2m_dblink(md.disposition_id,md.plan_id,md.sr_instance_id)
when md.origination_type in (50,70,92) then msc_get_name.maintenance_plan&a2m_dblink(md.schedule_designator_id)
when md.origination_type=29 and md.plan_id=-11 then msc_get_name.designator&a2m_dblink(md.schedule_designator_id)
when md.origination_type=29 and x.in_source_plan=1 then msc_get_name.designator&a2m_dblink(md.schedule_designator_id,md.forecast_set_id)
when md.origination_type=29 then msc_get_name.scenario_designator&a2m_dblink(md.forecast_set_id,md.plan_id,md.organization_id,md.sr_instance_id)||case when msc_get_name.designator&a2m_dblink(md.schedule_designator_id,md.forecast_set_id) is not null then '/'||msc_get_name.designator&a2m_dblink(md.schedule_designator_id,md.forecast_set_id) end
else msc_get_name.designator&a2m_dblink(md.schedule_designator_id)
end) demand_order_number,
-nvl(md.daily_demand_rate,md.using_requirement_quantity)*nvl(md.probability,1) demand_order_qty,
md.demand_priority,
md.old_demand_date demand_due_date,
md.using_assembly_demand_date demand_sugg_due_date,
md.request_ship_date demand_req_ship_date,
md.schedule_ship_date demand_sch_ship_date,
round(
case
when md.dmd_satisfied_date<md.using_assembly_demand_date then least(md.dmd_satisfied_date-md.using_assembly_demand_date,-0.01)
when md.dmd_satisfied_date>md.using_assembly_demand_date then greatest(md.dmd_satisfied_date-md.using_assembly_demand_date,0.01)
else 0
end,2) demand_days_late,
case when md.customer_id is not null then msc_get_name.customer&a2m_dblink(md.customer_id) else msc_get_name.get_other_customers&a2m_dblink(md.plan_id,md.schedule_designator_id) end demand_customer,
case when md.customer_site_id is not null then msc_get_name.customer_site&a2m_dblink(md.customer_site_id) else msc_get_name.get_other_customers&a2m_dblink(md.plan_id,md.schedule_designator_id) end demand_customer_site,
md.ship_set_name demand_ship_set,
msc_get_name.project&a2m_dblink(ms.project_id,ms.organization_id,ms.plan_id,ms.sr_instance_id) supply_project,
msc_get_name.task&a2m_dblink(ms.task_id,ms.project_id,ms.organization_id,ms.plan_id,ms.sr_instance_id) supply_task,
decode(ms.order_type,92,70,ms.order_type) supply_order_type_id,
case
when mp.plan_type=8 and (ms.order_type in (1,53) or ms.order_type=2 and ms.source_organization_id is null) then msc_get_name.lookup_meaning&a2m_dblink('SRP_CHANGED_ORDER_TYPE',ms.order_type)
when mp.plan_type=8 and ms.order_type=2 then msc_get_name.lookup_meaning&a2m_dblink('MRP_ORDER_TYPE',53)
else msc_get_name.lookup_meaning&a2m_dblink('MRP_ORDER_TYPE',decode(ms.order_type,92,70,ms.order_type))
end supply_order_type,
msc_get_name.supply_order_number&a2m_dblink(ms.order_type,ms.order_number,ms.plan_id,ms.sr_instance_id,ms.transaction_id,ms.disposition_id) supply_order_number,
ms.purch_line_num supply_line_num,
nvl(ms.daily_rate,ms.new_order_quantity) supply_order_qty,
ms.firm_quantity supply_firm_qty,
msc_get_name.action&a2m_dblink(
'MSC_SUPPLIES',
x.bom_item_type,
x.base_item_id,
x.wip_supply_type,
ms.order_type,
ms.reschedule_flag,
ms.disposition_status_type,
ms.new_schedule_date,
ms.old_schedule_date,
ms.implemented_quantity,
ms.quantity_in_process,
ms.new_order_quantity,
x.release_time_fence_code,
ms.reschedule_days,
ms.firm_quantity,
ms.plan_id,
x.critical_component_flag,
x.mrp_planning_code,
x.lots_exist,
ms.item_type_value,
ms.transaction_id
) supply_action,
case when ms.old_schedule_date<>ms.new_schedule_date then ms.new_schedule_date end supply_reschedule_date,
ms.old_schedule_date supply_due_date,
ms.new_schedule_date supply_sugg_due_date,
ms.firm_date supply_firm_date,
ms.old_need_by_date supply_old_need_by_date,
ms.need_by_date supply_need_by_date,
ms.promised_date supply_promise_date,
round(nvl(ms.earliest_completion_date-ms.need_by_date,0),2) supply_days_late,
msc_get_name.lookup_meaning&a2m_dblink('WIP_JOB_STATUS',ms.wip_status_code) supply_wip_status,
msc_get_name.org_code&a2m_dblink(ms.source_organization_id,ms.source_sr_instance_id) source_organization,
msc_get_name.supplier&a2m_dblink(ms.supplier_id) supply_vendor,
msc_get_name.supplier_site&a2m_dblink(ms.supplier_site_id) supply_vendor_site,
mfpe.organization_id end_peg_org_id,
msie.sr_inventory_item_id end_peg_sr_item_id,
mfpe.demand_id end_peg_demand_id,
msie.item_name end_assembly,
case
when mfpe.demand_id<0 then msc_get_name.project&a2m_dblink(mfpe.project_id,mfpe.organization_id,mfpe.plan_id,mfpe.sr_instance_id)
else msc_get_name.project&a2m_dblink(mde.project_id,mde.organization_id,mde.plan_id,mde.sr_instance_id)
end end_peg_demand_project,
case
when mfpe.demand_id<0 then msc_get_name.task&a2m_dblink(mfpe.task_id,mfpe.project_id,mfpe.organization_id,mfpe.plan_id,mfpe.sr_instance_id)
else msc_get_name.task&a2m_dblink(mde.task_id,mde.project_id,mde.organization_id,mde.plan_id,mde.sr_instance_id)
end end_peg_demand_task,
mpoe.organization_code end_peg_demand_organization,
case
when mfpe.demand_id<0 then msc_get_name.lookup_meaning&a2m_dblink('MRP_FLP_SUPPLY_DEMAND_TYPE',mfpe.demand_id)
else msc_get_name.lookup_meaning&a2m_dblink('MSC_DEMAND_ORIGINATION',decode(mde.origination_type,70,50,92,50,mde.origination_type))
end end_demand_origination,
case
when mfpe.demand_id<0 and mfpe.supply_type<0 then msc_get_name.lookup_meaning&a2m_dblink('MRP_FLP_SUPPLY_DEMAND_TYPE',mfpe.supply_type)
when mfpe.demand_id<0 and mfpe.supply_type>0 then msc_get_name.lookup_meaning&a2m_dblink('MRP_ORDER_TYPE',mfpe.supply_type)
end end_peg_other_supply_type,
coalesce(mde.order_number,
case
when mde.origination_type in (1,22,78) then to_char(mde.disposition_id)
when mde.origination_type=3 then msc_get_name.job_name&a2m_dblink(mde.disposition_id,mde.plan_id,mde.sr_instance_id)
when mde.origination_type in (50,70,92) then msc_get_name.maintenance_plan&a2m_dblink(mde.schedule_designator_id)
when mde.origination_type=29 and mde.plan_id=-11 then msc_get_name.designator&a2m_dblink(mde.schedule_designator_id)
when mde.origination_type=29 and msie.in_source_plan=1 then msc_get_name.designator&a2m_dblink(mde.schedule_designator_id,mde.forecast_set_id)
when mde.origination_type=29 then msc_get_name.scenario_designator&a2m_dblink(mde.forecast_set_id,mde.plan_id,mde.organization_id,mde.sr_instance_id)||case when msc_get_name.designator&a2m_dblink(mde.schedule_designator_id,mde.forecast_set_id) is not null then '/'||msc_get_name.designator&a2m_dblink(mde.schedule_designator_id,mde.forecast_set_id) end
else msc_get_name.designator&a2m_dblink(mde.schedule_designator_id)
end) end_demand_order_number,
case when mfpe.demand_id<0 then (select msc_get_name.supply_order_number&a2m_dblink(mse.order_type,mse.order_number,mse.plan_id,mse.sr_instance_id,mse.transaction_id,mse.disposition_id) from msc_supplies&a2m_dblink mse where mfpe.plan_id=mse.plan_id and mfpe.sr_instance_id=mse.sr_instance_id and mfpe.transaction_id=mse.transaction_id) end end_peg_other_supply_order,
mde.demand_priority end_demand_priority,
mfpe.demand_date end_peg_demand_date,
mfpe.supply_date end_peg_supply_date,
case when trunc(mfpe.supply_date)>trunc(mfpe.demand_date) then trunc(mfpe.supply_date)-trunc(mfpe.demand_date) end end_peg_days_late,
mde.old_demand_date end_demand_due_date,
mde.using_assembly_demand_date end_demand_sugg_due_date,
mde.request_ship_date end_demand_req_ship_date,
-nvl(mde.daily_demand_rate,mde.using_requirement_quantity)*nvl(mde.probability,1) end_demand_order_qty,
mfpe.demand_quantity end_peg_demand_qty,
round(
case
when mde.dmd_satisfied_date<mde.using_assembly_demand_date then least(mde.dmd_satisfied_date-mde.using_assembly_demand_date,-0.01)
when mde.dmd_satisfied_date>mde.using_assembly_demand_date then greatest(mde.dmd_satisfied_date-mde.using_assembly_demand_date,0.01)
else 0
end,2) end_demand_days_late,
x.planning_exception_set,
(
select
listagg(med.exception_type_meaning,', ') within group (order by med.exception_type_meaning)
from
(
select distinct
med.plan_id,
med.sr_instance_id,
med.organization_id,
med.inventory_item_id,
med.number1,
xxen_util.meaning&a2m_dblink(med.exception_type,'MRP_EXCEPTION_CODE_TYPE',700) exception_type_meaning
from
msc_exception_details&a2m_dblink med
where
med.exception_type in (1,2,3,4,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29)
) med
where
x.plan_id=med.plan_id and
x.sr_instance_id=med.sr_instance_id and
x.organization_id=med.organization_id and
x.inventory_item_id=med.inventory_item_id and
x.transaction_id=med.number1
) exceptions
from
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
nullif(msi.min_minmax_quantity,0) min_minmax_quantity,
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
(select mfp.* from msc_full_pegging&a2m_dblink mfp where mfp.plan_id=:p_plan_id and mfp.sr_instance_id=:p_instance_id) mfp,
msc_system_items&a2m_dblink msi,
(
select
mfp.pegging_id
from
msc_full_pegging&a2m_dblink mfp,
msc_system_items&a2m_dblink msi
where
mfp.plan_id=:p_plan_id and
mfp.sr_instance_id=:p_instance_id and
3=3 and
(mfp.prev_pegging_id is null or not exists (select null from msc_full_pegging&a2m_dblink mfp2 where mfp.plan_id=mfp2.plan_id and mfp.sr_instance_id=mfp2.sr_instance_id and mfp.prev_pegging_id=mfp2.pegging_id &org_restriction)) and
mfp.plan_id=msi.plan_id(+) and
mfp.sr_instance_id=msi.sr_instance_id(+) and
mfp.organization_id=msi.organization_id(+) and
mfp.inventory_item_id=msi.inventory_item_id(+)
) qsp --start rows by outer join, as a START WITH subquery cannot execute on the planning server
where
mfp.plan_id=msi.plan_id(+) and
mfp.sr_instance_id=msi.sr_instance_id(+) and
mfp.organization_id=msi.organization_id(+) and
mfp.inventory_item_id=msi.inventory_item_id(+) and
mfp.pegging_id=qsp.pegging_id(+)
connect by
prior mfp.pegging_id=mfp.prev_pegging_id
&show_source_org_pegging
start with
qsp.pegging_id is not null
) x,
(
select
qoh.qoh_pegging_id pegging_id,
max(case when qoh.level_=1 then qoh.po_qoh_fulfillment end) po_qoh_fulfillment,
case
when min(case when qoh.level_>1 then qoh.po_qoh_fulfillment end)=1 then 1
when max(case when qoh.level_>1 then qoh.po_qoh_fulfillment end)=1 then 0.5
else 0
end supply_qoh_fulfillment
from
(
select
level level_,
connect_by_root mfp.pegging_id qoh_pegging_id,
case mfp.supply_type
when 18 then 1
when 5 then --planned order: 0 without demand or with demand in a source organization that is not shown, null when its planned order demand decides
  case
  when :show_source_org_pegging='N' and mfp.pegging_id in (select mfp2.prev_pegging_id from msc_full_pegging&a2m_dblink mfp2 where mfp.plan_id=mfp2.plan_id and mfp.sr_instance_id=mfp2.sr_instance_id and mfp.organization_id<>mfp2.organization_id) then 0
  when not exists (select null from msc_full_pegging&a2m_dblink mfp2 where mfp.plan_id=mfp2.plan_id and mfp.sr_instance_id=mfp2.sr_instance_id and mfp.pegging_id=mfp2.prev_pegging_id) then 0
  end
else 0
end po_qoh_fulfillment
from
(select mfp.* from msc_full_pegging&a2m_dblink mfp where mfp.plan_id=:p_plan_id and mfp.sr_instance_id=:p_instance_id) mfp
connect by
prior decode(mfp.supply_type,5,mfp.pegging_id,0)=mfp.prev_pegging_id
&show_source_org_pegging2
start with
mfp.supply_type=5
) qoh
group by
qoh.qoh_pegging_id
) qqf, --each planned order (level 1) and its planned order demand subtree (levels 2+)
msc_plans&a2m_dblink mp,
msc_plan_organizations&a2m_dblink mpo,
msc_item_categories&a2m_dblink mic,
msc_category_sets&a2m_dblink mcs,
msc_supplies&a2m_dblink ms,
msc_demands&a2m_dblink md,
msc_full_pegging&a2m_dblink mfpe,
msc_plan_organizations&a2m_dblink mpoe,
msc_system_items&a2m_dblink msie,
msc_demands&a2m_dblink mde
where
1=1 and
x.pegging_id=qqf.pegging_id(+) and
x.plan_id=mp.plan_id and
x.sr_instance_id=mp.sr_instance_id and
x.plan_id=mpo.plan_id and
x.sr_instance_id=mpo.sr_instance_id and
x.organization_id=mpo.organization_id and
x.sr_instance_id=mic.sr_instance_id and
x.organization_id=mic.organization_id and
x.inventory_item_id=mic.inventory_item_id and
mic.category_set_id=mcs.category_set_id and
mcs.category_set_name=:p_category_set_name and
x.plan_id=ms.plan_id(+) and
x.sr_instance_id=ms.sr_instance_id(+) and
x.transaction_id=ms.transaction_id(+) and
x.plan_id=md.plan_id(+) and
x.sr_instance_id=md.sr_instance_id(+) and
x.demand_id=md.demand_id(+) and
x.plan_id=mfpe.plan_id(+) and
x.sr_instance_id=mfpe.sr_instance_id(+) and
x.end_pegging_id=mfpe.pegging_id(+) and
mfpe.plan_id=mpoe.plan_id(+) and
mfpe.sr_instance_id=mpoe.sr_instance_id(+) and
mfpe.organization_id=mpoe.organization_id(+) and
mfpe.plan_id=msie.plan_id(+) and
mfpe.sr_instance_id=msie.sr_instance_id(+) and
mfpe.organization_id=msie.organization_id(+) and
mfpe.inventory_item_id=msie.inventory_item_id(+) and
mfpe.plan_id=mde.plan_id(+) and
mfpe.sr_instance_id=mde.sr_instance_id(+) and
mfpe.demand_id=mde.demand_id(+)
) y
) z
where
4=4
order by
z.instance,
z.plan,
z.demand_organization,
z.is_bom desc,
z.end_peg_demand_date nulls last,
z.end_peg_demand_origination nulls last,
z.end_peg_demand_order_number nulls last,
z.end_pegging_id,
z.seq

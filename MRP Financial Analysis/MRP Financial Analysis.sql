/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MRP Financial Analysis
-- Description: Imported from BI Publisher
Description: Financial Analysis Report
Application: Master Scheduling/MRP
Source: Financial Analysis Report (XML)
Short Name: MRPRPPIT_XML
DB package: MRP_MRPRPPIT_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/mrp-financial-analysis/
-- Library Link: https://www.enginatics.com/reports/mrp-financial-analysis/
-- Run Report: https://demo.enginatics.com/

select
 (select ood.organization_name
  from   org_organization_definitions ood
  where  ood.organization_id = org_v.planned_organization
 ) organization,
 mrp_mrprppit_xmlp_pkg.c_planned_org_codeformula(org_v.planned_organization) organization_code,
 plan1.compile_designator plan_name,
 plan1.description plan_description,
 plan1.plan_completion_date plan_date,
 pln_sched.input_designator_name ||' - '||sched.description schedule_name,
 pln_sched.input_designator_name input_designator,
 --org_v.planned_organization planned_organization_id,
 trunc(plan1.cutoff_date) cutoff_date,
 xxen_util.meaning(:p_periods,'MRP_DISPLAY_PERIODS',700) periods,
 :p_weeks weeks,
 mrp_mrprppit_xmlp_pkg.c_cost_typeformula() cost_type,
 :p_currency_code currency,
 (select round(mfq.number1,:p_precision) beginning_inventory 
  from   mrp_form_query mfq
  where  char2    = pln_sched.input_designator_name
  and    number12 = org_v.planned_organization
  and    query_id = :p_query_id
  and    date2 is not null
  and    rownum=1
 ) beginning_inventory,
 mfq.date1                         period,
 round(mfq.number2,:p_precision)   purchase_orders,
 round(mfq.number3,:p_precision)   purchase_reqs,
 round(mfq.number4,:p_precision)   purchase_planned_orders,
 round(mfq.number5,:p_precision)   wip_discrete_jobs,
 round(mfq.number6,:p_precision)   wip_repetitive_schedules,
 round(mfq.number7,:p_precision)   wip_planned_orders,
 round(mfq.number8,:p_precision)   master_schedule,
 round(mfq.number9,:p_precision)   ending_inventory,
 mfq.number10                      period_turns,
 mfq.number11                      cumulative_turns 
from 
 mrp_plans plan1,
 mrp_schedule_designators sched,
 mrp_plan_schedules_v pln_sched,
 mrp_plan_organizations_v org_v,
 mrp_form_query mfq
where
       :p_org_code = :p_org_code
 and :p_cost_type_name = :p_cost_type_name
 and sched.organization_id = pln_sched.input_organization_id
 and sched.schedule_designator = pln_sched.input_designator_name
 and pln_sched.input_organization_id = org_v.planned_organization
 and pln_sched.compile_designator = org_v.compile_designator
 and plan1.organization_id = org_v.organization_id
 and plan1.compile_designator = org_v.compile_designator
 and decode(:p_org_type, 1, org_v.planned_organization, org_v.organization_id) = :p_org_id
 and org_v.compile_designator = :p_plan_name
 and mfq.char2    = pln_sched.input_designator_name
 and mfq.number12 = org_v.planned_organization
 and mfq.query_id = :p_query_id
 and mfq.date2   is not null
order by
 plan1.compile_designator,
 org_v.planned_organization,
 pln_sched.input_designator_name,
 pln_sched.input_designator_name,
 mfq.date1
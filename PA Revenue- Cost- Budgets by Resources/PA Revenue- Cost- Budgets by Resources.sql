/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Revenue, Cost, Budgets by Resources
-- Description: This Blitz Report is the implements the following standard oracle reports.

- MGT: Task - Revenue, Cost, Budgets by Resources
- MGT: Revenue, Cost, Budgets by Resources (Project Level)

The 'Report Level' parameter determines if the report is run at the Project Level or Task Level

Report Level Parameter:
Project - equivalent to running the MGT: Revenue, Cost, Budgets by Resources (Project Level) report
Task - equivalent to running the MGT: Task - Revenue, Cost, Budgets by Resources report

The report has been extended to pull in additional datapoints as displayed in the Project Status Inquiry Form.

Application: Projects
Source: MGT: Task - Revenue, Cost, Budgets by Resources (XML)
Short Name: PAXMGTSD_XML
DB package: PA_PAXMGTSD_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/pa-revenue-cost-budgets-by-resources/
-- Library Link: https://www.enginatics.com/reports/pa-revenue-cost-budgets-by-resources/
-- Run Report: https://demo.enginatics.com/

with projects as
(
select
 pi.project_id,
 haouv.name operating_unit,
 pi.organization_name project_organization,
 pi.manager_name project_manager,
 pi.project_type,
 pi.project_name,
 pi.project_number,
 iv.total_invoiced_amount,
 iv.total_revenue_amount,
 p.project_currency_code,
 p.projfunc_currency_code,
 iv.pfc_total_invoice_amount,
 iv.unbilled_retention,
 nvl(p.retn_accounting_flag,'N') retn_accounting_flag,
 xxen_util.meaning(pt.burden_cost_flag,'YES_NO',0) costs_burdened,
 pa_paxbubss_xmlp_pkg.unearned_revformula(nvl(p.retn_accounting_flag,'N'),iv.pfc_total_invoice_amount,iv.unbilled_retention,iv.total_revenue_amount) unearned_rev,
 pa_paxbubss_xmlp_pkg.accounts_receivableformula(pi.project_id) accounts_receivable,
 pa_paxbubss_xmlp_pkg.unbilled_recformula(nvl(p.retn_accounting_flag,'N'),iv.total_revenue_amount,iv.pfc_total_invoice_amount,iv.unbilled_retention) unbilled_rec,
 pa_paxbubss_xmlp_pkg.unbilled_retnformula(nvl(p.retn_accounting_flag,'N'),iv.unbilled_retention) unbilled_retn
from
 pa_proj_info_view pi,
 pa_projects p,
 pa_project_types pt,
 pa_proj_invoice_summary_view iv,
 hr_all_organization_units_vl haouv
where
 1=1 and
 p.template_flag !='Y' and
 p.project_type  = pt.project_type and
 p.project_id = pi.project_id and
 p.project_id = iv.project_id (+) and
 pi.org_id = haouv.organization_id and
 haouv.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
 p.project_id in
  (select
    p.project_id
   from
    pa_projects p,
    pa_project_status_controls s
   where
    p.project_status_code = s.project_status_code and
    s.status_type = 'PROJECT' and
    s.action_code = 'STATUS_REPORTING' and
    s.enabled_flag='Y'
  )
),
tasks as
(
select
 pt.project_id,
 pt.task_id,
 pt.parent_task_id,
 pt.wbs_level,
 pt.task_number,
 pt.task_name,
 substr(haout.name,1,60) task_organization,
 decode(pt.task_manager_person_id,ppx.person_id,ppx.full_name,null,'No Task Manager') task_manager,
 xxen_util.meaning(decode(pt.wbs_level,1,'Y'),'YES_NO',0) top_level_task,
 'Task' report_level
from
 pa_tasks pt,
 per_people_x ppx,
 hr_all_organization_units_tl haout
where
 2=2 and
 nvl(:p_report_level,'T') = 'T' and
 pt.task_manager_person_id = ppx.person_id (+) and
 ppx.employee_number (+) is not null and
 pt.carrying_out_organization_id = haout.organization_id (+) and
 haout.language (+) = userenv('lang')
union
select
 p.project_id,
 0 task_id,
 null parent_task_id,
 null wbs_level,
 null task_number,
 null task_name,
 null task_organization,
 null task_manager,
 null top_level_task,
 'Project' report_level
from
 pa_projects p
where
 nvl(:p_report_level,'T') = 'P'
),
resource_list as
(
select distinct
 ppah.project_id,
 ppah.task_id,
 pbt.budget_amount_code,
 prlm.resource_list_member_id,
 prlm.member_level,
 prlm.alias,
 pbt.budget_type_code,
 prla.resource_list_id,
 decode(prlm.parent_member_id, null, prlm.sort_order, prlm2.sort_order) parent_sort_order,
 decode(prlm.parent_member_id, null, 0, prlm.sort_order) sort_order,
 case when pbt.budget_type_code = :c_rev_bgt_code then 'Y' else 'N' end rev_rsc,
 case when pbt.budget_type_code = :c_cost_bgt_code then 'Y' else 'N' end cost_rsc,
 xxen_util.meaning(decode(prlm.parent_member_id,null,'Y'),'YES_NO',0) top_level_resource
from
 pa_project_accum_headers ppah,
 pa_resource_list_assignments prla,
 pa_resource_list_uses prlu,
 pa_budget_types pbt,
 pa_resource_list_members prlm,
 pa_resource_list_members prlm2
where
 ppah.project_id = prla.project_id and
 prla.resource_list_assignment_id = prlu.resource_list_assignment_id and
 prlu.use_code = pbt.budget_type_code and
 prla.resource_list_id = prlm.resource_list_id and
 nvl(prlm.parent_member_id, prlm.resource_list_member_id) = prlm2.resource_list_member_id and
 pbt.budget_type_code in (:c_rev_bgt_code,:c_cost_bgt_code) and
 (ppah.resource_list_member_id = prlm.resource_list_member_id or
  exists
  (select
    'x'
   from
    pa_resource_list_members prlm3
   where
    prlm.resource_list_member_id = prlm3.parent_member_id and
    prlm3.resource_list_member_id = ppah.resource_list_member_id
  )
 )
),
actuals as
(
select
 parav.project_id,
 parav.task_id,
 parav.resource_list_member_id,
 nvl(parav.revenue_itd,0) actual_rev,
 pa_paxmgtsd_xmlp_pkg.c_act_per_revformula(parav.resource_list_member_id, decode(parav.task_id,0,to_number(null),parav.task_id),:period_name,parav.project_id) actual_rev_prd,
 nvl(parav.burdened_cost_itd,0) actual_cst,
 pa_paxmgtsd_xmlp_pkg.c_act_per_costformula(parav.resource_list_member_id,decode(parav.task_id,0,to_number(null),parav.task_id),:period_name,parav.project_id) actual_cst_prd,
 --
 parav.raw_cost_itd,
 parav.raw_cost_ytd,
 parav.raw_cost_pp,
 parav.raw_cost_ptd,
 parav.billable_raw_cost_itd,
 parav.billable_raw_cost_ytd,
 parav.billable_raw_cost_pp,
 parav.billable_raw_cost_ptd,
 parav.burdened_cost_itd,
 parav.burdened_cost_ytd,
 parav.burdened_cost_pp,
 parav.burdened_cost_ptd,
 parav.billable_burdened_cost_itd,
 parav.billable_burdened_cost_ytd,
 parav.billable_burdened_cost_pp,
 parav.billable_burdened_cost_ptd,
 parav.actuals_quantity_itd,
 parav.actuals_quantity_ytd,
 parav.actuals_quantity_pp,
 parav.actuals_quantity_ptd,
 parav.billable_quantity_itd,
 parav.billable_quantity_ytd,
 parav.billable_quantity_pp,
 parav.billable_quantity_ptd,
 parav.actuals_labor_hours_itd,
 parav.actuals_labor_hours_ytd,
 parav.actuals_labor_hours_pp,
 parav.actuals_labor_hours_ptd,
 parav.billable_labor_hours_itd,
 parav.billable_labor_hours_ytd,
 parav.billable_labor_hours_pp,
 parav.billable_labor_hours_ptd,
 parav.revenue_itd,
 parav.revenue_ytd,
 parav.revenue_pp,
 parav.revenue_ptd
from
 pa_accum_rsrc_act_v parav
),
commitments as
(
select
 parcv.project_id,
 parcv.task_id,
 parcv.resource_list_member_id,
 --
 parcv.cmt_raw_cost_itd,
 parcv.cmt_raw_cost_ytd,
 parcv.cmt_raw_cost_pp,
 parcv.cmt_raw_cost_ptd,
 parcv.cmt_burdened_cost_itd,
 parcv.cmt_burdened_cost_ytd,
 parcv.cmt_burdened_cost_pp,
 parcv.cmt_burdened_cost_ptd,
 parcv.cmt_quantity_itd,
 parcv.cmt_quantity_ytd,
 parcv.cmt_quantity_pp,
 parcv.cmt_quantity_ptd
from
 pa_accum_rsrc_cmt_v parcv
),
budget_costs as
(
select
 parcbv.project_id,
 parcbv.task_id,
 parcbv.resource_list_member_id,
 parcbv.budget_type_code,
 nvl(parcbv.baseline_burdened_cost_tot,0) budget_cst,
 --
 parcbv.baseline_raw_cost_itd,
 parcbv.baseline_raw_cost_ytd,
 parcbv.baseline_raw_cost_pp,
 parcbv.baseline_raw_cost_ptd,
 parcbv.baseline_burdened_cost_itd,
 parcbv.baseline_burdened_cost_ytd,
 parcbv.baseline_burdened_cost_pp,
 parcbv.baseline_burdened_cost_ptd,
 parcbv.original_raw_cost_itd,
 parcbv.original_raw_cost_ytd,
 parcbv.original_raw_cost_pp,
 parcbv.original_raw_cost_ptd,
 parcbv.original_burdened_cost_itd,
 parcbv.original_burdened_cost_ytd,
 parcbv.original_burdened_cost_pp,
 parcbv.original_burdened_cost_ptd,
 parcbv.baseline_quantity_itd,
 parcbv.baseline_quantity_ytd,
 parcbv.baseline_quantity_pp,
 parcbv.baseline_quantity_ptd,
 parcbv.original_quantity_itd,
 parcbv.original_quantity_ytd,
 parcbv.original_quantity_pp,
 parcbv.original_quantity_ptd,
 parcbv.original_labor_hours_itd,
 parcbv.original_labor_hours_ytd,
 parcbv.original_labor_hours_pp,
 parcbv.original_labor_hours_ptd,
 parcbv.baseline_labor_hours_itd,
 parcbv.baseline_labor_hours_ytd,
 parcbv.baseline_labor_hours_pp,
 parcbv.baseline_labor_hours_ptd,
 parcbv.baseline_raw_cost_tot,
 parcbv.baseline_burdened_cost_tot,
 parcbv.original_raw_cost_tot,
 parcbv.original_burdened_cost_tot,
 parcbv.original_labor_hours_tot,
 parcbv.baseline_labor_hours_tot,
 parcbv.baseline_quantity_tot,
 parcbv.original_quantity_tot
from
 pa_accum_rsrc_cost_bgt_v parcbv
where
 parcbv.budget_type_code = :c_cost_bgt_code
),
budget_revenues as
(
select
 parrbv.project_id,
 parrbv.task_id,
 parrbv.resource_list_member_id,
 parrbv.budget_type_code,
 nvl(parrbv.baseline_revenue_tot,0) budget_rev,
 --
 parrbv.baseline_revenue_itd,
 parrbv.baseline_revenue_ytd,
 parrbv.baseline_revenue_pp,
 parrbv.baseline_revenue_ptd,
 parrbv.original_revenue_itd,
 parrbv.original_revenue_ytd,
 parrbv.original_revenue_pp,
 parrbv.original_revenue_ptd,
 parrbv.baseline_quantity_itd,
 parrbv.baseline_quantity_ytd,
 parrbv.baseline_quantity_pp,
 parrbv.baseline_quantity_ptd,
 parrbv.original_quantity_itd,
 parrbv.original_quantity_ytd,
 parrbv.original_quantity_pp,
 parrbv.original_quantity_ptd,
 parrbv.original_labor_hours_itd,
 parrbv.original_labor_hours_ytd,
 parrbv.original_labor_hours_pp,
 parrbv.original_labor_hours_ptd,
 parrbv.baseline_labor_hours_itd,
 parrbv.baseline_labor_hours_ytd,
 parrbv.baseline_labor_hours_pp,
 parrbv.baseline_labor_hours_ptd,
 parrbv.baseline_revenue_tot,
 parrbv.original_revenue_tot,
 parrbv.original_labor_hours_tot,
 parrbv.baseline_labor_hours_tot,
 parrbv.baseline_quantity_tot,
 parrbv.original_quantity_tot
from
 pa_accum_rsrc_rev_bgt_v parrbv
where
 parrbv.budget_type_code = :c_rev_bgt_code
)
--
-- Main Query
--
select
x.*
from
(
select /*+ ordered push_pred(t) push_pred(rl) push_pred(a) push_pred(c) push_pred(bc) push_pred(br) */
distinct
 p.operating_unit,
 p.project_organization,
 p.project_manager,
 p.project_type,
 p.project_number,
 p.project_name,
 p.projfunc_currency_code functional_currency,
 p.pfc_total_invoice_amount total_invoiced_amount,
 p.accounts_receivable accounts_receivable,
 p.unbilled_rec unbilled_receivable,
 p.unearned_rev unearned_revenue,
 p.unbilled_retn unbilled_retention,
 p.costs_burdened,
 t.report_level,
 t.wbs_level task_level,
 t.task_number,
 t.task_name,
 t.top_level_task,
 t.task_organization,
 t.task_manager,
 -- resource_list
 rl.member_level resource_level,
 rl.alias resource_name,
 rl.top_level_resource,
 -- actuals
 br.budget_rev budget_revenue,
 ar.actual_rev actual_revenue,
 ar.actual_rev_prd period_actual_revenue,
 --
 bc.budget_cst budget_burdened_cost,
 ac.actual_cst actual_burdened_cost,
 ac.actual_cst_prd period_actual_burdened_cost,
 --
 -- The following column list is from the Project Status Inquiry Form
 --
 decode((sign((nvl(bc.baseline_burdened_cost_itd,0) * 1.1) - (nvl(ac.burdened_cost_itd,0) + nvl(c.cmt_burdened_cost_ptd,0)))), -1, xxen_util.meaning('Y','YES_NO',0), null) ovr_bgt,
 round(nvl(br.baseline_revenue_itd,0)) itd_rev_bgt,
 round(nvl(ar.revenue_itd,0)) itd_act_rev,
 round(nvl(bc.baseline_burdened_cost_itd,0)) itd_cst_bgt,
 round(nvl(ac.burdened_cost_itd,0)) itd_act_cost,
 round(nvl(c.cmt_burdened_cost_ptd,0)) commit_amt,
 round(nvl(bc.baseline_labor_hours_itd,0)) itd_bgt_hrs,
 round(nvl(ac.actuals_labor_hours_itd,0)) itd_act_hrs,
 --
 round(nvl(bc.baseline_burdened_cost_ptd,0)) ptd_cst_bgt,
 round(nvl(ac.burdened_cost_ptd,0)) ptd_act_cost,
 round(nvl(bc.baseline_labor_hours_ptd,0)) ptd_bgt_hrs,
 round(nvl(ac.actuals_labor_hours_ptd,0)) ptd_act_hrs,
 --
 round(nvl(br.baseline_revenue_tot,0)) tot_rev_bgt,
 round(nvl(bc.baseline_burdened_cost_tot,0)) tot_cst_bgt,
 round(nvl(bc.baseline_labor_hours_tot,0)) tot_bgt_hrs,
 --
 round(decode(bc.baseline_burdened_cost_tot, 0, 0, (ac.burdened_cost_itd/bc.baseline_burdened_cost_tot) * 100)) fin_pct_cmplt,
 round(decode(bc.baseline_labor_hours_tot,0,0, (ac.actuals_labor_hours_itd/bc.baseline_labor_hours_tot) * 100)) hrs_pct_cmplt,
 round(nvl(bc.baseline_burdened_cost_tot,0) - nvl(c.cmt_burdened_cost_ptd,0) - nvl(ac.burdened_cost_itd,0)) est_to_cmplt,
 round(nvl(ac.burdened_cost_itd,0) + nvl(c.cmt_burdened_cost_ptd,0)) tot_cst_itd,
 round(nvl(br.baseline_revenue_tot,0) - nvl(bc.baseline_burdened_cost_tot,0)) bgt_mgn,
 round(nvl(ar.revenue_itd,0) - nvl(ac.burdened_cost_itd,0)) act_mgn_itd,
 --
 round(nvl(br.original_revenue_itd,0)) itd_orig_rev_bgt,
 round(nvl(br.original_revenue_tot,0)) tot_orig_rev_bgt,
 round(nvl(bc.original_burdened_cost_itd,0)) itd_orig_cst_bgt,
 round(nvl(bc.original_burdened_cost_tot,0)) tot_orig_cst_bgt,
 round(nvl(bc.original_labor_hours_tot,0)) tot_orig_bgt_hrs,
 --
 :period_name period,
 t.project_id,
 t.task_id,
 t.parent_task_id,
 rl.resource_list_member_id,
 rl.parent_sort_order resource_parent_sort_order,
 rl.sort_order resource_sort_order,
 first_value(nvl2(coalesce(ar.project_id,ac.project_id,br.project_id,bc.project_id),'N','Y'))
 over (partition by p.project_id order by nvl2(coalesce(ar.project_id,ac.project_id,br.project_id,bc.project_id),'N','Y')
       rows between unbounded preceding and unbounded following
      ) exclude_project
from
 projects p,
 tasks t,
 resource_list rl,
 actuals ar,
 actuals ac,
 commitments c,
 budget_revenues br,
 budget_costs bc
where
 p.project_id = t.project_id and
 --
 t.project_id = rl.project_id (+) and
 t.task_id = rl.task_id (+) and
 --
 case when rl.rev_rsc = 'Y' then rl.project_id else null end = ar.project_id (+) and
 case when rl.rev_rsc = 'Y' then rl.task_id else null end = ar.task_id (+) and
 case when rl.rev_rsc = 'Y' then rl.resource_list_member_id else null end = ar.resource_list_member_id (+) and
 --
 case when rl.cost_rsc = 'Y' then rl.project_id else null end = ac.project_id (+) and
 case when rl.cost_rsc = 'Y' then rl.task_id else null end = ac.task_id (+) and
 case when rl.cost_rsc = 'Y' then rl.resource_list_member_id else null end = ac.resource_list_member_id (+) and
 --
 case when rl.cost_rsc = 'Y' then rl.project_id else null end = c.project_id (+) and
 case when rl.cost_rsc = 'Y' then rl.task_id else null end = c.task_id (+) and
 case when rl.cost_rsc = 'Y' then rl.resource_list_member_id else null end = c.resource_list_member_id (+) and
 --
 rl.project_id = br.project_id (+) and
 rl.task_id = br.task_id (+) and
 rl.resource_list_member_id = br.resource_list_member_id (+) and
 --
 rl.project_id = bc.project_id (+) and
 rl.task_id = bc.task_id (+) and
 rl.resource_list_member_id = bc.resource_list_member_id (+)
) x
where
x.exclude_project = 'N'
order by
operating_unit,
task_organization,
task_manager,
project_number,
decode(report_level,'Task',1,2),
task_number,
resource_parent_sort_order,
resource_sort_order,
resource_name
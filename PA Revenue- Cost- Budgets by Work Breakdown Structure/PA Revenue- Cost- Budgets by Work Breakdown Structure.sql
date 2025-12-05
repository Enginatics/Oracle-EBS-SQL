/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Revenue, Cost, Budgets by Work Breakdown Structure
-- Description: This Blitz report implements the standard Oracle report: MGT: Revenue, Cost, Budgets by Work Breakdown Structure (XML)

The 'Report Level' parameter determines if the report is run at the Project Level or Task Level

Report Level Parameter:
Project - will pull back revenue, costs and budgets accumulated at the project level
Task - will pull back revenue, costs and budgets accumulated at the task level

The report has been extended to pull in additional datapoints as displayed in the Project Status Inquiry Form.

Application: Projects
Source: MGT: Revenue, Cost, Budgets by Work Breakdown Structure (XML)
Short Name: PAXBUBSS_XML
DB package: PA_PAXBUBSS_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/pa-revenue-cost-budgets-by-work-breakdown-structure/
-- Library Link: https://www.enginatics.com/reports/pa-revenue-cost-budgets-by-work-breakdown-structure/
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
 pt.wbs_level,
 pt.task_number,
 pt.task_name,
 substr(haout.name,1,60) task_organization,
 decode(pt.task_manager_person_id,ppx.person_id,ppx.full_name,null,'No Task Manager') task_manager,
 xxen_util.meaning(decode(pt.wbs_level,1,'Y'),'YES_NO',0) top_level_task,
 pa_paxbubss_xmlp_pkg.c_indented_task_numberformula(pt.wbs_level,pt.task_number) indented_task_number,
 pa_paxbubss_xmlp_pkg.c_indented_task_nameformula(pt.wbs_level,pt.task_name) indented_task_name,
 substr(sys_connect_by_path(pt.task_number, '&lp_path_delimiter'),2) task_hierarchy,
 'Task' report_level
from
 pa_tasks pt,
 per_people_x ppx,
 hr_all_organization_units_tl haout
where
 pt.wbs_level = decode(nvl(:explode_sub_tasks,'N'),'N',1,pt.wbs_level) and
 nvl(:p_report_level,'T') = 'T' and
 pt.task_manager_person_id = ppx.person_id (+) and
 ppx.employee_number (+) is not null and
 pt.carrying_out_organization_id = haout.organization_id (+) and
 haout.language (+) = userenv('lang')
connect by
 prior pt.project_id = pt.project_id and
 prior pt.task_id = pt.parent_task_id
start with
 2=2 and
 pt.parent_task_id is null
union
select
 p.project_id,
 0 task_id,
 null wbs_level,
 null task_number,
 null task_name,
 null task_organization,
 null task_manager,
 null top_level_task,
 null indented_task_number,
 null indented_task_name,
 null task_hierarchy,
 'Project' report_level
from
 pa_projects p
where
 nvl(:p_report_level,'T') = 'P'
),
actuals as
(
select
 pah.project_id,
 pah.task_id,
 nvl(paa.revenue_itd,0) actual_revenue_amount,
 nvl(paa.burdened_cost_itd,0) actual_cost_amount,
 nvl(paa.labor_hours_itd,0) actual_hours,
 paa.*
from
 pa_project_accum_headers pah,
 pa_project_accum_actuals paa
where
 pah.project_accum_id = paa.project_accum_id and
 pah.resource_list_member_id = 0
),
commitments as
(
select
 pah.project_id,
 pah.task_id,
 nvl(ppac.cmt_burdened_cost_ptd,0) cmt_burdened_cost_ptd
from
 pa_project_accum_headers pah,
 pa_project_accum_commitments  ppac
where
 pah.project_accum_id = ppac.project_accum_id and
 pah.resource_list_member_id = 0
),
budget_costs as
(
select
 pah.project_id,
 pah.task_id,
 nvl(base_burdened_cost_tot,0) budget_cost_amount,
 nvl(base_labor_hours_tot,0) budget_cost_hours,
 --
 nvl(pab.base_raw_cost_itd,0) baseline_raw_cost_itd,
 nvl(pab.base_raw_cost_ytd,0) baseline_raw_cost_ytd,
 nvl(pab.base_raw_cost_pp,0) baseline_raw_cost_pp,
 nvl(pab.base_raw_cost_ptd,0) baseline_raw_cost_ptd,
 nvl(pab.base_burdened_cost_itd,0) baseline_burdened_cost_itd,
 nvl(pab.base_burdened_cost_ytd,0) baseline_burdened_cost_ytd,
 nvl(pab.base_burdened_cost_pp,0) baseline_burdened_cost_pp,
 nvl(pab.base_burdened_cost_ptd,0) baseline_burdened_cost_ptd,
 nvl(pab.orig_raw_cost_itd,0) original_raw_cost_itd,
 nvl(pab.orig_raw_cost_ytd,0) original_raw_cost_ytd,
 nvl(pab.orig_raw_cost_pp,0) original_raw_cost_pp,
 nvl(pab.orig_raw_cost_ptd,0) original_raw_cost_ptd,
 nvl(pab.orig_burdened_cost_itd,0) original_burdened_cost_itd,
 nvl(pab.orig_burdened_cost_ytd,0) original_burdened_cost_ytd,
 nvl(pab.orig_burdened_cost_pp,0) original_burdened_cost_pp,
 nvl(pab.orig_burdened_cost_ptd,0) original_burdened_cost_ptd,
 nvl(pab.orig_labor_hours_itd,0) original_labor_hours_itd,
 nvl(pab.orig_labor_hours_ytd,0) original_labor_hours_ytd,
 nvl(pab.orig_labor_hours_pp,0) original_labor_hours_pp,
 nvl(pab.orig_labor_hours_ptd,0) original_labor_hours_ptd,
 nvl(pab.base_labor_hours_itd,0) baseline_labor_hours_itd,
 nvl(pab.base_labor_hours_ytd,0) baseline_labor_hours_ytd,
 nvl(pab.base_labor_hours_pp,0) baseline_labor_hours_pp,
 nvl(pab.base_labor_hours_ptd,0) baseline_labor_hours_ptd,
 nvl(pab.base_raw_cost_tot,0) baseline_raw_cost_tot,
 nvl(pab.base_burdened_cost_tot,0) baseline_burdened_cost_tot,
 nvl(pab.orig_raw_cost_tot,0) original_raw_cost_tot,
 nvl(pab.orig_burdened_cost_tot,0) original_burdened_cost_tot,
 nvl(pab.orig_labor_hours_tot,0) original_labor_hours_tot,
 nvl(pab.base_labor_hours_tot,0) baseline_labor_hours_tot
from
 pa_project_accum_headers pah,
 pa_project_accum_budgets pab,
 pa_budget_types pbt
where
 pah.project_accum_id = pab.project_accum_id and
 pab.budget_type_code = pbt.budget_type_code and
 pab.budget_type_code = pa_paxbubss_xmlp_pkg.c_cost_bgt_code_p and
 pah.resource_list_member_id = 0 and
 pbt.budget_amount_code = 'C'
 ),
budget_revenues as
(
select
 pah.project_id,
 pah.task_id,
 nvl(base_revenue_tot,0) budget_revenue_amount,
 nvl(base_labor_hours_tot,0) budget_revenue_hours,
 --
 nvl(pab.base_revenue_itd,0) baseline_revenue_itd,
 nvl(pab.base_revenue_ytd,0) baseline_revenue_ytd,
 nvl(pab.base_revenue_pp,0) baseline_revenue_pp,
 nvl(pab.base_revenue_ptd,0) baseline_revenue_ptd,
 nvl(pab.orig_revenue_itd,0) original_revenue_itd,
 nvl(pab.orig_revenue_ytd,0) original_revenue_ytd,
 nvl(pab.orig_revenue_pp,0) original_revenue_pp,
 nvl(pab.orig_revenue_ptd,0) original_revenue_ptd,
 nvl(pab.orig_labor_hours_itd,0) original_labor_hours_itd,
 nvl(pab.orig_labor_hours_ytd,0) original_labor_hours_ytd,
 nvl(pab.orig_labor_hours_pp,0) original_labor_hours_pp,
 nvl(pab.orig_labor_hours_ptd,0) original_labor_hours_ptd,
 nvl(pab.base_labor_hours_itd,0) baseline_labor_hours_itd,
 nvl(pab.base_labor_hours_ytd,0) baseline_labor_hours_ytd,
 nvl(pab.base_labor_hours_pp,0) baseline_labor_hours_pp,
 nvl(pab.base_labor_hours_ptd,0) baseline_labor_hours_ptd,
 nvl(pab.base_revenue_tot,0) baseline_revenue_tot,
 nvl(pab.orig_revenue_tot,0) original_revenue_tot,
 nvl(pab.orig_labor_hours_tot,0) original_labor_hours_tot,
 nvl(pab.base_labor_hours_tot,0) baseline_labor_hours_tot
from
 pa_project_accum_headers pah,
 pa_project_accum_budgets pab,
 pa_budget_types pbt
where
 pah.project_accum_id = pab.project_accum_id and
 pab.budget_type_code = pbt.budget_type_code and
 pah.resource_list_member_id = 0 and
 pab.budget_type_code = pa_paxbubss_xmlp_pkg.c_rev_bgt_code_p and
 pbt.budget_amount_code = 'R'
)
--
-- Main Query
--
select /*+ ordered push_pred(t) push_pred(a) push_pred(c) push_pred(bc) push_pred(br) */
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
 -- tasks
 t.report_level,
 t.wbs_level task_level,
 t.task_number,
 t.task_name,
 t.top_level_task,
 t.task_hierarchy,
 t.task_organization,
 t.task_manager,
 -- actuals
 case when a.project_id is not null then a.actual_revenue_amount else null end actual_revenue_amount,
 case when a.project_id is not null then a.actual_cost_amount else null end actual_cost_amount,
 case when a.project_id is not null then a.actual_hours else null end actual_hours,
 -- cost_budget
 case when bc.project_id is not null then bc.budget_cost_amount else null end budget_cost_amount,
 case when bc.project_id is not null then bc.budget_cost_hours else null end budget_cost_hours,
 -- revenue_budget
 case when br.project_id is not null then br.budget_revenue_amount else null end budget_revenue_amount,
 case when br.project_id is not null then br.budget_revenue_hours else null end budget_revenue_hours,
 --
 -- The following column list is from the Project Status Inquiry Form
 --
 decode((sign((nvl(bc.baseline_burdened_cost_itd,0) * 1.1) - (nvl(a.burdened_cost_itd,0) + nvl(c.cmt_burdened_cost_ptd,0)))), -1, xxen_util.meaning('Y','YES_NO',0), null) ovr_bgt,
 round(nvl(br.baseline_revenue_itd,0)) itd_rev_bgt,
 round(nvl(a.revenue_itd,0)) itd_act_rev,
 round(nvl(bc.baseline_burdened_cost_itd,0)) itd_cst_bgt,
 round(nvl(a.burdened_cost_itd,0)) itd_act_cost,
 round(nvl(c.cmt_burdened_cost_ptd,0)) commit_amt,
 round(nvl(bc.baseline_labor_hours_itd,0)) itd_bgt_hrs,
 round(nvl(a.labor_hours_itd,0)) itd_act_hrs,
 --
 round(nvl(bc.baseline_burdened_cost_ptd,0)) ptd_cst_bgt,
 round(nvl(a.burdened_cost_ptd,0)) ptd_act_cost,
 round(nvl(bc.baseline_labor_hours_ptd,0)) ptd_bgt_hrs,
 round(nvl(a.labor_hours_ptd,0)) ptd_act_hrs,
 --
 round(nvl(br.baseline_revenue_tot,0)) tot_rev_bgt,
 round(nvl(bc.baseline_burdened_cost_tot,0)) tot_cst_bgt,
 round(nvl(bc.baseline_labor_hours_tot,0)) tot_bgt_hrs,
 --
 round(decode(bc.baseline_burdened_cost_tot, 0, 0, (a.burdened_cost_itd/bc.baseline_burdened_cost_tot) * 100)) fin_pct_cmplt,
 round(decode(bc.baseline_labor_hours_tot,0,0, (a.labor_hours_itd/bc.baseline_labor_hours_tot) * 100)) hrs_pct_cmplt,
 round(nvl(bc.baseline_burdened_cost_tot,0) - nvl(c.cmt_burdened_cost_ptd,0) - nvl(a.burdened_cost_itd,0)) est_to_cmplt,
 round(nvl(a.burdened_cost_itd,0) + nvl(c.cmt_burdened_cost_ptd,0)) tot_cst_itd,
 round(nvl(br.baseline_revenue_tot,0) - nvl(bc.baseline_burdened_cost_tot,0)) bgt_mgn,
 round(nvl(a.revenue_itd,0) - nvl(a.burdened_cost_itd,0)) act_mgn_itd,
 --
 round(nvl(br.original_revenue_itd,0)) itd_orig_rev_bgt,
 round(nvl(br.original_revenue_tot,0)) tot_orig_rev_bgt,
 round(nvl(bc.original_burdened_cost_itd,0)) itd_orig_cst_bgt,
 round(nvl(bc.original_burdened_cost_tot,0)) tot_orig_cst_bgt,
 round(nvl(bc.original_labor_hours_tot,0)) tot_orig_bgt_hrs,
 --
 --
 p.project_id,
 t.task_id
from
 projects p,
 tasks t,
 actuals a,
 commitments c,
 budget_costs bc,
 budget_revenues br
where
 p.project_id = t.project_id and
 --
 t.project_id = a.project_id (+) and
 t.task_id = a.task_id (+) and
 --
 t.project_id = c.project_id (+) and
 t.task_id = c.task_id (+) and
 --
 t.project_id = bc.project_id (+) and
 t.task_id = bc.task_id (+) and
 --
 t.project_id = br.project_id (+) and
 t.task_id = br.task_id (+)
order by
 operating_unit,
 project_organization,
 project_manager,
 project_number,
 task_hierarchy
/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Project Revenue and Cost by Period
-- Description: Revenue, raw cost, burdened cost and margin per project and top task for each GL or PA period, in the project functional currency.
-- Cost is taken from the raw cost distribution lines of all expenditure items, revenue from the released draft revenue of expenditure items and events. Period Basis decides whether amounts are assigned to periods by their GL date and the ledger's accounting periods, or by their PA date and the PA periods. A date range that starts or ends inside a period includes only part of that period.
-- Event revenue entered at project level shows a blank top task. Run over all periods, the totals agree with the inception-to-date actuals of Update Project Summary Amounts as of its last run.
-- The templates Pivot: by Period and Pivot: by Year show projects against periods or fiscal years.
-- Excel Example Output: https://www.enginatics.com/example/pa-project-revenue-and-cost-by-period/
-- Library Link: https://www.enginatics.com/reports/pa-project-revenue-and-cost-by-period/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
ppa.segment1 project_number,
ppa.name project_name,
ppa.project_type,
pps.project_status_name project_status,
haouv2.name project_organization,
pt.task_number top_task_number,
pt.task_name top_task_name,
gp.period_year,
gp.period_name,
to_char(gp.period_year)||'-'||lpad(gp.period_num,2,'0')||' ('||gp.period_name||')' period,
ppa.projfunc_currency_code currency,
sum(y.revenue) revenue,
sum(y.raw_cost) raw_cost,
sum(y.burdened_cost) burdened_cost,
nvl(sum(y.revenue),0)-nvl(sum(y.burdened_cost),0) margin,
round(100*(sum(y.revenue)-sum(y.burdened_cost))/nullif(sum(y.revenue),0),2) margin_percent
from
(
select
pcdla.project_id,
pt.top_task_id,
decode(:period_basis,'PA',pcdla.pa_date,pcdla.gl_date) period_date,
to_number(null) revenue,
sum(pcdla.amount) raw_cost,
sum(pcdla.burdened_cost) burdened_cost
from
pa_cost_distribution_lines_all pcdla,
pa_tasks pt
where
pcdla.line_type='R' and
pcdla.task_id=pt.task_id
group by
pcdla.project_id,
pt.top_task_id,
decode(:period_basis,'PA',pcdla.pa_date,pcdla.gl_date)
union all
select
pcrdla.project_id,
pt.top_task_id,
decode(:period_basis,'PA',pdra.pa_date,pdra.gl_date) period_date,
sum(pcrdla.projfunc_revenue_amount) revenue,
to_number(null) raw_cost,
to_number(null) burdened_cost
from
pa_draft_revenues_all pdra,
pa_cust_rev_dist_lines_all pcrdla,
pa_expenditure_items_all peia,
pa_tasks pt
where
pdra.released_date is not null and
pdra.project_id=pcrdla.project_id and
pdra.draft_revenue_num=pcrdla.draft_revenue_num and
pcrdla.expenditure_item_id=peia.expenditure_item_id and
peia.task_id=pt.task_id
group by
pcrdla.project_id,
pt.top_task_id,
decode(:period_basis,'PA',pdra.pa_date,pdra.gl_date)
union all
select
pcera.project_id,
pt.top_task_id,
decode(:period_basis,'PA',pdra.pa_date,pdra.gl_date) period_date,
sum(pcera.projfunc_revenue_amount) revenue,
to_number(null) raw_cost,
to_number(null) burdened_cost
from
pa_draft_revenues_all pdra,
pa_cust_event_rdl_all pcera,
pa_tasks pt
where
pdra.released_date is not null and
pdra.project_id=pcera.project_id and
pdra.draft_revenue_num=pcera.draft_revenue_num and
pcera.task_id=pt.task_id(+)
group by
pcera.project_id,
pt.top_task_id,
decode(:period_basis,'PA',pdra.pa_date,pdra.gl_date)
) y,
pa_projects_all ppa,
hr_all_organization_units_vl haouv,
pa_project_statuses pps,
hr_all_organization_units_vl haouv2,
pa_tasks pt,
pa_implementations_all pia,
gl_ledgers gl,
gl_periods gp
where
1=1 and
y.period_date>=:date_from and
y.period_date<:date_to+1 and
y.project_id=ppa.project_id and
ppa.org_id=haouv.organization_id and
haouv.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
ppa.project_status_code=pps.project_status_code and
ppa.carrying_out_organization_id=haouv2.organization_id and
y.top_task_id=pt.task_id(+) and
ppa.org_id=pia.org_id and
pia.set_of_books_id=gl.ledger_id and
gl.period_set_name=gp.period_set_name and
decode(:period_basis,'PA',pia.pa_period_type,gl.accounted_period_type)=gp.period_type and
gp.adjustment_period_flag='N' and
y.period_date between gp.start_date and gp.end_date
group by
haouv.name,
ppa.segment1,
ppa.name,
ppa.project_type,
pps.project_status_name,
haouv2.name,
pt.task_number,
pt.task_name,
gp.period_year,
gp.period_num,
gp.period_name,
ppa.projfunc_currency_code
order by
haouv.name,
ppa.segment1,
pt.task_number,
gp.period_year,
gp.period_num

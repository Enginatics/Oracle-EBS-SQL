/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Project Billing Status
-- Description: Project billing overview showing revenue, billed and unbilled amounts, funding totals, and available funding for each project.
-- Excel Examle Output: https://www.enginatics.com/example/pa-project-billing-status/
-- Library Link: https://www.enginatics.com/reports/pa-project-billing-status/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
ppa.segment1 project_number,
ppa.name project_name,
ppta.project_type,
(select pps.project_status_name from pa_project_statuses pps where pps.project_status_code=ppa.project_status_code) project_status,
(select haouv2.name from hr_all_organization_units_vl haouv2 where haouv2.organization_id=ppa.carrying_out_organization_id) project_organization,
(select ppx.full_name from pa_project_players ppp, per_people_x ppx where ppp.project_id=ppa.project_id and ppp.project_role_type='PROJECT MANAGER' and sysdate between ppp.start_date_active and nvl(ppp.end_date_active,sysdate) and ppp.person_id=ppx.person_id and rownum=1) project_manager,
ppa.start_date,
ppa.completion_date,
(select sum(ppaa.revenue_itd) from pa_project_accum_actuals ppaa, pa_project_accum_headers ppah where ppah.project_accum_id=ppaa.project_accum_id and ppah.project_id=ppa.project_id and ppah.task_id=0 and ppah.resource_list_member_id=0) total_revenue,
(select sum(ppaa.raw_cost_itd) from pa_project_accum_actuals ppaa, pa_project_accum_headers ppah where ppah.project_accum_id=ppaa.project_accum_id and ppah.project_id=ppa.project_id and ppah.task_id=0 and ppah.resource_list_member_id=0) total_cost,
(select sum(pdii.amount) from pa_draft_invoice_items pdii, pa_draft_invoices_all pdia2 where pdii.project_id=ppa.project_id and pdii.project_id=pdia2.project_id and pdii.draft_invoice_num=pdia2.draft_invoice_num and pdia2.released_date is not null) total_billed,
(select sum(ppaa.revenue_itd) from pa_project_accum_actuals ppaa, pa_project_accum_headers ppah where ppah.project_accum_id=ppaa.project_accum_id and ppah.project_id=ppa.project_id and ppah.task_id=0 and ppah.resource_list_member_id=0)-nvl((select sum(pdii.amount) from pa_draft_invoice_items pdii, pa_draft_invoices_all pdia2 where pdii.project_id=ppa.project_id and pdii.project_id=pdia2.project_id and pdii.draft_invoice_num=pdia2.draft_invoice_num and pdia2.released_date is not null),0) unbilled_receivable,
(select sum(pspf.total_baselined_amount) from pa_summary_project_fundings pspf where pspf.project_id=ppa.project_id) total_funding,
nvl((select sum(pspf.total_baselined_amount) from pa_summary_project_fundings pspf where pspf.project_id=ppa.project_id),0)-nvl((select sum(ppaa.revenue_itd) from pa_project_accum_actuals ppaa, pa_project_accum_headers ppah where ppah.project_accum_id=ppaa.project_accum_id and ppah.project_id=ppa.project_id and ppah.task_id=0 and ppah.resource_list_member_id=0),0) available_funding,
(select max(pdia3.invoice_date) from pa_draft_invoices_all pdia3 where pdia3.project_id=ppa.project_id and pdia3.released_date is not null) last_invoice_date,
ppa.project_currency_code currency,
ppa.project_id
from
pa_projects_all ppa,
pa_project_types_all ppta,
hr_all_organization_units_vl haouv
where
1=1 and
ppa.project_type=ppta.project_type and
ppa.org_id=ppta.org_id and
ppa.org_id=haouv.organization_id and
haouv.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
order by
haouv.name,
ppa.segment1
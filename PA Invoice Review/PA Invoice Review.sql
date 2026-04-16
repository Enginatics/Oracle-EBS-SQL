/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Invoice Review
-- Description: Project draft invoices with line details showing invoice amounts, approval and release status, customer, GL date, and expenditure type breakdown.
-- Excel Examle Output: https://www.enginatics.com/example/pa-invoice-review/
-- Library Link: https://www.enginatics.com/reports/pa-invoice-review/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
ppa.segment1 project_number,
ppa.name project_name,
pdia.draft_invoice_num,
pdia.invoice_date,
hp.party_name customer_name,
hca.account_number customer_number,
pdia.bill_through_date,
(select sum(pdii2.amount) from pa_draft_invoice_items pdii2 where pdii2.project_id=pdia.project_id and pdii2.draft_invoice_num=pdia.draft_invoice_num) invoice_amount,
pdia.inv_currency_code,
xxen_util.meaning(case when pdia.approved_date is not null then 'Y' end,'YES_NO',0) approved,
pdia.approved_date,
xxen_util.meaning(case when pdia.released_date is not null then 'Y' end,'YES_NO',0) released,
pdia.released_date,
xxen_util.meaning(case when pdia.transferred_date is not null then 'Y' end,'YES_NO',0) transferred,
pdia.transferred_date,
pdia.gl_date,
pdia.pa_period_name period_name,
pdii.line_num invoice_line_num,
pdii.amount line_amount,
pdii.text line_description,
(select pt.task_number from pa_tasks pt where pt.task_id=pdii.task_id) line_task_number,
pdii.event_num,
xxen_util.user_name(pdia.created_by) created_by,
pdia.creation_date,
xxen_util.user_name(pdia.last_updated_by) last_updated_by,
pdia.last_update_date
from
pa_draft_invoices_all pdia,
pa_draft_invoice_items pdii,
pa_projects_all ppa,
hz_cust_accounts hca,
hz_parties hp,
hr_all_organization_units_vl haouv
where
1=1 and
pdia.project_id=pdii.project_id and
pdia.draft_invoice_num=pdii.draft_invoice_num and
pdia.project_id=ppa.project_id and
ppa.org_id=haouv.organization_id and
haouv.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
pdia.bill_to_customer_id=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+)
order by
haouv.name,
ppa.segment1,
pdia.draft_invoice_num,
pdii.line_num
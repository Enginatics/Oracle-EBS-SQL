/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Supplier Invoice Audit
-- Description: AP invoices charged to projects showing vendor, invoice, cost distribution, and GL transfer details for supplier expenditure audit.
-- Excel Examle Output: https://www.enginatics.com/example/pa-supplier-invoice-audit/
-- Library Link: https://www.enginatics.com/reports/pa-supplier-invoice-audit/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
ppa.segment1 project_number,
ppa.name project_name,
pt.task_number,
pt.task_name,
peia.expenditure_type,
aps.vendor_name,
aps.segment1 vendor_number,
aia.invoice_num,
aia.invoice_date,
aia.invoice_amount,
aia.invoice_currency_code,
peia.expenditure_item_date,
pcdla.pa_period_name period_name,
pcdla.gl_date,
pcdla.transferred_date transfer_date,
gcck.concatenated_segments gl_account,
pcdla.amount raw_cost,
pcdla.burdened_cost,
peia.quantity,
peia.expenditure_item_id,
pcdla.line_num distribution_line_num,
xxen_util.meaning(pcdla.transfer_status_code,'TRANSFER STATUS',275) transfer_status,
xxen_util.user_name(pcdla.created_by) created_by,
pcdla.creation_date
from
pa_cost_distribution_lines_all pcdla,
pa_expenditure_items_all peia,
pa_expenditures_all pea,
pa_projects_all ppa,
pa_tasks pt,
ap_invoices_all aia,
ap_suppliers aps,
gl_code_combinations_kfv gcck,
hr_all_organization_units_vl haouv
where
1=1 and
pcdla.line_type='R' and
peia.system_linkage_function='VI' and
pcdla.expenditure_item_id=peia.expenditure_item_id and
peia.expenditure_id=pea.expenditure_id and
peia.project_id=ppa.project_id and
peia.task_id=pt.task_id and
peia.document_header_id=aia.invoice_id(+) and
aia.vendor_id=aps.vendor_id(+) and
pcdla.dr_code_combination_id=gcck.code_combination_id(+) and
ppa.org_id=haouv.organization_id and
haouv.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
order by
haouv.name,
ppa.segment1,
pt.task_number,
aps.vendor_name,
aia.invoice_num
/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Invoice Price Variance
-- Description: Report to display the Invoice Price Variances (IPV), Exchange Rate Variances (ERV) and A/P Accrual Write-Off Variances for an entered date range. IPV is the difference between the PO unit price and the invoice unit cost times the quantity invoiced. ERV is the difference between the purchase order exchange rate and the exchange rate used by the A/P invoice. For a given invoice line, both the IPV and ERV amounts will be shown on the same row, in separate columns. These entries have the Type "IPV-ERV". The A/P Accrual Write-Off Variances appear as separate rows with the Type "INV WO" for invoice write-off amounts. The A/P Accrual Write-Off Variances typically use the IPV account so for completeness, are also displayed on this report.
-- / +=============================================================================+
-- -- | Copyright 2006-2021 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxipvrept.sql
-- -- |
-- -- | Parameters:
-- -- | ptrxdatefrom -- starting accounting date for the payables invoices
-- -- | ptrxdateto -- ending accounting date for the payables invoices
-- -- | pcategoryset1 -- The first item category set to report, typically the
-- -- | Cost or Product Line Category Set
-- -- | pcategoryset2 -- The second item category set to report, typically the
-- -- | Inventory Category Set
-- -- | pvendorname -- Vendor you want to report (optional)
-- -- | poperatingunit -- Operating Unit you wish to report, leave blank for all
-- -- | operating units (optional)
-- -- | pledger -- general ledger you wish to report, leave blank for all
-- -- | ledgers (optional)
-- -- |
-- -- | Description:
-- -- | Report to display the invoice price variances for an entered date range.
-- -- | IPV is the difference between the PO unit price and the invoice unit
-- -- | cost times the quantity invoiced.
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 01 Jun 2006 Douglas Volz Initial Coding based on XXXIPVREPT.sql
-- -- | 1.1 17 Apr 2010 Douglas Volz Modified for Release 12 for Client, the IPV
-- -- | columns are now null as a new line type
-- -- | exists for IPV in AID, and the amount columns
-- -- | only have the PO amounts, not the total invoice
-- -- | amount.
-- -- | 1.11 22 May 2017 Douglas Volz Added product type, business code, product family and
-- -- | and product line inventory categories
-- -- | 1.12 20 Jul 2019 Douglas Volz Removed all item categories except COSTING.
-- -- | 1.13 18 Feb 2021 Douglas Volz Changed to multi-org views for items, categories
-- -- | and HR organizations.
-- -- | 1.14 12 Apr 2021 Douglas Volz Removed redundant joins and tables to improve performance.
-- -- | 1.15 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-invoice-price-variance/
-- Library Link: https://www.enginatics.com/reports/cac-invoice-price-variance/
-- Run Report: https://demo.enginatics.com/

select
gl.name ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
x.period_name,
&segment_columns
x.type,
xxen_util.meaning(x.accounting_class_code,'XLA_ACCOUNTING_CLASS',602) accounting_class_code,
x.supplier,
x.buyer,
msiv.concatenated_segments item_number,
nvl(msiv.description,x.item_description) item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
&category_columns
xxen_util.meaning(x.destination_type_code,'DESTINATION TYPE',201) destination_type,
x.po_number,
x.po_line,
x.po_release,
x.invoice_number,
decode(x.ipv_distribution_line_number,0,null,x.ipv_distribution_line_number) ipv_invoice_line,
decode(x.erv_distribution_line_number,0,null,x.erv_distribution_line_number) erv_invoice_line,
x.invoice_date,
x.accounting_date,
x.po_uom,
x.invoice_quantity,
nvl(x.po_currency_code,gl.currency_code) po_currency_code,
x.po_unit_price,
nvl(x.po_rate,1) po_exchange_rate,
gl.currency_code gl_currency_code,
round(nvl(x.po_rate,1)*x.po_unit_price,6) converted_po_unit_price,
nvl(x.po_rate,1)*x.po_unit_price*x.invoice_quantity total_po_amount,
nvl(x.invoice_currency_code,gl.currency_code) invoice_currency_code,
x.unit_price payables_unit_cost,
nvl(x.exchange_rate,1) payables_exchange_rate,
round(nvl(x.unit_price,0)*nvl(x.exchange_rate,1),6) converted_invoice_unit_cost,
decode(x.section,'WO',0,round(nvl(x.unit_price,0)*nvl(x.exchange_rate,1),6)-round(nvl(x.po_rate,1)*x.po_unit_price,6)) unit_cost_variance,
round(nvl(x.unit_price,0)*nvl(x.exchange_rate,1)*x.invoice_quantity,2) total_invoice_amount,
round((nvl(x.unit_price,0)*nvl(x.exchange_rate,1)-nvl(x.po_rate,1)*x.po_unit_price)*x.invoice_quantity,2) total_calculated_ipv,
x.ipv_amount general_ledger_ipv_amount,
x.erv_amount general_ledger_erv_amount,
round((nvl(x.unit_price,0)*nvl(x.exchange_rate,1)-nvl(x.po_rate,1)*x.po_unit_price)*x.invoice_quantity/abs(decode(nvl(x.po_rate,1)*x.po_unit_price*x.invoice_quantity,0,1,nvl(x.po_rate,1)*x.po_unit_price*x.invoice_quantity))*100,1) percent
from
(
select
'INV' section,
v.ledger_id,
v.period_name,
plla.ship_to_organization_id organization_id,
aia.org_id,
pla.item_id inventory_item_id,
null item_description,
v.ipv_code_combination_id,
v.erv_code_combination_id,
v.type,
v.accounting_class_code,
aps.vendor_name supplier,
(select he.full_name from hr_employees he where pha.agent_id=he.employee_id) buyer,
v.destination_type_code,
pha.segment1 po_number,
to_char(pla.line_num) po_line,
pra.release_num po_release,
aia.invoice_num invoice_number,
v.ipv_distribution_line_number,
v.erv_distribution_line_number,
aia.invoice_date,
v.accounting_date,
pla.unit_meas_lookup_code po_uom,
v.quantity_invoiced*mucv.conversion_rate invoice_quantity,
pha.currency_code po_currency_code,
plla.price_override po_unit_price,
v.rate po_rate,
aia.invoice_currency_code,
v.unit_price,
aia.exchange_rate,
v.ipv_amount,
v.erv_amount
from
(
select
y.invoice_id,
y.period_name,
y.ledger_id,
y.accounting_date,
y.ipv_code_combination_id,
y.erv_code_combination_id,
y.type,
y.accounting_class_code,
y.ipv_distribution_line_number,
y.erv_distribution_line_number,
y.po_line_id,
y.line_location_id,
y.rate,
y.destination_type_code,
sum(nvl(aida.quantity_invoiced,0)) quantity_invoiced,
sum(nvl(aida.unit_price,0)) unit_price,
sum(y.ipv_amount) ipv_amount,
sum(y.erv_amount) erv_amount
from
(
select
z.invoice_id,
z.period_name,
z.ledger_id,
z.accounting_date,
max(z.ipv_code_combination_id) ipv_code_combination_id,
max(z.erv_code_combination_id) erv_code_combination_id,
'IPV-ERV' type,
max(z.accounting_class_code) accounting_class_code,
max(z.ipv_distribution_line_number) ipv_distribution_line_number,
max(z.erv_distribution_line_number) erv_distribution_line_number,
max(z.ipv_invoice_distribution_id) ipv_invoice_distribution_id,
max(z.erv_invoice_distribution_id) erv_invoice_distribution_id,
z.invoice_line_number,
z.matched_uom_lookup_code,
z.po_distribution_id,
z.quantity_invoiced,
z.related_id,
z.unit_price,
sum(z.ipv_amount) ipv_amount,
sum(z.erv_amount) erv_amount,
z.po_line_id,
z.line_location_id,
z.rate,
z.destination_type_code
from
(
select
aida.invoice_id,
aida.period_name,
xal.ledger_id,
aida.accounting_date,
decode(aida.line_type_lookup_code,'IPV',xal.code_combination_id) ipv_code_combination_id,
decode(aida.line_type_lookup_code,'ERV',xal.code_combination_id) erv_code_combination_id,
xal.accounting_class_code,
decode(aida.line_type_lookup_code,'IPV',aida.invoice_line_number) ipv_distribution_line_number,
decode(aida.line_type_lookup_code,'ERV',aida.invoice_line_number) erv_distribution_line_number,
decode(aida.line_type_lookup_code,'IPV',aida.invoice_distribution_id) ipv_invoice_distribution_id,
decode(aida.line_type_lookup_code,'ERV',aida.invoice_distribution_id) erv_invoice_distribution_id,
aida.invoice_line_number,
aida.matched_uom_lookup_code,
aida.po_distribution_id,
aida.quantity_invoiced,
aida.related_id,
aida.unit_price,
decode(aida.line_type_lookup_code,'IPV',aida.base_amount,0) ipv_amount,
decode(aida.line_type_lookup_code,'ERV',aida.base_amount,0) erv_amount,
pda.po_line_id,
pda.line_location_id,
pda.rate,
pda.destination_type_code
from
ap_invoice_distributions_all aida,
po_distributions_all pda,
xla_distribution_links xdl,
xla_ae_lines xal
where
2=2 and
aida.line_type_lookup_code in ('IPV','ERV') and
aida.po_distribution_id=pda.po_distribution_id and
pda.destination_type_code<>'EXPENSE' and
aida.invoice_distribution_id=xdl.source_distribution_id_num_1 and
xdl.source_distribution_type='AP_INV_DIST' and
xdl.application_id=200 and
xdl.ae_header_id=xal.ae_header_id and
xdl.ae_line_num=xal.ae_line_num and
xal.application_id=200 and
xal.accounting_class_code=decode(aida.line_type_lookup_code,'IPV','IPV','EXCHANGE_RATE_VARIANCE')
) z
group by
z.invoice_id,
z.period_name,
z.ledger_id,
z.accounting_date,
z.invoice_line_number,
z.matched_uom_lookup_code,
z.po_distribution_id,
z.quantity_invoiced,
z.related_id,
z.unit_price,
z.po_line_id,
z.line_location_id,
z.rate,
z.destination_type_code
) y,
ap_invoice_distributions_all aida
where
y.related_id=aida.related_id and
aida.line_type_lookup_code='ACCRUAL'
group by
y.invoice_id,
y.period_name,
y.ledger_id,
y.accounting_date,
y.ipv_code_combination_id,
y.erv_code_combination_id,
y.type,
y.accounting_class_code,
y.ipv_distribution_line_number,
y.erv_distribution_line_number,
y.ipv_invoice_distribution_id,
y.erv_invoice_distribution_id,
y.invoice_line_number,
aida.matched_uom_lookup_code,
y.po_distribution_id,
y.related_id,
y.po_line_id,
y.line_location_id,
y.rate,
y.destination_type_code
) v,
ap_invoices_all aia,
po_line_locations_all plla,
po_lines_all pla,
po_headers_all pha,
po_releases_all pra,
ap_suppliers aps,
mtl_uom_conversions_view mucv
where
v.invoice_id=aia.invoice_id and
v.line_location_id=plla.line_location_id and
v.po_line_id=pla.po_line_id and
plla.po_line_id=pla.po_line_id and
pla.po_header_id=pha.po_header_id and
aia.org_id=pha.org_id and
plla.po_release_id=pra.po_release_id(+) and
pha.vendor_id=aps.vendor_id and
plla.ship_to_organization_id=mucv.organization_id and
pla.item_id=mucv.inventory_item_id and
pla.unit_meas_lookup_code=mucv.unit_of_measure
union all
select
'WO' section,
w.ledger_id,
w.period_name,
w.organization_id,
to_number(null) org_id,
w.inventory_item_id,
w.item_description,
w.code_combination_id ipv_code_combination_id,
to_number(null) erv_code_combination_id,
w.write_off_type type,
w.accounting_class_code,
w.vendor_name supplier,
w.full_name buyer,
w.destination_type_code,
w.po_number,
w.po_line,
w.release_num po_release,
null invoice_number,
w.ipv_distribution_line_number,
0 erv_distribution_line_number,
w.invoice_date,
w.accounting_date,
w.unit_meas_lookup_code po_uom,
w.quantity_invoiced*w.conversion_rate invoice_quantity,
w.currency_code po_currency_code,
w.price_override po_unit_price,
w.rate po_rate,
w.invoice_currency_code,
w.unit_price,
w.exchange_rate,
w.ipv_amount,
0 erv_amount
from
(
select
cwo.write_off_id,
xal.ledger_id,
xah.period_name,
xal.code_combination_id,
xal.accounting_class_code,
cwo.destination_type_code,
cwo.transaction_date accounting_date,
nvl(cwo.currency_conversion_rate,1) conversion_rate,
cwo.currency_code,
decode(cwo.inventory_transaction_id,null,decode(cwo.po_distribution_id,null,'AP No PO WO','AP-PO WO'),'INV WO') write_off_type,
case
when cwo.inventory_transaction_id is not null then (select max(mta.organization_id) from mtl_transaction_accounts mta where cwo.inventory_transaction_id=mta.transaction_id and cwo.accrual_account_id=mta.reference_account)
when cwo.po_distribution_id is not null then plla.ship_to_organization_id
else (select osp.master_organization_id from oe_system_parameters_all osp where aida.org_id=osp.org_id)
end organization_id,
coalesce(mmt.inventory_item_id,pla.item_id) inventory_item_id,
coalesce(pla.item_description,aida.description) item_description,
coalesce(aps_po.vendor_name,aps_ap.vendor_name) vendor_name,
nvl((select he.full_name from hr_employees he where pha.agent_id=he.employee_id),(select fu.user_name from fnd_user fu where nvl(mmt.created_by,aia.created_by)=fu.user_id)) full_name,
pha.segment1 po_number,
to_char(pla.line_num) po_line,
pra.release_num,
nvl(aida.distribution_line_number,0) ipv_distribution_line_number,
aia.invoice_date,
coalesce(pla.unit_meas_lookup_code,aida.matched_uom_lookup_code,aia.invoice_currency_code,(select msiv.primary_unit_of_measure from mtl_system_items_vl msiv where mmt.organization_id=msiv.organization_id and mmt.inventory_item_id=msiv.inventory_item_id)) unit_meas_lookup_code,
coalesce((select sum(mta.primary_quantity) from mtl_transaction_accounts mta where cwo.inventory_transaction_id=mta.transaction_id and cwo.accrual_account_id=mta.reference_account),aida.quantity_invoiced,0) quantity_invoiced,
coalesce(mmt.actual_cost,plla.price_override,0) price_override,
coalesce(mmt.currency_conversion_rate,pda.rate,pha.rate,1) rate,
aia.invoice_currency_code,
nvl(aida.unit_price,0) unit_price,
nvl(aida.exchange_rate,1) exchange_rate,
sum(nvl(xal.accounted_dr,0)-nvl(xal.accounted_cr,0)) ipv_amount
from
cst_write_offs cwo,
mtl_material_transactions mmt,
po_distributions_all pda,
po_line_locations_all plla,
po_lines_all pla,
po_headers_all pha,
po_releases_all pra,
ap_suppliers aps_po,
ap_invoice_distributions_all aida,
ap_invoices_all aia,
ap_suppliers aps_ap,
xla_distribution_links xdl,
xla_ae_lines xal,
xla_ae_headers xah
where
cwo.transaction_date>=:p_trx_date_from and
cwo.transaction_date<:p_trx_date_to+1 and
cwo.inventory_transaction_id=mmt.transaction_id(+) and
cwo.po_distribution_id=pda.po_distribution_id(+) and
pda.line_location_id=plla.line_location_id(+) and
pda.po_line_id=pla.po_line_id(+) and
pda.po_header_id=pha.po_header_id(+) and
plla.po_release_id=pra.po_release_id(+) and
pha.vendor_id=aps_po.vendor_id(+) and
cwo.invoice_distribution_id=aida.invoice_distribution_id(+) and
aida.invoice_id=aia.invoice_id(+) and
aia.vendor_id=aps_ap.vendor_id(+) and
cwo.write_off_id=xdl.source_distribution_id_num_1 and
xdl.source_distribution_type='CST_WRITE_OFFS' and
xdl.application_id=707 and
xdl.ae_header_id=xal.ae_header_id and
xdl.ae_line_num=xal.ae_line_num and
xal.application_id=707 and
xal.ae_header_id=xah.ae_header_id and
xal.application_id=xah.application_id
group by
cwo.write_off_id,
xal.ledger_id,
xah.period_name,
xal.code_combination_id,
xal.accounting_class_code,
cwo.destination_type_code,
cwo.transaction_date,
cwo.currency_conversion_rate,
cwo.currency_code,
cwo.inventory_transaction_id,
cwo.po_distribution_id,
cwo.accrual_account_id,
plla.ship_to_organization_id,
aida.org_id,
mmt.inventory_item_id,
mmt.organization_id,
mmt.created_by,
mmt.actual_cost,
mmt.currency_conversion_rate,
pla.item_id,
pla.item_description,
aida.description,
aps_po.vendor_name,
aps_ap.vendor_name,
pha.agent_id,
aia.created_by,
pha.segment1,
pla.line_num,
pra.release_num,
aida.distribution_line_number,
aia.invoice_date,
pla.unit_meas_lookup_code,
aida.matched_uom_lookup_code,
aia.invoice_currency_code,
aida.quantity_invoiced,
plla.price_override,
pda.rate,
pha.rate,
aida.unit_price,
aida.exchange_rate
) w
) x,
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
mtl_system_items_vl msiv,
gl_code_combinations gcc1,
gl_code_combinations gcc2
where
1=1 and
3=3 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
x.organization_id=mp.organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv_ou.organization_id and
nvl(x.org_id,haouv_ou.organization_id)=haouv_ou.organization_id and
x.ledger_id=gl.ledger_id and
x.organization_id=msiv.organization_id(+) and
x.inventory_item_id=msiv.inventory_item_id(+) and
x.ipv_code_combination_id=gcc1.code_combination_id(+) and
x.erv_code_combination_id=gcc2.code_combination_id(+)
order by
gl.name,
haouv_ou.name,
mp.organization_code,
x.period_name,
x.type,
accounting_class_code,
x.supplier,
x.buyer,
item_number,
x.po_number,
x.po_line,
x.po_release,
x.invoice_number,
x.accounting_date

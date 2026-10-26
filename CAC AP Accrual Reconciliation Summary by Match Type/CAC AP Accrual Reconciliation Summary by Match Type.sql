/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC AP Accrual Reconciliation Summary by Match Type
-- Description: Use this report to summarize the A/P Accrual entries from the Accrual Reconcilation Report tables, by operating unit, accrual match type and inventory organization. Use this report for summary reconciliation purposes, to justify the "at time of receipt" accrual balances for your inventory and expense A/P accrual accounts.
-- Parameters:
-- ===========
-- Transaction Date From: enter the accrual starting transaction date you wish to report. Defaults to the earliest date found (mandatory).
-- Transaction Date To: enter the accrual ending transaction date you wish to report. Defaults to the latest date found (mandatory).
-- Operating Unit: operating unit you wish to report (optional).
-- Ledger: general ledger you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2011-2025 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 11 Nov 2011 Douglas Volz Initial Coding based on xxxapaccrualsummaryrept.sql
-- -- | Retrofitted to R12 A/P Accrual tables
-- -- | 1.1 07 May 2019 Douglas Volz Modified for upgrade client
-- -- | 1.2 06 Feb 2020 Douglas Volz Added Ledger parameter.
-- -- | 1.3 09 Apr 2020 Douglas Volz Commented out capr.inventorytransactionid column
-- -- | Was added by Oracle for consignment transactions in
-- -- | Release 12.1.6.
-- -- | 1.4 15 Apr 2020 Douglas Volz Undid modifications for upgrade client
-- -- | 1.5 17 Feb 2025 Douglas Volz Formatted for Blitz Report.
-- -- | 1.6 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-ap-accrual-reconciliation-summary-by-match-type/
-- Library Link: https://www.enginatics.com/reports/cac-ap-accrual-reconciliation-summary-by-match-type/
-- Run Report: https://demo.enginatics.com/

select
y.ledger,
y.operating_unit,
coalesce(xxen_util.meaning(y.transaction_type_code,'ACCRUAL TYPE',201),xxen_util.meaning(y.transaction_type_code,'RCV TRANSACTION TYPE',201),(select mtt.transaction_type_name from mtl_transaction_types mtt where y.transaction_type_code=to_char(mtt.transaction_type_id))) match_type,
y.org_code,
gcck.concatenated_segments accrual_account,
&segment_columns
y.currency_code,
y.receiving_amount,
y.payables_amount,
y.inventory_amount,
y.other_amount,
y.total_accounted_amount,
y.write_offs,
y.net_accounted_amount
from
(
select
gl.name ledger,
haouv.name operating_unit,
x.transaction_type_code,
mp.organization_code org_code,
x.accrual_account_id,
gl.currency_code,
sum(decode(xah.je_category_name,'Receiving',x.amount,0)) receiving_amount,
sum(decode(xah.je_category_name,'Purchase Invoices',x.amount,0)) payables_amount,
sum(decode(xah.je_category_name,'INVENTORY',x.amount,'Inventory',x.amount,'MTL',x.amount,0)) inventory_amount,
sum(decode(xah.je_category_name,'INVENTORY',0,'Inventory',0,'MTL',0,'Receiving',0,'Purchase Invoices',0,x.amount)) other_amount,
sum(x.total_amount) total_accounted_amount,
sum(x.write_off_amount) write_offs,
sum(x.net_amount) net_accounted_amount
from
(
select
capr.operating_unit_id,
capr.transaction_type_code,
pda.destination_organization_id organization_id,
capr.accrual_account_id,
capr.ae_header_id,
capr.ae_line_num,
nvl(capr.amount,0) amount,
decode(capr.write_off_id,null,nvl(capr.amount,0),0) total_amount,
decode(capr.write_off_id,null,0,nvl(capr.amount,0)) write_off_amount,
nvl(capr.amount,0) net_amount
from
cst_ap_po_reconciliation capr,
po_distributions_all pda
where
2=2 and
capr.operating_unit_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='OU') and
capr.po_distribution_id=pda.po_distribution_id
union all
select
cmr.operating_unit_id,
cmr.transaction_type_code,
cmr.inventory_organization_id,
cmr.accrual_account_id,
cmr.ae_header_id,
cmr.ae_line_num,
nvl(cmr.amount,0),
nvl(cmr.amount,0),
decode(nvl(cmr.write_off_select_flag,'N'),'N',0,nvl(cmr.amount,0)),
decode(nvl(cmr.write_off_select_flag,'N'),'N',nvl(cmr.amount,0),0)
from
cst_misc_reconciliation cmr
where
3=3 and
cmr.operating_unit_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='OU')
) x,
xla_ae_lines xal,
xla_ae_headers xah,
hr_all_organization_units_vl haouv,
hr_organization_information hoi,
gl_ledgers gl,
mtl_parameters mp
where
1=1 and
x.ae_header_id=xal.ae_header_id and
x.ae_line_num=xal.ae_line_num and
xal.application_id in (200,707) and
x.accrual_account_id=xal.code_combination_id and
xal.ae_header_id=xah.ae_header_id and
xal.application_id=xah.application_id and
x.operating_unit_id=haouv.organization_id and
haouv.organization_id=hoi.organization_id and
hoi.org_information_context='Operating Unit Information' and
to_number(hoi.org_information3)=gl.ledger_id and
xah.ledger_id=gl.ledger_id and
x.organization_id=mp.organization_id(+)
group by
gl.name,
haouv.name,
x.transaction_type_code,
mp.organization_code,
x.accrual_account_id,
gl.currency_code
) y,
gl_code_combinations_kfv gcck
where
y.accrual_account_id=gcck.code_combination_id
order by
y.ledger,
y.operating_unit,
match_type,
y.org_code,
accrual_account

/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC AP Accrual IR ISO Match Analysis
-- Description: Use this report to match the A/P Accrual entries for internal order inventory receipts with the internal order payables invoices, by the internal sale order and line number. If run in Detail Mode, shows inventory receipts and payables invoices on separate lines with detailed information, if run in Summary Mode, the sales order line is summarized into one row.
-- / +=============================================================================+
-- -- | Copyright 2016 - 2025 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged.09o warranties, express or otherwise is included in this permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 23 Nov 2016 Douglas Volz Initial Coding
-- -- | 1.1 15 Dec 2016 Douglas Volz Added Customer Name for A/P Invoice
-- -- | 1.2 20 Dec 2016 Douglas Volz Fixed calculation bug for Net Amount
-- -- | 1.3 10 Jan 2017 Douglas Volz Added Transaction Type Code 61 and Transaction
-- -- | Source Type 7 in order to report internal
-- -- | order receipts for txn type Int Req Intr Rcpt
-- -- | and corrected SIGN of net quantity.
-- -- | 1.4 17 Jan 2017 Douglas Volz Added Int Req Intr Rcpt to the Inventory Queries
-- -- | corrected the transaction type code for material
-- -- | transactions, truncated the transaction date
-- -- | and corrected the report sort by order number and
-- -- | transaction type (receipts first).
-- -- | 1.5 18 Jan 2017 Douglas Volz Added Vendor Name and Transaction Source.
-- -- | 1.6 19 Jan 2017 Douglas Volz Commented out the customer type indicator, was
-- -- | preventing A/P invoices from being reported.
-- -- | 1.7 09 Jun 2017 Douglas Volz Added new section to report Intransit Shipments
-- -- | for FOB Shipment with the order booked in one
-- -- | OU but shipped from another OU
-- -- | 1.8 11 Jun 2017 Douglas Volz Added Transaction Date and Operating Unit
-- -- | Parameters. Added new section 5 for Payables
-- -- | invoices which are unmatched to POs or for IR/ISOs.
-- -- | 1.9 26 Feb 2025 Douglas Volz Removed tabs, cleaned up for Blitz Report.
-- -- | 1.10 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-ap-accrual-ir-iso-match-analysis/
-- Library Link: https://www.enginatics.com/reports/cac-ap-accrual-ir-iso-match-analysis/
-- Run Report: https://demo.enginatics.com/

select
:p_report_mode report_mode,
&p_det_col1
haouv.name operating_unit,
&p_det_col2
xah.period_name,
gcck.concatenated_segments accounts,
&segment_columns
x.order_number iso_number,
x.line_number iso_line_num,
&p_det_col3
aps.vendor_name supplier,
&p_det_col4
msiv.concatenated_segments item_number,
msiv.description item_description,
&category_columns
&p_det_col5
sum(x.receipt_quantity) receipt_quantity,
sum(x.invoice_quantity) invoice_quantity,
sum(x.receipt_quantity+x.invoice_quantity) net_quantity,
sum(x.receipt_amount) receipt_amount,
sum(x.invoice_amount) invoice_amount,
sum(x.receipt_amount+x.invoice_amount) net_amount
from
(
select
cmr.operating_unit_id,
cmr.inventory_organization_id,
cmr.ae_header_id,
cmr.ae_line_num,
ooha.order_number,
oola.line_number,
'INV' transaction_source,
cmr.transaction_date,
mtt.transaction_type_name transaction_type,
cmr.inventory_item_id,
cmr.inventory_transaction_id,
null ap_invoice_num,
to_number(null) ap_invoice_line,
null party_name,
null party_number,
cmr.vendor_id,
-nvl(cmr.quantity,0) receipt_quantity,
0 invoice_quantity,
nvl(cmr.amount,0) receipt_amount,
0 invoice_amount
from
cst_misc_reconciliation cmr,
mtl_material_transactions mmt,
mtl_transaction_types mtt,
oe_order_lines_all oola,
oe_order_headers_all ooha
where
2=2 and
cmr.transaction_type_code in ('10','13') and
cmr.inventory_transaction_id=mmt.transaction_id and
cmr.inventory_item_id=mmt.inventory_item_id and
mmt.transaction_source_type_id=13 and
mmt.transaction_type_id=mtt.transaction_type_id and
mmt.trx_source_line_id=oola.line_id and
mmt.inventory_item_id=oola.inventory_item_id and
oola.order_source_id in (0,6) and
oola.line_category_code='ORDER' and
oola.header_id=ooha.header_id
union all
select
cmr.operating_unit_id,
cmr.inventory_organization_id,
cmr.ae_header_id,
cmr.ae_line_num,
ooha.order_number,
oola.line_number,
'INV' transaction_source,
cmr.transaction_date,
mtt.transaction_type_name transaction_type,
cmr.inventory_item_id,
cmr.inventory_transaction_id,
null ap_invoice_num,
to_number(null) ap_invoice_line,
null party_name,
null party_number,
cmr.vendor_id,
decode(cmr.transaction_type_code,'62',1,-1)*nvl(cmr.quantity,0) receipt_quantity,
0 invoice_quantity,
nvl(cmr.amount,0) receipt_amount,
0 invoice_amount
from
cst_misc_reconciliation cmr,
mtl_material_transactions mmt,
mtl_transaction_types mtt,
mtl_material_transactions mmt_ship,
oe_order_lines_all oola,
oe_order_headers_all ooha
where
2=2 and
cmr.transaction_type_code in ('61','62') and
cmr.inventory_transaction_id=mmt.transaction_id and
cmr.inventory_item_id=mmt.inventory_item_id and
mmt.transaction_source_type_id=decode(cmr.transaction_type_code,'61',7,8) and
mmt.transaction_type_id=mtt.transaction_type_id and
decode(cmr.transaction_type_code,'61',mmt.transfer_transaction_id,mmt.transaction_id)=mmt_ship.transaction_id and
mmt_ship.transaction_source_type_id=8 and
mmt_ship.trx_source_line_id=oola.line_id and
mmt_ship.inventory_item_id=oola.inventory_item_id and
oola.order_source_id=10 and
oola.line_category_code='ORDER' and
oola.header_id=ooha.header_id
union all
select
cmr.operating_unit_id,
rctla.warehouse_id inventory_organization_id,
cmr.ae_header_id,
cmr.ae_line_num,
to_number(rctla.sales_order) order_number,
to_number(rctla.interface_line_attribute2) line_number,
'A/P' transaction_source,
cmr.transaction_date,
cmr.transaction_type_code transaction_type,
rctla.inventory_item_id,
to_number(null) inventory_transaction_id,
aia.invoice_num ap_invoice_num,
aila.line_number ap_invoice_line,
hp.party_name,
hp.party_number,
cmr.vendor_id,
0 receipt_quantity,
nvl(rctla.quantity_invoiced,0) invoice_quantity,
0 receipt_amount,
nvl(cmr.amount,0) invoice_amount
from
cst_misc_reconciliation cmr,
ap_invoice_distributions_all aida,
ap_invoice_lines_all aila,
ap_invoices_all aia,
ra_customer_trx_lines_all rctla,
ra_customer_trx_all rcta,
hz_cust_accounts hca,
hz_parties hp
where
2=2 and
cmr.transaction_type_code='AP NO PO' and
cmr.invoice_distribution_id=aida.invoice_distribution_id and
aida.po_distribution_id is null and
aida.reference_1 is not null and
aida.reference_2 is not null and
aida.invoice_id=aila.invoice_id and
aida.invoice_line_number=aila.line_number and
aila.invoice_id=aia.invoice_id and
aila.source_line_id=rctla.customer_trx_line_id and
rctla.interface_line_context='INTERCOMPANY' and
rctla.customer_trx_id=rcta.customer_trx_id and
rcta.sold_to_customer_id=hca.cust_account_id and
hca.party_id=hp.party_id and
hp.party_type='ORGANIZATION'
union all
select
cmr.operating_unit_id,
fspa.inventory_organization_id,
cmr.ae_header_id,
cmr.ae_line_num,
to_number(null) order_number,
to_number(null) line_number,
'A/P' transaction_source,
cmr.transaction_date,
cmr.transaction_type_code transaction_type,
to_number(null) inventory_item_id,
to_number(null) inventory_transaction_id,
aia.invoice_num ap_invoice_num,
aila.line_number ap_invoice_line,
null party_name,
null party_number,
cmr.vendor_id,
0 receipt_quantity,
nvl(cmr.quantity,0) invoice_quantity,
0 receipt_amount,
nvl(cmr.amount,0) invoice_amount
from
cst_misc_reconciliation cmr,
ap_invoice_distributions_all aida,
ap_invoice_lines_all aila,
ap_invoices_all aia,
financials_system_params_all fspa
where
2=2 and
cmr.transaction_type_code='AP NO PO' and
cmr.invoice_distribution_id=aida.invoice_distribution_id and
aida.po_distribution_id is null and
aida.reference_1 is null and
aida.reference_2 is null and
aida.invoice_id=aila.invoice_id and
aida.invoice_line_number=aila.line_number and
aila.invoice_id=aia.invoice_id and
cmr.operating_unit_id=fspa.org_id
) x,
xla_ae_headers xah,
xla_ae_lines xal,
gl_ledgers gl,
gl_code_combinations_kfv gcck,
hr_all_organization_units_vl haouv,
mtl_parameters mp,
ap_suppliers aps,
mtl_system_items_vl msiv
where
1=1 and
x.operating_unit_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='OU') and
x.ae_header_id=xah.ae_header_id and
xah.ae_header_id=xal.ae_header_id and
xah.application_id=xal.application_id and
x.ae_line_num=xal.ae_line_num and
xah.ledger_id=gl.ledger_id and
xal.code_combination_id=gcck.code_combination_id and
x.operating_unit_id=haouv.organization_id and
x.inventory_organization_id=mp.organization_id and
x.vendor_id=aps.vendor_id(+) and
x.inventory_item_id=msiv.inventory_item_id(+) and
x.inventory_organization_id=msiv.organization_id(+)
group by
&p_det_grp1
haouv.name,
&p_det_grp2
xah.period_name,
gcck.concatenated_segments,
&segment_columns_grp
x.order_number,
x.line_number,
&p_det_grp3
aps.vendor_name,
&p_det_grp4
msiv.concatenated_segments,
msiv.description,
msiv.inventory_item_id,
msiv.organization_id
&p_det_grp5
order by
haouv.name,
xah.period_name,
gcck.concatenated_segments,
x.order_number,
x.line_number,
msiv.concatenated_segments

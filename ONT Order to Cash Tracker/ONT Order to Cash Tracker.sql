/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: ONT Order to Cash Tracker
-- Description: One row per sales order or quote line with the date of each step from quote to payment, and the accounting and GL posting of its invoice.
-- Invoice columns are those of the first invoice raised for the line; Invoiced Amount sums all its invoice lines. Amount Due Remaining is shown on the invoice's first order line only, so it can be summed. Paid Date is the date the invoice's last installment closed, Receipt Number the latest receipt applied to it.
-- Accounted Date is when final accounting was created for the invoice, GL Posted Date when its journal was posted.
-- Excel Example Output: https://www.enginatics.com/example/ont-order-to-cash-tracker/
-- Library Link: https://www.enginatics.com/reports/ont-order-to-cash-tracker/
-- Run Report: https://demo.enginatics.com/

select
x.operating_unit,
x.customer,
x.account_number,
x.phase,
x.order_type,
x.quote_number,
x.quote_date,
x.quote_expiration_date,
x.order_number,
x.order_date,
x.booked_date,
x.order_status,
x.line_number,
x.item,
x.item_description,
x.quantity,
x.uom,
x.unit_selling_price,
x.line_amount,
x.currency,
x.line_status,
x.hold_name,
x.hold_date,
x.request_date,
x.schedule_ship_date,
x.ship_date,
x.shipped_quantity,
rcta.trx_number invoice_number,
rcta.trx_date invoice_date,
x.invoiced_amount,
(select min(apsa.due_date) from ar_payment_schedules_all apsa where rcta.customer_trx_id=apsa.customer_trx_id) due_date,
case when row_number() over (partition by x.customer_trx_id order by x.header_id, x.line_id)=1 then (select sum(apsa.amount_due_remaining) from ar_payment_schedules_all apsa where rcta.customer_trx_id=apsa.customer_trx_id) end amount_due_remaining,
(select max(apsa.actual_date_closed) from ar_payment_schedules_all apsa where rcta.customer_trx_id=apsa.customer_trx_id having min(apsa.status)='CL') paid_date,
(
select
max(acra.receipt_number) keep (dense_rank last order by araa.apply_date, araa.receivable_application_id)
from
ar_receivable_applications_all araa,
ar_cash_receipts_all acra
where
rcta.customer_trx_id=araa.applied_customer_trx_id and
araa.status='APP' and
araa.display='Y' and
araa.cash_receipt_id=acra.cash_receipt_id
) receipt_number,
(
select
max(xah.creation_date)
from
xla.xla_transaction_entities xte,
xla_ae_headers xah
where
rcta.set_of_books_id=xte.ledger_id and
xte.application_id=222 and
xte.entity_code='TRANSACTIONS' and
nvl(xte.source_id_int_1,-99)=rcta.customer_trx_id and
xte.entity_id=xah.entity_id and
xte.application_id=xah.application_id and
xah.accounting_entry_status_code='F'
) accounted_date,
(
select
max(gjh.posted_date)
from
xla.xla_transaction_entities xte,
xla_ae_headers xah,
xla_ae_lines xal,
gl_import_references gir,
gl_je_headers gjh
where
rcta.set_of_books_id=xte.ledger_id and
xte.application_id=222 and
xte.entity_code='TRANSACTIONS' and
nvl(xte.source_id_int_1,-99)=rcta.customer_trx_id and
xte.entity_id=xah.entity_id and
xte.application_id=xah.application_id and
xah.accounting_entry_status_code='F' and
xah.gl_transfer_status_code='Y' and
xah.ae_header_id=xal.ae_header_id and
xah.application_id=xal.application_id and
xal.gl_sl_link_id=gir.gl_sl_link_id and
xal.gl_sl_link_table=gir.gl_sl_link_table and
gir.je_header_id=gjh.je_header_id and
gjh.status='P'
) gl_posted_date,
x.salesperson
from
(
select
haouv.name operating_unit,
hp.party_name customer,
hca.account_number,
xxen_util.meaning(nvl(ooha.transaction_phase_code,'F'),'TRANSACTION_PHASE',660) phase,
ottt.name order_type,
case when ooha.quote_number is not null then to_char(ooha.quote_number) when ooha.source_document_type_id=16 then regexp_substr(ooha.orig_sys_document_ref,'^(\d+).',1,1,null,1) end quote_number,
ooha.quote_date,
ooha.expiration_date quote_expiration_date,
case when nvl(ooha.transaction_phase_code,'F')='F' then ooha.order_number end order_number,
case when nvl(ooha.transaction_phase_code,'F')='F' then ooha.ordered_date end order_date,
ooha.booked_date,
xxen_util.meaning(ooha.flow_status_code,'FLOW_STATUS',660) order_status,
oola.line_number||'.'||oola.shipment_number||case when oola.option_number is not null then '.'||oola.option_number end line_number,
oola.ordered_item item,
msiv.description item_description,
oola.ordered_quantity quantity,
oola.order_quantity_uom uom,
oola.unit_selling_price,
oola.ordered_quantity*oola.unit_selling_price line_amount,
ooha.transactional_curr_code currency,
xxen_util.meaning(oola.flow_status_code,'LINE_FLOW_STATUS',660) line_status,
(
select
listagg(ohd.name,', ') within group (order by ohd.name)
from
oe_order_holds_all ooha_h,
oe_hold_sources_all ohsa,
oe_hold_definitions ohd
where
ooha.header_id=ooha_h.header_id and
(ooha_h.line_id is null or ooha_h.line_id=oola.line_id) and
ooha_h.released_flag='N' and
ooha_h.hold_source_id=ohsa.hold_source_id and
ohsa.hold_id=ohd.hold_id
) hold_name,
(
select
min(ooha_h.creation_date)
from
oe_order_holds_all ooha_h
where
ooha.header_id=ooha_h.header_id and
(ooha_h.line_id is null or ooha_h.line_id=oola.line_id) and
ooha_h.released_flag='N'
) hold_date,
oola.request_date,
oola.schedule_ship_date,
oola.actual_shipment_date ship_date,
oola.shipped_quantity,
(
select
min(rctla.customer_trx_id)
from
ra_customer_trx_lines_all rctla
where
rctla.interface_line_context in ('ORDER ENTRY','INTERCOMPANY') and
to_char(oola.line_id)=rctla.interface_line_attribute6 and
rctla.line_type='LINE'
) customer_trx_id,
(
select
sum(rctla.extended_amount)
from
ra_customer_trx_lines_all rctla
where
rctla.interface_line_context in ('ORDER ENTRY','INTERCOMPANY') and
to_char(oola.line_id)=rctla.interface_line_attribute6 and
rctla.line_type='LINE'
) invoiced_amount,
jrrev.resource_name salesperson,
ooha.header_id,
oola.line_id
from
hr_all_organization_units_vl haouv,
oe_order_headers_all ooha,
oe_order_lines_all oola,
hz_cust_accounts hca,
hz_parties hp,
oe_transaction_types_tl ottt,
mtl_system_items_vl msiv,
jtf_rs_salesreps jrs,
jtf_rs_resource_extns_vl jrrev
where
1=1 and
ooha.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
haouv.organization_id=ooha.org_id and
ooha.header_id=oola.header_id and
ooha.sold_to_org_id=hca.cust_account_id and
hca.party_id=hp.party_id and
ooha.order_type_id=ottt.transaction_type_id and
ottt.language=userenv('lang') and
oola.inventory_item_id=msiv.inventory_item_id(+) and
oola.ship_from_org_id=msiv.organization_id(+) and
nvl(oola.salesrep_id,ooha.salesrep_id)=jrs.salesrep_id(+) and
ooha.org_id=jrs.org_id(+) and
jrs.resource_id=jrrev.resource_id(+)
) x,
ra_customer_trx_all rcta
where
x.customer_trx_id=rcta.customer_trx_id(+)
order by
x.operating_unit,
x.order_number,
x.quote_number,
x.line_id

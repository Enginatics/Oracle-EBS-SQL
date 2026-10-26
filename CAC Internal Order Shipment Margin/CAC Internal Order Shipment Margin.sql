/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Internal Order Shipment Margin
-- Description: Report to display the internal sales orders/requisition shipments with COGS, margin, inter-company profit and other useful information. This report separately gets the COGS and revenue entries for the entered date range. If the COGS information is not reported the sales order line was not shipped in the entered date range. If the revenue nformation is not reported the sales order line was not billed in the entered date range.
-- / +=============================================================================+
-- -- | Copyright 2010 - 2020 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Parameters:
-- -- | pfromorgledger -- general ledger you wish to report, for the From Organization, optional
-- -- | ptoorgledger -- general ledger you wish to report, for the To Organization, optional
-- -- | pfromorgcode -- the source or from inventory organization you wish to report, optional
-- -- | ptrxdatefrom -- starting transaction date for internal shipment transactions, mandatory
-- -- | ptrxdateto -- ending transaction date for internal shipment transactions, mandatory
-- -- | ppiicosttype -- the profit in inventory costs you wish to report
-- -- | ppiiresourcecode -- the sub-element or resource for profit in inventory,
-- -- | such as PII or ICP
-- -- | pcurrconvdate -- currency conversion date
-- -- | pstdcostcurrconvtype -- currency conversion type used to set your standard costs and
-- -- | transfer prices
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== =========================================
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 12 Nov 2009 Douglas Volz Initial Coding based on XXXIROCOGS.sql
-- -- | 1.27 25 May 2020 Douglas Volz Changed to multi-language views for organizations, operating units,
-- -- | categories and units of measure. Remove RA Batches code logic.
-- -- | Remove sections for custom IR/ISO transactions.
-- -- | 1.28 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- -- ========================================================
-- -- Program Outline
-- -- ========================================================
-- -- Section I: Output the Report Columns for the Internal Shipment Entries
-- -- Section II: Get the currency conversion rates, based on the currency conversion
-- -- type and currency conversion date parameters
-- -- Section III: Condense the 2 union all statements into one line
-- -- for each Transaction Id. Also get the PII item costs.
-- -- Section IV: Get the material, payables and revenue transactions
-- -- which represent the Internal Order activity.
-- -- Assume IR/ISO shipments may or may not use custom billing
-- -- Section IV has 2 union all reports as follows:
-- -- Report 1: Get IR/ISO COGS and Sales for Intransit Shipments
-- -- where title passes upon shipment (FOB = 1, Shipment)
-- -- Report 2: Get IR/ISO COGS and Sales for IR/ISO Intransit Receipts
-- -- where title passes upon receipt (FOBPoint = 2, Receipt)
-- Excel Example Output: https://www.enginatics.com/example/cac-internal-order-shipment-margin/
-- Library Link: https://www.enginatics.com/reports/cac-internal-order-shipment-margin/
-- Run Report: https://demo.enginatics.com/

select
y.from_ledger,
y.from_operating_unit,
y.to_ledger,
y.to_operating_unit,
y.ship_from_org,
y.ship_to_org,
y.item_number,
y.item_description,
y.item_type,
&category_columns
y.customer,
y.customer_number,
y.sales_order_number,
y.sales_order_line,
y.order_type,
y.ar_invoice_number,
y.ar_line_number,
y.requisition_number,
y.price_list,
y.transaction_type,
y.transaction_number,
y.ship_date,
y.lot_number,
y.from_org_txn_cost,
y.from_org_unit_price,
y.uom_code,
y.ship_quantity,
y.invoice_quantity,
y.ship_quantity-y.invoice_quantity quantity_diff,
y.from_curr_code,
y.from_org_cogs_amount,
y.from_org_sales_amount,
y.from_org_cogs_amount-y.from_org_sales_amount from_org_margin_amount,
case
when y.from_org_unit_price=0 and y.from_org_txn_cost=0 then 0
when y.from_org_unit_price=0 and y.from_org_txn_cost<>0 then 100
else round((y.from_org_txn_cost-y.from_org_unit_price)/y.from_org_unit_price,3)*100
end from_org_margin_percent,
y.from_org_txn_cost-y.from_org_unit_price from_org_unit_margin,
y.from_org_pii_item_cost,
y.from_org_txn_cost-y.from_org_unit_price+y.from_org_pii_item_cost from_org_net_unit_margin,
y.from_org_cogs_amount-y.from_org_sales_amount+round(y.from_org_pii_item_cost*y.ship_quantity,2) from_org_net_margin_amount,
y.to_org_curr_code,
:conversion_date curr_conv_date,
round(y.curr_conv_rate,6) curr_conv_rate,
round((y.from_org_cogs_amount-y.from_org_sales_amount+round(y.from_org_pii_item_cost*y.ship_quantity,2))*y.curr_conv_rate,2) conv_net_margin_amount,
y.to_org_pii_item_cost,
round(y.ship_quantity*y.to_org_pii_item_cost,2) to_org_pii_amount,
round((y.from_org_cogs_amount-y.from_org_sales_amount+round(y.from_org_pii_item_cost*y.ship_quantity,2))*y.curr_conv_rate,2)+round(y.ship_quantity*y.to_org_pii_item_cost,2) conv_net_margin_less_pii
from
(
select
nvl(gl_from.short_name,gl_from.name) from_ledger,
haouv_from.name from_operating_unit,
nvl(gl_to.short_name,gl_to.name) to_ledger,
haouv_to.name to_operating_unit,
mp_from.organization_code ship_from_org,
mp_to.organization_code ship_to_org,
msiv.concatenated_segments item_number,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
hp.party_name customer,
hca.account_number customer_number,
ooha.order_number sales_order_number,
oola.line_number sales_order_line,
ottt.name order_type,
(select rcta.trx_number from ra_customer_trx_all rcta where x.ar_invoice_id=rcta.customer_trx_id) ar_invoice_number,
x.ar_invoice_line_number ar_line_number,
prha.segment1 requisition_number,
(select qlht.name from qp_list_headers_tl qlht where ooha.price_list_id=qlht.list_header_id and qlht.language=userenv('lang')) price_list,
mtt.transaction_type_name transaction_type,
x.transaction_id transaction_number,
x.transaction_date ship_date,
x.lot_number,
x.transaction_cost from_org_txn_cost,
x.unit_price from_org_unit_price,
msiv.primary_uom_code uom_code,
x.primary_quantity ship_quantity,
x.quantity_invoiced invoice_quantity,
gl_from.currency_code from_curr_code,
x.cogs_amount from_org_cogs_amount,
x.revenue_amount from_org_sales_amount,
nvl((select /*+ no_unnest*/ sum(cicd.item_cost) from cst_item_cost_details cicd, cst_cost_types cct, bom_resources br where oola.inventory_item_id=cicd.inventory_item_id and oola.ship_from_org_id=cicd.organization_id and cicd.cost_type_id=cct.cost_type_id and cicd.resource_id=br.resource_id and 5=5 and 6=6),0) from_org_pii_item_cost,
gl_to.currency_code to_org_curr_code,
decode(gl_from.currency_code,gl_to.currency_code,1,(select gdr.conversion_rate from gl_daily_rates gdr, gl_daily_conversion_types gdct where gl_from.currency_code=gdr.from_currency and gl_to.currency_code=gdr.to_currency and gdr.conversion_date=:conversion_date and gdr.conversion_type=gdct.conversion_type and gdct.user_conversion_type=:user_conversion_type)) curr_conv_rate,
nvl((select /*+ no_unnest*/ sum(cicd.item_cost) from cst_item_cost_details cicd, cst_cost_types cct, bom_resources br where oola.inventory_item_id=cicd.inventory_item_id and prla.destination_organization_id=cicd.organization_id and cicd.cost_type_id=cct.cost_type_id and cicd.resource_id=br.resource_id and 5=5 and 6=6),0) to_org_pii_item_cost,
oola.inventory_item_id,
oola.ship_from_org_id
from
(
select
t.so_line_id,
t.ship_transaction_id,
t.lot_number,
max(t.transaction_id) keep (dense_rank first order by t.section) transaction_id,
max(t.transaction_type_id) keep (dense_rank first order by t.section) transaction_type_id,
max(t.transaction_date) keep (dense_rank first order by t.section) transaction_date,
round(max(t.transaction_cost),5) transaction_cost,
round(sum(t.primary_quantity),3) primary_quantity,
round(sum(t.cogs_amount),2) cogs_amount,
max(t.ar_invoice_id) ar_invoice_id,
max(t.ar_invoice_line_number) ar_invoice_line_number,
round(nvl(max(t.unit_price),0),5) unit_price,
round(sum(t.quantity_invoiced),3) quantity_invoiced,
round(sum(t.revenue_amount),3) revenue_amount
from
(
select
1 section,
mmt.trx_source_line_id so_line_id,
mmt.transaction_id ship_transaction_id,
mtln.lot_number,
mmt.transaction_id,
mmt.transaction_type_id,
mmt.transaction_date,
mmt.actual_cost transaction_cost,
-nvl(mtln.primary_quantity,mmt.primary_quantity) primary_quantity,
round(-nvl(mtln.primary_quantity,mmt.primary_quantity)*nvl(mmt.actual_cost,0),2) cogs_amount,
to_number(null) ar_invoice_id,
to_number(null) ar_invoice_line_number,
to_number(null) unit_price,
0 quantity_invoiced,
0 revenue_amount
from
mtl_material_transactions mmt,
mtl_transaction_lot_numbers mtln,
oe_order_lines_all oola
where
7=7 and
mmt.transaction_action_id=21 and
mmt.fob_point=1 and
mmt.transaction_id=mtln.transaction_id(+) and
mmt.trx_source_line_id=oola.line_id and
oola.order_source_id=10 and
oola.line_category_code='ORDER'
union all
select
2 section,
mmt_ship.trx_source_line_id so_line_id,
mmt_ship.transaction_id ship_transaction_id,
mtln.lot_number,
mmt.transaction_id,
mmt.transaction_type_id,
mmt.transaction_date,
mmt_ship.actual_cost transaction_cost,
decode(mmt.transaction_type_id,95,-1,1)*nvl(mtln.primary_quantity,mmt.primary_quantity) primary_quantity,
round(decode(mmt.transaction_type_id,95,-1,1)*nvl(mtln.primary_quantity,mmt.primary_quantity)*nvl(mmt_ship.actual_cost,0),5) cogs_amount,
to_number(null) ar_invoice_id,
to_number(null) ar_invoice_line_number,
to_number(null) unit_price,
0 quantity_invoiced,
0 revenue_amount
from
mtl_material_transactions mmt,
mtl_material_transactions mmt_ship,
mtl_transaction_lot_numbers mtln,
oe_order_lines_all oola
where
7=7 and
mmt.transaction_source_type_id=7 and
mmt.fob_point=2 and
mmt.transfer_transaction_id=mmt_ship.transaction_id and
mmt_ship.transaction_source_type_id=8 and
mmt.transaction_id=mtln.transaction_id(+) and
mmt_ship.trx_source_line_id=oola.line_id and
oola.order_source_id=10 and
oola.line_category_code='ORDER'
union all
select
3 section,
oola.line_id so_line_id,
mmt.transaction_id ship_transaction_id,
(select max(mtln.lot_number) from mtl_transaction_lot_numbers mtln where mmt.transaction_id=mtln.transaction_id) lot_number,
mmt.transaction_id,
mmt.transaction_type_id,
mmt.transaction_date,
0 transaction_cost,
0 primary_quantity,
0 cogs_amount,
rcta.customer_trx_id ar_invoice_id,
rctla.line_number ar_invoice_line_number,
rctla.unit_selling_price*nvl(rcta.exchange_rate,1) unit_price,
nvl(rctla.quantity_invoiced,0)*mucv.conversion_rate quantity_invoiced,
nvl(rctla.revenue_amount,0)*nvl(rcta.exchange_rate,1) revenue_amount
from
ra_customer_trx_lines_all rctla,
ra_customer_trx_all rcta,
oe_order_lines_all oola,
mtl_material_transactions mmt,
mtl_uom_conversions_view mucv
where
rctla.interface_line_context='INTERCOMPANY' and
rctla.line_type='LINE' and
rctla.customer_trx_line_id in (select rctlgda.customer_trx_line_id from ra_cust_trx_line_gl_dist_all rctlgda where 10=10 and rctlgda.account_class='REV' and rctlgda.account_set_flag='N') and
rctla.customer_trx_id=rcta.customer_trx_id and
rcta.complete_flag='Y' and
to_number(rctla.interface_line_attribute6)=oola.line_id and
rcta.org_id=oola.org_id and
oola.line_category_code in ('ORDER','RETURN') and
oola.line_id=nvl(oola.top_model_line_id,oola.line_id) and
to_number(rctla.interface_line_attribute7)=mmt.transaction_id and
oola.ship_from_org_id=mucv.organization_id and
oola.inventory_item_id=mucv.inventory_item_id and
rctla.uom_code=mucv.uom_code
) t
group by
t.so_line_id,
t.ship_transaction_id,
t.lot_number
) x,
oe_order_lines_all oola,
oe_order_headers_all ooha,
oe_transaction_types_tl ottt,
po_requisition_lines_all prla,
po_requisition_headers_all prha,
hz_cust_accounts hca,
hz_parties hp,
mtl_system_items_vl msiv,
mtl_transaction_types mtt,
mtl_parameters mp_from,
hr_organization_information hoi_from,
hr_all_organization_units_vl haouv_from,
gl_ledgers gl_from,
mtl_parameters mp_to,
hr_organization_information hoi_to,
hr_all_organization_units_vl haouv_to,
gl_ledgers gl_to
where
8=8 and
9=9 and
x.so_line_id=oola.line_id and
oola.header_id=ooha.header_id and
oola.line_type_id=ottt.transaction_type_id and
ottt.language=userenv('lang') and
oola.source_document_line_id=prla.requisition_line_id and
prla.requisition_header_id=prha.requisition_header_id and
prha.type_lookup_code='INTERNAL' and
ooha.source_document_id=prha.requisition_header_id and
oola.sold_to_org_id=hca.cust_account_id and
hca.party_id=hp.party_id and
oola.ship_from_org_id=msiv.organization_id and
oola.inventory_item_id=msiv.inventory_item_id and
x.transaction_type_id=mtt.transaction_type_id and
oola.ship_from_org_id=mp_from.organization_id and
mp_from.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp_from.organization_id=hoi_from.organization_id and
hoi_from.org_information_context='Accounting Information' and
to_number(hoi_from.org_information3)=haouv_from.organization_id and
to_number(hoi_from.org_information1)=gl_from.ledger_id and
prla.destination_organization_id=mp_to.organization_id and
mp_to.organization_id=hoi_to.organization_id and
hoi_to.org_information_context='Accounting Information' and
to_number(hoi_to.org_information3)=haouv_to.organization_id and
to_number(hoi_to.org_information1)=gl_to.ledger_id and
haouv_from.organization_id<>haouv_to.organization_id
) y
order by
y.from_ledger,
y.from_operating_unit,
y.to_ledger,
y.to_operating_unit,
y.ship_from_org,
y.ship_to_org,
y.item_number

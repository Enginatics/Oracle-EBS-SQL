/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST COGS Revenue Matching
-- Description: Imported from Concurrent Program
Application: Bills of Material
Source: COGS Revenue Matching Report
Short Name: CSTRCMRX

The COGS/Revenue Matching Report displays earned and unearned (deferred) revenue, and cost of goods sold amounts for sales orders issues specified in the report's run-time parameters.
The report displays shipped sales order and associated sales order lines and shows the accounts where the earned and deferred COGS were charged.

The report is based on the Revenue and COGS Matching functionality delivered in Oracle EBS R12. Please refer to the following documentation regarding this functionality:
- Oracle Cost Management User Guide, Section: Revenue and COGS Matching
- MOS Document 1060202.1 Understanding COGS and DCOGS Recognition Accounting

Revenue / COGS Recognition Process Flow
=======================================
When you ship confirm one or more order lines in Oracle Order Management and then run the applicable Cost Management cost and accounting processes, the cost of goods sold associated with the sales order line is immediately debited to a Deferred COGS account pending the invoicing and recognition of the sales order revenue in Oracle Receivables.

When Oracle Receivables recognizes all or part of the sales revenue associated with a sales order line, you run a cost process that calculates the percentage of total billed revenue recognized. Oracle Inventory then creates a cost recognition transaction that adjusts the Deferred COGS and regular COGS amount for the order line. The proportion of total shipment cost that is recognized as COGS will always match the proportion of total billable quantity that is recognized as revenue.

Revenue / COGS Recognition Concurrent Processes
================================================
It is recommended the Revenue and COGS concurrent processes be run in the following order:

Run the AR Concurrent Processes first:

- Autoinvoice Master Program.  Run autoinvoice to generate the invoice transactions.
- Revenue Recognition. Run the Revenue Recognition Master Program to generate the AR revenue recognition

Then the COGS Concurrent Processes:

- Record Order Management Transactions
 The Record Order Management Transactions concurrent process picks up and costs all uncosted sales order issue and RMA return transactions and creates a record for each new order line in the costing COGS recognition matching table. This process is not for Perpetual Discrete Costing (Standard, Average, FIFO). In Discrete Costing, the cost processor selects and costs the uncosted sales order issues and inserts them into the COGS matching table

- Collect Revenue Recognition Information
 The Collect Revenue Recognition Information concurrent process calls an Oracle Receivables API to retrieve the latest revenue recognition percentage of all invoiced sales order lines in Oracle receivables for a specific ledger and with activity dates within a user-specified date range. This process must be run before the Generate COGS recognition Event concurrent process.

- Generate COGS Recognition Events
 The Generate COGS Recognition Events concurrent request compares the COGS recognition percentage for each sales order line and accounting period combination to the current earned revenue percentage. When the compared percentages are different, the process raises a COGS recognition event and creates a COGS recognition transaction in Oracle Inventory that adjusts the ratio of earned and deferred COGS to match that of earned and deferred revenue. You must run this process after completion of the Collect Revenue Recognition Information concurrent process.

-- Excel Examle Output: https://www.enginatics.com/example/cst-cogs-revenue-matching/
-- Library Link: https://www.enginatics.com/reports/cst-cogs-revenue-matching/
-- Run Report: https://demo.enginatics.com/

with
perpetual_qry_1 as
(
  select
  x.*
  from
  (
    select
    crcml.operating_unit_id,
    haou.name operating_unit,
    gl.name ledger,
    gl.currency_code currency,
    ooha.order_number,
    ooha.booked_date,
    ooha.transactional_curr_code,
    oola.line_number,
    oola.sold_to_org_id,
    oola.item_type_code,
    oola.order_quantity_uom uom,
    crcml.sales_order_issue_date,
    crcml.revenue_om_line_id,
    crcml.organization_id,
    crcml.deferred_cogs_acct_id,
    crcml.cogs_om_line_id,
    crcml.inventory_item_id,
    crcml.unit_cost,
    crcml.unit_material_cost,
    crcml.unit_moh_cost,
    crcml.unit_op_cost,
    crcml.unit_resource_cost,
    crcml.unit_overhead_cost,
    sum(decode(mta.accounting_line_type, 35, mta.base_transaction_value,0)) cogs_balance,
    last_value(sum(decode(mta.accounting_line_type, 35, mta.base_transaction_value,0)))  -- CST_ACCOUNTING_LINE_TYPE 35 = Cost of Goods Sold
    over ( partition by
           crcml.operating_unit_id,
           haou.name,
           gl.name,
           gl.currency_code,
           ooha.order_number,
           ooha.booked_date,
           ooha.transactional_curr_code,
           oola.line_number,
           oola.sold_to_org_id,
           oola.item_type_code,
           oola.order_quantity_uom,
           crcml.sales_order_issue_date,
           crcml.revenue_om_line_id,
           crcml.organization_id,
           crcml.deferred_cogs_acct_id,
           crcml.cogs_om_line_id
           order by
           crcml.operating_unit_id,
           haou.name,
           gl.name,
           gl.currency_code,
           ooha.order_number,
           ooha.booked_date,
           ooha.transactional_curr_code,
           oola.line_number,
           oola.sold_to_org_id,
           oola.item_type_code,
           oola.order_quantity_uom,
           crcml.sales_order_issue_date,
           crcml.revenue_om_line_id,
           crcml.organization_id,
           crcml.deferred_cogs_acct_id,
           crcml.cogs_om_line_id
         ) total_cogs_balance,
    sum(decode(mta.accounting_line_type, 36, mta.base_transaction_value,0)) def_cogs_balance,
    last_value(sum(decode(mta.accounting_line_type, 36, mta.base_transaction_value,0))) -- CST_ACCOUNTING_LINE_TYPE 36 = Deferred Cost of Goods Sold
    over( partition by
          crcml.operating_unit_id,
          haou.name,
          gl.name,
          gl.currency_code,
          ooha.order_number,
          ooha.booked_date,
          ooha.transactional_curr_code,
          oola.line_number,
          oola.sold_to_org_id,
          oola.item_type_code,
          oola.order_quantity_uom,
          crcml.sales_order_issue_date,
          crcml.revenue_om_line_id,
          crcml.organization_id,
          crcml.deferred_cogs_acct_id,
          crcml.cogs_om_line_id
          order by
          crcml.operating_unit_id,
          haou.name,
          gl.name,
          gl.currency_code,
          ooha.order_number,
          ooha.booked_date,
          ooha.transactional_curr_code,
          oola.line_number,
          oola.sold_to_org_id,
          oola.item_type_code,
          oola.order_quantity_uom,
          crcml.sales_order_issue_date,
          crcml.revenue_om_line_id,
          crcml.organization_id,
          crcml.deferred_cogs_acct_id,
          crcml.cogs_om_line_id
        ) total_def_cogs_balance
    from
    cst_revenue_cogs_match_lines crcml,
    cst_cogs_events cce,
    oe_order_lines_all oola,
    oe_order_headers_all ooha,
    mtl_transaction_accounts mta,
    gl_ledgers gl,
    hr_all_organization_units haou
    where
    1=1 and
    crcml.ledger_id = :p_ledger_id and
    crcml.pac_cost_type_id is null and
    cce.event_date<=:p_gps_end_dt and
    cce.event_date>=:p_gps_start_dt and
    cce.cogs_om_line_id = crcml.cogs_om_line_id and
    gl.ledger_id = crcml.ledger_id and
    oola.header_id = ooha.header_id and
    oola.line_id = crcml.cogs_om_line_id and
    mta.transaction_id (+) = cce.mmt_transaction_id and
    haou.organization_id (+) = crcml.operating_unit_id
    group by
    crcml.operating_unit_id,
    haou.name,
    gl.name,
    gl.currency_code,
    ooha.order_number,
    ooha.booked_date,
    ooha.transactional_curr_code,
    oola.line_number,
    oola.sold_to_org_id,
    oola.item_type_code,
    oola.order_quantity_uom,
    crcml.sales_order_issue_date,
    crcml.revenue_om_line_id,
    crcml.organization_id,
    crcml.deferred_cogs_acct_id,
    crcml.cogs_om_line_id,
    crcml.inventory_item_id,
    crcml.unit_cost,
    crcml.unit_material_cost,
    crcml.unit_moh_cost,
    crcml.unit_op_cost,
    crcml.unit_resource_cost,
    crcml.unit_overhead_cost  
  ) x
),
perpetual_qry_2 as
(
  select
  pq1.operating_unit_id,
  pq1.operating_unit,
  pq1.ledger,
  pq1.currency ledger_currency,
  pq1.order_number order_number,
  pq1.booked_date order_date,
  substrb(hp.party_name,1,50) customer_name,
  pq1.transactional_curr_code order_currency,
  pq1.line_number sales_order_line,
  pq1.sales_order_issue_date,
  pq1.revenue_om_line_id sales_order_line_id,
  pq1.item_type_code item_type_code,
  msiv.concatenated_segments item,
  msiv.description item_description,
  xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
  msiv.inventory_item_id,
  mp.organization_code,
  mp.organization_id,
  rctla.line_number invoice_line,
  rctla.unit_selling_price,
  rctla.customer_trx_line_id,
  rctla.customer_trx_id,
  sum(cce.event_quantity) total_line_quantity,
  decode(sum(cce.event_quantity),0,0,sum(cce.event_quantity * crcml.unit_cost) / sum(cce.event_quantity))item_cost,
  decode(sum(cce.event_quantity),0,0,sum(cce.event_quantity * crcml.unit_material_cost) / sum(cce.event_quantity))material_cost,
  decode(sum(cce.event_quantity),0,0,sum(cce.event_quantity * crcml.unit_moh_cost) / sum(cce.event_quantity))material_oh_cost,
  decode(sum(cce.event_quantity),0,0,sum(cce.event_quantity * crcml.unit_op_cost) / sum(cce.event_quantity))osp_cost,
  decode(sum(cce.event_quantity),0,0,sum(cce.event_quantity * crcml.unit_resource_cost) / sum(cce.event_quantity))resource_cost,
  decode(sum(cce.event_quantity),0,0,sum(cce.event_quantity * crcml.unit_overhead_cost) / sum(cce.event_quantity))overhead_cost,
  pq1.uom,
  pq1.cogs_balance earned_cogs,
  pq1.total_cogs_balance total_earned_cogs,
  pq1.def_cogs_balance deferred_cogs,
  pq1.total_def_cogs_balance total_deferred_cogs,
  gcck_cogs.concatenated_segments cogs_account,
  gcck_dcogs.concatenated_segments deferred_cogs_account,
  pq1.cogs_om_line_id cogs_om_line_id,
  gcck_cogs.code_combination_id cogs_account_ccid,
  gcck_cogs.chart_of_accounts_id,
  cce.event_date gl_date
  from
  perpetual_qry_1 pq1,
  cst_revenue_cogs_match_lines crcml,
  mtl_system_items_vl msiv,
  mtl_parameters mp,
  gl_code_combinations_kfv gcck_cogs,
  gl_code_combinations_kfv gcck_dcogs,
  ra_customer_trx_lines_all rctla,
  hz_cust_accounts hca,
  hz_parties hp,
  cst_cogs_events cce
  where
  msiv.inventory_item_id = pq1.inventory_item_id and
  msiv.organization_id = pq1.organization_id and
  mp.organization_id = pq1.organization_id and
  gcck_cogs.code_combination_id = crcml.cogs_acct_id and
  gcck_dcogs.code_combination_id = pq1.deferred_cogs_acct_id and
  rctla.line_type (+) = 'LINE' and
  rctla.interface_line_context (+) = 'ORDER ENTRY' and
  rctla.interface_line_attribute6 (+) = to_char(pq1.revenue_om_line_id) and
  rctla.sales_order (+) = to_char(pq1.order_number) and
  pq1.sold_to_org_id = hca.cust_account_id (+)and
  hca.party_id = hp.party_id and
  cce.cogs_om_line_id = pq1.cogs_om_line_id and
  cce.event_type in (1,2) and
  cce.event_date<=:p_gps_end_dt and
  cce.event_date>=:p_gps_start_dt and
  crcml.cogs_om_line_id = pq1.cogs_om_line_id and
  crcml.pac_cost_type_id is null and
  ( :p_all_lines = 'Y' or pq1.def_cogs_balance not between -1*:p_amt_tolerance and :p_amt_tolerance)
  group by
  pq1.operating_unit_id,
  pq1.operating_unit,
  pq1.ledger,
  pq1.currency,
  pq1.order_number,
  pq1.booked_date,
  substrb(hp.party_name,1,50),
  pq1.transactional_curr_code,
  pq1.line_number,
  pq1.sales_order_issue_date,
  pq1.revenue_om_line_id,
  pq1.item_type_code,
  pq1.uom,
  msiv.concatenated_segments,
  msiv.description,
  msiv.item_type,
  msiv.inventory_item_id,
  mp.organization_code,
  mp.organization_id,
  rctla.line_number,
  rctla.unit_selling_price,
  rctla.customer_trx_line_id,
  rctla.customer_trx_id,
  pq1.cogs_balance,
  pq1.total_cogs_balance,
  pq1.def_cogs_balance,
  pq1.total_def_cogs_balance,
  gcck_cogs.concatenated_segments,
  gcck_dcogs.concatenated_segments,
  pq1.cogs_om_line_id,
  gcck_cogs.code_combination_id,
  gcck_cogs.chart_of_accounts_id,
  cce.event_date
),
perpetual_qry as
(
  select
  pq2.operating_unit_id,
  pq2.operating_unit,
  pq2.ledger,
  pq2.ledger_currency,
  pq2.order_number,
  pq2.order_date,
  pq2.customer_name,
  pq2.order_currency,
  pq2.sales_order_line,
  pq2.sales_order_issue_date,
  pq2.sales_order_line_id,
  pq2.item_type_code,
  pq2.item,
  pq2.item_description,
  pq2.user_item_type,
  pq2.inventory_item_id,
  pq2.organization_code,
  pq2.organization_id,
  pq2.invoice_line,
  pq2.unit_selling_price,
  pq2.customer_trx_line_id,
  pq2.customer_trx_id,
  pq2.total_line_quantity,
  pq2.item_cost,
  pq2.material_cost,
  pq2.material_oh_cost,
  pq2.osp_cost,
  pq2.resource_cost,
  pq2.overhead_cost,
  pq2.uom,
  pq2.earned_cogs,
  case when pq2.item_type_code = 'INCLUDED'
  then (select
        sum(pq2_1.earned_cogs)
        from
        perpetual_qry_2 pq2_1
        where
        pq2_1.operating_unit_id = pq2.operating_unit_id and
        pq2_1.order_number = pq2.order_number and
        pq2_1.sales_order_line = pq2.sales_order_line and
        pq2_1.sales_order_line_id = pq2.sales_order_line_id and
        pq2_1.item_type_code = 'INCLUDED' and
        pq2_1.customer_trx_line_id = pq2.customer_trx_line_id and
        pq2_1.customer_trx_id = pq2.customer_trx_id
       )
  else pq2.total_earned_cogs
  end total_earned_cogs,
  pq2.deferred_cogs,
  pq2.total_deferred_cogs,
  pq2.cogs_account,
  pq2.deferred_cogs_account,
  pq2.cogs_om_line_id,
  pq2.cogs_account_ccid,
  pq2.chart_of_accounts_id,
  pq2.gl_date
  from
  perpetual_qry_2 pq2
),
perpetual_lines_qry as
(
  select /*+ leading(pq,rctla) index(rctla ra_customer_trx_lines_n9)*/
  rctla.interface_line_attribute1,
  rctla.interface_line_attribute6,
  rcta.trx_number,
  rctla.line_number,
  rctla.customer_trx_id,
  row_number() over (partition by rctla.sales_order,rctla.interface_line_attribute6,rctla.interface_line_context,rctla.line_type order by rctla.customer_trx_id) rctla_rank
  from
  ra_customer_trx_lines_all rctla,
  ra_customer_trx_all rcta,
  perpetual_qry pq
  where
  rctla.interface_line_context='ORDER ENTRY' and
  rctla.line_type ='LINE' and
  rctla.customer_trx_id = rcta.customer_trx_id and
  rctla.sales_order = to_char(pq.order_number) and
  rctla.interface_line_attribute6 = to_char(pq.sales_order_line_id)
)
--
-- Main Query Starts Here
--
select
x.ledger,
x.operating_unit,
x.order_number,
x.order_date,
x.customer,
x.order_currency,
x.order_line,
x.order_quantity,
x.uom,
x.sales_order_issue_date,
x.invoice_number,
x.quantity_invoiced,
x.invoice_line,
x.item,
x.item_description,
&category_columns
x.user_item_type,
x.organization_code,
(select mp.organization_code from mtl_parameters mp,oe_order_lines_all oola where oola.line_id=x.cogs_om_line_id and oola.ship_from_org_id=mp.organization_id)ship_from_warehouse,
x.ledger_currency,
:p_period_name period,
x.unit_selling_price,
x.item_cost,
x.material_cost,
x.material_oh_cost,
x.osp_cost,
x.resource_cost,
x.overhead_cost,
&lp_cost_type_col
x.earned_revenue,
x.unearned_revenue,
x.unbilled_revenue,
case when x.earned_revenue is not null and x.unearned_revenue is not null and x.unbilled_revenue is not null
then x.earned_revenue + x.unearned_revenue + x.unbilled_revenue
end total_revenue,
case when x.earned_revenue is not null and x.unearned_revenue is not null and x.unbilled_revenue is not null
then case when x.earned_revenue + x.unearned_revenue + x.unbilled_revenue = 0
     then 100
     else x.earned_revenue/(x.earned_revenue + x.unearned_revenue + x.unbilled_revenue)*100
     end
end revenue_percent,
x.earned_cogs,
x.deferred_cogs,
x.earned_cogs+x.deferred_cogs total_cogs,
(select actual_shipment_date from oe_order_lines_all where line_id = x.sales_order_line_id) so_line_closed_date,
x.gl_date,
case when x.earned_cogs is not null and x.deferred_cogs is not null
then case when x.earned_cogs + x.deferred_cogs = 0
     then 100
     else x.earned_cogs/(x.earned_cogs + x.deferred_cogs)*100
     end
end cogs_percent,
x.cogs_account,
x.deferred_cogs_account,
case when x.revenue_ccid is not null then fnd_flex_xml_publisher_apis.process_kff_combination_1('seg','SQLGL','GL#',x.chart_of_accounts_id,NULL,x.revenue_ccid,'ALL','Y','VALUE') end revenue_account_segments,
case when x.unearn_ccid is not null then fnd_flex_xml_publisher_apis.process_kff_combination_1('seg','SQLGL','GL#',x.chart_of_accounts_id,NULL,x.unearn_ccid,'ALL','Y','VALUE') end unearned_account_segments,
case when x.unbill_ccid is not null then fnd_flex_xml_publisher_apis.process_kff_combination_1('seg','SQLGL','GL#',x.chart_of_accounts_id,NULL,x.unbill_ccid,'ALL','Y','VALUE') end unbilled_account_segments,
&lp_cogs_account_segments
&lp_rev_account_segments
x.cogs_om_line_id
from
(
select
pq.ledger,
pq.ledger_currency,
pq.operating_unit,
pq.order_number,
pq.order_date,
pq.customer_name customer,
pq.order_currency,
pq.sales_order_line order_line,
decode(rcta.trx_number,min(plq.trx_number),decode(pq.invoice_line,min(plq.min_inv_line),pq.total_line_quantity)) order_quantity,
pq.uom,
pq.sales_order_issue_date,
rcta.trx_number invoice_number,
rctla.quantity_invoiced,
pq.invoice_line,
pq.unit_selling_price,
pq.item_cost,
pq.material_cost,
pq.material_oh_cost,
pq.osp_cost,
pq.resource_cost,
pq.overhead_cost,
pq.item,
pq.item_description,
pq.user_item_type,
pq.inventory_item_id,
pq.organization_code,
pq.organization_id,
round(sum(decode(axclv.account_class,'UNEARN',0,'UNBILL',0, axclv.acctd_amount))*decode(pq.earned_cogs, pq.total_earned_cogs,1,pq.earned_cogs/decode(pq.total_earned_cogs,0,1,pq.total_earned_cogs)),2) earned_revenue,
round(sum(decode(axclv.account_class,'REV',   0,'UNBILL',0, axclv.acctd_amount))*decode(pq.deferred_cogs, pq.total_deferred_cogs,1,pq.deferred_cogs/decode(pq.total_deferred_cogs,0,1,pq.total_deferred_cogs)),2) unearned_revenue,
round(sum(decode(axclv.account_class,'REV',   0,'UNEARN',0, axclv.acctd_amount))*decode(pq.deferred_cogs, pq.total_deferred_cogs,1,pq.deferred_cogs/decode(pq.total_deferred_cogs,0,1,pq.total_deferred_cogs)),2) unbilled_revenue,
decode(rcta.trx_number,min(plq.trx_number),decode(pq.invoice_line,min(plq.min_inv_line),pq.earned_cogs)) earned_cogs,
decode(rcta.trx_number,min(plq.trx_number),decode(pq.invoice_line,min(plq.min_inv_line),pq.deferred_cogs)) deferred_cogs,
pq.cogs_account,
pq.deferred_cogs_account,
min(decode(axclv.account_class,'REV',axclv.code_combination_id)) revenue_ccid,
min(decode(axclv.account_class,'UNEARN',axclv.code_combination_id)) unearn_ccid,
min(decode(axclv.account_class,'UNBILL',axclv.code_combination_id)) unbill_ccid,
plq.interface_line_attribute6,
pq.sales_order_line_id,
pq.cogs_om_line_id,
pq.cogs_account_ccid,
pq.chart_of_accounts_id,
axclv.gl_date
from
perpetual_qry pq,
ar_xla_ctlgd_lines_v axclv,
ra_customer_trx_lines_all rctla,
ra_customer_trx_all rcta,
(
select
plq.interface_line_attribute1,
plq.interface_line_attribute6,
plq.trx_number,
min(plq.line_number) min_inv_line
from
perpetual_lines_qry plq
where
plq.rctla_rank=1
group by
plq.interface_line_attribute1,
plq.interface_line_attribute6,
plq.trx_number
) plq
where
(pq.customer_trx_line_id = rctla.customer_trx_line_id or pq.customer_trx_line_id = rctla.previous_customer_trx_line_id) and
pq.customer_trx_id = rcta.customer_trx_id and
axclv.customer_trx_line_id = rctla.customer_trx_line_id and
axclv.account_set_flag = 'N' and
axclv.account_class in ('REV', 'UNEARN', 'UNBILL') and
axclv.gl_date<=:p_gps_end_dt and
axclv.gl_date>=:p_gps_start_dt and
to_char(pq.sales_order_line_id)=rctla.interface_line_attribute6 and
to_char(pq.sales_order_line_id)=plq.interface_line_attribute6
group by
pq.ledger,
pq.ledger_currency,
pq.operating_unit,
pq.order_number,
pq.order_date,
pq.customer_name,
pq.order_currency,
pq.sales_order_line,
pq.sales_order_issue_date,
rcta.trx_number,
rctla.quantity_invoiced,
pq.invoice_line,
pq.unit_selling_price,
pq.item_cost,
pq.material_cost,
pq.material_oh_cost,
pq.osp_cost,
pq.resource_cost,
pq.overhead_cost,
pq.item,
pq.item_description,
pq.user_item_type,
pq.inventory_item_id,
pq.organization_code,
pq.organization_id,
pq.total_line_quantity,
pq.uom,
pq.earned_cogs,
pq.total_earned_cogs,
pq.deferred_cogs,
pq.total_deferred_cogs,
pq.cogs_account,
pq.deferred_cogs_account,
plq.interface_line_attribute6,
pq.sales_order_line_id,
pq.cogs_om_line_id,
pq.cogs_account_ccid,
pq.chart_of_accounts_id,
axclv.gl_date
having
:p_all_lines = 'Y' or
(decode(sum(rctla.revenue_amount),0,1,round(sum(decode(axclv.account_class,'UNEARN',0,'UNBILL',0, axclv.amount))/(sum(rctla.revenue_amount)/count(axclv.cust_trx_line_gl_dist_id)),3)) <>
decode(pq.earned_cogs,0,decode(pq.deferred_cogs,0,1,0),round((pq.earned_cogs/decode(pq.deferred_cogs+pq.earned_cogs,0,1,pq.deferred_cogs+pq.earned_cogs)),3)) and
pq.deferred_cogs not between -1*:p_amt_tolerance and :p_amt_tolerance
)
union
select
pq.ledger,
pq.ledger_currency,
pq.operating_unit,
pq.order_number,
pq.order_date,
pq.customer_name customer,
pq.order_currency,
pq.sales_order_line order_line,
pq.total_line_quantity order_quantity,
pq.uom,
pq.sales_order_issue_date,
null invoice_number,
null quantity_invoiced,
null invoice_line,
null unit_selling_price,
pq.item_cost,
pq.material_cost,
pq.material_oh_cost,
pq.osp_cost,
pq.resource_cost,
pq.overhead_cost,
pq.item,
pq.item_description,
pq.user_item_type,
pq.inventory_item_id,
pq.organization_code,
pq.organization_id,
null earned_revenue,
null unearned_revenue,
null unbilled_revenue,
pq.earned_cogs,
pq.deferred_cogs,
pq.cogs_account,
pq.deferred_cogs_account,
null revenue_ccid,
null unearn_ccid,
null unbill_ccid,
null interface_line_attribute6,
pq.sales_order_line_id,
pq.cogs_om_line_id,
pq.cogs_account_ccid,
pq.chart_of_accounts_id,
pq.gl_date
from
perpetual_qry pq
where
(pq.customer_trx_line_id is null or pq.customer_trx_id is null) and
(:p_all_lines = 'Y' or pq.deferred_cogs not between -1*:p_amt_tolerance and :p_amt_tolerance)
union
select
pq.ledger,
pq.ledger_currency,
pq.operating_unit,
pq.order_number,
pq.order_date,
pq.customer_name customer,
pq.order_currency,
pq.sales_order_line order_line,
pq.total_line_quantity order_quantity,
pq.uom,
pq.sales_order_issue_date,
null invoice_number,
null quantity_invoiced,
null invoice_line,
null unit_selling_price,
pq.item_cost,
pq.material_cost,
pq.material_oh_cost,
pq.osp_cost,
pq.resource_cost,
pq.overhead_cost,
pq.item,
pq.item_description,
pq.user_item_type,
pq.inventory_item_id,
pq.organization_code,
pq.organization_id,
null earned_revenue,
null unearned_revenue,
null unbilled_revenue,
pq.earned_cogs,
pq.deferred_cogs,
pq.cogs_account,
pq.deferred_cogs_account,
null revenue_ccid,
null unearn_ccid,
null unbill_ccid,
null interface_line_attribute6,
pq.sales_order_line_id,
pq.cogs_om_line_id,
pq.cogs_account_ccid,
pq.chart_of_accounts_id,
pq.gl_date
from
perpetual_qry pq
where
pq.customer_trx_line_id is not null and
pq.customer_trx_id is not null and
not exists
(
select /*+ use_concat no_unnest leading(rctla) use_nl(rctla,rctlgda) */
null
from
ra_customer_trx_lines_all rctla,
ra_cust_trx_line_gl_dist_all rctlgda
where
(pq.customer_trx_line_id = rctla.customer_trx_line_id or pq.customer_trx_line_id = rctla.previous_customer_trx_line_id) and
rctla.customer_trx_line_id = rctlgda.customer_trx_line_id and
rctlgda.account_set_flag = 'N' and
rctlgda.account_class in ('REV', 'UNEARN', 'UNBILL') and
rctlgda.gl_date<=:p_gps_end_dt and
rctlgda.gl_date>=:p_gps_start_dt
) and
(:p_all_lines = 'Y' or pq.deferred_cogs not between -1*:p_amt_tolerance and :p_amt_tolerance)
) x
where
3=3 and
:p_ledger=:p_ledger and
:p_cost_method=1 and
nvl(:p_cost_type,'?')=nvl(:p_cost_type,'?')
order by
x.order_number,
x.order_line,
nvl2(order_quantity,1,2)
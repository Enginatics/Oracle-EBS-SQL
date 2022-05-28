/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST COGS Revenue Matching
-- Description: Imported from Concurrent Program
Application: Bills of Material
Source: COGS Revenue Matching Report
Short Name: CSTRCMRX
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
    select /*+ leading(haou,crcml,oola,ooha,cce,mta) use_nl(haou,crcml, oola, ooha) index(crcml cst_rev_cogs_match_lines_n2) */
    crcml.operating_unit_id,
    haou.name operating_unit,
    ooha.order_number,
    ooha.booked_date,
    ooha.transactional_curr_code,
    oola.line_number,
    oola.sold_to_org_id,
    oola.item_type_code,
    crcml.revenue_om_line_id,
    crcml.organization_id,
    crcml.deferred_cogs_acct_id,
    crcml.cogs_om_line_id,
    crcml.inventory_item_id,
    crcml.unit_cost,
    sum(decode(mta.accounting_line_type, 35, mta.base_transaction_value,0)) cogs_balance,
    last_value(sum(decode(mta.accounting_line_type, 35, mta.base_transaction_value,0)))
    over ( partition by
           crcml.operating_unit_id,
           haou.name,
           ooha.order_number,
           ooha.booked_date,
           ooha.transactional_curr_code,
           oola.line_number,
           oola.sold_to_org_id,
           oola.item_type_code,
           crcml.revenue_om_line_id,
           crcml.organization_id,
           crcml.deferred_cogs_acct_id,
           crcml.cogs_om_line_id
           order by
           crcml.operating_unit_id,
           haou.name,
           ooha.order_number,
           ooha.booked_date,
           ooha.transactional_curr_code,
           oola.line_number,
           oola.sold_to_org_id,
           oola.item_type_code,
           crcml.revenue_om_line_id,
           crcml.organization_id,
           crcml.deferred_cogs_acct_id,
           crcml.cogs_om_line_id
         ) total_cogs_balance,
    sum(decode(mta.accounting_line_type, 36, mta.base_transaction_value,0)) def_cogs_balance,
    last_value(sum(decode(mta.accounting_line_type, 36, mta.base_transaction_value,0)))
    over( partition by
          crcml.operating_unit_id,
          haou.name,
          ooha.order_number,
          ooha.booked_date,
          ooha.transactional_curr_code,
          oola.line_number,
          oola.sold_to_org_id,
          oola.item_type_code,
          crcml.revenue_om_line_id,
          crcml.organization_id,
          crcml.deferred_cogs_acct_id,
          crcml.cogs_om_line_id
          order by
          crcml.operating_unit_id,
          haou.name,
          ooha.order_number,
          ooha.booked_date,
          ooha.transactional_curr_code,
          oola.line_number,
          oola.sold_to_org_id,
          oola.item_type_code,
          crcml.revenue_om_line_id,
          crcml.organization_id,
          crcml.deferred_cogs_acct_id,
          crcml.cogs_om_line_id
        ) total_def_cogs_balance,
    grouping(crcml.cogs_om_line_id) flg_cogs_om_line_id,
    grouping(crcml.inventory_item_id) flg_inv_item_id,
    grouping(crcml.unit_cost) flg_unit_cost
    from
    cst_revenue_cogs_match_lines crcml,
    cst_cogs_events cce,
    oe_order_lines_all oola,
    oe_order_headers_all ooha,
    mtl_transaction_accounts mta,
    hr_all_organization_units haou
    where
    1=1 and
    crcml.ledger_id = :p_ledger_id and
    crcml.pac_cost_type_id is null and
    cce.event_date <= :p_gps_end_dt - (inv_le_timezone_pub.get_le_day_time_for_ou(sysdate,crcml.operating_unit_id)-sysdate) and
    cce.cogs_om_line_id = crcml.cogs_om_line_id and
    oola.header_id = ooha.header_id and
    oola.line_id = crcml.cogs_om_line_id and
    mta.transaction_id (+) = cce.mmt_transaction_id and
    haou.organization_id (+) = crcml.operating_unit_id
    group by
    rollup((crcml.operating_unit_id,
            haou.name,
            ooha.order_number,
            ooha.booked_date,
            ooha.transactional_curr_code,
            oola.line_number,
            oola.sold_to_org_id,
            oola.item_type_code,
            crcml.revenue_om_line_id,
            crcml.organization_id,
            crcml.deferred_cogs_acct_id,
            crcml.cogs_om_line_id
           ),
           (crcml.cogs_om_line_id,
            crcml.inventory_item_id,
            crcml.unit_cost
           )
          )
  ) x
  where
  x.flg_cogs_om_line_id <>1 and
  x.flg_inv_item_id <> 1 and
  x.flg_unit_cost <> 1
),
perpetual_qry_2 as
(
  select /*+ index(rctla ra_customer_trx_lines_n9) leading (pq1, rctla) use_nl(pq1, rctla) */
  pq1.operating_unit_id,
  pq1.operating_unit,
  pq1.order_number order_number,
  pq1.booked_date order_date,
  substrb(hp.party_name,1,50) customer_name,
  pq1.transactional_curr_code currency,
  pq1.line_number sales_order_line,
  pq1.revenue_om_line_id sales_order_line_id,
  pq1.item_type_code item_type_code,
  msik.concatenated_segments item,
  rctla.line_number invoice_line,
  rctla.customer_trx_line_id,
  rctla.customer_trx_id,
  sum(cce.event_quantity) total_line_quantity,
  pq1.cogs_balance earned_cogs,
  pq1.total_cogs_balance total_earned_cogs,
  pq1.def_cogs_balance deferred_cogs,
  pq1.total_def_cogs_balance total_deferred_cogs,
  gcck_cogs.concatenated_segments cogs_account,
  gcck_dcogs.concatenated_segments deferred_cogs_account,
  pq1.cogs_om_line_id cogs_om_line_id
  from
  perpetual_qry_1 pq1,
  cst_revenue_cogs_match_lines crcml,
  mtl_system_items_kfv msik,
  gl_code_combinations_kfv gcck_cogs,
  gl_code_combinations_kfv gcck_dcogs,
  ra_customer_trx_lines_all rctla,
  hz_cust_accounts hca,
  hz_parties hp,
  cst_cogs_events cce
  where
  msik.inventory_item_id = pq1.inventory_item_id and
  msik.organization_id = pq1.organization_id and
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
  cce.event_date <= :p_gps_end_dt - (inv_le_timezone_pub.get_le_day_time_for_ou(sysdate,pq1.operating_unit_id)-sysdate) and
  crcml.cogs_om_line_id = pq1.cogs_om_line_id and
  crcml.pac_cost_type_id is null and
  ( :p_all_lines = 'Y' or pq1.def_cogs_balance not between -1*:p_amt_tolerance and :p_amt_tolerance)
  group by
  pq1.operating_unit_id,
  pq1.operating_unit,
  pq1.order_number,
  pq1.booked_date,
  substrb(hp.party_name,1,50),
  pq1.transactional_curr_code,
  pq1.line_number,
  pq1.revenue_om_line_id,
  pq1.item_type_code,
  msik.concatenated_segments,
  rctla.line_number,
  rctla.customer_trx_line_id,
  rctla.customer_trx_id,
  pq1.cogs_balance,
  pq1.total_cogs_balance,
  pq1.def_cogs_balance,
  pq1.total_def_cogs_balance,
  gcck_cogs.concatenated_segments,
  gcck_dcogs.concatenated_segments,
  pq1.cogs_om_line_id
),
perpetual_qry as
(
  select
  pq2.operating_unit_id,
  pq2.operating_unit,
  pq2.order_number,
  pq2.order_date,
  pq2.customer_name,
  pq2.currency,
  pq2.sales_order_line,
  pq2.sales_order_line_id,
  pq2.item_type_code,
  pq2.item,
  pq2.invoice_line,
  pq2.customer_trx_line_id,
  pq2.customer_trx_id,
  pq2.total_line_quantity,
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
  pq2.cogs_om_line_id
  from
  perpetual_qry_2 pq2
),
perpetual_lines_qry as
(
  select /*+ leading(pq2,rctla) index(rctla ra_customer_trx_lines_n9)*/
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
:p_ledger ledger,
x.operating_unit,
x.order_number,
x.order_date,
x.customer,
x.currency,
x.order_line,
x.order_quantity,
x.invoice_number,
x.invoice_line,
x.item_number,
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
case when x.earned_cogs is not null and x.deferred_cogs is not null
then case when x.earned_cogs + x.deferred_cogs = 0
     then 100
     else x.earned_cogs/(x.earned_cogs + x.deferred_cogs)*100
     end
end cogs_percent,
x.cogs_account,
x.deferred_cogs_account
from
(
select /*+ leading(pq) no_merge(rctlgda) index(rctlgda ra_cust_trx_line_gl_dist_n1)*/
pq.operating_unit,
pq.order_number order_number,
pq.order_date order_date,
pq.customer_name customer,
decode(rcta.trx_number,min(plq.trx_number),decode(pq.invoice_line,min(plq.min_inv_line), pq.currency, null), null) currency,
pq.sales_order_line order_line,
decode(rcta.trx_number,min(plq.trx_number),decode(pq.invoice_line,min(plq.min_inv_line),pq.total_line_quantity,null),null) order_quantity,
rcta.trx_number invoice_number,
pq.invoice_line invoice_line,
pq.item item_number,
round(sum(decode(rctlgda.account_class,'UNEARN',0,'UNBILL',0, rctlgda.acctd_amount))*decode(pq.earned_cogs, pq.total_earned_cogs,1,pq.earned_cogs/decode(pq.total_earned_cogs,0,1,pq.total_earned_cogs)),2) earned_revenue,
round(sum(decode(rctlgda.account_class,'REV',   0,'UNBILL',0, rctlgda.acctd_amount))*decode(pq.deferred_cogs, pq.total_deferred_cogs,1,pq.deferred_cogs/decode(pq.total_deferred_cogs,0,1,pq.total_deferred_cogs)),2) unearned_revenue,
round(sum(decode(rctlgda.account_class,'REV',   0,'UNEARN',0, rctlgda.acctd_amount))*decode(pq.deferred_cogs, pq.total_deferred_cogs,1,pq.deferred_cogs/decode(pq.total_deferred_cogs,0,1,pq.total_deferred_cogs)),2) unbilled_revenue,
decode(rcta.trx_number,min(plq.trx_number),decode(pq.invoice_line,min(plq.min_inv_line),pq.earned_cogs,null),null) earned_cogs,
decode(rcta.trx_number,min(plq.trx_number),decode(pq.invoice_line,min(plq.min_inv_line),pq.deferred_cogs,null),null) deferred_cogs,
decode(rcta.trx_number,min(plq.trx_number),decode(pq.invoice_line,min(plq.min_inv_line),pq.cogs_account,null),null) cogs_account,
decode(rcta.trx_number,min(plq.trx_number),decode(pq.invoice_line,min(plq.min_inv_line),pq.deferred_cogs_account,null),null) deferred_cogs_account,
plq.interface_line_attribute6,
pq.sales_order_line_id,
pq.cogs_om_line_id
from
perpetual_qry pq,
ra_cust_trx_line_gl_dist_all rctlgda,
ra_customer_trx_lines_all rctla,
ra_customer_trx_all rcta,
(select
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
rctlgda.customer_trx_line_id = rctla.customer_trx_line_id and
rctlgda.account_set_flag = 'N' and
rctlgda.account_class in ('REV', 'UNEARN', 'UNBILL') and
rctlgda.gl_date <= :p_gps_end_dt and
to_char(pq.sales_order_line_id)=rctla.interface_line_attribute6 and
to_char(pq.sales_order_line_id)=plq.interface_line_attribute6
group by
pq.operating_unit,
pq.order_number,
pq.order_date,
pq.customer_name,
pq.currency,
pq.sales_order_line,
rcta.trx_number,
pq.invoice_line,
pq.item,
pq.total_line_quantity,
pq.earned_cogs,
pq.total_earned_cogs,
pq.deferred_cogs,
pq.total_deferred_cogs,
pq.cogs_account,
pq.deferred_cogs_account,
plq.interface_line_attribute6,
pq.sales_order_line_id,
pq.cogs_om_line_id
having
(
 :p_all_lines = 'Y' or
 (decode(sum(rctla.revenue_amount),0,1,round(sum(decode(rctlgda.account_class,'UNEARN',0,'UNBILL',0, rctlgda.amount))/(sum(rctla.revenue_amount)/count(rctlgda.cust_trx_line_gl_dist_id)),3)) <>
  decode(pq.earned_cogs,0,decode(pq.deferred_cogs,0,1,0),round((pq.earned_cogs/decode(pq.deferred_cogs+pq.earned_cogs,0,1,pq.deferred_cogs+pq.earned_cogs)),3)) and
  pq.deferred_cogs not between -1*:p_amt_tolerance and :p_amt_tolerance
 )
)
union
select
pq.operating_unit,
pq.order_number order_number,
pq.order_date order_date,
pq.customer_name customer,
pq.currency currency,
pq.sales_order_line order_line,
pq.total_line_quantity order_quantity,
null invoice_number,
null invoice_line,
pq.item item_number,
null earned_revenue,
null unearned_revenue,
null unbilled_revenue,
pq.earned_cogs earned_cogs,
pq.deferred_cogs deferred_cogs,
pq.cogs_account cogs_account,
pq.deferred_cogs_account deferred_cogs_account,
null interface_line_attribute6,
pq.sales_order_line_id,
pq.cogs_om_line_id
from
perpetual_qry pq
where
(pq.customer_trx_line_id is null or pq.customer_trx_id is null) and
(:p_all_lines = 'Y' or pq.deferred_cogs not between -1*:p_amt_tolerance and :p_amt_tolerance)
union
select
pq.operating_unit,
pq.order_number order_number,
pq.order_date order_date,
pq.customer_name customer,
pq.currency currency,
pq.sales_order_line order_line,
pq.total_line_quantity order_quantity,
null invoice_number,
null invoice_line,
pq.item item_number,
null earned_revenue,
null unearned_revenue,
null unbilled_revenue,
pq.earned_cogs earned_cogs,
pq.deferred_cogs deferred_cogs,
pq.cogs_account cogs_account,
pq.deferred_cogs_account deferred_cogs_account,
null interface_line_attribute6,
pq.sales_order_line_id,
pq.cogs_om_line_id
from
perpetual_qry pq
where
(pq.customer_trx_line_id is not null and pq.customer_trx_id is not null) and
not exists
 (select /*+ use_concat no_unnest leading(rctla) use_nl(rctla,rctlgda) */
  null
  from
  ra_customer_trx_lines_all rctla,
  ra_cust_trx_line_gl_dist_all rctlgda
  where
  (pq.customer_trx_line_id = rctla.customer_trx_line_id or pq.customer_trx_line_id = rctla.previous_customer_trx_line_id) and
  rctla.customer_trx_line_id = rctlgda.customer_trx_line_id and
  rctlgda.account_set_flag = 'N' and
  rctlgda.account_class in ('REV', 'UNEARN', 'UNBILL') and
  rctlgda.gl_date <= :p_gps_end_dt
 ) and
(:p_all_lines = 'Y' or pq.deferred_cogs not between -1*:p_amt_tolerance and :p_amt_tolerance)
) x
where
:p_cost_method=1
order by
x.order_number,
x.order_line,
nvl2(order_quantity,1,2)
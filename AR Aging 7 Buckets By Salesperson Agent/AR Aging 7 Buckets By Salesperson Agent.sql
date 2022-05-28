/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Aging - 7 Buckets - By Salesperson/Agent
-- Description: Application: Receivables
Source: Aging - 7 Buckets  - By Salesperson/Agent Report
Short Name: ARXAGRW
Package: XXEN_AR_ARXAGRW_PKG
-- Excel Examle Output: https://www.enginatics.com/example/ar-aging-7-buckets-by-salesperson-agent/
-- Library Link: https://www.enginatics.com/reports/ar-aging-7-buckets-by-salesperson-agent/
-- Run Report: https://demo.enginatics.com/

select
 x1.ledger                           ledger,
 x1.operating_unit                   operating_unit,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('lp_acct_flex_bal_seg', 'SQLGL', 'GL#', x1.chart_of_accounts_id, NULL, x1.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') "&lp_bal_seg_p",
 fnd_flex_xml_publisher_apis.process_kff_combination_1('lp_acct_flex_acc_seg', 'SQLGL', 'GL#', x1.chart_of_accounts_id, NULL, x1.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE') "&lp_acc_seg_p",
 fnd_flex_xml_publisher_apis.process_kff_combination_1('lp_accounting_flexfield', 'SQLGL', 'GL#', x1.chart_of_accounts_id, NULL, x1.code_combination_id, 'ALL', 'Y', 'VALUE') gl_account_segments,
 x1.sort_field1                      salesperson,
 x1.cust_name                        customer,
 x1.cust_no                          customer_Number,
 &lp_invoice_cols_s
 nvl(sum(x1.amt_due_original),0)     original_amount,
 nvl(sum(x1.amt_due_remaining),0)    outstanding_amount,
 &lp_on_acc_summ_cols
 sum(decode(x1.b0,1,x1.amt_due_remaining,null)) "&lp_b0_p",
 sum(decode(x1.b1,1,x1.amt_due_remaining,null)) "&lp_b1_p",
 sum(decode(x1.b2,1,x1.amt_due_remaining,null)) "&lp_b2_p",
 sum(decode(x1.b3,1,x1.amt_due_remaining,null)) "&lp_b3_p",
 sum(decode(x1.b4,1,x1.amt_due_remaining,null)) "&lp_b4_p",
 sum(decode(x1.b5,1,x1.amt_due_remaining,null)) "&lp_b5_p",
 sum(decode(x1.b6,1,x1.amt_due_remaining,null)) "&lp_b6_p",
 case nvl(sum(x1.amt_due_remaining),0)
 when 0 then to_number(null) else round(sum(decode(x1.b0,1,x1.amt_due_remaining,null)) / sum(x1.amt_due_remaining) * 100,2)
 end "&lp_b0_ps %",
 case nvl(sum(x1.amt_due_remaining),0)
 when 0 then to_number(null) else round(sum(decode(x1.b1,1,x1.amt_due_remaining,null)) / sum(x1.amt_due_remaining) * 100,2)
 end "&lp_b1_ps %",
 case nvl(sum(x1.amt_due_remaining),0)
 when 0 then to_number(null) else round(sum(decode(x1.b2,1,x1.amt_due_remaining,null)) / sum(x1.amt_due_remaining) * 100,2)
 end "&lp_b2_ps %",
 case nvl(sum(x1.amt_due_remaining),0)
 when 0 then to_number(null) else round(sum(decode(x1.b3,1,x1.amt_due_remaining,null)) / sum(x1.amt_due_remaining) * 100,2)
 end "&lp_b3_ps %",
 case nvl(sum(x1.amt_due_remaining),0)
 when 0 then to_number(null) else round(sum(decode(x1.b4,1,x1.amt_due_remaining,null)) / sum(x1.amt_due_remaining) * 100,2)
 end "&lp_b4_ps %",
 case nvl(sum(x1.amt_due_remaining),0)
 when 0 then to_number(null) else round(sum(decode(x1.b5,1,x1.amt_due_remaining,null)) / sum(x1.amt_due_remaining) * 100,2)
 end "&lp_b5_ps %",
 case nvl(sum(x1.amt_due_remaining),0)
 when 0 then to_number(null) else round(sum(decode(x1.b6,1,x1.amt_due_remaining,null)) / sum(x1.amt_due_remaining) * 100,2)
 end "&lp_b6_ps %",
 -- Revaluation Columns
 &lp_reval_columns
 --
 fnd_flex_xml_publisher_apis.process_kff_combination_1('lp_acct_flex_bal_seg', 'SQLGL', 'GL#', x1.chart_of_accounts_id, NULL, x1.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION') "&lp_bal_seg_p Desc",
 fnd_flex_xml_publisher_apis.process_kff_combination_1('lp_acct_flex_acc_seg', 'SQLGL', 'GL#', x1.chart_of_accounts_id, NULL, x1.code_combination_id, 'GL_ACCOUNT', 'Y', 'DESCRIPTION') "&lp_acc_seg_p Desc",
 fnd_flex_xml_publisher_apis.process_kff_combination_1('lp_accounting_flexfield', 'SQLGL', 'GL#', x1.chart_of_accounts_id, NULL, x1.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') gl_account_segments_desc
from
 ( --start x1
  select
   x.ledger,
   (select haou.name from hr_all_organization_units haou where haou.organization_id = x.org_id) operating_unit,
   x.sort_field1,
   x.sort_field2,
   x.cust_name,
   x.cust_no,
   x.class,
   x.cons_billing_number,
   x.invnum,
   x.due_date,
   x.days_past_due,
   x.amt_due_original,
   x.amount_adjusted,
   x.amount_applied,
   x.amount_credited,
   x.gl_date,
   x.data_converted,
   x.ps_exchange_rate,
   x.code_combination_id,
   x.chart_of_accounts_id,
   x.invoice_type,
   x.b0,
   x.b1,
   x.b2,
   x.b3,
   x.b4,
   x.b5,
   x.b6,
   case when (:p_credit_option = 'SUMMARY' and x.class in ('PMT','CM','CLAIM'))
          or (:p_risk_option = 'SUMMARY' AND x.invoice_type = :p_risk_meaning)
     then to_number(null)
     else x.amt_due_remaining
     end amt_due_remaining,
   case when :p_credit_option = 'SUMMARY' AND x.class = 'PMT'
     then x.amt_due_remaining
     else null
     end  on_account_amount_cash,
   case when :p_credit_option = 'SUMMARY' AND x.class = 'CM'
     then x.amt_due_remaining
     else null
     end  on_account_amount_credit,
   case when :p_risk_option = 'SUMMARY' AND x.invoice_type = :p_risk_meaning
     then x.amt_due_remaining
     else null
     end  on_account_amount_risk,
   case when :p_credit_option = 'SUMMARY' AND x.class = 'CLAIM'
     then x.amt_due_remaining
     else null
     end  cust_amount_claim,
   nvl(:p_in_currency,x.functional_currency) revaluation_from_currency,
   decode(nvl(:p_in_currency,x.functional_currency),:p_reval_currency,1,(select gdr.conversion_rate from gl_daily_conversion_types gdct, gl_daily_rates gdr where nvl(:p_in_currency,x.functional_currency)=gdr.from_currency and gdr.to_currency=:p_reval_currency and :p_reval_conv_date=gdr.conversion_date and gdct.user_conversion_type=:p_reval_conv_type and gdct.conversion_type=gdr.conversion_type)) reval_conv_rate,
   xxen_util.meaning(:p_reporting_level,'FND_MO_REPORTING_LEVEL',0) reporting_level,
   case :p_reporting_level when '1000' then x.ledger when '3000' then (select haou.name from hr_all_organization_units haou where haou.organization_id = x.org_id) end reporting_entity   
  from
   ( --start x
    select
     substrb(party.party_name,1,50) cust_name,
     cust_acct.account_number cust_no,
     nvl(sales.name,jrrev.resource_name) sort_field1,
     arpt_sql_func_util.get_org_trx_type_details(ps.cust_trx_type_id,ps.org_id) sort_field2,
     nvl(sales.salesrep_id, -3) inv_tid,
     site.site_use_id contact_site_id,
     loc.state cust_state,
     loc.city cust_city,
     decode(decode(upper(rtrim(rpad(:p_in_format_option_low, 1))),'D','D',null),null,-1,acct_site.cust_acct_site_id) addr_id,
     nvl(cust_acct.cust_account_id,-999) cust_id,
     ps.payment_schedule_id payment_sched_id,
     ps.class class,
     ps.due_date  due_date,
     decode(nvl2(:p_in_currency,'N','Y'), 'Y', ps.amount_due_original * nvl(ps.exchange_rate, 1), ps.amount_due_original) amt_due_original,
     xxen_ar_arxagrw_pkg.comp_amt_due_remainingformula
      ( ps.class,
        arpt_sql_func_util.get_org_trx_type_details(ps.cust_trx_type_id,ps.org_id),
        ps.payment_schedule_id,
        ps.amt_due_remaining,
        ps.amount_applied,
        ps.amount_credited,
        ps.amount_adjusted
      )  amt_due_remaining,
     ps.trx_number invnum,
     ceil(:p_in_as_of_date_low - ps.due_date) days_past_due,
     ps.amount_adjusted amount_adjusted,
     ps.amount_applied amount_applied,
     ps.amount_credited amount_credited,
     ps.gl_date gl_date,
     decode(ps.invoice_currency_code, gsob.currency_code, NULL, decode(ps.exchange_rate, null, '*', null)) data_converted,
     nvl(ps.exchange_rate, 1) ps_exchange_rate,
     arpt_sql_func_util.bucket_function
      ( xxen_ar_arxagrw_pkg.bucket_line_type(0),
        dh.amount_in_dispute,
        ps.amount_adjusted_pending,
        xxen_ar_arxagrw_pkg.bucket_days_from(0),
        xxen_ar_arxagrw_pkg.bucket_days_to(0),
        ps.due_date,
        xxen_ar_arxagrw_pkg.bucket_category,
        :p_in_as_of_date_low
      ) b0,
     arpt_sql_func_util.bucket_function
      ( xxen_ar_arxagrw_pkg.bucket_line_type(1),
        dh.amount_in_dispute,
        ps.amount_adjusted_pending,
        xxen_ar_arxagrw_pkg.bucket_days_from(1),
        xxen_ar_arxagrw_pkg.bucket_days_to(1),
        ps.due_date,
        xxen_ar_arxagrw_pkg.bucket_category,
        :p_in_as_of_date_low
      ) b1,
     arpt_sql_func_util.bucket_function
      ( xxen_ar_arxagrw_pkg.bucket_line_type(2),
        dh.amount_in_dispute,
        ps.amount_adjusted_pending,
        xxen_ar_arxagrw_pkg.bucket_days_from(2),
        xxen_ar_arxagrw_pkg.bucket_days_to(2),
        ps.due_date,
        xxen_ar_arxagrw_pkg.bucket_category,
        :p_in_as_of_date_low
      ) b2,
     arpt_sql_func_util.bucket_function
      ( xxen_ar_arxagrw_pkg.bucket_line_type(3),
        dh.amount_in_dispute,
        ps.amount_adjusted_pending,
        xxen_ar_arxagrw_pkg.bucket_days_from(3),
        xxen_ar_arxagrw_pkg.bucket_days_to(3),
        ps.due_date,
        xxen_ar_arxagrw_pkg.bucket_category,
        :p_in_as_of_date_low
      ) b3,
     arpt_sql_func_util.bucket_function
      ( xxen_ar_arxagrw_pkg.bucket_line_type(4),
        dh.amount_in_dispute,
        ps.amount_adjusted_pending,
        xxen_ar_arxagrw_pkg.bucket_days_from(4),
        xxen_ar_arxagrw_pkg.bucket_days_to(4),
        ps.due_date,
        xxen_ar_arxagrw_pkg.bucket_category,
        :p_in_as_of_date_low
      ) b4,
     arpt_sql_func_util.bucket_function
      ( xxen_ar_arxagrw_pkg.bucket_line_type(5),
        dh.amount_in_dispute,
        ps.amount_adjusted_pending,
        xxen_ar_arxagrw_pkg.bucket_days_from(5),
        xxen_ar_arxagrw_pkg.bucket_days_to(5),
        ps.due_date,
        xxen_ar_arxagrw_pkg.bucket_category,
        :p_in_as_of_date_low
      ) b5,
     arpt_sql_func_util.bucket_function
      ( xxen_ar_arxagrw_pkg.bucket_line_type(6),
        dh.amount_in_dispute,
        ps.amount_adjusted_pending,
        xxen_ar_arxagrw_pkg.bucket_days_from(6),
        xxen_ar_arxagrw_pkg.bucket_days_to(6),
        ps.due_date,
        xxen_ar_arxagrw_pkg.bucket_category,
        :p_in_as_of_date_low
      ) b6,
     c.code_combination_id,
     c.chart_of_accounts_id,
     ci.cons_billing_number  cons_billing_number,
     arpt_sql_func_util.get_org_trx_type_details(ps.cust_trx_type_id,ps.org_id) invoice_type,
     gsob.currency_code functional_currency,
     gsob.name ledger,
     ps.org_id
    from
     hz_cust_accounts cust_acct,
     hz_parties party,
     (select
       a.customer_id,
       a.customer_site_use_id ,
       a.customer_trx_id,
       a.payment_schedule_id,
       a.class ,
       sum(a.primary_salesrep_id) primary_salesrep_id,
       a.due_date ,
       sum(a.amount_due_remaining) amt_due_remaining,
       a.trx_number,
       a.amount_due_original,
       a.amount_adjusted,
       a.amount_applied ,
       a.amount_credited ,
       a.amount_adjusted_pending,
       a.gl_date ,
       a.cust_trx_type_id,
       a.org_id,
       a.invoice_currency_code,
       a.exchange_rate,
       sum(a.cons_inv_id) cons_inv_id
      from
       (
        select
         ps.customer_id,
         ps.customer_site_use_id,
         ps.customer_trx_id,
         ps.payment_schedule_id,
         ps.class,
         0 primary_salesrep_id,
         ps.due_date,
         nvl(sum(decode(nvl2(:p_in_currency,'N','Y'), 'Y', nvl(adj.acctd_amount, 0), adj.amount)),0) * (-1)  amount_due_remaining,
         ps.trx_number,
         ps.amount_due_original,
         ps.amount_adjusted,
         ps.amount_applied,
         ps.amount_credited,
         ps.amount_adjusted_pending,
         ps.gl_date,
         ps.cust_trx_type_id,
         ps.org_id,
         ps.invoice_currency_code,
         nvl(ps.exchange_rate,1) exchange_rate,
         0 cons_inv_id
        from
         ar_payment_schedules ps,
         ar_adjustments adj
         &lp_customer_num_f
        where
            ps.gl_date <= :p_in_as_of_date_low
        and ps.customer_id > 0
        and  ps.gl_date_closed  > :p_in_as_of_date_low
        and  decode(upper(:p_in_currency),NULL, ps.invoice_currency_code,upper(:p_in_currency)) = ps.invoice_currency_code
        and  adj.payment_schedule_id = ps.payment_schedule_id
        and  adj.status = 'A'
        and  adj.gl_date > :p_in_as_of_date_low
        &lp_customer_num_low
        &lp_customer_num_high
        &lp_customer_num_w
        and xxen_ar_arxagrw_pkg.include_org_id(ps.org_id) = 'Y'
        and adj.org_id = ps.org_id
       group by
        ps.customer_id,
        ps.customer_site_use_id,
        ps.customer_trx_id,
        ps.class,
        ps.due_date,
        ps.trx_number,
        ps.amount_due_original,
        ps.amount_adjusted,
        ps.amount_applied,
        ps.amount_credited,
        ps.amount_adjusted_pending,
        ps.gl_date,
        ps.cust_trx_type_id,
        ps.org_id,
        ps.invoice_currency_code,
        nvl(ps.exchange_rate,1),
        ps.payment_schedule_id
       union all
       select
        ps.customer_id,
        ps.customer_site_use_id,
        ps.customer_trx_id,
        ps.payment_schedule_id,
        ps.class,
        0 primary_salesrep_id,
        ps.due_date,
        nvl(sum(decode( nvl2(:p_in_currency,'N','Y'),
                        'Y', (decode( ps.class,
                                      'CM', decode( app.application_type, 'CM', app.acctd_amount_applied_from, app.acctd_amount_applied_to),
                                            app.acctd_amount_applied_to
                                    ) +
                               nvl(app.acctd_earned_discount_taken,0) +
                               nvl(app.acctd_unearned_discount_taken,0)
                              )
                           ,  ( app.amount_applied +
                               nvl(app.earned_discount_taken,0) +
                               nvl(app.unearned_discount_taken,0)
                              )
                      ) *
                decode( ps.class,
                        'CM', decode(app.application_type, 'CM', -1, 1),
                              1
                      )
               ),0
           ) amount_due_remaining,
        ps.trx_number,
        ps.amount_due_original,
        ps.amount_adjusted,
        ps.amount_applied ,
        ps.amount_credited,
        ps.amount_adjusted_pending,
        ps.gl_date gl_date,
        ps.cust_trx_type_id,
        ps.org_id,
        ps.invoice_currency_code,
        nvl(ps.exchange_rate, 1) exchange_rate,
        0 cons_inv_id
       from
        ar_payment_schedules ps,
        ar_receivable_applications app
        &lp_customer_num_f
       where
           ps.gl_date <= :p_in_as_of_date_low
       and ps.customer_id > 0
       and ps.gl_date_closed  > :p_in_as_of_date_low
       and decode(upper(:p_in_currency),NULL, ps.invoice_currency_code, upper(:p_in_currency)) = ps.invoice_currency_code
       and (app.applied_payment_schedule_id = ps.payment_schedule_id or
            app.payment_schedule_id = ps.payment_schedule_id
           )
       and app.status IN ('APP', 'ACTIVITY')
       and nvl( app.confirmed_flag, 'Y' ) = 'Y'
       and app.gl_date > :p_in_as_of_date_low
       &lp_customer_num_low
       &lp_customer_num_high
       &lp_customer_num_w
       and xxen_ar_arxagrw_pkg.include_org_id(ps.org_id) = 'Y'
       and app.org_id = ps.org_id
       group by
        ps.customer_id,
        ps.customer_site_use_id,
        ps.customer_trx_id,
        ps.class,
        ps.due_date,
        ps.trx_number,
        ps.amount_due_original,
        ps.amount_adjusted,
        ps.amount_applied,
        ps.amount_credited,
        ps.amount_adjusted_pending,
        ps.gl_date,
        ps.cust_trx_type_id,
        ps.org_id,
        ps.invoice_currency_code,
        nvl(ps.exchange_rate, 1),
        ps.payment_schedule_id
       union all
       select
        ps.customer_id,
        ps.customer_site_use_id,
        ps.customer_trx_id,
        ps.payment_schedule_id,
        ps.class class,
        nvl(ct.primary_salesrep_id, -3) primary_salesrep_id,
        ps.due_date  due_date,
        decode( nvl2(:p_in_currency,'N','Y'), 'Y', ps.acctd_amount_due_remaining, ps.amount_due_remaining) amt_due_remaining,
        ps.trx_number,
        ps.amount_due_original,
        ps.amount_adjusted,
        ps.amount_applied,
        ps.amount_credited,
        ps.amount_adjusted_pending,
        ps.gl_date,
        ps.cust_trx_type_id,
        ps.org_id,
        ps.invoice_currency_code,
        nvl(ps.exchange_rate, 1) exchange_rate,
        ps.cons_inv_id
       from
        ar_payment_schedules ps,
        ra_customer_trx ct
        &lp_customer_num_f
       where
           ps.gl_date <= :p_in_as_of_date_low
       and ps.gl_date_closed  > :p_in_as_of_date_low
       and decode(upper(:p_in_currency),NULL, ps.invoice_currency_code, upper(:p_in_currency)) = ps.invoice_currency_code
       and ps.customer_trx_id = ct.customer_trx_id
       and ps.class <> 'CB'
       &lp_customer_num_low
       &lp_customer_num_high
       &lp_customer_num_w
       and xxen_ar_arxagrw_pkg.include_org_id(ps.org_id) = 'Y'
       and ct.org_id = ps.org_id
       union all
       select
        ps.customer_id,
        ps.customer_site_use_id ,
        ps.customer_trx_id,
        ps.payment_schedule_id,
        ps.class class,
        ct.primary_salesrep_id primary_salesrep_id,
        ps.due_date  due_date,
        decode( nvl2(:p_in_currency,'N','Y'), 'Y', ps.acctd_amount_due_remaining, ps.amount_due_remaining) amt_due_remaining,
        ps.trx_number,
        ps.amount_due_original,
        ps.amount_adjusted,
        ps.amount_applied,
        ps.amount_credited,
        ps.amount_adjusted_pending,
        ps.gl_date,
        ps.cust_trx_type_id,
        ps.org_id,
        ps.invoice_currency_code,
        nvl(ps.exchange_rate, 1) exchange_rate,
        ps.cons_inv_id
       from
        ar_payment_schedules ps,
        ra_customer_trx ct,
        ar_adjustments adj
        &lp_customer_num_f
       where
           ps.gl_date <= :p_in_as_of_date_low
       and ps.gl_date_closed  > :p_in_as_of_date_low
       and decode(upper(:p_in_currency),NULL, ps.invoice_currency_code, upper(:p_in_currency)) = ps.invoice_currency_code
       and ps.class = 'CB'
       and ps.customer_trx_id = adj.chargeback_customer_trx_id
       and adj.customer_trx_id = ct.customer_trx_id
       &lp_customer_num_low
       &lp_customer_num_high
       &lp_customer_num_w
       and xxen_ar_arxagrw_pkg.include_org_id(ps.org_id) = 'Y'
       and ct.org_id = ps.org_id
       and adj.org_id = ps.org_id
      ) a
     group by
      a.customer_id,
      a.customer_site_use_id,
      a.customer_trx_id,
      a.payment_schedule_id,
      a.class,
      a.due_date,
      a.trx_number,
      a.amount_due_original,
      a.amount_adjusted,
      a.amount_applied,
      a.amount_credited,
      a.amount_adjusted_pending,
      a.gl_date,
      a.cust_trx_type_id,
      a.org_id,
      a.invoice_currency_code,
      a.exchange_rate
     ) ps,
     ar_cons_inv ci,
     ra_salesreps_all sales,
     jtf_rs_resource_extns_vl jrrev,
     hz_cust_site_uses site,
     hz_cust_acct_sites acct_site,
     hz_party_sites party_site,
     hz_locations loc,
     ra_cust_trx_line_gl_dist gld,
     ar_dispute_history dh,
     gl_code_combinations c,
     ra_customer_trx rct,
     gl_sets_of_books gsob
    where
        --upper(RTRIM(RPAD(:p_in_summary_option_low,1)) ) = 'I'
        ps.customer_site_use_id = site.site_use_id
    and site.cust_acct_site_id = acct_site.cust_acct_site_id
    and acct_site.party_site_id = party_site.party_site_id
    and loc.location_id = party_site.location_id
    and ps.customer_id = cust_acct.cust_account_id
    and cust_acct.party_id = party.party_id
    and ps.customer_trx_id = gld.customer_trx_id
    and gld.account_class = 'REC'
    and gld.latest_rec_flag = 'Y'
    and gld.code_combination_id = c.code_combination_id
    and ps.payment_schedule_id  =  dh.payment_schedule_id(+)
    and :p_in_as_of_date_low  >= nvl(dh.start_date(+), :p_in_as_of_date_low)
    and :p_in_as_of_date_low  <  nvl(dh.end_date(+), :p_in_as_of_date_low + 1)
    and (   dh.dispute_history_id is null
         or dh.dispute_history_id =
              (select max(dh2.dispute_history_id)
               from   ar_dispute_history dh2
               where  dh2.payment_schedule_id = ps.payment_schedule_id
               and    :p_in_as_of_date_low  >= nvl(dh2.start_date(+), :p_in_as_of_date_low)
               and    :p_in_as_of_date_low  <  nvl(dh2.end_date(+), :p_in_as_of_date_low + 1)
              )
        )
    and rct.customer_trx_id = ps.customer_trx_id
    and gsob.set_of_books_id = rct.set_of_books_id
    &lp_customer_name_low
    &lp_customer_name_high
    &lp_customer_num_low
    &lp_customer_num_high
    &lp_invoice_type_low
    &lp_invoice_type_high
    &lp_bal_seg_low
    &lp_bal_seg_high
    and ps.cons_inv_id = ci.cons_inv_id(+)
    and nvl(ps.primary_salesrep_id,-3) = sales.salesrep_id
    and sales.org_id = ps.org_id
    and jrrev.resource_id = sales.resource_id
    and nvl(sales.name,jrrev.resource_name) between nvl(:p_in_salesrep_name_low,nvl(sales.name,jrrev.resource_name))
                                                and nvl(:p_in_salesrep_name_high,nvl(sales.name,jrrev.resource_name))
    and xxen_ar_arxagrw_pkg.include_org_id(ps.org_id) = 'Y'
    and gld.org_id = ps.org_id
    and site.org_id = ps.org_id
    union all
    select
     substrb(nvl(party.party_name,:p_short_unid_phrase),1,50) cust_name,
     cust_acct.account_number cust_no,
     nvl(sales.name,jrrev.resource_name),
     initcap(:p_payment_meaning),
     nvl(sales.salesrep_id,-3),
     site.site_use_id,
     loc.state cust_state,
     loc.city cust_state,
     decode(decode(upper(RTRIM(RPAD(:p_in_format_option_low, 1))),'D','D',NULL),NULL,-1,acct_site.cust_acct_site_id) addr_id,
     nvl(cust_acct.cust_account_id, -999) cust_id,
     ps.payment_schedule_id,
     app.class,
     ps.due_date,
     decode(nvl2(:p_in_currency,'N','Y'), 'Y', ps.amount_due_original * nvl(ps.exchange_rate, 1), ps.amount_due_original) amt_due_original,
     xxen_ar_arxagrw_pkg.Comp_Amt_Due_RemainingFormula
      ( app.class,
        initcap(:p_payment_meaning),
        ps.payment_schedule_id,
        decode(nvl2(:p_in_currency,'N','Y'), 'Y', nvl(-SUM(app.acctd_amount), 0), nvl(-SUM(app.amount), 0)), -- amount due remaining
        ps.amount_applied,
        ps.amount_credited,
        ps.amount_adjusted
      )  amt_due_remaining,
     ps.trx_number,
     ceil(:p_in_as_of_date_low - ps.due_date),
     ps.amount_adjusted,
     ps.amount_applied,
     ps.amount_credited,
     ps.gl_date,
     decode(ps.invoice_currency_code, gsob.currency_code, NULL, decode(ps.exchange_rate, NULL, '*', NULL)),
     nvl(ps.exchange_rate, 1),
     arpt_sql_func_util.bucket_function
      ( xxen_ar_arxagrw_pkg.bucket_line_type(0),
        ps.amount_in_dispute,
        ps.amount_adjusted_pending,
        xxen_ar_arxagrw_pkg.bucket_days_from(0),
        xxen_ar_arxagrw_pkg.bucket_days_to(0),
        ps.due_date,
        xxen_ar_arxagrw_pkg.bucket_category,
        :p_in_as_of_date_low
      ) b0,
     arpt_sql_func_util.bucket_function
      ( xxen_ar_arxagrw_pkg.bucket_line_type(1),
        ps.amount_in_dispute,
        ps.amount_adjusted_pending,
        xxen_ar_arxagrw_pkg.bucket_days_from(1),
        xxen_ar_arxagrw_pkg.bucket_days_to(1),
        ps.due_date,
        xxen_ar_arxagrw_pkg.bucket_category,:p_in_as_of_date_low
      ) b1,
     arpt_sql_func_util.bucket_function
      ( xxen_ar_arxagrw_pkg.bucket_line_type(2),
        ps.amount_in_dispute,
        ps.amount_adjusted_pending,
        xxen_ar_arxagrw_pkg.bucket_days_from(2),
        xxen_ar_arxagrw_pkg.bucket_days_to(2),
        ps.due_date,
        xxen_ar_arxagrw_pkg.bucket_category,
        :p_in_as_of_date_low
      ) b2,
     arpt_sql_func_util.bucket_function
      ( xxen_ar_arxagrw_pkg.bucket_line_type(3),
        ps.amount_in_dispute,
        ps.amount_adjusted_pending,
        xxen_ar_arxagrw_pkg.bucket_days_from(3),
        xxen_ar_arxagrw_pkg.bucket_days_to(3),
        ps.due_date,
        xxen_ar_arxagrw_pkg.bucket_category,
        :p_in_as_of_date_low
      ) b3,
     arpt_sql_func_util.bucket_function
      ( xxen_ar_arxagrw_pkg.bucket_line_type(4),
        ps.amount_in_dispute,
        ps.amount_adjusted_pending,
        xxen_ar_arxagrw_pkg.bucket_days_from(4),
        xxen_ar_arxagrw_pkg.bucket_days_to(4),
        ps.due_date,
        xxen_ar_arxagrw_pkg.bucket_category,
        :p_in_as_of_date_low
      ) b4,
     arpt_sql_func_util.bucket_function
      ( xxen_ar_arxagrw_pkg.bucket_line_type(5),
        ps.amount_in_dispute,
        ps.amount_adjusted_pending,
        xxen_ar_arxagrw_pkg.bucket_days_from(5),
        xxen_ar_arxagrw_pkg.bucket_days_to(5),
        ps.due_date,
        xxen_ar_arxagrw_pkg.bucket_category,
        :p_in_as_of_date_low
      ) b5,
     arpt_sql_func_util.bucket_function
      ( xxen_ar_arxagrw_pkg.bucket_line_type(6),
        ps.amount_in_dispute,
        ps.amount_adjusted_pending,
        xxen_ar_arxagrw_pkg.bucket_days_from(6),
        xxen_ar_arxagrw_pkg.bucket_days_to(6),
        ps.due_date,
        xxen_ar_arxagrw_pkg.bucket_category,
        :p_in_as_of_date_low
      ) b6,
     app.code_combination_id,
     app.chart_of_accounts_id,
     ci.cons_billing_number cons_billing_number,
     initcap(:p_payment_meaning),
     gsob.currency_code functional_currency,
     gsob.name ledger,
     ps.org_id
    from
     hz_cust_accounts cust_acct,
     hz_parties party,
     ar_payment_schedules ps,
     ar_cons_inv ci,
     ra_salesreps_all sales,
     jtf_rs_resource_extns_vl jrrev,
     hz_cust_site_uses site,
     hz_cust_acct_sites acct_site,
     hz_party_sites party_site,
     hz_locations loc,
     ar_cash_receipts acr,
     gl_sets_of_books gsob,
     (
      select
       c.code_combination_id,
       c.chart_of_accounts_id,
       ps.payment_schedule_id payment_schedule_id,
       decode(app.applied_payment_schedule_id,   -4,   'CLAIM',   ps.class) class,
       app.acctd_amount_applied_from acctd_amount,
       app.amount_applied amount,
       app.status status
      from
       ar_receivable_applications app,
       gl_code_combinations c,
       ar_payment_schedules ps
      where
          app.gl_date <= :p_in_as_of_date_low
      --and upper(RTRIM(RPAD(:p_in_summary_option_low,1)))  = 'I'
      and xxen_ar_arxagrw_pkg.include_org_id(ps.org_id) = 'Y'
      and ps.cash_receipt_id = app.cash_receipt_id
      and app.code_combination_id = c.code_combination_id
      and app.status in ( 'ACC', 'UNAPP', 'UNID','OTHER ACC')
      and nvl(app.confirmed_flag, 'Y') = 'Y'
      and ps.gl_date_closed  > :p_in_as_of_date_low
      and ((app.reversal_gl_date is not null and
            ps.gl_date <= :p_in_as_of_date_low
           ) or
           app.reversal_gl_date is null
          )
      and decode(upper(:p_in_currency), null, ps.invoice_currency_code, upper(:p_in_currency)) = ps.invoice_currency_code
      and nvl( ps.receipt_confirmed_flag, 'Y' ) = 'Y'
      &lp_bal_seg_low
      &lp_bal_seg_high
      and app.org_id = ps.org_id
     ) app
    where
        ps.payment_schedule_id = app.payment_schedule_id
    and ps.customer_id = cust_acct.cust_account_id(+)
    and cust_acct.party_id = party.party_id(+)
    and ps.customer_site_use_id = site.site_use_id(+)
    and site.cust_acct_site_id = acct_site.cust_acct_site_id(+)
    and acct_site.party_site_id = party_site.party_site_id(+)
    and loc.location_id(+) = party_site.location_id
    and acr.cash_receipt_id = ps.cash_receipt_id
    and gsob.set_of_books_id = acr.set_of_books_id
    &lp_customer_name_low
    &lp_customer_name_high
    &lp_customer_num_low
    &lp_customer_num_high
    and ps.cons_inv_id = ci.cons_inv_id(+)
    and sales.salesrep_id = -3
    and sales.org_id  = ps.org_id
    and jrrev.resource_id = sales.resource_id
    and nvl(sales.name,jrrev.resource_name) between nvl(:p_in_salesrep_name_low,nvl(sales.name,jrrev.resource_name))
                                                and nvl(:p_in_salesrep_name_high,nvl(sales.name,jrrev.resource_name))
    and site.org_id (+) = ps.org_id
    group by
     party.party_name,
     cust_acct.account_number,
     site.site_use_id,
     nvl(sales.name,jrrev.resource_name),
     nvl(sales.salesrep_id,-3),
     loc.state,
     loc.city,
     acct_site.cust_acct_site_id,
     cust_acct.cust_account_id,
     ps.payment_schedule_id,
     ps.due_date,
     ps.trx_number,
     ps.amount_due_original,
     ps.amount_adjusted,
     ps.amount_applied,
     ps.amount_credited,
     ps.gl_date,
     ps.amount_in_dispute,
     ps.amount_adjusted_pending,
     ps.invoice_currency_code,
     ps.exchange_rate,
     app.class,
     app.code_combination_id,
     app.chart_of_accounts_id,
     decode( app.status, 'UNID', 'UNID','OTHER ACC','OTHER ACC','UNAPP'),
     ci.cons_billing_number ,
     initcap(:p_payment_meaning),
     gsob.currency_code,
     gsob.name,
     ps.org_id
    union all
    select
     substrb(nvl(party.party_name, :p_short_unid_phrase),1,50) cust_name,
     cust_acct.account_number cust_no,
     nvl(sales.name,jrrev.resource_name),
     initcap(:p_risk_meaning),
     nvl(sales.salesrep_id,-3),
     site.site_use_id,
     loc.state cust_state,
     loc.city cust_city,
     decode(decode(upper(RTRIM(RPAD(:p_in_format_option_low, 1))),'D','D',NULL),NULL,-1,acct_site.cust_acct_site_id) addr_id,
     nvl(cust_acct.cust_account_id, -999) cust_id,
     ps.payment_schedule_id,
     initcap(:p_risk_meaning),
     ps.due_date,
     decode(nvl2(:p_in_currency,'N','Y'), 'Y', ps.amount_due_original * nvl(ps.exchange_rate, 1), ps.amount_due_original) amt_due_original,
     xxen_ar_arxagrw_pkg.comp_amt_due_remainingformula
      ( initcap(:p_risk_meaning),
        initcap(:p_risk_meaning),
        ps.payment_schedule_id,
        decode( nvl2(:p_in_currency,'N','Y'), 'Y', crh.acctd_amount, crh.amount), -- amount due remaining
        ps.amount_applied,
        ps.amount_credited,
        ps.amount_adjusted
      )  amt_due_remaining,
     ps.trx_number,
     ceil(:p_in_as_of_date_low - ps.due_date),
     ps.amount_adjusted,
     ps.amount_applied,
     ps.amount_credited,
     crh.gl_date,
     decode(ps.invoice_currency_code, gsob.currency_code, NULL, decode(crh.exchange_rate, NULL, '*', NULL)),
     nvl(crh.exchange_rate, 1),
     arpt_sql_func_util.bucket_function
      ( xxen_ar_arxagrw_pkg.bucket_line_type(0),
        0,
        0,
        xxen_ar_arxagrw_pkg.bucket_days_from(0),
        xxen_ar_arxagrw_pkg.bucket_days_to(0),
        ps.due_date,
        xxen_ar_arxagrw_pkg.bucket_category,
        :p_in_as_of_date_low
      ) b0,
     arpt_sql_func_util.bucket_function
      ( xxen_ar_arxagrw_pkg.bucket_line_type(1),
        0,
        0,
        xxen_ar_arxagrw_pkg.bucket_days_from(1),
        xxen_ar_arxagrw_pkg.bucket_days_to(1),
        ps.due_date,
        xxen_ar_arxagrw_pkg.bucket_category,
        :p_in_as_of_date_low
      ) b1,
     arpt_sql_func_util.bucket_function
      ( xxen_ar_arxagrw_pkg.bucket_line_type(2),
        0,
        0,xxen_ar_arxagrw_pkg.bucket_days_from(2),
        xxen_ar_arxagrw_pkg.bucket_days_to(2),
        ps.due_date,
        xxen_ar_arxagrw_pkg.bucket_category,
        :p_in_as_of_date_low
      ) b2,
     arpt_sql_func_util.bucket_function
      ( xxen_ar_arxagrw_pkg.bucket_line_type(3),
        0,
        0,
        xxen_ar_arxagrw_pkg.bucket_days_from(3),
        xxen_ar_arxagrw_pkg.bucket_days_to(3),
        ps.due_date,
        xxen_ar_arxagrw_pkg.bucket_category,
        :p_in_as_of_date_low
      ) b3,
     arpt_sql_func_util.bucket_function
      ( xxen_ar_arxagrw_pkg.bucket_line_type(4),
        0,
        0,
        xxen_ar_arxagrw_pkg.bucket_days_from(4),
        xxen_ar_arxagrw_pkg.bucket_days_to(4),
        ps.due_date,
        xxen_ar_arxagrw_pkg.bucket_category,
        :p_in_as_of_date_low
      ) b4,
     arpt_sql_func_util.bucket_function
      ( xxen_ar_arxagrw_pkg.bucket_line_type(5),
        0,
        0,
        xxen_ar_arxagrw_pkg.bucket_days_from(5),
        xxen_ar_arxagrw_pkg.bucket_days_to(5),
        ps.due_date,
        xxen_ar_arxagrw_pkg.bucket_category,
        :p_in_as_of_date_low
      ) b5,
     arpt_sql_func_util.bucket_function
      ( xxen_ar_arxagrw_pkg.bucket_line_type(6),
        0,
        0,
        xxen_ar_arxagrw_pkg.bucket_days_from(6),
        xxen_ar_arxagrw_pkg.bucket_days_to(6),
        ps.due_date,
        xxen_ar_arxagrw_pkg.bucket_category,
        :p_in_as_of_date_low
      ) b6,
     c.code_combination_id,
     c.chart_of_accounts_id,
     ci.cons_billing_number  cons_billing_number,
     initcap(:p_risk_meaning),
     gsob.currency_code functional_currency,
     gsob.name ledger,
     ps.org_id
    from
     hz_cust_accounts cust_acct,
     hz_parties party,
     ar_payment_schedules ps,
     ar_cons_inv ci,
     hz_cust_site_uses site,
     hz_cust_acct_sites acct_site,
     hz_party_sites party_site,
     hz_locations loc,
     ar_cash_receipts cr,
     ar_cash_receipt_history crh,
     gl_code_combinations c,
     ra_salesreps_all sales,
     jtf_rs_resource_extns_vl jrrev,
  
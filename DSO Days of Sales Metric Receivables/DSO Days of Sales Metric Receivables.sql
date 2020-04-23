/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DSO - Days of Sales Metric Receivables
-- Description: **The DSO financial indicator shows both the age in days of an organization's accounts receivables,and the average time it takes to turn those  receivables into cash.
 
The balance is expressed in terms of recent sales, and it is compared to industry and organization averages and standard selling terms.
Several methods exist for calculating DSO. It reflects the organization's internal collection efficiencies, and it requires three pieces of information for calculation:

  Total receivables for the period analyzed.
  Total credit sales for the period analyzed.
  The number of days in the period analyzed.
  
Here is the formula for the standard (regular) DSO calculation:
(Total Receivables / Total Credit Sales) ? Number of Days = Regular DSO

Here is an example scenario:

Total Receivables = 4,600,000 USD.

Total Credit Sales = 9,000,000 USD.

Number of days in period = 90.

Here is the calculation:
(4,600,000 / 9,000,000) ? 90 = 45 days
In this example, it takes 45 days (on the average) to collect the receivables. **/
-- Excel Examle Output: https://www.enginatics.com/example/dso-days-of-sales-metric-receivables
-- Library Link: https://www.enginatics.com/reports/dso-days-of-sales-metric-receivables
-- Run Report: https://demo.enginatics.com/


select
    round((sum(apsa.amount_due_remaining) / sum(apsa.amount_due_original)) * :days) "Days of Sales Outstanding",
   round(sum(apsa.amount_due_remaining)) "Outstanding Receivables",
  --  round(sum(apsa.amount_due_original)) "Total Credit Sales",
  --  round(sum(apsa.amount_applied)) "Amount Applied",
    --   hca.account_number,
 -- period_name,
   --hp.party_name,
  -- apsa.trx_number,
       --acctd_amount_due_remaining,
       haou.name ou
       --apsa.invoice_currency_code,
       --apsa.class,
       --apsa.customer_id,
       --gp.period_name                              
  from ar_payment_schedules_all     apsa,
       gl_periods                   gp,
       gl_ledgers                   gl,
       ra_customer_trx_all          rcta,
       ra_cust_trx_types_all        rctta,
       hz_cust_accounts             hca,
       hz_parties                   hp,
       hz_cust_site_uses_all        hcsua,
       hz_cust_acct_sites_all       hcasa,
       hz_party_sites               hps,
       hr_all_organization_units    haou
 where 1 = 1
      --and apsa.invoice_currency_code = 'usd'
   and apsa.class in ('INV', 'DM', 'CB', 'DEP', 'BR')
   and gl.period_set_name = gp.period_set_name
   and apsa.org_id = haou.organization_id
   and gl.accounted_period_type = gp.period_type
   and apsa.customer_id = hca.cust_account_id(+)
   and hca.party_id = hp.party_id(+)
   and apsa.customer_site_use_id = hcsua.site_use_id(+)
   and hcsua.cust_acct_site_id = hcasa.cust_acct_site_id(+)
   and hcasa.party_site_id = hps.party_site_id(+)
   and apsa.gl_date between gp.start_date and gp.end_date
      --and payment_schedule_id = 265579
   and rcta.customer_trx_id = apsa.customer_trx_id(+)
   and rcta.cust_trx_type_id = rctta.cust_trx_type_id
   and rcta.org_id = rctta.org_id
   and gl.ledger_id = rcta.set_of_books_id
   and apsa.AMOUNT_DUE_REMAINING <> 0
   and haou.name = 'Vision Communications (USA)'
 -- and period_name like 'Jan-20'
 group by 
 
 apsa.invoice_currency_code,
          haou.name
  --      apsa.trx_number,
 --     apsa.trx_date,
  --        apsa.class,
 --         apsa.customer_id,
 --      gp.period_name,
 --         hca.account_number,
  --    hp.party_name
 --         apsa.AMOUNT_DUE_REMAINING ,
  --        apsa.amount_due_original
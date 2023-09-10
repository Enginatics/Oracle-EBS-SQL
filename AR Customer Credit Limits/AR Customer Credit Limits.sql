/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Customer Credit Limits
-- Description: Master data report for customer setup audit of credit amount limits and GL accounts for customer credit management and dunning notices.
-- Excel Examle Output: https://www.enginatics.com/example/ar-customer-credit-limits/
-- Library Link: https://www.enginatics.com/reports/ar-customer-credit-limits/
-- Run Report: https://demo.enginatics.com/

select
x.party_name,
x.currency_code,
&column_party
&column_account
&column_site_use
--
&lp_rec_open_bal_cols
&lp_oe_open_bal_cols
&lp_tot_open_bal_cols
--
x.party_number
from
(
select
haouv.name operating_unit,
hp.party_name,
hp.party_number,
hca.account_number,
fc.currency_code,
hcsua.location,
hcsua.site_use_code,
hcasa.party_site_id,
hp.party_id,
hca.cust_account_id,
hcsua.site_use_id,
(select hcp.cust_account_profile_id from hz_customer_profiles hcp where hp.party_id=hcp.party_id and hcp.cust_account_id=-1) party_level_id,
(select hcp.cust_account_profile_id from hz_customer_profiles hcp where hca.cust_account_id=hcp.cust_account_id and hcp.site_use_id is null) account_level_id,
(select hcp.cust_account_profile_id from hz_customer_profiles hcp where hcsua.site_use_id=hcp.site_use_id) site_use_level_id
from
hr_all_organization_units_vl haouv,
hz_parties hp,
(select hca.* from hz_cust_accounts hca where :display_level in ('Account','Site Use','All')) hca,
(select hcasa.* from hz_cust_acct_sites_all hcasa where :display_level in ('Site Use','All')) hcasa,
(select hcsua.* from hz_cust_site_uses_all hcsua where :display_level in ('Site Use','All')) hcsua,
fnd_currencies fc
where
1=1 and
hp.party_id in (
select
hca1.party_id
from
mo_glob_org_access_tmp mgoat,
hz_cust_acct_sites_all hcasa1,
hz_cust_accounts hca1
where
3=3 and
mgoat.organization_id=hcasa1.org_id and
hcasa1.cust_account_id=hca1.cust_account_id and
hcasa1.status='A' and
hca1.status='A'
) and
hp.party_id=hca.party_id(+) and
hca.cust_account_id=hcasa.cust_account_id(+) and
hcasa.org_id=haouv.organization_id(+) and
hcasa.cust_acct_site_id=hcsua.cust_acct_site_id(+) and
(decode(:display_level,'Site Use',nvl(hcasa.org_id,-1),hcasa.org_id) is null or hcasa.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual))
) x,
hz_cust_profile_amts hcpa0,
hz_cust_profile_amts hcpa1,
hz_cust_profile_amts hcpa2,
hz_party_sites hps,
hz_locations hl,
fnd_territories_tl ftt,
--
(select
  hp.party_id,
  case when :display_level in ('Account','Site Use','All') then apsa.customer_id else -999 end customer_id,
  case when :display_level in ('Site Use','All') then apsa.customer_site_use_id else -999 end customer_site_use_id,
  apsa.invoice_currency_code,
  sum(apsa.amount_due_remaining) receivables_balance,
  sum(apsa.acctd_amount_due_remaining) acctd_receivables_balance
 from
  ar_payment_schedules_all apsa,
  hr_all_organization_units_vl haouv,
  hz_cust_accounts hca,
  hz_parties hp
 where
  apsa.status = 'OP' and
  apsa.org_id = haouv.organization_id and
  apsa.customer_id = hca.cust_account_id and
  hca.party_id = hp.party_id and
  :p_show_open_rec_bal_flag is not null and
  apsa.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual) and
  2=2
 group by
  hp.party_id,
  case when :display_level in ('Account','Site Use','All') then apsa.customer_id else -999 end,
  case when :display_level in ('Site Use','All') then apsa.customer_site_use_id else -999 end,
  apsa.invoice_currency_code
) apsa,
(select
  hp.party_id,
  case when :display_level in ('Account','Site Use','All') then ooha.sold_to_org_id else -999 end customer_id,
  case when :display_level in ('Site Use','All') then ooha.invoice_to_org_id else -999 end customer_site_use_id,
  ooha.transactional_curr_code order_currency_code,
  sum(round(oola.ordered_quantity * oola.unit_selling_price,2)) sales_orders_balance,
  sum(round((oola.ordered_quantity * oola.unit_selling_price) *
  case when ooha.transactional_curr_code = gsob.currency_code
  then 1
  else nvl(ooha.conversion_rate,(select gl_currency_api.get_closest_rate(gsob.set_of_books_id, ooha.transactional_curr_code, trunc(sysdate), gdct.conversion_type,365) from gl_daily_conversion_types gdct where gdct.user_conversion_type = nvl(:p_exchange_rate_type,'Corporate')))
  end, 2)) acctd_sales_orders_balance
 from
  oe_order_headers_all ooha,
  oe_order_lines_all oola,
  hz_cust_accounts hca,
  hz_parties hp,
  hr_operating_units haouv,
  gl_sets_of_books gsob
where
  ooha.header_id = oola.header_id and
  ooha.sold_to_org_id = hca.cust_account_id and
  hca.party_id = hp.party_id and
  ooha.org_id = haouv.organization_id and
  haouv.set_of_books_id = gsob.set_of_books_id and
  ooha.booked_flag = 'Y' and
  ooha.open_flag = 'Y' and
  ooha.cancelled_flag = 'N' and
  oola.open_flag = 'Y' and
  oola.cancelled_flag = 'N' and
  nvl(oola.invoice_interface_status_code,'?') != 'NOT_ELIGIBLE' and
  not exists
  (select
    null
   from
    ra_customer_trx_lines_all rctla
   where
    rctla.interface_line_context = 'ORDER ENTRY' and
    rctla.interface_line_attribute6 = to_char(oola.line_id) and
    rctla.sales_order = to_char(ooha.order_number) and
    rctla.line_type = 'LINE'
  ) and
  :p_show_open_oe_bal_flag is not null and
  ooha.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual) and
  2=2
group by
  hp.party_id,
  case when :display_level in ('Account','Site Use','All') then ooha.sold_to_org_id else -999 end,
  case when :display_level in ('Site Use','All') then ooha.invoice_to_org_id else -999 end,
  ooha.transactional_curr_code
) oola
where
(
(:display_level in ('All','Party') and
 (hcpa0.auto_rec_min_receipt_amount is not null or
  hcpa0.overall_credit_limit is not null or
  hcpa0.trx_credit_limit is not null or
  hcpa0.min_statement_amount is not null or
  hcpa0.min_dunning_amount is not null or
  hcpa0.min_dunning_invoice_amount is not null
 )
) or
(:display_level in ('All','Account') and
 (hcpa1.auto_rec_min_receipt_amount is not null or
  hcpa1.overall_credit_limit is not null or
  hcpa1.trx_credit_limit is not null or
  hcpa1.min_statement_amount is not null or
  hcpa1.min_dunning_amount is not null or
  hcpa1.min_dunning_invoice_amount is not null
 )
) or
(:display_level in ('All','Site Use') and
 (hcpa2.auto_rec_min_receipt_amount is not null or
  hcpa2.overall_credit_limit is not null or
  hcpa2.trx_credit_limit is not null or
  hcpa2.min_statement_amount is not null or
  hcpa2.min_dunning_amount is not null or
  hcpa2.min_dunning_invoice_amount is not null
 )
)
) and
x.party_level_id=hcpa0.cust_account_profile_id(+) and
x.account_level_id=hcpa1.cust_account_profile_id(+) and
x.site_use_level_id=hcpa2.cust_account_profile_id(+) and
x.currency_code=hcpa0.currency_code(+) and
x.currency_code=hcpa1.currency_code(+) and
x.currency_code=hcpa2.currency_code(+) and
x.party_site_id=hps.party_site_id(+) and
hps.location_id=hl.location_id(+) and
hl.country=ftt.territory_code(+) and
ftt.language(+)=userenv('lang') and
--
apsa.party_id (+) = x.party_id and
apsa.invoice_currency_code (+) = x.currency_code and
apsa.customer_id (+) = nvl(x.cust_account_id,-999) and
apsa.customer_site_use_id (+) = nvl(x.site_use_id,-999) and
oola.party_id (+) = x.party_id and
oola.order_currency_code (+) = x.currency_code and
oola.customer_id (+) = nvl(x.cust_account_id,-999) and
oola.customer_site_use_id (+) = nvl(x.site_use_id,-999)
order by
x.party_name,
hl.country,
x.account_number,
hps.party_site_number,
x.operating_unit,
x.currency_code
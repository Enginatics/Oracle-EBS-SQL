/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Customer Credit Snapshot
-- Description: Application: Receivables
Source: Customer Credit Snapshot (XML)
Short Name: ARXCCS_XML
DB package: AR_ARXCCS_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/ar-customer-credit-snapshot/
-- Library Link: https://www.enginatics.com/reports/ar-customer-credit-snapshot/
-- Run Report: https://demo.enginatics.com/

with q_cust as
(
select
 sob.name ledger,
 haouv.name operating_unit,
 sob.currency_code functional_currency,
 cur.precision functional_currency_precision,
 sob.set_of_books_id,
 param.org_id qcust_org_id,
 cust_acct.cust_account_id customer_id,
 cust_acct.account_number customer_number,
 party.party_name customer_name,
 round((trunc(sysdate) - cust_acct.creation_date)/365,1) customer_age,
 round((trunc(sysdate) - acct_site.creation_date)/365,1) address_age,
 acct_site.cust_acct_site_id address_id,
 loc.address1 address1,
 loc.address2 address2,
 loc.address3 address3,
 loc.address4 address4,
 decode(loc.city, null, null, loc.city || ',') city,
 nvl(loc.state, loc.province) state,
 loc.postal_code postal_code,
 terr.territory_short_name country,
 site_uses.site_use_id site_use_id,
 site_uses.location location,
 site_uses.primary_flag,
 hcpc.name profile_class,
 cp.cust_account_profile_id customer_profile_id,
 cp.statement_cycle_id,
 ar_arxccs_xmlp_pkg.c_last_credit_memo_formulaform(sob.currency_code,cust_acct.cust_account_id, site_uses.site_use_id) c_last_credit_memo_formula,
 ar_arxccs_xmlp_pkg.c_data_not_foundformula(substrb ( party.party_name , 1 , 50 )) c_data_not_found,
 ar_arxccs_xmlp_pkg.c_customer_ageformula(round ( ( trunc ( sysdate ) - cust_acct.creation_date ) / 365 , 1 )) c_customer_age,
 ar_arxccs_xmlp_pkg.sel_contactformula(acct_site.cust_acct_site_id) sel_contact,
 ar_arxccs_xmlp_pkg.c_address_ageformula(round ( ( trunc ( sysdate ) - acct_site.creation_date ) / 365 , 1 )) c_address_age,
 ar_arxccs_xmlp_pkg.c_city_state_zipformula(decode ( loc.city , null , null , loc.city || ',' ), nvl ( loc.state , loc.province ), loc.postal_code) c_city_state_zip,
 ar_arxccs_xmlp_pkg.c_credit_summaryformula(cust_acct.cust_account_id, site_uses.site_use_id) c_credit_summary,
 ar_arxccs_xmlp_pkg.c_last_invoice_formulaformula(sob.currency_code, cust_acct.cust_account_id, site_uses.site_use_id) c_last_invoice_formula,
 ar_arxccs_xmlp_pkg.c_guarantee_formulaformula(sob.currency_code, cust_acct.cust_account_id, site_uses.site_use_id) c_guarantee_formula,
 ar_arxccs_xmlp_pkg.c_last_deposit_formulaformula(sob.currency_code, cust_acct.cust_account_id, site_uses.site_use_id) c_last_deposit_formula,
 ar_arxccs_xmlp_pkg.c_last_dm_formulaformula(sob.currency_code, cust_acct.cust_account_id, site_uses.site_use_id) c_last_dm_formula,
 ar_arxccs_xmlp_pkg.c_last_cb_formulaformula(sob.currency_code, cust_acct.cust_account_id, site_uses.site_use_id) c_last_cb_formula,
 ar_arxccs_xmlp_pkg.c_last_payment_formulaformula(sob.currency_code, cust_acct.cust_account_id, site_uses.site_use_id) c_last_payment_formula,
 ar_arxccs_xmlp_pkg.c_last_adj_formulaformula(sob.currency_code, cust_acct.cust_account_id, site_uses.site_use_id) c_last_adj_formula,
 ar_arxccs_xmlp_pkg.c_last_writeoff_formulaformula(sob.currency_code, cust_acct.cust_account_id, site_uses.site_use_id) c_last_writeoff_formula,
 ar_arxccs_xmlp_pkg.c_last_statement_formulaformul(cust_acct.cust_account_id, site_uses.site_use_id) c_last_statement_formula,
 ar_arxccs_xmlp_pkg.c_last_dn_formulaformula(cust_acct.cust_account_id, site_uses.site_use_id) c_last_dn_formula,
 ar_arxccs_xmlp_pkg.c_last_nsf_formulaformula(sob.currency_code, cust_acct.cust_account_id, site_uses.site_use_id) c_last_nsf_formula,
 ar_arxccs_xmlp_pkg.c_last_contact_formulaformula(sob.currency_code, cust_acct.cust_account_id, site_uses.site_use_id) c_last_contact_formula,
 ar_arxccs_xmlp_pkg.c_last_hold_formulaformula(cust_acct.cust_account_id, site_uses.site_use_id) c_last_hold_formula,
 ar_arxccs_xmlp_pkg.c_contact_p c_contact,
 ar_arxccs_xmlp_pkg.c_phone_number_p c_phone_number,
 ar_arxccs_xmlp_pkg.c_profile_site_use_id_p c_profile_site_use_id,
 ar_arxccs_xmlp_pkg.c_customer_profile_id_p c_customer_profile_id,
 ar_arxccs_xmlp_pkg.c_cred_summ_collector_p c_cred_summ_collector,
 ar_arxccs_xmlp_pkg.c_cred_summ_exempt_dun_p c_cred_summ_exempt_dun,
 ar_arxccs_xmlp_pkg.c_cred_summ_terms_p c_cred_summ_terms,
 ar_arxccs_xmlp_pkg.c_cred_summ_account_status_p c_cred_summ_account_status,
 ar_arxccs_xmlp_pkg.c_cred_summ_credit_hold_p c_cred_summ_credit_hold,
 ar_arxccs_xmlp_pkg.c_cred_summ_risk_code_p c_cred_summ_risk_code,
 ar_arxccs_xmlp_pkg.c_cred_summ_credit_rating_p c_cred_summ_credit_rating,
 ar_arxccs_xmlp_pkg.c_cred_summ_limit_tolerance_p c_cred_summ_limit_tolerance,
 ar_arxccs_xmlp_pkg.c_cred_summ_lt_exp_date_p c_cred_summ_limit_expire_date,
 ar_arxccs_xmlp_pkg.c_last_invoice_days_since_p c_last_invoice_days_since,
 ar_arxccs_xmlp_pkg.c_last_invoice_date_p c_last_invoice_date,
 ar_arxccs_xmlp_pkg.c_last_invoice_converted_p c_last_invoice_converted,
 ar_arxccs_xmlp_pkg.c_last_invoice_amount_p c_last_invoice_amount,
 ar_arxccs_xmlp_pkg.c_last_invoice_currency_p c_last_invoice_currency,
 ar_arxccs_xmlp_pkg.c_last_invoice_type_p c_last_invoice_type,
 ar_arxccs_xmlp_pkg.c_last_invoice_number_p c_last_invoice_number,
 ar_arxccs_xmlp_pkg.c_last_cm_rel_invoice_p c_last_cm_rel_invoice,
 ar_arxccs_xmlp_pkg.c_last_cm_converted_p c_last_cm_converted,
 ar_arxccs_xmlp_pkg.c_last_cm_amount_p c_last_cm_amount,
 ar_arxccs_xmlp_pkg.c_last_cm_id_p c_last_cm_id,
 ar_arxccs_xmlp_pkg.c_last_cm_prev_trx_p c_last_cm_prev_trx,
 ar_arxccs_xmlp_pkg.c_last_cm_days_since_p c_last_cm_days_since,
 ar_arxccs_xmlp_pkg.c_last_cm_date_p c_last_cm_date,
 ar_arxccs_xmlp_pkg.c_last_cm_currency_p c_last_cm_currency,
 ar_arxccs_xmlp_pkg.c_last_cm_type_p c_last_cm_type,
 ar_arxccs_xmlp_pkg.c_last_guar_days_since_p c_last_guar_days_since,
 ar_arxccs_xmlp_pkg.c_last_guar_date_p c_last_guar_date,
 ar_arxccs_xmlp_pkg.c_last_guar_converted_p c_last_guar_converted,
 ar_arxccs_xmlp_pkg.c_last_guar_amount_p c_last_guar_amount,
 ar_arxccs_xmlp_pkg.c_last_guar_currency_p c_last_guar_currency,
 ar_arxccs_xmlp_pkg.c_last_guar_type_p c_last_guar_type,
 ar_arxccs_xmlp_pkg.c_last_guar_number_p c_last_guar_number,
 ar_arxccs_xmlp_pkg.c_last_dep_days_since_p c_last_dep_days_since,
 ar_arxccs_xmlp_pkg.c_last_dep_date_p c_last_dep_date,
 ar_arxccs_xmlp_pkg.c_last_dep_converted_p c_last_dep_converted,
 ar_arxccs_xmlp_pkg.c_last_dep_amount_p c_last_dep_amount,
 ar_arxccs_xmlp_pkg.c_last_dep_currency_p c_last_dep_currency,
 ar_arxccs_xmlp_pkg.c_last_dep_type_p c_last_dep_type,
 ar_arxccs_xmlp_pkg.c_last_dep_number_p c_last_dep_number,
 ar_arxccs_xmlp_pkg.c_last_dm_days_since_p c_last_dm_days_since,
 ar_arxccs_xmlp_pkg.c_last_dm_date_p c_last_dm_date,
 ar_arxccs_xmlp_pkg.c_last_dm_converted_p c_last_dm_converted,
 ar_arxccs_xmlp_pkg.c_last_dm_amount_p c_last_dm_amount,
 ar_arxccs_xmlp_pkg.c_last_dm_currency_p c_last_dm_currency,
 ar_arxccs_xmlp_pkg.c_last_dm_type_p c_last_dm_type,
 ar_arxccs_xmlp_pkg.c_last_dm_number_p c_last_dm_number,
 ar_arxccs_xmlp_pkg.c_last_cb_days_since_p c_last_cb_days_since,
 ar_arxccs_xmlp_pkg.c_last_cb_date_p c_last_cb_date,
 ar_arxccs_xmlp_pkg.c_last_cb_converted_p c_last_cb_converted,
 ar_arxccs_xmlp_pkg.c_last_cb_amount_p c_last_cb_amount,
 ar_arxccs_xmlp_pkg.c_last_cb_currency_p c_last_cb_currency,
 ar_arxccs_xmlp_pkg.c_last_cb_type_p c_last_cb_type,
 ar_arxccs_xmlp_pkg.c_last_cm_number_p c_last_cm_number,
 ar_arxccs_xmlp_pkg.c_last_cb_number_p c_last_cb_number,
 ar_arxccs_xmlp_pkg.c_last_payment_rel_invoice_p c_last_payment_rel_invoice,
 ar_arxccs_xmlp_pkg.c_last_payment_days_since_p c_last_payment_days_since,
 ar_arxccs_xmlp_pkg.c_last_payment_date_p c_last_payment_date,
 ar_arxccs_xmlp_pkg.c_last_payment_converted_p c_last_payment_converted,
 ar_arxccs_xmlp_pkg.c_last_payment_amount_p c_last_payment_amount,
 ar_arxccs_xmlp_pkg.c_last_payment_currency_p c_last_payment_currency,
 ar_arxccs_xmlp_pkg.c_last_payment_type_p c_last_payment_type,
 ar_arxccs_xmlp_pkg.c_last_payment_number_p c_last_payment_number,
 ar_arxccs_xmlp_pkg.c_last_adj_days_since_p c_last_adj_days_since,
 ar_arxccs_xmlp_pkg.c_last_adj_date_p c_last_adj_date,
 ar_arxccs_xmlp_pkg.c_last_adj_converted_p c_last_adj_converted,
 ar_arxccs_xmlp_pkg.c_last_adj_amount_p c_last_adj_amount,
 ar_arxccs_xmlp_pkg.c_last_adj_currency_p c_last_adj_currency,
 ar_arxccs_xmlp_pkg.c_last_adj_rel_invoice_p c_last_adj_rel_invoice,
 ar_arxccs_xmlp_pkg.c_last_adj_type_p c_last_adj_type,
 ar_arxccs_xmlp_pkg.c_last_adj_number_p c_last_adj_number,
 ar_arxccs_xmlp_pkg.c_last_wo_days_since_p c_last_wo_days_since,
 ar_arxccs_xmlp_pkg.c_last_wo_date_p c_last_wo_date,
 ar_arxccs_xmlp_pkg.c_last_wo_converted_p c_last_wo_converted,
 ar_arxccs_xmlp_pkg.c_last_wo_amount_p c_last_wo_amount,
 ar_arxccs_xmlp_pkg.c_last_wo_currency_p c_last_wo_currency,
 ar_arxccs_xmlp_pkg.c_last_wo_rel_invoice_p c_last_wo_rel_invoice,
 ar_arxccs_xmlp_pkg.c_last_wo_type_p c_last_wo_type,
 ar_arxccs_xmlp_pkg.c_last_wo_number_p c_last_wo_number,
 ar_arxccs_xmlp_pkg.c_last_stmnt_next_trx_date_p c_last_stmnt_next_trx_date,
 ar_arxccs_xmlp_pkg.c_last_st_date_p c_last_st_date,
 ar_arxccs_xmlp_pkg.c_last_st_type_p c_last_st_type,
 ar_arxccs_xmlp_pkg.c_last_st_number_p c_last_st_number,
 ar_arxccs_xmlp_pkg.c_last_st_days_since_p c_last_st_days_since,
 ar_arxccs_xmlp_pkg.c_last_dn_days_since_p c_last_dn_days_since,
 ar_arxccs_xmlp_pkg.c_last_dn_date_p c_last_dn_date,
 ar_arxccs_xmlp_pkg.c_last_dn_currency_p c_last_dn_currency,
 ar_arxccs_xmlp_pkg.c_last_dn_amount_p c_last_dn_amount,
 ar_arxccs_xmlp_pkg.c_last_dn_type_p c_last_dn_type,
 ar_arxccs_xmlp_pkg.c_last_dn_number_p c_last_dn_number,
 ar_arxccs_xmlp_pkg.c_last_nsf_currency_p c_last_nsf_currency,
 ar_arxccs_xmlp_pkg.c_last_nsf_days_since_p c_last_nsf_days_since,
 ar_arxccs_xmlp_pkg.c_last_nsf_date_p c_last_nsf_date,
 ar_arxccs_xmlp_pkg.c_last_nsf_converted_p c_last_nsf_converted,
 ar_arxccs_xmlp_pkg.c_last_nsf_amount_p c_last_nsf_amount,
 ar_arxccs_xmlp_pkg.c_last_nsf_type_p c_last_nsf_type,
 ar_arxccs_xmlp_pkg.c_last_nsf_number_p c_last_nsf_number,
 ar_arxccs_xmlp_pkg.c_last_contact_days_since_p c_last_contact_days_since,
 ar_arxccs_xmlp_pkg.c_last_contact_date_p c_last_contact_date,
 ar_arxccs_xmlp_pkg.c_last_contact_amount_p c_last_contact_amount,
 ar_arxccs_xmlp_pkg.c_last_contact_converted_p c_last_contact_converted,
 ar_arxccs_xmlp_pkg.c_last_contact_currency_p c_last_contact_currency,
 ar_arxccs_xmlp_pkg.c_last_contact_rel_invoice_p c_last_contact_rel_invoice,
 ar_arxccs_xmlp_pkg.c_last_contact_number_p c_last_contact_number,
 ar_arxccs_xmlp_pkg.c_last_hold_days_since_p c_last_hold_days_since,
 ar_arxccs_xmlp_pkg.c_last_hold_date_p c_last_hold_date,
 ar_arxccs_xmlp_pkg.c_last_hold_amount_p c_last_hold_amount,
 ar_arxccs_xmlp_pkg.c_last_hold_number_p c_last_hold_number
from
 ar_system_parameters_all param,
 gl_sets_of_books sob,
 hr_all_organization_units_vl haouv,
 fnd_currencies cur,
 hz_cust_accounts cust_acct,
 hz_parties party,
 hz_cust_acct_sites acct_site,
 hz_party_sites party_site,
 hz_locations loc,
 hz_cust_site_uses site_uses,
 fnd_territories_vl terr,
 ar_collectors coll,
 hz_customer_profiles cp,
 hz_cust_profile_classes hcpc
where
 1=1 and
 param.set_of_books_id = sob.set_of_books_id and
 param.org_id = haouv.organization_id (+) and
 sob.currency_code = cur.currency_code and
 cp.cust_account_id = cust_acct.cust_account_id and
 cust_acct.party_id = party.party_id and
 cp.collector_id = coll.collector_id and
 cust_acct.cust_account_id = acct_site.cust_account_id and
 nvl(param.org_id,-99) = nvl(acct_site.org_id,-99) and
 site_uses.cust_acct_site_id = acct_site.cust_acct_site_id and
 nvl(site_uses.org_id,-99) = nvl(acct_site.org_id,-99) and
 site_uses.status = 'A' and
 acct_site.party_site_id = party_site.party_site_id and
 loc.location_id = party_site.location_id and
 site_uses.site_use_code = 'BILL_TO' and
 site_uses.status = 'A' and
 loc.country = terr.territory_code and
 cp.cust_account_profile_id =
  (select
    max(cp2.cust_account_profile_id)
   from
    hz_customer_profiles cp2
   where
    cust_acct.cust_account_id = cp2.cust_account_id and
    (site_uses.site_use_id = cp2.site_use_id or cp2.site_use_id is null )
  ) and
 cp.profile_class_id = hcpc.profile_class_id
 &p_org_where_param
),
q_currencies as
(
 select
 hca.cust_account_id customer_id,
 hcsua.site_use_id site_use_id,
 hcsua.org_id org_id,
 hcpa.cust_account_profile_id,
 hcpa.currency_code
 from
 hz_cust_accounts hca,
 hz_cust_acct_sites_all hcasa,
 hz_cust_site_uses_all hcsua,
 hz_cust_profile_amts hcpa
 where
 hca.cust_account_id = hcasa.cust_account_id and
 hcasa.cust_acct_site_id = hcsua.cust_acct_site_id and
 nvl(hcasa.org_id,-99) = nvl(hcsua.org_id,-99) and
 hca.cust_account_id = hcpa.cust_account_id and
 hcpa.cust_account_profile_id =
 (select
  max(hcp2.cust_account_profile_id)
  from
  hz_customer_profiles hcp2
  where
  hcp2.cust_account_id = hca.cust_account_id and
  (hcp2.site_use_id = hcsua.site_use_id or hcp2.site_use_id is null )
 )
 union
 select
 apsa.customer_id,
 apsa.customer_site_use_id,
 apsa.org_id,
 hcp.cust_account_profile_id,
 apsa.invoice_currency_code
 from
 ar_payment_schedules_all apsa,
 hz_customer_profiles hcp
 where
 apsa.class not in ('CM', 'PMT') and
 apsa.customer_id = hcp.cust_account_id and
 hcp.cust_account_profile_id =
 (select
  max(hcp2.cust_account_profile_id)
  from
  hz_customer_profiles hcp2
  where
  hcp2.cust_account_id = apsa.customer_id and
  (hcp2.site_use_id = apsa.customer_site_use_id or hcp2.site_use_id is null )
 )
),
q_buckets as
(
 select
  ps.customer_id ps_customer_id,
  ps.customer_site_use_id ps_site_use_id,
  ps.org_id ps_org_id,
  ps.invoice_currency_code currency_bucket,
  sum(ps.amount_due_remaining) aging_balance_outstanding,
  sum(decode(:rp_bucket_line_type_0,
             'DISPUTE_ONLY',   decode(nvl(ps.amount_in_dispute,0),0,0,1),
             'PENDADJ_ONLY',   decode(nvl(ps.amount_adjusted_pending,0),0,0,1),
             'DISPUTE_PENDADJ',decode(nvl(ps.amount_in_dispute,0), 0,decode(nvl(ps.amount_adjusted_pending,0),0,0,1), 1),
                               case when ceil(trunc(sysdate)-ps.due_date) between to_number(:rp_bucket_days_from_0) and to_number(:rp_bucket_days_to_0) then 1 else 0 end
                               * decode(nvl(ps.amount_in_dispute,0), 0, 1, decode('', 'DISPUTE_ONLY', 0, 'DISPUTE_PENDADJ', 0, 1))
                               * decode(nvl(ps.amount_adjusted_pending,0), 0, 1, decode('', 'PENDADJ_ONLY', 0, 'DISPUTE_PENDADJ', 0, 1))
            )
      * ps.amount_due_remaining * 1
  ) total_cust_b0,
  sum(decode(:rp_bucket_line_type_1,
             'DISPUTE_ONLY',   decode(nvl(ps.amount_in_dispute,0),0,0,1),
             'PENDADJ_ONLY',   decode(nvl(ps.amount_adjusted_pending,0),0,0,1),
             'DISPUTE_PENDADJ',decode(nvl(ps.amount_in_dispute,0), 0,decode(nvl(ps.amount_adjusted_pending,0),0,0,1), 1),
                               case when ceil(trunc(sysdate)-ps.due_date) between to_number(:rp_bucket_days_from_1) and to_number(:rp_bucket_days_to_1) then 1 else 0 end
                               * decode(nvl(ps.amount_in_dispute,0), 0, 1, decode('', 'DISPUTE_ONLY', 0, 'DISPUTE_PENDADJ', 0, 1))
                               * decode(nvl(ps.amount_adjusted_pending,0), 0, 1, decode('', 'PENDADJ_ONLY', 0, 'DISPUTE_PENDADJ', 0, 1))
            )
      * ps.amount_due_remaining * 1
  ) total_cust_b1,
  sum(decode(:rp_bucket_line_type_2,
             'DISPUTE_ONLY',   decode(nvl(ps.amount_in_dispute,0),0,0,1),
             'PENDADJ_ONLY',   decode(nvl(ps.amount_adjusted_pending,0),0,0,1),
             'DISPUTE_PENDADJ',decode(nvl(ps.amount_in_dispute,0), 0,decode(nvl(ps.amount_adjusted_pending,0),0,0,1), 1),
                               case when ceil(trunc(sysdate)-ps.due_date) between to_number(:rp_bucket_days_from_2) and to_number(:rp_bucket_days_to_2) then 1 else 0 end
                               * decode(nvl(ps.amount_in_dispute,0), 0, 1, decode('', 'DISPUTE_ONLY', 0, 'DISPUTE_PENDADJ', 0, 1))
                               * decode(nvl(ps.amount_adjusted_pending,0), 0, 1, decode('', 'PENDADJ_ONLY', 0, 'DISPUTE_PENDADJ', 0, 1))
            )
      * ps.amount_due_remaining * 1
  ) total_cust_b2,
  sum(decode(:rp_bucket_line_type_3,
             'DISPUTE_ONLY',   decode(nvl(ps.amount_in_dispute,0),0,0,1),
             'PENDADJ_ONLY',   decode(nvl(ps.amount_adjusted_pending,0),0,0,1),
             'DISPUTE_PENDADJ',decode(nvl(ps.amount_in_dispute,0), 0,decode(nvl(ps.amount_adjusted_pending,0),0,0,1), 1),
                               case when ceil(trunc(sysdate)-ps.due_date) between to_number(:rp_bucket_days_from_3) and to_number(:rp_bucket_days_to_3) then 1 else 0 end
                               * decode(nvl(ps.amount_in_dispute,0), 0, 1, decode('', 'DISPUTE_ONLY', 0, 'DISPUTE_PENDADJ', 0, 1))
                               * decode(nvl(ps.amount_adjusted_pending,0), 0, 1, decode('', 'PENDADJ_ONLY', 0, 'DISPUTE_PENDADJ', 0, 1))
            )
      * ps.amount_due_remaining * 1
  ) total_cust_b3,
  sum(decode(:rp_bucket_line_type_4,
             'DISPUTE_ONLY',   decode(nvl(ps.amount_in_dispute,0),0,0,1),
             'PENDADJ_ONLY',   decode(nvl(ps.amount_adjusted_pending,0),0,0,1),
             'DISPUTE_PENDADJ',decode(nvl(ps.amount_in_dispute,0), 0,decode(nvl(ps.amount_adjusted_pending,0),0,0,1), 1),
                               case when ceil(trunc(sysdate)-ps.due_date) between to_number(:rp_bucket_days_from_4) and to_number(:rp_bucket_days_to_4) then 1 else 0 end
                               * decode(nvl(ps.amount_in_dispute,0), 0, 1, decode('', 'DISPUTE_ONLY', 0, 'DISPUTE_PENDADJ', 0, 1)) *
                                 decode(nvl(ps.amount_adjusted_pending,0), 0, 1, decode('', 'PENDADJ_ONLY', 0, 'DISPUTE_PENDADJ', 0, 1))
            )
      * ps.amount_due_remaining * 1
  ) total_cust_b4,
  sum(decode(:rp_bucket_line_type_5,
             'DISPUTE_ONLY',   decode(nvl(ps.amount_in_dispute,0),0,0,1),
             'PENDADJ_ONLY',   decode(nvl(ps.amount_adjusted_pending,0),0,0,1),
             'DISPUTE_PENDADJ',decode(nvl(ps.amount_in_dispute,0), 0,decode(nvl(ps.amount_adjusted_pending,0),0,0,1), 1),
                               case when ceil(trunc(sysdate)-ps.due_date) between to_number(:rp_bucket_days_from_5) and to_number(:rp_bucket_days_to_5) then 1 else 0 end
                                       * decode(nvl(ps.amount_in_dispute,0), 0, 1, decode('', 'DISPUTE_ONLY', 0, 'DISPUTE_PENDADJ', 0, 1))
                                       * decode(nvl(ps.amount_adjusted_pending,0), 0, 1, decode('', 'PENDADJ_ONLY', 0, 'DISPUTE_PENDADJ', 0, 1))
            )
      * ps.amount_due_remaining * 1
  ) total_cust_b5,
  sum(decode(:rp_bucket_line_type_6,
             'DISPUTE_ONLY',   decode(nvl(ps.amount_in_dispute,0),0,0,1),
             'PENDADJ_ONLY',   decode(nvl(ps.amount_adjusted_pending,0),0,0,1),
             'DISPUTE_PENDADJ',decode(nvl(ps.amount_in_dispute,0), 0,decode(nvl(ps.amount_adjusted_pending,0),0,0,1), 1),
                               case when ceil(trunc(sysdate)-ps.due_date) between to_number(:rp_bucket_days_from_6) and to_number(:rp_bucket_days_to_6) then 1 else 0 end
                               * decode(nvl(ps.amount_in_dispute,0), 0, 1, decode('', 'DISPUTE_ONLY', 0, 'DISPUTE_PENDADJ', 0, 1)) *
                               decode(nvl(ps.amount_adjusted_pending,0), 0, 1, decode('', 'PENDADJ_ONLY', 0, 'DISPUTE_PENDADJ', 0, 1))
            )
      * ps.amount_due_remaining * 1
  ) total_cust_b6
 from
  ar_payment_schedules_all ps
 where
  ps.class not in ('CM', 'PMT')
  &p_org_where_ps
 group by
  ps.customer_id,
  ps.customer_site_use_id,
  ps.org_id,
  ps.invoice_currency_code
),
q_stmt_cycles as
(
 select distinct
 astc.statement_cycle_id,
 first_value(astc.name) over (partition by astc.statement_cycle_id order by astcd.statement_date desc,astcd.statement_cycle_date_id desc) statement_type,
 first_value(astcd.statement_date) over (partition by astc.statement_cycle_id order by astcd.statement_date desc,astcd.statement_cycle_date_id desc) statement_date,
 trunc(trunc(sysdate) - first_value(astcd.statement_date) over (partition by astc.statement_cycle_id order by astcd.statement_date desc,astcd.statement_cycle_date_id desc)) days_since
 from
 ar_statement_cycles astc,
 ar_statement_cycle_dates astcd
 where
 astc.statement_cycle_id = astcd.statement_cycle_id and
 astcd.printed = 'Y'
)
--
-- select main query starts here
select /*+ ordered push_pred(curr) push_pred(qb) push_pred(qsc) */
 qc.ledger,
 qc.operating_unit,
 qc.functional_currency,
 -- function call ensures the placeholder columns are populated
 nvl2(qc.c_credit_summary ||
      qc.sel_contact ||
      qc.c_last_invoice_formula ||
      qc.c_last_credit_memo_formula ||
      qc.c_guarantee_formula ||
      qc.c_last_deposit_formula ||
      qc.c_last_dm_formula ||
      qc.c_last_cb_formula ||
      qc.c_last_payment_formula ||
      qc.c_last_adj_formula ||
      qc.c_last_writeoff_formula ||
      qc.c_last_statement_formula ||
      qc.c_last_dn_formula ||
      qc.c_last_nsf_formula ||
      qc.c_last_contact_formula ||
      qc.c_last_hold_formula,
      qc.customer_name,
      qc.customer_name
     ) customer_name,
 qc.customer_number customer_number,
 --
 qc.location,
 qc.address1,
 qc.address2,
 qc.address3,
 qc.address4,
 qc.city,
 qc.state,
 qc.postal_code,
 qc.country,
 --qc.c_city_state_zip,
 qc.c_contact contact,
 qc.c_phone_number phone_number,
 qc.c_customer_age customer_age,
 qc.c_address_age address_age,
 --
 -- Customer Level Credit Summary
 --
 --qc.c_credit_summary,
 qc.profile_class,
 nvl2(qc.c_profile_site_use_id,'Site','Account') profile_level,
 qc.c_cred_summ_limit_tolerance credit_tolerance,
 qc.c_cred_summ_credit_rating credit_rating,
 qc.c_cred_summ_risk_code risk_code,
 qc.c_cred_summ_credit_hold credit_hold,
 qc.c_cred_summ_account_status account_status,
 qc.c_cred_summ_terms standard_terms,
 qc.c_cred_summ_exempt_dun exempt_from_dunning,
 qc.c_cred_summ_collector collector,
 --qc.c_cred_summ_limit_expire_date,
 --
 -- Currency
 --
 -- the function calls are required to populate the place holder columns
 nvl2(ar_arxccs_xmlp_pkg.cf_currency_lookupformula(hcpa.cust_account_id, curr.currency_code, hcpa.site_use_id, qc.site_use_id) ||
      ar_arxccs_xmlp_pkg.c_currency_lookupformula(qc.site_use_id, curr.currency_code) ||
      ar_arxccs_xmlp_pkg.c_credit_amounts_calcformu0114(qc.customer_id, qc.site_use_id,qc.functional_currency,curr.currency_code,hcpa.overall_credit_limit) ||
      ar_arxccs_xmlp_pkg.c_compute_amtformula(qc.functional_currency, qc.customer_id, qc.site_use_id, curr.currency_code, qb.aging_balance_outstanding) ||
      ar_arxccs_xmlp_pkg.c_high_inv_formulaformula(qc.functional_currency, qc.customer_id, qc.site_use_id, curr.currency_code) ||
      ar_arxccs_xmlp_pkg.c_rolling_summary_calcformula(qc.functional_currency, qc.customer_id, qc.site_use_id, curr.currency_code),
      curr.currency_code,curr.currency_code
      ) currency,
 --
 -- G_CREDIT_LIMITS
 --
 hcpa.overall_credit_limit credit_limit, -- 1,
 case when hcpa.currency_code is not null
 then case when hcpa.overall_credit_limit is null then ar_arxccs_xmlp_pkg.rp_no_limit_p end
 else ar_arxccs_xmlp_pkg.rp_no_limit_p
 end no_credit_limit,
 hcpa.trx_credit_limit order_credit_limit, -- 1,
 case when hcpa.currency_code is not null then ar_arxccs_xmlp_pkg.c_cred_summ_available1_p end available_credit, -- c_cred_summ_available1,
 case when hcpa.currency_code is not null then ar_arxccs_xmlp_pkg.c_cred_summ_exceeded1_p end exceeded_credit_amount, -- c_cred_summ_exceeded1,
 case when hcpa.currency_code is not null then ar_arxccs_xmlp_pkg.default_flag_p end default_flag, -- default_flag,
 --
 -- G_BUCKETS
 --
 -- aging
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.cp_default_flag_p end default_flag,
 case when qb.currency_bucket is not null then qb.aging_balance_outstanding end aging_outstanding_balance,
 &lp_aging_amount_cols
 &lp_aging_percent_cols
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.c_aging_credit_p end  aging_on_account_credit, -- c_aging_credit,
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.c_aging_unapplied_p end  aging_unapplied_cash, -- c_aging_unapplied,
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.c_aging_on_account_p end  aging_on_account_cash, -- c_aging_on_account,
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.c_adjusted_balance_p end  aging_adjusted_balance, -- c_adjusted_balance,
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.c_aging_in_collection_p end  aging_in_collection, -- c_aging_in_collection,
 -- customer history
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.c_cust_hist_high_invoice_amt_p end  hist_largest_invoice_amount, -- c_cust_hist_high_invoice_amt,
 case when qb.currency_bucket is not null then to_date(ar_arxccs_xmlp_pkg.c_cust_hist_high_inv_date_p) end  hist_largest_invoice_date, -- c_cust_hist_high_invoice_date,
 -- not using these function as it contains a bug compared to the rdf version
 --  ar_arxccs_xmlp_pkg.c_cust_hist_high_limit_amtform(qc.customer_id, qc.site_use_id)  c_cust_hist_high_limit_amt,
 --  ar_arxccs_xmlp_pkg.c_cust_hist_high_limit_date_p) c_cust_hist_high_limit_date,
 case when qb.currency_bucket is not null
 then
   --nvl(
    (select
     max(h.credit_limit)
     from
     ar_credit_histories h
     where
     h.customer_id = qc.customer_id and
     (h.site_use_id = qc.site_use_id or
      (h.site_use_id is null and not exists (select 1 from ar_credit_histories h2 where h2.site_use_id = qc.site_use_id and h2.customer_id = qc.customer_id)
      )
     ) and
     nvl(h.credit_limit,0) != 0
    )
   --,decode(nvl(hcpa.overall_credit_limit,0),0,to_number(null),hcpa.overall_credit_limit)
   --)
 end hist_highest_credit_limit,
 case when qb.currency_bucket is not null
 and (select
      max(h.credit_limit)
      from
      ar_credit_histories h
      where
      h.customer_id = qc.customer_id and
      (h.site_use_id = qc.site_use_id or
       (h.site_use_id is null and not exists (select 1 from ar_credit_histories h2 where h2.site_use_id = qc.site_use_id and h2.customer_id = qc.customer_id)
       )
      ) and
      nvl(h.credit_limit,0) != 0
     ) is null
 then ar_arxccs_xmlp_pkg.rp_no_limit_p
 else null
 end hist_highest_no_credit_limit,
 case when qb.currency_bucket is not null
 then
   --nvl(
    (select distinct
     first_value(trunc(h.last_update_date)) over (order by h.credit_limit desc range between unbounded preceding and unbounded following)
     from
     ar_credit_histories h
     where
     h.customer_id = qc.customer_id and
     (h.site_use_id = qc.site_use_id or
      (h.site_use_id is null and not exists (select 1 from ar_credit_histories h2 where h2.site_use_id = qc.site_use_id and h2.customer_id = qc.customer_id)
      )
     ) and
     nvl(h.credit_limit,0) != 0
    )
    --,decode(nvl(hcpa.overall_credit_limit,0),0,to_date(null),trunc(hcpa.last_update_date))
   --)
 end hist_highest_credit_limit_date,
 --
 -- 12mth rolling summary
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.c_ytd_sales_amount_p end   sales_amount, -- c_ytd_sales_amount,
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.c_ytd_payment_amount_p end  payments_amount, -- c_ytd_payment_amount,
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.c_ytd_credit_amount_p end  credits_amount, -- c_ytd_credit_amount,
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.c_ytd_finance_charge_amount_p end  finance_changes_amount, -- c_ytd_finance_charge_amount,
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.c_ytd_writeoff_amount_p end  written_off_amount, -- c_ytd_writeoff_amount,
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.c_ytd_earned_discount_amount_p end  earned_discounts_amount, -- c_ytd_earned_discount_amount,
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.c_ytd_unearned_discount_amoun end  unearned_discounts_amount, -- c_ytd_unearned_discount_amount,
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.c_ytd_nsf_amount_p end  nsf_stop_payments_amount, -- c_ytd_nsf_amount,
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.c_ytd_sales_count_p end  sales_count, -- c_ytd_sales_count,
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.c_ytd_payment_count_p end  payments_count, -- c_ytd_payment_count,
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.c_ytd_credit_count_p end  credits_count, -- c_ytd_credit_count,
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.c_ytd_finance_charge_count_p end  finance_changes_count, -- c_ytd_finance_charge_count,
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.c_ytd_nsf_count_p end  nsf_stop_payments_count, -- c_ytd_nsf_count ,
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.c_ytd_late_payments_count_p end  late_payments_count, -- c_ytd_late_payments_count,
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.c_ytd_on_time_payments_count_p end  on_time_payments_count, -- c_ytd_on_time_payments_count,
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.c_ytd_average_payment_days_p end  average_payment_days, -- c_ytd_average_payment_days,
 case when qb.currency_bucket is not null then ar_arxccs_xmlp_pkg.c_ytd_average_days_late_p end average_days_late, -- c_ytd_average_days_late,
 --
 -- Last Transactions Summary
 --
 --qc.c_last_invoice_formula,
 qc.c_last_invoice_number last_invoice_number,
 qc.c_last_invoice_type last_invoice_type,
 qc.c_last_invoice_currency last_invoice_curr,
 qc.c_last_invoice_amount last_invoice_amount,
 to_date(qc.c_last_invoice_date) last_invoice_date,
 qc.c_last_invoice_days_since last_invoice_days_since,
 --qc.c_last_credit_memo_formula,
 qc.c_last_cm_number last_credit_memo_number,
 qc.c_last_cm_type last_credit_memo_type,
 qc.c_last_cm_rel_invoice last_credit_memo_related_inv,
 qc.c_last_cm_currency last_credit_memo_curr,
 qc.c_last_cm_amount last_credit_memo_amount,
 to_date(qc.c_last_cm_date) last_credit_memo_date,
 qc.c_last_cm_days_since last_credit_memo_days_since,
 --qc.c_guarantee_formula,
 qc.c_last_guar_number last_guarantee_number,
 qc.c_last_guar_type last_guarantee_type,
 qc.c_last_guar_currency last_guarantee_curr,
 qc.c_last_guar_amount last_guarantee_amount,
 --qc.c_last_guar_converted last_guarantee_converted,
 to_date(qc.c_last_guar_date) last_guarantee_date,
 qc.c_last_guar_days_since last_guarantee_days_since,
 --qc.c_last_deposit_formula,
 qc.c_last_dep_number last_deposit_number,
 qc.c_last_dep_type last_deposit_type,
 qc.c_last_dep_currency last_deposit_curr,
 qc.c_last_dep_amount last_deposit_amount,
 to_date(qc.c_last_dep_date) last_deposit_date,
 qc.c_last_dep_days_since last_deposit_days_since,
 --qc.c_last_dm_formula,
 qc.c_last_dm_number last_debit_memo_number,
 qc.c_last_dm_type last_debit_memo_type,
 qc.c_last_dm_currency last_debit_memo_curr,
 qc.c_last_dm_amount last_debit_memo_amount,
 to_date(qc.c_last_dm_date) last_debit_memo_date,
 qc.c_last_dm_days_since last_debit_memo_days_since,
 --qc.c_last_cb_formula,
 qc.c_last_cb_number last_charge_back_number,
 qc.c_last_cb_type last_charge_back_type,
 qc.c_last_cb_currency last_charge_back_curr,
 qc.c_last_cb_amount last_charge_back_amount,
 to_date(qc.c_last_cb_date) last_charge_back_date,
 qc.c_last_cb_days_since last_charge_back_days_since,
 --qc.c_last_payment_formula,
 qc.c_last_payment_number last_payment_number,
 qc.c_last_payment_type last_payment_type,
 qc.c_last_payment_rel_invoice last_payment_related_inv,
 qc.c_last_payment_currency last_payment_curr,
 qc.c_last_payment_amount last_payment_amount,
 to_date(qc.c_last_payment_date) last_payment_date,
 qc.c_last_payment_days_since last_payment_days_since,
 --qc.c_last_adj_formula,
 qc.c_last_adj_number last_adjustment_number,
 qc.c_last_adj_type last_adjustment_type,
 qc.c_last_adj_rel_invoice last_adjustment_related_inv,
 qc.c_last_adj_currency last_adjustment_curr,
 qc.c_last_adj_amount last_adjustment_amount,
 to_date(qc.c_last_adj_date) last_adjustment_date,
 qc.c_last_adj_days_since last_adjustment_days_since,
 --qc.c_last_writeoff_formula,
 qc.c_last_wo_number last_writeoff_number,
 qc.c_last_wo_type last_writeoff_type,
 qc.c_last_wo_rel_invoice last_writeoff_related_inv,
 qc.c_last_wo_currency last_writeoff_curr,
 qc.c_last_wo_amount last_writeoff_amount,
 to_date(qc.c_last_wo_date) last_writeoff_date,
 qc.c_last_wo_days_since last_writeoff_days_since,
 /* not using the xml function as it contains a bug */
 --qc.c_last_statement_formula,
 --qc.c_last_st_number last_statement_number,
 -- qc.c_last_st_type last_statement_type,
 -- to_date(qc.c_last_st_date) last_statement_date,
 --qc.c_last_st_days_since last_statement_days_since,
 --to_date(qc.c_last_stmnt_next_trx_date) next_statement_date,

/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: OZF Claims and Deductions
-- Description: Trade Management claims, deductions and overpayments with their type, reason, status, customer, amounts, owner, source transaction and settlement.
-- Days Past Due and Aging Bucket are calculated from the due date as of today, for claims in status New, Open, Complete or Rejected, the claims that Oracle Trade Management ages. Aging Bucket uses the Receivables aging bucket selected in the parameter of the same name. Open Only restricts the report to these claims.
-- The template Pivot: Aging by Customer shows the accounted remaining amount of the open claims by customer and aging bucket, as the claims aging view.
-- Excel Example Output: https://www.enginatics.com/example/ozf-claims-and-deductions/
-- Library Link: https://www.enginatics.com/reports/ozf-claims-and-deductions/
-- Run Report: https://demo.enginatics.com/

select
(select hou.name from hr_operating_units hou where oca.org_id=hou.organization_id) operating_unit,
oca.claim_number,
xxen_util.meaning(oca.claim_class,'OZF_CLAIM_CLASS',682) claim_class,
(select octav.name from ozf_claim_types_all_vl octav where oca.claim_type_id=octav.claim_type_id and oca.org_id=octav.org_id) claim_type,
(select orcav.name from ozf_reason_codes_all_vl orcav where oca.reason_code_id=orcav.reason_code_id) reason,
oca.customer_reason,
(select ausv.name from ams_user_statuses_vl ausv where oca.user_status_id=ausv.user_status_id) claim_status,
hca.account_number customer_number,
hp.party_name customer,
(select hcsua.location from hz_cust_site_uses_all hcsua where oca.cust_billto_acct_site_id=hcsua.site_use_id) bill_to,
(select hcsua.location from hz_cust_site_uses_all hcsua where oca.cust_shipto_acct_site_id=hcsua.site_use_id) ship_to,
oca.customer_ref_number customer_reference,
oca.customer_ref_date customer_reference_date,
oca.claim_date,
oca.due_date,
oca.gl_date,
case when oca.status_code in ('NEW','OPEN','COMPLETE','REJECTED') then trunc(sysdate)-trunc(oca.due_date) end days_past_due,
(
select
aabl.bucket_sequence_num+1||' '||aablt.report_heading1||nvl2(aablt.report_heading2,' '||aablt.report_heading2,null)
from
ar_aging_buckets aab,
ar_aging_bucket_lines_b aabl,
ar_aging_bucket_lines_tl aablt
where
oca.status_code in ('NEW','OPEN','COMPLETE','REJECTED') and
aab.bucket_name=:aging_bucket and
aab.aging_bucket_id=aabl.aging_bucket_id and
trunc(sysdate)-trunc(oca.due_date) between aabl.days_start and aabl.days_to and
aabl.aging_bucket_line_id=aablt.aging_bucket_line_id and
aablt.language=userenv('lang')
) aging_bucket,
oca.currency_code currency,
oca.amount,
oca.amount_adjusted,
oca.amount_settled,
oca.amount_remaining,
oca.acctd_amount accounted_amount,
oca.acctd_amount_remaining accounted_remaining,
(select jrrev.resource_name from jtf_rs_resource_extns_vl jrrev where oca.owner_id=jrrev.resource_id) owner,
(select jrs.name from jtf_rs_salesreps jrs where oca.sales_rep_id=jrs.salesrep_id and oca.org_id=jrs.org_id) salesperson,
(select ac.name from ar_collectors ac where oca.collector_id=ac.collector_id) collector,
xxen_util.meaning(oca.source_object_class,'OZF_CLAIM_SOURCE_OBJECT',682) source_type,
oca.source_object_number source_number,
oca.receipt_number,
xxen_util.meaning(oca.payment_method,'OZF_PAYMENT_METHOD',682) settlement_method,
oca.payment_reference_number settlement_number,
oca.payment_reference_date settlement_date,
xxen_util.meaning(oca.payment_status,'OZF_PAYMENT_STATUS',682) payment_status,
oca.settled_date,
(select oca2.claim_number from ozf_claims_all oca2 where oca.split_from_claim_id=oca2.claim_id) split_from_claim,
oca.comments,
xxen_util.user_name(oca.created_by) created_by,
oca.creation_date,
xxen_util.user_name(oca.last_updated_by) last_updated_by,
oca.last_update_date
from
ozf_claims_all oca,
hz_cust_accounts hca,
hz_parties hp
where
1=1 and
oca.org_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='OU') and
oca.cust_account_id=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+)
&open_only
order by
operating_unit,
oca.claim_date,
oca.claim_number

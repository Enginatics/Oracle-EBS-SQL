/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: IEX Dunning History
-- Description: Dunning letters sent by Advanced Collections, one row per dunning, with the customer, account or bill-to site dunned, the dunning plan, the letter template, the delivery method and the amount due at the time of the dunning.
-- The customer, account and bill-to site are derived from the dunning level: a customer level dunning has no account, and a delinquency level dunning shows the delinquent transaction with its due date and the days past due on the dunning date.
-- Collector is the collector of the bill-to site profile, else of the account profile, else of the party profile.
-- Excel Example Output: https://www.enginatics.com/example/iex-dunning-history/
-- Library Link: https://www.enginatics.com/reports/iex-dunning-history/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
xxen_util.client_time(y.creation_date) dunning_date,
y.correspondence_date,
xxen_util.meaning(y.dunning_level,'IEX_RUNNING_LEVEL',695) dunning_level,
hp.party_name customer,
hp.party_number,
hca.account_number,
hca.account_name,
hcsua.location bill_to_location,
coalesce(
(select ac.name from hz_customer_profiles hcp, ar_collectors ac where y.site_use_id=hcp.site_use_id and hcp.collector_id=ac.collector_id),
(select ac.name from hz_customer_profiles hcp, ar_collectors ac where y.cust_account_id=hcp.cust_account_id and hcp.site_use_id is null and hcp.collector_id=ac.collector_id),
(select ac.name from hz_customer_profiles hcp, ar_collectors ac where y.party_id_=hcp.party_id and hcp.cust_account_id=-1 and hcp.collector_id=ac.collector_id)
) collector,
(select idpv.name from iex_dunning_plans_vl idpv where y.dunning_plan_id=idpv.dunning_plan_id) dunning_plan,
coalesce(
(select xtv.template_name from xdo_templates_vl xtv where y.xml_template_id=xtv.template_id),
(select jfta.template_name from jtf_fm_template_all jfta where y.template_id=jfta.template_id),
y.letter_name
) letter_template,
xxen_util.meaning(y.dunning_method,'IEX_FULFILLMENT_SEND_METHOD',695) delivery_method,
y.contact_destination,
(select hp2.party_name from hz_parties hp2 where y.contact_party_id=hp2.party_id) contact,
xxen_util.meaning(y.status,'IEX_DUNNING_STATUS',695) status,
xxen_util.meaning(y.dunning_mode,'IEX_DUNNING_MODE',695) dunning_mode,
xxen_util.meaning(y.confirmation_mode,'IEX_CONFIRMATION_MODE',695) confirmation_mode,
y.delivery_status,
y.amount_due_remaining amount_due,
y.financial_charge,
y.interest_amt interest_amount,
y.currency_code currency,
apsa.trx_number transaction_number,
xxen_util.meaning(apsa.class,'INV/CM/ADJ',222) transaction_class,
apsa.due_date,
trunc(y.creation_date)-apsa.due_date days_past_due,
apsa.amount_due_remaining transaction_amount_due,
nullif(y.request_id,-1) request_id,
y.xml_request_id delivery_request_id,
y.dunning_id
from
(
select
x.*,
coalesce(x.cust_account_id_,(select hcasa.cust_account_id from hz_cust_site_uses_all hcsua, hz_cust_acct_sites_all hcasa where x.site_use_id=hcsua.site_use_id and hcsua.cust_acct_site_id=hcasa.cust_acct_site_id)) cust_account_id
from
(
select
id.*,
decode(id.dunning_level,'CUSTOMER',id.dunning_object_id,'DELINQUENCY',ida.party_cust_id) party_id_,
decode(id.dunning_level,'ACCOUNT',id.dunning_object_id,'DELINQUENCY',ida.cust_account_id) cust_account_id_,
decode(id.dunning_level,'BILL_TO',id.dunning_object_id,'DELINQUENCY',ida.customer_site_use_id) site_use_id,
ida.payment_schedule_id
from
iex_dunnings id,
iex_delinquencies_all ida
where
2=2 and
(id.org_id is null or id.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)) and
id.delinquency_id=ida.delinquency_id(+)
) x
) y,
hr_all_organization_units_vl haouv,
hz_cust_accounts hca,
hz_parties hp,
hz_cust_site_uses_all hcsua,
ar_payment_schedules_all apsa
where
1=1 and
y.org_id=haouv.organization_id(+) and
y.cust_account_id=hca.cust_account_id(+) and
nvl(y.party_id_,hca.party_id)=hp.party_id and
y.site_use_id=hcsua.site_use_id(+) and
y.payment_schedule_id=apsa.payment_schedule_id(+)
order by
hp.party_name,
hca.account_number,
y.creation_date,
y.dunning_id

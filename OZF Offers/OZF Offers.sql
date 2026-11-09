/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: OZF Offers
-- Description: Trade Management offers with their type, status, dates, owner, market eligibility and budget source, and the amounts of the offer checkbook in the offer currency: committed, utilized, earned, paid and unpaid.
-- Committed is the approved budget requests less the transfers back to the budget. Utilized, Earned and Paid follow the rules of OZF Budget Utilization. The report lists the offers that the Advanced Pricing operating unit security allows: global offers and the offers of the operating units the responsibility can access.
-- Excel Example Output: https://www.enginatics.com/example/ozf-offers/
-- Library Link: https://www.enginatics.com/reports/ozf-offers/
-- Run Report: https://demo.enginatics.com/

select
(select hou.name from hr_operating_units hou where qlhv.orig_org_id=hou.organization_id) operating_unit,
oo.offer_code,
qlhv.description offer_name,
xxen_util.meaning(oo.offer_type,'OZF_OFFER_TYPE',682) offer_type,
(select ausv.name from ams_user_statuses_vl ausv where oo.user_status_id=ausv.user_status_id) offer_status,
qlhv.start_date_active start_date,
qlhv.end_date_active end_date,
xxen_util.yes(qlhv.active_flag) active,
(select jrrev.resource_name from jtf_rs_resource_extns_vl jrrev where oo.owner_id=jrrev.resource_id) owner,
xxen_util.meaning(oo.qualifier_type,'OZF_OFFER_DEAL_CUSTOMER_TYPES',682) market_type,
case
when oo.qualifier_type='CUSTOMER' then (select hp.party_name from hz_cust_accounts hca, hz_parties hp where oo.qualifier_id=hca.cust_account_id and hca.party_id=hp.party_id)
when oo.qualifier_type in ('CUSTOMER_BILL_TO','SHIP_TO') then (select hp.party_name||' - '||hcsua.location from hz_cust_site_uses_all hcsua, hz_cust_acct_sites_all hcasa, hz_cust_accounts hca, hz_parties hp where oo.qualifier_id=hcsua.site_use_id and hcsua.cust_acct_site_id=hcasa.cust_acct_site_id and hcasa.cust_account_id=hca.cust_account_id and hca.party_id=hp.party_id)
when oo.qualifier_type='BUYER' then (select hp.party_name from hz_parties hp where oo.qualifier_id=hp.party_id)
end market,
oo.customer_reference,
xxen_util.meaning(oo.budget_source_type,'OZF_FUND_SOURCE',682) budget_source_type,
case oo.budget_source_type when 'FUND' then (select fav.short_name from ozf_funds_all_vl fav where oo.budget_source_id=fav.fund_id) end budget_source,
oo.transaction_currency_code currency,
oo.budget_amount_tc budget_amount,
c.committed_amount committed,
u.utilized_amount utilized,
u.earned_amount earned,
u.paid_amount paid,
u.earned_amount-nvl(u.paid_amount,0) unpaid,
xxen_util.yes(oo.autopay_flag) autopay,
xxen_util.user_name(oo.created_by) created_by,
oo.creation_date,
xxen_util.user_name(oo.last_updated_by) last_updated_by,
oo.last_update_date
from
ozf_offers oo,
qp_list_headers_vl qlhv,
(
select
decode(oab.transfer_type,'TRANSFER',oab.budget_source_id,oab.act_budget_used_by_id) qp_list_header_id,
sum(decode(oab.transfer_type,'REQUEST',oab.approved_amount,-oab.approved_original_amount)) committed_amount
from
ozf_act_budgets oab
where
oab.transfer_type in ('REQUEST','TRANSFER') and
oab.status_code='APPROVED' and
oab.parent_act_budget_id is null and
oab.arc_act_budget_used_by<>oab.budget_source_type and
decode(oab.transfer_type,'TRANSFER',oab.budget_source_type,oab.arc_act_budget_used_by)='OFFR'
group by
decode(oab.transfer_type,'TRANSFER',oab.budget_source_id,oab.act_budget_used_by_id)
) c,
(
select
y.plan_id,
sum(y.utilized_amount) utilized_amount,
sum(y.earned_amount) earned_amount,
sum(y.paid_amount) paid_amount
from
(
select
fuab.plan_id,
fuab.plan_curr_amount utilized_amount,
case when nvl(fuab.gl_posted_flag,'Y')='Y' then fuab.plan_curr_amount end earned_amount,
case when fuab.utilization_type='UTILIZED' and nvl(fuab.gl_posted_flag,'Y')='Y' then fuab.plan_curr_amount-nvl(fuab.plan_curr_amount_remaining,0) end paid_amount
from
ozf_funds_utilized_all_b fuab
where
fuab.plan_type='OFFR' and
fuab.utilization_type in ('UTILIZED','ACCRUAL','ADJUSTMENT','CHARGEBACK','LEAD_ACCRUAL','LEAD_ADJUSTMENT')
union all
select
fuab.plan_id,
to_number(null) utilized_amount,
to_number(null) earned_amount,
oclua.plan_curr_amount paid_amount
from
ozf_claims_all oca,
ozf_claim_lines_all ocla,
ozf_claim_lines_util_all oclua,
ozf_funds_utilized_all_b fuab
where
oca.status_code='CLOSED' and
oca.claim_id=ocla.claim_id and
ocla.claim_line_id=oclua.claim_line_id and
oclua.utilization_id=fuab.utilization_id and
fuab.plan_type='OFFR' and
fuab.utilization_type in ('ACCRUAL','ADJUSTMENT','CHARGEBACK','LEAD_ACCRUAL','LEAD_ADJUSTMENT')
) y
group by
y.plan_id
) u
where
1=1 and
oo.qp_list_header_id=qlhv.list_header_id and
oo.qp_list_header_id=c.qp_list_header_id(+) and
oo.qp_list_header_id=u.plan_id(+)
order by
operating_unit,
oo.offer_code

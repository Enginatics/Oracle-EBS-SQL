/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: OZF Budget Utilization
-- Description: Trade Management budget utilization lines, as the utilized, earned and paid checkbooks of a budget: offer accruals, accrual adjustments, off-invoice discounts, chargebacks and referral accruals, with the customer, product and order or transaction they come from.
-- Utilized, Earned, Paid and Unpaid are in the budget currency. Earned excludes lines that are not posted to GL. Paid is the amount settled by closed claims, or for an off-invoice discount the discount itself, and Unpaid is earned less paid. The accounted columns show the same in the ledger currency, with Paid at the exchange rate of the accrual.
-- The totals by budget agree with the Utilized, Earned and Paid amounts of OZF Budgets. The template Pivot: by Customer lists the earned, paid and unpaid amounts by customer and offer, as the promotional payments view.
-- Excel Example Output: https://www.enginatics.com/example/ozf-budget-utilization/
-- Library Link: https://www.enginatics.com/reports/ozf-budget-utilization/
-- Run Report: https://demo.enginatics.com/

select
(select hou.name from hr_operating_units hou where fuab.org_id=hou.organization_id) operating_unit,
fav.fund_number budget_number,
fav.short_name budget_name,
xxen_util.meaning(fuab.plan_type,'OZF_FUND_SOURCE',682) activity_type,
oo.offer_code,
qlht.description offer_name,
xxen_util.meaning(oo.offer_type,'OZF_OFFER_TYPE',682) offer_type,
xxen_util.meaning(fuab.utilization_type,'OZF_UTILIZATION_TYPE',682) utilization_type,
(select octav.name from ozf_claim_types_all_vl octav where fuab.adjustment_type_id=octav.claim_type_id and fuab.org_id=octav.org_id) adjustment_type,
fuab.adjustment_date utilization_date,
fuab.gl_date,
xxen_util.yes(fuab.gl_posted_flag) gl_posted,
hca.account_number customer_number,
hp.party_name customer,
(select hcsua.location from hz_cust_site_uses_all hcsua where fuab.ship_to_site_use_id=hcsua.site_use_id) ship_to,
msiv.concatenated_segments item,
msiv.description item_description,
(select mck.concatenated_segments from mtl_categories_kfv mck where fuab.product_level_type='FAMILY' and fuab.product_id=mck.category_id) category,
(select ooha.order_number from oe_order_headers_all ooha where fuab.object_type in ('ORDER','TP_ORDER') and fuab.object_id=ooha.header_id) order_number,
(select oola.line_number||'.'||oola.shipment_number from oe_order_lines_all oola where fuab.order_line_id=oola.line_id) order_line,
(select rcta.trx_number from ra_customer_trx_all rcta where fuab.object_type in ('CM','DM','INVOICE') and fuab.object_id=rcta.customer_trx_id) transaction_number,
fav.currency_code_tc currency,
fuab.amount utilized,
case when nvl(fuab.gl_posted_flag,'Y')='Y' then fuab.amount end earned,
case when fuab.utilization_type='UTILIZED' then case when nvl(fuab.gl_posted_flag,'Y')='Y' then fuab.amount-nvl(fuab.amount_remaining,0) end else p.paid_amount end paid,
case when nvl(fuab.gl_posted_flag,'Y')='Y' then fuab.amount end-nvl(case when fuab.utilization_type='UTILIZED' then fuab.amount-nvl(fuab.amount_remaining,0) else p.paid_amount end,0) unpaid,
(select gl.currency_code from hr_operating_units hou, gl_ledgers gl where fuab.org_id=hou.organization_id and hou.set_of_books_id=gl.ledger_id) ledger_currency,
case when nvl(fuab.gl_posted_flag,'Y')='Y' then fuab.acctd_amount end accounted_earned,
case when fuab.utilization_type='UTILIZED' then case when nvl(fuab.gl_posted_flag,'Y')='Y' then fuab.acctd_amount-nvl(fuab.acctd_amount_remaining,0) end else p.acctd_paid_amount end accounted_paid,
case when nvl(fuab.gl_posted_flag,'Y')='Y' then fuab.acctd_amount end-nvl(case when fuab.utilization_type='UTILIZED' then fuab.acctd_amount-nvl(fuab.acctd_amount_remaining,0) else p.acctd_paid_amount end,0) accounted_unpaid,
xxen_util.user_name(fuab.created_by) created_by,
fuab.creation_date
from
ozf_funds_utilized_all_b fuab,
ozf_funds_all_vl fav,
ozf_offers oo,
qp_list_headers_tl qlht, --not the _vl: the QP org security policy on qp_list_headers_b hides offers that are neither global nor of the operating units of the session
hz_cust_accounts hca,
hz_parties hp,
oe_sys_parameters_all ospa,
mtl_system_items_vl msiv,
(
select
oclua.utilization_id,
sum(oclua.util_curr_amount) paid_amount,
sum(nvl(oclua.utilized_acctd_amount,oclua.acctd_amount)) acctd_paid_amount
from
ozf_claims_all oca,
ozf_claim_lines_all ocla,
ozf_claim_lines_util_all oclua
where
oca.status_code='CLOSED' and
oca.claim_id=ocla.claim_id and
ocla.claim_line_id=oclua.claim_line_id
group by
oclua.utilization_id
) p
where
1=1 and
fuab.utilization_type in ('UTILIZED','ACCRUAL','ADJUSTMENT','CHARGEBACK','LEAD_ACCRUAL','LEAD_ADJUSTMENT') and
fuab.org_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='OU') and
fuab.fund_id=fav.fund_id and
decode(fuab.plan_type,'OFFR',fuab.plan_id)=oo.qp_list_header_id(+) and
oo.qp_list_header_id=qlht.list_header_id(+) and
qlht.language(+)=userenv('lang') and
fuab.cust_account_id=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
fuab.org_id=ospa.org_id(+) and
ospa.parameter_code(+)='MASTER_ORGANIZATION_ID' and
decode(fuab.product_level_type,'PRODUCT',fuab.product_id)=msiv.inventory_item_id(+) and
to_number(ospa.parameter_value)=msiv.organization_id(+) and
fuab.utilization_id=p.utilization_id(+)
order by
operating_unit,
fav.fund_number,
oo.offer_code,
fuab.gl_date,
fuab.utilization_id

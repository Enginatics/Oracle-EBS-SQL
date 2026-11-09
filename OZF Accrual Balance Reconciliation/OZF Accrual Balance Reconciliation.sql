/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: OZF Accrual Balance Reconciliation
-- Description: Trade Management accrual balance by offer and customer for a range of GL periods: the opening balance, then the accruals, accrual adjustments and paid amounts of each period, in the ledger currency of the operating unit.
-- Accrual and Adjustment are the offer accruals and accrual adjustments by their GL date. Paid is the earnings paid by closed claims, by the claim's GL date and at the accrual's exchange rate, and is shown negative. Accruals and adjustments that are not posted to GL and claims that are not closed are not included.
-- The opening balance is the total of all three before the first period, so the opening balance plus the period amounts is the balance at the end of Period To.
-- The templates Pivot: by Offer and Pivot: by Customer list offers or customers against periods; their Grand Total column is the closing balance.
-- Excel Example Output: https://www.enginatics.com/example/ozf-accrual-balance-reconciliation/
-- Library Link: https://www.enginatics.com/reports/ozf-accrual-balance-reconciliation/
-- Run Report: https://demo.enginatics.com/

select
y.operating_unit,
y.currency,
oo.offer_code,
qlht.description offer_name,
xxen_util.meaning(oo.offer_type,'OZF_OFFER_TYPE',682) offer_type,
(select ausv.name from ams_user_statuses_vl ausv where oo.user_status_id=ausv.user_status_id) offer_status,
(select ofav.short_name from ozf_funds_all_vl ofav where y.fund_id=ofav.fund_id) budget,
hca.account_number customer_number,
hp.party_name customer,
case y.type_seq
when 1 then '1 '||xxen_report.column_translation('OPENING_BALANCE')
when 2 then '2 '||xxen_util.meaning('PAID','OZF_EARN_AMOUNT_TYPE',682)
when 3 then '3 '||xxen_util.meaning('ACCRUAL','OZF_UTILIZATION_TYPE',682)
when 4 then '4 '||xxen_util.meaning('ADJUSTMENT','OZF_UTILIZATION_TYPE',682)
end type,
case when y.type_seq=1 then fnd_date.date_to_displaydate(y.start_date-1) else to_char(y.period_year)||'-'||lpad(y.period_num,2,'0')||' ('||y.period_name||')' end period,
y.amount
from
(
select
x.operating_unit,
x.currency,
x.plan_id,
x.fund_id,
x.cust_account_id,
x.start_date,
x.type_seq,
gp.period_name,
gp.period_year,
gp.period_num,
sum(x.amount) amount
from
(
select
r.operating_unit,
r.currency,
r.period_set_name,
r.period_type,
r.start_date,
m.plan_id,
m.fund_id,
m.cust_account_id,
case when m.gl_date<r.start_date then 1 else m.type_seq end type_seq,
case when m.gl_date>=r.start_date then m.gl_date end period_date,
m.amount
from
(
select
hou.organization_id org_id,
hou.name operating_unit,
gl.currency_code currency,
gl.period_set_name,
gl.accounted_period_type period_type,
(select gp.start_date from gl_periods gp where gl.period_set_name=gp.period_set_name and gp.period_name=:period_name_from) start_date,
(select gp.end_date from gl_periods gp where gl.period_set_name=gp.period_set_name and gp.period_name=:period_name_to) end_date
from
hr_operating_units hou,
gl_ledgers gl
where
1=1 and
hou.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='OU') and
hou.set_of_books_id=gl.ledger_id
) r,
(
select
fuab.org_id,
fuab.plan_id,
fuab.fund_id,
fuab.cust_account_id,
trunc(fuab.gl_date) gl_date,
decode(fuab.utilization_type,'ACCRUAL',3,4) type_seq,
fuab.acctd_amount amount
from
ozf_funds_utilized_all_b fuab
where
fuab.plan_type='OFFR' and
fuab.utilization_type in ('ACCRUAL','ADJUSTMENT') and
nvl(fuab.gl_posted_flag,'Y')='Y'
union all
select
fuab.org_id,
fuab.plan_id,
fuab.fund_id,
fuab.cust_account_id,
trunc(oca.gl_date) gl_date,
2 type_seq,
-nvl(oclua.utilized_acctd_amount,oclua.acctd_amount) amount
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
fuab.utilization_type in ('ACCRUAL','ADJUSTMENT')
) m
where
r.org_id=m.org_id and
m.gl_date<r.end_date+1
) x,
gl_periods gp
where
x.period_set_name=gp.period_set_name(+) and
x.period_type=gp.period_type(+) and
gp.adjustment_period_flag(+)='N' and
x.period_date>=gp.start_date(+) and
x.period_date<=gp.end_date(+)
group by
x.operating_unit,
x.currency,
x.plan_id,
x.fund_id,
x.cust_account_id,
x.start_date,
x.type_seq,
gp.period_name,
gp.period_year,
gp.period_num
having
sum(x.amount)<>0
) y,
ozf_offers oo,
qp_list_headers_tl qlht, --not the _vl: the QP org security policy on qp_list_headers_b hides offers that are neither global nor of the operating units of the session
hz_cust_accounts hca,
hz_parties hp
where
2=2 and
y.plan_id=oo.qp_list_header_id and
oo.qp_list_header_id=qlht.list_header_id and
qlht.language=userenv('lang') and
y.cust_account_id=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+)
order by
y.operating_unit,
oo.offer_code,
hca.account_number,
y.type_seq,
y.period_year,
y.period_num

/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: OZF Budgets
-- Description: Trade Management budgets with the amounts of the budget checkbook, in the budget currency: original budget, transfers, holdback, planned, committed, available, utilized, earned, paid and unpaid.
-- Total is the original budget plus transfers in less transfers out. Available is the total less holdback and committed. Unpaid is earned less paid. OZF Budget Utilization lists the accruals, adjustments and payments behind Utilized, Earned and Paid.
-- Rollup Amounts shows the amounts of each budget including its child budgets, as the rollup view of the budget checkbook. Quotas are not included.
-- Excel Example Output: https://www.enginatics.com/example/ozf-budgets/
-- Library Link: https://www.enginatics.com/reports/ozf-budgets/
-- Run Report: https://demo.enginatics.com/

select
(select hou.name from hr_operating_units hou where x.org_id=hou.organization_id) operating_unit,
x.fund_number budget_number,
x.short_name budget_name,
x.description budget_description,
xxen_util.meaning(x.fund_type,'OZF_FUND_TYPE',682) budget_type,
(select acv.category_name from ams_categories_vl acv where x.category_id=acv.category_id) budget_category,
(select ausv.name from ams_user_statuses_vl ausv where x.user_status_id=ausv.user_status_id) budget_status,
(select fav.short_name from ozf_funds_all_vl fav where x.parent_fund_id=fav.fund_id) parent_budget,
(select jrrev.resource_name from jtf_rs_resource_extns_vl jrrev where x.owner=jrrev.resource_id) owner,
x.start_date_active start_date,
x.end_date_active end_date,
x.currency_code_tc currency,
x.original_amount original_budget,
x.transfer_in_amount transfers_in,
x.transfer_out_amount transfers_out,
x.original_amount+x.transfer_in_amount-x.transfer_out_amount total,
x.holdback_amount holdback,
x.planned_amount planned,
x.committed_amount committed,
x.original_amount+x.transfer_in_amount-x.transfer_out_amount-x.holdback_amount-x.committed_amount available,
x.recal_committed_amount recalculated_committed,
x.utilized_amount utilized,
x.earned_amount earned,
x.paid_amount paid,
x.earned_amount-x.paid_amount unpaid,
xxen_util.concatenated_segments(x.accrued_liable_account) liability_account,
xxen_util.concatenated_segments(x.ded_adjustment_account) adjustment_account,
xxen_util.user_name(x.created_by) created_by,
x.creation_date,
xxen_util.user_name(x.last_updated_by) last_updated_by,
x.last_update_date
from
(
select
fav.*,
nvl(decode(:rollup,'Y',fav.rollup_original_budget,fav.original_budget),0) original_amount,
nvl(decode(:rollup,'Y',fav.rollup_transfered_in_amt,fav.transfered_in_amt),0) transfer_in_amount,
nvl(decode(:rollup,'Y',fav.rollup_transfered_out_amt,fav.transfered_out_amt),0) transfer_out_amount,
nvl(decode(:rollup,'Y',fav.rollup_holdback_amt,fav.holdback_amt),0) holdback_amount,
nvl(decode(:rollup,'Y',fav.rollup_planned_amt,fav.planned_amt),0) planned_amount,
nvl(decode(:rollup,'Y',fav.rollup_committed_amt,fav.committed_amt),0) committed_amount,
nvl(decode(:rollup,'Y',fav.rollup_recal_committed,fav.recal_committed),0) recal_committed_amount,
nvl(decode(:rollup,'Y',fav.rollup_utilized_amt,fav.utilized_amt),0) utilized_amount,
nvl(decode(:rollup,'Y',fav.rollup_earned_amt,fav.earned_amt),0) earned_amount,
nvl(decode(:rollup,'Y',fav.rollup_paid_amt,fav.paid_amt),0) paid_amount
from
ozf_funds_all_vl fav
where
fav.fund_type in ('FIXED','FULLY_ACCRUED') and
(fav.org_id is null or fav.org_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='OU'))
) x
where
1=1
order by
operating_unit,
x.fund_number

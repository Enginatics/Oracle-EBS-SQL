/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Asset Transfers
-- Description: Asset transfers between distributions (employee, expense account and location), one row per transfer and distribution side.
-- A transfer closes the From distributions and creates the To distributions. Units, cost and reserve are signed, negative on the From side and positive on the To side, so a transfer nets to zero and a sum by cost center, account or location shows what moved in and out.
-- Cost, reserve, depreciation expense and revaluation reserve are the amounts the transfer moved between the distributions in the selected book, taken from its accounting adjustments. A back-dated transfer also moves the depreciation expense of the periods it reaches back to.
-- A partial unit transfer closes the From distribution and recreates it with the remaining units, so the remainder is listed on the To side as well and nets against the closed distribution.
-- Excel Example Output: https://www.enginatics.com/example/fa-asset-transfers/
-- Library Link: https://www.enginatics.com/reports/fa-asset-transfers/
-- Run Report: https://demo.enginatics.com/

select
x.ledger,
x.book,
x.currency,
x.period,
x.asset_number,
x.asset_description,
x.tag_number,
x.serial_number,
x.asset_type,
x.category,
x.transfer_date,
x.transaction_number,
xxen_util.meaning(x.side,'GLJAHE',101) side,
x.units,
papf.full_name employee_name,
papf.employee_number,
gcck.concatenated_segments expense_account,
fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg','SQLGL','GL#',gcck.chart_of_accounts_id,null,gcck.code_combination_id,'FA_COST_CTR','Y','VALUE') cost_center,
flk.concatenated_segments location,
y.cost,
y.reserve,
y.cost-y.reserve net_book_value,
y.depreciation_expense,
y.revaluation_reserve,
x.comments,
xxen_util.user_name(x.last_updated_by) entered_by,
x.entered_date
from
(
select
gsob.name ledger,
fbc.book_type_code book,
gsob.currency_code currency,
fdp.period_name period,
fa.asset_number,
fa.description asset_description,
fa.tag_number,
fa.serial_number,
(select fl.meaning from fa_lookups fl where fl.lookup_type='ASSET TYPE' and fa.asset_type=fl.lookup_code) asset_type,
fcbk.concatenated_segments category,
fth.transaction_date_entered transfer_date,
fth.transaction_header_id transaction_number,
fth.transaction_name comments,
fth.last_updated_by,
fth.date_effective entered_date,
fdh.side,
fdh.distribution_id,
decode(fdh.side,'FROM',-1,1)*fdh.units_assigned units,
fdh.assigned_to,
fdh.code_combination_id,
fdh.location_id
from
fa_book_controls_sec fbc,
gl_sets_of_books gsob,
fa_transaction_headers fth,
fa_deprn_periods fdp,
fa_additions fa,
fa_categories_b_kfv fcbk,
(
select 'FROM' side, fdh.transaction_header_id_out transaction_header_id, fdh.distribution_id, fdh.units_assigned, fdh.assigned_to, fdh.code_combination_id, fdh.location_id from fa_distribution_history fdh
union all
select 'TO' side, fdh.transaction_header_id_in transaction_header_id, fdh.distribution_id, fdh.units_assigned, fdh.assigned_to, fdh.code_combination_id, fdh.location_id from fa_distribution_history fdh
) fdh
where
1=1 and
fbc.set_of_books_id=gsob.set_of_books_id and
fbc.distribution_source_book=fth.book_type_code and
fth.transaction_type_code='TRANSFER' and
fbc.book_type_code=fdp.book_type_code and
fth.date_effective>=fdp.period_open_date and
fth.date_effective<=nvl(fdp.period_close_date,sysdate) and
fth.asset_id=fa.asset_id and
fa.asset_category_id=fcbk.category_id and
fth.transaction_header_id=fdh.transaction_header_id
) x,
(
select
fadj.transaction_header_id,
fadj.distribution_id,
fadj.book_type_code,
sum(case when fadj.adjustment_type in ('COST','CIP COST') then decode(fadj.debit_credit_flag,'DR',1,-1)*fadj.adjustment_amount else 0 end) cost,
sum(case when fadj.adjustment_type='RESERVE' then decode(fadj.debit_credit_flag,'CR',1,-1)*fadj.adjustment_amount else 0 end) reserve,
sum(case when fadj.adjustment_type='EXPENSE' then decode(fadj.debit_credit_flag,'DR',1,-1)*fadj.adjustment_amount else 0 end) depreciation_expense,
sum(case when fadj.adjustment_type='REVAL RESERVE' then decode(fadj.debit_credit_flag,'CR',1,-1)*fadj.adjustment_amount else 0 end) revaluation_reserve
from
fa_adjustments fadj
where
fadj.source_type_code='TRANSFER'
group by
fadj.transaction_header_id,
fadj.distribution_id,
fadj.book_type_code
) y,
per_all_people_f papf,
gl_code_combinations_kfv gcck,
fa_locations_kfv flk
where
x.transaction_number=y.transaction_header_id(+) and
x.distribution_id=y.distribution_id(+) and
x.book=y.book_type_code(+) and
x.assigned_to=papf.person_id(+) and
x.entered_date>=papf.effective_start_date(+) and
x.entered_date<papf.effective_end_date(+)+1 and
x.code_combination_id=gcck.code_combination_id and
x.location_id=flk.location_id
order by
x.book,
x.asset_number,
x.transfer_date,
x.transaction_number,
x.side desc

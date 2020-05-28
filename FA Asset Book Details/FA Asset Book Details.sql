/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Asset Book Details
-- Description: FA asset books with asset depreciation summary and financial transaction values.
Using parameters 'Show Calendar', 'Show Alternative Ledgers', 'Show Accounting Rules', 'Show Natural Accounts' shows the setup details of book controls.
-- Excel Examle Output: https://www.enginatics.com/example/fa-asset-book-details/
-- Library Link: https://www.enginatics.com/reports/fa-asset-book-details/
-- Run Report: https://demo.enginatics.com/

with c_alt_ledgers as (
select
gl.ledger_id,
fmbc.book_type_code,
gl.name alternative_ledger,
decode(gl.ledger_category_code,'ALC','Reporting','SECONDARY','Secondary') alternative_ledger_type,
gl.currency_code alternative_ledger_currency,
fifsv.description alt_ledger_chart_of_accounts,
fmbc.gl_posting_allowed_flag alt_ledger_allow_gl_posting,
fmbc.enabled_flag alternative_ledger_enabled
from
fa_mc_book_controls fmbc,
gl_ledgers gl,
fnd_id_flex_structures_vl fifsv
where
fmbc.set_of_books_id=gl.ledger_id and
gl.ledger_category_code<>'PRIMARY' and
gl.chart_of_accounts_id=fifsv.id_flex_num and
fifsv.id_flex_code='GL#' and
fifsv.application_id=101 and
'&show_alt_ledgers'='Y'
),
c_additions as(
select
fab.asset_id,
fab.asset_number,
(select fat.description from fa_additions_tl fat where fat.asset_id=fab.asset_id and fat.language=userenv('lang')) asset_description,
fab.tag_number,
fab.attribute_category_code asset_category_code,
fab.serial_number,
(select fakk.concatenated_segments from fa_asset_keywords_kfv fakk where fakk.code_combination_id=fab.asset_key_ccid) asset_key,
(select fab1.asset_number from fa_additions_b fab1 where fab1.asset_id=fab.parent_asset_id)parent_asset_number,
(select fat.description from fa_additions_tl fat where fat.asset_id=fab.parent_asset_id and fat.language=userenv('lang')) parent_description ,
fab.manufacturer_name,
fab.model_number,
fl.lease_number,
fl.description lease_description,
(select asu.vendor_name from ap_suppliers asu where fl.lessor_id=asu.vendor_id) lessor,
fab.in_use_flag,
fab.inventorial,
fab.asset_type,
fab.current_units,
fab.property_type_code,
fab.owned_leased,
fab.property_1245_1250_code,
fab.new_used,
fab.commitment,
fab.investment_law,
fb.book_type_code,
fb.cost
from
fa_additions_b fab,
fa_books fb,
fa_leases fl
where
fab.asset_id=fb.asset_id and
nvl(fb.disabled_flag,'N')='N' and
fb.transaction_header_id_out is null and
fab.lease_id=fl.lease_id(+) and
('&show_additions'='Y' or '&show_dprn'='Y' or '&show_trx'='Y')
),
c_dprn as(
select
fds.book_type_code,
fds.asset_id,
fds.period_counter,
fdp.period_name deprn_period_name,
fdp.period_close_date deprn_period_close_date,
fds.deprn_amount,
fds.ytd_deprn,
fds.deprn_reserve,
fds.deprn_source_code
from
(select x.* from (select max(fds.period_counter) over (partition by fds.asset_id,fds.book_type_code) max_period_counter, fds.* from fa_deprn_summary fds) x where x.period_counter=x.max_period_counter) fds,
fa_deprn_periods fdp
where
fds.book_type_code=fdp.book_type_code(+) and
fds.period_counter+1=fdp.period_counter(+) and
'&show_dprn'='Y'
),
c_fin_trx as (
select
fb.asset_id,
fb.book_type_code,
(select fl.meaning from fa_lookups fl where fl.lookup_type='FAXOLTRX' and fl.lookup_code=fth.transaction_type_code) trx_transaction_type,
fdp.period_name trx_period_entered,
fcp.period_name trx_period_effective,
fb.cost trx_current_cost,
fth.transaction_date_entered trx_date_entered,
fdp.fiscal_year trx_fiscal_year,
fth.date_effective trx_date_effective,
ftr.transaction_type trx_reference_type,
ftr.trx_reference_id,
fb.transaction_header_id_in
from
fa_books fb,
fa_books fb0,
fa_transaction_headers fth,
fa_trx_references ftr,
fa_deprn_periods fdp,
fa_book_controls fbc,
fa_calendar_periods fcp
where
fb.transaction_header_id_in=fb0.transaction_header_id_out(+) and
(fb.cost<>fb0.cost or fb0.cost is null) and
fb.transaction_header_id_in=fth.transaction_header_id and
fth.trx_reference_id=ftr.trx_reference_id(+) and
fth.book_type_code=fdp.book_type_code and
fth.date_effective between fdp.period_open_date and nvl(fdp.period_close_date,sysdate) and
fb.book_type_code=fbc.book_type_code and
fbc.deprn_calendar=fcp.calendar_type and
fth.transaction_date_entered between fcp.start_date and fcp.end_date and
fb.book_type_code=fdp.book_type_code and
'&show_trx'='Y'
)
select --main SQL starts here
fbc.book_type_code book,
fbc.book_type_name description,
fbc.book_class class,
fbc.distribution_source_book associated_corporate_book,
(select fds.period_name from fa_deprn_periods fds where fds.period_counter=fbc.initial_period_counter and fds.book_type_code=fbc.book_type_code) initial_period_counter,
(select fds.period_name from fa_deprn_periods fds where fds.period_counter=fbc.last_mass_copy_period_counter and fds.book_type_code=fbc.book_type_code) last_mass_copy_period_counter ,
(select fds.period_name from fa_deprn_periods fds where fds.period_counter=fbc.last_period_counter and fds.book_type_code=fbc.book_type_code) last_period_counter,
&calendar_columns
(select fift.id_flex_structure_name from fnd_id_flex_structures_tl fift where gl.chart_of_accounts_id=fift.id_flex_num and fift.application_id=101 and fift.id_flex_code='GL#' and fift.language=userenv('lang')) chart_of_accounts,
&alt_ledger_columns
&accounting_rules_columns
&natural_account_columns
&asset_number
&addition_columns
&dprn_columns
&trx_columns
haouv.name operating_unit,
org_id
from
fa_book_controls fbc,
gl_ledgers gl,
c_alt_ledgers,
c_additions,
c_dprn,
c_fin_trx,
hr_all_organization_units_vl haouv
where
fbc.set_of_books_id=gl.ledger_id and
fbc.book_type_code=c_alt_ledgers.book_type_code(+) and
fbc.book_type_code=c_additions.book_type_code(+) and
c_additions.book_type_code=c_dprn.book_type_code(+) and
c_additions.asset_id=c_dprn.asset_id(+) and
c_additions.book_type_code=c_fin_trx.book_type_code(+) and
c_additions.asset_id=c_fin_trx.asset_id(+) and
fbc.org_id=haouv.organization_id(+) and
2=2
order by
fbc.book_type_code
&order_columns
/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA CIP Assets and Invoices
-- Description: CIP (Construction in Progress) assets with invoice details.
Shows asset master information (category, location, tag, cost) alongside AP invoice lines that feed into CIP.
Run as-is for invoice-level detail, or pivot/group in Excel for an asset-level summary.

Covers the use cases of:
- Monthly CIP Report - Asset Details (CapEx)
- Monthly CIP Report - CIP Invoice Activity
-- Excel Examle Output: https://www.enginatics.com/example/fa-cip-assets-and-invoices/
-- Library Link: https://www.enginatics.com/reports/fa-cip-assets-and-invoices/
-- Run Report: https://demo.enginatics.com/

select
gl.name ledger,
:p_book book,
gl.currency_code currency,
fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'GL_BALANCING','Y','VALUE') balancing_segment,
fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_acct_seg','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'GL_ACCOUNT','Y','VALUE') cip_account,
fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'FA_COST_CTR','Y','VALUE') cost_center,
fab.asset_number,
fat.description asset_description,
fab.tag_number,
fcbk.concatenated_segments asset_category,
flk.concatenated_segments asset_location,
fb.cost asset_cost,
fb.date_placed_in_service,
fai.invoice_number,
fai.invoice_date,
fai.fixed_assets_cost invoice_cost,
fai.description invoice_description,
fai.po_number purchase_order,
aps.vendor_name,
fai.feeder_system_name,
fai.payables_batch_name,
&dff_columns
fai.creation_date invoice_creation_date,
fdh.last_update_date distribution_last_update
from
fa_book_controls fbc,
gl_ledgers gl,
fa_additions_b fab,
fa_additions_tl fat,
fa_books fb,
fa_distribution_history fdh,
gl_code_combinations gcc,
fa_categories_b_kfv fcbk,
fa_locations_kfv flk,
fa_asset_invoices fai,
ap_suppliers aps
where
fbc.book_type_code=:p_book and
fbc.set_of_books_id=gl.ledger_id and
fab.asset_type='CIP' and
fab.asset_id=fat.asset_id and
fat.language=userenv('lang') and
fab.asset_id=fb.asset_id and
fb.book_type_code=fbc.book_type_code and
fb.transaction_header_id_out is null and
fab.asset_id=fdh.asset_id and
fdh.book_type_code=fbc.book_type_code and
fdh.date_ineffective is null and
fdh.code_combination_id=gcc.code_combination_id and
fdh.location_id=flk.location_id and
fab.asset_category_id=fcbk.category_id and
fab.asset_id=fai.asset_id(+) and
fai.po_vendor_id=aps.vendor_id(+) and
1=1
order by
fab.asset_number,
fai.invoice_number
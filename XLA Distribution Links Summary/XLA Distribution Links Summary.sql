/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: XLA Distribution Links Summary
-- Description: Summary of subledger distribution links for developers to understand which source_ids are populated for which subledger table sources.
The link to subledger tables for different source_distribution_type values is described e.g. MOS Doc IDs for:
AP 813968.1 https://support.oracle.com/CSP/main/article?cmd=show&type=NOT&id=813968.1
FA 2002464.1 https://support.oracle.com/CSP/main/article?cmd=show&type=NOT&id=2002464.1
PA 1274575.1 https://support.oracle.com/CSP/main/article?cmd=show&type=NOT&id=1274575.1

For GMF, there is
AP and PO Accrual Reconciliation Report Debugging from OPM Financials 2114612.1 https://support.oracle.com/CSP/main/article?cmd=show&type=NOT&id=2114612.1
and Financials Troubleshooting Guide 1213193.1 https://support.oracle.com/CSP/main/article?cmd=show&type=NOT&id=1213193.1
-- Excel Examle Output: https://www.enginatics.com/example/xla-distribution-links-summary/
-- Library Link: https://www.enginatics.com/reports/xla-distribution-links-summary/
-- Run Report: https://demo.enginatics.com/

select
fav.application_short_name,
fav.application_name,
count(*) count,
xdl.source_distribution_type,
coalesce(
decode(xdl.source_distribution_type,
'AP_INV_DIST','ap_invoice_distributions_all',
'AP_PMT_DIST','ap_payment_hist_dists',
'AP_PREPAY','ap_prepay_app_dists',
'XLA_MANUAL','ap_self_assessed_tax_dist_all',
--FA
'TRX','fa_adjustments',
'DEPRN','fa_deprn_detail',
'IAC','fa_deprn_detail',
--PA
'R','pa_cost_distribution_lines_all',
'C','pa_cost_distribution_lines_all',
'D','pa_cost_distribution_lines_all',
'BL','pa_cc_dist_lines_all',
'Revenue - Normal Revenue','pa_cust_rev_dist_lines_all',
'Revenue - Event Revenue','pa_cust_event_rdl_all',
'Revenue - UBR','pa_draft_revenues_all',
'Revenue - UER','pa_draft_revenues_all'
),
--GMF
decode(xdl.application_id,555,'gmf_xla_extract_lines'),
--other
case when xdl.source_distribution_type in
(
'PO_REQ_DISTRIBUTIONS_ALL',
'AR_DISTRIBUTIONS_ALL',
'RCV_RECEIVING_SUB_LEDGER',
'RA_CUST_TRX_LINE_GL_DIST_ALL',
'OKL_TRNS_ACC_DSTRS',
'MTL_TRANSACTION_ACCOUNTS',
'WIP_TRANSACTION_ACCOUNTS',
'PO_DISTRIBUTIONS_ALL'
) then lower(xdl.source_distribution_type) end
--(select lower(ds.table_name) from dba_synonyms ds where ds.owner='APPS' and xdl.source_distribution_type=ds.synonym_name)
) source_table,
coalesce(
decode(xdl.source_distribution_type,
--AP
'AP_INV_DIST','invoice_distribution_id',
'AP_PMT_DIST','payment_hist_dist_id',
'AP_PREPAY','prepay_app_dist_id',
'XLA_MANUAL','invoice_distribution_id',
--FA
'TRX','transaction_header_id,adjustment_line_id',
'DEPRN','book_type_code, asset_id, period_counter, deprn_run_id, distribution_id',
'IAC','book_type_code, asset_id, period_counter, deprn_run_id, distribution_id',
--PA
'R','expenditure_item_id, line_num',
'C','expenditure_item_id, line_num',
'D','expenditure_item_id, line_num',
'BL','expenditure_item_id, line_num',
'Revenue - Normal Revenue','expenditure_item_id, line_num',
'Revenue - Event Revenue','event_id, line_num',
'Revenue - UBR','project_id, draft_revenue_num',
'Revenue - UER','project_id, draft_revenue_num'
),
--GMF
decode(xdl.application_id,555,'line_id'),
--other
decode(xdl.source_distribution_type,
'PO_REQ_DISTRIBUTIONS_ALL','distribution_id',
'AR_DISTRIBUTIONS_ALL','line_id',
'RCV_RECEIVING_SUB_LEDGER','rcv_sub_ledger_id',
'RA_CUST_TRX_LINE_GL_DIST_ALL','cust_trx_line_gl_dist_id',
'OKL_TRNS_ACC_DSTRS','id',
'MTL_TRANSACTION_ACCOUNTS','inv_sub_ledger_id',
'WIP_TRANSACTION_ACCOUNTS','wip_sub_ledger_id',
'PO_DISTRIBUTIONS_ALL','po_distribution_id'
)
) source_columns,
nvl2(xdl.source_distribution_id_char_1,'not null',null) source_distribution_id_char_1,
nvl2(xdl.source_distribution_id_char_2,'not null',null) source_distribution_id_char_2,
nvl2(xdl.source_distribution_id_char_3,'not null',null) source_distribution_id_char_3,
nvl2(xdl.source_distribution_id_char_4,'not null',null) source_distribution_id_char_4,
nvl2(xdl.source_distribution_id_char_5,'not null',null) source_distribution_id_char_5,
nvl2(xdl.source_distribution_id_num_1,'not null',null) source_distribution_id_num_1,
nvl2(xdl.source_distribution_id_num_2,'not null',null) source_distribution_id_num_2,
nvl2(xdl.source_distribution_id_num_3,'not null',null) source_distribution_id_num_3,
nvl2(xdl.source_distribution_id_num_4,'not null',null) source_distribution_id_num_4,
nvl2(xdl.source_distribution_id_num_5,'not null',null) source_distribution_id_num_5,
xdl.accounting_line_code,
xdl.accounting_line_type_code,
xdl.merge_duplicate_code,
xdl.line_definition_owner_code,
xdl.line_definition_code,
xdl.event_class_code,
xdl.event_type_code,
sum(xdl.unrounded_entered_cr) unrounded_entered_cr,
sum(xdl.unrounded_accounted_cr) unrounded_accounted_cr,
nvl2(xdl.upg_batch_id,'not null',null) upg_batch_id,
xdl.application_id
from
fnd_application_vl fav,
xla_distribution_links xdl
where
fav.application_id=xdl.application_id
group by
fav.application_short_name,
fav.application_name,
xdl.source_distribution_type,
nvl2(xdl.source_distribution_id_char_1,'not null',null),
nvl2(xdl.source_distribution_id_char_2,'not null',null),
nvl2(xdl.source_distribution_id_char_3,'not null',null),
nvl2(xdl.source_distribution_id_char_4,'not null',null),
nvl2(xdl.source_distribution_id_char_5,'not null',null),
nvl2(xdl.source_distribution_id_num_1,'not null',null),
nvl2(xdl.source_distribution_id_num_2,'not null',null),
nvl2(xdl.source_distribution_id_num_3,'not null',null),
nvl2(xdl.source_distribution_id_num_4,'not null',null),
nvl2(xdl.source_distribution_id_num_5,'not null',null),
xdl.accounting_line_code,
xdl.accounting_line_type_code,
xdl.merge_duplicate_code,
xdl.line_definition_owner_code,
xdl.line_definition_code,
xdl.event_class_code,
xdl.event_type_code,
nvl2(xdl.upg_batch_id,'not null',null),
xdl.application_id
order by
fav.application_short_name,
fav.application_name,
count(*) desc
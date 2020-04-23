/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: XLA Entity ID Mappings
-- Description: Shows the column link between table xla_transaction_entities and subledger source tables such as and AP invoice_id or AR customer_trx_id, used when writing queries linking GL to subledger such as the GL Account Analysis report www.enginatics.com/reports/gl-account-analysis/
-- Excel Examle Output: https://www.enginatics.com/example/xla-entity-id-mappings
-- Library Link: https://www.enginatics.com/reports/xla-entity-id-mappings
-- Run Report: https://demo.enginatics.com/


select
fav.application_name,
fav.application_short_name,
xeim.application_id,
xeim.entity_code,
lower(xeim.xte_column) xte_column,
lower(xeim.transaction_column) transaction_column,
case
when xeim.application_id=140 and xeim.entity_code='DEFERRED_DEPRECIATION' then 'fa_deprn_summary'
when xeim.application_id=140 and xeim.entity_code='DEPRECIATION' then 'fa_deprn_summary'
when xeim.application_id=140 and xeim.entity_code='INTER_ASSET_TRANSACTIONS' then 'fa_trx_references'
when xeim.application_id=140 and xeim.entity_code='TRANSACTIONS' then 'fa_transaction_headers'
when xeim.application_id=260 and xeim.entity_code='CE_CASHFLOWS' then ''
when xeim.application_id=8407 and xeim.entity_code='CC_CONTRACTS' then ''
when xeim.application_id=8407 and xeim.entity_code='CC_PROJECTS' then ''
when xeim.application_id=8407 and xeim.entity_code='CC_PURCHASE_ORDERS' then ''
when xeim.application_id=8407 and xeim.entity_code='CC_REQUISITIONS' then ''
when xeim.application_id=20065 and xeim.entity_code='DEPOSITS' then ''
when xeim.application_id=20065 and xeim.entity_code='INVESTMENTS' then ''
when xeim.application_id=20065 and xeim.entity_code='LINESOFCREDIT' then ''
when xeim.application_id=20065 and xeim.entity_code='LOANS' then ''
when xeim.application_id=707 and xeim.entity_code='MTL_ACCOUNTING_EVENTS' then 'mtl_material_transactions'
when xeim.application_id=707 and xeim.entity_code='RCV_ACCOUNTING_EVENTS' then 'rcv_transactions'
when xeim.application_id=707 and xeim.entity_code='WIP_ACCOUNTING_EVENTS' then 'wip_transactions'
when xeim.application_id=707 and xeim.entity_code='WO_ACCOUNTING_EVENTS' then 'cst_write_offs cwo'
when xeim.application_id=8901 and xeim.entity_code='BE_RPR_TRANSACTIONS' then ''
when xeim.application_id=8901 and xeim.entity_code='BE_TRANSACTIONS' then ''
when xeim.application_id=8901 and xeim.entity_code='TREASURY_CONFIRMATION' then ''
when xeim.application_id=20066 and xeim.entity_code='INSURANCE' then ''
when xeim.application_id=20066 and xeim.entity_code='INTERESTRATESWAPS' then ''
when xeim.application_id=20066 and xeim.entity_code='INVESTMENTS' then ''
when xeim.application_id=540 and xeim.entity_code='AM_QUOTES' then ''
when xeim.application_id=540 and xeim.entity_code='ASSETS' then ''
when xeim.application_id=540 and xeim.entity_code='CONTRACTS' then ''
when xeim.application_id=540 and xeim.entity_code='INVESTOR_AGREEMENTS' then ''
when xeim.application_id=540 and xeim.entity_code='SALES_QUOTES' then ''
when xeim.application_id=540 and xeim.entity_code='TAX_SCHEDULE_REQUESTS' then ''
when xeim.application_id=540 and xeim.entity_code='TRANSACTIONS' then ''
when xeim.application_id=206 and xeim.entity_code='LOANS' then ''
when xeim.application_id=9000 and xeim.entity_code='CLAIM_SETTLEMENT' then ''
when xeim.application_id=9000 and xeim.entity_code='COST_UPDATE' then ''
when xeim.application_id=200 and xeim.entity_code='AP_INVOICES' then 'ap_invoices_all aia'
when xeim.application_id=200 and xeim.entity_code='AP_PAYMENTS' then 'ap_checks_all aca'
when xeim.application_id=801 and xeim.entity_code='ASSIGNMENTS' then ''
when xeim.application_id=555 and xeim.entity_code='INVENTORY' then ''
when xeim.application_id=555 and xeim.entity_code='ORDERMANAGEMENT' then ''
when xeim.application_id=555 and xeim.entity_code='PRODUCTION' then ''
when xeim.application_id=555 and xeim.entity_code='PURCHASING' then ''
when xeim.application_id=555 and xeim.entity_code='REVALUATION' then ''
when xeim.application_id=275 and xeim.entity_code='BUDGETS' then 'pa_budget_versions'
when xeim.application_id=275 and xeim.entity_code='EXPENDITURES' then 'pa_expenditure_items_all'
when xeim.application_id=275 and xeim.entity_code='REVENUE' then 'pa_draft_revenues_all'
when xeim.application_id=240 and xeim.entity_code='TRANSACTION' then ''
when xeim.application_id=201 and xeim.entity_code='PURCHASE_ORDER' then 'po_headers_all'
when xeim.application_id=201 and xeim.entity_code='RELEASE' then 'po_releases_all'
when xeim.application_id=201 and xeim.entity_code='REQUISITION' then 'po_requisition_headers_all'
when xeim.application_id=222 and xeim.entity_code='ADJUSTMENTS' then 'ar_adjustments_all'
when xeim.application_id=222 and xeim.entity_code='BILLS_RECEIVABLE' then 'ra_customer_trx_all'
when xeim.application_id=222 and xeim.entity_code='JL_BR_AR_COLL_DOC_OCCS' then 'jl_br_ar_collection_docs_all'
when xeim.application_id=222 and xeim.entity_code='RECEIPTS' then 'ar_cash_receipts_all'
when xeim.application_id=222 and xeim.entity_code='TRANSACTIONS' then 'ra_customer_trx_all'
when xeim.application_id=682 and xeim.entity_code='ACCRUAL' then ''
when xeim.application_id=682 and xeim.entity_code='CLAIM_SETTLEMENT' then ''
end transaction_table
from
(
select 1 seq_num, xeim.application_id, xeim.entity_code, xeim.source_id_col_name_1 xte_column, xeim.transaction_id_col_name_1 transaction_column from xla_entity_id_mappings xeim where xeim.source_id_col_name_1 is not null union all
select 2 seq_num, xeim.application_id, xeim.entity_code, xeim.source_id_col_name_2 xte_column, xeim.transaction_id_col_name_2 transaction_column from xla_entity_id_mappings xeim where xeim.source_id_col_name_2 is not null union all
select 3 seq_num, xeim.application_id, xeim.entity_code, xeim.source_id_col_name_3 xte_column, xeim.transaction_id_col_name_3 transaction_column from xla_entity_id_mappings xeim where xeim.source_id_col_name_3 is not null union all
select 4 seq_num, xeim.application_id, xeim.entity_code, xeim.source_id_col_name_4 xte_column, xeim.transaction_id_col_name_4 transaction_column from xla_entity_id_mappings xeim where xeim.source_id_col_name_4 is not null
) xeim,
fnd_application_vl fav
where
xeim.application_id=fav.application_id
order by
fav.application_name,
xeim.entity_code,
xeim.seq_num
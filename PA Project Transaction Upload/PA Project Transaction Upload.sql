/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Project Transaction Upload
-- Description: PA Project Transaction Upload
===================
This upload can be used to upload transactions from external cost collection systems into Oracle Projects. 
Transaction Import creates pre-approved expenditure items from transaction data entered in external cost collection systems.

If the 'Operating Unit' and/or 'Transaction Source' parameters are specified, then the upload excel will be restricted to the specified Operating Unit and/or Transaction Source.

If the 'Batch Name' parameter is specified, this will default as the Batch Name in the upload Excel.

If the 'All Negative Expend Unmatched' parameter is set to Yes, then all negative transations then the 'Unmatched Negative Txn Flag' column will automatically default to Yes against any negative transactions entered into upload Excel.

If the 'Reverse in Future Period' parameter is set to Yes, then the 'Accrual Flag' column will default to Yes against every transaction entered in the upload Excel  

-- Excel Examle Output: https://www.enginatics.com/example/pa-project-transaction-upload/
-- Library Link: https://www.enginatics.com/reports/pa-project-transaction-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
null row_id,
--
haouv.name operating_unit,
(select pts.user_transaction_source from pa_transaction_sources pts where pts.transaction_source = ptia.transaction_source) transaction_source,
ptia.system_linkage expnd_type_class,
ptia.expenditure_ending_date expnd_ending_date,
ptia.batch_name batch_name,
ptia.orig_transaction_reference original_trans_ref,
--
ptia.organization_name organization_name,
null employee_name,
ptia.employee_number employee_number,
ptia.person_business_group_name business_group,
ptia.person_type person_type,
ptia.override_to_organization_name override_to_organization,
--
ptia.expenditure_item_date expnd_item_date,
ptia.project_number project_number,
null project_name,
ptia.task_number task_number,
null task_name,
ptia.expenditure_type expnd_type,
--
ptia.non_labor_resource non_labor_resource, --usages
ptia.non_labor_resource_org_name non_labor_org, --usages
ptia.assignment_name assignment_name, -- timecards
ptia.work_type_name work_type_name,
--
ptia.quantity quantity,
--
ptia.denom_currency_code trans_curr,
ptia.denom_raw_cost trans_raw_cost,
ptia.denom_burdened_cost trans_burdened_cost,
ptia.acct_raw_cost acctd_raw_cost,
ptia.acct_burdened_cost acctd_burdened_cost,
ptia.raw_cost_rate,
ptia.burdened_cost_rate,
--
ptia.acct_rate_type acctd_exchange_rate_type,
ptia.acct_rate_date acctd_exchange_rate_date,
ptia.acct_exchange_rate acctd_exchange_rate,
ptia.acct_exchange_rounding_limit acctd_exchange_rounding_limit,
--
ptia.receipt_currency_code,
ptia.receipt_currency_amount,
ptia.receipt_exchange_rate,
ptia.project_rate_type,
ptia.project_rate_date,
ptia.project_exchange_rate,
ptia.projfunc_cost_rate_type project_func_rate_type,
ptia.projfunc_cost_rate_date project_func_rate_date,
ptia.projfunc_cost_exchange_rate project_func_exchange_rate,
--
ptia.reversed_orig_txn_reference reversed_orig_trans_ref,
ptia.unmatched_negative_txn_flag negative_txn_flag,
ptia.accrual_flag,
ptia.billable_flag,
--
ptia.gl_date gl_date,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = ptia.dr_code_combination_id) debit_acct,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = ptia.cr_code_combination_id) credit_acct,
--
ptia.vendor_number vendor_number,
ptia.po_number po_number,
ptia.po_line_num po_line_number,
ptia.po_price_type po_price_type,
--
ptia.expenditure_comment,
--
ptia.orig_user_exp_txn_reference orig_user_expnd_trans_ref,
ptia.orig_exp_txn_reference1 orig_expnd_trans_ref1,
ptia.orig_exp_txn_reference2 orig_expnd_trans_ref2,
ptia.orig_exp_txn_reference3 orig_expnd_trans_ref3,
ptia.cdl_system_reference1 cdl_system_ref1,
ptia.cdl_system_reference2 cdl_system_ref2,
ptia.cdl_system_reference3 cdl_system_ref3,
ptia.cdl_system_reference4 cdl_system_ref4,
ptia.cdl_system_reference5 cdl_system_ref5,
--
ptia.attribute_category attribute_category,
ptia.attribute1 pa_expnd_attribute1,
ptia.attribute2 pa_expnd_attribute2,
ptia.attribute3 pa_expnd_attribute3,
ptia.attribute4 pa_expnd_attribute4,
ptia.attribute5 pa_expnd_attribute5,
ptia.attribute6 pa_expnd_attribute6,
ptia.attribute7 pa_expnd_attribute7,
ptia.attribute8 pa_expnd_attribute8,
ptia.attribute9 pa_expnd_attribute9,
ptia.attribute10 pa_expnd_attribute10,
--
xxen_util.meaning(nvl(:p_submit_import,'Y'),'YES_NO',0) import_transactions
from
pa_transaction_interface_all ptia,
hr_all_organization_units_vl haouv
where
1=1 and
ptia.org_id = haouv.organization_id and
:p_upload_mode like '%' || xxen_upload.action_update and
haouv.name = nvl(:p_operating_unit,haouv.name) and
ptia.transaction_source = nvl(:p_transaction_source,ptia.transaction_source) and
ptia.batch_name = nvl(:p_batch_name,ptia.batch_name) and
nvl(:p_expnd_ending_date,sysdate) = nvl(:p_expnd_ending_date,sysdate) and
nvl(:p_unmatched_neg_txn_flag,'X') = nvl(:p_unmatched_neg_txn_flag,'X') and
nvl(:p_accrual_flag,'X') = nvl(:p_accrual_flag,'X')
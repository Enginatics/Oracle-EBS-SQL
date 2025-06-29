/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Transaction Sources
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/pa-transaction-sources/
-- Library Link: https://www.enginatics.com/reports/pa-transaction-sources/
-- Run Report: https://demo.enginatics.com/

select
pts.user_transaction_source,
case when userenv('lang')='US' then (select psl.meaning from pa_system_linkages psl where pts.system_linkage_function=psl.function) else xxen_util.meaning(pts.system_linkage_function,'TIMECARD TRANSLATION',275) end default_expenditure_type_class,
xxen_util.yes(pts.gl_accounted_flag) raw_cost_gl_accounted,
xxen_util.yes(pts.costed_flag) import_raw_cost_amounts,
xxen_util.yes(pts.allow_burden_flag) import_burdened_amounts,
xxen_util.yes(pts.allow_duplicate_reference_flag) allow_duplicate_reference,
xxen_util.yes(pts.allow_emp_org_override_flag) import_employee_organization,
xxen_util.yes(pts.modify_interface_flag) allow_interface_modifications,
xxen_util.yes(pts.purgeable_flag) purge_after_import,
xxen_util.yes(pts.allow_reversal_flag) allow_reversals,
xxen_util.yes(pts.allow_adjustments_flag) allow_adjustments,
xxen_util.yes(pts.process_funds_check) process_funds_check,
xxen_util.yes(pts.cc_process_flag) process_cross_change,
pts.pre_processing_extension,
pts.post_processing_extension,
pts.batch_size processing_set_size,
pts.start_date_active start_date,
pts.end_date_active end_date,
pts.description,
&dff_columns
xxen_util.user_name(pts.created_by) created_by,
xxen_util.client_time(pts.creation_date) creation_date,
xxen_util.user_name(pts.last_updated_by) last_updated_by,
xxen_util.client_time(pts.last_update_date) last_update_date,
pts.transaction_source,
pts.system_linkage_function
from
pa_transaction_sources pts
order by
pts.transaction_source
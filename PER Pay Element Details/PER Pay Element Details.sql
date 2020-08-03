/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Pay Element Details
-- Description: Master data report showing HR payroll element details.
Elements are the units used to build all the earnings, deductions and benefits that companies can give to employees.
-- Excel Examle Output: https://www.enginatics.com/example/per-pay-element-details/
-- Library Link: https://www.enginatics.com/reports/per-pay-element-details/
-- Run Report: https://demo.enginatics.com/

select
petf.element_name,
petf.reporting_name,
petf.description,
pec.classification_name,
pec.legislation_code,
petf.input_currency_code,
petf.output_currency_code,
xxen_util.meaning(petf.additional_entry_allowed_flag,'YES_NO',0) additional_entry_allowed,
xxen_util.meaning(petf.adjustment_only_flag,'YES_NO',0) adjustment_only,
xxen_util.meaning(petf.closed_for_entry_flag,'YES_NO',0) closed_for_entry,
xxen_util.meaning(petf.multiple_entries_allowed_flag,'YES_NO',0) multiple_entries_allowed,
xxen_util.meaning(petf.process_in_run_flag,'YES_NO',0) process_in_run,
xxen_util.meaning(petf.standard_link_flag,'YES_NO',0) standard_link,
xxen_util.meaning(petf.processing_type,'PROCESSING_TYPE',3) processing_type,
xxen_util.meaning(petf.post_termination_rule,'TERMINATION_RULE',3) post_termination_rule,
petf.effective_start_date,
petf.effective_end_date,
petf.processing_priority,
xxen_util.user_name(petf.created_by) created_by,
xxen_util.client_time(petf.creation_date) creation_date,
xxen_util.user_name(petf.last_updated_by) last_updated_by,
xxen_util.client_time(petf.last_update_date) last_update_date,
petf.element_type_id
from
pay_element_types_f petf, 
pay_element_classifications pec
where
1=1 and
petf.classification_id=pec.classification_id
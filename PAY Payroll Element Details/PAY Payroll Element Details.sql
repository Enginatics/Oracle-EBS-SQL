/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PAY Payroll Element Details
-- Description: Master data report showing HR payroll element details.
Elements are the units used to build all the earnings, deductions and benefits that companies can give to employees.
-- Excel Examle Output: https://www.enginatics.com/example/pay-payroll-element-details/
-- Library Link: https://www.enginatics.com/reports/pay-payroll-element-details/
-- Run Report: https://demo.enginatics.com/

select
petfv.element_name,
petfv.reporting_name,
petfv.description,
pec.classification_name,
pec.legislation_code,
petfv.input_currency_code,
petfv.output_currency_code,
xxen_util.meaning(petfv.additional_entry_allowed_flag,'YES_NO',0) additional_entry_allowed,
xxen_util.meaning(petfv.adjustment_only_flag,'YES_NO',0) adjustment_only,
xxen_util.meaning(petfv.closed_for_entry_flag,'YES_NO',0) closed_for_entry,
xxen_util.meaning(petfv.multiple_entries_allowed_flag,'YES_NO',0) multiple_entries_allowed,
xxen_util.meaning(petfv.process_in_run_flag,'YES_NO',0) process_in_run,
xxen_util.meaning(petfv.standard_link_flag,'YES_NO',0) standard_link,
xxen_util.meaning(petfv.processing_type,'PROCESSING_TYPE',3) processing_type,
xxen_util.meaning(petfv.post_termination_rule,'TERMINATION_RULE',3) post_termination_rule,
petfv.effective_start_date,
petfv.effective_end_date,
petfv.processing_priority,
xxen_util.user_name(petfv.created_by) created_by,
xxen_util.client_time(petfv.creation_date) creation_date,
xxen_util.user_name(petfv.last_updated_by) last_updated_by,
xxen_util.client_time(petfv.last_update_date) last_update_date,
petfv.element_type_id
from
pay_element_types_f_vl petfv, 
pay_element_classifications pec
where
1=1 and
petfv.classification_id=pec.classification_id
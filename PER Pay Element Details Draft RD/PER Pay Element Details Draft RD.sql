/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Pay Element Details - Draft RD
-- Description: Pay Elements
Need more details and clarification
-- Excel Examle Output: https://www.enginatics.com/example/per-pay-element-details-draft-rd
-- Library Link: https://www.enginatics.com/reports/per-pay-element-details-draft-rd
-- Run Report: https://demo.enginatics.com/


select
petf.element_type_id,
petf.element_name,
petf.reporting_name,
petf.description,
pec.classification_name,
decode(petf.additional_entry_allowed_flag,'Y','Yes','N','No') additional_entry_allowed,
decode(petf.adjustment_only_flag,'Y','Yes','N','No') adjustment_only,
decode(petf.closed_for_entry_flag,'Y','Yes','N','No') closed_for_entry,
decode(petf.multiple_entries_allowed_flag,'Y','Yes','N','No') multiple_entries_allowed,
decode(petf.process_in_run_flag,'Y','Yes','N','No') process_in_run,
decode(petf.standard_link_flag,'Y','Yes','N','No') standard_link,
decode(petf.processing_type,'N','Non-Recurring','R','Recurring') Processing_type,
decode(petf.post_termination_rule,'A','Actual Termination','F','Final Close','L','Last Standard Process') Termination_rule,
petf.effective_start_date,
petf.effective_end_date,
petf.processing_priority,
petf.creation_Date
from
pay_element_types_f petf, 
pay_element_classifications pec
where 1=1 and
petf.classification_id=pec.classification_id
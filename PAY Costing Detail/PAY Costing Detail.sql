/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PAY Costing Detail
-- Description: Imported from Concurrent Program
Application: Payroll
Source: Costing Detail Report
Short Name: PAYRPCDR
-- Excel Examle Output: https://www.enginatics.com/example/pay-costing-detail/
-- Library Link: https://www.enginatics.com/reports/pay-costing-detail/
-- Run Report: https://demo.enginatics.com/

select
 x.consolidation_set_name,
 x.payroll_name,
 x.gre,
 x.last_name,
 x.first_name,
 x.middle_names,
 x.effective_date,
 x.element_name,
 x.input_value,
 x.uom,
 x.cost_allocation_segments,
 x.credit_amount,
 x.debit_amount,
 &lp_cost_alloc_segments
 x.organization_name,
 x.location_name,
 &lp_ni_number
 x.employee_number,
 x.assignment_number,
 x.element_classification,
 x.employment_category
from
 (select
   pcd.cost_type,
   pcd.consolidation_set_name,
   pcd.payroll_name,
   pcd.gre_name gre,
   pcd.organization_name,
   pcd.location_code location_name,
   pcd.last_name,
   pcd.first_name,
   pcd.middle_names,
   pcd.employee_number,
   pcd.national_identifier,
   (select
     pec.classification_name
    from
     pay_element_classifications pec
    where
     pcd.classification_id = pec.classification_id
   ) element_classification,
   (SELECT
     hrl.meaning
    from
     hr_lookups hrl,
     per_all_assignments_f paf
    where
     hrl.lookup_type = 'EMP_CAT' and
     hrl.lookup_code = paf.employment_category and
     paf.assignment_id = pcd.assignment_id and
     pcd.effective_date between paf.effective_start_date and paf.effective_end_date
   ) employment_category,
   pcd.assignment_number,
   pcd.assignment_id,
   nvl(pcd.reporting_name,pcd.element_name) element_name,
   pcd.input_value_name input_value,
   pcd.uom,
   pcd.credit_amount,
   pcd.debit_amount,
   pcd.effective_date,
   pcd.concatenated_segments cost_allocation_segments,
   pcd.segment1,
   pcd.segment2,
   pcd.segment3,
   pcd.segment4,
   pcd.segment5,
   pcd.segment6,
   pcd.segment7,
   pcd.segment8,
   pcd.segment9,
   pcd.segment10,
   pcd.segment11,
   pcd.segment12,
   pcd.segment13,
   pcd.segment14,
   pcd.segment15,
   pcd.segment16,
   pcd.segment17,
   pcd.segment18,
   pcd.segment19,
   pcd.segment20,
   pcd.segment21,
   pcd.segment22,
   pcd.segment23,
   pcd.segment24,
   pcd.segment25,
   pcd.segment26,
   pcd.segment27,
   pcd.segment28,
   pcd.segment29,
   pcd.segment30,
   pcd.run_result_id
  from
   pay_costing_details_v pcd
  where
   nvl(:p_selection_criteria,'?') = nvl(:p_selection_criteria,'?') and
   nvl(:p_eff_date_begin,sysdate) = nvl(:p_eff_date_begin,sysdate) and
   nvl(:p_eff_date_end,sysdate) = nvl(:p_eff_date_end,sysdate) and
   pcd.effective_date between :p_start_date and :p_end_date and
   pcd.business_group_id = :p_business_group_id and
   ( (:p_cost_type = 'EST_MODE_COST' and pcd.cost_type in ('COST_TMP','EST_COST')) or
     (:p_cost_type = 'EST_MODE_ALL' and pcd.cost_type in ('COST_TMP','EST_COST','EST_REVERSAL')) or
     (:p_cost_type is null and pcd.cost_type = 'COST_TMP')
   ) and
   1=1
 ) x
order by
 x.cost_type,
 x.last_name,
 x.first_name,
 x.middle_names,
 x.effective_date,
 x.cost_type
/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PAY Element Entries
-- Description: Element entries and their input values valid at the Effective Date, for all assignments including non-primary assignments and the assignments of terminated employees whose entries are still valid at that date.
-- One row per element entry and input value, so that the values of an input value, for example Pay Value or Amount, can be filtered and summed across employees and elements. An entry without input values shows one row with blank input value columns.
-- Entry Value shows the meaning of lookup validated input values and dates in display format. Numeric Value holds the value of money, number, integer and decimal hours input values as a number. Input values validated by a value set show the stored value.
-- Excel Example Output: https://www.enginatics.com/example/pay-element-entries/
-- Library Link: https://www.enginatics.com/reports/pay-element-entries/
-- Run Report: https://demo.enginatics.com/

select
haouv.name business_group,
papf.full_name employee_name,
papf.employee_number,
paaf.assignment_number,
xxen_util.yes(paaf.primary_flag) primary_assignment,
pastv.user_status assignment_status,
(select pap.payroll_name from pay_all_payrolls_f pap where paaf.payroll_id=pap.payroll_id and :effective_date between pap.effective_start_date and pap.effective_end_date) payroll,
haouv2.name organization,
petfv.element_name,
pecv.classification_name classification,
xxen_util.meaning(petfv.processing_type,'PROCESSING_TYPE',3) processing_type,
xxen_util.meaning(peef.entry_type,'ENTRY_TYPE',3) entry_type,
xxen_util.meaning(peef.creator_type,'CREATOR_TYPE',3) creator_type,
peef.effective_start_date entry_start_date,
nullif(peef.effective_end_date,to_date('31.12.4712','DD.MM.YYYY')) entry_end_date,
pivfv.name input_value,
case
when pivfv.lookup_type is not null then nvl(xxen_util.meaning(peevf.screen_entry_value,pivfv.lookup_type,3),peevf.screen_entry_value)
when pivfv.uom='D' then fnd_date.date_to_displaydate(fnd_date.canonical_to_date(peevf.screen_entry_value))
else peevf.screen_entry_value
end entry_value,
case when pivfv.uom in ('M','N','I','ND','H_DECIMAL1','H_DECIMAL2','H_DECIMAL3') then fnd_number.canonical_to_number(peevf.screen_entry_value) end numeric_value,
xxen_util.meaning(pivfv.uom,'UNITS',3) unit_of_measure,
pcak.concatenated_segments cost_allocation,
xxen_util.meaning(peef.reason,'ELE_ENTRY_REASON',3) reason,
xxen_util.user_name(peef.last_updated_by) last_updated_by,
xxen_util.client_time(peef.last_update_date) last_update_date
from
per_all_assignments_f paaf,
per_all_people_f papf,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv2,
per_assignment_status_types_v pastv,
pay_element_entries_f peef,
pay_element_types_f_vl petfv,
pay_element_classifications_vl pecv,
pay_element_entry_values_f peevf,
pay_input_values_f_vl pivfv,
pay_cost_allocation_keyflex pcak
where
1=1 and
:effective_date between paaf.effective_start_date and paaf.effective_end_date and
paaf.person_id=papf.person_id and
:effective_date between papf.effective_start_date and papf.effective_end_date and
paaf.business_group_id=haouv.organization_id and
paaf.organization_id=haouv2.organization_id and
paaf.assignment_status_type_id=pastv.assignment_status_type_id and
paaf.assignment_id=peef.assignment_id and
:effective_date between peef.effective_start_date and peef.effective_end_date and
peef.element_type_id=petfv.element_type_id and
:effective_date between petfv.effective_start_date and petfv.effective_end_date and
petfv.classification_id=pecv.classification_id and
peef.element_entry_id=peevf.element_entry_id(+) and
:effective_date between peevf.effective_start_date(+) and peevf.effective_end_date(+) and
peevf.input_value_id=pivfv.input_value_id(+) and
:effective_date between pivfv.effective_start_date(+) and pivfv.effective_end_date(+) and
peef.cost_allocation_keyflex_id=pcak.cost_allocation_keyflex_id(+)
order by
haouv.name,
papf.full_name,
paaf.assignment_number,
petfv.element_name,
peef.effective_start_date,
pivfv.display_sequence,
pivfv.name

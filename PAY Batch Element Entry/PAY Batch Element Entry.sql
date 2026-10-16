/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PAY Batch Element Entry
-- Description: Batch Element Entry (BEE) batch lines with their batch header, line status, element, input values and validation or transfer messages.
-- Input Values lists the line's values with the input value names of the element in display sequence, which is the order in which BEE assigns Value 1 to Value 15.
-- Use Line Status Error to review lines that failed validation or transfer before correcting and revalidating the batch.
-- Excel Example Output: https://www.enginatics.com/example/pay-batch-element-entry/
-- Library Link: https://www.enginatics.com/reports/pay-batch-element-entry/
-- Run Report: https://demo.enginatics.com/

select
haouv.name business_group,
pbh.batch_name,
pbh.batch_reference,
pbh.batch_source,
xxen_util.meaning(pbh.batch_status,'BATCH_STATUS',3) batch_status,
xxen_util.meaning(pbh.action_if_exists,'ACTION_IF_EXISTS',3) action_if_exists,
pbl.batch_sequence,
xxen_util.meaning(pbl.batch_line_status,'BATCH_STATUS',3) line_status,
nvl(paaf.assignment_number,pbl.assignment_number) assignment_number,
(select papf.full_name from per_all_people_f papf where paaf.person_id=papf.person_id and pbl.effective_date between papf.effective_start_date and papf.effective_end_date) employee_name,
(select papf.employee_number from per_all_people_f papf where paaf.person_id=papf.person_id and pbl.effective_date between papf.effective_start_date and papf.effective_end_date) employee_number,
nvl((select petfv.element_name from pay_element_types_f_vl petfv where pbl.element_type_id=petfv.element_type_id and pbl.effective_date between petfv.effective_start_date and petfv.effective_end_date),pbl.element_name) element_name,
xxen_util.meaning(pbl.entry_type,'ENTRY_TYPE',3) entry_type,
pbl.effective_date,
pbl.date_earned,
pbl.effective_start_date,
pbl.effective_end_date,
(
select
listagg(x.name||': '||decode(x.rn,1,pbl.value_1,2,pbl.value_2,3,pbl.value_3,4,pbl.value_4,5,pbl.value_5,6,pbl.value_6,7,pbl.value_7,8,pbl.value_8,9,pbl.value_9,10,pbl.value_10,11,pbl.value_11,12,pbl.value_12,13,pbl.value_13,14,pbl.value_14,15,pbl.value_15),'; ') within group (order by x.rn)
from
(
select
y.element_type_id,
y.name,
row_number() over (partition by y.element_type_id order by y.display_sequence, y.name) rn
from
(
select
pivfv.element_type_id,
max(pivfv.name) keep (dense_rank last order by pivfv.effective_start_date) name,
max(pivfv.display_sequence) keep (dense_rank last order by pivfv.effective_start_date) display_sequence
from
pay_input_values_f_vl pivfv
group by
pivfv.element_type_id,
pivfv.input_value_id
) y
) x
where
pbl.element_type_id=x.element_type_id and
decode(x.rn,1,pbl.value_1,2,pbl.value_2,3,pbl.value_3,4,pbl.value_4,5,pbl.value_5,6,pbl.value_6,7,pbl.value_7,8,pbl.value_8,9,pbl.value_9,10,pbl.value_10,11,pbl.value_11,12,pbl.value_12,13,pbl.value_13,14,pbl.value_14,15,pbl.value_15) is not null
) input_values,
pbl.concatenated_segments cost_allocation,
pbl.reason,
(select count(*) from pay_message_lines pml where pbl.batch_line_id=pml.source_id and pml.source_type='L') line_messages,
(select max(pml.line_text) keep (dense_rank first order by pml.line_sequence) from pay_message_lines pml where pbl.batch_line_id=pml.source_id and pml.source_type='L') line_message,
(select max(pml.line_text) keep (dense_rank first order by pml.line_sequence) from pay_message_lines pml where pbh.batch_id=pml.source_id and pml.source_type='H') batch_message,
xxen_util.user_name(pbh.created_by) batch_created_by,
xxen_util.client_time(pbh.creation_date) batch_creation_date
from
pay_batch_headers pbh,
hr_all_organization_units_vl haouv,
pay_batch_lines pbl,
per_all_assignments_f paaf
where
1=1 and
pbh.business_group_id=haouv.organization_id and
pbh.batch_id=pbl.batch_id and
pbl.assignment_id=paaf.assignment_id(+) and
pbl.effective_date between paaf.effective_start_date(+) and paaf.effective_end_date(+)
order by
haouv.name,
pbh.batch_name,
pbh.batch_id,
pbl.batch_sequence,
pbl.batch_line_id

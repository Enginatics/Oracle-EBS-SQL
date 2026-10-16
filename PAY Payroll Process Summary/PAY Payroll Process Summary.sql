/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PAY Payroll Process Summary
-- Description: Payroll processes (payroll actions) of all action types with their assignment action counts by status, the number of messages and the first message, for monitoring payroll runs, prepayments, costing, transfers to the ledger and other payroll processes.
-- Messages counts the process level and assignment action level messages. First Message is the first process level message, or else the first fatal assignment action message.
-- Use Errors Only to list processes in error or with assignment actions in error, for example as a scheduled alert.
-- Excel Example Output: https://www.enginatics.com/example/pay-payroll-process-summary/
-- Library Link: https://www.enginatics.com/reports/pay-payroll-process-summary/
-- Run Report: https://demo.enginatics.com/

select
x.business_group,
x.payroll,
x.action_type,
x.action_status,
x.effective_date,
x.date_earned,
x.period_name,
x.display_run_number,
x.consolidation_set,
x.element_set,
x.assignment_set,
x.batch_name,
x.request_id,
x.program,
x.requested_by,
x.actual_start_date,
x.actual_completion_date,
x.assignment_actions,
x.complete,
x.in_error,
x.marked_for_retry,
x.unprocessed,
x.skipped,
x.messages,
x.first_message,
x.created_by,
x.creation_date
from
(
select
haouv.name business_group,
(select pap.payroll_name from pay_all_payrolls_f pap where ppa.payroll_id=pap.payroll_id and ppa.effective_date between pap.effective_start_date and pap.effective_end_date) payroll,
xxen_util.meaning(ppa.action_type,'ACTION_TYPE',3) action_type,
xxen_util.meaning(ppa.action_status,'ACTION_STATUS',3) action_status,
ppa.action_status action_status_code,
ppa.effective_date,
ppa.date_earned,
ptp.period_name,
ppa.display_run_number,
(select pcs.consolidation_set_name from pay_consolidation_sets pcs where ppa.consolidation_set_id=pcs.consolidation_set_id) consolidation_set,
(select pes.element_set_name from pay_element_sets pes where ppa.element_set_id=pes.element_set_id) element_set,
(select has.assignment_set_name from hr_assignment_sets has where ppa.assignment_set_id=has.assignment_set_id) assignment_set,
(select pbh.batch_name from pay_batch_headers pbh where ppa.batch_id=pbh.batch_id) batch_name,
ppa.request_id,
fcpv.user_concurrent_program_name program,
xxen_util.user_name(fcr.requested_by) requested_by,
fcr.actual_start_date,
fcr.actual_completion_date,
paa.assignment_actions,
paa.complete,
paa.in_error,
paa.marked_for_retry,
paa.unprocessed,
paa.skipped,
(select count(*) from pay_message_lines pml where ppa.payroll_action_id=pml.source_id and pml.source_type='P')+
(select count(*) from pay_assignment_actions paa2, pay_message_lines pml where ppa.payroll_action_id=paa2.payroll_action_id and paa2.assignment_action_id=pml.source_id and pml.source_type='A') messages,
coalesce(
(select max(pml.line_text) keep (dense_rank first order by pml.line_sequence) from pay_message_lines pml where ppa.payroll_action_id=pml.source_id and pml.source_type='P'),
(select max(pml.line_text) keep (dense_rank first order by pml.line_sequence) from pay_assignment_actions paa2, pay_message_lines pml where ppa.payroll_action_id=paa2.payroll_action_id and paa2.assignment_action_id=pml.source_id and pml.source_type='A' and pml.message_level='F')
) first_message,
xxen_util.user_name(ppa.created_by) created_by,
xxen_util.client_time(ppa.creation_date) creation_date
from
pay_payroll_actions ppa,
hr_all_organization_units_vl haouv,
per_time_periods ptp,
fnd_concurrent_requests fcr,
fnd_concurrent_programs_vl fcpv,
(
select
paa.payroll_action_id,
count(*) assignment_actions,
count(decode(paa.action_status,'C',1)) complete,
count(decode(paa.action_status,'E',1)) in_error,
count(decode(paa.action_status,'M',1)) marked_for_retry,
count(decode(paa.action_status,'U',1)) unprocessed,
count(decode(paa.action_status,'S',1)) skipped
from
pay_assignment_actions paa
group by
paa.payroll_action_id
) paa
where
1=1 and
ppa.business_group_id=haouv.organization_id and
ppa.time_period_id=ptp.time_period_id(+) and
ppa.request_id=fcr.request_id(+) and
fcr.program_application_id=fcpv.application_id(+) and
fcr.concurrent_program_id=fcpv.concurrent_program_id(+) and
ppa.payroll_action_id=paa.payroll_action_id(+)
) x
where
2=2
order by
x.effective_date desc,
x.business_group,
x.payroll,
x.action_type,
x.request_id

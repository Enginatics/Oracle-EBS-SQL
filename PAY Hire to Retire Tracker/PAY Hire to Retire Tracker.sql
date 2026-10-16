/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PAY Hire to Retire Tracker
-- Description: One row per employee period of service that overlaps the period from Date From to Date To: new hires, leavers and everyone employed in between, with the date of each step from hire to the first payment, the termination dates, and the payroll processing exceptions of the period.
-- Assignment columns are those of the primary assignment on Date To, or on the termination date for a leaver. New Hire and Leaver mark a hire or termination date within the period.
-- Payroll Ready Date is the later of the hire date and the dates the payroll and the first approved salary were entered. First Period Cut Off and First Period Pay Date are the cut-off and the regular payment date of the first pay period whose cut-off is on or after the hire date. Payment dates are those of completed cheque, magnetic transfer, cash or manual payments.
-- Missed Run Date is the date of the payroll's last run in the period when the assignment was processable on that payroll but was not processed in that pay period or later. Unpaid Prepayment Date and Unpaid Amount are prepayments of the period that no completed payment pays. Process Errors counts payroll processes in error or marked for retry in the period; Error Date, Error Process and Error Message describe the latest.
-- Retro Pending Date is the earliest reprocess date of a retropay request not yet processed. Run After Termination is the last run date when that run was for a pay period starting after the last standard process date, or after the termination date when there is none.
-- Excel Example Output: https://www.enginatics.com/example/pay-hire-to-retire-tracker/
-- Library Link: https://www.enginatics.com/reports/pay-hire-to-retire-tracker/
-- Run Report: https://demo.enginatics.com/

select
x.business_group,
x.employee_number,
x.employee_name,
x.assignment_number,
x.organization,
x.job,
x.location,
x.supervisor,
x.payroll,
x.salary_basis,
x.salary,
x.assignment_status,
x.statutory_information,
x.payment_method,
x.hire_date,
xxen_util.yes(x.new_hire) new_hire,
case when x.new_hire='Y' then greatest(x.hire_date,x.payroll_entered,nvl2(x.salary_basis,x.salary_entered,x.hire_date)) end payroll_ready_date,
x.first_period_cut_off,
x.first_period_pay_date,
case when x.new_hire='Y' then x.first_run_date end first_payroll_run_date,
case when x.new_hire='Y' then x.first_payment_date end first_payment_date,
x.last_run_date last_payroll_run_date,
x.last_payment_date,
case when x.payroll_period_start>greatest(x.hire_date,nvl(x.last_run_period_start,x.hire_date)) and
coalesce(x.last_standard_process_date,x.termination_date,x.payroll_period_start)>=x.payroll_period_start and
(
select
'Y'
from
per_all_assignments_f paaf,
per_assignment_status_types past
where
x.assignment_id=paaf.assignment_id and
x.payroll_date_earned between paaf.effective_start_date and paaf.effective_end_date and
x.payroll_id=paaf.payroll_id and
paaf.assignment_status_type_id=past.assignment_status_type_id and
past.pay_system_status='P'
)='Y'
then x.payroll_last_run_date end missed_run_date,
x.unpaid_prepayment_date,
x.unpaid_amount,
nullif(x.process_errors,0) process_errors,
x.error_date,
xxen_util.meaning(x.error_action_type,'ACTION_TYPE',3) error_process,
trim(x.error_line1||' '||x.error_line2) error_message,
x.retro_pending_date,
x.termination_date,
xxen_util.yes(x.leaver) leaver,
x.leaving_reason,
x.last_standard_process_date,
x.final_process_date,
case when x.last_run_period_start>nvl(x.last_standard_process_date,x.termination_date) then x.last_run_date end run_after_termination
from
(
select /*+ no_push_pred(y) no_push_pred(z) */
haouv.name business_group,
papf.employee_number,
papf.full_name employee_name,
paaf.assignment_number,
(select haouv2.name from hr_all_organization_units_vl haouv2 where paaf.organization_id=haouv2.organization_id) organization,
(select pjv.name from per_jobs_vl pjv where paaf.job_id=pjv.job_id) job,
(select hlav.location_code from hr_locations_all_vl hlav where paaf.location_id=hlav.location_id) location,
(select papf2.full_name from per_all_people_f papf2 where paaf.supervisor_id=papf2.person_id and ppos.as_of_date between papf2.effective_start_date and papf2.effective_end_date) supervisor,
(select paypf.payroll_name from pay_all_payrolls_f paypf where paaf.payroll_id=paypf.payroll_id and ppos.as_of_date between paypf.effective_start_date and paypf.effective_end_date) payroll,
(select ppb.name from per_pay_bases ppb where paaf.pay_basis_id=ppb.pay_basis_id) salary_basis,
(select max(ppp.proposed_salary_n) keep (dense_rank last order by ppp.change_date) from per_pay_proposals ppp where paaf.assignment_id=ppp.assignment_id and ppp.approved='Y' and ppp.change_date<=ppos.as_of_date) salary,
(select pastv.user_status from per_assignment_status_types_v pastv where paaf.assignment_status_type_id=pastv.assignment_status_type_id) assignment_status,
(select hsck.concatenated_segments from hr_soft_coding_keyflex hsck where paaf.soft_coding_keyflex_id=hsck.soft_coding_keyflex_id) statutory_information,
(
select
listagg(popmft.org_payment_method_name,', ') within group (order by pppmf.priority)
from
pay_personal_payment_methods_f pppmf,
pay_org_payment_methods_f_tl popmft
where
paaf.assignment_id=pppmf.assignment_id and
ppos.as_of_date between pppmf.effective_start_date and pppmf.effective_end_date and
pppmf.payee_id is null and
pppmf.org_payment_method_id=popmft.org_payment_method_id and
popmft.language=userenv('lang')
) payment_method,
ppos.date_start hire_date,
case when ppos.date_start>=trunc(:date_from) then 'Y' end new_hire,
case when ppos.date_start>=trunc(:date_from) then (select min(trunc(paaf2.creation_date)) from per_all_assignments_f paaf2 where paaf.assignment_id=paaf2.assignment_id and paaf2.payroll_id is not null) end payroll_entered,
case when ppos.date_start>=trunc(:date_from) then (select min(trunc(ppp.creation_date)) from per_pay_proposals ppp where paaf.assignment_id=ppp.assignment_id and ppp.approved='Y') end salary_entered,
case when ppos.date_start>=trunc(:date_from) then
(
select
min(nvl(ptp.cut_off_date,ptp.end_date))
from
per_time_periods ptp
where
paaf.payroll_id=ptp.payroll_id and
nvl(ptp.cut_off_date,ptp.end_date)>=ppos.date_start
)
end first_period_cut_off,
case when ppos.date_start>=trunc(:date_from) then
(
select
min(ptp.regular_payment_date) keep (dense_rank first order by ptp.start_date)
from
per_time_periods ptp
where
paaf.payroll_id=ptp.payroll_id and
nvl(ptp.cut_off_date,ptp.end_date)>=ppos.date_start
)
end first_period_pay_date,
y.first_run_date,
y.first_payment_date,
y.last_run_date,
(select ptp.start_date from per_time_periods ptp where y.last_run_period_id=ptp.time_period_id) last_run_period_start,
y.last_payment_date,
y.unpaid_prepayment_date,
y.unpaid_amount,
y.process_errors,
y.error_date,
y.error_action_type,
(select min(pml.line_text) keep (dense_rank first order by pml.line_sequence) from pay_message_lines pml where y.error_action_id=pml.source_id and pml.source_type='A') error_line1,
(
select
min(pml.line_text) keep (dense_rank first order by pml.line_sequence)
from
pay_message_lines pml
where
y.error_action_id=pml.source_id and
pml.source_type='A' and
pml.line_sequence>(select min(pml2.line_sequence) from pay_message_lines pml2 where y.error_action_id=pml2.source_id and pml2.source_type='A')
) error_line2,
(select min(pra.reprocess_date) from pay_retro_assignments pra where paaf.assignment_id=pra.assignment_id and pra.retro_assignment_action_id is null and pra.superseding_retro_asg_id is null) retro_pending_date,
ppos.actual_termination_date termination_date,
case when ppos.actual_termination_date<trunc(:date_to)+1 then 'Y' end leaver,
xxen_util.meaning(ppos.leaving_reason,'LEAVING_REASON',3) leaving_reason,
ppos.last_standard_process_date,
ppos.final_process_date,
paaf.assignment_id,
paaf.payroll_id,
z.payroll_last_run_date,
z.payroll_date_earned,
z.payroll_period_start
from
(
select
ppos.*,
least(nvl(ppos.actual_termination_date,trunc(:date_to)),trunc(:date_to)) as_of_date
from
per_periods_of_service ppos
where
ppos.date_start<trunc(:date_to)+1 and
(ppos.actual_termination_date is null or ppos.actual_termination_date>=trunc(:date_from))
) ppos,
hr_all_organization_units_vl haouv,
per_all_people_f papf,
per_all_assignments_f paaf,
(
select
v.assignment_id,
min(case when v.action_type in ('R','Q') and v.action_status='C' then v.effective_date end) first_run_date,
max(case when v.action_type in ('R','Q') and v.action_status='C' then v.effective_date end) last_run_date,
max(case when v.action_type in ('R','Q') and v.action_status='C' then v.time_period_id end) keep (dense_rank last order by case when v.action_type in ('R','Q') and v.action_status='C' then v.effective_date end nulls first) last_run_period_id,
min(case when v.pre_payment_id is not null and v.action_status='C' then v.effective_date end) first_payment_date,
max(case when v.pre_payment_id is not null and v.action_status='C' then v.effective_date end) last_payment_date,
min(case when v.unpaid_amount<>0 then v.effective_date end) unpaid_prepayment_date,
sum(v.unpaid_amount) unpaid_amount,
count(case when v.action_status in ('E','M') then 1 end) process_errors,
max(case when v.action_status in ('E','M') then v.effective_date end) error_date,
max(case when v.action_status in ('E','M') then v.assignment_action_id end) error_action_id,
max(case when v.action_status in ('E','M') then v.action_type end) keep (dense_rank last order by case when v.action_status in ('E','M') then v.assignment_action_id end nulls first) error_action_type
from
(
select
paa.assignment_id,
paa.assignment_action_id,
paa.action_status,
paa.pre_payment_id,
ppa.action_type,
ppa.effective_date,
ppa.time_period_id,
case when ppa.action_type in ('P','U') and paa.action_status='C' then
(
select
sum(ppp.value)
from
pay_pre_payments ppp
where
paa.assignment_action_id=ppp.assignment_action_id and
not exists (select null from pay_assignment_actions paa2 where ppp.pre_payment_id=paa2.pre_payment_id and paa2.action_status='C')
)
end unpaid_amount
from
pay_payroll_actions ppa,
pay_assignment_actions paa
where
ppa.effective_date>=trunc(:date_from) and
ppa.effective_date<trunc(:date_to)+1 and
2=2 and
ppa.payroll_action_id=paa.payroll_action_id
) v
group by
v.assignment_id
) y,
(
select
ppa.payroll_id,
max(ppa.effective_date) payroll_last_run_date,
max(ppa.date_earned) keep (dense_rank last order by ppa.effective_date) payroll_date_earned,
max(ptp.start_date) keep (dense_rank last order by ppa.effective_date) payroll_period_start
from
pay_payroll_actions ppa,
per_time_periods ptp
where
ppa.action_type='R' and
ppa.action_status='C' and
ppa.effective_date>=trunc(:date_from) and
ppa.effective_date<trunc(:date_to)+1 and
ppa.time_period_id=ptp.time_period_id
group by
ppa.payroll_id
) z
where
1=1 and
ppos.business_group_id=haouv.organization_id and
ppos.person_id=papf.person_id and
ppos.as_of_date between papf.effective_start_date and papf.effective_end_date and
ppos.period_of_service_id=paaf.period_of_service_id and
paaf.assignment_type='E' and
paaf.primary_flag='Y' and
ppos.as_of_date between paaf.effective_start_date and paaf.effective_end_date and
paaf.assignment_id=y.assignment_id(+) and
paaf.payroll_id=z.payroll_id(+)
) x
order by
x.business_group,
x.employee_name,
x.hire_date

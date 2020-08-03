/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PAY Employee Bank Accounts
-- Excel Examle Output: https://www.enginatics.com/example/pay-employee-bank-accounts/
-- Library Link: https://www.enginatics.com/reports/pay-employee-bank-accounts/
-- Run Report: https://demo.enginatics.com/

select distinct
      (ron.employee_number)
     ,ron.full_name
     ,ron.effective_start_date
     ,ron.effective_end_date
     ,bnk.bank_name
     ,bnk.branch_name
     ,asg.assignment_number
     ,pay.payroll_name
     ,asg.assignment_type
     ,acc.segment1 branch_code
     ,decode(acc.segment2,'1','Current Account','2','Savings Account','3','Transmission Account','4','Bond','5','Subscription',acc.segment2) acc_type
     ,acc.segment3 acc_number
     ,acc.segment4 payee
     from pay_personal_payment_methods_f met
   ,pay_external_accounts acc
   ,per_all_assignments_f asg
   ,per_all_people_f ron
   ,pay_za_branch_cdv_details bnk
   ,pay_payrolls_f pay
where met.external_account_id    = acc.external_account_id
and    met.assignment_id = asg.assignment_id
and    acc.segment1 = bnk.branch_code(+)
and    ron.person_id = asg.person_id
and    pay.payroll_id = asg.payroll_id
--and    met.effective_start_date <= sysdate
--and    ron.effective_end_date >= sysdate
--and    asg.effective_start_date <= sysdate
---and    ron.effective_end_date >= sysdate
order by ron.employee_number
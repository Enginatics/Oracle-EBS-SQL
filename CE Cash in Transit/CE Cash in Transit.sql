/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CE Cash in Transit
-- Description: Application: Cash Management
Description: Cash in Transit

Provides equivalent functionality to the following standard Oracle Forms/Reports
- Cash in Transit

Applicable Templates:
- Pivot: Cash in Transit - Pivot: Bank Account Currency, Bank Account, In Transit Type, Operating Unit, Third Party (Supplier/Customer) with drill down to details
- Cash In Transit Detail - Detail Extract

Source: Cash in Transit (CEXCSHTR)
DB package: CE_CEXCSHTR_XMLP_PKG (required to initialize security)

-- Excel Examle Output: https://www.enginatics.com/example/ce-cash-in-transit/
-- Library Link: https://www.enginatics.com/reports/ce-cash-in-transit/
-- Run Report: https://demo.enginatics.com/

select
 x.bank_account_currency   bank_account_currency,
 x.bank_account_name       bank_account_name,
 x.bank_account_num        bank_account_number,
 x.bank_name               bank_name,
 x.bank_branch_name        branch_name,
 x.org_name                organization,
 case x.type
 when 'PAYMENTS' then 'Payments in Transit'
 when 'RECEIPTS' then 'Receipts in Transit'
 when 'ROI_LINE' then 'Open-Interface Transactions in Transit'
 when 'PAYROLL'  then 'Payroll Payments in Transit'
 else x.type || ' in Transit'
 end                       in_transit_type,
 x.supplier_customer       "Supplier/Customer/Agent Name",
 x.payment_date            "Payment/Remit/Trx Date",
 x.maturity_date           maturity_date,
 x.payrcpt_num             "Payment/Receipt/Trx Number",
 x.payment_method          "Payment Method/Trx Type",
 x.c_currency_code         currency,
 x.amount                  "Payment/Receipt/Trx Amount",
 x.base_amount             bank_account_amount,
 x.cash_in_transit         net_cash_in_transit,
 x.check_number,
 -- pivot labels
 x.bank_name || ' - ' || x.bank_account_num || ' - ' || x.bank_account_name || ' (' || x.bank_account_currency || ')' bank_account_pivot_label,
 x.org_name organization_pivot_label,
 x.transaction_order in_transit_type_order
from
(
select
 'PAYMENTS' type,
 nvl(c.vendor_name,c.remit_to_supplier_name) supplier_customer,
 ba.bank_account_name bank_account_name,
 ba.bank_account_num bank_account_num,
 ba.currency_code bank_account_currency,
 bb.bank_name,
 bb.bank_branch_name,
 c.check_date payment_date,
 c.future_pay_due_date maturity_date,
 to_char(c.check_number) payrcpt_num,
 pmt.payment_method_name payment_method,
 c.currency_code c_currency_code,
 nvl(c.amount,0) amount,
 decode(c.currency_code,ba.currency_code,nvl(-c.amount,0),nvl(-c.base_amount,0)) cash_in_transit,
 decode(c.currency_code,ba.currency_code,nvl(c.amount,0),nvl(c.base_amount,0)) base_amount,
 c.check_number check_number,
 '20' transaction_order,
 ou.name org_name
from
 ce_bank_accounts        ba,
 ce_bank_branches_v      bb,
 ap_checks_all           c,
 ce_bank_acct_uses_all   bau,
 ce_security_profiles_gt ou,
 ce_system_parameters    sys,
 iby_payment_methods_vl  pmt,
 ap_payment_history_all  apha
where
    bb.branch_party_id        = ba.bank_branch_id
and ba.bank_account_id        = bau.bank_account_id
and c.payment_method_code     = pmt.payment_method_code
and apha.check_id             = c.check_id
and apha.accounting_date     <= nvl(:p_as_of_date, trunc(sysdate))
and not exists
  (select null
   from   ap_payment_history_all aph2
   where  aph2.check_id        = c.check_id
     and aph2.creation_date    > apha.creation_date
     and aph2.accounting_date <= nvl(:p_as_of_date, trunc(sysdate))
  )
and apha.transaction_type not in('PAYMENT CLEARING', 'PAYMENT CANCELLED','PAYMENT CLEARING ADJUSTED','REFUND CANCELLED')
and c.status_lookup_code  not in ('RECONCILED','CLEARED')
and bau.bank_acct_use_id      = c.ce_bank_acct_use_id
and bau.ap_use_enable_flag    = 'Y'
and bau.org_id                = c.org_id
and bau.org_id                = ou.organization_id
and ou.organization_type      = 'OPERATING_UNIT'
and ba.account_owner_org_id   = sys.legal_entity_id
and trunc(c.check_date)      <= nvl(:p_as_of_date, trunc(sysdate))
and c.check_date             >= sys.cashbook_begin_date
and case
    when c.remit_to_supplier_id is not null and c.remit_to_supplier_id = decode(c.status_lookup_code,'SET UP', -1, 'SPOILED' , -2 , c.remit_to_supplier_id) then 1
    when nvl(c.vendor_id,-1) = decode(c.status_lookup_code,'SET UP', -1, 'SPOILED' , -2 , nvl(c.vendor_id,-1)) then 1
    end = 1
and :p_type                  in ('AR_AND_AP', 'PAYMENTS', 'ALL')
and ou.name                   = nvl(ou.name,ou.name)
--
union all
--
select
 'RECEIPTS'	type,
	hz.party_name	supplier_customer,
	ba.bank_account_name	bank_account_name,
	ba.bank_account_num	bank_account_num,
	ba.currency_code	bank_account_currency,
 bb.bank_name,
 bb.bank_branch_name,
	acrh.trx_date payment_date,
	ps.due_date	maturity_date,
	acr.receipt_number	payrcpt_num,
	arm.name	payment_method,
	acr.currency_code	c_currency_code,
	nvl(acrh.amount,0)	amount,
	decode(acr.currency_code,ba.currency_code,nvl(acrh.amount,0),nvl(acrh.acctd_amount,0)) cash_in_transit,
	decode(acr.currency_code,ba.currency_code,nvl(acrh.amount,0),nvl(acrh.acctd_amount,0)) base_amount,
	0	check_number,
	'10'	transaction_order,
	ou.name  org_name
from
 ar_receipt_methods		    		  arm,
	ar_payment_schedules_all		  ps,
	ce_bank_accounts				        ba,
	ce_bank_branches_v 			      bb,
 hz_cust_accounts            cu,
	hz_parties 				             hz,
	ar_cash_receipts 				       acr,
	ar_cash_receipt_history_all acrh,
	ce_bank_acct_uses_all 			   bau,
	ce_security_profiles_gt			  ou,
	ce_system_parameters			     sys
where
    arm.receipt_method_id 			= acr.receipt_method_id
and	cu.cust_account_id(+)		 	= acr.pay_from_customer
and hz.party_id(+) 			      	= cu.party_id
and	ba.bank_branch_id 				   = bb.branch_party_id
and	ba.bank_account_id 				  = bau.bank_account_id
and bau.bank_acct_use_id		  	= acr.remit_bank_acct_use_id
and	bau.org_id 			          	= acr.org_id
and bau.org_id 		          		= ou.organization_id
and ou.organization_type 	  	= 'OPERATING_UNIT'
and ba.account_owner_org_id 	= sys.legal_entity_id
and	acr.type 		          			in ('CASH','MISC')
and	ps.cash_receipt_id (+) 		= acrh.cash_receipt_id
and acr.cash_receipt_id 				 = acrh.cash_receipt_id
and acrh.status              = 'REMITTED'
and acrh.trx_date           <= nvl(:p_as_of_date, sysdate)
and not exists
  (select 'x'
   from   ar_cash_receipt_history_all acrh2
   where  acrh2.cash_receipt_id = acr.cash_receipt_id
   and    acrh2.status         in('CLEARED','REVERSED')
   and    acrh2.trx_date       <= nvl(:p_as_of_date, sysdate)
   and    acrh2.trx_date       >= acrh.trx_date
  )
and	acr.receipt_date			   	 <= nvl(:p_as_of_date,sysdate)
and	acrh.trx_date			       	>= sys.cashbook_begin_date
and	:p_type                 in ('AR_AND_AP', 'RECEIPTS','ALL')
and ou.name                  = nvl(ou.name,ou.name)
--
union all
--
select
 'ROI_LINE'	type,
	null	supplier_customer,
	ba.bank_account_name	bank_account_name,
	ba.bank_account_num	bank_account_num,
	ba.currency_code	bank_account_currency,
 bb.bank_name,
 bb.bank_branch_name,
	roi.trx_date	payment_date,
	to_date(null)	maturity_date,
	roi.trx_number	payrcpt_num,
	trx_type_dsp	payment_method,
	roi.currency_code	c_currency_code,
	nvl(roi.amount,0)	amount,
	decode(roi.currency_code
       ,ba.currency_code, decode(roi.trx_type, 'PAYMENT', nvl(-roi.amount,0), nvl(roi.amount, 0))
                        , decode(roi.trx_type, 'PAYMENT', nvl(-roi.acctd_amount,0), nvl(roi.acctd_amount,0))
       )	cash_in_transit,
	decode(roi.currency_code,ba.currency_code, nvl(roi.amount,0),nvl(roi.acctd_amount,0)) base_amount,
	0	check_number,
	'30'	transaction_order,
	null org_name
from
 ce_999_interface_v			   roi,
	ce_bank_accts_gt_v			   ba,
 ce_bank_branches_v      bb,
	ce_system_parameters			 sys,
 ce_statement_recon_gt_v cre
where
    ba.bank_branch_id 				           = bb.branch_party_id
and	ba.bank_account_id	 			          = roi.bank_account_id
and ba.account_owner_org_id 			      = sys.legal_entity_id
and	ba.RECON_ENABLE_OI_FLAG			       = 'Y'
and roi.status	 				                 = ba.recon_oi_float_status
and	roi.trx_date 				               <= nvl(:p_as_of_date, sysdate)
and	roi.trx_date				                >= sys.cashbook_begin_date
and	cre.reference_id             (+)	= roi.trx_id
and	cre.reference_type           (+) = 'ROI_LINE'
and	nvl(cre.status_flag,'U') 			     = 'U'
and	nvl(cre.current_record_flag,'Y') = 'Y'
and :p_type                         in ('ROI_LINES', 'ALL')
--
union all --  Payroll Payments
--
select
 'PAYROLL'	type,
	null	supplier_customer,
	ba.bank_account_name	bank_account_name,
	ba.bank_account_num	bank_account_num,
	ba.currency_code	bank_account_currency,
 bb.bank_name,
 bb.bank_branch_name,
	ppa.effective_date	payment_date,
	to_date(null)	maturity_date,
	paa.serial_number	payrcpt_num,
	popm.org_payment_method_name	payment_method,
	popm.currency_code	c_currency_code,
	ppp.value	amount,
	decode(popm.currency_code,ba.currency_code,nvl(-ppp.value,0),nvl(-ppp.base_currency_value,0)) cash_in_transit,
	decode(popm.currency_code,ba.currency_code,nvl(ppp.value,0),nvl(ppp.base_currency_value,0)) base_amount,
	0 check_number,
	'40'	transaction_order,
	ou.name org_name
FROM
 ce_bank_branches_v		       bb,
	ce_bank_accounts		         ba,
	gl_sets_of_books			        sob,
	ce_system_parameters	     	sys,
	pay_ce_reconciled_payments	pcrp,
	pay_pre_payments		         ppp,
	pay_assignment_actions		   paa,
	pay_payroll_actions		      ppa,
	pay_org_payment_methods_f	 popm,
	ce_bank_acct_uses_all 			  bau,
	ce_security_profiles_gt			 ou,
	pay_payment_types          ppt
where
    bb.branch_party_id 				           = ba.bank_branch_id
and	ba.bank_account_id 				           = bau.bank_account_id
and	bau.payroll_bank_account_id 			   = popm.external_account_id
and bau.org_id                        = ou.organization_id
and ou.organization_type              = 'BUSINESS_GROUP'
and ba.account_owner_org_id 			       = sys.legal_entity_id
and	sys.set_of_books_id			           	= sob.set_of_books_id
and	pcrp.assignment_action_id     (+)	= paa.assignment_action_id
and ppp.org_payment_method_id 			     = popm.org_payment_method_id
and	ppa.payroll_action_id				         = paa.payroll_action_id
and	paa.pre_payment_id 				           = ppp.pre_payment_id
and ppt.payment_type_id          			  = popm.payment_type_id	--9495956
and	ppa.action_type                  in ( 'P', 'H', 'E','M')
and (   ppa.action_type   <> 'E'
     or (ppa.action_type   = 'E' and paa.serial_number not in ('-1','-2'))
    )
and (   (ppa.action_type  != 'M')
     or (ppa.action_type   = 'M' and ppt.reconciliation_function is not null)
    )
and paa.action_status                in ('C', 'V')
and (   (    (pcrp.cleared_date is null )
         or  (pcrp.cleared_date  > nvl(:p_as_of_date, sysdate) )
        )
     or (    (paa.action_status  = 'V')
         and (ppa.effective_date > nvl(:p_as_of_date, sysdate) )
        )
    )
and	ppa.effective_date		             <= nvl(:p_as_of_date, sysdate)
and	ppa.effective_date		             >= sys.cashbook_begin_date
and ppa.effective_date          between popm.effective_start_date and popm.effective_end_date
and not exists
      (select *
       from   pay_action_interlocks pai
       where  pai.locked_action_id = paa.assignment_action_id
      )
and	:p_type                          IN ( 'PAYROLLS','ALL')
and ou.name                           = nvl(:p_business_group,ou.name)
--
union all --  Voided Payroll Payments
--
select
 'PAYROLL'	type,
	null	supplier_customer,
	ba.bank_account_name	bank_account_name,
	ba.bank_account_num	bank_account_num,
	ba.currency_code	bank_account_currency,
 bb.bank_name,
 bb.bank_branch_name,
	ppa.effective_date	payment_date,
	to_date(null)	maturity_date,
	paa.serial_number	payrcpt_num,
	popm.org_payment_method_name	payment_method,
	popm.currency_code	c_currency_code,
	ppp.value	amount,
	decode(popm.currency_code,ba.currency_code,nvl(-ppp.value,0),nvl(-ppp.base_currency_value,0)) cash_in_transit,
	decode(popm.currency_code,ba.currency_code,nvl(ppp.value,0),nvl(ppp.base_currency_value,0)) base_amount,
 0 check_number,
	'40'	transaction_order,
	ou.name org_name
from
 ce_bank_branches_v		       bb,
	ce_bank_accounts		         ba,
	gl_sets_of_books		         sob,
	ce_system_parameters		     sys,
	pay_ce_reconciled_payments	pcrp,
	pay_pre_payments		         ppp,
	pay_assignment_actions		   paa,
	pay_payroll_actions		      ppa,
	pay_org_payment_methods_f	 popm,
 pay_action_interlocks   		 pai,
	ce_bank_acct_uses_all 		 	 bau,
	ce_security_profiles_gt		  ou
where
    bb.branch_party_id 				                  = ba.bank_branch_id
and	ba.bank_account_id 				                  = bau.bank_account_id
and	bau.payroll_bank_account_id 			          = popm.external_account_id
and bau.org_id                               = ou.organization_id
and ou.organization_type                     = 'BUSINESS_GROUP'
and ba.account_owner_org_id 			              = sys.legal_entity_id
and	sys.set_of_books_id				                  = sob.set_of_books_id
and	pcrp.assignment_action_id            (+)	= paa.assignment_action_id
and ppp.org_payment_method_id 			            = popm.org_payment_method_id
and	ppa.payroll_action_id				                = paa.payroll_action_id
and	paa.pre_payment_id 				                  = ppp.pre_payment_id
and	ppa.action_type                          = 'H'
and paa.action_status                        = 'C'
and	nvl(ppa.date_earned,ppa.effective_date)	<= nvl(:p_as_of_date, sysdate)
and	nvl(ppa.date_earned,ppa.effective_date)	>= sys.cashbook_begin_date
and pai.locked_action_id 			                 = paa.assignment_action_id
and ppa.effective_date                 between popm.effective_start_date and popm.effective_end_date
and	exists
     (select *
      from   pay_assignment_actions paa2,
             pay_payroll_actions ppa2
      where  paa2.assignment_action_id = pai.locking_action_id
      and    paa2.payroll_action_id    = ppa2.payroll_action_id
      and    ppa2.effective_date       > nvl(:p_as_of_date, sysdate)
      and    ppa2.action_type          = 'D'
     )
and	:p_type                                 in ( 'PAYROLLS','ALL')
and ou.name                                  = nvl(:p_business_group,ou.name)
) x
where
1=1
order by
 x.bank_account_currency,
 x.bank_account_name,
 x.bank_account_num,
 x.transaction_order,
 x.org_name,
 x.check_number,
 x.payrcpt_num
/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Receipt Register
-- Description: Application: Receivables
Description: Receivables Receipt Register

Provided Templates:
Default: Detail - Detail Listing with no Pivot Summarization
Pivot: Summary by Receipt Date - Summary by Balancing Segment, Receipt Currency, Receipt Date
Pivot: Summary by Receipt Status - Summary by Balancing Segment, Receipt Status
Pivot: Summary by Batch - Summary by Balancing Segment, Receipt Currency, Batch
Pivot: Summary by Customer Name - Summary by Balancing Segment, Receipt Currency, Customer
Pivot: Summary by Debit Account - Summary by Balancing Segment, Account Segment, Debit Account, Receipt Currency
Pivot: Summary by GL Date - Summary by Balancing Segment, Receipt Currency, GL Date

Source: Receipt Register
Short Name: ARRXRCRG/RXARRCRG

-- Excel Examle Output: https://www.enginatics.com/example/ar-receipt-register/
-- Library Link: https://www.enginatics.com/reports/ar-receipt-register/
-- Run Report: https://demo.enginatics.com/

select
 x.*
from
(
select /*+ push_pred(araa, araa2) */
 gl.name  ledger,
 gl.currency_code ledger_currency,
 haou.name  operating_unit,
 substrb(hp.party_name,1,240) customer_name,
 hca.account_number customer_number,
 decode(hp.party_type,'ORGANIZATION',hp.organization_name_phonetic, null) customer_name_alt,
 hcsua.location customer_location,
 hz_format_pub.format_address(hps.location_id,null,null,' , ') customer_address,
 ftv2.territory_short_name customer_country,
 hp.jgzz_fiscal_code customer_tax_number,
 nvl(ac2.name,ac.name) collector,
 ac.name collector_account,
 ac2.name collector_site,
  -- Receipt Main Details
 decode(acrha.status, 'REVERSED', aba.name, aba.name) batch_name,
 absa.name batch_source,
 acra.receipt_number,
 acra.receipt_date,
 acrha.gl_date,
 xxen_util.meaning(acra.type,'PAYMENT_CATEGORY_TYPE',222) receipt_type,
 arm.name receipt_method,
 case when acra.status in ('REV', 'NSF', 'STOP') and acrha.status <> 'REVERSED'
 then case :p_mrc_flag
      when 'R'
      then (select
             case
             when sum(decode(araa2.status,'UNID',araa2.amount_applied,0)) != 0
             then xxen_util.meaning('UNID','CHECK_STATUS',222)
             when sum(decode(araa2.status,'UNAPP',araa2.amount_applied,0)) != 0
             then xxen_util.meaning('UNAPP','CHECK_STATUS',222)
             else xxen_util.meaning('APP','CHECK_STATUS',222)
             end
            from
              ar_receivable_apps_all_mrc_v araa2
            where
              araa2.cash_receipt_id = acra.cash_receipt_id
           )
      else (select
             case
             when sum(decode(araa2.status,'UNID',araa2.amount_applied,0)) != 0
             then xxen_util.meaning('UNID','CHECK_STATUS',222)
             when sum(decode(araa2.status,'UNAPP',araa2.amount_applied,0)) != 0
             then xxen_util.meaning('UNAPP','CHECK_STATUS',222)
             else xxen_util.meaning('APP','CHECK_STATUS',222)
             end
            from
              ar_receivable_applications_all araa2
            where
              araa2.cash_receipt_id = acra.cash_receipt_id
           )
      end
 else xxen_util.meaning(acra.status,'CHECK_STATUS',222)
 end  receipt_status,
 xxen_util.meaning(acrha.status,'RECEIPT_CREATION_STATUS',222) receipt_history_status,
 acra.currency_code receipt_currency,
 decode(acrha.status,
        'REVERSED',decode(acrha3.cash_receipt_history_id , acrha.cash_receipt_history_id, 0 , (nvl(acrha3.amount,0))* -1),
		                 decode(acrha3.cash_receipt_history_id, acrha.cash_receipt_history_id, (acrha.amount), (acrha.amount -(nvl(acrha3.amount,0))))
	      ) +
 decode(acrha.status,
        'REVERSED',decode(acrha3.cash_receipt_history_id , acrha.cash_receipt_history_id, 0, (nvl(acrha3.factor_discount_amount,0))* -1),
		                 decode(acrha3.cash_receipt_history_id ,acrha.cash_receipt_history_id, nvl(acrha.factor_discount_amount,0), (nvl(acrha.factor_discount_amount,0) -(nvl(acrha3.factor_discount_amount,0))))
	      ) receipt_amount,
 decode(acrha.status,
        'REVERSED',decode(acrha3.cash_receipt_history_id , acrha.cash_receipt_history_id, 0, (nvl(acrha3.factor_discount_amount,0))* -1),
		                 decode(acrha3.cash_receipt_history_id ,acrha.cash_receipt_history_id, nvl(acrha.factor_discount_amount,0), (nvl(acrha.factor_discount_amount,0) -(nvl(acrha3.factor_discount_amount,0))))
	      ) factor_discount_amount,
 araa.applied_amount,
 araa.on_account_amount,
 araa.unidentified_amount,
 decode(araa.unapplied_amt,0,to_number(null),araa.unapplied_amt) unapplied_amt,
 case when acra.type = 'MISC'
 then
   decode(acrha.status,
          'REVERSED',decode(acrha3.cash_receipt_history_id , acrha.cash_receipt_history_id, 0 , (nvl(acrha3.amount,0))* -1),
	                    decode(acrha3.cash_receipt_history_id, acrha.cash_receipt_history_id, (acrha.amount), (acrha.amount -(nvl(acrha3.amount,0))))
	        ) +
   decode(acrha.status,
          'REVERSED',decode(acrha3.cash_receipt_history_id , acrha.cash_receipt_history_id, 0, (nvl(acrha3.factor_discount_amount,0))* -1),
		                   decode(acrha3.cash_receipt_history_id ,acrha.cash_receipt_history_id, nvl(acrha.factor_discount_amount,0), (nvl(acrha.factor_discount_amount,0) -(nvl(acrha3.factor_discount_amount,0))))
	   )
	end miscellaneous_amount, 
 araa.cash_claims_amount,
 araa.writeoff_amount,
 araa.refund_amount,
 araa.chargeback_amount,
 araa.short_term_debt_amount,
 araa.earned_discount_taken,
 araa.unearned_discount_taken,
 -- acctd
 decode(acrha.status,
        'REVERSED',decode(acrha3.cash_receipt_history_id , acrha.cash_receipt_history_id, 0, (nvl(acrha3.acctd_amount,0))* -1),
		                 decode(acrha3.cash_receipt_history_id, acrha.cash_receipt_history_id, (acrha.acctd_amount) , (acrha.acctd_amount -(nvl(acrha3.acctd_amount,0))))
	      ) +
 decode(acrha.status,
        'REVERSED',decode(acrha3.cash_receipt_history_id , acrha.cash_receipt_history_id,0, (nvl(acrha3.acctd_factor_discount_amount,0))* -1),
		                 decode(acrha3.cash_receipt_history_id ,acrha.cash_receipt_history_id, nvl(acrha.acctd_factor_discount_amount,0), (nvl(acrha.acctd_factor_discount_amount,0) -(nvl(acrha3.acctd_factor_discount_amount,0))))
	      ) acctd_receipt_amount,
 decode(acrha.status,
        'REVERSED',decode(acrha3.cash_receipt_history_id , acrha.cash_receipt_history_id,0, (nvl(acrha3.acctd_factor_discount_amount,0))* -1),
		                 decode(acrha3.cash_receipt_history_id ,acrha.cash_receipt_history_id, nvl(acrha.acctd_factor_discount_amount,0), (nvl(acrha.acctd_factor_discount_amount,0) -(nvl(acrha3.acctd_factor_discount_amount,0))))
	      ) acctd_factor_discount_amount,
 araa.acctd_applied_amount,
 araa.acctd_on_account_amount,
 araa.acctd_unidentified_amt,
 decode(araa.acctd_unapplied_amt,0,to_number(null),araa.acctd_unapplied_amt) acctd_unapplied_amt,
 case when acra.type = 'MISC'
 then
   decode(acrha.status,
          'REVERSED',decode(acrha3.cash_receipt_history_id , acrha.cash_receipt_history_id, 0, (nvl(acrha3.acctd_amount,0))* -1),
		                   decode(acrha3.cash_receipt_history_id, acrha.cash_receipt_history_id, (acrha.acctd_amount) , (acrha.acctd_amount -(nvl(acrha3.acctd_amount,0))))
	        ) +
   decode(acrha.status,
          'REVERSED',decode(acrha3.cash_receipt_history_id , acrha.cash_receipt_history_id,0, (nvl(acrha3.acctd_factor_discount_amount,0))* -1),
		                   decode(acrha3.cash_receipt_history_id ,acrha.cash_receipt_history_id, nvl(acrha.acctd_factor_discount_amount,0), (nvl(acrha.acctd_factor_discount_amount,0) -(nvl(acrha3.acctd_factor_discount_amount,0))))
	        ) 
 end acctd_miscellaneous_amount,
 araa.acctd_cash_claims_amount,
 araa.acctd_writeoff_amount,
 araa.acctd_refund_amount,
 araa.acctd_chargeback_amount,
 araa.acctd_short_term_debt_amount,
 araa.acctd_earned_discount_taken,
 araa.acctd_unearned_discount_taken,
 araa.acctd_gain_loss,
 --
 (select
  min(trunc(araa.apply_date))
  from
  ar_receivable_applications_all araa
  where
  araa.org_id = acra.org_id and
  araa.cash_receipt_id = acra.cash_receipt_id and
  nvl(araa.confirmed_flag,'Y')='Y' and
  araa.status = 'APP'
 ) first_apply_date,
 (select
  max(trunc(araa.apply_date))
  from
  ar_receivable_applications_all araa,
  ar_payment_schedules_all apsa
  where
  araa.org_id = acra.org_id and
  araa.cash_receipt_id = acra.cash_receipt_id and
  araa.applied_payment_schedule_id = apsa.payment_schedule_id and
  nvl(araa.confirmed_flag,'Y')='Y' and
  araa.status = 'APP' and 
  decode(sign(araa.amount_applied),-1,-1,1) = decode(sign(apsa.amount_due_original),-1,-1,1)
 ) last_apply_date,
 araa2.first_applied_in_full_date,
 (select
  min(trunc(araa.gl_date))
  from
  ar_receivable_applications_all araa
  where
  araa.org_id = acra.org_id and
  araa.cash_receipt_id = acra.cash_receipt_id and
  nvl(araa.confirmed_flag,'Y')='Y' and
  araa.status = 'APP'
 ) first_apply_gl_date,
 (select
  max(trunc(araa.gl_date))
  from
  ar_receivable_applications_all araa,
  ar_payment_schedules_all apsa
  where
  araa.org_id = acra.org_id and
  araa.cash_receipt_id = acra.cash_receipt_id and
  araa.applied_payment_schedule_id = apsa.payment_schedule_id and
  nvl(araa.confirmed_flag,'Y')='Y' and
  araa.status = 'APP' and 
  decode(sign(araa.amount_applied),-1,-1,1) = decode(sign(apsa.amount_due_original),-1,-1,1)
 ) last_apply_gl_date,
 araa2.first_applied_in_full_gl_date,
 -- Additional Receipt Infor
 fds.name doc_sequence_name,
 acra.doc_sequence_value doc_sequence_value,
 acra.creation_date  receipt_creation_date,
 xxen_util.user_name(acra.created_by) receipt_created_by,
 acra.last_update_date receipt_last_updated_date,
 xxen_util.user_name(acra.last_updated_by) receipt_last_updated_by,
 acra.issue_date,
 acra.deposit_date,
 acra.anticipated_clearing_date,
 acra.misc_payment_source,
 xxen_util.meaning(acra.reference_type,'CB_REFERENCE_TYPE',222) reference_type,
 case
  when acra.reference_type='REMITTANCE' then (select ab.name from ar_batches_all ab where acra.reference_id=ab.batch_id)
  when acra.reference_type='RECEIPT' then (select acra.receipt_number from ar_cash_receipts_all acra0 where acra.reference_id=acra0.cash_receipt_id)
  when acra.reference_type='PAYMENT_BATCH' then (select aisca.checkrun_name from ap_inv_selection_criteria_all aisca where acra.reference_id=aisca.checkrun_id)
  when acra.reference_type='PAYMENT' then (select to_char(aca.check_number) from ap_checks_all aca where acra.reference_id=aca.check_id)
  when acra.reference_type='CREDIT_MEMO' then (select rcta.trx_number from ra_customer_trx_all rcta where acra.reference_id=rcta.customer_trx_id)
 end reference_number,
 acra.customer_receipt_reference customer_receipt_reference,
 avta.tax_code,
 acra.exchange_rate,
 acra.exchange_date,
 acra.exchange_rate_type,
 acra.comments receipt_comments,
 acra.application_notes,
 cbbv.bank_name,
 cbbv.bank_name_alt,
 cbbv.bank_number,
 cbbv.bank_branch_name,
 cbbv.bank_branch_name_alt,
 cbbv.branch_number,
 ftv.territory_short_name bank_branch_country,
 cba.bank_account_name,
 cba.bank_account_name_alt,
 cba.masked_account_num bank_account_number,
 cba.currency_code bank_account_currency,
 cba.description bank_account_description,
 -- Debit GL Account Info
 nvl2(gcc.code_combination_id,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'VALUE'),null) debit_account,
 nvl2(gcc.code_combination_id,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'DESCRIPTION'),null) debit_account_desc,
 nvl2(gcc.code_combination_id,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE'),null) balancing_segment,
 nvl2(gcc.code_combination_id,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION'),null) balancing_segment_desc,
 nvl2(gcc.code_combination_id,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE'),null) account_segment,
 nvl2(gcc.code_combination_id,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'DESCRIPTION'),null) account_segment_desc,
 nvl2(gcc.code_combination_id,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'VALUE') || ' - ' ||
                              fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'DESCRIPTION'),null) debit_account_pivot_label,
 nvl2(gcc.code_combination_id,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') || ' - ' ||
                              fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION'),null) bal_seg_pivot_label,
 nvl2(gcc.code_combination_id,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE') || ' - ' ||
                              fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'DESCRIPTION'),null) account_pivot_label,
 hp.party_name || ' - ' || hca.account_number cust_name_pivot_label,
 hca.account_number || ' - ' || hp.party_name cust_number_pivot_label,
 decode(:reporting_level,1000,gl.name,3000,haou.name,null) reporting_entity,
 acra.cash_receipt_id
from
 (select
  araa.org_id,
  araa.cash_receipt_id,
  --
  sum(case araa.status
      when 'APP' then nvl(araa.amount_applied_from,araa.amount_applied)
      when 'ACTIVITY' then decode(araa.receivables_trx_id,-16,araa.amount_applied,null)
      else null
      end
     ) applied_amount,
  sum(case araa.status
      when 'APP' then araa.earned_discount_taken
      when 'ACTIVITY' then decode(araa.receivables_trx_id,-16,araa.earned_discount_taken,null)
      else null
      end
     ) earned_discount_taken,
  sum(case araa.status
      when 'APP' then araa.unearned_discount_taken
      when 'ACTIVITY' then decode(araa.receivables_trx_id,-16,araa.unearned_discount_taken,null)
      else null
      end
     ) unearned_discount_taken,
  sum(case araa.status
      when 'ACC' then araa.amount_applied
      when 'OTHER ACC' then decode(araa.applied_payment_schedule_id,-7,araa.amount_applied,null)
      else null
      end
     ) on_account_amount,
  sum(case araa.status
      when 'UNID' then araa.amount_applied
      else null
      end
     ) unidentified_amount,
  sum(case araa.status
      when 'UNAPP' then araa.amount_applied
      else null
      end
     ) unapplied_amt,
  sum(case araa.status
      when 'OTHER ACC' then decode(araa.applied_payment_schedule_id,-4,araa.amount_applied,null)
      else null
      end
     ) cash_claims_amount,
  sum(case araa.status
      when 'ACTIVITY' then decode(araa.applied_payment_schedule_id,-3,araa.amount_applied,null)
      else null
      end
     ) writeoff_amount,
  sum(case araa.status
      when 'ACTIVITY' then decode(araa.applied_payment_schedule_id,-8,araa.amount_applied,null)
      else null
      end
     ) refund_amount,
  sum(case araa.status
      when 'ACTIVITY' then decode(araa.applied_payment_schedule_id,-5,araa.amount_applied,null)
      else null
      end
     ) chargeback_amount,
  sum(case araa.status
      when 'ACTIVITY' then decode(araa.applied_payment_schedule_id,-2,araa.amount_applied,null)
      else null
      end
     ) short_term_debt_amount,
  -- acctd
  sum(case araa.status
      when 'APP' then araa.acctd_amount_applied_from
      when 'ACTIVITY' then decode(araa.receivables_trx_id,-16,araa.acctd_amount_applied_from,null)
      else null
      end
     ) acctd_applied_amount,
  sum(case araa.status
      when 'APP' then araa.acctd_earned_discount_taken
      when 'ACTIVITY' then decode(araa.receivables_trx_id,-16,araa.acctd_earned_discount_taken,null)
      else null
      end
     ) acctd_earned_discount_taken,
  sum(case araa.status
      when 'APP' then araa.acctd_unearned_discount_taken
      when 'ACTIVITY' then decode(araa.receivables_trx_id,-16,araa.acctd_unearned_discount_taken,null)
      else null
      end
     ) acctd_unearned_discount_taken,
  sum(case araa.status
      when 'ACC' then araa.acctd_amount_applied_from
      when 'OTHER ACC' then decode(araa.applied_payment_schedule_id,-7,araa.acctd_amount_applied_from,null)
      else null
      end
     ) acctd_on_account_amount,
  sum(case araa.status
      when 'UNID' then araa.acctd_amount_applied_from
      else null
      end
     ) acctd_unidentified_amt,
  sum(case araa.status
      when 'UNAPP' then araa.acctd_amount_applied_from
      else null
      end
     ) acctd_unapplied_amt,
  sum(case araa.status
      when 'OTHER ACC' then decode(araa.applied_payment_schedule_id,-4,araa.acctd_amount_applied_from,null)
      else null
      end
     ) acctd_cash_claims_amount,
  sum(case araa.status
      when 'ACTIVITY' then decode(araa.applied_payment_schedule_id,-3,araa.acctd_amount_applied_from,null)
      else null
      end
     ) acctd_writeoff_amount,
  sum(case araa.status
      when 'ACTIVITY' then decode(araa.applied_payment_schedule_id,-8,araa.acctd_amount_applied_from,null)
      else null
      end
     ) acctd_refund_amount,
  sum(case araa.status
      when 'ACTIVITY' then decode(araa.applied_payment_schedule_id,-5,araa.acctd_amount_applied_from,null)
      else null
      end
     ) acctd_chargeback_amount,
  sum(case araa.status
      when 'ACTIVITY' then decode(araa.applied_payment_schedule_id,-2,araa.acctd_amount_applied_from,null)
      else null
      end
     ) acctd_short_term_debt_amount,
  sum(case araa.status
      when 'APP' then nvl(araa.acctd_amount_applied_from - araa.acctd_amount_applied_to,0)
      when 'ACTIVITY' then decode(araa.receivables_trx_id,-16,nvl(araa.acctd_amount_applied_from - araa.acctd_amount_applied_to,0),null)
      else null
      end
     ) acctd_gain_loss
  from
  ar_receivable_applications_all araa
  where
  nvl(araa.confirmed_flag,'Y')='Y' and
  3=3
  group by
  araa.org_id,
  araa.cash_receipt_id
 ) araa,
 (select
  araa.org_id,
  araa.cash_receipt_id,
  min(araa.apply_date) first_applied_in_full_date,
  min(araa.gl_date) first_applied_in_full_gl_date
  from
   (select
    araa.org_id,
    araa.cash_receipt_id,
    trunc(araa.apply_date) apply_date,
    trunc(araa.gl_date) gl_date,
    case when sum(araa.amount_applied) over (partition by araa.org_id,araa.cash_receipt_id order by araa.apply_date,araa.receivable_application_id) >= acrha.amount
    then 'Y' else null
    end applied_in_full
    from
    ar_receivable_applications_all araa,
    ar_cash_receipt_history_all acrha
    where
    araa.org_id = acrha.org_id and
    araa.cash_receipt_id = acrha.cash_receipt_id and
    nvl(araa.confirmed_flag,'Y')='Y' and
    (araa.status = 'APP' or (araa.status = 'ACTIVITY' and araa.receivables_trx_id = -16)) and
    acrha.first_posted_record_flag = 'Y'
   ) araa
  where
  araa.applied_in_full = 'Y'
  group by
  araa.org_id,
  araa.cash_receipt_id
 ) araa2,
 &lp_table_list
where
 acra.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where not exists (select null from mo_glob_org_access_tmp mgoat)) and
 acra.org_id = araa.org_id (+) and
 acra.cash_receipt_id = araa.cash_receipt_id (+) and
 acra.org_id = araa2.org_id (+) and
 acra.cash_receipt_id = araa2.cash_receipt_id (+) and
 acra.org_id = haou.organization_id and
 acra.set_of_books_id = gl.ledger_id and
 acra.cash_receipt_id = acrha2.cash_receipt_id and
 acrha2.first_posted_record_flag = 'Y' and
 acrha2.org_id = aba.org_id(+) and
 acrha2.batch_id = aba.batch_id(+) and
 nvl(aba.org_id,-1) = absa.org_id(+) and 
 nvl(aba.batch_source_id,-1) = absa.batch_source_id(+) and
 acra.doc_sequence_id = fds.doc_sequence_id(+) and
 acra.vat_tax_id = avta.vat_tax_id(+) and
 acra.remit_bank_acct_use_id = cbaua.bank_acct_use_id and
 cba.bank_branch_id = cbbv.branch_party_id and
 cbbv.country=ftv.territory_code(+) and
 cbaua.bank_account_id = cba.bank_account_id and
 acra.receipt_method_id = arm.receipt_method_id and
 acra.cash_receipt_id = acrha.cash_receipt_id and
 gcc.code_combination_id (+) = acrha.account_code_combination_id and
 acra.pay_from_customer = hca.cust_account_id(+) and
 hca.party_id = hp.party_id(+) and
 acra.customer_site_use_id=hcsua.site_use_id(+) and
 hcsua.cust_acct_site_id=hcasa.cust_acct_site_id(+) and
 hcasa.party_site_id=hps.party_site_id(+) and
 hps.location_id=hl.location_id(+) and
 hl.country=ftv2.territory_code(+) and
 acra.pay_from_customer=hcp.cust_account_id(+) and
 nvl(hcp.site_use_id(+),-999)=-999 and
 hcp.collector_id=ac.collector_id(+) and
 acra.pay_from_customer=hcp2.cust_account_id(+) and
 acra.customer_site_use_id=hcp2.site_use_id(+) and
 hcp2.collector_id=ac2.collector_id(+) and
 acrha.cash_receipt_id = acrha3.cash_receipt_id and
 (decode(acrha3.cash_receipt_history_id , acrha.cash_receipt_history_id, acrha.acctd_amount +1 , acrha3.acctd_amount) <> acrha.acctd_amount or
  decode(acrha3.cash_receipt_history_id , acrha.cash_receipt_history_id, nvl( acrha.acctd_factor_discount_amount,0) + 1 ,nvl(acrha3.acctd_factor_discount_amount,0)) <> nvl( acrha.acctd_factor_discount_amount,0) or
  acrha.status='REVERSED'
 ) and
 nvl(acra.confirmed_flag,'Y') = 'Y' and
 --
 :reporting_level in (1000,3000) and
 nvl(:p_coa,-1) = nvl(:p_coa,-1) and
 :p_mrc_flag = :p_mrc_flag and
 nvl(:p_gl_date_low_h,sysdate) = nvl(:p_gl_date_low_h,sysdate) and
 nvl(:p_gl_date_high_h,sysdate) = nvl(:p_gl_date_high_h,sysdate) and
 1=1
 ) x
where
 2=2
order by
 x.ledger,
 x.balancing_segment,
 x.operating_unit,
 x.receipt_currency,
 x.receipt_number
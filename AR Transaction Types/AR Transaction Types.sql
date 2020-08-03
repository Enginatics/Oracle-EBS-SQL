/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Transaction Types
-- Description: Overview report of transaction types setup definition for BR100 setup documentation
-- Excel Examle Output: https://www.enginatics.com/example/ar-transaction-types/
-- Library Link: https://www.enginatics.com/reports/ar-transaction-types/
-- Run Report: https://demo.enginatics.com/

SELECT hou.name operating_unit
      ,xep.name legal_entity
      ,rctt.name      
      ,rctt.description
      ,al.meaning class
      ,al2.meaning creation_sign
      ,al3.meaning transaction_status
      ,al4.meaning printing_option
      ,NULL invoice_type
      ,rctt2.name credit_memo_type
      ,aars.rule_set_name application_rule_set
      ,aat.payment_term_name terms
      ,rctt.start_date
      ,rctt.end_date      
      ,rctt.accounting_affect_flag open_receivable
      ,rctt.adj_post_to_gl allow_adjustment_posting
      ,rctt.post_to_gl post_to_gl
      ,rctt.allow_freight_flag allow_freight
      ,rctt.natural_application_only_flag natural_application_only
      ,rctt.tax_calculation_flag default_tax_classification
      ,rctt.exclude_from_late_charges exclude_from_late_charges_cal
      ,rctt.allow_overapplication_flag allow_over_application
      ,gcck.concatenated_segments receivable_account
      ,gcck3.concatenated_segments freight_account
      ,gcck2.concatenated_segments revenue_account
      ,gcck4.concatenated_segments clearing_account
      ,gcck5.concatenated_segments unbilled_receivable_account
      ,gcck6.concatenated_segments unearned_revenue_account
      ,gcck7.concatenated_segments tax_account
  FROM ra_cust_trx_types_all rctt
      ,hr_operating_units hou
      ,xle_entity_profiles xep
      ,ar_lookups al
      ,ar_lookups al2
      ,ar_lookups al3
      ,ar_lookups al4
      ,ra_cust_trx_types_all rctt2
      ,ar_app_rule_sets aars
      ,arfv_ar_terms aat
      ,gl_code_combinations_kfv gcck
      ,gl_code_combinations_kfv gcck2
      ,gl_code_combinations_kfv gcck3
      ,gl_code_combinations_kfv gcck4
      ,gl_code_combinations_kfv gcck5
      ,gl_code_combinations_kfv gcck6
      ,gl_code_combinations_kfv gcck7
 WHERE 1=1
   AND rctt.org_id= hou.organization_id
   AND rctt.name=nvl(:P_TYPE,rctt.name)
   AND hou.organization_id=nvl(:P_ORG_ID, hou.organization_id)
   AND xep.legal_entity_id(+)=rctt.legal_entity_id
   AND al.lookup_type='INV/CM'
   AND al.lookup_code=rctt.TYPE
   AND al2.lookup_type='SIGN'
   AND al2.lookup_code=rctt.creation_sign
   AND al3.lookup_type='INVOICE_TRX_STATUS'
   AND al3.lookup_code=rctt.default_status
   AND al4.lookup_type='INVOICE_PRINT_OPTIONS'
   AND al4.lookup_code=rctt.default_printing_option
   AND rctt.credit_memo_type_id=rctt2.cust_trx_type_id(+)
   AND rctt.org_id=rctt2.org_id(+)
   AND rctt.rule_set_id=aars.rule_set_id(+)
   AND rctt.default_term=aat.term_id(+)
   AND gcck.code_combination_id(+)=rctt.gl_id_rec
   AND gcck2.code_combination_id(+)=rctt.gl_id_rev
   AND gcck3.code_combination_id(+)=rctt.gl_id_freight
   AND gcck4.code_combination_id(+)=rctt.gl_id_clearing
   AND gcck5.code_combination_id(+)=rctt.gl_id_unbilled
   AND gcck6.code_combination_id(+)=rctt.gl_id_unearned
   AND gcck7.code_combination_id(+)=rctt.gl_id_tax
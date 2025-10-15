/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Transaction Types
-- Description: Imported from BI Publisher
Description: Print a listing of the Transaction Types
Application: Receivables
Source: Transaction Types Listing (XML)
Short Name: RAXTTL_XML
DB package: AR_RAXTTL_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/ar-transaction-types/
-- Library Link: https://www.enginatics.com/reports/ar-transaction-types/
-- Run Report: https://demo.enginatics.com/

select
 hou.name operating_unit,
 rtt.name transaction_name,
 rtt.description transaction_description,
 xxen_util.meaning(rtt.type,'INV/CM',222) transaction_class,
 xxen_util.meaning(rtt.accounting_affect_flag,'YES_NO',0) open_receivable,
 xxen_util.meaning(rtt.post_to_gl,'YES_NO',0) post_to_gl,
 xxen_util.meaning(rtt.default_printing_option,'INVOICE_PRINT_OPTIONS',222) printing_option,
 xxen_util.meaning(rtt.default_status,'INVOICE_TRX_STATUS',222) transaction_status,
 xxen_util.meaning(rtt.allow_freight_flag,'YES_NO',0) allow_freight,
 xxen_util.meaning(rtt.tax_calculation_flag,'YES_NO',0) tax_calculation,
 xxen_util.meaning(rtt.creation_sign,'SIGN',222) creation_sign,
 xxen_util.meaning(rtt.natural_application_only_flag,'YES_NO',0) natural_application_only,
 xxen_util.meaning(rtt.allow_overapplication_flag,'YES_NO',0) allow_overapplication,
 rtt.start_date start_date,
 rtt.end_date end_date,
 (select rctt.name
  from   ra_cust_trx_types rctt
  where  rctt.cust_trx_type_id = rtt.subsequent_trx_type_id and
         rctt.org_id = rtt.org_id
 ) invoice_type,
 (select rctt.name
  from   ra_cust_trx_types rctt
  where  rctt.cust_trx_type_id = rtt.credit_memo_type_id and
         rctt.org_id = rtt.org_id
 ) credit_memo_type,
 (select rt.name
  from   ra_terms rt
  where  rt.term_id = rtt.default_term
 ) term_name,
 gl7.concatenated_segments tax_account,
 gl1.concatenated_segments revenue_account,
 gl2.concatenated_segments freight_account,
 gl3.concatenated_segments receivable_account,
 gl4.concatenated_segments clearing_account,
 gl5.concatenated_segments unbilled_account,
 gl6.concatenated_segments unearned_account
from
 hr_operating_units hou,
 ra_cust_trx_types rtt,
 gl_code_combinations_kfv gl1,
 gl_code_combinations_kfv gl2,
 gl_code_combinations_kfv gl3,
 gl_code_combinations_kfv gl4,
 gl_code_combinations_kfv gl5,
 gl_code_combinations_kfv gl6,
 gl_code_combinations_kfv gl7
where
 1=1 and
 hou.organization_id = rtt.org_id and
 gl1.code_combination_id(+) = rtt.gl_id_rev and
 gl2.code_combination_id(+) = rtt.gl_id_freight and
 gl3.code_combination_id(+) = rtt.gl_id_rec and
 gl4.code_combination_id(+) = rtt.gl_id_clearing and
 gl5.code_combination_id(+) = rtt.gl_id_unbilled and
 gl6.code_combination_id(+) = rtt.gl_id_unearned and
 gl7.code_combination_id(+) = rtt.gl_id_tax
order by
 hou.name,
 rtt.name
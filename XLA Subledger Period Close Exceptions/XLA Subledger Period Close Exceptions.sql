/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: XLA Subledger Period Close Exceptions
-- Description: Imported from BI Publisher
Description: This report extracts all those events which are either untransferred or are not accounted for.
Application: Subledger Accounting
Source: Subledger Period Close Exceptions Report
Short Name: XLAPEXRPT
DB package: XLA_PERIOD_CLOSE_EXP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/xla-subledger-period-close-exceptions/
-- Library Link: https://www.enginatics.com/reports/xla-subledger-period-close-exceptions/
-- Run Report: https://demo.enginatics.com/

select 
 table1.ledger_short_name ledger_short_name,
 table1.ledger_name ledger_name,
 table1.ledger_description ledger_description,
 table1.ledger_currency ledger_currency,
 table1.period_year period_year,
 table1.period_number period_number,
 table1.period_name period_name,
 (select fa.application_name from fnd_application_vl fa where fa.application_id = table1.application_id) subledger,
 table1.user_je_source journal_source,
 table1.user_je_category_name journal_category,
 table1.event_class_name event_class,
 to_date(table1.event_date,'YYYY-MM-DD') event_date,
 table1.event_type_name event_type,
 table1.transaction_number transaction_number,
 table1.print_status status, 
 substr(userids,1,instr(userids,'|',1,1)-1) user_trx_identifier_name_1,
 substr(userids,instr(userids,'|',1,1)+1,(instr(userids,'|',1,2)-1-instr(userids,'|',1,1))) user_trx_identifier_value_1,
 substr(userids,instr(userids,'|',1,2)+1,(instr(userids,'|',1,3)-1-instr(userids,'|',1,2))) user_trx_identifier_name_2,
 substr(userids,instr(userids,'|',1,3)+1,(instr(userids,'|',1,4)-1-instr(userids,'|',1,3))) user_trx_identifier_value_2,
 substr(userids,instr(userids,'|',1,4)+1,(instr(userids,'|',1,5)-1-instr(userids,'|',1,4))) user_trx_identifier_name_3,
 substr(userids,instr(userids,'|',1,5)+1,(instr(userids,'|',1,6)-1-instr(userids,'|',1,5))) user_trx_identifier_value_3,
 substr(userids,instr(userids,'|',1,6)+1,(instr(userids,'|',1,7)-1-instr(userids,'|',1,6))) user_trx_identifier_name_4,
 substr(userids,instr(userids,'|',1,7)+1,(instr(userids,'|',1,8)-1-instr(userids,'|',1,7))) user_trx_identifier_value_4,
 substr(userids,instr(userids,'|',1,8)+1,(instr(userids,'|',1,9)-1-instr(userids,'|',1,8))) user_trx_identifier_name_5,
 substr(userids,instr(userids,'|',1,9)+1,(instr(userids,'|',1,10)-1-instr(userids,'|',1,9))) user_trx_identifier_value_5,
 substr(userids,instr(userids,'|',1,10)+1,(instr(userids,'|',1,11)-1-instr(userids,'|',1,10))) user_trx_identifier_name_6,
 substr(userids,instr(userids,'|',1,11)+1,(instr(userids,'|',1,12)-1-instr(userids,'|',1,11))) user_trx_identifier_value_6,
 substr(userids,instr(userids,'|',1,12)+1,(instr(userids,'|',1,13)-1-instr(userids,'|',1,12))) user_trx_identifier_name_7,
 substr(userids,instr(userids,'|',1,13)+1,(instr(userids,'|',1,14)-1-instr(userids,'|',1,13))) user_trx_identifier_value_7,
 substr(userids,instr(userids,'|',1,14)+1,(instr(userids,'|',1,15)-1-instr(userids,'|',1,14))) user_trx_identifier_name_8,
 substr(userids,instr(userids,'|',1,15)+1,(instr(userids,'|',1,16)-1-instr(userids,'|',1,15))) user_trx_identifier_value_8,
 substr(userids,instr(userids,'|',1,16)+1,(instr(userids,'|',1,17)-1-instr(userids,'|',1,16))) user_trx_identifier_name_9,
 substr(userids,instr(userids,'|',1,17)+1,(instr(userids,'|',1,18)-1-instr(userids,'|',1,17))) user_trx_identifier_value_9,
 substr(userids,instr(userids,'|',1,18)+1,(instr(userids,'|',1,19)-1-instr(userids,'|',1,18))) user_trx_identifier_name_10,
 substr(userids,instr(userids,'|',1,19)+1,(length(userids)-instr(userids,'|',1,19))) user_trx_identifier_value_10,
 table1.user_name created_by_user,
 to_date(table1.creation_date,'YYYY-MM-DD') creation_date,
 to_date(table1.last_update_date,'YYYY-MM-DD') last_update_date,
 to_date(table1.transaction_date,'YYYY-MM-DD') transaction_date,
 table1.on_hold on_hold,
 table1.balance_type balance_type,
 table1.event_id event_id,
 table1.event_number event_number
from 
 (&p_template_sql_statement
  &c_events_cols_query 
  &p_trx_identifiers_1 
  &p_trx_identifiers_2 
  &p_trx_identifiers_3 
  &p_trx_identifiers_4 
  &p_trx_identifiers_5 
  &c_events_from_query 
  &p_ledger_ids 
  &p_event_filter 
  &p_je_source_filter 
  union 
  &p_template_sql_statement
  &c_headers_cols_query 
  &p_trx_identifiers_1 
  &p_trx_identifiers_2 
  &p_trx_identifiers_3 
  &p_trx_identifiers_4 
  &p_trx_identifiers_5 
  &c_headers_from_query 
  &p_ledger_ids 
  &p_header_filter 
  &p_je_source_filter
 ) table1
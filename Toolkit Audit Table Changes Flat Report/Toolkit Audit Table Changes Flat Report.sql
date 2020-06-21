/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Toolkit - Audit Table Changes Flat Report
-- Description: Reports all changes to an audited application table - Flat Report.

The report has one row per audit transaction showing the Old and New values for all audited columns in a single row
-- Excel Examle Output: https://www.enginatics.com/example/toolkit-audit-table-changes-flat-report/
-- Library Link: https://www.enginatics.com/reports/toolkit-audit-table-changes-flat-report/
-- Run Report: https://demo.enginatics.com/

select 
  :audit_table_name    audit_table
&sel_audit_key_cols
, xxen_util.meaning(aud_ac1.audit_transaction_type,'FND_AUDIT_TRANS_TYPE',0) audit_trx_type
, xxen_util.client_time(aud_a.audit_timestamp) audit_timestamp
, xxen_util.user_name(aud_ac1.audit_user_name) audit_trx_user
&sel_audit_cols
&sel_audit_cols2
&sel_audit_cols3
&sel_audit_cols4
&sel_audit_cols5
&sel_audit_cols6
&sel_audit_cols7
&sel_audit_cols8
&sel_audit_cols9
&sel_audit_cols10
&sel_audit_cols11
&sel_audit_cols12
&sel_audit_cols13
&sel_audit_cols14
&sel_audit_cols15
&sel_audit_cols16
&sel_audit_cols17
&sel_audit_cols18
&sel_audit_cols19
&sel_audit_cols20
, to_char(aud_a.row_key)        audit_row_key
, aud_a.audit_session_id
, aud_a.audit_sequence_id
, aud_a.audit_commit_id
from
&from_audit_tables
where
aud_a.row_key = aud_ac1.row_key
and 1=1
and 2=2
and 3=3
order by
  aud_a.row_key DESC
/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Audit Table Changes by Record
-- Description: Reports all changes to an audited application table.

The report has one row per audit transaction showing the old and new values for all audited columns in a single row.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-audit-table-changes-by-record/
-- Library Link: https://www.enginatics.com/reports/fnd-audit-table-changes-by-record/
-- Run Report: https://demo.enginatics.com/

select 
  :audit_table_name    audit_table
, xxen_util.client_time(aud_a.audit_timestamp) audit_timestamp
,xxen_util.meaning(aud_ac1.audit_transaction_type,'FND_AUDIT_TRANS_TYPE',0)  audit_trx_type
,xxen_util.user_name(aud_ac1.audit_user_name) audit_trx_user
&sel_xinfo_table_user_cols
&sel_table_user_cols
&sel_audit_key_cols
&sel_audit_cols1
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
&from_xinfo_table
(select 'X' -- dummy just to allow multiple select on user identifying columns
 from dual
 where not exists
   (select 'X'  -- dummy just to allow multiple select on user identifying columns
    from  fnd_tables ft, fnd_columns fc
    where ft.application_id = fc.application_id
    and   ft.table_id       = fc.table_id
    and   ft.table_name     = :additional_info_table
    and   2=2
    and 'X'='Y' -- make sure it does not return anything
   )
 ) dummy
where
aud_a.row_key = aud_ac1.row_key
&join_audit_tab_key_cols
&join_xinfo_table_key_cols
and 1=1
order by
  aud_a.row_key DESC
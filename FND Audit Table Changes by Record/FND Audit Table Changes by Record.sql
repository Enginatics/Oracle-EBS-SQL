/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
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
:audit_table audit_table,
xxen_util.client_time(aud_a.audit_timestamp) audit_timestamp,
xxen_util.meaning(aud_ac1.audit_transaction_type,'FND_AUDIT_TRANS_TYPE',0)  audit_transaction_type,
xxen_util.user_name(aud_ac1.audit_user_name) audit_transaction_user,
&sel_xinfo_table_user_cols
&sel_table_user_cols
&sel_audit_key_cols
&sel_audit_cols
to_char(aud_a.row_key) audit_row_key,
aud_a.audit_session_id,
aud_a.audit_sequence_id,
aud_a.audit_commit_id
from
&from_tables
where
aud_a.row_key=aud_ac1.row_key and
&join_audit_tab_key_cols
&join_xinfo_table_key_cols
1=1
order by
aud_a.row_key desc
/*&dummy*/
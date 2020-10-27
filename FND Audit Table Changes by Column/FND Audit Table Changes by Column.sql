/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Audit Table Changes by Column
-- Description: Reports all changes to an audited application table.

The report has one row per audit transaction and audited column showing the old and new audit column value.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-audit-table-changes-by-column/
-- Library Link: https://www.enginatics.com/reports/fnd-audit-table-changes-by-column/
-- Run Report: https://demo.enginatics.com/

select
q2.*
from
(
select
:audit_table audit_table,
xxen_util.client_time(q1.audit_timestamp) audit_timestamp,
xxen_util.meaning(q1.audit_transaction_type,'FND_AUDIT_TRANS_TYPE',0) audit_transaction_type,
xxen_util.user_name(q1.audit_user_name) audit_transaction_user,
&sel_xinfo_table_user_cols
&sel_base_table_user_cols
&sel_audit_key_cols
q1.audit_column audit_column,
case when q1.a_val is null and q1.true_null='N' then null else q1.a_val end old_value,
case q1.audit_transaction_type when 'D' then null when 'I' then q1.ac1_val else case when q1.a_val is null and q1.true_null='N' then null else q1.ac1_val end end new_value,
to_char(q1.row_key) row_key,
q1.audit_session_id,
q1.audit_sequence_id,
q1.audit_commit_id,
q1.column_sequence_id,
q1.audit_transaction_type audit_trx_type
from
(
select 
aud_a.*,
col.column_name audit_column,
col.sequence_id column_sequence_id,
nvl(substr(aud_a.audit_true_nulls,col.sequence_id+1,1),'N') true_null,
case col.column_name
&sel_audit_cols_old_vals
end a_val,
case col.column_name
&sel_audit_cols_new_vals
end ac1_val
from
&from_audit_tables
(
select distinct
fc.column_name,
fac.sequence_id
from
fnd_tables ft,
fnd_audit_columns fac,
fnd_columns fc
where
1=1 and
ft.table_name=:audit_table and
ft.application_id=fac.table_app_id and
ft.table_id=fac.table_id and
fac.state='N' and
fac.sequence_id>=0 and
fac.table_app_id=fc.application_id and
fac.table_id=fc.table_id and
fac.column_id=fc.column_id
order by
fac.sequence_id,
fc.column_name
) col
where
2=2 and
&join_audit_tab_key_cols
aud_a.row_key=aud_ac1.row_key
) q1,
&from_tables
where
&join_base_table_key_cols
&join_xinfo_table_key_cols
3=3
) q2
where
4=4
order by
q2.audit_table,
q2.row_key desc,
q2.column_sequence_id
/*&dummy*/
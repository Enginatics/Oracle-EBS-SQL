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

select q2.*
from (
select
 :audit_table_name audit_table
,xxen_util.client_time(q1.audit_timestamp) audit_timestamp
,xxen_util.meaning(q1.audit_transaction_type,'FND_AUDIT_TRANS_TYPE',0)  audit_trx_type
,xxen_util.user_name(q1.audit_user_name) audit_trx_user
&sel_xinfo_table_user_cols
&sel_base_table_user_cols
&sel_audit_key_cols
,q1.audit_column audit_column
, case when q1.a_val is null
        and q1.true_null = 'N'
  then null
  else q1.a_val
  end                         old_value
, case q1.audit_transaction_type
  when 'D' then null
  when 'I' then q1.ac1_val
  else case when q1.a_val is null
             and q1.true_null = 'N'
            then null
            else q1.ac1_val
       end
  end                         new_value
, to_char(q1.row_key) row_key 
, q1.audit_session_id
, q1.audit_sequence_id
, q1.audit_commit_id
, q1.column_sequence_id       
from
(
select 
 aud_a.*
,col.column_name audit_column
,col.sequence_id column_sequence_id
,nvl(SUBSTR(aud_a.audit_true_nulls,col.sequence_id+1,1),'N') true_null
,case col.column_name
&sel_audit_cols_old_vals
 end                     a_val
,case col.column_name
&sel_audit_cols_new_vals
 end                     ac1_val
,(select 'X'  -- dummy just to allow muliple select on user identifying columns
  from  fnd_tables ft, fnd_columns fc
  where ft.application_id = fc.application_id
  and   ft.table_id       = fc.table_id
  and   ft.table_name     = :audit_table_name
  and   5=5
  and   'X'='Y' -- we dont want this to return anything
 ) dummy
,:additional_info_table
from
 &from_audit_tables
,(
  select distinct
   fc.column_name
  ,fac.sequence_id
  from
   fnd_columns        fc
  ,fnd_audit_columns  fac
  ,fnd_tables         ft
  where
      fc.column_id           = fac.column_id
  and fc.table_id            = fac.table_id
  and fc.application_id      = fac.table_app_id
  and fac.table_app_id       = ft.application_id
  and fac.table_id           = ft.table_id
  and fac.state              = 'N'
  and fac.sequence_id       >= 0
  and ft.table_name          = :audit_table_name
  and 1=1 
  order by
    fac.sequence_id
  , fc.column_name
 ) col
where
   aud_a.row_key = aud_ac1.row_key
&join_audit_tab_key_cols
and 2=2
) q1
&from_base_table
&from_xinfo_table
where
  3=3
&join_base_table_key_cols
&join_xinfo_table_key_cols
) q2
where 
4=4
and (   NVL(q2.old_value,'#ISNULL') != NVL(q2.new_value,'#ISNULL')
       or q2.audit_trx_type = 'Insert'
      )
order by 
q2.audit_table,q2.row_key DESC, q2.column_sequence_id
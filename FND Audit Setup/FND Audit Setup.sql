/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Audit Setup
-- Description: FND audit setup validation report including audit groups, audit tables and audited columns, and a check if the corresponding audit tables are created in columns 'Audit Table Name' and 'Audit Column Exists'.

Oracle's standard audit trail works with a concurrent program 'AuditTrail Update Tables', which creates a set of database triggers for updates, inserts and deletes. The triggers write table changes to an audit table with the name: audited_table_A.

The whole audit trail setup process is describe in this blog: https://www.enginatics.com/blog/how-to-track-master-data-changes-using-oracle-ebs-audit-function-and-blitz-report/
-- Excel Examle Output: https://www.enginatics.com/example/fnd-audit-setup/
-- Library Link: https://www.enginatics.com/reports/fnd-audit-setup/
-- Run Report: https://demo.enginatics.com/

select
fav.application_short_name,
fav.application_name,
fag.group_name audit_group,
fag.description group_description,
xxen_util.meaning(fag.state,'AUDIT_STATE',0) group_audit_state,
(
select distinct
listagg(fatd.template_name,', ') within group (order by fatd.template_name) over () template
from
fnd_audit_tmplt_dtl fatd
where
fag.audit_group_id=fatd.audit_group_id and
fag.application_id=fatd.application_id
) template,
ft.table_name,
(
select
dt.table_name
from
fnd_product_installations fpi,
fnd_oracle_userid fou,
dba_tables dt
where
ft.application_id=fpi.application_id and
fpi.oracle_id=fou.oracle_id and
fou.oracle_username=dt.owner and
substr(ft.table_name,1,24)||'_A'=dt.table_name and
rownum=1
) audit_table_name,
fc.column_name,
xxen_util.meaning(fc.column_type,'COLUMN_TYPE',0) column_type,
xxen_util.meaning((select 'Y' from fnd_primary_key_columns fpkc where fac.table_app_id=fpkc.application_id and fac.table_id=fpkc.table_id and fac.column_id=fpkc.column_id and rownum=1),'YES_NO',0) primary_key,
xxen_util.meaning((
select
'Y'
from
fnd_product_installations fpi,
fnd_oracle_userid fou,
dba_tab_columns dtc
where
ft.application_id=fpi.application_id and
fpi.oracle_id=fou.oracle_id and
fou.oracle_username=dtc.owner and
substr(ft.table_name,1,24)||'_A'=dtc.table_name and
fc.column_name=dtc.column_name and
rownum=1
),'YES_NO',0) audit_column_exists,
xxen_util.user_name(fag.created_by) group_created_by,
xxen_util.client_time(fag.creation_date) group_creation_date,
xxen_util.user_name(fag.last_updated_by) group_last_updated_by,
xxen_util.client_time(fag.last_update_date) group_last_update_date,
xxen_util.user_name(fac.created_by) column_created_by,
xxen_util.client_time(fac.creation_date) column_creation_date,
xxen_util.user_name(fac.last_updated_by) column_last_updated_by,
xxen_util.client_time(fac.last_update_date) column_last_update_date
from
fnd_application_vl fav,
fnd_audit_groups fag,
fnd_audit_tables fat,
fnd_tables ft,
fnd_audit_columns fac,
fnd_columns fc
where
1=1 and
fav.application_id=fag.application_id and
fag.audit_group_id=fat.audit_group_id and
fag.application_id=fat.audit_group_app_id and
fat.table_app_id=ft.application_id and
fat.table_id=ft.table_id and
fat.table_id=fac.table_id and
fat.table_app_id=fac.table_app_id and
fac.schema_id=-1 and
fac.table_app_id=fc.application_id and
fac.table_id=fc.table_id and
fac.column_id=fc.column_id
order by
fav.application_name,
fag.group_name,
ft.table_name,
fc.column_sequence
/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Blitz Report ORDS Configuration
-- Description: Validates the Oracle REST Data Services (ORDS) configuration for Blitz Report webservices. Shows ORDS schema enablement, REST module setup, PL/SQL package status, all 27 expected endpoint handlers, OAuth2 security grants, and profile option settings. Use this report to verify that the ORDS integration is complete and all components are properly configured.
-- Excel Examle Output: https://www.enginatics.com/example/dba-blitz-report-ords-configuration/
-- Library Link: https://www.enginatics.com/reports/dba-blitz-report-ords-configuration/
-- Run Report: https://demo.enginatics.com/

select
x.section,
x.component,
x.status,
x.detail,
x.validation
from
(
select
'ORDS Schema' section,
os.parsing_schema||' Schema' component,
os.status,
'Module: xxen_webservices | Config Version: '||nvl(regexp_substr(om.comments,'v(\d+)',1,1,'i',1),'0') detail,
case when os.status='ENABLED' then 'OK' else 'Error' end validation,
1 sort
from
ords_metadata.ords_schemas os,
ords_metadata.ords_modules om
where
os.id=om.schema_id and
om.name='xxen_webservices'
union all
select
'PL/SQL Packages',
do.owner||'.'||do.object_name||' ('||initcap(do.object_type)||')',
do.status,
'Last DDL: '||to_char(do.last_ddl_time,'yyyy-mm-dd hh24:mi:ss'),
case do.status when 'VALID' then 'OK' else 'Error' end,
2
from
dba_objects do
where
do.object_name in ('XXEN_WEBSERVICES_ORDS','XXEN_WEBSERVICES_ORDS_AUTH') and
do.object_type in ('PACKAGE','PACKAGE BODY')
union all
select
'REST Endpoints',
e.endpoint_name,
case when dp.procedure_name is not null then 'Defined' else 'Missing' end,
case when dp.procedure_name is not null then 'Handler: '||e.procedure_name else 'Expected: '||e.procedure_name end,
case when dp.procedure_name is not null then 'OK' else 'Error' end,
3
from
(
select 'copy_template' endpoint_name, 'COPY_TEMPLATE_ORDS' procedure_name from dual union all
select 'delete_drilldown', 'DELETE_DRILLDOWN_ORDS' from dual union all
select 'get_autofill_values', 'AUTOFILL_ORDS' from dual union all
select 'get_drilldowns', 'GET_DRILLDOWNS_ORDS' from dual union all
select 'get_function_records', 'FUNCTION_RECORDS_ORDS' from dual union all
select 'get_lov_records', 'LOV_RECORDS_ORDS' from dual union all
select 'get_records', 'RECORDS_ORDS' from dual union all
select 'get_report_batch', 'REPORT_BATCH_ORDS' from dual union all
select 'get_report_columns', 'GET_REPORT_COLUMNS_ORDS' from dual union all
select 'get_report_list', 'REPORT_LIST_ORDS' from dual union all
select 'get_report_metadata', 'REPORT_METADATA_ORDS' from dual union all
select 'get_report_param_lov', 'REPORT_PARAM_LOV_ORDS' from dual union all
select 'get_session', 'GET_SESSION_ORDS' from dual union all
select 'get_template_columns', 'TEMPLATE_COLUMNS_ORDS' from dual union all
select 'get_user_responsibilities', 'USER_RESPONSIBILITIES_ORDS' from dual union all
select 'get_version_info', 'GET_VERSION_INFO_ORDS' from dual union all
select 'login', 'LOGIN_ORDS' from dual union all
select 'run_report', 'RUN_REPORT_ORDS' from dual union all
select 'save_drilldown', 'SAVE_DRILLDOWN_ORDS' from dual union all
select 'save_template', 'SAVE_TEMPLATE_ORDS' from dual union all
select 'update_fsg_profile_values', 'UPDATE_FSG_PROFILES_ORDS' from dual union all
select 'upload_default_value', 'UPLOAD_DEFAULT_VALUE_ORDS' from dual union all
select 'upload_file', 'UPLOAD_FILE_ORDS' from dual union all
select 'upload_lov_records', 'UPLOAD_LOV_RECORDS_ORDS' from dual union all
select 'validate_required_params', 'VALIDATE_REQ_PARAMS_ORDS' from dual union all
select 'validate_upload_records', 'VALIDATE_UPLOAD_RECS_ORDS' from dual union all
select 'view_transaction', 'VIEW_TRANSACTION_ORDS' from dual
) e,
(select dp.procedure_name from dba_procedures dp where dp.owner='APPS' and dp.object_name='XXEN_WEBSERVICES_ORDS') dp
where
e.procedure_name=dp.procedure_name(+)
union all
select
'Security',
'Execute Grant to '||dtp.grantee,
'Granted',
dtp.owner||'.'||dtp.table_name||' | Grantable: '||dtp.grantable,
'OK',
4
from
dba_tab_privs dtp
where
dtp.table_name='XXEN_WEBSERVICES_ORDS' and
dtp.privilege='EXECUTE'
union all
select
'Security',
'OAuth2 Auth Package',
do.status,
do.owner||'.XXEN_WEBSERVICES_ORDS_AUTH - provides client_id/secret',
case do.status when 'VALID' then 'OK' else 'Error' end,
4
from
dba_objects do
where
do.object_name='XXEN_WEBSERVICES_ORDS_AUTH' and
do.object_type='PACKAGE' and
do.owner not in ('APPS','PUBLIC','SYS','SYSTEM')
union all
select
'Configuration',
'XXEN_WEBSERVICE_CONNECTION_TYPE',
nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'(not set - defaults to ORDS)'),
'Controls webservice transport: ORDS, ISG, or MOD_PLSQL',
case nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'ORDS')
when 'ORDS' then 'OK'
when 'ISG' then 'OK'
when 'MOD_PLSQL' then 'OK'
else 'Warning'
end,
5
from dual
union all
select
'Middleware',
'ORDS Connection Pool',
case when y.session_count>0 then 'Active ('||y.session_count||' sessions)' else 'Not Connected' end,
'ORDS_PUBLIC_USER sessions in gv$session',
case when y.session_count>0 then 'OK' else 'Error' end,
6
from
(select count(*) session_count from gv$session vs where vs.username='ORDS_PUBLIC_USER') y
) x
where
1=1
order by
x.sort,
x.component
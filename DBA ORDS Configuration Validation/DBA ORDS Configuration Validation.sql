/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA ORDS Configuration Validation
-- Description: Validates the Oracle REST Data Services (ORDS) configuration for Blitz Report webservices. Checks: ORDS schema enablement and URL mapping, REST module status, PL/SQL package validity, all 27 expected endpoint handlers and their ORDS template registrations, execute grants, the complete OAuth2 chain (role, privilege, privilege-role mapping, privilege-module mapping, OAuth client, client-role grant), ORDS URL profile configuration with token endpoint validation, OAuth2 client_id/secret availability, and ORDS connection pool sessions. Use this report to diagnose ORDS connectivity issues including OAuth token 404 errors.
-- Excel Examle Output: https://www.enginatics.com/example/dba-ords-configuration-validation/
-- Library Link: https://www.enginatics.com/reports/dba-ords-configuration-validation/
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
'1. ORDS Schema' section,
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
'1. ORDS Schema',
'URL Mapping',
oum.pattern,
'Schema alias used in ORDS URL path',
case when oum.pattern is not null then 'OK' else 'Error' end,
1
from
ords_metadata.ords_schemas os,
ords_metadata.ords_modules om,
ords_metadata.ords_url_mappings oum
where
os.id=om.schema_id and
om.name='xxen_webservices' and
os.url_mapping_id=oum.id
union all
select
'1. ORDS Schema',
'Module Status',
om.status,
'Base path: '||om.uri_prefix,
case when om.status='PUBLISHED' then 'OK' else 'Error' end,
1
from
ords_metadata.ords_modules om,
ords_metadata.ords_schemas os
where
om.name='xxen_webservices' and
om.schema_id=os.id
union all
select
'2. PL/SQL Packages',
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
'3. REST Endpoints',
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
'3. REST Endpoints',
'ORDS Template: '||ot.uri_template,
'Registered',
'Handler count: '||(select count(*) from ords_metadata.ords_handlers oh where oh.template_id=ot.id),
'OK',
3
from
ords_metadata.ords_templates ot,
ords_metadata.ords_modules om
where
ot.module_id=om.id and
om.name='xxen_webservices'
union all
select
'4. Security',
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
'4. Security',
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
-- OAuth2 Chain: only relevant when connection type is ORDS
select
'5. OAuth2 Chain',
y.component,
y.status,
y.detail,
case when nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'ORDS')<>'ORDS' then 'OK' else y.validation end,
5
from
(
select '1. Role: xxen_webservices' component,
case when (select uor.name from user_ords_roles uor where uor.name='xxen_webservices' and rownum=1) is not null then 'Exists'
when nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'ORDS')<>'ORDS' then 'N/A (not using ORDS)'
else 'Missing' end status,
case when (select uor.name from user_ords_roles uor where uor.name='xxen_webservices' and rownum=1) is not null then 'Role created successfully'
when nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'ORDS')<>'ORDS' then 'OAuth2 not required for '||fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE')||' transport'
else 'Run configure_ords.sql to create role' end detail,
case when (select uor.name from user_ords_roles uor where uor.name='xxen_webservices' and rownum=1) is not null then 'OK' else 'Error' end validation
from dual
union all
select '2. Privilege: xxen_webservices',
case when (select uop.name from user_ords_privileges uop where uop.name='xxen_webservices' and rownum=1) is not null then 'Exists'
when nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'ORDS')<>'ORDS' then 'N/A (not using ORDS)'
else 'Missing' end,
nvl((select 'Label: '||uop.label from user_ords_privileges uop where uop.name='xxen_webservices' and rownum=1),
case when nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'ORDS')<>'ORDS' then 'OAuth2 not required for '||fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE')||' transport'
else 'Run configure_ords.sql to create privilege' end),
case when (select uop.name from user_ords_privileges uop where uop.name='xxen_webservices' and rownum=1) is not null then 'OK' else 'Error' end
from dual
union all
select '3. Privilege-Role Mapping',
case when (select uopr.role_name from user_ords_privilege_roles uopr where uopr.privilege_name='xxen_webservices' and rownum=1) is not null then 'Linked'
when nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'ORDS')<>'ORDS' then 'N/A (not using ORDS)'
else 'Missing' end,
nvl((select 'Privilege linked to role '||uopr.role_name from user_ords_privilege_roles uopr where uopr.privilege_name='xxen_webservices' and rownum=1),
case when nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'ORDS')<>'ORDS' then 'OAuth2 not required for '||fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE')||' transport'
else 'Privilege not linked to role - OAuth token will fail' end),
case when (select uopr.role_name from user_ords_privilege_roles uopr where uopr.privilege_name='xxen_webservices' and rownum=1) is not null then 'OK' else 'Error' end
from dual
union all
select '4. Privilege-Module Mapping',
case when (select uopm.module_name from user_ords_privilege_modules uopm where uopm.privilege_name='xxen_webservices' and rownum=1) is not null then 'Linked'
when nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'ORDS')<>'ORDS' then 'N/A (not using ORDS)'
else 'Missing' end,
nvl((select 'Module '||uopm.module_name||' protected by privilege' from user_ords_privilege_modules uopm where uopm.privilege_name='xxen_webservices' and rownum=1),
case when nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'ORDS')<>'ORDS' then 'OAuth2 not required for '||fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE')||' transport'
else 'Module not protected - endpoints are unprotected' end),
case when (select uopm.module_name from user_ords_privilege_modules uopm where uopm.privilege_name='xxen_webservices' and rownum=1) is not null then 'OK' else 'Error' end
from dual
union all
select '5. OAuth2 Client: xxen_webservices',
case when (select uoc.name from user_ords_clients uoc where uoc.name='xxen_webservices' and rownum=1) is not null then 'Exists'
when nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'ORDS')<>'ORDS' then 'N/A (not using ORDS)'
else 'Missing' end,
nvl((select 'Grant type: '||uoc.auth_flow||' | Schema: '||uoc.created_by from user_ords_clients uoc where uoc.name='xxen_webservices' and rownum=1),
case when nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'ORDS')<>'ORDS' then 'OAuth2 not required for '||fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE')||' transport'
else 'Run configure_ords.sql to create OAuth client' end),
case when (select uoc.name from user_ords_clients uoc where uoc.name='xxen_webservices' and rownum=1) is not null then 'OK' else 'Error' end
from dual
union all
select '6. Client-Role Grant',
case when (select uocr.role_name from user_ords_client_roles uocr where uocr.client_name='xxen_webservices' and rownum=1) is not null then 'Granted'
when nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'ORDS')<>'ORDS' then 'N/A (not using ORDS)'
else 'Missing' end,
nvl((select 'Client granted role '||uocr.role_name from user_ords_client_roles uocr where uocr.client_name='xxen_webservices' and rownum=1),
case when nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'ORDS')<>'ORDS' then 'OAuth2 not required for '||fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE')||' transport'
else 'Client not granted role - OAuth token request will be rejected' end),
case when (select uocr.role_name from user_ords_client_roles uocr where uocr.client_name='xxen_webservices' and rownum=1) is not null then 'OK' else 'Error' end
from dual
) y
union all
select
'6. Configuration',
'XXEN_WEBSERVICE_CONNECTION_TYPE',
nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'(not set - defaults to ORDS)'),
'Controls webservice transport: ORDS, ISG, or MOD_PLSQL',
case nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'ORDS')
when 'ORDS' then 'OK'
when 'ISG' then 'OK'
when 'MOD_PLSQL' then 'OK'
else 'Warning'
end,
6
from dual
union all
-- FND_APEX_URL: the ORDS listener base URL when APEX is installed
select
'6. Configuration',
'FND_APEX_URL',
nvl(fnd_profile.value('FND_APEX_URL'),'(not set)'),
case when fnd_profile.value('FND_APEX_URL') is not null then
'ORDS listener base URL for this instance'
else 'Not set - APEX not installed, ORDS URL derived from APPS_SERVLET_AGENT' end,
'OK',
6
from dual
union all
-- Derived ORDS URL: shows what instance_url() auto-derives when XXEN_WEBSERVICE_ORDS_URL is not set
select
'6. Configuration',
'Derived ORDS URL',
coalesce(
(select fnd_profile.value('FND_APEX_URL')||case when substr(fnd_profile.value('FND_APEX_URL'),-1)<>'/' then '/' end||oum.pattern||'/'
from ords_metadata.ords_schemas os, ords_metadata.ords_modules om, ords_metadata.ords_url_mappings oum
where os.id=om.schema_id and om.name='xxen_webservices' and os.url_mapping_id=oum.id and fnd_profile.value('FND_APEX_URL') is not null and rownum=1),
xxen_webservices.instance_url
),
'Auto-derived from '||case when fnd_profile.value('FND_APEX_URL') is not null then 'FND_APEX_URL + ORDS schema alias' else 'APPS_SERVLET_AGENT hostname' end||'. Set XXEN_WEBSERVICE_ORDS_URL to override.',
'OK',
6
from dual
union all
select
'6. Configuration',
'XXEN_WEBSERVICE_ORDS_URL',
nvl(fnd_profile.value('XXEN_WEBSERVICE_ORDS_URL'),'(not set - auto-derived)'),
'Effective URL: '||xxen_webservices.instance_url||' | Token endpoint: '||xxen_webservices.instance_url||'oauth/token',
case
when nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'ORDS')<>'ORDS' then 'OK'
when fnd_profile.value('XXEN_WEBSERVICE_ORDS_URL') is not null then 'OK'
else 'Warning'
end,
6
from dual
union all
select
'6. Configuration',
'OAuth2 Client ID',
case when xxen_webservices.ords_client_id is not null then 'Available' else 'Not Found' end,
case when xxen_webservices.ords_client_id is not null then 'Client ID retrieved successfully' else 'Cannot retrieve client_id from user_ords_clients' end,
case
when nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'ORDS')<>'ORDS' then 'OK'
when xxen_webservices.ords_client_id is not null then 'OK'
else 'Error' end,
6
from dual
union all
select
'6. Configuration',
'OAuth2 Client Secret',
case when xxen_webservices.ords_client_secret is not null then 'Available' else 'Not Found' end,
case when xxen_webservices.ords_client_secret is not null then 'Client secret retrieved successfully' else 'Cannot retrieve client_secret from user_ords_clients' end,
case
when nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'ORDS')<>'ORDS' then 'OK'
when xxen_webservices.ords_client_secret is not null then 'OK'
else 'Error' end,
6
from dual
union all
select
'7. Middleware',
'ORDS Connection Pool',
case when y.session_count>0 then 'Active ('||y.session_count||' sessions)' else 'Not Connected' end,
'ORDS_PUBLIC_USER sessions in gv$session',
case when y.session_count>0 then 'OK'
when nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'ORDS')<>'ORDS' then 'OK'
else 'Error' end,
7
from
(select count(*) session_count from gv$session vs where vs.username='ORDS_PUBLIC_USER') y
) x
where
1=1
order by
x.sort,
x.component
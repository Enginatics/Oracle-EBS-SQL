/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA ORDS Configuration Validation
-- Description: Validates the Oracle REST Data Services (ORDS) configuration for Blitz Report webservices. Checks: ORDS schema enablement and URL mapping, REST module status, PL/SQL package validity, all 27 expected endpoint handlers and their ORDS template registrations, execute grants, URL-pattern privileges that intercept xxenwebservices calls and the OAuth client's role grants (catches HTTP 401 caused by pre-existing catch-all privileges), ORDS URL profile configuration with token endpoint validation, OAuth2 clientid/secret availability, and ORDS connection pool sessions. Use this report to diagnose ORDS connectivity issues including OAuth token 404 and 401 errors.
-- Excel Example Output: https://www.enginatics.com/example/dba-ords-configuration-validation/
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
select
x.endpoint_name,
upper(x.endpoint_name) procedure_name
from
(
select 'autofill_values' endpoint_name from dual union all
select 'cell_lov_records' from dual union all
select 'clear_param_defaults' from dual union all
select 'copy_template' from dual union all
select 'delete_drilldown' from dual union all
select 'drilldowns' from dual union all
select 'email_report' from dual union all
select 'email_upload_result' from dual union all
select 'fsg_function_records' from dual union all
select 'fsg_lov_records' from dual union all
select 'fsg_records' from dual union all
select 'installed_languages' from dual union all
select 'login' from dual union all
select 'lov_catalogue' from dual union all
select 'report_batch' from dual union all
select 'report_columns' from dual union all
select 'report_list' from dual union all
select 'report_metadata' from dual union all
select 'report_param_lov' from dual union all
select 'run_report' from dual union all
select 'save_drilldown' from dual union all
select 'save_param_defaults' from dual union all
select 'save_template' from dual union all
select 'session_cookie' from dual union all
select 'stage_upload_rows' from dual union all
select 'template_columns' from dual union all
select 'update_fsg_profile_values' from dual union all
select 'upload_default_value' from dual union all
select 'upload_file' from dual union all
select 'upload_lov_records' from dual union all
select 'user_responsibilities' from dual union all
select 'validate_required_params' from dual union all
select 'validate_upload_records' from dual union all
select 'version_info' from dual union all
select 'view_transaction' from dual
) x
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
-- 5. URL-pattern Privileges: detect ords privileges whose URL patterns intercept /xxen_webservices/ calls.
-- ORDS enforces every matching privilege, so any catch-all privilege adds role requirements that the
-- xxen_webservices OAuth client must hold or calls return HTTP 401. Older ORDS releases on EBS expose only
-- ords_privilege_mappings (denormalised name+pattern) and ords_client_roles (denormalised client+role),
-- not ords_privileges/ords_privilege_roles, so the privilege->required-role link is left to manual lookup
-- via ords_admin (DBA_ORDS_PRIVILEGE_ROLES). The section also lists the xxen_webservices client's currently
-- held roles so the DBA can compare against any flagged catch-all privilege.
select
'5. URL-pattern Privileges' section,
case y.kind
when 'catch-all-detected' then 'Catch-all Privilege: '||y.priv_name||' (pattern '||y.pattern||')'
when 'catch-all-none'     then 'Catch-all Privileges'
when 'client-role'        then 'OAuth Client Role: '||y.role_name
end component,
case y.kind
when 'catch-all-detected' then 'Detected'
when 'catch-all-none'     then 'None detected'
when 'client-role'        then 'Granted'
end status,
case y.kind
when 'catch-all-detected' then 'Privilege intercepts /xxen_webservices/ calls; xxen_webservices client must hold every role this privilege requires. Look up required roles via ords_admin: select role_name from ords_metadata.dba_ords_privilege_roles where privilege_id='||y.priv_id
when 'catch-all-none'     then 'No URL-pattern privileges intercept /xxen_webservices/ calls. Patterns checked: /*, /**, /xxen%'
when 'client-role'        then 'xxen_webservices OAuth client holds role '||y.role_name
end detail,
case y.kind when 'catch-all-detected' then 'Warning' else 'OK' end validation,
5 sort
from (
select 'catch-all-detected' kind, opm.name priv_name, opm.pattern, to_char(opm.privilege_id) priv_id, cast(null as varchar2(60)) role_name
from ords_metadata.ords_privilege_mappings opm, ords_metadata.ords_modules om, ords_metadata.ords_schemas os
where om.name='xxen_webservices' and om.schema_id=os.id and opm.schema_id=os.id
and (opm.pattern in ('/*','/**') or opm.pattern like '/xxen%')
union all
select 'catch-all-none', null, null, null, null
from dual
where not exists (
select null from ords_metadata.ords_privilege_mappings opm, ords_metadata.ords_modules om, ords_metadata.ords_schemas os
where om.name='xxen_webservices' and om.schema_id=os.id and opm.schema_id=os.id
and (opm.pattern in ('/*','/**') or opm.pattern like '/xxen%')
)
union all
select 'client-role', null, null, null, ocr.role_name
from ords_metadata.ords_client_roles ocr
where ocr.client_name='xxen_webservices'
) y
union all
select
'6. Configuration',
'XXEN_WEBSERVICE_CONNECTION_TYPE',
nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'(not set - defaults to ORDS)'),
'Controls webservice transport: ORDS, ISG, or MOD_PLSQL',
case xxen_webservices.connection_type
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
-- Derived ORDS URL: shows what xxen_webservices.webservice_url auto-derives.
-- When XXEN_WEBSERVICE_ORDS_URL is set, webservice_url returns that profile value (which is the override).
-- When the profile is null, webservice_url derives the URL as host/context/schema_alias/
-- where alias comes from ords_metadata.ords_url_mappings (authoritative) and host comes from
-- FND_APEX_URL when APEX is installed, otherwise APPS_SERVLET_AGENT host on :8443/ords/.
select
'6. Configuration',
'Derived ORDS URL',
case when fnd_profile.value('XXEN_WEBSERVICE_ORDS_URL') is not null
then '(XXEN_WEBSERVICE_ORDS_URL profile is set; auto-derivation bypassed)'
else nvl(
(select case when fnd_profile.value('FND_APEX_URL') is not null
then fnd_profile.value('FND_APEX_URL')||case when substr(fnd_profile.value('FND_APEX_URL'),-1)<>'/' then '/' end||oum.pattern||'/'
else (select regexp_substr(fpov.profile_option_value,'https?://[^/:]+')||':8443/ords/'||oum.pattern||'/'
from fnd_profile_option_values fpov
where fpov.profile_option_id in (select fpo.profile_option_id from fnd_profile_options fpo where fpo.profile_option_name='APPS_SERVLET_AGENT')
and fpov.level_id=10001 and rownum=1)
end
from ords_metadata.ords_schemas os, ords_metadata.ords_modules om, ords_metadata.ords_url_mappings oum
where os.id=om.schema_id and om.name='xxen_webservices' and os.url_mapping_id=oum.id and rownum=1),
xxen_webservices.webservice_url
)
end,
'Schema alias source: ords_metadata.ords_url_mappings | Host source: '||case when fnd_profile.value('FND_APEX_URL') is not null then 'FND_APEX_URL' else 'APPS_SERVLET_AGENT + :8443/ords/' end,
'OK',
6
from dual
union all
select
'6. Configuration',
'XXEN_WEBSERVICE_ORDS_URL',
nvl(fnd_profile.value('XXEN_WEBSERVICE_ORDS_URL'),'(not set - auto-derived)'),
'Effective URL: '||xxen_webservices.webservice_url||' | Token endpoint: '||xxen_webservices.webservice_url||'oauth/token',
case
when xxen_webservices.connection_type<>'ORDS' then 'OK'
when xxen_webservices.webservice_url is not null then 'OK'
else 'Warning'
end,
6
from dual
union all
select
'6. Configuration',
'ORDS URL Protocol',
case
when u.connection_type<>'ORDS' then '(not applicable)'
when u.ords_url is null then '(no URL)'
when lower(u.ords_url) like 'https://%' then 'HTTPS'
when lower(u.ords_url) like 'http://%' then 'HTTP - not encrypted'
else '(unrecognized)'
end,
case
when u.connection_type<>'ORDS' then 'Applies to the ORDS transport only. The connection type is '||u.connection_type
when lower(u.ords_url) like 'https://%' then 'OAuth2 token requests are encrypted, as ORDS requires'
else 'ORDS refuses OAuth2 requests received over HTTP and returns HTTP 403, so the add-in cannot obtain a bearer token and every later call fails with HTTP 401. Move ORDS to HTTPS, or set security.verifySSL to false on the ORDS host - development and test only, because the OAuth client id and secret then travel in clear text'
end,
case
when u.connection_type<>'ORDS' then 'OK'
when lower(u.ords_url) like 'https://%' then 'OK'
when u.ords_url is null then 'Warning'
else 'Error'
end,
6
from
(select xxen_webservices.webservice_url ords_url, xxen_webservices.connection_type from dual) u
union all
select
'6. Configuration',
'ORDS security.verifySSL',
case
when u.connection_type<>'ORDS' then '(not applicable)'
else '(not readable from the database)'
end,
case
when u.connection_type<>'ORDS' then 'Applies to the ORDS transport only. The connection type is '||u.connection_type
when lower(u.ords_url) like 'https://%' then 'The ORDS default of true is correct for an HTTPS URL - nothing to change'
else 'With an HTTP URL this setting decides which failure occurs: true, the ORDS default, means no bearer token can be obtained at all (HTTP 403); false means OAuth2 over HTTP is permitted and the client id and secret are sent in clear text. It is an ORDS instance setting held in the ORDS configuration file, not in the database - read it on the ORDS host with the ORDS command line: ords config get security.verifySSL'
end,
case
when u.connection_type<>'ORDS' then 'OK'
when lower(u.ords_url) like 'https://%' then 'OK'
else 'Warning'
end,
6
from
(select xxen_webservices.webservice_url ords_url, xxen_webservices.connection_type from dual) u
union all
select
'6. Configuration',
'OAuth2 Client ID',
case when xxen_webservices.ords_client_id is not null then 'Available' else 'Not Found' end,
case when xxen_webservices.ords_client_id is not null then 'Client ID retrieved successfully' else 'Cannot retrieve client_id from user_ords_clients' end,
case
when xxen_webservices.connection_type<>'ORDS' then 'OK'
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
when xxen_webservices.connection_type<>'ORDS' then 'OK'
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
when xxen_webservices.connection_type<>'ORDS' then 'OK'
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

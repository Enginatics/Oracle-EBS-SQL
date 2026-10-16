/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Add-in Environment Setup
-- Description: Generates connection configuration for the Blitz Report Excel Add-in. Open the output file in Excel with the add-in installed to auto-configure the environment.
-- Excel Example Output: https://www.enginatics.com/example/blitz-report-add-in-environment-setup/
-- Library Link: https://www.enginatics.com/reports/blitz-report-add-in-environment-setup/
-- Run Report: https://demo.enginatics.com/

select
sys_context('userenv','db_name') "Environment Name",
xxen_webservices.connection_type "Connection Type",
xxen_webservices.webservice_url "Webservice URL",
case when xxen_webservices.connection_type='ORDS' then xxen_webservices.ords_client_id end "ORDS Client ID",
case when xxen_webservices.connection_type='ORDS' then xxen_webservices.ords_client_secret end "ORDS Client Secret",
xxen_webservices.login_method "Login Method",
xxen_webservices.login_url "Login URL",
fnd_global.user_name "User Name",
(select v.value from v$parameter v where v.name='nls_language') "NLS Language",
(select dbms_lob.substr(xmlagg(xmlelement(e,nvl(flv.description,initcap(replace(lower(flv.nls_language),'_',' ')))||'='||flv.nls_language||'|') order by decode(flv.installed_flag,'B',0,1), nvl(flv.description,flv.nls_language)).extract('//text()').getclobval(),4000,1) from fnd_languages_vl flv where flv.installed_flag in ('B','I')) "NLS Languages"
from dual

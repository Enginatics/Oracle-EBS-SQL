/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Add-in Setup Environment
-- Description: Generates connection configuration for the Blitz Report Excel Add-in. Open the output file in Excel with the add-in installed to auto-configure the environment.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-add-in-setup-environment/
-- Library Link: https://www.enginatics.com/reports/blitz-report-add-in-setup-environment/
-- Run Report: https://demo.enginatics.com/

select
sys_context('userenv','db_name') environment_name,
nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'ORDS') connection_type,
xxen_webservices.instance_url,
case when nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'ORDS')='ORDS' then xxen_webservices.ords_client_id end ords_client_id,
case when nvl(fnd_profile.value('XXEN_WEBSERVICE_CONNECTION_TYPE'),'ORDS')='ORDS' then xxen_webservices.ords_client_secret end ords_client_secret,
nvl(fnd_profile.value('XXEN_REPORT_SSO_ENABLED'),'N') sso_enabled,
fnd_global.user_name user_name,
(select v.value from v$parameter v where v.name='nls_language') nls_language
from dual
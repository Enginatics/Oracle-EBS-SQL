/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Compare FND Lookup Values between environments
-- Description: Compares lookup values between the local and a remote database environment
-- Excel Examle Output: https://www.enginatics.com/example/compare-fnd-lookup-values-between-environments/
-- Library Link: https://www.enginatics.com/reports/compare-fnd-lookup-values-between-environments/
-- Run Report: https://demo.enginatics.com/

select
nvl(flv.lookup_type,flv2.lookup_type) lookup_type,
nvl(flv.lookup_code,flv2.lookup_code) lookup_code,
nvl(flv.language,flv2.language) language,
flv.source_lang,
flv2.source_lang source_lang_remote,
decode(nvl(flv.source_lang,'x'),nvl(flv2.source_lang,'x'),null,'Y') source_lang_different,
flv.description,
flv2.description description_remote,
decode(nvl(flv.description,'x'),nvl(flv2.description,'x'),null,'Y') description_different,
flv.meaning,
flv2.meaning meaning_remote,
decode(nvl(flv.meaning,'x'),nvl(flv2.meaning,'x'),null,'Y') meaning_different
from
(select flv.* from fnd_lookup_values flv where 1=1) flv
full join
(select flv.* from fnd_lookup_values@&database_link flv where 1=1) flv2
on
flv.lookup_type=flv2.lookup_type and
flv.lookup_code=flv2.lookup_code and
flv.language=flv2.language and
flv.view_application_id=flv2.view_application_id and
flv.security_group_id=flv2.security_group_id
where
2=2
/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Information Type Security
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/per-information-type-security/
-- Library Link: https://www.enginatics.com/reports/per-information-type-security/
-- Run Report: https://demo.enginatics.com/

select
fav.application_name,
frv.responsibility_name,
pitsv.info_type_table_name,
pitsv.information_type,
pitsv.context_name,
pitsv.legislation_code,
xxen_util.user_name(pitsv.created_by) created_by,
xxen_util.client_time(pitsv.creation_date) creation_date,
xxen_util.user_name(pitsv.last_updated_by) last_updated_by,
xxen_util.client_time(pitsv.last_update_date) last_update_date
from
fnd_application_vl fav,
fnd_responsibility_vl frv,
per_info_type_security_v pitsv
where
1=1 and
pitsv.application_id=fav.application_id and
pitsv.application_id=frv.application_id and
pitsv.responsibility_id=frv.responsibility_id
order by
fav.application_name,
frv.responsibility_name,
pitsv.info_type_table_name,
pitsv.information_type
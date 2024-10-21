/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Messages
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/fnd-messages/
-- Library Link: https://www.enginatics.com/reports/fnd-messages/
-- Run Report: https://demo.enginatics.com/

select
fav.application_name application,
fnm.message_name,
fnm.language_code language,
fnm.message_text,
fnm.message_number,
xxen_util.meaning(fnm.type,'MESSAGE_TYPES',0) type,
fnm.max_length,
fnm.description,
xxen_util.meaning(fnm.category,'FND_KBF_CATEGORY',0) alert_category,
xxen_util.meaning(fnm.severity,'FND_KBF_SEVERITY',0) alert_severity,
xxen_util.meaning(fnm.fnd_log_severity,'FND_LOG_SEVERITY_LEVEL',0) log_severity,
xxen_util.user_name(fnm.created_by) created_by,
xxen_util.client_time(fnm.creation_date) creation_date,
xxen_util.user_name(fnm.last_updated_by) last_updated_by,
xxen_util.client_time(fnm.last_update_date) last_update_date
from
fnd_new_messages fnm,
fnd_application_vl fav
where
1=1 and
fnm.application_id=fav.application_id
order by
fav.application_name,
fnm.message_name,
fnm.language_code
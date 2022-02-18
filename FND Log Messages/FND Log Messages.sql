/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Log Messages
-- Excel Examle Output: https://www.enginatics.com/example/fnd-log-messages/
-- Library Link: https://www.enginatics.com/reports/fnd-log-messages/
-- Run Report: https://demo.enginatics.com/

select
xxen_util.user_name(flm.user_id) user_name,
xxen_util.meaning(flm.log_level,'AFLOG_LEVELS',0) log_level_name,
flm.*
from
fnd_log_messages flm
where
1=1
order by
flm.timestamp desc
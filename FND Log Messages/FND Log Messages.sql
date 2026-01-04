/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Log Messages
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/fnd-log-messages/
-- Library Link: https://www.enginatics.com/reports/fnd-log-messages/
-- Run Report: https://demo.enginatics.com/

select
trunc(flm.timestamp,'month') month,
xxen_util.user_name(flm.user_id) user_name,
xxen_util.meaning(flm.log_level,'AFLOG_LEVELS',0) log_level_name,
fltc.transaction_type,
flm.*
from
fnd_log_messages flm,
fnd_log_transaction_context fltc
where
1=1 and
flm.transaction_context_id=fltc.transaction_context_id(+)
order by
flm.log_sequence desc
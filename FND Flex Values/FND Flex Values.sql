/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Flex Values
-- Excel Examle Output: https://www.enginatics.com/example/fnd-flex-values
-- Library Link: https://www.enginatics.com/reports/fnd-flex-values
-- Run Report: https://demo.enginatics.com/


select
ffvs.flex_value_set_name,
ffvv.flex_value,
ffvv.flex_value_meaning,
ffvv.description,
xxen_util.meaning(decode(ffvv.summary_flag,'Y','Y'),'YES_NO',0) summary_flag,
ffvv.parent_flex_value_low,
ffvv.parent_flex_value_high,
ffvv.start_date_active,
ffvv.end_date_active,
xxen_util.meaning(decode(ffvv.enabled_flag,'Y','Y'),'YES_NO',0) enabled_flag,
xxen_util.user_name(ffvv.created_by) created_by,
xxen_util.client_time(ffvv.creation_date) creation_date,
xxen_util.user_name(ffvv.last_updated_by) last_updated_by,
xxen_util.client_time(ffvv.last_update_date) last_update_date
from
fnd_flex_value_sets ffvs,
fnd_flex_values_vl ffvv
where
1=1 and
ffvs.flex_value_set_id=ffvv.flex_value_set_id
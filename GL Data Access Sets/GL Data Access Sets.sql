/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Data Access Sets
-- Description: Master data report showing GL account security access across multiple ledgers.
-- Excel Examle Output: https://www.enginatics.com/example/gl-data-access-sets/
-- Library Link: https://www.enginatics.com/reports/gl-data-access-sets/
-- Run Report: https://demo.enginatics.com/

select
gasv.name access_set,
gasv.description access_set_description,
gasv.chart_of_accounts_name chart_of_accounts,
gasv.period_set_name calendar,
gasv.user_period_type period_type,
decode(gasv.security_segment_code,'F','Full Ledger','B','Balancing Segment Value','M','Management Segment Value') access_set_type,
gasv.default_ledger_name default_ledger,
gasnav.ledger_name,
xxen_util.meaning(gl.ledger_category_code,'GL_ASF_LEDGER_CATEGORY',101) ledger_category,
xxen_util.meaning(gasnav.all_segment_value_flag,'YES_NO',0) all_values,
gasnav.segment_value specific_value,
decode(gasnav.access_privilege_code,'B','Read and Write','R','Read Only') privilege,
xxen_util.user_name(gasnav.created_by) created_by,
xxen_util.client_time(gasnav.creation_date) creation_date,
xxen_util.user_name(gasnav.last_updated_by) last_updated_by,
xxen_util.client_time(gasnav.last_update_date) last_update_date,
gasv.access_set_id
from
gl_access_sets_v gasv,
gl_access_set_norm_assign_v gasnav,
gl_ledgers gl
where
1=1 and
gasv.access_set_id=gasnav.access_set_id(+) and
gasnav.ledger_id=gl.ledger_id(+) and
(gasnav.status_code is null or gasnav.status_code<>'D')
order by
gasv.name,
gasnav.ledger_name
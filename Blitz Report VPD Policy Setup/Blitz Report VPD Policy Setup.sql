/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report VPD Policy Setup
-- Description: Lists tables and columns to be secured by Blitz Report's VPD policy functionality (concurrent program 'Blitz Report Update VPD Policies') from lookup XXEN_REPORT_VPD_POLICY_TABLES and validates if corresponding DB policies have been created.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-vpd-policy-setup/
-- Library Link: https://www.enginatics.com/reports/blitz-report-vpd-policy-setup/
-- Run Report: https://demo.enginatics.com/

select
flv.lookup_code,
flv.owner,
flv.table_name,
flv.column_name,
xxen_util.meaning((select 'Y' from dba_policies dp where dp.policy_name='XXEN_VPD' and flv.owner=dp.object_owner and flv.table_name=dp.object_name and dp.enable='YES'),'YES_NO',0) vpd_policy_active,
flv.description,
flv.tag,
xxen_util.meaning(decode(flv.enabled_flag,'Y','Y'),'YES_NO',0) enabled,
flv.start_date_active,
flv.end_date_active,
case
when flv.column_name is not null and atc.column_name is null then 'Column not found'
when flv.table_name is not null and at.table_name is null then 'Table not found'
when flv.table_name is null then 'Please specify table or columns in format: owner.table_name.column_name'
end validation_error,
flv.meaning,
xxen_util.user_name(flv.created_by) created_by,
xxen_util.client_time(flv.creation_date) creation_date,
xxen_util.user_name(flv.last_updated_by) last_updated_by,
xxen_util.client_time(flv.last_update_date) last_update_date
from
(
select
regexp_substr(flv.meaning,'[^\.]+',1,1) owner,
regexp_substr(flv.meaning,'[^\.]+',1,2) table_name,
regexp_substr(flv.meaning,'[^\.]+',1,3) column_name,
flv.*
from
fnd_lookup_values flv
where
flv.lookup_type='XXEN_REPORT_VPD_POLICY_TABLES' and
flv.language='US' and
flv.view_application_id=0 and
flv.security_group_id=0
) flv,
all_tables at,
all_tab_columns atc
where
flv.owner=at.owner(+) and
flv.table_name=at.table_name(+) and
flv.owner=atc.owner(+) and
flv.table_name=atc.table_name(+) and
flv.column_name=atc.column_name(+)
order by
flv.owner,
flv.table_name,
flv.column_name nulls  first
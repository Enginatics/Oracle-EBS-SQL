/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report LOVs
-- Description: Blitz Report list of values
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-lovs/
-- Library Link: https://www.enginatics.com/reports/blitz-report-lovs/
-- Run Report: https://demo.enginatics.com/

select
xrplv.lov_name,
xrplv.description,
xxen_util.meaning(xrplv.validate_from_list,'YES_NO',0) validate_from_list,
xxen_util.meaning(xrplv.filter_before_display,'YES_NO',0) filter_before_display,
decode(xrplv.usage_count,0,to_number(null),xrplv.usage_count) usage_count,
xrplv.version,
(select max(xrplh.creation_date) from xxen_report_parameter_lovs_h xrplh where xrplv.lov_id=xrplh.lov_id) last_sql_update_date,
xxen_util.user_name(xrplv.created_by) created_by,
xxen_util.client_time(xrplv.creation_date) creation_date,
xxen_util.user_name(xrplv.last_updated_by) last_updated_by,
xxen_util.client_time(xrplv.last_update_date) last_update_date,
xrplv.lov_query,
length(xrplv.lov_query) lov_query_size
from
(
select
(select count(*) from xxen_report_parameters xrp where xrp.parameter_type='LOV' and xrplv.lov_id=xrp.lov_id) usage_count,
xrplv.*
from
xxen_report_parameter_lovs_v xrplv
) xrplv
where
1=1
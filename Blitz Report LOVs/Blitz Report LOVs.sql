/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report LOVs
-- Description: Blitz Report lists of values: shared LOVs, and the custom LOVs of report parameters and upload columns.
-- The count columns show the last result of the concurrent program Blitz Report Update LOV Filter Before Display, which sets filter before display on LOVs with more rows than its row limit and removes it from LOVs within the limit.
-- Excel Example Output: https://www.enginatics.com/example/blitz-report-lovs/
-- Library Link: https://www.enginatics.com/reports/blitz-report-lovs/
-- Run Report: https://demo.enginatics.com/

select
xrplv.type,
xrplv.lov_name,
xrplv.report_name,
xrplv.parameter_name,
xrplv.column_name,
xrplv.description,
xxen_util.meaning(xrplv.filter_before_display,'YES_NO',0) filter_before_display,
xrlc.status count_status,
xrlc.filter_change,
xrlc.row_count,
xxen_util.client_time(xrlc.last_update_date) count_date,
decode(xrplv.usage_count,0,to_number(null),xrplv.usage_count) usage_count,
xrplv.version,
(select max(xrplh.creation_date) from xxen_report_parameter_lovs_h xrplh where xrplv.lov_id=xrplh.lov_id) last_sql_update_date,
xxen_util.user_name(xrplv.created_by) created_by,
xxen_util.client_time(xrplv.creation_date) creation_date,
xxen_util.user_name(xrplv.last_updated_by) last_updated_by,
xxen_util.client_time(xrplv.last_update_date) last_update_date,
xrplv.lov_query,
length(xrplv.lov_query) lov_query_size,
xrplv.lov_id,
xrplv.report_id,
xrplv.parameter_id
from
(
select
'LOV' type,
xrplv.lov_name,
to_char(null) report_name,
to_char(null) parameter_name,
to_char(null) column_name,
xrplv.description,
xrplv.filter_before_display,
(select count(*) from xxen_report_parameters xrp where xrp.parameter_type='LOV' and xrplv.lov_id=xrp.lov_id)+
(select count(*) from xxen_upload_columns xuc where xuc.column_type='LOV' and xrplv.lov_id=xuc.lov_id) usage_count,
xrplv.version,
xrplv.created_by,
xrplv.creation_date,
xrplv.last_updated_by,
xrplv.last_update_date,
xrplv.lov_query,
xrplv.lov_id,
to_number(null) report_id,
to_number(null) parameter_id,
to_char(xrplv.lov_id) count_key
from
xxen_report_parameter_lovs_v xrplv
union all
select
'Parameter' type,
to_char(null) lov_name,
xrt.report_name,
xrpt.parameter_name,
to_char(null) column_name,
xrpt.description,
xrp.filter_before_display,
to_number(null) usage_count,
to_number(null) version,
xrp.created_by,
xrp.creation_date,
xrp.last_updated_by,
xrp.last_update_date,
xrp.lov_query,
to_number(null) lov_id,
xrp.report_id,
xrp.parameter_id,
to_char(xrp.parameter_id) count_key
from
xxen_report_parameters xrp,
xxen_report_parameters_tl xrpt,
xxen_reports_tl xrt
where
xrp.parameter_type='LOV' and
xrp.lov_id is null and
xrp.display_sequence is not null and
xrp.parameter_id=xrpt.parameter_id and
xrpt.language=userenv('lang') and
xrp.report_id=xrt.report_id and
xrt.language=userenv('lang')
union all
select
'Upload Column' type,
to_char(null) lov_name,
xrt.report_name,
to_char(null) parameter_name,
xuc.column_name,
xuc.comments description,
xuc.filter_before_display,
to_number(null) usage_count,
to_number(null) version,
xuc.created_by,
xuc.creation_date,
xuc.last_updated_by,
xuc.last_update_date,
xuc.lov_query,
to_number(null) lov_id,
xuc.report_id,
to_number(null) parameter_id,
xuc.report_id||'.'||xuc.column_name count_key
from
xxen_upload_columns xuc,
xxen_reports_tl xrt
where
xuc.column_type='LOV' and
xuc.lov_id is null and
xuc.report_id=xrt.report_id and
xrt.language=userenv('lang')
) xrplv,
(
select
xrlc.*,
decode(xrlc.type,'LOV',to_char(xrlc.lov_id),'Parameter',to_char(xrlc.parameter_id),xrlc.report_id||'.'||xrlc.column_name) count_key
from
xxen_report_lov_counts xrlc
) xrlc
where
1=1 and
xrplv.type=xrlc.type(+) and
xrplv.count_key=xrlc.count_key(+)

/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Templates
-- Description: Blitz Report column or pivot aggregation layout templates
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-templates/
-- Library Link: https://www.enginatics.com/reports/blitz-report-templates/
-- Run Report: https://demo.enginatics.com/

select distinct
xrtv.report_name,
xrtv.report_description,
xrtv.category,
xrtv.template_name,
xrtv.description,
xrtv.owner,
xrtv.sharing,
xxen_util.meaning(xrtv.global_default,'YES_NO',0) global_default,
xxen_util.meaning(xrtv.distinct_flag,'YES_NO',0) distinct_flag,
count(*) over (partition by xrtv.template_id) column_count,
max(xxen_util.meaning(xrtc.aggregation,'AMS_EXPN_BUILDER_OPERATORS',530)) over (partition by xrtv.template_id) max_aggregation,
max(nvl2(xrtc.sort_order,xrtc.direction||' ',null)||xrtc.sort_order_) over (partition by xrtv.template_id) max_sort_order,
(select sum(length(xrtf.file_data)) from xxen_report_template_files xrtf where xrtv.template_id=xrtf.template_id) file_size,
xrtv.file_name excel_file_name,
(select xrtf.sheet_name from xxen_report_template_files xrtf where xrtv.template_id=xrtf.template_id and xrtf.sheet_type='data') data_sheet_name,
xxen_util.client_time(xrtv.file_last_modified_date) file_last_modified,
xxen_util.user_name(xrtv.created_by) created_by,
xxen_util.client_time(xrtv.creation_date) creation_date,
xxen_util.user_name(xrtv.last_updated_by) last_updated_by,
xxen_util.client_time(xrtv.last_update_date) last_update_date,
&columns
xrtv.template_id
from
xxen_report_templates_v xrtv,
(
select
xxen_util.meaning(xrtc.aggregation,'AMS_EXPN_BUILDER_OPERATORS',530) aggregation_meaning,
xxen_util.meaning(case when xrtc.sort_order<0 then 2 else sign(xrtc.sort_order) end,'WMS_SORT_ORDER',700) direction,
abs(xrtc.sort_order) sort_order_,
xxen_util.meaning(xrtc.sheet_break,'YES_NO',0) sheet_break_,
(select distinct listagg(xrtp.field_type,', ') within group (order by xrtp.field_type) over () pivot_field_type from xxen_report_template_pivot xrtp where xrtc.template_id=xrtp.template_id and xrtc.column_name=xrtp.column_name) pivot_field_type,
xrtc.*
from
xxen_report_template_columns xrtc
where
'&show_columns'='Y' and
xrtc.display_sequence is not null
) xrtc
where
1=1 and
xrtv.template_id=xrtc.template_id(+)
order by
report_name,
owner,
xrtv.template_name
&column_order_by
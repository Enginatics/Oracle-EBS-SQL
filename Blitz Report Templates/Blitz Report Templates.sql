/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
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
xrtv.template_name,
xrtv.owner,
xxen_util.meaning(xrtv.public_flag,'YES_NO',0) public_flag,
xxen_util.meaning(xrtv.global_default,'YES_NO',0) global_default,
xxen_util.meaning(xrtv.distinct_flag,'YES_NO',0) distinct_flag,
count(*) over (partition by xrtv.template_id) column_count,
max(xxen_util.meaning(xrtc.aggregation,'AMS_EXPN_BUILDER_OPERATORS',530)) over (partition by xrtv.template_id) max_aggregation,
max(xrtc.sort_order_||nvl2(xrtc.sort_order,' '||xrtc.direction,null)) over (partition by xrtv.template_id) max_sort_order,
xrtv.creation_date
&columns
from
xxen_report_templates_v xrtv,
(
select
xxen_util.meaning(xrtc.aggregation,'AMS_EXPN_BUILDER_OPERATORS',530) aggregation_meaning,
abs(xrtc.sort_order) sort_order_,
xxen_util.meaning(case when xrtc.sort_order<0 then 2 else sign(xrtc.sort_order) end,'WMS_SORT_ORDER',700) direction,
xrtc.*
from
xxen_report_template_columns xrtc
) xrtc
where
1=1 and
xrtv.template_id=xrtc.template_id(+)
order by
xrtv.report_name,
owner,
xrtv.template_name
&column_order_by
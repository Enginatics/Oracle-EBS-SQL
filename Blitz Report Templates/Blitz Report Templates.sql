/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Templates
-- Description: Blitz Report column or pivot aggregation layout templates
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-templates/
-- Library Link: https://www.enginatics.com/reports/blitz-report-templates/
-- Run Report: https://demo.enginatics.com/

select
xrtv.report_name,
xrtv.template_name,
xxen_util.meaning(xrtv.public_flag,'YES_NO',0) public_flag,
xxen_util.meaning(xrtv.global_default,'YES_NO',0) global_default,
(select count(*) from xxen_report_template_columns xrtc where xrtv.template_id=xrtc.template_id) column_count,
xrtv.owner,
xrtv.creation_date
&columns
from
xxen_report_templates_v xrtv,
(select xrtc.* from xxen_report_template_columns xrtc where '&show_columns'='Y') xrtc
where
1=1 and
xrtv.template_id=xrtc.template_id(+)
order by
xrtv.report_name,
owner,
xrtv.template_name
&column_order_by
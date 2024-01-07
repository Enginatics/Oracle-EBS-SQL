/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL FSG Reports
-- Description: Financial Statement Generator reports
-- Excel Examle Output: https://www.enginatics.com/example/gl-fsg-reports/
-- Library Link: https://www.enginatics.com/reports/gl-fsg-reports/
-- Run Report: https://demo.enginatics.com/

select
rrv.name report_name,
rrv.report_title,
xxen_util.meaning(decode(rrv.security_flag,'Y','Y'),'YES_NO',0) security,
rrv.row_set,
rrv.column_set,
rrv.content_set,
rrv.row_order,
rrv.report_display_set display_set,
rrv.segment_override,
rrv.unit_of_measure_id currency,
xxen_util.meaning(rrv.rounding_option,'ROUNDING_OPTION',168) rounding_option,
xxen_util.meaning(rrv.minimum_display_level,'GL_DISPLAY_LEVEL',168) minimum_display_level,
xxen_util.meaning(rrv.output_option,'OUTPUT_OPTION',168) output_option,
rrv.description,
xxen_util.user_name(rrv.created_by) created_by,
xxen_util.client_time(rrv.creation_date) creation_date,
xxen_util.user_name(rrv.last_updated_by) last_updated_by,
xxen_util.client_time(rrv.last_update_date) last_update_date,
fifsv.id_flex_structure_name,
rrv.structure_id
from
rg_reports_v rrv,
fnd_id_flex_structures_vl fifsv
where
1=1 and
rrv.application_id=fifsv.application_id and
rrv.id_flex_code=fifsv.id_flex_code and
rrv.structure_id=fifsv.id_flex_num
order by
fifsv.id_flex_structure_name,
rrv.name
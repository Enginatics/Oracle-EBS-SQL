/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Column Translations
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-column-translations/
-- Library Link: https://www.enginatics.com/reports/blitz-report-column-translations/
-- Run Report: https://demo.enginatics.com/

select
xrc.column_name,
xrc.number_format,
flv.description language,
xrct.translation,
xrct.language language_code,
xxen_util.user_name(xrc.created_by) column_created_by,
xxen_util.client_time(xrc.creation_date) column_creation_date,
xxen_util.user_name(xrc.last_updated_by) column_last_updated_by,
xxen_util.client_time(xrc.last_update_date) column_last_update_date,
xxen_util.user_name(xrct.created_by) translation_created_by,
xxen_util.client_time(xrct.creation_date) translation_creation_date,
xxen_util.user_name(xrct.last_updated_by) translation_last_updated_by,
xxen_util.client_time(xrct.last_update_date) translation_last_update_date
from
xxen_report_columns xrc,
xxen_report_columns_tl xrct,
fnd_languages_vl flv
where
1=1 and
xrc.column_id=xrct.column_id(+) and
xrct.language=flv.language_code(+)
order by
xrc.column_name,
flv.description
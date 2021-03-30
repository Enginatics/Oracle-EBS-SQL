/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Compare Blitz Report Column Translations between environments
-- Description: Shows differences in Blitz Report column translations between the local and a remote database server
-- Excel Examle Output: https://www.enginatics.com/example/compare-blitz-report-column-translations-between-environments/
-- Library Link: https://www.enginatics.com/reports/compare-blitz-report-column-translations-between-environments/
-- Run Report: https://demo.enginatics.com/

select
nvl(xrct.column_name,xrct2.column_name) column_name,
nvl(xrct.language,xrct2.language) language,
xrct.translation,
xrct2.translation translation_remote
from
(
select
xrc.column_name,
xrct.language,
xrct.translation
from
xxen_report_columns xrc,
xxen_report_columns_tl xrct
where
xrc.column_id=xrct.column_id
) xrct
full join
(
select
xrc.column_name,
xrct.language,
xrct.translation
from
xxen_report_columns@&database_link xrc,
xxen_report_columns_tl@&database_link xrct
where
xrc.column_id=xrct.column_id
) xrct2
on
xrct.column_name=xrct2.column_name and
xrct.language=xrct2.language
where
1=1 and
nvl(xrct.translation,'x')<>nvl(xrct2.translation,'x')
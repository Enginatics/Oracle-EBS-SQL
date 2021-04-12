/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Compare Blitz Report Column Number Fomats between environments
-- Description: Shows differences in Blitz Report column translations between the local and a remote database server
-- Excel Examle Output: https://www.enginatics.com/example/compare-blitz-report-column-number-fomats-between-environments/
-- Library Link: https://www.enginatics.com/reports/compare-blitz-report-column-number-fomats-between-environments/
-- Run Report: https://demo.enginatics.com/

select
nvl(xrc.column_name,xrc2.column_name) column_name,
xrc.number_format,
xrc2.number_format number_format_remote,
xxen_util.user_name(xrc.last_updated_by) last_updated_by,
xrc.last_update_date,
xxen_util.user_name@&database_link(xrc2.last_updated_by) last_updated_by_remote,
xrc2.last_update_date last_update_date_remote,
xxen_util.user_name(xrc.created_by) created_by,
xrc.creation_date,
xxen_util.user_name@&database_link(xrc2.created_by) created_by_remote,
xrc2.creation_date creation_date_remote
from
(select xrc.* from xxen_report_columns xrc where xrc.number_format is not null) xrc
full join
(select xrc.* from xxen_report_columns@&database_link xrc where xrc.number_format is not null) xrc2
on
xrc.column_name=xrc2.column_name
where
1=1
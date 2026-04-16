/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Project Asset Details
-- Description: Capital project asset information showing CIP costs, capitalized amounts, FA asset numbers, estimated and actual in-service dates, and asset line transfer status.
-- Excel Examle Output: https://www.enginatics.com/example/pa-project-asset-details/
-- Library Link: https://www.enginatics.com/reports/pa-project-asset-details/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
ppa.segment1 project_number,
ppa.name project_name,
ppa.project_type,
(select pps.project_status_name from pa_project_statuses pps where pps.project_status_code=ppa.project_status_code) project_status,
ppaa.asset_name,
ppaa.asset_description,
(select fab.asset_number from fa_additions_b fab where fab.asset_id=ppaa.fa_asset_id) fa_asset_number,
ppaa.project_asset_type,
ppaa.estimated_cost,
ppaa.estimated_in_service_date,
ppaa.date_placed_in_service,
xxen_util.meaning(ppaa.capitalized_flag,'YES_NO',0) capitalized_flag,
ppaa.capitalized_date,
ppaa.book_type_code,
ppaa.asset_units,
ppaa.estimated_asset_units,
nvl(ppala.original_asset_cost,0) original_asset_cost,
nvl(ppala.current_asset_cost,0) current_asset_cost,
(select pce.capital_event_number from pa_capital_events pce where pce.capital_event_id=ppala.capital_event_id) capital_event,
ppala.description asset_line_description,
ppala.gl_date asset_line_gl_date,
ppala.fa_period_name,
xxen_util.meaning(ppala.transfer_status_code,'TRANSFER STATUS',275) asset_line_transfer_status,
ppaa.manufacturer_name,
ppaa.model_number,
ppaa.serial_number,
ppaa.tag_number,
xxen_util.meaning(ppaa.reverse_flag,'YES_NO',0) reverse_flag,
xxen_util.meaning(ppaa.capital_hold_flag,'YES_NO',0) capital_hold_flag,
xxen_util.user_name(ppaa.created_by) created_by,
ppaa.creation_date,
xxen_util.user_name(ppaa.last_updated_by) last_updated_by,
ppaa.last_update_date
from
pa_project_assets_all ppaa,
pa_projects_all ppa,
pa_project_asset_lines_all ppala,
hr_all_organization_units_vl haouv
where
1=1 and
ppaa.project_id=ppa.project_id and
ppaa.project_asset_id=ppala.project_asset_id(+) and
ppa.org_id=haouv.organization_id and
haouv.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
order by
haouv.name,
ppa.segment1,
ppaa.asset_name
/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MRP Item Forecast
-- Description: Detail report for item planning forecast, including forecast description, planner, item, bucket type, forecast start and end dates, current quantity, original qty, project related data, and confidence projection.
-- Excel Examle Output: https://www.enginatics.com/example/mrp-item-forecast/
-- Library Link: https://www.enginatics.com/reports/mrp-item-forecast/
-- Run Report: https://demo.enginatics.com/

select
ood.organization_name organization,
ood.organization_code,
nvl(mfds0.forecast_designator,mfds.forecast_designator) forecast_set,
nvl(mfds0.description,mfds.description) set_description,
nvl2(mfds.forecast_set,mfds.forecast_designator,null) forecast,
nvl2(mfds.description,mfds.description,null) description,
msiv.planner_code planner,
mpl.description planner_description,
msiv.concatenated_segments item,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
msiv.primary_uom_code uom,
mfiv.alternate_bom_designator alternate_bill,
xxen_util.meaning(mfiv.bom_item_type,'BOM_ITEM_TYPE',700) bill_type,
mfiv.ato_forecast_control_desc forecast_control,
mfiv.mrp_planning_code_desc mrp_planning_method,
xxen_util.meaning(mfd.origination_type,'MRP_FORECAST_ORIG',700) origination_type,
xxen_util.meaning(mfd.bucket_type,'MRP_BUCKET_TYPE',700) bucket_type,
mfd.forecast_date,
mfd.rate_end_date end_date,
mfd.current_forecast_quantity current_quantity,
mfd.original_forecast_quantity original_quantity,
ppa.project_number project,
pt.task_number task,
mfd.confidence_percentage,
mfiv.alternate_bom_designator,
wl.line_code
from
org_organization_definitions ood,
mrp_forecast_items_v mfiv,
mrp_forecast_dates mfd,
mrp_forecast_designators mfds,
mrp_forecast_designators mfds0,
mtl_system_items_vl msiv,
(
select ppa.project_id, ppa.segment1 project_number from pa_projects_all ppa union
select psm.project_id, psm.project_number from pjm_seiban_numbers psm
) ppa,
pa_tasks pt,
wip_lines wl,
mtl_planners mpl
where
1=1 and
ood.organization_id=mfiv.organization_id and
mfiv.organization_id=mfd.organization_id and
mfiv.forecast_designator=mfd.forecast_designator and
mfiv.inventory_item_id=mfd.inventory_item_id and
mfiv.organization_id=mfds.organization_id and
mfiv.forecast_designator=mfds.forecast_designator and
mfds.organization_id=mfds0.organization_id(+) and
mfds.forecast_set=mfds0.forecast_designator(+) and
mfiv.organization_id=msiv.organization_id and
mfiv.inventory_item_id=msiv.inventory_item_id and
mfd.project_id=ppa.project_id(+) and
mfd.task_id=pt.task_id(+) and
mfd.line_id=wl.line_id(+) and
msiv.planner_code=mpl.planner_code(+) and
msiv.organization_id=mpl.organization_id(+)
order by
forecast_set,
forecast,
msiv.concatenated_segments,
mfd.forecast_date desc
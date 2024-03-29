/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Safety Stocks
-- Description: Master data report for inventory safety stock with inventory org code, item, effective date, UOM,safety stock quantity, safety stock method, forecast , safety stock percent, service level and creation information.
-- Excel Examle Output: https://www.enginatics.com/example/inv-safety-stocks/
-- Library Link: https://www.enginatics.com/reports/inv-safety-stocks/
-- Run Report: https://demo.enginatics.com/

select
haouv.name organization,
mp.organization_code,
msiv.concatenated_segments item,
msiv.description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
ppa.project_number project,
pt.task_number,
mss.effectivity_date,
muomv.unit_of_measure_tl uom,
msiv.primary_uom_code,
mss.safety_stock_quantity quantity,
xxen_util.meaning(mss.safety_stock_code,'MTL_SAFETY_STOCK',700) safety_stock_method,
mss.forecast_designator forecast,
mss.safety_stock_percent,
mss.service_level,
xxen_util.user_name(mss.created_by) created_by,
xxen_util.client_time(mss.creation_date) creation_date,
xxen_util.user_name(mss.last_updated_by) last_updated_by,
xxen_util.client_time(mss.last_update_date) last_update_date
from
hr_all_organization_units_vl haouv,
mtl_parameters mp,
mtl_safety_stocks mss,
mtl_system_items_vl msiv,
mtl_units_of_measure_vl muomv,
(
select ppa.project_id, ppa.segment1 project_number from pa_projects_all ppa union
select psm.project_id, psm.project_number from pjm_seiban_numbers psm
) ppa,
pa_tasks pt
where
1=1 and
mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
haouv.organization_id=mss.organization_id and
mp.organization_id=mss.organization_id and
mss.organization_id=msiv.organization_id and
mss.inventory_item_id=msiv.inventory_item_id and
msiv.primary_uom_code=muomv.uom_code and
mss.project_id=ppa.project_id(+) and
mss.task_id=pt.task_id(+)
order by
mp.organization_code,
msiv.concatenated_segments
/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: OPM Item Process and Recipe Attributes
-- Description: Oracle Process Manufacturing (OPM) item attributes: for every process-manufacturing-enabled item, its recipe, process-execution, quality and costing enabled flags, grade control and default grade, lot / child-lot control, lot divisibility, and shelf-life control and days. Lets formulation and QA teams see which items are recipe and process enabled.
-- Excel Example Output: https://www.enginatics.com/example/opm-item-process-and-recipe-attributes/
-- Library Link: https://www.enginatics.com/reports/opm-item-process-and-recipe-attributes/
-- Run Report: https://demo.enginatics.com/

select
ood.organization_code,
msiv.concatenated_segments item,
msiv.description,
msiv.inventory_item_status_code item_status,
msiv.primary_uom_code uom,
xxen_util.yes(msiv.recipe_enabled_flag) recipe_enabled,
xxen_util.yes(msiv.process_execution_enabled_flag) process_execution_enabled,
xxen_util.yes(msiv.process_quality_enabled_flag) process_quality_enabled,
xxen_util.yes(msiv.process_costing_enabled_flag) process_costing_enabled,
xxen_util.yes(msiv.grade_control_flag) grade_controlled,
msiv.default_grade,
decode(msiv.lot_control_code,1,'No lot control',2,'Lot controlled') lot_control,
xxen_util.yes(msiv.child_lot_flag) child_lot_enabled,
xxen_util.yes(msiv.lot_divisible_flag) lot_divisible,
decode(msiv.shelf_life_code,1,'No shelf life control',2,'Shelf life days',4,'User-defined expiration') shelf_life_control,
msiv.shelf_life_days
from
mtl_system_items_vl msiv,
org_organization_definitions ood
where
1=1 and
msiv.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
msiv.organization_id=ood.organization_id and
(msiv.recipe_enabled_flag='Y' or msiv.process_execution_enabled_flag='Y' or msiv.process_quality_enabled_flag='Y' or msiv.process_costing_enabled_flag='Y')
order by
ood.organization_code,
msiv.concatenated_segments

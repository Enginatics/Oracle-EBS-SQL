/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: BOM Resource Upload
-- Description: Creates and updates resources - the Resources form (Bills of Material > Routings > Resources).
-- Resources cannot be deleted; enter an Inactive On date instead. Their rates and overhead associations per cost type are maintained with the CST Resource Rate Upload and the CST Resource Overhead Association Upload.
-- As in the form, Outside Processing defaults from a PO charge type and Costed from Outside Processing, and an outside processing resource takes the receiving inspection account of the organization as Absorption Account and its purchase price variance account as Variance Account. Outside Processing and Costed cannot be changed once the resource is used in routings, overheads, WIP or (Costed) has rates, and the UOM only with profile BOM: Update Resource UOM for resources not scheduled in routings or used in standard operations.
-- Supply Subinventory and Supply Locator apply to machines, Competence, Skill Level and Qualification to persons, Billable Item to types other than Amount. A currency resource takes the functional currency as UOM and is always costed. A batchable resource has basis Lot.
-- Excel Example Output: https://www.enginatics.com/example/bom-resource-upload/
-- Library Link: https://www.enginatics.com/reports/bom-resource-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
br.resource_id,
mp.organization_code,
br.resource_code,
br.disable_date inactive_on,
br.description,
decode(br.functional_currency_flag,1,fnd_message.get_string('FND','CURRENCY'),xxen_util.meaning(br.resource_type,'BOM_RESOURCE_TYPE',700)) resource_type,
br.unit_of_measure uom,
xxen_util.meaning(br.autocharge_type,'BOM_AUTOCHARGE_TYPE',700) charge_type,
xxen_util.meaning(br.default_basis_type,'BOM_BASIS_TYPE',700) basis,
br.expenditure_type,
br.supply_subinventory,
milk.concatenated_segments supply_locator,
xxen_util.yes(decode(br.cost_code_type,4,'Y')) outside_processing,
msiv_p.concatenated_segments outside_processing_item,
msiv_p.description outside_processing_item_desc,
msiv_b.concatenated_segments billable_item,
msiv_b.description billable_item_description,
decode(br.allow_costs_flag,1,xxen_util.meaning('1','SYS_YES_NO',700)) costed,
ca.activity,
decode(br.standard_rate_flag,1,xxen_util.meaning('1','SYS_YES_NO',700)) standard_rate,
gcck_a.concatenated_segments absorption_account,
gcck_v.concatenated_segments variance_account,
pc.name competence,
(select to_char(prl.step_value)||'-'||prl.name from per_rating_levels prl where br.rating_level_id=prl.rating_level_id) skill_level,
pqt.name qualification,
decode(br.batchable,1,xxen_util.meaning('1','SYS_YES_NO',700)) batchable,
br.min_batch_capacity minimum_batch_capacity,
br.max_batch_capacity maximum_batch_capacity,
br.batch_capacity_uom,
br.batch_window batching_window,
br.batch_window_uom batching_window_uom,
xxen_util.display_flexfield_context(702,'BOM_RESOURCES',br.attribute_category) res_attribute_category,
xxen_util.display_flexfield_value(702,'BOM_RESOURCES',br.attribute_category,'ATTRIBUTE1',br.rowid,br.attribute1) res_attribute1,
xxen_util.display_flexfield_value(702,'BOM_RESOURCES',br.attribute_category,'ATTRIBUTE2',br.rowid,br.attribute2) res_attribute2,
xxen_util.display_flexfield_value(702,'BOM_RESOURCES',br.attribute_category,'ATTRIBUTE3',br.rowid,br.attribute3) res_attribute3,
xxen_util.display_flexfield_value(702,'BOM_RESOURCES',br.attribute_category,'ATTRIBUTE4',br.rowid,br.attribute4) res_attribute4,
xxen_util.display_flexfield_value(702,'BOM_RESOURCES',br.attribute_category,'ATTRIBUTE5',br.rowid,br.attribute5) res_attribute5,
xxen_util.display_flexfield_value(702,'BOM_RESOURCES',br.attribute_category,'ATTRIBUTE6',br.rowid,br.attribute6) res_attribute6,
xxen_util.display_flexfield_value(702,'BOM_RESOURCES',br.attribute_category,'ATTRIBUTE7',br.rowid,br.attribute7) res_attribute7,
xxen_util.display_flexfield_value(702,'BOM_RESOURCES',br.attribute_category,'ATTRIBUTE8',br.rowid,br.attribute8) res_attribute8,
xxen_util.display_flexfield_value(702,'BOM_RESOURCES',br.attribute_category,'ATTRIBUTE9',br.rowid,br.attribute9) res_attribute9,
xxen_util.display_flexfield_value(702,'BOM_RESOURCES',br.attribute_category,'ATTRIBUTE10',br.rowid,br.attribute10) res_attribute10,
xxen_util.display_flexfield_value(702,'BOM_RESOURCES',br.attribute_category,'ATTRIBUTE11',br.rowid,br.attribute11) res_attribute11,
xxen_util.display_flexfield_value(702,'BOM_RESOURCES',br.attribute_category,'ATTRIBUTE12',br.rowid,br.attribute12) res_attribute12,
xxen_util.display_flexfield_value(702,'BOM_RESOURCES',br.attribute_category,'ATTRIBUTE13',br.rowid,br.attribute13) res_attribute13,
xxen_util.display_flexfield_value(702,'BOM_RESOURCES',br.attribute_category,'ATTRIBUTE14',br.rowid,br.attribute14) res_attribute14,
xxen_util.display_flexfield_value(702,'BOM_RESOURCES',br.attribute_category,'ATTRIBUTE15',br.rowid,br.attribute15) res_attribute15,
to_number(null) upload_row
from
mtl_parameters mp,
bom_resources br,
mtl_item_locations_kfv milk,
mtl_system_items_vl msiv_p,
mtl_system_items_vl msiv_b,
cst_activities ca,
gl_code_combinations_kfv gcck_a,
gl_code_combinations_kfv gcck_v,
per_competences pc,
per_qualification_types pqt
where
1=1 and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=br.organization_id and
br.cost_code_type in (3,4) and
br.supply_locator_id=milk.inventory_location_id(+) and
br.organization_id=milk.organization_id(+) and
br.purchase_item_id=msiv_p.inventory_item_id(+) and
br.organization_id=msiv_p.organization_id(+) and
br.billable_item_id=msiv_b.inventory_item_id(+) and
br.organization_id=msiv_b.organization_id(+) and
br.default_activity_id=ca.activity_id(+) and
br.absorption_account=gcck_a.code_combination_id(+) and
br.rate_variance_account=gcck_v.code_combination_id(+) and
br.competence_id=pc.competence_id(+) and
br.qualification_type_id=pqt.qualification_type_id(+)

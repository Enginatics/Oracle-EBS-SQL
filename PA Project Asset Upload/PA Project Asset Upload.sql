/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Project Asset Upload
-- Description: PA Project Asset Upload
-- ======================
-- Create, update, or delete project assets and their task assignments for Oracle Projects capital projects, using the public API paprojectassetspub.
-- Supported Actions:
-- - Create / Update project asset (ESTIMATED or AS-BUILT types only — RETIREMENTADJUSTMENT is excluded)
-- - Add / Delete asset-to-task assignment (top-task rollup or leaf-task)
-- Row Structure (bundled parent-child):
-- - One row per (asset, assignment) pair
-- - Leave Assignment Task Number blank on a row to create/update just the asset header with no assignment
-- - For multiple assignments on the same asset, repeat the asset columns on subsequent rows with different Task Numbers
-- Report Parameters:
-- - Upload Mode: 'Create' or 'Create, Update'
-- - Operating Unit: filters Project LOV
-- - Project Number: the capital project (paprojectsall.segment1) to which uploaded assets belong
-- Notes:
-- - Capitalization and Reversal are NOT supported via this upload — use the Capital Assets form for those workflow actions
-- - The Depreciation Expense Account KFF is resolved against the chart of accounts of the project's ledger
-- - Asset-to-task assignments do not support an update API — to modify an existing assignment DFF, delete and re-add
-- Excel Example Output: https://www.enginatics.com/example/pa-project-asset-upload/
-- Library Link: https://www.enginatics.com/reports/pa-project-asset-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
-- operating unit and project
haouv.name operating_unit,
ppa.segment1 project_number,
ppa.name project_name,
-- asset identity
ppaa.project_asset_id,
ppaa.pm_asset_reference asset_reference,
ppaa.asset_name,
ppaa.asset_description description,
xxen_util.meaning(ppaa.project_asset_type,'PROJECT_ASSET_TYPES',275) project_asset_type,
ppaa.asset_number,
xxen_util.meaning(ppaa.pm_product_code,'PM_PRODUCT_CODE',275) product_source,
-- FA book and KFFs
ppaa.book_type_code book,
fcbk.concatenated_segments asset_category,
fakk.concatenated_segments asset_key,
flk.concatenated_segments location,
-- employee
papf.full_name employee_name,
papf.employee_number,
-- dates
ppaa.estimated_in_service_date,
ppaa.date_placed_in_service actual_in_service_date,
-- units and cost
ppaa.estimated_asset_units,
ppaa.asset_units actual_units,
ppaa.estimated_cost,
-- parent asset
fa.asset_number parent_asset_number,
-- flags
decode(ppaa.depreciate_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) depreciate,
decode(ppaa.amortize_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) amortize_adjustments,
gcck.concatenated_segments depreciation_expense_account,
decode(ppaa.capital_hold_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) capital_hold,
-- identification
ppaa.manufacturer_name,
ppaa.model_number,
ppaa.serial_number,
ppaa.tag_number,
-- asset DFF
xxen_util.display_flexfield_context(275,'PA_PROJECT_ASSETS',ppaa.attribute_category) asset_attribute_category,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSETS',ppaa.attribute_category,'ATTRIBUTE1',ppaa.rowid,ppaa.attribute1) asset_attribute1,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSETS',ppaa.attribute_category,'ATTRIBUTE2',ppaa.rowid,ppaa.attribute2) asset_attribute2,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSETS',ppaa.attribute_category,'ATTRIBUTE3',ppaa.rowid,ppaa.attribute3) asset_attribute3,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSETS',ppaa.attribute_category,'ATTRIBUTE4',ppaa.rowid,ppaa.attribute4) asset_attribute4,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSETS',ppaa.attribute_category,'ATTRIBUTE5',ppaa.rowid,ppaa.attribute5) asset_attribute5,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSETS',ppaa.attribute_category,'ATTRIBUTE6',ppaa.rowid,ppaa.attribute6) asset_attribute6,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSETS',ppaa.attribute_category,'ATTRIBUTE7',ppaa.rowid,ppaa.attribute7) asset_attribute7,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSETS',ppaa.attribute_category,'ATTRIBUTE8',ppaa.rowid,ppaa.attribute8) asset_attribute8,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSETS',ppaa.attribute_category,'ATTRIBUTE9',ppaa.rowid,ppaa.attribute9) asset_attribute9,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSETS',ppaa.attribute_category,'ATTRIBUTE10',ppaa.rowid,ppaa.attribute10) asset_attribute10,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSETS',ppaa.attribute_category,'ATTRIBUTE11',ppaa.rowid,ppaa.attribute11) asset_attribute11,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSETS',ppaa.attribute_category,'ATTRIBUTE12',ppaa.rowid,ppaa.attribute12) asset_attribute12,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSETS',ppaa.attribute_category,'ATTRIBUTE13',ppaa.rowid,ppaa.attribute13) asset_attribute13,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSETS',ppaa.attribute_category,'ATTRIBUTE14',ppaa.rowid,ppaa.attribute14) asset_attribute14,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSETS',ppaa.attribute_category,'ATTRIBUTE15',ppaa.rowid,ppaa.attribute15) asset_attribute15,
-- assignment
pt.task_id assignment_task_id,
pt.task_number assignment_task_number,
decode(case when pt.task_id is not null and pt.task_id=pt.top_task_id then 'Y' end,'Y',xxen_util.meaning('Y','YES_NO',0)) rollup,
null delete_assignment,
-- assignment DFF
xxen_util.display_flexfield_context(275,'PA_PROJECT_ASSET_ASSIGNMENTS',paas.attribute_category) assign_attribute_category,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSET_ASSIGNMENTS',paas.attribute_category,'ATTRIBUTE1',paas.rowid,paas.attribute1) assign_attribute1,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSET_ASSIGNMENTS',paas.attribute_category,'ATTRIBUTE2',paas.rowid,paas.attribute2) assign_attribute2,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSET_ASSIGNMENTS',paas.attribute_category,'ATTRIBUTE3',paas.rowid,paas.attribute3) assign_attribute3,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSET_ASSIGNMENTS',paas.attribute_category,'ATTRIBUTE4',paas.rowid,paas.attribute4) assign_attribute4,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSET_ASSIGNMENTS',paas.attribute_category,'ATTRIBUTE5',paas.rowid,paas.attribute5) assign_attribute5,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSET_ASSIGNMENTS',paas.attribute_category,'ATTRIBUTE6',paas.rowid,paas.attribute6) assign_attribute6,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSET_ASSIGNMENTS',paas.attribute_category,'ATTRIBUTE7',paas.rowid,paas.attribute7) assign_attribute7,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSET_ASSIGNMENTS',paas.attribute_category,'ATTRIBUTE8',paas.rowid,paas.attribute8) assign_attribute8,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSET_ASSIGNMENTS',paas.attribute_category,'ATTRIBUTE9',paas.rowid,paas.attribute9) assign_attribute9,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSET_ASSIGNMENTS',paas.attribute_category,'ATTRIBUTE10',paas.rowid,paas.attribute10) assign_attribute10,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSET_ASSIGNMENTS',paas.attribute_category,'ATTRIBUTE11',paas.rowid,paas.attribute11) assign_attribute11,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSET_ASSIGNMENTS',paas.attribute_category,'ATTRIBUTE12',paas.rowid,paas.attribute12) assign_attribute12,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSET_ASSIGNMENTS',paas.attribute_category,'ATTRIBUTE13',paas.rowid,paas.attribute13) assign_attribute13,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSET_ASSIGNMENTS',paas.attribute_category,'ATTRIBUTE14',paas.rowid,paas.attribute14) assign_attribute14,
xxen_util.display_flexfield_value(275,'PA_PROJECT_ASSET_ASSIGNMENTS',paas.attribute_category,'ATTRIBUTE15',paas.rowid,paas.attribute15) assign_attribute15,
to_number(null) upload_row
from
pa_projects_all ppa,
hr_all_organization_units_vl haouv,
pa_project_assets_all ppaa,
pa_project_asset_assignments paas,
pa_tasks pt,
fa_categories_b_kfv fcbk,
fa_asset_keywords_kfv fakk,
fa_locations_kfv flk,
fa_additions_v fa,
gl_code_combinations_kfv gcck,
per_all_people_f papf
where
1=1 and
ppa.org_id=haouv.organization_id and
ppa.project_id=ppaa.project_id and
ppaa.project_asset_type in ('AS-BUILT','ESTIMATED') and
ppaa.project_asset_id=paas.project_asset_id(+) and
paas.project_id(+)<>0 and
paas.task_id=pt.task_id(+) and
ppaa.asset_category_id=fcbk.category_id(+) and
ppaa.asset_key_ccid=fakk.code_combination_id(+) and
ppaa.location_id=flk.location_id(+) and
ppaa.parent_asset_id=fa.asset_id(+) and
ppaa.depreciation_expense_ccid=gcck.code_combination_id(+) and
ppaa.assigned_to_person_id=papf.person_id(+) and
trunc(sysdate) between papf.effective_start_date(+) and papf.effective_end_date(+)

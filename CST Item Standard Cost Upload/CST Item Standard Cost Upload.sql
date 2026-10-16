/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Item Standard Cost Upload
-- Description: CST Item Standard Cost Upload
-- =============================
-- This upload can be used to
-- - Upload New Item Costs
-- - Download the current Item Costs, Update, and Upload the amended item costs for a specified Cost Type
-- - Download the current item Costs from one Source cost type, update, and upload the amended item costs to a different Target Cost Type
-- NOTE:
-- You can only upload costs to cost types that are not flagged as frozen and are flagged as updateable. This upload is used for updating cost types using the standard costing method.
-- Optionally, the upload can perform a Cost Rollup after the Item Costs have been imported. The Cost Rollup can be performed for
-- - Specific Items - a cost rollup will be done for only those items for which costs have been uploaded
-- - All Items - in this mode the upload will submit the 'Supply Chain Cost Rollup - Print Report' concurrent request to roll up all items within each organization costs are uploaded to
-- NOTE: The Item Cost Interface only supports importing 'This Level' costs. As such, this upload does not support the direct upload of rolled up costs
-- Parameters
-- ==========
-- Target Cost Type (Required) - The Cost Type to which the Item Costs are to be uploaded to.
-- Mode (Required, Default: Remove and replace cost information) -
-- The Item Cost Update Mode
-- - Remove and replace cost information
-- - Insert new Cost Information Only
-- Auto Populate Upload Columns (Default: Yes) -
-- Applies to downloaded Item Cost Entries only. If set to Yes, the downloaded records are flagged ready for upload even if no changes have been made. If left blank, records are only flagged for upload when the user amends them. Where an Item Cost has multiple cost elements, all cost element records of that item must then be flagged for upload by amending them, as only flagged records are uploaded.
-- Source Cost Type
-- Optionally specify the source Cost Type from which to download the current Item Costs. For the scenarios where you want to amend the current items costs for a Cost Type or want to copy the current item costs for a Cost Type to a different Target Cost Type.
-- Rollup Costs - set to Yes to do a cost rollup after the costs are uploaded
-- Rollup Type - Rollup specific Items or All Items
-- Rollup Option - Single level rollup or Full cost rollup
-- NOTE:
-- In All Items mode the Supply Chain Cost Rollup requests are submitted asynchronously, and the upload does not wait for them, so the item summary costs in the upload result may not yet reflect the completed rollup.
-- Organization Code - Optionally select the Organization(s) for which you want to download the Item Costs for
-- Additional Parameters - optionally restrict the items to be downloaded.
-- Inventory Asset? (Default: Yes)
-- Costs can only be uploaded against items flagged as an inventory asset in the cost type, so others are excluded by default. Select No or clear it to download them, so the flag can be set to Yes and costs entered. On Release 12.1 and earlier the item must also be set as an inventory asset in the selected organization, or the import rejects it.
-- Based on Rollup? and Zero Cost Items? further restrict the download. Zero cost items include those with no cost details yet, which download with Cost Element, Sub-Element and Usage Rate or Amount defaulted.
-- Notes on the Upload
-- ===================
-- Mode Remove and replace rebuilds the whole item: the import deletes every cost detail the item holds in the cost type and re-creates it from the uploaded rows. All cost element rows of an item must therefore be uploaded together, which Auto Populate Upload Columns Yes ensures; clear it and amend one element only and the rest are deleted. Deleting a row removes that cost element.
-- Items whose costs default from the Default Cost Type have no cost details of their own, so they are not downloaded. Uploading costs against such an item gives it its own costs and it stops defaulting.
-- Excel Example Output: https://www.enginatics.com/example/cst-item-standard-cost-upload/
-- Library Link: https://www.enginatics.com/reports/cst-item-standard-cost-upload/
-- Run Report: https://demo.enginatics.com/

select
case when nvl2(:p_autopopulate_upload_status,'Y','N')='Y' then xxen_upload.action_meaning(xxen_upload.action_update) else null end action_,
case when nvl2(:p_autopopulate_upload_status,'Y','N')='Y' then xxen_upload.status_meaning(xxen_upload.status_new) else null end status_,
case when nvl2(:p_autopopulate_upload_status,'Y','N')='Y' then xxen_util.description('U_EXCEL_MSG_VALIDATION_PENDING','XXEN_REPORT_TRANSLATIONS',0) else null end message_,
to_number(null) request_id_,
null modified_columns_,
null row_id,
-- Item
cct_t.cost_type target_cost_type,
mp.organization_code,
msiv.concatenated_segments item,
msiv.description item_description,
(select misv.inventory_item_status_code_tl from mtl_item_status_vl misv where misv.inventory_item_status_code=msiv.inventory_item_status_code) item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_or_buy,
xxen_util.meaning(cic.inventory_asset_flag,'SYS_YES_NO',700) inventory_asset,
xxen_util.meaning(cic.based_on_rollup_flag,'CST_BONROLLUP_VAL',700) based_on_rollup,
coalesce(cic.lot_size,msiv.std_lot_size,1) lot_size,
coalesce(cic.shrinkage_rate,msiv.shrinkage_rate,0) shrinkage_rate,
-- Item Cost Element Details
xxen_util.meaning(cicd.rollup_source_type,'CST_SOURCE_TYPE',700) cost_source_type,
(select cce.cost_element from cst_cost_elements cce where cce.cost_element_id=nvl(cicd.cost_element_id,decode(cic.inventory_asset_flag,1,1))) cost_element,
nvl(br.resource_code,
(select
 br2.resource_code
 from
 bom_resources br2
 where
 br2.resource_id=mp.default_material_cost_id and
 br2.organization_id=mp.organization_id and
 br2.cost_element_id=1 and
 nvl(br2.allow_costs_flag,1)=1 and
 nvl(br2.disable_date,sysdate)>=sysdate and
 cic.inventory_asset_flag = 1 and
 cicd.rowid is null
)) sub_element,
nvl(cicd.usage_rate_or_amount,decode(cic.inventory_asset_flag,1,0))  usage_rate_or_amount,
xxen_util.meaning(cicd.basis_type,'CST_BASIS_SHORT',700) basis,
ca.activity,
cicd.activity_units,
cicd.item_units,
-- other enterable fields
xxen_util.display_flexfield_context(702,'CST_ITEM_COST_DETAILS',cicd.attribute_category) attribute_category,
xxen_util.display_flexfield_value(702,'CST_ITEM_COST_DETAILS',cicd.attribute_category,'ATTRIBUTE1',cicd.rowid,cicd.attribute1) item_cost_attribute1,
xxen_util.display_flexfield_value(702,'CST_ITEM_COST_DETAILS',cicd.attribute_category,'ATTRIBUTE2',cicd.rowid,cicd.attribute2) item_cost_attribute2,
xxen_util.display_flexfield_value(702,'CST_ITEM_COST_DETAILS',cicd.attribute_category,'ATTRIBUTE3',cicd.rowid,cicd.attribute3) item_cost_attribute3,
xxen_util.display_flexfield_value(702,'CST_ITEM_COST_DETAILS',cicd.attribute_category,'ATTRIBUTE4',cicd.rowid,cicd.attribute4) item_cost_attribute4,
xxen_util.display_flexfield_value(702,'CST_ITEM_COST_DETAILS',cicd.attribute_category,'ATTRIBUTE5',cicd.rowid,cicd.attribute5) item_cost_attribute5,
xxen_util.display_flexfield_value(702,'CST_ITEM_COST_DETAILS',cicd.attribute_category,'ATTRIBUTE6',cicd.rowid,cicd.attribute6) item_cost_attribute6,
xxen_util.display_flexfield_value(702,'CST_ITEM_COST_DETAILS',cicd.attribute_category,'ATTRIBUTE7',cicd.rowid,cicd.attribute7) item_cost_attribute7,
xxen_util.display_flexfield_value(702,'CST_ITEM_COST_DETAILS',cicd.attribute_category,'ATTRIBUTE8',cicd.rowid,cicd.attribute8) item_cost_attribute8,
xxen_util.display_flexfield_value(702,'CST_ITEM_COST_DETAILS',cicd.attribute_category,'ATTRIBUTE9',cicd.rowid,cicd.attribute9) item_cost_attribute9,
xxen_util.display_flexfield_value(702,'CST_ITEM_COST_DETAILS',cicd.attribute_category,'ATTRIBUTE10',cicd.rowid,cicd.attribute10) item_cost_attribute10,
xxen_util.display_flexfield_value(702,'CST_ITEM_COST_DETAILS',cicd.attribute_category,'ATTRIBUTE11',cicd.rowid,cicd.attribute11) item_cost_attribute11,
xxen_util.display_flexfield_value(702,'CST_ITEM_COST_DETAILS',cicd.attribute_category,'ATTRIBUTE12',cicd.rowid,cicd.attribute12) item_cost_attribute12,
xxen_util.display_flexfield_value(702,'CST_ITEM_COST_DETAILS',cicd.attribute_category,'ATTRIBUTE13',cicd.rowid,cicd.attribute13) item_cost_attribute13,
xxen_util.display_flexfield_value(702,'CST_ITEM_COST_DETAILS',cicd.attribute_category,'ATTRIBUTE14',cicd.rowid,cicd.attribute14) item_cost_attribute14,
xxen_util.display_flexfield_value(702,'CST_ITEM_COST_DETAILS',cicd.attribute_category,'ATTRIBUTE15',cicd.rowid,cicd.attribute15) item_cost_attribute15,
-- display only - calculated by Item Cost Import
cicd.basis_factor,
cicd.net_yield_or_shrinkage_factor,
cicd.resource_rate,
cicd.item_cost element_unit_cost,
-- Item Cost Summary Amounts
cic.material_cost item_material_cost,
cic.material_overhead_cost item_material_overhead_cost,
cic.resource_cost item_resource_cost,
cic.outside_processing_cost item_outside_processing_cost,
cic.overhead_cost item_overhead_cost,
cic.item_cost,
cic.unburdened_cost item_unburdened_cost,
cic.burden_cost item_burden_cost,
1 level_type,
1 rollup_source_type,
1 process_flag,
:p_upload_mode upload_mode,
:p_do_cost_rollup rollup_costs,
:p_rollup_range rollup_type,
:p_rollup_option rollup_option,
:p_rollup_inc_unimp_ecn_flag rollup_unimpl_ecos,
null upload_row
--
from
cst_cost_types cct_s,
cst_cost_types cct_t,
cst_item_costs cic,
cst_item_cost_details cicd,
cst_activities ca,
bom_resources br,
mtl_system_items_vl msiv,
mtl_parameters mp
where
1=1 and
:p_upload_mode=:p_upload_mode and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
--
cct_s.cost_type=:p_source_cost_type and
cct_t.cost_type=:p_target_cost_type and
--
cct_s.cost_type_id=cic.cost_type_id and
cic.cost_type_id=cicd.cost_type_id(+) and
cic.organization_id=cicd.organization_id(+) and
cic.inventory_item_id=cicd.inventory_item_id(+) and
ca.activity_id(+)=cicd.activity_id and
br.organization_id(+)=cicd.organization_id and
br.resource_id(+)=cicd.resource_id and
cic.organization_id=mp.organization_id and
cic.organization_id=msiv.organization_id and
cic.inventory_item_id=msiv.inventory_item_id and
(cicd.rollup_source_type=1 or cicd.rowid is null)

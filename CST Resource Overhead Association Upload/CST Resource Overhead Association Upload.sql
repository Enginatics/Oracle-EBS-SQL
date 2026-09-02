/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Resource Overhead Association Upload
-- Description: CST Resource Overhead Association Upload
========================================

This upload can be used to
- Upload new Resource Overhead Associations
- Download the current Resource Overhead Associations for a Cost Type and upload them to a different Target Cost Type
- Update the descriptive flexfield attributes of existing associations by re-uploading them in 'Remove and replace' mode
- Delete existing Resource Overhead Associations

Resource Overhead Associations link Resource or Outside Processing sub-elements to the Overhead or Material Overhead sub-elements they absorb. The associations are imported via the Oracle Cost Import Process.

NOTE:
You can only upload associations to cost types that are not flagged as frozen and are flagged as updateable.

NOTE:
The Cost Import Process cannot delete a Resource Overhead Association, so a row flagged for deletion is not sent to it. Set the Delete Association column to Yes and the association is removed directly when the row is processed, in the same way as the Overheads and Resources forms remove it.
Deletion is not allowed for frozen standard cost types or for cost types which do not allow updates.
Deleted associations are not covered by the Cost Rollup. Run a rollup separately if the removal should be reflected in item costs.

Optionally, the upload can perform a Cost Rollup after the associations have been imported. The Cost Rollup can be performed for
- Specific item - a cost rollup is done only for rolled up items whose cost details in the Target Cost Type use the associated resources
- All items - the 'Supply Chain Cost Rollup - Print Report' concurrent request is submitted to rollup all items within each organization associations are uploaded to

NOTE:
In 'All items' mode the Supply Chain Cost Rollup requests are submitted asynchronously and the upload does not wait for them.
In 'Specific item' mode, the items to roll up are derived from the existing cost details in the Target Cost Type. Items that have never been rolled up in the Target Cost Type are therefore not found, even if their routings use an associated resource - use 'All items' mode for those.

Parameters
==========
Target Cost Type (Required) - The Cost Type to which the Resource Overhead Associations are to be uploaded.

Mode (Required, Default: Remove and replace cost information) -
- Remove and replace cost information: an existing association for the same resource, overhead, and cost type is replaced
- Insert new Cost Information Only: uploading an association that already exists raises an error

Auto Populate Upload Columns (Default: Yes) -
Applies to downloaded associations only. If set to Yes, the downloaded records are flagged ready for upload even if no changes have been made. If left blank, records are only flagged for upload when the user amends them.

Source Cost Type - Optionally specify the Cost Type from which to download the current Resource Overhead Associations, to copy them to a different Target Cost Type. New associations can be entered as additional rows in the generated Excel.

Rollup Costs - set to Yes to do a cost rollup after the associations are imported
Rollup Type - All items or Specific item
Rollup Option - Single level rollup or Full cost rollup

Organization Code / Resource / Overhead - Optionally restrict the associations to be downloaded.

Notes on the Upload
===================
The upload supports the Resource Overhead Information descriptive flexfield. The attribute columns are named according to the descriptive flexfield segments setup.
-- Excel Examle Output: https://www.enginatics.com/example/cst-resource-overhead-association-upload/
-- Library Link: https://www.enginatics.com/reports/cst-resource-overhead-association-upload/
-- Run Report: https://demo.enginatics.com/

select
case when nvl2(:p_autopopulate_upload_status,'Y','N')='Y' then xxen_upload.action_meaning(xxen_upload.action_update) else null end action_,
case when nvl2(:p_autopopulate_upload_status,'Y','N')='Y' then xxen_upload.status_meaning(xxen_upload.status_new) else null end status_,
case when nvl2(:p_autopopulate_upload_status,'Y','N')='Y' then xxen_util.description('U_EXCEL_MSG_VALIDATION_PENDING','XXEN_REPORT_TRANSLATIONS',0) else null end message_,
to_number(null) request_id_,
null modified_columns_,
null row_id,
cct_t.cost_type target_cost_type,
mp.organization_code,
br_r.resource_code,
br_r.description resource_description,
br_o.resource_code overhead,
br_o.description overhead_description,
null delete_association,
xxen_util.display_flexfield_context(702,'CST_RESOURCE_OVERHEADS',cro.attribute_category) attribute_category,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_OVERHEADS',cro.attribute_category,'ATTRIBUTE1',cro.rowid,cro.attribute1) res_ovhd_attribute1,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_OVERHEADS',cro.attribute_category,'ATTRIBUTE2',cro.rowid,cro.attribute2) res_ovhd_attribute2,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_OVERHEADS',cro.attribute_category,'ATTRIBUTE3',cro.rowid,cro.attribute3) res_ovhd_attribute3,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_OVERHEADS',cro.attribute_category,'ATTRIBUTE4',cro.rowid,cro.attribute4) res_ovhd_attribute4,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_OVERHEADS',cro.attribute_category,'ATTRIBUTE5',cro.rowid,cro.attribute5) res_ovhd_attribute5,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_OVERHEADS',cro.attribute_category,'ATTRIBUTE6',cro.rowid,cro.attribute6) res_ovhd_attribute6,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_OVERHEADS',cro.attribute_category,'ATTRIBUTE7',cro.rowid,cro.attribute7) res_ovhd_attribute7,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_OVERHEADS',cro.attribute_category,'ATTRIBUTE8',cro.rowid,cro.attribute8) res_ovhd_attribute8,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_OVERHEADS',cro.attribute_category,'ATTRIBUTE9',cro.rowid,cro.attribute9) res_ovhd_attribute9,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_OVERHEADS',cro.attribute_category,'ATTRIBUTE10',cro.rowid,cro.attribute10) res_ovhd_attribute10,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_OVERHEADS',cro.attribute_category,'ATTRIBUTE11',cro.rowid,cro.attribute11) res_ovhd_attribute11,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_OVERHEADS',cro.attribute_category,'ATTRIBUTE12',cro.rowid,cro.attribute12) res_ovhd_attribute12,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_OVERHEADS',cro.attribute_category,'ATTRIBUTE13',cro.rowid,cro.attribute13) res_ovhd_attribute13,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_OVERHEADS',cro.attribute_category,'ATTRIBUTE14',cro.rowid,cro.attribute14) res_ovhd_attribute14,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_OVERHEADS',cro.attribute_category,'ATTRIBUTE15',cro.rowid,cro.attribute15) res_ovhd_attribute15,
1 process_flag,
3 import_cost_option,
:p_upload_mode upload_mode,
:p_do_cost_rollup rollup_costs,
:p_rollup_range rollup_type,
:p_rollup_option rollup_option,
:p_rollup_inc_unimp_ecn_flag rollup_unimpl_ecos,
null upload_row
from
cst_cost_types cct_s,
cst_cost_types cct_t,
mtl_parameters mp,
cst_resource_overheads cro,
bom_resources br_r,
bom_resources br_o
where
1=1 and
:p_upload_mode=:p_upload_mode and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.cost_organization_id=mp.organization_id and
nvl(mp.process_enabled_flag,'N')<>'Y' and
cct_s.cost_type=:p_source_cost_type and
cct_t.cost_type=:p_target_cost_type and
cro.cost_type_id=cct_s.cost_type_id and
cro.organization_id=mp.organization_id and
cro.resource_id=br_r.resource_id and
cro.overhead_id=br_o.resource_id
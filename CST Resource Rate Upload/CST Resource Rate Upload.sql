/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Resource Rate Upload
-- Description: CST Resource Rate Upload
========================

This upload can be used to
- Upload new Resource Rates
- Download the current Resource Rates for a Cost Type, update, and upload the amended rates
- Download the current Resource Rates from a Source Cost Type and upload them to a different Target Cost Type
- Delete existing Resource Rates

Resource Rates apply to rate based Resource and Outside Processing sub-elements (sub-elements whose charge basis is not currency based). The rates are imported via the Oracle Cost Import Process.

NOTE:
You can only upload rates to cost types that are not flagged as frozen and are flagged as updateable. This includes the rates cost types used by average costing organizations (e.g. AvgRates).

NOTE:
The Cost Import Process cannot delete a Resource Rate, so a row flagged for deletion is not sent to it. Set the Delete Resource Rate column to Yes and the rate is removed directly when the row is processed, in the same way as the Resources form removes it.
Deletion is not allowed for frozen standard cost types or for cost types which do not allow updates.
Deleted rates are not covered by the Cost Rollup. Run a rollup separately if the removal should be reflected in item costs.

Optionally, the upload can perform a Cost Rollup after the rates have been imported. The Cost Rollup can be performed for
- Specific item - a cost rollup is done only for rolled up items whose cost details in the Target Cost Type reference the uploaded resources
- All items - the 'Supply Chain Cost Rollup - Print Report' concurrent request is submitted to rollup all items within each organization rates are uploaded to

NOTE:
In 'All items' mode the Supply Chain Cost Rollup requests are submitted asynchronously and the upload does not wait for them.
In 'Specific item' mode, the items to roll up are derived from the existing cost details in the Target Cost Type. Items that have never been rolled up in the Target Cost Type are therefore not found, even if their routings use an uploaded resource - use 'All items' mode for those.

Parameters
==========
Target Cost Type (Required) - The Cost Type to which the Resource Rates are to be uploaded.

Mode (Required, Default: Remove and replace cost information) -
- Remove and replace cost information: an existing rate for the same resource is replaced
- Insert new Cost Information Only: uploading a rate for a resource that already has one raises an error

Auto Populate Upload Columns (Default: Yes) -
Applies to downloaded rates only. If set to Yes, the downloaded records are flagged ready for upload even if no changes have been made. If left blank, records are only flagged for upload when the user amends them.

Source Cost Type - Optionally specify the Cost Type from which to download the current Resource Rates, to amend them or to copy them to a different Target Cost Type.

Include Resources without a Rate - Set to Yes to also download rate eligible resources that do not yet have a rate in the Source Cost Type, with a blank rate ready to be entered. To rate new resources for a cost type, select that cost type as both Source and Target Cost Type.

Rollup Costs - set to Yes to do a cost rollup after the rates are imported
Rollup Type - All items or Specific item
Rollup Option - Single level rollup or Full cost rollup

Organization Code / Resource / Resource Like - Optionally restrict the resources to be downloaded.

Notes on the Upload
===================
The upload supports the Resource Cost Information descriptive flexfield. The attribute columns are named according to the descriptive flexfield segments setup.
-- Excel Examle Output: https://www.enginatics.com/example/cst-resource-rate-upload/
-- Library Link: https://www.enginatics.com/reports/cst-resource-rate-upload/
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
br.resource_code,
br.description resource_description,
br.unit_of_measure,
xxen_util.meaning(br.cost_element_id,'CST_COST_CODE_TYPE',700) cost_element,
crc.resource_rate,
null delete_resource_rate,
xxen_util.display_flexfield_context(702,'CST_RESOURCE_COSTS',crc.attribute_category) attribute_category,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_COSTS',crc.attribute_category,'ATTRIBUTE1',crc.rowid,crc.attribute1) rsc_rate_attribute1,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_COSTS',crc.attribute_category,'ATTRIBUTE2',crc.rowid,crc.attribute2) rsc_rate_attribute2,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_COSTS',crc.attribute_category,'ATTRIBUTE3',crc.rowid,crc.attribute3) rsc_rate_attribute3,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_COSTS',crc.attribute_category,'ATTRIBUTE4',crc.rowid,crc.attribute4) rsc_rate_attribute4,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_COSTS',crc.attribute_category,'ATTRIBUTE5',crc.rowid,crc.attribute5) rsc_rate_attribute5,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_COSTS',crc.attribute_category,'ATTRIBUTE6',crc.rowid,crc.attribute6) rsc_rate_attribute6,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_COSTS',crc.attribute_category,'ATTRIBUTE7',crc.rowid,crc.attribute7) rsc_rate_attribute7,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_COSTS',crc.attribute_category,'ATTRIBUTE8',crc.rowid,crc.attribute8) rsc_rate_attribute8,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_COSTS',crc.attribute_category,'ATTRIBUTE9',crc.rowid,crc.attribute9) rsc_rate_attribute9,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_COSTS',crc.attribute_category,'ATTRIBUTE10',crc.rowid,crc.attribute10) rsc_rate_attribute10,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_COSTS',crc.attribute_category,'ATTRIBUTE11',crc.rowid,crc.attribute11) rsc_rate_attribute11,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_COSTS',crc.attribute_category,'ATTRIBUTE12',crc.rowid,crc.attribute12) rsc_rate_attribute12,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_COSTS',crc.attribute_category,'ATTRIBUTE13',crc.rowid,crc.attribute13) rsc_rate_attribute13,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_COSTS',crc.attribute_category,'ATTRIBUTE14',crc.rowid,crc.attribute14) rsc_rate_attribute14,
xxen_util.display_flexfield_value(702,'CST_RESOURCE_COSTS',crc.attribute_category,'ATTRIBUTE15',crc.rowid,crc.attribute15) rsc_rate_attribute15,
1 process_flag,
2 import_cost_option,
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
bom_resources br,
cst_resource_costs crc
where
1=1 and
:p_upload_mode=:p_upload_mode and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.cost_organization_id=mp.organization_id and
nvl(mp.process_enabled_flag,'N')<>'Y' and
cct_s.cost_type=:p_source_cost_type and
cct_t.cost_type=:p_target_cost_type and
br.organization_id=mp.organization_id and
br.cost_element_id in (3,4) and
br.functional_currency_flag<>1 and
nvl(br.allow_costs_flag,1)=1 and
nvl(br.disable_date,sysdate)>=sysdate and
cct_s.cost_type_id=crc.cost_type_id(+) and
br.organization_id=crc.organization_id(+) and
br.resource_id=crc.resource_id(+) and
(crc.rowid is not null or nvl(:p_include_no_rate_resources,'N')='Y')
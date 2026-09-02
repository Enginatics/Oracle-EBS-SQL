/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Department Overhead Rate Upload
-- Description: CST Department Overhead Rate Upload
===================================

This upload can be used to
- Upload new Department Overhead Rates
- Download the current Department Overhead Rates for a Cost Type, update, and upload the amended rates
- Download the current Department Overhead Rates from a Source Cost Type and upload them to a different Target Cost Type
- Delete existing Department Overhead Rates

Department Overhead Rates associate Overhead sub-elements with Departments and specify the rate or amount charged, per basis (Item, Lot, Resource Units, or Resource Value). The rates are imported via the Oracle Cost Import Process.

NOTE:
You can only upload rates to cost types that are not flagged as frozen and are flagged as updateable.

NOTE:
The Cost Import Process cannot delete a Department Overhead Rate, so a row flagged for deletion is not sent to it. Set the Delete Overhead Rate column to Yes and the rate is removed directly when the row is processed, in the same way as the Overheads form removes it.
Deletion is not allowed for frozen standard cost types or for cost types which do not allow updates.
Deleted rates are not covered by the Cost Rollup. Run a rollup separately if the removal should be reflected in item costs.

NOTE:
The Cost Import Process accepts only one row per Department, Overhead, and Cost Type combination in a single run, even when the rows carry different basis types. In 'Remove and replace' mode all existing basis rows of an uploaded combination are replaced by the uploaded row.

Optionally, the upload can perform a Cost Rollup after the rates have been imported. The Cost Rollup can be performed for
- Specific item - a cost rollup is done only for rolled up items whose cost details in the Target Cost Type reference the uploaded department overheads
- All items - the 'Supply Chain Cost Rollup - Print Report' concurrent request is submitted to rollup all items within each organization rates are uploaded to

NOTE:
In 'All items' mode the Supply Chain Cost Rollup requests are submitted asynchronously and the upload does not wait for them.
In 'Specific item' mode, the items to roll up are derived from the existing cost details in the Target Cost Type. Items that have never been rolled up in the Target Cost Type are therefore not found, even if their routings use a department carrying an uploaded overhead rate - use 'All items' mode for those.

Parameters
==========
Target Cost Type (Required) - The Cost Type to which the Department Overhead Rates are to be uploaded.

Mode (Required, Default: Remove and replace cost information) -
- Remove and replace cost information: an existing rate for the same department, overhead, and cost type combination is replaced
- Insert new Cost Information Only: uploading a rate for a combination that already has one raises an error

Auto Populate Upload Columns (Default: Yes) -
Applies to downloaded rates only. If set to Yes, the downloaded records are flagged ready for upload even if no changes have been made. If left blank, records are only flagged for upload when the user amends them.

Source Cost Type - Optionally specify the Cost Type from which to download the current Department Overhead Rates, to amend them or to copy them to a different Target Cost Type. New rates can be entered as additional rows in the generated Excel.

Rollup Costs - set to Yes to do a cost rollup after the rates are imported
Rollup Type - All items or Specific item
Rollup Option - Single level rollup or Full cost rollup

Organization Code / Department / Overhead - Optionally restrict the rates to be downloaded.

Notes on the Upload
===================
The upload supports the Department Overhead Information descriptive flexfield. The attribute columns are named according to the descriptive flexfield segments setup.
-- Excel Examle Output: https://www.enginatics.com/example/cst-department-overhead-rate-upload/
-- Library Link: https://www.enginatics.com/reports/cst-department-overhead-rate-upload/
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
bd.department_code department,
bd.description department_description,
br.resource_code overhead,
br.description overhead_description,
ca.activity,
xxen_util.meaning(cdo.basis_type,'CST_BASIS',700) basis,
cdo.rate_or_amount,
null delete_overhead_rate,
xxen_util.display_flexfield_context(702,'CST_DEPARTMENT_OVERHEADS',cdo.attribute_category) attribute_category,
xxen_util.display_flexfield_value(702,'CST_DEPARTMENT_OVERHEADS',cdo.attribute_category,'ATTRIBUTE1',cdo.rowid,cdo.attribute1) dept_ovhd_attribute1,
xxen_util.display_flexfield_value(702,'CST_DEPARTMENT_OVERHEADS',cdo.attribute_category,'ATTRIBUTE2',cdo.rowid,cdo.attribute2) dept_ovhd_attribute2,
xxen_util.display_flexfield_value(702,'CST_DEPARTMENT_OVERHEADS',cdo.attribute_category,'ATTRIBUTE3',cdo.rowid,cdo.attribute3) dept_ovhd_attribute3,
xxen_util.display_flexfield_value(702,'CST_DEPARTMENT_OVERHEADS',cdo.attribute_category,'ATTRIBUTE4',cdo.rowid,cdo.attribute4) dept_ovhd_attribute4,
xxen_util.display_flexfield_value(702,'CST_DEPARTMENT_OVERHEADS',cdo.attribute_category,'ATTRIBUTE5',cdo.rowid,cdo.attribute5) dept_ovhd_attribute5,
xxen_util.display_flexfield_value(702,'CST_DEPARTMENT_OVERHEADS',cdo.attribute_category,'ATTRIBUTE6',cdo.rowid,cdo.attribute6) dept_ovhd_attribute6,
xxen_util.display_flexfield_value(702,'CST_DEPARTMENT_OVERHEADS',cdo.attribute_category,'ATTRIBUTE7',cdo.rowid,cdo.attribute7) dept_ovhd_attribute7,
xxen_util.display_flexfield_value(702,'CST_DEPARTMENT_OVERHEADS',cdo.attribute_category,'ATTRIBUTE8',cdo.rowid,cdo.attribute8) dept_ovhd_attribute8,
xxen_util.display_flexfield_value(702,'CST_DEPARTMENT_OVERHEADS',cdo.attribute_category,'ATTRIBUTE9',cdo.rowid,cdo.attribute9) dept_ovhd_attribute9,
xxen_util.display_flexfield_value(702,'CST_DEPARTMENT_OVERHEADS',cdo.attribute_category,'ATTRIBUTE10',cdo.rowid,cdo.attribute10) dept_ovhd_attribute10,
xxen_util.display_flexfield_value(702,'CST_DEPARTMENT_OVERHEADS',cdo.attribute_category,'ATTRIBUTE11',cdo.rowid,cdo.attribute11) dept_ovhd_attribute11,
xxen_util.display_flexfield_value(702,'CST_DEPARTMENT_OVERHEADS',cdo.attribute_category,'ATTRIBUTE12',cdo.rowid,cdo.attribute12) dept_ovhd_attribute12,
xxen_util.display_flexfield_value(702,'CST_DEPARTMENT_OVERHEADS',cdo.attribute_category,'ATTRIBUTE13',cdo.rowid,cdo.attribute13) dept_ovhd_attribute13,
xxen_util.display_flexfield_value(702,'CST_DEPARTMENT_OVERHEADS',cdo.attribute_category,'ATTRIBUTE14',cdo.rowid,cdo.attribute14) dept_ovhd_attribute14,
xxen_util.display_flexfield_value(702,'CST_DEPARTMENT_OVERHEADS',cdo.attribute_category,'ATTRIBUTE15',cdo.rowid,cdo.attribute15) dept_ovhd_attribute15,
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
bom_departments bd,
bom_resources br,
cst_department_overheads cdo,
cst_activities ca
where
1=1 and
:p_upload_mode=:p_upload_mode and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.cost_organization_id=mp.organization_id and
nvl(mp.process_enabled_flag,'N')<>'Y' and
cct_s.cost_type=:p_source_cost_type and
cct_t.cost_type=:p_target_cost_type and
bd.organization_id=mp.organization_id and
nvl(bd.disable_date,sysdate)>=sysdate and
br.organization_id=mp.organization_id and
br.cost_element_id=5 and
nvl(br.allow_costs_flag,1)=1 and
nvl(br.disable_date,sysdate)>=sysdate and
cct_s.cost_type_id=cdo.cost_type_id and
mp.organization_id=cdo.organization_id and
bd.department_id=cdo.department_id and
br.resource_id=cdo.overhead_id and
cdo.activity_id=ca.activity_id(+)
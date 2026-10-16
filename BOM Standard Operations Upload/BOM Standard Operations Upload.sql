/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: BOM Standard Operations Upload
-- Description: Report: BOM Standard Operations Upload
-- This upload can be used to create and/or update BOM Standard Operations.
-- Standard operations are reusable operation templates that routings can reference. The upload covers:
-- - Standard operation header (code, type, line, department, attributes, EAM and OSFM extensions)
-- - Primary resource assignments to the standard operation
-- - Substitute (alternate) resource assignments
-- - Descriptive flexfield attributes on the header and primary resources
-- Each Excel row represents one resource of a standard operation. Header columns repeat across resource rows of the same standard operation. To upload a standard operation with no resources, leave the Resource Code blank. To upload a substitute resource, set Substitute Resource to Yes and supply Substitute Group + Replacement Group.
-- Standard operations are one of four types: discrete Standard (not tied to a production line), or Flow Event, Flow Process or Flow Line (each tied to a line). Many columns apply, default or are editable differently by operation type - for example Value Added and Critical to Quality can only be set to No on Flow Events, Count Point, Auto-charge and Backflush can only be set to No on discrete Standard operations, and Display Sequence applies only to Flow Process and Flow Line operations. Each affected column carries a cell comment describing its behaviour, and the supplied templates already show only the columns relevant to each type.
-- Five templates are provided, one per operation type and scenario - pick the one matching the operation you are creating. Each shows only the columns relevant to that type, and the flow templates pre-set the Operation Type:
-- - Discrete Standard Operation: a standard operation not tied to a production line.
-- - Discrete Standard Operation - Shop Floor Management: the same, for OSFM/WSM-enabled organizations, additionally showing the Shop Floor Management fields (Operation Yield Enabled, Yield, Lowest Acceptable Yield, the Queue/Run/To Move Mandatory flags, Track Multiple Resource Usage Dates and the Show flags).
-- - Flow Standard Events: a Flow Event operation tied to a production line.
-- - Flow Standard Line Operations: a Flow Line operation tied to a production line.
-- - Flow Standard Processes: a Flow Process operation tied to a production line.
-- The download parameters control which operations are returned: Organization Code (defaults to your current manufacturing organization), Manufacturing Mode (Flow or Standard), Operation Type, Operation Code, Operation Code like (pattern search), Department and Contains Resource. Contains Resource returns each matching operation in full - all of its resource and substitute rows - so a resource is shown in the context of its whole operation rather than as an isolated line.
-- Deletion is supported at two levels via the Delete Std Op and Delete Resource columns. Header delete cascades to resources, substitute resources, and OSFM child rows (bonus codes, scrap codes, responsibility exclusions). Header delete is blocked if the standard operation is referenced by an active routing operation or by a setup transition.
-- Excel Example Output: https://www.enginatics.com/example/bom-standard-operations-upload/
-- Library Link: https://www.enginatics.com/reports/bom-standard-operations-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
null upload_mode,
x.*,
null upload_row
from
(
select
mp.organization_code,
xxen_util.meaning(nvl(bso.operation_type,1),'BOM_OPERATION_TYPE',700) operation_type,
wl.line_code line,
bso.operation_code,
bso.operation_description,
bd.department_code department,
case when bso.line_id is not null and nvl(bso.operation_type,1) in (2,3) then bso.sequence_num end display_sequence,
bso.minimum_transfer_quantity min_transfer_qty,
xxen_util.meaning(bso.wms_task_type,'WMS_TASK_TYPES',700) task_type,
bso.default_subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where milk.organization_id=bso.organization_id and milk.inventory_location_id=bso.default_locator_id) default_locator,
xxen_util.yes(case when bso.option_dependent_flag=1 then 'Y' end) option_dependent,
xxen_util.yes(bso.value_added) value_added,
xxen_util.yes(bso.critical_to_quality) critical_to_quality,
xxen_util.yes(case when bso.count_point_type in (1) then 'Y' end) count_point,
xxen_util.yes(case when bso.count_point_type in (1,3) then 'Y' end) autocharge,
xxen_util.yes(case when bso.backflush_flag=1 then 'Y' end) backflush,
xxen_util.meaning(bso.shutdown_type,'BOM_EAM_SHUTDOWN_TYPE',700) shutdown_type,
bso.yield,
xxen_util.yes(case when bso.operation_yield_enabled=1 then 'Y' end) operation_yield_enabled,
xxen_util.yes(case when bso.check_skill=1 then 'Y' end) check_skill,
bso.lowest_acceptable_yield,
xxen_util.yes(case when bso.use_org_settings=1 then 'Y' end) use_org_settings,
xxen_util.yes(case when bso.queue_mandatory_flag=1 then 'Y' end) queue_mandatory,
xxen_util.yes(case when bso.run_mandatory_flag=1 then 'Y' end) run_mandatory,
xxen_util.yes(case when bso.to_move_mandatory_flag=1 then 'Y' end) to_move_mandatory,
xxen_util.yes(case when bso.show_next_op_by_default=1 then 'Y' end) default_for_move_to_next_op,
xxen_util.yes(case when bso.show_scrap_code=1 then 'Y' end) show_scrap_codes,
xxen_util.yes(case when bso.show_lot_attrib=1 then 'Y' end) show_lot_attrib,
xxen_util.yes(case when bso.track_multiple_res_usage_dates=1 then 'Y' end) track_multi_res_dates,
xxen_util.display_flexfield_context(702,'OPERATIONS',bso.attribute_category) op_attribute_category,
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE1',null,bso.attribute1) op_attribute1,
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE2',null,bso.attribute2) op_attribute2,
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE3',null,bso.attribute3) op_attribute3,
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE4',null,bso.attribute4) op_attribute4,
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE5',null,bso.attribute5) op_attribute5,
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE6',null,bso.attribute6) op_attribute6,
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE7',null,bso.attribute7) op_attribute7,
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE8',null,bso.attribute8) op_attribute8,
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE9',null,bso.attribute9) op_attribute9,
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE10',null,bso.attribute10) op_attribute10,
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE11',null,bso.attribute11) op_attribute11,
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE12',null,bso.attribute12) op_attribute12,
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE13',null,bso.attribute13) op_attribute13,
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE14',null,bso.attribute14) op_attribute14,
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE15',null,bso.attribute15) op_attribute15,
null substitute_resource,
bsor.resource_seq_num resource_seq,
bsor.substitute_group_num substitute_group,
to_number(null) replacement_group,
br.resource_code,
xxen_util.meaning(bsor.basis_type,'BOM_BASIS_TYPE',700) basis,
bsor.usage_rate_or_amount usage_rate,
bsor.usage_rate_or_amount_inverse inverse_rate,
bsor.schedule_seq_num schedule_seq,
xxen_util.meaning(bsor.schedule_flag,'BOM_RESOURCE_SCHEDULE_TYPE',700) schedule,
bsor.assigned_units,
xxen_util.yes(case when bsor.principle_flag=1 then 'Y' end) principal,
cavv.activity,
xxen_util.yes(case when bsor.standard_rate_flag=1 then 'Y' end) standard_rate,
xxen_util.meaning(bsor.autocharge_type,'BOM_AUTOCHARGE_TYPE',700) charge_type,
xxen_util.display_flexfield_context(702,'OPERATION_RESOURCES',bsor.attribute_category) rsc_attribute_category,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE1',null,bsor.attribute1) rsc_attribute1,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE2',null,bsor.attribute2) rsc_attribute2,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE3',null,bsor.attribute3) rsc_attribute3,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE4',null,bsor.attribute4) rsc_attribute4,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE5',null,bsor.attribute5) rsc_attribute5,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE6',null,bsor.attribute6) rsc_attribute6,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE7',null,bsor.attribute7) rsc_attribute7,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE8',null,bsor.attribute8) rsc_attribute8,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE9',null,bsor.attribute9) rsc_attribute9,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE10',null,bsor.attribute10) rsc_attribute10,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE11',null,bsor.attribute11) rsc_attribute11,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE12',null,bsor.attribute12) rsc_attribute12,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE13',null,bsor.attribute13) rsc_attribute13,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE14',null,bsor.attribute14) rsc_attribute14,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE15',null,bsor.attribute15) rsc_attribute15,
null delete_std_op,
null delete_resource,
bso.standard_operation_id,
rowidtochar(bso.rowid) standard_operation_rowid,
rowidtochar(bsor.rowid) std_op_resource_rowid,
null std_op_sub_resource_rowid
from
mtl_parameters mp,
bom_standard_operations bso,
bom_departments bd,
wip_lines wl,
bom_std_op_resources bsor,
bom_resources br,
cst_activities_val_v cavv
where
mp.organization_id=bso.organization_id and
mp.organization_code=:p_organization_code and
bso.department_id=bd.department_id and
bso.line_id=wl.line_id(+) and
bso.standard_operation_id=bsor.standard_operation_id(+) and
bsor.resource_id=br.resource_id(+) and
bsor.activity_id=cavv.activity_id(+) and
nvl(cavv.organization_id(+),bso.organization_id)=bso.organization_id and
1=1
union all
select
mp.organization_code,
xxen_util.meaning(nvl(bso.operation_type,1),'BOM_OPERATION_TYPE',700) operation_type,
wl.line_code line,
bso.operation_code,
bso.operation_description,
bd.department_code department,
case when bso.line_id is not null and nvl(bso.operation_type,1) in (2,3) then bso.sequence_num end,
bso.minimum_transfer_quantity,
xxen_util.meaning(bso.wms_task_type,'WMS_TASK_TYPES',700),
bso.default_subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where milk.organization_id=bso.organization_id and milk.inventory_location_id=bso.default_locator_id),
xxen_util.yes(case when bso.option_dependent_flag=1 then 'Y' end),
xxen_util.yes(bso.value_added),
xxen_util.yes(bso.critical_to_quality),
xxen_util.yes(case when bso.count_point_type in (1) then 'Y' end),
xxen_util.yes(case when bso.count_point_type in (1,3) then 'Y' end),
xxen_util.yes(case when bso.backflush_flag=1 then 'Y' end),
xxen_util.meaning(bso.shutdown_type,'BOM_EAM_SHUTDOWN_TYPE',700),
bso.yield,
xxen_util.yes(case when bso.operation_yield_enabled=1 then 'Y' end),
xxen_util.yes(case when bso.check_skill=1 then 'Y' end),
bso.lowest_acceptable_yield,
xxen_util.yes(case when bso.use_org_settings=1 then 'Y' end),
xxen_util.yes(case when bso.queue_mandatory_flag=1 then 'Y' end),
xxen_util.yes(case when bso.run_mandatory_flag=1 then 'Y' end),
xxen_util.yes(case when bso.to_move_mandatory_flag=1 then 'Y' end),
xxen_util.yes(case when bso.show_next_op_by_default=1 then 'Y' end),
xxen_util.yes(case when bso.show_scrap_code=1 then 'Y' end),
xxen_util.yes(case when bso.show_lot_attrib=1 then 'Y' end),
xxen_util.yes(case when bso.track_multiple_res_usage_dates=1 then 'Y' end),
xxen_util.display_flexfield_context(702,'OPERATIONS',bso.attribute_category),
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE1',null,bso.attribute1),
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE2',null,bso.attribute2),
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE3',null,bso.attribute3),
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE4',null,bso.attribute4),
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE5',null,bso.attribute5),
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE6',null,bso.attribute6),
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE7',null,bso.attribute7),
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE8',null,bso.attribute8),
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE9',null,bso.attribute9),
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE10',null,bso.attribute10),
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE11',null,bso.attribute11),
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE12',null,bso.attribute12),
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE13',null,bso.attribute13),
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE14',null,bso.attribute14),
xxen_util.display_flexfield_value(702,'OPERATIONS',bso.attribute_category,'ATTRIBUTE15',null,bso.attribute15),
xxen_util.meaning('Y','YES_NO',0) substitute_resource,
bssor.resource_id resource_seq,
bssor.substitute_group_num substitute_group,
bssor.replacement_group_num replacement_group,
br.resource_code,
xxen_util.meaning(bssor.basis_type,'BOM_BASIS_TYPE',700),
bssor.usage_rate_or_amount,
bssor.usage_rate_or_amount_inverse,
bssor.schedule_seq_num,
xxen_util.meaning(bssor.schedule_flag,'BOM_RESOURCE_SCHEDULE_TYPE',700),
bssor.assigned_units,
null principal,
cavv.activity,
xxen_util.yes(case when bssor.standard_rate_flag=1 then 'Y' end),
xxen_util.meaning(bssor.autocharge_type,'BOM_AUTOCHARGE_TYPE',700),
null rsc_attribute_category,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
null delete_std_op,
null delete_resource,
bso.standard_operation_id,
rowidtochar(bso.rowid) standard_operation_rowid,
null std_op_resource_rowid,
rowidtochar(bssor.rowid) std_op_sub_resource_rowid
from
mtl_parameters mp,
bom_standard_operations bso,
bom_departments bd,
wip_lines wl,
bom_std_sub_op_resources bssor,
bom_resources br,
cst_activities_val_v cavv
where
mp.organization_id=bso.organization_id and
mp.organization_code=:p_organization_code and
bso.department_id=bd.department_id and
bso.line_id=wl.line_id(+) and
bso.standard_operation_id=bssor.standard_operation_id and
bssor.resource_id=br.resource_id and
bssor.activity_id=cavv.activity_id(+) and
nvl(cavv.organization_id(+),bso.organization_id)=bso.organization_id and
1=1
) x

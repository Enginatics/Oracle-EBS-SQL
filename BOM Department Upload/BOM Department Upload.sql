/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: BOM Department Upload
-- Description: Creates and updates departments with their resources and resource shifts - the Departments form (Bills of Material > Routings > Departments).
-- Each row holds one department, optionally one of its resources and one shift of that resource. The department and resource columns repeat on every row, and a change in any of these rows is applied. Departments cannot be deleted; enter an Inactive On date instead.
-- A resource with an Owning Department is borrowed from that department: its availability, units, Check CTP, ATP rule, utilization and efficiency are copied from the owning department's resource, which must have Share set to Yes. Changing Available 24 Hours of a shared resource updates the departments borrowing it, as the form does.
-- A resource that is not available 24 hours needs at least one shift. Deleting its last shift makes it available 24 hours. To remove a resource from a department, delete its shifts first, or enter Yes in Delete Shift and Delete Resource on the same row.
-- Utilization % and Efficiency % are entered as percentages. Cost Category is available in eAM organizations only, Project Expenditure Org in organizations with project cost collection, and the scrap accounts in organizations with network manufacturing (WSM).
-- Excel Example Output: https://www.enginatics.com/example/bom-department-upload/
-- Library Link: https://www.enginatics.com/reports/bom-department-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
bd.department_id,
mp.organization_code,
bd.department_code department,
bd.description,
xxen_util.meaning(bd.maint_cost_category,'BOM_EAM_COST_CATEGORY',700) cost_category,
bd.department_class_code class,
bdc.description class_description,
hl.location_code location,
hl.description location_description,
haouv.name project_expenditure_org,
bd.disable_date inactive_on,
gcck_s.concatenated_segments scrap_account,
gcck_e.concatenated_segments estimated_absorption_account,
xxen_util.display_flexfield_context(702,'BOM_DEPARTMENTS',bd.attribute_category) dept_attribute_category,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENTS',bd.attribute_category,'ATTRIBUTE1',bd.rowid,bd.attribute1) dept_attribute1,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENTS',bd.attribute_category,'ATTRIBUTE2',bd.rowid,bd.attribute2) dept_attribute2,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENTS',bd.attribute_category,'ATTRIBUTE3',bd.rowid,bd.attribute3) dept_attribute3,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENTS',bd.attribute_category,'ATTRIBUTE4',bd.rowid,bd.attribute4) dept_attribute4,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENTS',bd.attribute_category,'ATTRIBUTE5',bd.rowid,bd.attribute5) dept_attribute5,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENTS',bd.attribute_category,'ATTRIBUTE6',bd.rowid,bd.attribute6) dept_attribute6,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENTS',bd.attribute_category,'ATTRIBUTE7',bd.rowid,bd.attribute7) dept_attribute7,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENTS',bd.attribute_category,'ATTRIBUTE8',bd.rowid,bd.attribute8) dept_attribute8,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENTS',bd.attribute_category,'ATTRIBUTE9',bd.rowid,bd.attribute9) dept_attribute9,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENTS',bd.attribute_category,'ATTRIBUTE10',bd.rowid,bd.attribute10) dept_attribute10,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENTS',bd.attribute_category,'ATTRIBUTE11',bd.rowid,bd.attribute11) dept_attribute11,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENTS',bd.attribute_category,'ATTRIBUTE12',bd.rowid,bd.attribute12) dept_attribute12,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENTS',bd.attribute_category,'ATTRIBUTE13',bd.rowid,bd.attribute13) dept_attribute13,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENTS',bd.attribute_category,'ATTRIBUTE14',bd.rowid,bd.attribute14) dept_attribute14,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENTS',bd.attribute_category,'ATTRIBUTE15',bd.rowid,bd.attribute15) dept_attribute15,
br.resource_code,
br.description resource_description,
bd_own.department_code owning_department,
decode(bdr.available_24_hours_flag,1,xxen_util.meaning('1','SYS_YES_NO',700)) available_24_hours,
decode(bdr.share_capacity_flag,1,xxen_util.meaning('1','SYS_YES_NO',700)) share_capacity,
br.unit_of_measure uom,
bdr.capacity_units units,
decode(bdr.ctp_flag,1,xxen_util.meaning('1','SYS_YES_NO',700)) check_ctp,
xxen_util.meaning(bdr.resource_group_name,'CRP_RESOURCE_GROUPS',3) resource_group,
decode(bdr.schedule_to_instance,1,xxen_util.meaning('1','SYS_YES_NO',700)) schedule_by_instance,
bdr.exception_set_name exception_set,
mar.rule_name atp_rule,
bdr.utilization*100 utilization_percent,
bdr.efficiency*100 efficiency_percent,
bdr.sequencing_window sequencing_window_days,
null delete_resource,
xxen_util.display_flexfield_context(702,'BOM_DEPARTMENT_RESOURCES',bdr.attribute_category) res_attribute_category,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENT_RESOURCES',bdr.attribute_category,'ATTRIBUTE1',bdr.rowid,bdr.attribute1) res_attribute1,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENT_RESOURCES',bdr.attribute_category,'ATTRIBUTE2',bdr.rowid,bdr.attribute2) res_attribute2,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENT_RESOURCES',bdr.attribute_category,'ATTRIBUTE3',bdr.rowid,bdr.attribute3) res_attribute3,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENT_RESOURCES',bdr.attribute_category,'ATTRIBUTE4',bdr.rowid,bdr.attribute4) res_attribute4,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENT_RESOURCES',bdr.attribute_category,'ATTRIBUTE5',bdr.rowid,bdr.attribute5) res_attribute5,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENT_RESOURCES',bdr.attribute_category,'ATTRIBUTE6',bdr.rowid,bdr.attribute6) res_attribute6,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENT_RESOURCES',bdr.attribute_category,'ATTRIBUTE7',bdr.rowid,bdr.attribute7) res_attribute7,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENT_RESOURCES',bdr.attribute_category,'ATTRIBUTE8',bdr.rowid,bdr.attribute8) res_attribute8,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENT_RESOURCES',bdr.attribute_category,'ATTRIBUTE9',bdr.rowid,bdr.attribute9) res_attribute9,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENT_RESOURCES',bdr.attribute_category,'ATTRIBUTE10',bdr.rowid,bdr.attribute10) res_attribute10,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENT_RESOURCES',bdr.attribute_category,'ATTRIBUTE11',bdr.rowid,bdr.attribute11) res_attribute11,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENT_RESOURCES',bdr.attribute_category,'ATTRIBUTE12',bdr.rowid,bdr.attribute12) res_attribute12,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENT_RESOURCES',bdr.attribute_category,'ATTRIBUTE13',bdr.rowid,bdr.attribute13) res_attribute13,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENT_RESOURCES',bdr.attribute_category,'ATTRIBUTE14',bdr.rowid,bdr.attribute14) res_attribute14,
xxen_util.display_flexfield_value(702,'BOM_DEPARTMENT_RESOURCES',bdr.attribute_category,'ATTRIBUTE15',bdr.rowid,bdr.attribute15) res_attribute15,
to_char(brs.shift_num) shift_num,
(select bcs.description from bom_calendar_shifts bcs where mp.calendar_code=bcs.calendar_code and brs.shift_num=bcs.shift_num) shift_description,
brs.capacity_units shift_units,
null delete_shift,
xxen_util.display_flexfield_context(702,'BOM_RESOURCE_SHIFTS',brs.attribute_category) shift_attribute_category,
xxen_util.display_flexfield_value(702,'BOM_RESOURCE_SHIFTS',brs.attribute_category,'ATTRIBUTE1',brs.rowid,brs.attribute1) shift_attribute1,
xxen_util.display_flexfield_value(702,'BOM_RESOURCE_SHIFTS',brs.attribute_category,'ATTRIBUTE2',brs.rowid,brs.attribute2) shift_attribute2,
xxen_util.display_flexfield_value(702,'BOM_RESOURCE_SHIFTS',brs.attribute_category,'ATTRIBUTE3',brs.rowid,brs.attribute3) shift_attribute3,
xxen_util.display_flexfield_value(702,'BOM_RESOURCE_SHIFTS',brs.attribute_category,'ATTRIBUTE4',brs.rowid,brs.attribute4) shift_attribute4,
xxen_util.display_flexfield_value(702,'BOM_RESOURCE_SHIFTS',brs.attribute_category,'ATTRIBUTE5',brs.rowid,brs.attribute5) shift_attribute5,
xxen_util.display_flexfield_value(702,'BOM_RESOURCE_SHIFTS',brs.attribute_category,'ATTRIBUTE6',brs.rowid,brs.attribute6) shift_attribute6,
xxen_util.display_flexfield_value(702,'BOM_RESOURCE_SHIFTS',brs.attribute_category,'ATTRIBUTE7',brs.rowid,brs.attribute7) shift_attribute7,
xxen_util.display_flexfield_value(702,'BOM_RESOURCE_SHIFTS',brs.attribute_category,'ATTRIBUTE8',brs.rowid,brs.attribute8) shift_attribute8,
xxen_util.display_flexfield_value(702,'BOM_RESOURCE_SHIFTS',brs.attribute_category,'ATTRIBUTE9',brs.rowid,brs.attribute9) shift_attribute9,
xxen_util.display_flexfield_value(702,'BOM_RESOURCE_SHIFTS',brs.attribute_category,'ATTRIBUTE10',brs.rowid,brs.attribute10) shift_attribute10,
xxen_util.display_flexfield_value(702,'BOM_RESOURCE_SHIFTS',brs.attribute_category,'ATTRIBUTE11',brs.rowid,brs.attribute11) shift_attribute11,
xxen_util.display_flexfield_value(702,'BOM_RESOURCE_SHIFTS',brs.attribute_category,'ATTRIBUTE12',brs.rowid,brs.attribute12) shift_attribute12,
xxen_util.display_flexfield_value(702,'BOM_RESOURCE_SHIFTS',brs.attribute_category,'ATTRIBUTE13',brs.rowid,brs.attribute13) shift_attribute13,
xxen_util.display_flexfield_value(702,'BOM_RESOURCE_SHIFTS',brs.attribute_category,'ATTRIBUTE14',brs.rowid,brs.attribute14) shift_attribute14,
xxen_util.display_flexfield_value(702,'BOM_RESOURCE_SHIFTS',brs.attribute_category,'ATTRIBUTE15',brs.rowid,brs.attribute15) shift_attribute15,
to_number(null) upload_row
from
mtl_parameters mp,
bom_departments bd,
bom_department_classes bdc,
hr_locations_all hl,
hr_all_organization_units_vl haouv,
gl_code_combinations_kfv gcck_s,
gl_code_combinations_kfv gcck_e,
bom_department_resources bdr,
bom_resources br,
bom_departments bd_own,
mtl_atp_rules mar,
bom_resource_shifts brs
where
1=1 and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=bd.organization_id and
bd.department_class_code=bdc.department_class_code(+) and
bd.organization_id=bdc.organization_id(+) and
bd.location_id=hl.location_id(+) and
bd.pa_expenditure_org_id=haouv.organization_id(+) and
bd.scrap_account=gcck_s.code_combination_id(+) and
bd.est_absorption_account=gcck_e.code_combination_id(+) and
bd.department_id=bdr.department_id(+) and
bdr.resource_id=br.resource_id(+) and
bdr.share_from_dept_id=bd_own.department_id(+) and
bdr.atp_rule_id=mar.rule_id(+) and
bdr.department_id=brs.department_id(+) and
bdr.resource_id=brs.resource_id(+)

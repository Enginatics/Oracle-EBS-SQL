/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: WIP Job Upload
-- Description: Upload to create and update WIP Discrete Jobs (Standard and Non-Standard) including operations, resources, and material requirements (components). Multiple inventory organizations can be combined in one upload file; the upload submits a separate WIP Mass Load run per organization.
-- Job headers support all standard fields including assembly, class code, status, quantities, dates, scheduling, BOM/routing references (non-standard jobs), completion subinventory/locator, schedule group, line, project/task, and descriptive flexfield attributes.
-- Operations, resources, and material requirements (components) can be added on new and existing jobs and modified on existing jobs. A single upload row can carry header, operation/resource, and component fields simultaneously, so compact entry does not require separate row types.
-- Explode Bom and Routing. By default, Bom and Routing are automatically exploded only for new jobs (create) where the job does not have detail entries (operations/resources/components) included in the upload. This is to preserve the manually entered details on upload. If uploading Job Details for a new job, then all the detail entries for the Job should be included in the upload. The Bom and Routing are not automatically re-exploded when updating an existing job. There is a hidden ‘Explode Bom and Routing’ column in the upload that can be used to override this default behaviour.
-- Scheduled Start and Completion Dates. For jobs with a routing (the assembly’s own routing for Standard jobs, or a Routing Reference for Non-Standard jobs), supply one of Scheduled Start Date or Scheduled Completion Date — providing the start forward-schedules, providing the completion backward-schedules. The system computes the other end from the routing lead times. If both are supplied, forward-scheduling from the start is used. For jobs without a routing, both dates are required and are stored verbatim. The same rules apply on update: changing only the start triggers a forward reschedule, changing only the completion triggers a backward reschedule.
-- Job creation supports both automatic job name generation (via the WIP Job Prefix profile and sequence) and manual job naming. The Upload Job Identifier column uniquely identifies a job in the upload and provides traceability between uploaded rows and the eventual job name when automatic naming is used. It must be unique per logical job within a single upload. For manual job naming, the Upload Job Identifier will also be used as the Job Name if a Job Name is not specifically entered in the upload.
-- Non-standard jobs without an assembly or routing reference cannot be updated through WIP Mass Load; such jobs must be edited in the Discrete Jobs form directly. The upload reports a clear error if attempted.
-- Processing uses the WIP Mass Load interface (wipjobscheduleinterface and wipjobdtlsinterface) with the WICMLP concurrent program. Validation errors are detected per job and cascaded to all rows of the affected job so the job is either processed in its entirety or not at all.
-- Excel Example Output: https://www.enginatics.com/example/wip-job-upload/
-- Library Link: https://www.enginatics.com/reports/wip-job-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
to_char(null) job_rowid,
to_char(null) operation_rowid,
to_char(null) resource_rowid,
to_char(null) component_rowid,
to_char(null) auto_generate_job_name,
x.*
from
(
-- branch 1: operations + resources (outer joined, also returns header-only jobs)
select
-- Job
mp.organization_code,
we.wip_entity_name upload_job_identifier,
we.wip_entity_name job_name,
xxen_util.meaning(wdj.job_type,'WIP_DISCRETE_JOB',700) job_type,
wdj.description job_description,
(select msiv.concatenated_segments from mtl_system_items_vl msiv where msiv.inventory_item_id=wdj.primary_item_id and msiv.organization_id=wdj.organization_id) assembly,
(select msiv0.description from mtl_system_items_vl msiv0 where msiv0.inventory_item_id=wdj.primary_item_id and msiv0.organization_id=wdj.organization_id) assembly_description,
wdj.class_code,
xxen_util.meaning(wdj.status_type,'WIP_JOB_STATUS',700) job_status,
xxen_util.meaning(wdj.firm_planned_flag,'SYS_YES_NO',700) firm,
wdj.start_quantity,
wdj.net_quantity mrp_net_quantity,
wdj.scheduled_start_date,
wdj.scheduled_completion_date,
wdj.start_quantity-wdj.quantity_completed-wdj.quantity_scrapped quantity_remaining,
wdj.quantity_completed,
wdj.quantity_scrapped,
wdj.date_released,
wdj.date_completed,
wdj.date_closed,
(select msiv2.concatenated_segments from mtl_system_items_vl msiv2 where msiv2.inventory_item_id=wdj.bom_reference_id and msiv2.organization_id=wdj.organization_id) bom_reference,
(select msiv2b.description from mtl_system_items_vl msiv2b where msiv2b.inventory_item_id=wdj.bom_reference_id and msiv2b.organization_id=wdj.organization_id) bom_reference_description,
wdj.alternate_bom_designator bom_alternate_designator,
wdj.bom_revision,
wdj.bom_revision_date,
xxen_util.meaning(wdj.wip_supply_type,'WIP_SUPPLY',700) supply_type,
(select msiv3.concatenated_segments from mtl_system_items_vl msiv3 where msiv3.inventory_item_id=wdj.routing_reference_id and msiv3.organization_id=wdj.organization_id) routing_reference,
(select msiv3b.description from mtl_system_items_vl msiv3b where msiv3b.inventory_item_id=wdj.routing_reference_id and msiv3b.organization_id=wdj.organization_id) routing_reference_description,
wdj.alternate_routing_designator routing_alternate_designator,
wdj.serialization_start_op,
wdj.routing_revision,
wdj.routing_revision_date,
wdj.completion_subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where milk.inventory_location_id=wdj.completion_locator_id) completion_locator,
(select wsg.schedule_group_name from wip_schedule_groups wsg where wsg.schedule_group_id=wdj.schedule_group_id) schedule_group,
wdj.build_sequence,
(select wl.line_code from wip_lines wl where wl.line_id=wdj.line_id and wl.organization_id=wdj.organization_id) line,
(select ppmv.project_number from pjm_projects_mtll_v ppmv where ppmv.project_id=wdj.project_id) project,
(select pt.task_number from pa_tasks pt where pt.task_id=wdj.task_id) task,
wdj.end_item_unit_number,
wdj.requested_start_date,
wdj.due_date requested_due_date,
wdj.priority scheduling_priority,
wdj.due_date_penalty,
wdj.due_date_tolerance,
wdj.demand_class,
wdj.lot_number,
xxen_util.meaning(wdj.overcompletion_tolerance_type,'WIP_TOLERANCE_TYPE',700) overcompletion_tolerance_type,
wdj.overcompletion_tolerance_value,
to_char(null) explode_bom_and_routing,
wdj.source_code,
wdj.source_line_id,
xxen_util.display_flexfield_context(706,'WIP_DISCRETE_JOBS',wdj.attribute_category) job_attribute_category,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE1',wdj.rowid,wdj.attribute1) job_attribute1,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE2',wdj.rowid,wdj.attribute2) job_attribute2,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE3',wdj.rowid,wdj.attribute3) job_attribute3,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE4',wdj.rowid,wdj.attribute4) job_attribute4,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE5',wdj.rowid,wdj.attribute5) job_attribute5,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE6',wdj.rowid,wdj.attribute6) job_attribute6,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE7',wdj.rowid,wdj.attribute7) job_attribute7,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE8',wdj.rowid,wdj.attribute8) job_attribute8,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE9',wdj.rowid,wdj.attribute9) job_attribute9,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE10',wdj.rowid,wdj.attribute10) job_attribute10,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE11',wdj.rowid,wdj.attribute11) job_attribute11,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE12',wdj.rowid,wdj.attribute12) job_attribute12,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE13',wdj.rowid,wdj.attribute13) job_attribute13,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE14',wdj.rowid,wdj.attribute14) job_attribute14,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE15',wdj.rowid,wdj.attribute15) job_attribute15,
-- Operations
wo.operation_seq_num,
(select bso.operation_code from bom_standard_operations bso where bso.standard_operation_id=wo.standard_operation_id and bso.organization_id=wo.organization_id) operation_code,
(select bd.department_code from bom_departments bd where bd.department_id=wo.department_id) department,
xxen_util.meaning(wo.count_point_type,'BOM_COUNT_POINT_TYPE',700) count_point,
xxen_util.meaning(wor.autocharge_type,'BOM_AUTOCHARGE_TYPE',700) autocharge,
xxen_util.meaning(wo.backflush_flag,'SYS_YES_NO',700) backflush,
wo.minimum_transfer_quantity,
wo.first_unit_start_date,
wo.first_unit_completion_date,
wo.last_unit_start_date,
wo.last_unit_completion_date,
wo.description operation_description,
-- Resource
wor.resource_seq_num,
(select br.resource_code from bom_resources br where br.resource_id=wor.resource_id and br.organization_id=wor.organization_id) resource_sub_element,
wor.uom_code resource_uom,
xxen_util.meaning(wor.basis_type,'CST_BASIS',700) resource_basis,
wor.usage_rate_or_amount,
wor.assigned_units,
xxen_util.meaning(wor.scheduled_flag,'BOM_RESOURCE_SCHEDULE_TYPE',700) scheduled,
wor.schedule_seq_num,
(select ca.activity from cst_activities ca where ca.activity_id=wor.activity_id) activity,
wor.start_date resource_start_date,
wor.completion_date resource_completion_date,
-- Component
to_char(null) component,
to_char(null) component_description,
to_char(null) component_uom,
to_number(null) component_operation_seq_num,
to_char(null) component_department,
to_date(null) component_date_required,
to_char(null) component_basis,
to_number(null) component_quantity_per_assembly,
to_number(null) component_required_quantity,
to_number(null) component_yield_factor,
to_char(null) component_supply_type,
to_char(null) component_supply_subinventory,
to_char(null) component_supply_locator,
to_char(null) component_mrp_net,
-- Ids
wdj.wip_entity_id,
wdj.organization_id,
to_number(null) component_item_id,
nvl2(wo.operation_seq_num,1,2) row_type_sort,
to_number(null) upload_row
from
mtl_parameters mp,
wip_discrete_jobs wdj,
wip_entities we,
wip_operations wo,
wip_operation_resources wor
where
mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=wdj.organization_id and
we.entity_type not in (5,6,7,8,9,10) and
wdj.status_type in (1,3,4,6,7) and
wdj.wip_entity_id=we.wip_entity_id and
wdj.organization_id=we.organization_id and
case when :p_download_operations='Y' then wdj.wip_entity_id end=wo.wip_entity_id(+) and
case when :p_download_operations='Y' then wdj.organization_id end=wo.organization_id(+) and
wo.wip_entity_id=wor.wip_entity_id(+) and
wo.operation_seq_num=wor.operation_seq_num(+) and
wo.organization_id=wor.organization_id(+) and
1=1 and
2=2
union all
-- branch 2: components
select
-- Job
mp.organization_code,
we.wip_entity_name upload_job_identifier,
we.wip_entity_name job_name,
xxen_util.meaning(wdj.job_type,'WIP_DISCRETE_JOB',700) job_type,
wdj.description job_description,
(select msiv.concatenated_segments from mtl_system_items_vl msiv where msiv.inventory_item_id=wdj.primary_item_id and msiv.organization_id=wdj.organization_id) assembly,
(select msiv0.description from mtl_system_items_vl msiv0 where msiv0.inventory_item_id=wdj.primary_item_id and msiv0.organization_id=wdj.organization_id) assembly_description,
wdj.class_code,
xxen_util.meaning(wdj.status_type,'WIP_JOB_STATUS',700) job_status,
xxen_util.meaning(wdj.firm_planned_flag,'SYS_YES_NO',700) firm,
wdj.start_quantity,
wdj.net_quantity mrp_net_quantity,
wdj.scheduled_start_date,
wdj.scheduled_completion_date,
wdj.start_quantity-wdj.quantity_completed-wdj.quantity_scrapped quantity_remaining,
wdj.quantity_completed,
wdj.quantity_scrapped,
wdj.date_released,
wdj.date_completed,
wdj.date_closed,
(select msiv2.concatenated_segments from mtl_system_items_vl msiv2 where msiv2.inventory_item_id=wdj.bom_reference_id and msiv2.organization_id=wdj.organization_id) bom_reference,
(select msiv2b.description from mtl_system_items_vl msiv2b where msiv2b.inventory_item_id=wdj.bom_reference_id and msiv2b.organization_id=wdj.organization_id) bom_reference_description,
wdj.alternate_bom_designator bom_alternate_designator,
wdj.bom_revision,
wdj.bom_revision_date,
xxen_util.meaning(wdj.wip_supply_type,'WIP_SUPPLY',700) supply_type,
(select msiv3.concatenated_segments from mtl_system_items_vl msiv3 where msiv3.inventory_item_id=wdj.routing_reference_id and msiv3.organization_id=wdj.organization_id) routing_reference,
(select msiv3b.description from mtl_system_items_vl msiv3b where msiv3b.inventory_item_id=wdj.routing_reference_id and msiv3b.organization_id=wdj.organization_id) routing_reference_description,
wdj.alternate_routing_designator routing_alternate_designator,
wdj.serialization_start_op,
wdj.routing_revision,
wdj.routing_revision_date,
wdj.completion_subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where milk.inventory_location_id=wdj.completion_locator_id) completion_locator,
(select wsg.schedule_group_name from wip_schedule_groups wsg where wsg.schedule_group_id=wdj.schedule_group_id) schedule_group,
wdj.build_sequence,
(select wl.line_code from wip_lines wl where wl.line_id=wdj.line_id and wl.organization_id=wdj.organization_id) line,
(select ppmv.project_number from pjm_projects_mtll_v ppmv where ppmv.project_id=wdj.project_id) project,
(select pt.task_number from pa_tasks pt where pt.task_id=wdj.task_id) task,
wdj.end_item_unit_number,
wdj.requested_start_date,
wdj.due_date requested_due_date,
wdj.priority scheduling_priority,
wdj.due_date_penalty,
wdj.due_date_tolerance,
wdj.demand_class,
wdj.lot_number,
xxen_util.meaning(wdj.overcompletion_tolerance_type,'WIP_TOLERANCE_TYPE',700) overcompletion_tolerance_type,
wdj.overcompletion_tolerance_value,
to_char(null) explode_bom_and_routing,
wdj.source_code,
wdj.source_line_id,
xxen_util.display_flexfield_context(706,'WIP_DISCRETE_JOBS',wdj.attribute_category) job_attribute_category,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE1',wdj.rowid,wdj.attribute1) job_attribute1,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE2',wdj.rowid,wdj.attribute2) job_attribute2,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE3',wdj.rowid,wdj.attribute3) job_attribute3,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE4',wdj.rowid,wdj.attribute4) job_attribute4,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE5',wdj.rowid,wdj.attribute5) job_attribute5,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE6',wdj.rowid,wdj.attribute6) job_attribute6,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE7',wdj.rowid,wdj.attribute7) job_attribute7,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE8',wdj.rowid,wdj.attribute8) job_attribute8,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE9',wdj.rowid,wdj.attribute9) job_attribute9,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE10',wdj.rowid,wdj.attribute10) job_attribute10,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE11',wdj.rowid,wdj.attribute11) job_attribute11,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE12',wdj.rowid,wdj.attribute12) job_attribute12,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE13',wdj.rowid,wdj.attribute13) job_attribute13,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE14',wdj.rowid,wdj.attribute14) job_attribute14,
xxen_util.display_flexfield_value(706,'WIP_DISCRETE_JOBS',wdj.attribute_category,'ATTRIBUTE15',wdj.rowid,wdj.attribute15) job_attribute15,
-- Operation
to_number(null) operation_seq_num,
to_char(null) operation_code,
to_char(null) department,
to_char(null) count_point,
to_char(null) autocharge,
to_char(null) backflush,
to_number(null) minimum_transfer_quantity,
to_date(null) first_unit_start_date,
to_date(null) first_unit_completion_date,
to_date(null) last_unit_start_date,
to_date(null) last_unit_completion_date,
to_char(null) operation_description,
-- Resource
to_number(null) resource_seq_num,
to_char(null) resource_sub_element,
to_char(null) resource_uom,
to_char(null) resource_basis,
to_number(null) usage_rate_or_amount,
to_number(null) assigned_units,
to_char(null) scheduled,
to_number(null) schedule_seq_num,
to_char(null) activity,
to_date(null) resource_start_date,
to_date(null) resource_completion_date,
-- Component
(select msiv4.concatenated_segments from mtl_system_items_vl msiv4 where msiv4.inventory_item_id=wro.inventory_item_id and msiv4.organization_id=wro.organization_id) component,
(select msiv4b.description from mtl_system_items_vl msiv4b where msiv4b.inventory_item_id=wro.inventory_item_id and msiv4b.organization_id=wro.organization_id) component_description,
(select msiv4c.primary_uom_code from mtl_system_items_vl msiv4c where msiv4c.inventory_item_id=wro.inventory_item_id and msiv4c.organization_id=wro.organization_id) component_uom,
wro.operation_seq_num component_operation_seq_num,
(select bd.department_code from bom_departments bd where bd.department_id=wro.department_id) component_department,
wro.date_required component_date_required,
xxen_util.meaning(wro.basis_type,'CST_BASIS',700) component_basis,
wro.quantity_per_assembly component_quantity_per_assembly,
wro.required_quantity component_required_quantity,
wro.component_yield_factor,
xxen_util.meaning(wro.wip_supply_type,'WIP_SUPPLY',700) component_supply_type,
wro.supply_subinventory component_supply_subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where milk.inventory_location_id=wro.supply_locator_id) component_supply_locator,
xxen_util.meaning(wro.mrp_net_flag,'SYS_YES_NO',700) component_mrp_net,
-- Ids
wdj.wip_entity_id,
wdj.organization_id,
wro.inventory_item_id component_item_id,
2 row_type_sort,
to_number(null) upload_row
from
mtl_parameters mp,
wip_discrete_jobs wdj,
wip_entities we,
wip_requirement_operations wro
where
mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=wdj.organization_id and
we.entity_type not in (5,6,7,8,9,10) and
wdj.status_type in (1,3,4,6,7) and
wdj.wip_entity_id=we.wip_entity_id and
wdj.organization_id=we.organization_id and
wdj.wip_entity_id=wro.wip_entity_id and
wdj.organization_id=wro.organization_id and
wro.wip_supply_type<>6 and
wro.operation_seq_num>0 and
:p_download_components='Y' and
1=1 and
2=2
) x

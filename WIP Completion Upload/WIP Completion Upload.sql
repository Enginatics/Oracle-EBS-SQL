/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: WIP Completion Upload
-- Description: Creates assembly completions and returns as in the Completion Transactions form, for discrete jobs with and without routing and for the repetitive schedules of a line and assembly, into a completion subinventory and locator, with lot and serial numbers and overcompletions. Each row is inserted into the inventory transaction interface and processed immediately by the transaction manager, with backflush of the assembly pull and operation pull components, as for a completion entered in the form.
-- Upload Mode Create opens an empty sheet. Create, Update downloads the jobs and schedules of the selected Transaction Type: for completions the quantity at To move of the last operation, or without routing the quantity not completed yet, as Available; for returns the completed quantity. Enter Quantity on the rows to transact, rows left unchanged are not uploaded. An existing transaction is never updated; correct a completion with a return.
-- Quantity above Available needs Overcompletion, within the overcompletion tolerance, and follows the Allow Overcompletion parameter. A blank Final Completion takes the form's default. Each row carries one lot and one serial number range; transact several lots as several rows.
-- Not supported: serialized jobs, sales order reservations and kanban replenishment, e-records and e-signatures, and backflush lot and serial entry. A completion fails when a backflush component is serial controlled, or lot controlled with a lot that cannot be derived.
-- To enter descriptive flexfield values, use the All Columns template, which shows the Completion Attribute segment prompts.
-- Excel Example Output: https://www.enginatics.com/example/wip-completion-upload/
-- Library Link: https://www.enginatics.com/reports/wip-completion-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
to_number(null) transaction_id,
x.organization_code,
x.line,
x.line_description,
x.assembly,
x.assembly_description,
x.primary_uom,
x.job,
x.job_description,
x.bill_revision,
x.transaction_type,
sysdate transaction_date,
to_char(null) overcompletion,
x.job_quantity,
x.job_complete,
x.available,
case when x.revision_qty_control_code=2 then x.bill_revision end revision,
x.subinventory,
x.locator,
x.primary_uom uom,
to_number(null) quantity,
to_char(null) final_completion,
case when x.lot_control_code=2 then x.lot_number end lot_number,
to_date(null) lot_expiration_date,
to_char(null) from_serial_number,
to_char(null) to_serial_number,
to_char(null) reason,
cast(null as varchar2(240)) reference,
to_char(null) completion_attribute_category,
to_char(null) completion_attribute1,
to_char(null) completion_attribute2,
to_char(null) completion_attribute3,
to_char(null) completion_attribute4,
to_char(null) completion_attribute5,
to_char(null) completion_attribute6,
to_char(null) completion_attribute7,
to_char(null) completion_attribute8,
to_char(null) completion_attribute9,
to_char(null) completion_attribute10,
to_char(null) completion_attribute11,
to_char(null) completion_attribute12,
to_char(null) completion_attribute13,
to_char(null) completion_attribute14,
to_char(null) completion_attribute15,
row_number() over (order by x.organization_code,x.job,x.line,x.assembly,x.transaction_action_id) upload_row
from
(
select
mp.organization_code,
to_char(null) line,
to_char(null) line_description,
msiv.concatenated_segments assembly,
msiv.description assembly_description,
msiv.primary_uom_code primary_uom,
msiv.revision_qty_control_code,
msiv.lot_control_code,
we.wip_entity_name job,
we.description job_description,
wdj.bom_revision bill_revision,
mtt.transaction_type_name transaction_type,
mtt.transaction_action_id,
wdj.start_quantity job_quantity,
wdj.quantity_completed job_complete,
xxen_wip_upload.completion_available(wdj.organization_id,wdj.wip_entity_id,null,mtt.transaction_action_id) available,
wdj.completion_subinventory subinventory,
milk.concatenated_segments locator,
wdj.lot_number
from
mtl_parameters mp,
wip_discrete_jobs wdj,
wip_entities we,
mtl_system_items_vl msiv,
mtl_transaction_types mtt,
mtl_item_locations_kfv milk
where
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=wdj.organization_id and
wdj.status_type in (3,4) and
wdj.serialization_start_op is null and
wdj.wip_entity_id=we.wip_entity_id and
we.entity_type=1 and
wdj.primary_item_id=msiv.inventory_item_id and
wdj.organization_id=msiv.organization_id and
mtt.transaction_type_id in (44,17) and
wdj.completion_locator_id=milk.inventory_location_id(+) and
wdj.organization_id=milk.organization_id(+)
union all
select
mp.organization_code,
wl.line_code line,
wl.description line_description,
msiv.concatenated_segments assembly,
msiv.description assembly_description,
msiv.primary_uom_code primary_uom,
msiv.revision_qty_control_code,
msiv.lot_control_code,
to_char(null) job,
to_char(null) job_description,
(select max(wrs.bom_revision) keep (dense_rank first order by wrs.first_unit_start_date) from wip_repetitive_schedules wrs where wri.wip_entity_id=wrs.wip_entity_id and wri.line_id=wrs.line_id and wrs.status_type in (3,4)) bill_revision,
mtt.transaction_type_name transaction_type,
mtt.transaction_action_id,
to_number(null) job_quantity,
to_number(null) job_complete,
xxen_wip_upload.completion_available(wri.organization_id,wri.wip_entity_id,wri.line_id,mtt.transaction_action_id) available,
wri.completion_subinventory subinventory,
milk.concatenated_segments locator,
to_char(null) lot_number
from
mtl_parameters mp,
wip_repetitive_items wri,
wip_lines wl,
mtl_system_items_vl msiv,
mtl_transaction_types mtt,
mtl_item_locations_kfv milk
where
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=wri.organization_id and
(wri.wip_entity_id,wri.line_id) in (select wrs.wip_entity_id, wrs.line_id from wip_repetitive_schedules wrs where wrs.status_type in (3,4)) and
wri.line_id=wl.line_id and
wri.primary_item_id=msiv.inventory_item_id and
wri.organization_id=msiv.organization_id and
mtt.transaction_type_id in (44,17) and
wri.completion_locator_id=milk.inventory_location_id(+) and
wri.organization_id=milk.organization_id(+)
) x
where
x.available>0 and
1=1

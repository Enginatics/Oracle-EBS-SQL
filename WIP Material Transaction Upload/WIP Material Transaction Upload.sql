/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: WIP Material Transaction Upload
-- Description: Issues components to, and returns components from, WIP work orders.

The download returns one row per component requirement of the selected work orders, with the operation, department, supply subinventory and locator already filled in, and the required, issued and still open quantities shown. Enter a Transaction Type and a Quantity on the rows you want to transact and leave the rest blank.

Quantity is always entered as a positive number; the Transaction Type decides the direction.

Discrete jobs, lot based jobs and maintenance work orders are supported. Repetitive schedules are not.

Rows are staged in the inventory transaction interface and processed by the inventory transaction manager, so the resulting transactions are identical to those the WIP Material Transactions form creates and relieve the work order requirement in the same way.
-- Excel Examle Output: https://www.enginatics.com/example/wip-material-transaction-upload/
-- Library Link: https://www.enginatics.com/reports/wip-material-transaction-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
to_number(null) source_line_id,
to_number(null) source_header_id,
ood.organization_code organization,
we.wip_entity_name job,
xxen_util.meaning(we.entity_type,'WIP_ENTITY',700) job_type,
xxen_util.meaning(wdj.status_type,'WIP_JOB_STATUS',700) job_status,
msiv_a.concatenated_segments assembly,
msiv_a.description assembly_description,
wro.operation_seq_num,
bd.department_code department,
msiv.concatenated_segments component,
msiv.description component_description,
xxen_util.meaning(wro.wip_supply_type,'WIP_SUPPLY',700) supply_type,
wro.date_required,
wro.required_quantity,
wro.quantity_issued,
wro.required_quantity-wro.quantity_issued open_quantity,
to_char(null) transaction_type,
to_number(null) quantity,
(select muomv.unit_of_measure from mtl_units_of_measure_vl muomv where msiv.primary_uom_code=muomv.uom_code) uom,
wro.supply_subinventory subinventory,
milk.concatenated_segments locator,
to_char(null) revision,
sysdate transaction_date,
to_char(null) reason,
cast(null as varchar2(240)) transaction_reference,
to_char(null) lot_number,
to_date(null) lot_expiration_date,
to_number(null) lot_quantity,
to_char(null) from_serial_number,
to_char(null) to_serial_number,
to_char(null) source_project,
to_char(null) source_task,
to_char(null) expenditure_type,
to_char(null) expenditure_org,
row_number() over (order by we.wip_entity_name, wro.operation_seq_num, msiv.concatenated_segments) upload_row
from
org_organization_definitions ood,
wip_entities we,
wip_discrete_jobs wdj,
wip_requirement_operations wro,
mtl_system_items_vl msiv,
mtl_system_items_vl msiv_a,
bom_departments bd,
mtl_item_locations_kfv milk
where
1=1 and
we.organization_id=ood.organization_id and
we.entity_type in (1,5,6) and
wdj.wip_entity_id=we.wip_entity_id and
wdj.organization_id=we.organization_id and
wro.wip_entity_id=we.wip_entity_id and
wro.organization_id=we.organization_id and
wro.repetitive_schedule_id is null and
msiv.inventory_item_id=wro.inventory_item_id and
msiv.organization_id=wro.organization_id and
msiv_a.inventory_item_id(+)=wdj.primary_item_id and
msiv_a.organization_id(+)=wdj.organization_id and
bd.department_id(+)=wro.department_id and
milk.inventory_location_id(+)=wro.supply_locator_id and
milk.organization_id(+)=wro.organization_id
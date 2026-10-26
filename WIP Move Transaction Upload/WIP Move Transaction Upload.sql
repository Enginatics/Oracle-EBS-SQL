/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: WIP Move Transaction Upload
-- Description: Creates move transactions as in the Move Transactions form: moves between operations and intraoperation steps, including moves into and out of Reject and Scrap, Move and completion transactions and Return and move transactions, for discrete jobs and for the repetitive schedules of a line and assembly. Each row is posted immediately, with backflush, completion, outside processing and autocharge resources as for a move entered in the form.
-- Upload Mode Create opens an empty sheet. Create, Update downloads the Queue, Run and To move steps of the selected jobs and schedules that hold a quantity, with their Available quantity, as new move rows: enter To Step and Quantity on the rows to move, rows left unchanged are not uploaded. On a downloaded row only the move can be changed; a move from another step goes on a new row. To move of the last operation is not downloaded, and a Move and completion cannot start there, as in the form: complete those assemblies with WIP Completion Upload. An existing move is never updated; correct it with another move, for example a backward move or a Return and move transaction.
-- Completions, returns and overcompletions follow the Transaction Types and Allow Overcompletion parameters, not the function Move Transactions is launched from. A .csv or plain .xlsx file, and an add-in upload of a sheet another user downloaded, run with the parameter defaults of the template named in the upload, else with the parameter defaults.
-- With E-Records and E-Signatures set to Yes, discrete job moves create e-records as in the Move Transactions form, also where the move or material processing profiles are set to background, where the form creates none. A move that needs an e-signature is refused and has to be entered in the form. With the parameter cleared, moves are posted without e-records, as through the WIP move interface.
-- Not supported: operations added on the fly, manual resource transactions, serialized jobs and backflush lot and serial entry. A move fails when a backflush component is serial controlled, or lot controlled with a lot that cannot be derived; derived lots are not verified. Mandatory quality collection plans are not enforced, as by the WIP move interface, and No Move shop floor statuses always apply, also for users of the form function that overrides them.
-- To enter descriptive flexfield values, add the Move Attribute Category and Move Attribute1-15 columns, which show the segment prompts, to a template of your own.
-- Excel Example Output: https://www.enginatics.com/example/wip-move-transaction-upload/
-- Library Link: https://www.enginatics.com/reports/wip-move-transaction-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
to_number(null) transaction_id,
x.organization_code,
to_char(null) sales_order,
to_char(null) order_line,
x.job,
x.job_description,
x.line,
x.line_description,
x.assembly,
x.assembly_description,
x.primary_uom,
x.bill_revision,
xxen_util.meaning(1,'WIP_MOVE_TRANSACTION_TYPE',700) transaction_type,
x.from_seq,
x.from_code,
x.from_department,
x.from_step,
x.to_seq,
x.to_code,
x.to_department,
to_char(null) to_step,
to_char(null) overcompletion,
x.primary_uom uom,
x.available,
to_number(null) quantity,
sysdate transaction_date,
to_char(null) scrap_account_alias,
to_char(null) scrap_account_number,
to_char(null) reason,
cast(null as varchar2(240)) reference,
to_char(null) move_attribute_category,
to_char(null) move_attribute1,
to_char(null) move_attribute2,
to_char(null) move_attribute3,
to_char(null) move_attribute4,
to_char(null) move_attribute5,
to_char(null) move_attribute6,
to_char(null) move_attribute7,
to_char(null) move_attribute8,
to_char(null) move_attribute9,
to_char(null) move_attribute10,
to_char(null) move_attribute11,
to_char(null) move_attribute12,
to_char(null) move_attribute13,
to_char(null) move_attribute14,
to_char(null) move_attribute15,
row_number() over (order by x.organization_code,x.job,x.line,x.assembly,x.from_seq,x.fm_step_type) upload_row
from
(
select
y.organization_code,
to_char(null) line,
to_char(null) line_description,
y.assembly,
y.assembly_description,
y.primary_uom,
y.job,
y.job_description,
y.bill_revision,
y.from_seq,
y.from_code,
y.from_department,
xxen_util.meaning(y.fm_step_type,'WIP_INTRAOPERATION_STEP',700) from_step,
y.fm_step_type,
y.to_seq,
bso_to.operation_code to_code,
bd_to.department_code to_department,
y.available,
y.wip_entity_id
from
(
select /*+ cardinality(rowgen 3) */
mp.organization_code,
msiv.concatenated_segments assembly,
msiv.description assembly_description,
msiv.primary_uom_code primary_uom,
we.wip_entity_name job,
we.description job_description,
wdj.bom_revision bill_revision,
wo.operation_seq_num from_seq,
bso.operation_code from_code,
bd.department_code from_department,
rowgen.column_value fm_step_type,
nvl((select min(wo_cp.operation_seq_num) from wip_operations wo_cp where wo.wip_entity_id=wo_cp.wip_entity_id and wo.operation_seq_num<wo_cp.operation_seq_num and wo_cp.count_point_type=1),wo.operation_seq_num) to_seq,
decode(rowgen.column_value,1,wo.quantity_in_queue,2,wo.quantity_running,3,wo.quantity_waiting_to_move) available,
wdj.wip_entity_id
from
mtl_parameters mp,
wip_discrete_jobs wdj,
wip_entities we,
mtl_system_items_vl msiv,
wip_operations wo,
bom_standard_operations bso,
bom_departments bd,
table(xxen_util.rowgen(3)) rowgen
where
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=wdj.organization_id and
wdj.status_type in (3,4) and
wdj.serialization_start_op is null and
wdj.wip_entity_id=we.wip_entity_id and
we.entity_type=1 and
wdj.primary_item_id=msiv.inventory_item_id and
wdj.organization_id=msiv.organization_id and
wdj.wip_entity_id=wo.wip_entity_id and
wo.standard_operation_id=bso.standard_operation_id(+) and
nvl(bso.operation_type,1)=1 and
bso.line_id is null and
wo.department_id=bd.department_id and
(rowgen.column_value<>3 or wo.next_operation_seq_num is not null)
) y,
wip_operations wo_to,
bom_standard_operations bso_to,
bom_departments bd_to
where
y.available>0 and
y.wip_entity_id=wo_to.wip_entity_id and
y.to_seq=wo_to.operation_seq_num and
wo_to.standard_operation_id=bso_to.standard_operation_id(+) and
wo_to.department_id=bd_to.department_id
union all
select
z.organization_code,
z.line,
z.line_description,
z.assembly,
z.assembly_description,
z.primary_uom,
to_char(null) job,
to_char(null) job_description,
z.bill_revision,
z.from_seq,
z.from_code,
z.from_department,
xxen_util.meaning(z.fm_step_type,'WIP_INTRAOPERATION_STEP',700) from_step,
z.fm_step_type,
z.to_seq,
bso_to.operation_code to_code,
bd_to.department_code to_department,
z.available,
to_number(null) wip_entity_id
from
(
select
y.*,
nvl((select min(wo_cp.operation_seq_num) from wip_operations wo_cp where y.first_schedule_id=wo_cp.repetitive_schedule_id and y.from_seq<wo_cp.operation_seq_num and wo_cp.count_point_type=1),y.from_seq) to_seq
from
(
select /*+ cardinality(rowgen 3) */
mp.organization_code,
wl.line_code line,
wl.description line_description,
msiv.concatenated_segments assembly,
msiv.description assembly_description,
msiv.primary_uom_code primary_uom,
max(wrs.bom_revision) keep (dense_rank first order by wrs.first_unit_start_date) bill_revision,
min(wrs.repetitive_schedule_id) keep (dense_rank first order by wrs.first_unit_start_date) first_schedule_id,
wo.operation_seq_num from_seq,
max(bso.operation_code) keep (dense_rank first order by wrs.first_unit_start_date) from_code,
max(bd.department_code) keep (dense_rank first order by wrs.first_unit_start_date) from_department,
rowgen.column_value fm_step_type,
sum(decode(rowgen.column_value,1,wo.quantity_in_queue,2,wo.quantity_running,3,wo.quantity_waiting_to_move)) available
from
mtl_parameters mp,
wip_repetitive_schedules wrs,
wip_lines wl,
wip_entities we,
mtl_system_items_vl msiv,
wip_operations wo,
bom_standard_operations bso,
bom_departments bd,
table(xxen_util.rowgen(3)) rowgen
where
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=wrs.organization_id and
wrs.status_type in (3,4) and
wrs.line_id=wl.line_id and
wrs.wip_entity_id=we.wip_entity_id and
we.primary_item_id=msiv.inventory_item_id and
we.organization_id=msiv.organization_id and
wrs.wip_entity_id=wo.wip_entity_id and
wrs.repetitive_schedule_id=wo.repetitive_schedule_id and
wo.standard_operation_id=bso.standard_operation_id(+) and
nvl(bso.operation_type,1)=1 and
bso.line_id is null and
wo.department_id=bd.department_id and
(rowgen.column_value<>3 or wo.next_operation_seq_num is not null)
group by
mp.organization_code,
wl.line_code,
wl.description,
msiv.concatenated_segments,
msiv.description,
msiv.primary_uom_code,
wo.operation_seq_num,
rowgen.column_value
) y
where
y.available>0
) z,
wip_operations wo_to,
bom_standard_operations bso_to,
bom_departments bd_to
where
z.first_schedule_id=wo_to.repetitive_schedule_id and
z.to_seq=wo_to.operation_seq_num and
wo_to.standard_operation_id=bso_to.standard_operation_id(+) and
wo_to.department_id=bd_to.department_id
) x
where
1=1

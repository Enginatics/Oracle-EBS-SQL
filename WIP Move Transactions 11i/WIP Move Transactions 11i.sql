/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: WIP Move Transactions 11i
-- Description: WIP move transactions of discrete jobs, lot based jobs, repetitive schedules and flow schedules, one row per transaction, as shown in the View Move Transactions form.
-- The report covers the data of the Oracle standard Move Transaction Report (WIPTSMOV): from and to operation, department and intraoperation step, transaction and primary quantity, reason and reference, over-completion and scrap account.
-- A repetitive move is shown once per repetitive schedule it was allocated to, with the schedule's first unit start date and the allocated quantity.
-- Quantity is in the unit of measure the transaction was entered in, Primary Quantity in the assembly's primary unit of measure. Transaction Day is the transaction date without the time, for daily totals.
-- Transactions still pending in the move transaction interface are not included.
-- Excel Example Output: https://www.enginatics.com/example/wip-move-transactions-11i/
-- Library Link: https://www.enginatics.com/reports/wip-move-transactions-11i/
-- Run Report: https://demo.enginatics.com/

select
mp.organization_code,
wmt.transaction_date,
trunc(wmt.transaction_date) transaction_day,
we.wip_entity_name job,
xxen_util.meaning(we.entity_type,'WIP_ENTITY',700) job_type,
wl.line_code line,
wrs.first_unit_start_date schedule_start_date,
msiv.concatenated_segments assembly,
msiv.description assembly_description,
wmt.fm_operation_seq_num from_operation_seq,
wmt.fm_operation_code from_operation_code,
bd_fm.department_code from_department,
xxen_util.meaning(wmt.fm_intraoperation_step_type,'WIP_INTRAOPERATION_STEP',700) from_step,
wmt.to_operation_seq_num to_operation_seq,
wmt.to_operation_code,
bd_to.department_code to_department,
xxen_util.meaning(wmt.to_intraoperation_step_type,'WIP_INTRAOPERATION_STEP',700) to_step,
nvl(wmta.transaction_quantity,wmt.transaction_quantity) quantity,
wmt.transaction_uom uom,
nvl(wmta.primary_quantity,wmt.primary_quantity) primary_quantity,
wmt.primary_uom,
xxen_util.yes(case when wmt.overcompletion_transaction_id is not null then 'Y' end) overcompletion,
wmt.overcompletion_transaction_qty overcompletion_quantity,
wmt.overcompletion_primary_qty,
xxen_util.concatenated_segments(wmt.scrap_account_id) scrap_account,
mtr.reason_name reason,
wmt.reference,
wmt.source_code,
xxen_util.user_name(wmt.created_by) created_by,
wmt.creation_date,
wmt.transaction_id
from
mtl_parameters mp,
wip_move_transactions wmt,
wip_move_txn_allocations wmta,
wip_repetitive_schedules wrs,
wip_entities we,
wip_lines wl,
mtl_system_items_vl msiv,
bom_departments bd_fm,
bom_departments bd_to,
mtl_transaction_reasons mtr
where
1=1 and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=wmt.organization_id and
wmt.transaction_id=wmta.transaction_id(+) and
wmta.repetitive_schedule_id=wrs.repetitive_schedule_id(+) and
wmt.wip_entity_id=we.wip_entity_id and
wmt.line_id=wl.line_id(+) and
wmt.organization_id=wl.organization_id(+) and
wmt.organization_id=msiv.organization_id(+) and
wmt.primary_item_id=msiv.inventory_item_id(+) and
wmt.fm_department_id=bd_fm.department_id and
wmt.to_department_id=bd_to.department_id and
wmt.reason_id=mtr.reason_id(+)
order by
mp.organization_code,
wmt.transaction_date,
wmt.transaction_id,
wrs.first_unit_start_date

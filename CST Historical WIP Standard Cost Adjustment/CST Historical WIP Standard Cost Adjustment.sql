/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Historical WIP Standard Cost Adjustment
-- Description: WIP standard cost adjustment details recorded by a completed standard cost update, based on Oracle's Historical WIP Standard Cost Adjustment Report (CSTCUSJA).

The report shows one line per WIP discrete job, transaction type, item or resource operation and cost element, with the old and new unit costs, adjustment quantity and adjustment value, and the WIP job's valuation and standard cost adjustment accounts.

The Cost Update parameter offers the completed standard cost updates of the selected organization that saved their adjustment details, matching Oracle's View Cost Update History form. Oracle's Delete Snapshot option is deliberately not included, so the stored adjustment details are never removed by this report.
-- Excel Examle Output: https://www.enginatics.com/example/cst-historical-wip-standard-cost-adjustment/
-- Library Link: https://www.enginatics.com/reports/cst-historical-wip-standard-cost-adjustment/
-- Run Report: https://demo.enginatics.com/

select
z.organization_code,
z.cost_update_date,
z.cost_type,
z.cost_update_description,
z.item_range,
z.currency,
z.wip_class,
z.job,
z.assembly,
z.assembly_description,
z.transaction_type,
z.item,
z.item_description,
z.resource_code,
z.op_seq,
z.resource_seq,
z.basis,
z.uom,
z.standard_rate,
z.cost_element,
case when z.raw_transaction_type in (5,8,9) or z.count_qty=0 then z.old_unit_cost_sum when z.sum_level/z.count_qty in (1,2) then round(z.old_unit_cost_sum/z.count_qty,z.ext_prec) else round(z.old_unit_cost_sum*2/z.count_qty,z.ext_prec) end old_unit_cost,
case when z.raw_transaction_type in (5,8,9) or z.count_qty=0 then z.new_unit_cost_sum when z.sum_level/z.count_qty in (1,2) then round(z.new_unit_cost_sum/z.count_qty,z.ext_prec) else round(z.new_unit_cost_sum*2/z.count_qty,z.ext_prec) end new_unit_cost,
case when z.count_qty>0 and z.transaction_code=4 and z.sum_level/z.count_qty not in (1,2) then z.adjustment_quantity/2 else z.adjustment_quantity end adjustment_quantity,
z.old_value,
z.new_value,
z.adjustment,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where z.material_account=gcck.code_combination_id) material_account,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where z.material_overhead_account=gcck.code_combination_id) material_overhead_account,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where z.resource_account=gcck.code_combination_id) resource_account,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where z.outside_processing_account=gcck.code_combination_id) outside_processing_account,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where z.overhead_account=gcck.code_combination_id) overhead_account,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where z.std_cost_adjustment_account=gcck.code_combination_id) std_cost_adjustment_account
from
(
select
y.organization_code,
y.cost_update_date,
y.cost_type,
y.cost_update_description,
y.item_range,
y.currency,
y.wip_class,
y.job,
y.assembly,
y.assembly_description,
y.transaction_type,
y.transaction_code,
y.raw_transaction_type,
y.item,
y.item_description,
y.resource_code,
y.op_seq,
y.resource_seq,
y.basis,
y.uom,
max(y.standard_rate) standard_rate,
y.cost_element_id,
y.cost_element,
y.ext_prec,
y.material_account,
y.material_overhead_account,
y.resource_account,
y.outside_processing_account,
y.overhead_account,
y.std_cost_adjustment_account,
sum(y.old_unit_cost) old_unit_cost_sum,
sum(y.new_unit_cost) new_unit_cost_sum,
count(y.adjustment_quantity) count_qty,
sum(y.level_type) sum_level,
sum(y.adjustment_quantity) adjustment_quantity,
sum(y.old_value) old_value,
sum(y.new_value) new_value,
sum(y.adjustment) adjustment
from
(
select
x.*,
round(x.old_unit_cost0,x.ext_prec) old_unit_cost,
round(x.new_unit_cost0,x.ext_prec) new_unit_cost,
round(x.qty_factor*x.adjustment_quantity0,3) adjustment_quantity,
round(x.old_unit_cost0*x.adjustment_quantity0/x.round_unit)*x.round_unit old_value,
round(x.new_unit_cost0*x.adjustment_quantity0/x.round_unit)*x.round_unit new_value,
(round(x.new_unit_cost0*x.adjustment_quantity0/x.round_unit)-round(x.old_unit_cost0*x.adjustment_quantity0/x.round_unit))*x.round_unit*x.in_out_flag adjustment
from
(
select
ood.organization_code,
ccu.update_date cost_update_date,
cct.cost_type,
ccu.description cost_update_description,
xxen_util.meaning(ccu.range_option,'CST_ITEM_RANGE',700) item_range,
gl.currency_code currency,
wdj.class_code wip_class,
we.wip_entity_name job,
msiv_asm.concatenated_segments assembly,
msiv_asm.description assembly_description,
xxen_util.meaning(decode(csav.transaction_type,3,3,4,4,5,5,10),'CST_UPDATE_TXN_TYPE',700) transaction_type,
decode(csav.transaction_type,3,3,4,4,5,5,10) transaction_code,
csav.transaction_type raw_transaction_type,
msiv.concatenated_segments item,
msiv.description item_description,
br.resource_code,
csav.operation_seq_num op_seq,
csav.resource_seq_num resource_seq,
decode(csav.transaction_type,4,null,5,null,xxen_util.meaning(nvl(csav.basis_type,1),'CST_BASIS_SHORT',700)) basis,
decode(csav.transaction_type,3,msiv.primary_uom_code,4,msiv.primary_uom_code,5,msiv.primary_uom_code,br.unit_of_measure) uom,
xxen_util.meaning(csav.standard_rate_flag,'SYS_YES_NO',700) standard_rate,
csav.cost_element_id,
cce.cost_element,
wdj.material_account,
wdj.material_overhead_account,
wdj.resource_account,
wdj.outside_processing_account,
wdj.overhead_account,
wdj.std_cost_adjustment_account,
nvl(fc.extended_precision,fc.precision) ext_prec,
nvl(fc.minimum_accountable_unit,power(10,nvl(-fc.precision,0))) round_unit,
nvl(csav.level_type,1) level_type,
csav.old_unit_cost old_unit_cost0,
csav.new_unit_cost new_unit_cost0,
csav.adjustment_quantity adjustment_quantity0,
decode(csav.transaction_type,7,null,5,0.5,1) qty_factor,
csav.in_out_flag
from
cst_cost_updates ccu,
cst_cost_types cct,
org_organization_definitions ood,
gl_ledgers gl,
fnd_currencies fc,
cst_std_cost_adj_values csav,
wip_entities we,
wip_discrete_jobs wdj,
mtl_system_items_vl msiv_asm,
mtl_system_items_vl msiv,
bom_resources br,
cst_cost_elements cce
where
1=1 and
ccu.status=3 and
ccu.cost_type_id=cct.cost_type_id and
ccu.organization_id=ood.organization_id and
ood.set_of_books_id=gl.ledger_id and
gl.currency_code=fc.currency_code and
fc.enabled_flag='Y' and
ccu.cost_update_id=csav.cost_update_id and
csav.transaction_type>2 and
(
csav.transaction_type in (8,9) or
csav.old_unit_cost<>csav.new_unit_cost or
exists
(
select
null
from
cst_std_cost_adj_values csav2
where
csav.transaction_type=6 and
csav.cost_update_id=csav2.cost_update_id and
csav2.transaction_type=7 and
csav2.basis_type between 3 and 4 and
csav.wip_entity_id=csav2.wip_entity_id and
csav.operation_seq_num=csav2.operation_seq_num and
csav.resource_seq_num=csav2.resource_seq_num
)
) and
csav.wip_entity_id in
(
select
csav0.wip_entity_id
from
cst_std_cost_adj_values csav0
where
csav0.cost_update_id=csav.cost_update_id and
csav0.transaction_type>2 and
csav0.old_unit_cost<>csav0.new_unit_cost
) and
csav.organization_id=we.organization_id and
csav.wip_entity_id=we.wip_entity_id and
csav.organization_id=wdj.organization_id and
csav.wip_entity_id=wdj.wip_entity_id and
we.organization_id=msiv_asm.organization_id(+) and
we.primary_item_id=msiv_asm.inventory_item_id(+) and
csav.organization_id=msiv.organization_id(+) and
csav.inventory_item_id=msiv.inventory_item_id(+) and
csav.resource_id=br.resource_id(+) and
csav.cost_element_id=cce.cost_element_id
) x
) y
group by
y.organization_code,
y.cost_update_date,
y.cost_type,
y.cost_update_description,
y.item_range,
y.currency,
y.wip_class,
y.job,
y.assembly,
y.assembly_description,
y.transaction_type,
y.transaction_code,
y.raw_transaction_type,
y.item,
y.item_description,
y.resource_code,
y.op_seq,
y.resource_seq,
y.basis,
y.uom,
y.cost_element_id,
y.cost_element,
y.ext_prec,
y.material_account,
y.material_overhead_account,
y.resource_account,
y.outside_processing_account,
y.overhead_account,
y.std_cost_adjustment_account
) z
order by
z.wip_class,
z.job,
z.transaction_code,
z.op_seq,
z.resource_seq,
z.item,
z.resource_code,
z.cost_element_id
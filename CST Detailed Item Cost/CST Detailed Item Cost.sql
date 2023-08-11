/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Detailed Item Cost
-- Description: Detail report that lists each item and the associated costs to be recognized as part of total unit cost of producing the item.
-- Excel Examle Output: https://www.enginatics.com/example/cst-detailed-item-cost/
-- Library Link: https://www.enginatics.com/reports/cst-detailed-item-cost/
-- Run Report: https://demo.enginatics.com/

select
gl.name ledger,
mp.organization_code,
msiv.concatenated_segments item,
&category_columns
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
misv.inventory_item_status_code_tl item_status,
muomv.unit_of_measure_tl primary_uom,
cic.shrinkage_rate shrinkage,
cic.lot_size lot_size,
cicd.operation_seq_num op_seq,
xxen_util.meaning(cicd.level_type,'CST_LEVEL',700) op_level,
xxen_util.meaning(cicd.cost_element_id,'CST_COST_CODE_TYPE',700) cost_element,
br.resource_code sub_element,
br.unit_of_measure uom,
xxen_util.meaning(cicd.basis_type,'CST_BASIS_SHORT',700) basis,
xxen_util.meaning(cicd.rollup_source_type,'CST_SOURCE_TYPE',700) cost_source,
round(cicd.basis_factor,fc.extended_precision) basis_factor,
round(cicd.resource_rate,fc.extended_precision) res_unit_cost,
round(decode(cicd.cost_element_id,3,cicd.usage_rate_or_amount,4,cicd.usage_rate_or_amount,null),fc.extended_precision) resource_usage,
round(decode(cicd.cost_element_id,1,cicd.usage_rate_or_amount,3,null,4,null,cicd.usage_rate_or_amount),fc.extended_precision) matl_or_overhead,
round(cicd.item_cost, fc.extended_precision) unit_cost,
(select ca.activity from cst_activities ca where cicd.activity_id=ca.activity_id) activity,
cicd.item_units,
cicd.activity_units,
round(decode(cicd.cost_element_id,1,cicd.item_cost,0),fc.extended_precision) material_cost,
round(decode(cicd.cost_element_id,2,cicd.item_cost,0),fc.extended_precision) material_overhead_cost,
round(decode(cicd.cost_element_id,3,cicd.item_cost,0),fc.extended_precision) resource_cost,
round(decode(cicd.cost_element_id,4,cicd.item_cost,0),fc.extended_precision) outside_processing,
round(decode(cicd.cost_element_id,5,cicd.item_cost,0),fc.extended_precision) overhead, 
round(sum(cicd.item_cost) over (partition by cicd.organization_id, cicd.inventory_item_id, cicd.cost_type_id), fc.extended_precision) total_unit_cost,
xxen_util.user_name(cicd.created_by) created_by,
xxen_util.client_time(cicd.creation_date) creation_date,
xxen_util.user_name(cicd.last_updated_by) last_updated_by,
xxen_util.client_time(cicd.last_update_date) last_update_date
from
gl_ledgers gl,
fnd_currencies fc,
org_organization_definitions ood,
mtl_parameters mp,
cst_item_costs cic,
cst_cost_types cct,
cst_item_cost_details cicd,
mtl_system_items_vl msiv,
mtl_units_of_measure_vl muomv,
mtl_item_status_vl misv,
bom_resources br
where
1=1 and
gl.currency_code=fc.currency_code and
fc.enabled_flag='Y' and
gl.ledger_id=ood.set_of_books_id and
ood.organization_id=mp.organization_id and
mp.cost_organization_id=cic.organization_id and
cic.cost_type_id=cct.cost_type_id and
cic.cost_type_id=cicd.cost_type_id and
cic.inventory_item_id=cicd.inventory_item_id and
cic.organization_id=cicd.organization_id and
cic.inventory_item_id=msiv.inventory_item_id and
ood.organization_id=msiv.organization_id and
msiv.primary_uom_code=muomv.uom_code(+) and
msiv.inventory_item_status_code=misv.inventory_item_status_code(+) and
cicd.resource_id=br.resource_id(+)
order by
ledger,
organization_code,
item,
op_level desc,
cost_element
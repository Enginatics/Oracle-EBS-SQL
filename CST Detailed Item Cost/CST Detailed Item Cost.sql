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
mck.concatenated_segments category,
msiv.description item_description,
misv.inventory_item_status_code_tl item_status,
muomv.unit_of_measure_tl primary_uom,
cic.shrinkage_rate shrinkage,
cic.lot_size lot_size,
cdcv.operation_seq_num op_seq,
cdcv.cost_level op_level,
cdcv.cost_element,
cdcv.resource_code sub_element,
cdcv.unit_of_measure uom,
cdcv.basis,
cdcv.cost_source_type cost_source,
round(cdcv.basis_factor,fc.extended_precision) basis_factor,
round(cdcv.resource_rate,fc.extended_precision) res_unit_cost,
round(decode(cdcv.cost_element_id,3,cdcv.usage_rate_or_amount,4,cdcv.usage_rate_or_amount,null),fc.extended_precision) resource_usage,
round(decode(cdcv.cost_element_id,1,cdcv.usage_rate_or_amount,3,null,4,null,cdcv.usage_rate_or_amount),fc.extended_precision) matl_or_overhead,
round(cdcv.item_cost, fc.extended_precision) unit_cost,
cdcv.activity activity,
cdcv.item_units,
cdcv.activity_units,
round(decode(cdcv.cost_element_id,1,cdcv.item_cost,0),fc.extended_precision) material_cost,
round(decode(cdcv.cost_element_id,2,cdcv.item_cost,0),fc.extended_precision) material_overhead_cost,
round(decode(cdcv.cost_element_id,3,cdcv.item_cost,0),fc.extended_precision) resource_cost,
round(decode(cdcv.cost_element_id,4,cdcv.item_cost,0),fc.extended_precision) outside_processing,
round(decode(cdcv.cost_element_id,5,cdcv.item_cost,0),fc.extended_precision) overhead, 
round(sum(cdcv.item_cost) over (partition by cdcv.organization_id, cdcv.inventory_item_id, cdcv.cost_type_id), fc.extended_precision) total_unit_cost
from
gl_ledgers gl,
fnd_currencies fc,
org_organization_definitions ood,
mtl_parameters mp,
cst_item_costs cic,
cst_cost_types cct,
cst_detail_cost_view cdcv,
mtl_system_items_vl msiv,
mtl_units_of_measure_vl muomv,
mtl_item_status_vl misv,
mtl_category_sets_v mcsv,
mtl_item_categories mic,
mtl_categories_kfv mck
where
1=1 and
mcsv.category_set_name=:category_set_name and
gl.currency_code=fc.currency_code and
fc.enabled_flag='Y' and
gl.ledger_id=ood.set_of_books_id and
ood.organization_id=mp.organization_id and
mp.cost_organization_id=cic.organization_id and
cic.cost_type_id=cct.cost_type_id and
cic.cost_type_id=cdcv.cost_type_id and
cic.inventory_item_id=cdcv.inventory_item_id and
cic.organization_id=cdcv.organization_id and
cic.inventory_item_id=msiv.inventory_item_id and
ood.organization_id=msiv.organization_id and
msiv.primary_uom_code=muomv.uom_code(+) and
msiv.inventory_item_status_code=misv.inventory_item_status_code(+) and
mcsv.category_set_id=mic.category_set_id and
msiv.inventory_item_id=mic.inventory_item_id and
msiv.organization_id=mic.organization_id and 
mic.category_id=mck.category_id
order by
ledger,
organization_code,
item,
op_level desc,
cost_element
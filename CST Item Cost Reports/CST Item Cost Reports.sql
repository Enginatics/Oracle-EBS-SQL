/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Item Cost Reports
-- Description: Flexible costing set of reports -  analyze item costs for any cost type. 
Choose from the following options:
Choose one of the following options:
Activity Summary - Report item costs by activity.
Activity by Department - Report item costs by activity and department.
Activity by Flexfield Segment Value - Report item costs by the descriptive flexfield segment you enter.
Activity by Operation - Report item costs by activity and operation sequence number.
Element	- Report item costs by cost element and cost level.
Element by Activity - Report item costs by cost element and activity.
Element by Department - Report item costs by cost element and department.
Element by Operation - Report item costs by cost element and operation sequence number.
Element by Sub-Element - Report item costs by cost element and sub-element.
Operation Summary by Level - Report item costs by operation sequence number and cost level.
Operation by Activity - Report item costs by operation sequence number and activity.
Operation by Sub-Element - Report item costs by operation sequence number and sub-element.
Sub-Element - Report item costs by sub-element.
Sub-Element by Activity - Report item costs by sub-element and activity.
Sub-Element by Department - Report item costs by sub-element and department.
Sub-Element by Flexfield Segment Value - Report item costs by the descriptive flexfield segment you enter.
Sub-Element by Operation - Report item costs by sub-element and operation sequence number.


-- Excel Examle Output: https://www.enginatics.com/example/cst-item-cost-reports/
-- Library Link: https://www.enginatics.com/reports/cst-item-cost-reports/
-- Run Report: https://demo.enginatics.com/

select distinct
gl.name ledger,
mp.organization_code,
msiv.concatenated_segments item,
msiv.description item_description,
mck.concatenated_segments category,
misv.inventory_item_status_code_tl item_status,
muot.unit_of_measure_tl primary_uom,
&columns
round(sum(decode(cdcv.level_type,1,cdcv.item_cost,0)) over (partition by cdcv.organization_id, cdcv.inventory_item_id, &partition_by), fc.extended_precision) this_level,
round(sum(decode(cdcv.level_type,2,cdcv.item_cost,0)) over (partition by cdcv.organization_id, cdcv.inventory_item_id, &partition_by), fc.extended_precision) prev_level,
round(sum(cdcv.item_cost) over (partition by cdcv.organization_id, cdcv.inventory_item_id, &partition_by), fc.extended_precision) item_cost,
100*sum(cdcv.item_cost) over (partition by cdcv.organization_id, cdcv.inventory_item_id, &partition_by)/xxen_util.zero_to_null(sum(cdcv.item_cost) over (partition by cdcv.organization_id, cdcv.inventory_item_id)) percentage,
round(sum(cdcv.item_cost) over (partition by cdcv.organization_id, cdcv.inventory_item_id), fc.extended_precision) item_cost_total
from
gl_ledgers gl,
fnd_currencies fc,
org_organization_definitions ood,
mtl_parameters mp,
mtl_system_items_vl msiv,
mtl_units_of_measure_tl muot,
mtl_item_status_vl misv,
cst_detail_cost_view cdcv,
cst_cost_types cct,
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
ood.organization_id=msiv.organization_id and
msiv.primary_uom_code=muot.uom_code(+) and
muot.language(+)=userenv('lang') and
msiv.inventory_item_status_code=misv.inventory_item_status_code(+) and
msiv.inventory_item_id=cdcv.inventory_item_id and
mp.cost_organization_id=cdcv.organization_id and
cdcv.cost_type_id=cct.cost_type_id and
mcsv.category_set_id=mic.category_set_id and
msiv.inventory_item_id=mic.inventory_item_id and
msiv.organization_id=mic.organization_id and 
mic.category_id=mck.category_id
order by
ledger,
organization_code,
&order_by
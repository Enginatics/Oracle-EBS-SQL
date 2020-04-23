/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Item Cost Reports
-- Description: Based on Oracle's item cost reports CSTRFICRG_XML
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
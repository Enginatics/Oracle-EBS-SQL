/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: OPM Batch Lot Cost Details
-- Description: OPM Batch Lot Cost Details Report

This report shows the Batch Lot Costs details for completed batches in the specified from/to Date Range and for the specified Organization, Product, Formula Class (optional) and Batch (optional).

For each selected batch included in the report, the report details the lot cost details for that batch and for all child production batches consumed by that batch.

The quantities shown in the child batches are the actual quantities for that batch and it’s ingredients. This report does not apportion the child batch quantities based on the actual quantity consumed by the parent batches. 

The report allows the user to pull in several additional data points to allow further analysis of data based on the customer specific configuration. Specifically, for the both the batch product (same for all lines in the batch) and for the batch ingredients (are specific to each line in the batch), the following additional data can be pulled into the report.

- Item Catalog Descriptive Elements for a specific Item Catalog Group
- Item Category Segments for a specific Item Category Set
- Item Descriptive Flexfield Attributes   

-- Excel Examle Output: https://www.enginatics.com/example/opm-batch-lot-cost-details/
-- Library Link: https://www.enginatics.com/reports/opm-batch-lot-cost-details/
-- Run Report: https://demo.enginatics.com/

with opm_batch_lot_costs as
(
select
x.top_batch_id,
x.top_item_id,
x.batch_id,
x.material_detail_id,
x.organization_id,
x.product_item_id,
x.inventory_item_id,
x.primary_uom_code,
x.dtl_um,
x.dtl_prim_uom_conv_rate,
x.plan_qty,
x.actual_qty,
x.scaled_actual_qty,
x.ingredient_usage_factor,
x.lot_number,
x.lot_cost * x.dtl_prim_uom_conv_rate lot_cost,
x.lot_qty,
x.scaled_lot_qty,
x.intermediate_ingred,
x.uom_conv_error,
x.line_type,
x.lot_source,
x.step_level,
x.sort_order,
x.group_id
from
xmltable
( '/BATCHLOTCOST/ROW'
  passing xxen_opm.get_report_xml
  columns
    top_batch_id            number          path 'TOP_BATCH_ID'
  , top_item_id             number          path 'TOP_ITEM_ID'
  , batch_id                number          path 'BATCH_ID'
  , material_detail_id      number          path 'MATERIAL_DETAIL_ID'
  , organization_id         number          path 'ORGANIZATION_ID'
  , product_item_id         number          path 'PRODUCT_ITEM_ID'
  , inventory_item_id       number          path 'INVENTORY_ITEM_ID'
  , primary_uom_code        varchar2(3)     path 'PRIMARY_UOM_CODE'
  , dtl_um                  varchar2(3)     path 'DTL_UM'
  , dtl_prim_uom_conv_rate  number          path 'DTL_PRIM_UOM_CONV_RATE'
  , plan_qty                number          path 'PLAN_QTY'
  , actual_qty              number          path 'ACTUAL_QTY'
  , scaled_actual_qty       number          path 'SCALED_ACTUAL_QTY'
  , ingredient_usage_factor number          path 'SCALING_FACTOR'
  , lot_number              varchar2(150)   path 'LOT_NUMBER'
  , lot_cost                number          path 'LOT_COST'
  , lot_qty                 number          path 'LOT_QTY'
  , scaled_lot_qty          number          path 'SCALED_LOT_QTY'
  , intermediate_ingred     varchar2(1)     path 'INTERMEDIATE_INGRED'
  , uom_conv_error          varchar2(1)     path 'UOM_CONV_ERROR'
  , line_type               number          path 'LINE_TYPE'
  , lot_source              varchar2(150)   path 'LOT_SOURCE'
  , step_level              number          path 'STEP_LEVEL'
  , sort_order              varchar2(2000)  path 'SORT_ORDER'
  , group_id                number          path 'GROUP_ID'
) x
)
--
--
select
ood.organization_code organization,
gbh1.batch_no top_batch_no,
gbh2.batch_no,
(select gfc.formula_class_desc from fm_form_mst ffm,gmd_formula_class gfc where ffm.formula_class = gfc.formula_class and ffm.formula_id = gbh2.formula_id) batch_type,
gbh2.actual_cmplt_date batch_completion_date,
(select gllv.currency_code from gl_ledger_le_v gllv where gllv.ledger_id = ood.set_of_books_id) currency_code,
-- product
msiv1.concatenated_segments product,
msiv1.description product_desc,
xxen_util.meaning(msiv1.item_type,'ITEM_TYPE',3) product_item_type,
oblcp.lot_number batch_lot_number,
oblcp.plan_qty batch_size,
oblcp.actual_qty batch_actual_output,
round(oblcp.actual_qty/oblcp.plan_qty*100,2) batch_yield,
trunc(oblcp.lot_cost * oblcp.actual_qty,:p_precision) batch_cost,
trunc(oblcp.lot_cost,:p_precision) batch_unit_cost,
oblcp.dtl_um batch_uom,
oblcp.primary_uom_code primary_uom,
-- ingredients
oblc.step_level "Level",
xxen_util.meaning(oblc.line_type,'GMD_FORMULA_ITEM_TYPE',552) material_type,
msiv2.concatenated_segments item,
msiv2.description item_desc,
xxen_util.meaning(msiv2.item_type,'ITEM_TYPE',3) item_type,
-- lot
oblc.lot_number,
trunc(oblc.lot_cost,:p_precision) lot_cost,
trunc(oblc.lot_qty,:p_precision) lot_quantity,
trunc(trunc(oblc.lot_cost,:p_precision) * trunc(oblc.lot_qty,:p_precision),:p_precision) lot_extended_cost,
case when sum(trunc(oblc.lot_cost,:p_precision) * trunc(oblc.lot_qty,:p_precision)) over (partition by oblc.batch_id) != 0
then round(((trunc(oblc.lot_cost,:p_precision) * trunc(oblc.lot_qty,:p_precision)) / sum(trunc(oblc.lot_cost,:p_precision) * trunc(oblc.lot_qty,:p_precision)) over (partition by oblc.batch_id))*100,2)
else 0
end pct_of_cost,
decode(oblc.intermediate_ingred,'Y','PRODUCTION BATCH',oblc.lot_source) lot_source,
oblc.dtl_um detail_uom,
xxen_util.meaning(oblc.uom_conv_error,'YES_NO',0) uom_conv_error,
--
&lp_prod_category_segments
&lp_prod_catalog_elements
&lp_prod_item_dff
&lp_ingred_category_segments
&lp_ingred_catalog_elements
&lp_ingred_item_dff
--
oblc.sort_order sort_order,
oblc.top_batch_id,
oblc.batch_id,
oblc.material_detail_id
from
opm_batch_lot_costs oblc,
opm_batch_lot_costs oblcp,
gme_batch_header gbh1,
gme_batch_header gbh2,
org_organization_definitions ood,
mtl_system_items_vl msiv1,
mtl_system_items_vl msiv2
where
-- join the batch ingredient line to the batch product line for batch level kpis
oblc.top_batch_id = oblcp.top_batch_id and
oblc.batch_id = oblcp.batch_id and
oblc.product_item_id = oblcp.inventory_item_id and
oblcp.line_type = 1 and
--
oblc.top_batch_id = gbh1.batch_id and
oblc.batch_id = gbh2.batch_id and
gbh2.organization_id = ood.organization_id and
--
oblcp.organization_id = msiv1.organization_id and
oblcp.inventory_item_id = msiv1.inventory_item_id and
oblc.organization_id = msiv2.organization_id and
oblc.inventory_item_id = msiv2.inventory_item_id and
--
oblc.line_type = -1 and
1=1
order by
gbh1.batch_no,
oblc.step_level,
gbh2.batch_no,
oblc.sort_order
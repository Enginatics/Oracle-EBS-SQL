/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: OPM Batch Lot Cost Trends
-- Description: OPM Batch Lot Costing Trends Report

This report shows the Batch Lot Costs for the specified Organization and Product over a specified date range.

The report shows the Lot Cost for the batch product and explodes the batch to display all the lowest level ingredient lot costs involved in producing the batch.

Where an ingredient is sourced from another (child) batch, the (child) batch ingredient quantities are apportioned based on the actual usage of the ingredient in the batch consuming that ingredient.   

By default, intermediate ingredients are not displayed in the report, so as not to overstate the ingredient lot costs. To override this default behaviour set the ‘Show Intermediate Ingredients’ report parameter to Yes

The report allows the user to pull in several additional data points to allow further analysis of data based on the customer specific configuration. Specifically, for the both the batch product (same for all lines in the batch) and for the batch ingredients (are specific to each line in the batch), the following additional data can be pulled into the report.

- Item Catalog Descriptive Elements for a specific Item Catalog Group
- Item Category Segments for a specific Item Category Set
- Item Descriptive Flexfield Attributes

-- Excel Examle Output: https://www.enginatics.com/example/opm-batch-lot-cost-trends/
-- Library Link: https://www.enginatics.com/reports/opm-batch-lot-cost-trends/
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
gbh1.batch_no,
(select gfc.formula_class_desc from fm_form_mst ffm,gmd_formula_class gfc where ffm.formula_class = gfc.formula_class and ffm.formula_id = gbh1.formula_id) batch_type,
gbh1.actual_cmplt_date batch_completion_date,
(select gllv.currency_code from gl_ledger_le_v gllv where gllv.ledger_id = ood.set_of_books_id) currency_code,
-- product
msiv1.concatenated_segments product,
msiv1.description product_desc,
xxen_util.meaning(msiv1.item_type,'ITEM_TYPE',3) product_item_type,
case when oblc.step_level = 0 then gmd.plan_qty else null end batch_size,
case when oblc.step_level = 0 then gmd.actual_qty else null end batch_actual_output,
case when oblc.step_level = 0 then round(gmd.actual_qty/gmd.plan_qty*100,2) else null end batch_yield,
case when oblc.step_level = 0 then trunc(trunc(oblc.lot_cost,:p_precision) * oblc.actual_qty,:p_precision) else null end batch_cost,
case when oblc.step_level = 0 then trunc(oblc.lot_cost,:p_precision) else null end batch_unit_cost,
-- ingredients
oblc.step_level "Level",
xxen_util.meaning(oblc.line_type,'GMD_FORMULA_ITEM_TYPE',552) type,
xxen_util.meaning(decode(oblc.intermediate_ingred,'Y','Y',null),'YES_NO',0) intermediate_ingredient,
msiv2.concatenated_segments item,
msiv2.description item_desc,
xxen_util.meaning(msiv2.item_type,'ITEM_TYPE',3) item_type,
-- lot
oblc.lot_number,
trunc(oblc.lot_cost,:p_precision) lot_cost,
trunc(oblc.scaled_lot_qty,:p_precision) lot_quantity,
trunc(trunc(oblc.lot_cost,:p_precision) * trunc(oblc.scaled_lot_qty,:p_precision),:p_precision) lot_extended_cost,
gbh2.batch_no line_batch_no,
oblc.lot_source,
oblc.ingredient_usage_factor,
oblc.dtl_um detail_uom,
oblc.primary_uom_code,
oblc.dtl_prim_uom_conv_rate,
xxen_util.meaning(oblc.uom_conv_error,'YES_NO',0) uom_conv_error,
case when oblc.line_type = 1  then trunc(trunc(oblc.lot_cost,:p_precision) * trunc(oblc.scaled_lot_qty,:p_precision),:p_precision) else null end product_cost,
case when oblc.intermediate_ingred = 'N' and oblc.step_level > 0 then trunc(trunc(oblc.lot_cost,:p_precision) * trunc(oblc.scaled_lot_qty,:p_precision),:p_precision) else null end ingredient_cost,
case when oblc.intermediate_ingred = 'Y' and oblc.step_level > 0 then trunc(trunc(oblc.lot_cost,:p_precision) * trunc(oblc.scaled_lot_qty,:p_precision),:p_precision) else null end intemediate_ingredient_cost,
--
&lp_prod_category_segments
&lp_prod_catalog_elements
&lp_prod_item_dff
&lp_ingred_category_segments
&lp_ingred_catalog_elements
&lp_ingred_item_dff
--
oblc.sort_order,
oblc.top_batch_id,
oblc.batch_id,
oblc.material_detail_id
from
opm_batch_lot_costs oblc,
gme_batch_header gbh1,
gme_batch_header gbh2,
gme_material_details gmd,
org_organization_definitions ood,
mtl_system_items_vl msiv1,
mtl_system_items_vl msiv2
where
oblc.top_batch_id = gbh1.batch_id and
oblc.top_batch_id = gmd.batch_id and
oblc.top_item_id = gmd.inventory_item_id and
gmd.line_type = 1 and
oblc.batch_id = gbh2.batch_id and
gbh1.organization_id = ood.organization_id and
oblc.organization_id = msiv1.organization_id and
oblc.top_item_id = msiv1.inventory_item_id and
oblc.organization_id = msiv2.organization_id and
oblc.inventory_item_id = msiv2.inventory_item_id and
--
-- only the top batch product line to be selected
(oblc.step_level = 0 or oblc.line_type = -1) and
--
(:p_show_interm_ingred = 'Y' or oblc.intermediate_ingred = 'N') and
1=1
order by
gbh1.batch_no,
oblc.sort_order
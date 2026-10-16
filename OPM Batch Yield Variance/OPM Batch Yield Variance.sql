/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: OPM Batch Yield Variance
-- Description: Oracle Process Manufacturing (OPM) batch yield variance: compares planned versus actual product and by-product output quantities against total batch input, reporting quantity variance, variance percentage and planned/actual yield percentage - the key production yield KPI for completed batches.
-- Excel Example Output: https://www.enginatics.com/example/opm-batch-yield-variance/
-- Library Link: https://www.enginatics.com/reports/opm-batch-yield-variance/
-- Run Report: https://demo.enginatics.com/

select
ood.organization_code,
gbh.batch_no,
grv.recipe_no,
grv.recipe_version,
xxen_util.meaning(to_char(gbh.batch_status),'GME_BATCH_STATUS',553) batch_status,
gbh.actual_start_date,
gbh.actual_cmplt_date,
decode(gmd.line_type,1,'Product',2,'By-Product') output_type,
msiv.concatenated_segments product_item,
msiv.description product_description,
gmd.plan_qty planned_qty,
gmd.actual_qty actual_qty,
gmd.dtl_um uom,
gmd.actual_qty-gmd.plan_qty qty_variance,
round((gmd.actual_qty-gmd.plan_qty)/nullif(gmd.plan_qty,0)*100,2) qty_variance_pct,
i.planned_input_qty,
i.actual_input_qty,
round(gmd.plan_qty/nullif(i.planned_input_qty,0)*100,2) planned_yield_pct,
round(gmd.actual_qty/nullif(i.actual_input_qty,0)*100,2) actual_yield_pct
from
gme_batch_header gbh,
gme_material_details gmd,
mtl_system_items_vl msiv,
org_organization_definitions ood,
gmd_recipe_validity_rules grvr,
gmd_recipes_vl grv,
(
select
gmd2.batch_id,
sum(case when gmd2.line_type=-1 then gmd2.plan_qty end) planned_input_qty,
sum(case when gmd2.line_type=-1 then gmd2.actual_qty end) actual_input_qty
from
gme_material_details gmd2
group by
gmd2.batch_id
) i
where
1=1 and
gbh.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
gbh.batch_id=gmd.batch_id and
gmd.line_type in (1,2) and
gmd.inventory_item_id=msiv.inventory_item_id and
gmd.organization_id=msiv.organization_id and
gbh.organization_id=ood.organization_id and
gbh.batch_id=i.batch_id and
gbh.recipe_validity_rule_id=grvr.recipe_validity_rule_id(+) and
grvr.recipe_id=grv.recipe_id(+)
order by
ood.organization_code,
gbh.batch_no,
msiv.concatenated_segments

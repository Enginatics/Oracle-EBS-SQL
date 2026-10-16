/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: OPM Batch Details and Status Summary
-- Description: Oracle Process Manufacturing (OPM) batch details and status summary: one row per production batch showing batch status and type, recipe, primary product and planned/actual output quantity, planned versus actual start and completion dates, and whether the batch completed on time. Set a pending/released status with plan-date filters for a planned-production view.
-- Excel Example Output: https://www.enginatics.com/example/opm-batch-details-and-status-summary/
-- Library Link: https://www.enginatics.com/reports/opm-batch-details-and-status-summary/
-- Run Report: https://demo.enginatics.com/

select
ood.organization_code,
gbh.batch_no,
xxen_util.meaning(to_char(gbh.batch_status),'GME_BATCH_STATUS',553) batch_status,
decode(gbh.batch_type,0,'Batch',10,'Firm Planned Order') batch_type,
grv.recipe_no,
grv.recipe_version,
msiv.concatenated_segments product_item,
msiv.description product_description,
p.planned_product_qty,
p.actual_product_qty,
p.product_uom,
gbh.plan_start_date,
gbh.actual_start_date,
gbh.plan_cmplt_date,
gbh.actual_cmplt_date,
xxen_util.yes(case when gbh.actual_cmplt_date<=gbh.plan_cmplt_date then 'Y' end) completed_on_time
from
gme_batch_header gbh,
org_organization_definitions ood,
gmd_recipe_validity_rules grvr,
gmd_recipes_vl grv,
(
select
gmd.batch_id,
max(gmd.inventory_item_id) keep (dense_rank first order by gmd.line_no) product_item_id,
sum(gmd.plan_qty) planned_product_qty,
sum(gmd.actual_qty) actual_product_qty,
max(gmd.dtl_um) keep (dense_rank first order by gmd.line_no) product_uom
from
gme_material_details gmd
where
gmd.line_type=1
group by
gmd.batch_id
) p,
mtl_system_items_vl msiv
where
1=1 and
gbh.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
gbh.batch_id=p.batch_id(+) and
p.product_item_id=msiv.inventory_item_id(+) and
gbh.organization_id=msiv.organization_id(+) and
gbh.organization_id=ood.organization_id and
gbh.recipe_validity_rule_id=grvr.recipe_validity_rule_id(+) and
grvr.recipe_id=grv.recipe_id(+)
order by
ood.organization_code,
gbh.batch_no

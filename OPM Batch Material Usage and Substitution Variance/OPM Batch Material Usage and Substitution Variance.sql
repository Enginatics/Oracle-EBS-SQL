/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: OPM Batch Material Usage and Substitution Variance
-- Description: Oracle Process Manufacturing (OPM) batch material usage and substitution variance: per-ingredient planned versus actual consumption per production batch, with usage variance, variance percentage, remaining quantity, scrap factor and a substitution indicator. Exposes over/under-consumption and material substitutions at the batch line level.
-- Excel Example Output: https://www.enginatics.com/example/opm-batch-material-usage-and-substitution-variance/
-- Library Link: https://www.enginatics.com/reports/opm-batch-material-usage-and-substitution-variance/
-- Run Report: https://demo.enginatics.com/

select
ood.organization_code,
gbh.batch_no,
xxen_util.meaning(to_char(gbh.batch_status),'GME_BATCH_STATUS',553) batch_status,
gbh.actual_cmplt_date,
msiv.concatenated_segments item,
msiv.description item_description,
gmd.plan_qty,
gmd.actual_qty,
gmd.dtl_um uom,
gmd.actual_qty-gmd.plan_qty usage_variance,
round((gmd.actual_qty-gmd.plan_qty)/nullif(gmd.plan_qty,0)*100,2) usage_variance_pct,
gmd.plan_qty-gmd.actual_qty remaining_qty,
gmd.scrap_factor,
gmd.original_qty,
xxen_util.yes(case when gmd.original_qty is not null and gmd.original_qty<>gmd.plan_qty then 'Y' end) substitution
from
gme_material_details gmd,
gme_batch_header gbh,
mtl_system_items_vl msiv,
org_organization_definitions ood
where
1=1 and
gmd.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
gmd.batch_id=gbh.batch_id and
gmd.line_type=-1 and
gmd.inventory_item_id=msiv.inventory_item_id and
gmd.organization_id=msiv.organization_id and
gmd.organization_id=ood.organization_id
order by
ood.organization_code,
gbh.batch_no,
msiv.concatenated_segments

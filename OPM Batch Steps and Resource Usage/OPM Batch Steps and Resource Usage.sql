/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: OPM Batch Steps and Resource Usage
-- Description: Oracle Process Manufacturing (OPM) batch steps and resource usage: each production batch routing step with its status, planned versus actual step quantity and dates, and the planned versus actual usage, usage variance, count and UOM of each resource (machine / labor) on the step. Supports batch execution review and resource-efficiency analysis.
-- Excel Examle Output: https://www.enginatics.com/example/opm-batch-steps-and-resource-usage/
-- Library Link: https://www.enginatics.com/reports/opm-batch-steps-and-resource-usage/
-- Run Report: https://demo.enginatics.com/

select
ood.organization_code,
gbh.batch_no,
gbs.batchstep_no,
xxen_util.meaning(to_char(gbs.step_status),'GME_STEP_STATUS',553) step_status,
gbs.plan_step_qty,
gbs.actual_step_qty,
gbsr.resources resource_code,
gbsr.plan_rsrc_usage,
gbsr.actual_rsrc_usage,
round(gbsr.actual_rsrc_usage-gbsr.plan_rsrc_usage,6) usage_variance,
gbsr.usage_um,
gbsr.plan_rsrc_count,
gbsr.actual_rsrc_count,
gbs.plan_start_date,
gbs.actual_start_date,
gbs.plan_cmplt_date,
gbs.actual_cmplt_date
from
gme_batch_steps gbs,
gme_batch_step_resources gbsr,
gme_batch_header gbh,
org_organization_definitions ood
where
1=1 and
gbh.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
gbs.batch_id=gbh.batch_id and
gbs.batchstep_id=gbsr.batchstep_id(+) and
gbh.organization_id=ood.organization_id
order by
ood.organization_code,
gbh.batch_no,
gbs.batchstep_no,
gbsr.resources
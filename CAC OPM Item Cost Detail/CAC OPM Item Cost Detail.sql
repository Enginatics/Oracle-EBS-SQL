/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC OPM Item Cost Detail
-- Description: Oracle Process Manufacturing (OPM) item cost detail: the costed value of each item broken out by cost component class (material, labor, burden, overhead) and cost analysis code, per cost calendar, period and method. Answers what makes up an item's OPM cost.
-- Excel Example Output: https://www.enginatics.com/example/cac-opm-item-cost-detail/
-- Library Link: https://www.enginatics.com/reports/cac-opm-item-cost-detail/
-- Run Report: https://demo.enginatics.com/

select
ood.organization_code,
msiv.concatenated_segments item,
msiv.description item_description,
ccd.calendar_code,
gps.period_code,
cmm.cost_mthd_code cost_method,
cmm.cost_mthd_desc cost_method_desc,
ccmv.cost_cmpntcls_code cost_component_class,
ccmv.cost_cmpntcls_desc cost_component_class_desc,
ccd.cost_analysis_code,
ccd.cmpnt_cost component_cost,
ccd.total_qty
from
cm_cmpt_dtl ccd,
mtl_system_items_vl msiv,
cm_cmpt_mst_vl ccmv,
cm_mthd_mst cmm,
gmf_period_statuses gps,
org_organization_definitions ood
where
1=1 and
ccd.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
ccd.inventory_item_id=msiv.inventory_item_id and
ccd.organization_id=msiv.organization_id and
ccd.cost_cmpntcls_id=ccmv.cost_cmpntcls_id and
ccd.cost_type_id=cmm.cost_type_id and
ccd.period_id=gps.period_id(+) and
ccd.organization_id=ood.organization_id and
nvl(ccd.delete_mark,0)=0
order by
ood.organization_code,
msiv.concatenated_segments,
ccd.calendar_code,
gps.period_code,
ccmv.cost_cmpntcls_code

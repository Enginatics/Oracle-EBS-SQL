/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Resource Efficiency
-- Description: Report your resource efficiency variances for your open and closed WIP jobs. Resource efficiency measures the WIP routing requirements against the actual applied resources. This report replicates the Resource Section for the Oracle Discrete Job Value Report - Standard Costing.
-- If you leave the Cost Type parameter blank the report uses either your Costing Method Cost Type (Standard) or your Costing Method "Avg Rates" Cost Type (Average, FIFO, LIFO) for your resource rates. If the WIP job is open the Report Type column displays "Valuation", as this WIP job and potential material usage variance is still in your WIP inventory balances. If the job has been closed during the reporting period, the Report Type column displays "Variance", as this WIP job was written off on a WIP Job Close Variance transaction during the reporting period. Closed, Pending Close, Cancelled, Complete and Complete No Charges WIP job statuses use the completion quantities. All other WIP jobs use the parameter "Use Completion Quantities" to determine if completion or planned quantities are used for requirements. If you choose Yes for including scrap, this report will automatically include the scrapped quantities as part of the resource quantity requirements. And this report automatically includes WIP jobs which were either open during the reported accounting period or if closed, were closed doing the reporting period.
-- Parameters:
-- =========
-- Report Option: You can choose to limit the report size with this parameter. The choices are: Open jobs, All jobs or Closed jobs. (mandatory)
-- Period Name: Enter the PeriodName you wish to report for WIP Jobs (mandatory)
-- Cost Type: Enter the resource rates cost type. If left blank, the report uses the Costing Method rates cost type. (optional)
-- Include Scrap Quantities: Include scrap for quantity requirements. (mandatory)
-- Include Unreleased Jobs: Include jobs which have not been released and are not started. (mandatory)
-- Use Completion Quantities: For Released jobs, use the completion quantities for resource variance calculations else use the planned start quantities (mandatory).
-- Category Set 1: Choose any item category to report. Does not limit what is reported.
-- Category Set 2: Choose any item category to report. Does not limit what is reported.
-- Class Code: Specific WIP class code to report (optional).
-- Job Status: Specific WIP job status to report (optional).
-- WIP Job: Specific WIP job number to report (optional).
-- Resource Code: Specific resource code to report (optional).
-- Outside Processing Item: Specific outside processing component to report (optional).
-- Assembly Number: Specific assembly to report (optional).
-- Organization Code: Specific inventory organization you wish to report (optional)
-- Operating Unit: Specific operating unit you wish to report (optional)
-- Ledger: Specific ledger you wish to report (optional)
-- / +=============================================================================+
-- -- | Copyright 2009 - 2021 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged |
-- -- +=============================================================================+
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 28 Jan 2010 Douglas Volz Initial Coding
-- -- | 1.25 12 Dec 2021 Douglas Volz Added auto-charge, std rate and PO Currency Code columns.
-- -- | 1.26 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-wip-resource-efficiency/
-- Library Link: https://www.enginatics.com/reports/cac-wip-resource-efficiency/
-- Run Report: https://demo.enginatics.com/

select
x.report_type,
x.ledger,
x.operating_unit,
x.organization_code org_code,
x.period_name,
&segment_columns
x.class_code wip_class,
xxen_util.meaning(x.class_type,'WIP_CLASS_TYPE',700) class_type,
we.wip_entity_name wip_job,
(select ppa.segment1 from pa_projects_all ppa where x.project_id=ppa.project_id) project_number,
xxen_util.meaning(x.status_type,'WIP_JOB_STATUS',700) job_status,
x.creation_date,
x.scheduled_start_date,
x.date_released,
x.date_completed,
x.date_closed,
x.last_update_date,
msiv.primary_uom_code uom_code,
msiv.std_lot_size item_std_lot_size,
x.cost_type lot_size_cost_type,
x.costing_lot_size,
x.start_quantity,
x.quantity_completed assembly_quantity_completed,
x.quantity_scrapped assembly_quantity_scrapped,
x.quantity_completed+x.quantity_scrapped total_assembly_quantity,
msiv.concatenated_segments assembly,
msiv.description assembly_description,
xxen_util.yes(nvl2(x.last_rollup_date,'Y',null)) rolled_up,
x.last_rollup_date last_cost_rollup,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
msiv.inventory_item_status_code item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
&category_columns
x.lot_number,
msiv_osp.concatenated_segments outside_processing_item,
msiv_osp.description osp_description,
pha.segment1 po_number,
pla.line_num line_number,
pra.release_num po_release,
bd.department_code department,
x.operation_seq_num operation_seq_number,
bso.operation_code,
x.resource_seq_num resource_seq_number,
x.resource_code,
x.resource_description,
xxen_util.meaning(x.transaction_type,'WIP_TRANSACTION_TYPE',700) transaction_type_name,
xxen_util.meaning(x.autocharge_type,'BOM_AUTOCHARGE_TYPE',700) auto_charge,
xxen_util.yes(decode(x.standard_rate_flag,1,'Y')) std_rate,
xxen_util.meaning(x.basis_type,'CST_BASIS',700) basis_type,
pha.currency_code po_currency_code,
nvl(plla.price_override,pla.unit_price) po_unit_price,
nvl2(x.resource_rate,x.cost_type,null) resource_cost_type,
nvl(xxen_util.meaning(x.cost_element_id,'CST_COST_CODE_TYPE',700),'No Cost') cost_element_type,
x.currency_code,
nvl(x.resource_rate,0) resource_rate,
x.resource_uom_code,
x.usage_rate_or_amount quantity_per_assembly,
x.total_req_quantity total_required_quantity,
x.applied_resource_units total_units_applied,
round(x.applied_resource_units-x.total_req_quantity,6) quantity_variance,
x.total_req_quantity*nvl(x.resource_rate,0) standard_resource_value,
round(x.applied_resource_value,2) applied_resource_value,
round(x.applied_resource_value-x.total_req_quantity*nvl(x.resource_rate,0),2) resource_efficiency_variance
from
(
select
j.*,
wo.department_id,
wo.standard_operation_id,
wor.operation_seq_num,
wor.resource_seq_num,
wor.resource_id,
br.resource_code,
br.description resource_description,
br.unit_of_measure resource_uom_code,
br.purchase_item_id,
br.cost_element_id,
nvl(cic.lot_size,1) costing_lot_size,
decode(cic.based_on_rollup_flag,1,(select max(cicd.creation_date) from cst_item_cost_details cicd where cic.organization_id=cicd.organization_id and cic.inventory_item_id=cicd.inventory_item_id and cic.cost_type_id=cicd.cost_type_id and cicd.rollup_source_type=3 and cicd.attribute15 is null)) last_rollup_date,
wor.basis_type,
wor.autocharge_type,
wor.standard_rate_flag,
nvl(wor.usage_rate_or_amount,0) usage_rate_or_amount,
nvl(round(decode(wor.basis_type,2,wor.usage_rate_or_amount,wor.usage_rate_or_amount*
case
when j.status_type in (4,5,7,12,14,15) or nvl(:p_use_completion_qtys,'N')='N' then j.start_quantity-decode(:p_include_scrap,'Y',nvl(wo.cumulative_scrap_quantity,0),0)
when :p_use_completion_qtys='Y' then decode(j.class_type,5,j.quantity_completed,j.quantity_completed+decode(:p_include_scrap,'Y',j.quantity_scrapped,0))
end),6),0) total_req_quantity,
nvl(wor.applied_resource_units,0) applied_resource_units,
nvl(wor.applied_resource_value,0) applied_resource_value,
(
select
max(crc.resource_rate) keep (dense_rank first order by decode(crc.cost_type_id,j.rate_cost_type_id,1,2))
from
cst_resource_costs crc
where
wor.organization_id=crc.organization_id and
wor.resource_id=crc.resource_id and
crc.cost_type_id in (j.rate_cost_type_id,j.default_rate_cost_type_id)
) resource_rate,
(select max(pda.po_distribution_id) from po_distributions_all pda where wor.wip_entity_id=pda.wip_entity_id and wor.operation_seq_num=pda.wip_operation_seq_num and wor.resource_seq_num=pda.wip_resource_seq_num and wor.resource_id=pda.bom_resource_id and wor.organization_id=pda.destination_organization_id) po_distribution_id,
(select min(wt.transaction_type) from wip_transactions wt where wor.wip_entity_id=wt.wip_entity_id and wor.operation_seq_num=wt.operation_seq_num and wor.resource_seq_num=wt.resource_seq_num and wor.resource_id=wt.resource_id and wt.transaction_date<j.schedule_close_date+1) transaction_type
from
(
select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code,
gl.currency_code,
oap.period_name,
oap.schedule_close_date,
case when wdj.date_closed>=oap.period_start_date and wdj.date_closed<oap.schedule_close_date+1 then 'Variance' else 'Valuation' end report_type,
wdj.organization_id,
wdj.wip_entity_id,
wdj.class_code,
wac.class_type,
wdj.status_type,
wdj.project_id,
wdj.primary_item_id,
wdj.lot_number,
wdj.creation_date,
wdj.scheduled_start_date,
wdj.date_released,
wdj.date_completed,
wdj.date_closed,
wdj.last_update_date,
wdj.start_quantity,
wdj.resource_account,
wdj.outside_processing_account,
wdj.overhead_account,
wdj.quantity_completed-nvl((select sum(mmt.primary_quantity) from mtl_material_transactions mmt where wdj.wip_entity_id=mmt.transaction_source_id and mmt.transaction_source_type_id=5 and wdj.organization_id=mmt.organization_id and mmt.transaction_type_id in (17,44) and mmt.transaction_date>=oap.schedule_close_date+1),0) quantity_completed,
wdj.quantity_scrapped-nvl((select sum(mmt.primary_quantity) from mtl_material_transactions mmt where wdj.wip_entity_id=mmt.transaction_source_id and mmt.transaction_source_type_id=5 and wdj.organization_id=mmt.organization_id and mmt.transaction_type_id in (90,91) and mmt.transaction_date>=oap.schedule_close_date+1),0) quantity_scrapped,
cct.cost_type,
nvl((select cic.cost_type_id from cst_item_costs cic where cct.cost_type_id=cic.cost_type_id and wdj.organization_id=cic.organization_id and wdj.primary_item_id=cic.inventory_item_id),mp.primary_cost_method) item_cost_type_id,
decode(cct.cost_type_id,2,mp.avg_rates_cost_type_id,5,mp.avg_rates_cost_type_id,6,mp.avg_rates_cost_type_id,cct.cost_type_id) rate_cost_type_id,
decode(mp.primary_cost_method,1,1,2,mp.avg_rates_cost_type_id,5,mp.avg_rates_cost_type_id,6,mp.avg_rates_cost_type_id) default_rate_cost_type_id,
(select 'Y' from wip_transactions wt where wdj.wip_entity_id=wt.wip_entity_id and rownum=1) transactions_exist
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
cst_cost_types cct,
org_acct_periods oap,
wip_discrete_jobs wdj,
wip_accounting_classes wac
where
1=1 and
2=2 and
3=3 and
4=4 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
cct.cost_type_id=nvl((select cct2.cost_type_id from cst_cost_types cct2 where cct2.cost_type=:p_cost_type),mp.primary_cost_method) and
mp.organization_id=oap.organization_id and
mp.organization_id=wdj.organization_id and
wdj.class_code=wac.class_code and
wdj.organization_id=wac.organization_id and
wac.class_type in (1,3,5) and
(
wdj.date_closed>=oap.period_start_date and wdj.date_closed<oap.schedule_close_date+1 and :p_report_option in ('Closed jobs','All jobs') or
(wdj.date_closed is null or wdj.date_closed>=oap.schedule_close_date+1) and :p_report_option in ('Open jobs','All jobs') and
(
exists (select null from wip_transactions wt where wdj.wip_entity_id=wt.wip_entity_id and wt.resource_id is not null and wt.transaction_date<oap.schedule_close_date+1) or
wdj.creation_date<oap.schedule_close_date+1 and not exists (select null from wip_transactions wt where wdj.wip_entity_id=wt.wip_entity_id and wt.resource_id is not null)
)
)
) j,
wip_operations wo,
wip_operation_resources wor,
bom_resources br,
cst_item_costs cic
where
9=9 and
j.wip_entity_id=wo.wip_entity_id and
wo.wip_entity_id=wor.wip_entity_id and
wo.operation_seq_num=wor.operation_seq_num and
wor.resource_id=br.resource_id and
j.organization_id=cic.organization_id and
j.primary_item_id=cic.inventory_item_id and
j.item_cost_type_id=cic.cost_type_id
) x,
wip_entities we,
mtl_system_items_vl msiv,
bom_departments bd,
bom_standard_operations bso,
mtl_system_items_vl msiv_osp,
po_distributions_all pda,
po_headers_all pha,
po_lines_all pla,
po_line_locations_all plla,
po_releases_all pra,
gl_code_combinations gcc
where
5=5 and
(x.transaction_type is not null or x.transactions_exist is null) and
(x.purchase_item_id is null or x.po_distribution_id is not null) and
x.wip_entity_id=we.wip_entity_id and
x.organization_id=msiv.organization_id and
x.primary_item_id=msiv.inventory_item_id and
x.department_id=bd.department_id and
x.standard_operation_id=bso.standard_operation_id(+) and
nvl(bso.operation_type,1)=1 and
bso.line_id is null and
x.organization_id=msiv_osp.organization_id(+) and
x.purchase_item_id=msiv_osp.inventory_item_id(+) and
x.po_distribution_id=pda.po_distribution_id(+) and
pda.po_header_id=pha.po_header_id(+) and
pda.po_line_id=pla.po_line_id(+) and
pda.line_location_id=plla.line_location_id(+) and
pda.po_release_id=pra.po_release_id(+) and
decode(x.cost_element_id,3,x.resource_account,4,x.outside_processing_account,5,x.overhead_account,decode(x.po_distribution_id,null,x.resource_account,x.outside_processing_account))=gcc.code_combination_id(+)
order by
x.report_type,
x.ledger,
x.operating_unit,
x.organization_code,
x.class_code,
we.wip_entity_name,
msiv_osp.concatenated_segments,
pha.segment1,
pla.line_num,
pra.release_num,
x.operation_seq_num,
x.resource_seq_num,
x.resource_code

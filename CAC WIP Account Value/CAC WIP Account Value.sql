/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Account Value
-- Description: Report to show WIP values and all accounts for discrete manufacturing, in summary by inventory, organization, with WIP class, job status, name and other details. This report uses the valuation accounts from each discrete job and reports both jobs which were open during the accounting period as well as jobs closed during the accounting period. You can also run this report for earlier accounting periods and still get the correct amounts and the jobs that were open at that time.
-- Parameters
-- ==========
-- Period Name: the accounting period you wish to report (mandatory).
-- Include Expense WIP: enter Yes to include Expense WIP jobs. Defaults to No.
-- Job Status: enter a specific job status (optional).
-- Category Sets 1 - 3: any item category you wish (optional).
-- Item Number: specific item you wish to report (optional)
-- Organization Code: specific inventory organization to report (optional)
-- Operating Unit: specific operating unit (optional)
-- Ledger: specific ledger (optional)
-- / +=============================================================================+
-- -- | Copyright 2009 - 2025 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- | 1.27 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 29 Oct 2009 Douglas Volz Based on XXXWIPVALUEREPT.sql
-- -- | 1.13 22 May 2017 Douglas Volz Added cost item category
-- -- | 1.14 10 Jul 2017 Douglas Volz Added column to indicate a WIP job was converted
-- -- | from the Legacy Systems
-- -- | 1.15 26 Jul 2018 Douglas Volz Modified for chart of accounts and for categories
-- -- | 1.16 04 Dec 2018 Douglas Volz Modified for chart of accounts and removed converted
-- -- | job column. Fixed outer join for completion subinventories
-- -- | 1.17 19 Jun 2019 Douglas Volz Changed to G/L short name, for brevity, added
-- -- | inventory category. Added Date Released column.
-- -- | 1.17 19 Jun 2019 Douglas Volz Changed to G/L short name, for brevity, added
-- -- | inventory category. Added Date Released column.
-- -- | 1.18 24 Oct 2019 Douglas Volz Added aging dates, creation date and date released columns
-- -- | 1.19 06 Jan 2020 Douglas Volz Added Org Code and Operating Unit parameters.
-- -- | 1.20 24 Apr 2020 Douglas Volz Changed to multi-language views for the item
-- -- | master, item categories and operating units.
-- -- | And put the WIP Costs In, WIP Costs Out, WIP
-- -- | Relief and WIP Value as the last report columns.
-- -- | Add Project Number and Project Name columns.
-- -- | 1.21 17 Aug 2020 Douglas Volz Change categories to use categoryconcatsegs not segment1
-- -- | 1.22 09 Oct 2020 Douglas Volz Added unit of measure column
-- -- | 1.23 13 Mar 2022 Douglas Volz Added WIP job description column.
-- -- | 1.24 27 Feb 2025 Douglas Volz Removed tabs, fixed OU and GL security profiles.
-- -- | 1.25 17 Mar 2025 Douglas Volz WIP performance improvements.
-- -- | 1.26 31 Aug 2025 Douglas Volz Added Job Status parameter.
-- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-wip-account-value/
-- Library Link: https://www.enginatics.com/reports/cac-wip-account-value/
-- Run Report: https://demo.enginatics.com/

select
z.ledger,
z.operating_unit,
z.organization_code org_code,
z.period_name,
gcck.concatenated_segments wip_valuation_account,
&segment_columns
wdj.class_code wip_class,
xxen_util.meaning(wac.class_type,'WIP_CLASS_TYPE',700) class_type,
we.wip_entity_name wip_job,
we.description job_description,
xxen_util.meaning(wdj.status_type,'WIP_JOB_STATUS',700) job_status,
we.creation_date,
wdj.scheduled_start_date schedule_start_date,
wdj.date_released,
wdj.date_completed,
wdj.date_closed,
case
when z.schedule_close_date-we.creation_date<31 then '30 days'
when z.schedule_close_date-we.creation_date<61 then '60 days'
when z.schedule_close_date-we.creation_date<91 then '90 days'
when z.schedule_close_date-we.creation_date<121 then '120 days'
when z.schedule_close_date-we.creation_date<151 then '150 days'
when z.schedule_close_date-we.creation_date<181 then '180 days'
else 'Over 180 days'
end aged_creation_date,
case
when nvl(wdj.date_completed,z.schedule_close_date)-nvl(wdj.date_released,nvl(wdj.date_completed,sysdate))<31 then '30 days'
when nvl(wdj.date_completed,z.schedule_close_date)-nvl(wdj.date_released,nvl(wdj.date_completed,sysdate))<61 then '60 days'
when nvl(wdj.date_completed,z.schedule_close_date)-nvl(wdj.date_released,nvl(wdj.date_completed,sysdate))<91 then '90 days'
when nvl(wdj.date_completed,z.schedule_close_date)-nvl(wdj.date_released,nvl(wdj.date_completed,sysdate))<121 then '120 days'
when nvl(wdj.date_completed,z.schedule_close_date)-nvl(wdj.date_released,nvl(wdj.date_completed,sysdate))<151 then '150 days'
when nvl(wdj.date_completed,z.schedule_close_date)-nvl(wdj.date_released,nvl(wdj.date_completed,sysdate))<181 then '180 days'
else 'Over 180 days'
end aged_compln_vs_release_date,
case
when nvl(wdj.date_completed,z.schedule_close_date)-we.creation_date<31 then '30 days'
when nvl(wdj.date_completed,z.schedule_close_date)-we.creation_date<61 then '60 days'
when nvl(wdj.date_completed,z.schedule_close_date)-we.creation_date<91 then '90 days'
when nvl(wdj.date_completed,z.schedule_close_date)-we.creation_date<121 then '120 days'
when nvl(wdj.date_completed,z.schedule_close_date)-we.creation_date<151 then '150 days'
when nvl(wdj.date_completed,z.schedule_close_date)-we.creation_date<181 then '180 days'
else 'Over 180 days'
end aged_compln_vs_creation_date,
msiv.primary_uom_code uom_code,
wdj.start_quantity,
wdj.quantity_completed,
wdj.quantity_scrapped,
wdj.quantity_completed+wdj.quantity_scrapped total_quantity,
wdj.completion_subinventory,
(select msi.description from mtl_secondary_inventories msi where wdj.organization_id=msi.organization_id and wdj.completion_subinventory=msi.secondary_inventory_name) subinventory_description,
msiv.concatenated_segments item_number,
msiv.description item_description,
&category_columns
ppa.segment1 project_number,
ppa.name project_name,
wdj.lot_number,
z.currency_code,
z.wip_material_value,
z.wip_material_overhead_value,
z.wip_resource_value,
z.wip_outside_processing_value,
z.wip_overhead_value,
z.wip_scrap_value,
z.wip_costs_in,
z.wip_costs_out,
z.wip_relief,
z.wip_value
from
(
select
y.ledger,
y.operating_unit,
y.organization_code,
y.period_name,
y.schedule_close_date,
y.currency_code,
y.wip_entity_id,
decode(rowgen.column_value,1,y.material_account,2,y.material_overhead_account,3,y.resource_account,4,y.outside_processing_account,5,y.overhead_account,6,nvl(y.est_scrap_account,y.material_account)) code_combination_id,
sum(decode(rowgen.column_value,1,y.matl_value,0)) wip_material_value,
sum(decode(rowgen.column_value,2,y.moh_value,0)) wip_material_overhead_value,
sum(decode(rowgen.column_value,3,y.res_value,0)) wip_resource_value,
sum(decode(rowgen.column_value,4,y.osp_value,0)) wip_outside_processing_value,
sum(decode(rowgen.column_value,5,y.ovhd_value,0)) wip_overhead_value,
sum(decode(rowgen.column_value,6,y.scrap_value,0)) wip_scrap_value,
sum(decode(rowgen.column_value,1,y.matl_costs_in,2,y.moh_costs_in,3,y.res_costs_in,4,y.osp_costs_in,5,y.ovhd_costs_in,6,y.scrap_costs_in)) wip_costs_in,
sum(decode(rowgen.column_value,1,y.matl_costs_out,2,y.moh_costs_out,3,y.res_costs_out,4,y.osp_costs_out,5,y.ovhd_costs_out,6,y.scrap_costs_out)) wip_costs_out,
sum(decode(rowgen.column_value,1,y.matl_relief,2,y.moh_relief,3,y.res_relief,4,y.osp_relief,5,y.ovhd_relief,6,y.scrap_relief)) wip_relief,
sum(decode(rowgen.column_value,1,y.matl_value,2,y.moh_value,3,y.res_value,4,y.osp_value,5,y.ovhd_value,6,y.scrap_value)) wip_value
from
(
select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code,
oap.period_name,
oap.schedule_close_date,
gl.currency_code,
wdj.wip_entity_id,
wdj.material_account,
wdj.material_overhead_account,
wdj.resource_account,
wdj.outside_processing_account,
wdj.overhead_account,
wdj.est_scrap_account,
sum(nvl(wpb.pl_material_in,0)-nvl(wpb.tl_material_out,0)-nvl(wpb.pl_material_out,0)-nvl(wpb.tl_material_var,0)-nvl(wpb.pl_material_var,0)) matl_value,
sum(nvl(wpb.pl_material_overhead_in,0)-nvl(wpb.tl_material_overhead_out,0)-nvl(wpb.pl_material_overhead_out,0)-nvl(wpb.tl_material_overhead_var,0)-nvl(wpb.pl_material_overhead_var,0)) moh_value,
sum(nvl(wpb.tl_resource_in,0)+nvl(wpb.pl_resource_in,0)-nvl(wpb.tl_resource_out,0)-nvl(wpb.pl_resource_out,0)-nvl(wpb.tl_resource_var,0)-nvl(wpb.pl_resource_var,0)) res_value,
sum(nvl(wpb.tl_outside_processing_in,0)+nvl(wpb.pl_outside_processing_in,0)-nvl(wpb.tl_outside_processing_out,0)-nvl(wpb.pl_outside_processing_out,0)-nvl(wpb.tl_outside_processing_var,0)-nvl(wpb.pl_outside_processing_var,0)) osp_value,
sum(nvl(wpb.tl_overhead_in,0)+nvl(wpb.pl_overhead_in,0)-nvl(wpb.tl_overhead_out,0)-nvl(wpb.pl_overhead_out,0)-nvl(wpb.tl_overhead_var,0)-nvl(wpb.pl_overhead_var,0)) ovhd_value,
sum(nvl(wpb.tl_scrap_in,0)-nvl(wpb.tl_scrap_out,0)-nvl(wpb.tl_scrap_var,0)) scrap_value,
sum(nvl(wpb.pl_material_in,0)) matl_costs_in,
sum(nvl(wpb.pl_material_overhead_in,0)) moh_costs_in,
sum(nvl(wpb.tl_resource_in,0)+nvl(wpb.pl_resource_in,0)) res_costs_in,
sum(nvl(wpb.tl_outside_processing_in,0)+nvl(wpb.pl_outside_processing_in,0)) osp_costs_in,
sum(nvl(wpb.tl_overhead_in,0)+nvl(wpb.pl_overhead_in,0)) ovhd_costs_in,
sum(nvl(wpb.tl_scrap_in,0)) scrap_costs_in,
sum(nvl(wpb.tl_material_out,0)+nvl(wpb.pl_material_out,0)) matl_costs_out,
sum(nvl(wpb.tl_material_overhead_out,0)+nvl(wpb.pl_material_overhead_out,0)) moh_costs_out,
sum(nvl(wpb.tl_resource_out,0)+nvl(wpb.pl_resource_out,0)) res_costs_out,
sum(nvl(wpb.tl_outside_processing_out,0)+nvl(wpb.pl_outside_processing_out,0)) osp_costs_out,
sum(nvl(wpb.tl_overhead_out,0)+nvl(wpb.pl_overhead_out,0)) ovhd_costs_out,
sum(nvl(wpb.tl_scrap_out,0)) scrap_costs_out,
sum(nvl(wpb.tl_material_var,0)+nvl(wpb.pl_material_var,0)) matl_relief,
sum(nvl(wpb.tl_material_overhead_var,0)+nvl(wpb.pl_material_overhead_var,0)) moh_relief,
sum(nvl(wpb.tl_resource_var,0)+nvl(wpb.pl_resource_var,0)) res_relief,
sum(nvl(wpb.tl_outside_processing_var,0)+nvl(wpb.pl_outside_processing_var,0)) osp_relief,
sum(nvl(wpb.tl_overhead_var,0)+nvl(wpb.pl_overhead_var,0)) ovhd_relief,
sum(nvl(wpb.tl_scrap_var,0)) scrap_relief
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
org_acct_periods oap,
wip_discrete_jobs wdj,
wip_accounting_classes wac,
wip_period_balances wpb
where
1=1 and
2=2 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=oap.organization_id and
oap.organization_id=wdj.organization_id and
nvl(trunc(wdj.date_closed),oap.period_start_date)>=oap.period_start_date and
wdj.organization_id=wac.organization_id and
wdj.class_code=wac.class_code and
(wac.class_type not in (4,6) or upper(:p_include_expense_wip)='Y') and
wdj.wip_entity_id=wpb.wip_entity_id and
oap.organization_id=wpb.organization_id and
oap.acct_period_id>=wpb.acct_period_id
group by
nvl(gl.short_name,gl.name),
haouv_ou.name,
mp.organization_code,
oap.period_name,
oap.schedule_close_date,
gl.currency_code,
wdj.wip_entity_id,
wdj.material_account,
wdj.material_overhead_account,
wdj.resource_account,
wdj.outside_processing_account,
wdj.overhead_account,
wdj.est_scrap_account
) y,
table(xxen_util.rowgen(6)) rowgen
group by
y.ledger,
y.operating_unit,
y.organization_code,
y.period_name,
y.schedule_close_date,
y.currency_code,
y.wip_entity_id,
decode(rowgen.column_value,1,y.material_account,2,y.material_overhead_account,3,y.resource_account,4,y.outside_processing_account,5,y.overhead_account,6,nvl(y.est_scrap_account,y.material_account))
) z,
wip_discrete_jobs wdj,
wip_entities we,
wip_accounting_classes wac,
mtl_system_items_vl msiv,
pa_projects_all ppa,
gl_code_combinations_kfv gcck
where
3=3 and
z.wip_entity_id=wdj.wip_entity_id and
wdj.wip_entity_id=we.wip_entity_id and
wdj.organization_id=wac.organization_id and
wdj.class_code=wac.class_code and
wdj.organization_id=msiv.organization_id and
wdj.primary_item_id=msiv.inventory_item_id and
wdj.project_id=ppa.project_id(+) and
z.code_combination_id=gcck.code_combination_id(+)
order by
z.ledger,
z.operating_unit,
org_code,
wip_valuation_account,
wip_class,
wip_job

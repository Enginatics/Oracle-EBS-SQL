/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Material Relief
-- Description: Report to show WIP material variances on closed jobs for discrete manufacturing, in summary by inventory organization, with WIP class, job status, name and other details. Including any profit in inventory or PII amounts. But unlike the more recent CAC WIP Manufacturing Variance and CAC WIP Material Usage Variance reports, this report uses the latest material issue quantities as stored on the WIP job definition, even if you run it for a prior period. It does not rollback the component issue quantities for a prior accounting period.
-- Parameters:
-- ==========
-- Period Name: the accounting period you wish to report (mandatory).
-- Cost Type: defaults to your Costing Method. If blank the report uses your Costing Method Cost Type (mandatory).
-- PII Cost Type: enter the cost type for your profit in inventory item costs to report (optional).
-- PII Sub-Element: the sub-element or resource for profit in inventory, such as PII or ICP (optional).
-- Category Set 1: any item category you wish (optional).
-- Category Set 2: any item category you wish (optional).
-- Class Code: specific type of WIP class to report (optional).
-- Job Status: specific WIP job status (optional).
-- WIP Job: specific WIP job (optional).
-- Assembly Number: specific assembly number you wish to report (optional)
-- Component Number: specific component item you wish to report (optional)
-- Show Phantom Components: show the material usage variances for phantom components (optional).
-- Organization Code: any inventory organization, defaults to your session's inventory organization (optional).
-- Operating Unit: specific operating unit (optional).
-- Ledger: specific ledger (optional).
-- / +=============================================================================+
-- -- | Copyright 2009-24 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is acknowledged.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxwipreliefrept.sql
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 11 Jan 2010 Douglas Volz Initial Coding based on XXXICPWIPCOMPONENTVALREPT.sql,
-- -- | with this report analyzing the WIP variances on
-- -- | closed jobs. Added orgacctperiods to limit to
-- -- | jobs closed within the accounting period.
-- -- | 1.9 26 Sep 2010 Douglas Volz Added Component Item Number to report sort.
-- -- | 1.10 09 Feb 2012 Douglas Volz Included component yield in required quantities;
-- -- | decided to not exclude WIP expense jobs as they
-- -- | could have components with ICP issued to the job
-- -- | and the cost accountants would need the visibility.
-- -- | 1.11 23 Feb 2012 Douglas Volz Added component UOM code, to be consistent with
-- -- | other reports.
-- -- | 1.12 07 Oct 2020 Andy Haack Modify for Blitz Report with Blitz lookup functions
-- -- | (xxenutil) and re-format sql code.
-- -- | 1.13 11 Jul 2022 Douglas Volz Multi-language changes; added back PII parameters. Changed
-- -- | wro.componentyieldfactor to nvl(wro.componentyieldfactor,1).
-- -- | 1.14 23 Jun 2024 Douglas Volz Remove tabs, reinstall parameters and inventory org access controls.
-- -- | Added category set parameters.
-- -- | 1.15 24 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-wip-material-relief/
-- Library Link: https://www.enginatics.com/reports/cac-wip-material-relief/
-- Run Report: https://demo.enginatics.com/

select
y.ledger,
y.operating_unit,
y.org_code,
y.period_name,
&company_segment
&segment_columns
y.wip_class,
y.class_type,
y.wip_job,
y.job_status,
y.date_completed,
y.date_closed,
y.start_quantity,
y.assembly_quantity_completed,
y.assembly_quantity_scrapped,
y.total_assembly_quantity,
y.assembly_number,
y.assembly_description,
&category_columns
y.component_number,
y.component_description,
y.currency_code,
y.gross_item_cost,
y.pii_item_cost,
y.uom_code,
y.quantity_per_assembly,
y.total_required_quantity,
y.quantity_issued,
y.quantity_issued-y.total_required_quantity quantity_left_in_wip,
(y.quantity_issued-y.total_required_quantity)*y.gross_item_cost gross_material_usage_var,
(y.quantity_issued-y.total_required_quantity)*y.pii_item_cost pii_in_wip,
(y.quantity_issued-y.total_required_quantity)*(y.gross_item_cost+y.pii_item_cost) net_material_usage_var
from
(
select
gl.name ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
x.period_name,
wac.material_account gcc1_id,
msiv.cost_of_sales_account gcc2_id,
wac.class_code wip_class,
xxen_util.meaning(wac.class_type,'WIP_CLASS_TYPE',700) class_type,
we.wip_entity_name wip_job,
xxen_util.meaning(wdj.status_type,'WIP_JOB_STATUS',700) job_status,
wdj.date_completed,
wdj.date_closed,
wdj.start_quantity,
wdj.quantity_completed assembly_quantity_completed,
wdj.quantity_scrapped assembly_quantity_scrapped,
wdj.quantity_completed+wdj.quantity_scrapped total_assembly_quantity,
msiv.concatenated_segments assembly_number,
msiv.description assembly_description,
msiv.inventory_item_id,
msiv.organization_id,
msiv_comp.concatenated_segments component_number,
msiv_comp.description component_description,
gl.currency_code,
coalesce((select /*+ no_unnest*/ cic.item_cost from cst_cost_types cct, cst_item_costs cic where cct.cost_type=:p_cost_type and x.inventory_item_id=cic.inventory_item_id and x.organization_id=cic.organization_id and cct.cost_type_id=cic.cost_type_id),(select /*+ no_unnest*/ cic.item_cost from cst_item_costs cic where x.inventory_item_id=cic.inventory_item_id and x.organization_id=cic.organization_id and mp.primary_cost_method=cic.cost_type_id)) gross_item_cost,
nvl((select /*+ no_unnest*/ sum(cicd.item_cost) from cst_item_cost_details cicd, cst_cost_types cct, bom_resources br where x.organization_id=cicd.organization_id and x.inventory_item_id=cicd.inventory_item_id and cicd.cost_type_id=cct.cost_type_id and cct.cost_type=:p_pii_cost_type and cicd.resource_id=br.resource_id and br.resource_code=:p_pii_sub_element),0) pii_item_cost,
msiv_comp.primary_uom_code uom_code,
x.quantity_per_assembly,
x.total_required_quantity,
x.quantity_issued
from
(
select
oap.period_name,
wdj.wip_entity_id,
wro.organization_id,
wro.inventory_item_id,
sum(decode(wro.basis_type,2,nvl(wro.required_quantity,1),nvl(wro.quantity_per_assembly,0)/nvl(wro.component_yield_factor,1))) quantity_per_assembly,
sum(decode(wro.basis_type,2,nvl(wro.required_quantity,1),nvl(wro.quantity_per_assembly,0)/nvl(wro.component_yield_factor,1)*(nvl(wdj.quantity_completed,0)+nvl(wdj.quantity_scrapped,0)))) total_required_quantity,
sum(nvl(wro.quantity_issued,0)) quantity_issued
from
mtl_parameters mp,
org_acct_periods oap,
wip_discrete_jobs wdj,
wip_requirement_operations wro
where
1=1 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=oap.organization_id and
oap.organization_id=wdj.organization_id and
wdj.date_closed>=oap.period_start_date and
wdj.date_closed<oap.schedule_close_date+1 and
wdj.wip_entity_id=wro.wip_entity_id and
wdj.organization_id=wro.organization_id
group by
oap.period_name,
wdj.wip_entity_id,
wro.organization_id,
wro.inventory_item_id
) x,
wip_discrete_jobs wdj,
wip_entities we,
wip_accounting_classes wac,
mtl_parameters mp,
mtl_system_items_vl msiv,
mtl_system_items_vl msiv_comp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl
where
2=2 and
x.wip_entity_id=wdj.wip_entity_id and
wdj.wip_entity_id=we.wip_entity_id and
wdj.class_code=wac.class_code and
wdj.organization_id=wac.organization_id and
x.organization_id=mp.organization_id and
we.organization_id=msiv.organization_id and
we.primary_item_id=msiv.inventory_item_id and
x.organization_id=msiv_comp.organization_id and
x.inventory_item_id=msiv_comp.inventory_item_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id
) y,
gl_code_combinations gcc1,
gl_code_combinations gcc2
where
y.gcc1_id=gcc1.code_combination_id and
y.gcc2_id=gcc2.code_combination_id
order by
y.ledger,
y.operating_unit,
y.org_code,
y.period_name,
y.wip_class,
y.wip_job,
y.assembly_number,
y.component_number

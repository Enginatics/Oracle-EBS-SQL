/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Material Relief
-- Description: Report to show WIP material variances on closed jobs for discrete manufacturing, in summary by inventory organization, with WIP class, job status, name and other details.  Including any profit in inventory or PII amounts.  But unlike the more recent CAC WIP Manufacturing Variance and CAC WIP Material Usage Variance reports, this report uses the latest material issue quantities as stored on the WIP job definition, even if you run it for a prior period.  It does not rollback the component issue quantities for a prior accounting period.

/* +=============================================================================+
-- |  Copyright 2009-22 Douglas Volz Consulting, Inc.                            |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged                                                               |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_wip_relief_rept.sql
-- |
-- |  Parameters:
-- |  p_period_name             -- Enter the Period_Name you wish to report for WIP Period balances.
-- |  p_cost_type               -- Enter the cost type for your item costs to report.  Optional.  If
-- |                               blank the report uses your Costing Method Cost Type.
-- |  p_pii_cost_type           -- Enter the cost type for your profit in inventory item costs to report.  Mandatory.
-- |  p_pii_sub_element         -- The sub-element or resource for profit in inventory,such as PII or ICP (mandatory)
-- |  p_assembly_number         -- Enter the specific assembly number you wish to report (optional)
-- |  p_component_number        -- Enter the specific component item you wish to report (optional)
-- |  p_show_phantom_components -- show the material usage variances for phantom components
-- |  p_wip_job                 -- Specific WIP job (optional)
-- |  p_job_status              -- Specific WIP job status (optional)
-- |  p_wip_class_code          -- Specific WIP class code (optional)
-- |  p_org_code                -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit          -- Operating_Unit you wish to report, leave blank for all
-- |                               operating units (optional) 
-- |  p_ledger                  -- general ledger you wish to report, leave blank for all
-- |                               ledgers (optional)
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     11 Jan 2010 Douglas Volz   Initial Coding based on XXX_ICP_WIP_COMPONENT_VAL_REPT.sql,
-- |                                     with this report analyzing the WIP variances on
-- |                                     closed jobs.  Added org_acct_periods to limit to
-- |                                     jobs closed within the accounting period
-- |  1.11    23 Feb 2012 Douglas Volz   Added component UOM code, to be consistent with
-- |                                     other reports.
-- |  1.12    07 Oct 2020 Andy Haack     Modify for Blitz Report with Blitz lookup functions
-- |                                     (xxen_util) and re-format sql code.
-- |  1.13    11 Jul 2022 Douglas Volz   Multi-language changes; added back PII parameters.  Changed
-- |                                     wro.component_yield_factor to nvl(wro.component_yield_factor,1)
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-wip-material-relief/
-- Library Link: https://www.enginatics.com/reports/cac-wip-material-relief/
-- Run Report: https://demo.enginatics.com/

select
gl.name Ledger,
haouv2.name Operating_Unit,
mp.organization_code Org_Code,
oap.period_name,
&company_segment
&segment_columns
wac.class_code WIP_Class,
xxen_util.meaning(wac.class_type,'WIP_CLASS_TYPE',700) Class_Type,
we.wip_entity_name WIP_Job,
xxen_util.meaning(wdj.status_type,'WIP_JOB_STATUS',700) job_status,
wdj.date_completed,
wdj.date_closed,
wdj.start_quantity,
wdj.quantity_completed Assembly_Quantity_Completed,
wdj.quantity_scrapped assembly_Quantity_Scrapped,
wdj.quantity_completed + wdj.quantity_scrapped Total_assembly_Quantity,
msiv.concatenated_segments Assembly_Number,
msiv.description Assembly_Description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) assembly_item_type,
msiv2.concatenated_segments Component_Number,
msiv2.description Component_Description,
xxen_util.meaning(msiv2.item_type,'ITEM_TYPE',3) component_item_type,
gl.currency_code Currency_Code,
sum(cic.item_cost) Gross_Item_Cost,
nvl(cicd.item_cost,0) PII_Item_Cost,
-- Revision for version 1.13
-- msi2.primary_uom_code UOM_Code,
muomv.uom_code UOM_Code,
-- +=====================================================
-- need to include component yield in the icp calculation
-- +=====================================================
-- a basis of 2 indicates the component is issued per lot not per assembly, and the component yield factor is ignored
sum((decode(wro.basis_type, 
null, nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1),
1,    nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1),
2,    nvl(wro.required_quantity,1),
nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1)
)
)
) Quantity_Per_Assembly,
-- a basis of 2 indicates the component is issued per lot not per assembly, and the component yield factor is ignored
sum((decode(wro.basis_type, 
null, nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) * 
(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0)),
1,    nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) *
(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0)),
2,    nvl(wro.required_quantity,1),
nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) *
(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0))
)
)
) Total_Required_Quantity,
sum(nvl(wro.quantity_issued,0)) Quantity_Issued,
-- need to include component yield in the calculation
sum((nvl(wro.quantity_issued,0) - 
-- a basis of 2 indicates the component is issued per lot not per assembly, and the component yield factor is ignored
decode(wro.basis_type, 
null, nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) * 
(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0)),
1,    nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) *
(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0)),
2,    nvl(wro.required_quantity,1),
nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) *
(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0))
)
)
) Quantity_Left_in_WIP,
sum((nvl(wro.quantity_issued,0) - 
-- a basis of 2 indicates the component is issued per lot not per assembly, and the component yield factor is ignored
decode(wro.basis_type, 
null, nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) * 
(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0)),
1,    nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) *
(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0)),
2,    nvl(wro.required_quantity,1),
nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) *
(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0))
)
)
) * sum(nvl(cic.item_cost,0)) Gross_Material_Usage_Var,
sum((nvl(wro.quantity_issued,0) - 
-- a basis of 2 indicates the component is issued per lot not per assembly, and the component yield factor is ignored
decode(wro.basis_type, 
null, nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) * 
(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0)),
1,    nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) *
(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0)),
2,    nvl(wro.required_quantity,1),
nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) *
(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0))
)
)
) *
nvl(cicd.item_cost,0) PII_in_WIP,     -- p_cost_type
sum((nvl(wro.quantity_issued,0) - 
-- a basis of 2 indicates the component is issued per lot not per assembly, and the component yield factor is ignored
decode(wro.basis_type, 
null, nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) * 
(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0)),
1,    nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) *
(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0)),
2,    nvl(wro.required_quantity,1),
nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) *
(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0))
)
)
) *
(sum(nvl(cic.item_cost,0))
+
nvl(cicd.item_cost,0)) Net_Material_Usage_Var
from
org_acct_periods oap,
wip_entities we,
wip_discrete_jobs wdj,
wip_accounting_classes wac,
wip_requirement_operations wro,
mtl_parameters mp,
mtl_system_items_vl msiv,
mtl_system_items_vl msiv2,
cst_item_costs cic,
-- Revision for version 1.13
mtl_units_of_measure_vl muomv,
cst_cost_types cct,
gl_code_combinations gcc1,  -- wip class accounts
gl_code_combinations gcc2,  -- product group info from cogs account
hr_organization_information hoi,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv2,
gl_ledgers gl,
(
select
cicd.inventory_item_id,
cicd.organization_id,
sum(cicd.item_cost) item_cost
from
cst_item_cost_details cicd,
bom_resources br,
cst_cost_types cct
where
cicd.resource_id=br.resource_id and
br.resource_code= :p_pii_sub_element and
cicd.cost_type_id=cct.cost_type_id and
cct.cost_type=:p_pii_cost_type
group by
cicd.inventory_item_id,
cicd.organization_id
) cicd
where
1=1 and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
oap.organization_id=we.organization_id and
wdj.date_closed>=oap.period_start_date and
wdj.date_closed<oap.schedule_close_date+1 and
we.wip_entity_id=wdj.wip_entity_id and
wdj.class_code=wac.class_code and
wdj.organization_id=wac.organization_id and
wdj.wip_entity_id=wro.wip_entity_id
-- =================================================================
-- mtl parameter, item master and period close snapshot joins
-- =================================================================
and    mp.organization_id          = msiv.organization_id
and    msiv.organization_id        = we.organization_id
and    msiv.inventory_item_id      = we.primary_item_id    -- fg assembly item
and    msiv.organization_id        = msiv2.organization_id
and    msiv2.inventory_item_id     = wro.inventory_item_id -- component item
and    msiv2.organization_id       = cic.organization_id
and    msiv2.inventory_item_id     = cic.inventory_item_id  -- component item
-- Revision for version 1.13
and    msiv2.primary_uom_code      = muomv.uom_code
and    cct.cost_type               = :p_cost_type
-- If you do not specify a cost type, gets the frozen or average cost type based on your costing method
and    cic.cost_type_id            = nvl(cct.cost_type_id, mp.primary_cost_method)
-- End of revision for version 1.13
and    wac.material_account        = gcc1.code_combination_id
and    msiv.cost_of_sales_account  = gcc2.code_combination_id
and    hoi.org_information_context = 'Accounting Information'
and    hoi.organization_id         = mp.organization_id
and    hoi.organization_id         = haouv.organization_id   -- this gets the organization name
and    haouv2.organization_id      = to_number(hoi.org_information3) -- this gets the operating unit id
and    gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
and    msiv2.inventory_item_id     = cicd.inventory_item_id(+)
and    msiv2.organization_id       = cicd.organization_id(+)
group by
gl.name,
haouv2.name,
mp.organization_code,
oap.period_name,
&group_by_company_seg
&group_by_segment_columns
wac.class_code,
we.wip_entity_name,
xxen_util.meaning(wac.class_type,'WIP_CLASS_TYPE',700),
xxen_util.meaning(wdj.status_type,'WIP_JOB_STATUS',700),
wdj.date_completed,
wdj.date_closed,
wdj.start_quantity,
wdj.quantity_completed,
wdj.quantity_scrapped,
wdj.net_quantity,
msiv.concatenated_segments,
msiv.description,
msiv.item_type,
msiv2.concatenated_segments,
msiv2.description,
msiv2.item_type,
gl.currency_code,
-- Revision for version 1.13 
-- msi2.primary_uom_code,
muomv.uom_code,
msiv2.inventory_item_id,
msiv2.organization_id,
cicd.item_cost
order by 1,2,3,4,5,6,7,14,16,26
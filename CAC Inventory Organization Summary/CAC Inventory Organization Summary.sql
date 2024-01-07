/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inventory Organization Summary
-- Description: Report to show inventory org names, summary org controls, org hierarchy, operating unit and Ledger, and whether or not the Org should be rolled up for costing, based on the existence of BOMs, routings or org-level sourcing rules.
Note:  this report automatically looks for hierarchies which might be used with the Open Period Control and the Close Period Control Oracle programs.  Looking for the translated values of "Close", "Open" and "Period" in the Hierarchy Name.

Parameters:
==========
Assignment Set:  choose the Assignment Set to report for sourcing rules.  You may leave this value null and the report still works (optional).
Hierarchy Name:  select the organization hierarchy used to open and close your inventory organizations (optional).  If you leave this field blank the report automatically looks for hierarchies which might be used with the Open Period Control and the Close Period Control Oracle programs.  Looking for the translated values of "Close", "Open" and "Period" in the Hierarchy Name.
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2010-2022 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this
-- | permission.
-- +=============================================================================+
-- |
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     14 Apr 2010 Douglas Volz Initial Coding
-- | 1.19    09 Jul 2019 Douglas Volz Changed Org Hierarchy logic to look only for Hierarchy 
-- |                                  Names with "Open" or "Close" or "Period" in it.
-- |                                  For the 2nd union all, added an Outer Join to OU:
-- |                                  and haou2.organization_id (+) = to_number(hoi.org_information3)
-- |                                  ... found an inventory org in Vision with no OU
-- | 1.20    16 Jan 2020 Douglas Volz Added Ledger, Operating Unit and Org Code parameters.
-- | 1.21    02 Feb 2020 Douglas Volz Added max material and WIP transaction dates and removed
-- |                                  flv.source_lang joins, not needed.
-- | 1.22    08 Mar 2020 Douglas Volz Checking for a routing for the parent org
-- | 1.23    07 Apr 2020 Douglas Volz Consolidated two (union all) statements into one.
-- | 1.24    27 Apr 2020 Douglas Volz Changed to multi-language views for the
-- |                                  inventory orgs and operating units.
-- | 1.25    29 Jun 2022 Douglas Volz Fixed indicator for category accounts.
-- | 1.26    09 Sep 2022 Douglas Volz Added indicator for PAC Enabled.
+=============================================================================+*/

-- Excel Examle Output: https://www.enginatics.com/example/cac-inventory-organization-summary/
-- Library Link: https://www.enginatics.com/reports/cac-inventory-organization-summary/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
 -- Revision for version 1.17
 gl.currency_code Curr_Code,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 -- Revision for version 1.12
 decode(hoi2.org_information2, 'Y', 'Yes', 'N', 'No', null, 'No') Inv_Org,
 mp.organization_id Org_Id,
 (select max(hoh.parent_organization_name)
  from hrfv_organization_hierarchies hoh,
  mtl_parameters mp3 -- parent organization
  where hoh.parent_organization_id = mp3.organization_id
  and hoh.child_organization_id  = mp.organization_id
  and regexp_like(hoh.organization_hierarchy_name, '&p_name_open|&p_name_close|&p_name_period|&p_org_hierarchy_name','i')
 ) Hierarchy_Origin,
 (select max(mp3.organization_code)
  from hrfv_organization_hierarchies hoh,
  mtl_parameters mp3 -- parent organization
  where hoh.parent_organization_id = mp3.organization_id
  and hoh.child_organization_id  = mp.organization_id
  and regexp_like(hoh.organization_hierarchy_name, '&p_name_open|&p_name_close|&p_name_period|&p_org_hierarchy_name','i')
 ) Parent_Org_Code,
 (select max(hoh.organization_hierarchy_name)
  from hrfv_organization_hierarchies hoh,
  mtl_parameters mp3 -- parent organization
  where hoh.parent_organization_id = mp3.organization_id
  and hoh.child_organization_id  = mp.organization_id
  and regexp_like(hoh.organization_hierarchy_name, '&p_name_open|&p_name_close|&p_name_period|&p_org_hierarchy_name','i')
 ) Hierarchy_Name,
 -- Added columns for version 1.6
 haou.date_to Disable_Date,
 (select distinct 'Yes'
  from org_access a1, fnd_responsibility r
  where mp.organization_id  = a1.organization_id
  and nvl(a1.disable_date, sysdate + 1) >= sysdate
  and r.application_id    = a1.resp_application_id(+)
  and r.responsibility_id = a1.responsibility_id(+)) On_Org_Access,
 (select distinct 'Yes'
  from oe_system_parameters_all oesp
  where mp.organization_id    = oesp.master_organization_id
  and haou2.organization_id = oesp.org_id) Val_Org,
 -- End changes to version 1.6
 -- Revision for version 1.9
 decode(nvl(mp.process_enabled_flag, 'N'), 'N', 'No', 'Y', 'Yes') Process_Costing,
 -- Revision for version 1.26
 (select distinct 'Yes'
  from cst_cost_group_assignments ccga,
  cst_cost_groups ccg
  where ccg.legal_entity is not null
  and ccga.cost_group_id    = ccg.cost_group_id
  and ccga.organization_id  = mp.organization_id) PAC_Enabled,
 -- End revision for version 1.26
 mp.cost_cutoff_date Cost_Cut_Off_Date,
 br.resource_code Default_Matl_Sub_Element,
 br2.resource_code Default_MOH_Sub_Element,
 -- check to see if a BOM_or_Recipe exists
 (select distinct 'Yes'
  from bom_structures_b bsb
  where bsb.organization_id     = mp.organization_id
  and mp.process_enabled_flag = 'N'
  and bsb.alternate_bom_designator is null
  -- Revision for version 1.11, add union all logic for Recipes
  union all
  select distinct 'Yes'
  from gmd_recipes_b grb
  where grb.owner_organization_id = mp.organization_id
  and mp.process_enabled_flag   = 'Y') BOM_or_Recipe,
 -- check to see if a routing exists
 (select distinct 'Yes'
  from bom_operational_routings bor
  where bor.organization_id     = mp.organization_id
  and mp.process_enabled_flag = 'N'
  -- Revision for version 1.11, add union all logic for Recipes with Routings
  union all
  select distinct 'Yes'
  from gmd_recipes_b grb
  where grb.owner_organization_id = mp.organization_id
  and mp.process_enabled_flag   = 'Y'
  and grb.routing_id is not null) Routing,
 -- check to see if a sourcing rule exists for the receipt org
 (select distinct 'Yes'
  from mrp_sr_receipt_org msro,
  mrp_sr_source_org msso,
  mrp_sourcing_rules msr,
  mrp_sr_assignments msa,
  mrp_assignment_sets mas
  where msr.sourcing_rule_id        = msro.SOURCING_RULE_ID
  -- fix for version 1.4, check to see if the sourcing rule is
  -- for an inventory org, not a vendor
  and msso.sr_receipt_id          = msro.sr_receipt_id
  and msso.source_organization_id is not null
  and msa.sourcing_rule_id        = msr.sourcing_rule_id
  and msa.assignment_set_id       = mas.assignment_set_id
  and mp.organization_id          = msa.organization_id
  -- Fix for version 1.7
  and 2=2                                                                                           -- p_assignment_set
 ) Sourcing_Rule,
 -- Revision for version 1.11.  Now also checking for Process FROZEN Costs
 (select distinct 'Yes'
  from cst_item_costs cic
  where cic.cost_type_id        = mp.primary_cost_method
  and cic.organization_id     = mp.organization_id
  and nvl(cic.item_cost, 0) <> 0
  and mp.process_enabled_flag = 'N'
  union all
  select distinct 'Yes'
  from gl_item_cst gic,
  gmf_fiscal_policies gfp,
  cm_mthd_mst cmm
  where gic.cost_type_id        = cmm.cost_type_id
  and cmm.cost_mthd_code in ('FROZEN', 'STANDARD', 'STD', 'STND', 'PWAC','PPAC','PMAC')
  and gic.organization_id     = mp.organization_id
  and gfp.cost_type_id        = cmm.cost_type_id
  and nvl(gic.acctg_cost, 0) <> 0
  and mp.process_enabled_flag = 'Y') Has_Frozen_or_Avg_Costs,
 -- Revision for version 1.11.  Now checking for Process PENDING Costs
 (select distinct 'Yes'
  from cst_item_costs cic
  where cic.cost_type_id        = 3  -- Pending cost type
  and nvl(cic.item_cost, 0) <> 0
  and mp.process_enabled_flag = 'N'
  and cic.organization_id     = mp.organization_id
  union all
  select distinct 'Yes'
  from gl_item_cst gic,
  gmf_fiscal_policies gfp,
  cm_mthd_mst cmm
  where gic.cost_type_id = cmm.cost_type_id
  and cmm.cost_mthd_code = 'PENDING' -- Pending Standard cost type
  and gic.organization_id = mp.organization_id
  and gfp.cost_type_id = cmm.cost_type_id
  and nvl(gic.acctg_cost, 0) <> 0
  and mp.process_enabled_flag = 'Y') Has_Pending_Costs,
 -- End revision for version 1.11
 -- Revision for version 1.17
 (select distinct 'Yes'
  from mtl_onhand_quantities_detail moqd
  where mp.organization_id = moqd.organization_id) Has_Onhand,
 -- End revision for version 1.17
 -- Revision for version 1.21
 (select max(mmt.transaction_date)
  from mtl_material_transactions mmt
  where mp.organization_id = mmt.organization_id) Last_Material_Txn_Date,
 (select max(wta.transaction_date)
  from wip_transaction_accounts wta
  where mp.organization_id         = wta.organization_id
  and mp.process_enabled_flag = 'N'
 ) Last_WIP_Txn_Date,
 -- End revision for version 1.21
 mp2.organization_code Item_Master_Org,
 ml.meaning Costing_Method,
 ml2.meaning Allow_Negatives,
 -- Revision for version 1.8
 decode(nvl(mp.cost_group_accounting, 2),  2, 'No',  1, 'Yes') Cost_Group_Accounting,
 -- Revision for version 1.25
 -- decode(nvl(mp.enable_costing_by_category, 'N'), 'N', 'No', 'Y', 'Yes') Cost_by_Category_Enabled,
 case
    when nvl(mp.enable_costing_by_category, 'N') = 'Y' then 'Yes'
    when exists (select 'x'
   from mtl_category_accounts mca
   where mca.organization_id = mp.organization_id) then 'Yes'
    else 'No'
 end Cost_by_Category_Enabled,
 -- End revision for version 1.25
 -- Revision for version 1.14
 nvl((select 'Yes'
      from pjm_org_parameters pop
      where mp.organization_id = pop.organization_id),'No') Project_Mfg_Enabled,
 decode(nvl(mp.lcm_enabled_flag, 'N'), 'N', 'No', 'Y', 'Yes') LCM_Enabled,
 -- End revision for version 1.14
 decode(nvl(mp.eam_enabled_flag, 'N'), 'N', 'No', 'Y', 'Yes') EAM_Enabled,
 decode(nvl(mp.wms_enabled_flag, 'N'), 'N', 'No', 'Y', 'Yes') WMS_Enabled,
 -- Revision for version 1.14, check again for OSFM or WSM
 -- Revision for version 1.11, OSFM or WSM not used at Client
 nvl((select 'Yes'
      from wsm_parameters wp
      where mp.organization_id = wp.organization_id),'No') WSM_Shopfloor_Enabled,
 -- End revision for version 1.16
 -- Revision for version 1.18
 -- decode(mp.general_ledger_update_code, 1, 'Yes', 'No') Transfer_to_GL,
 decode(mp.general_ledger_update_code, 1, 'Detail', 2,'Summary', 3, '') Transfer_to_GL,
 -- End revision for version 1.18
 (select flvv.meaning
  from fnd_lookup_values_vl flvv, po_system_parameters_all pspa
  where flvv.lookup_type = 'INVENTORY ACCRUAL OPTION'
  and flvv.lookup_code = pspa.inventory_accrual_code
  and pspa.org_id      = haou2.organization_id) Accrue_Inventory,
 (select flvv.meaning
  from fnd_lookup_values_vl flvv, po_system_parameters_all pspa
  where flvv.lookup_type = 'EXPENSE ACCRUAL OPTION'
  and flvv.lookup_code = pspa.expense_accrual_code
  and pspa.org_id      = haou2.organization_id) Accrue_Expense,
 -- Revision for version 1.17
 (select distinct 'Yes'
  from cst_ap_po_reconciliation capr
  where mp.organization_id = capr.inventory_organization_id) Use_Payables_Accruals,
 (select distinct 'Yes'
  from cst_margin_summary cms
  where mp.organization_id = cms.organization_id) Use_Margin_Reports,
 -- End revision for version 1.17
 mp.creation_date Creation_Date,
 mp.last_update_date Last_Update_Date,
 fu.user_name Last_Updated_By
from mtl_parameters mp,
 mtl_parameters mp2, -- item master org
 bom_resources br,
 bom_resources br2,
 hr_organization_information hoi,
 -- Revision for version 1.12
 hr_organization_information hoi2,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 mfg_lookups ml,
 mfg_lookups ml2,
 fnd_user fu,
 gl_ledgers gl
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
where hoi.org_information_context   = 'Accounting Information'
-- Revision for version 1.12
and hoi2.organization_id          = mp.organization_id
and hoi2.org_information_context  = 'CLASS'
-- Revision for version 1.13 to avoid duplicates
and hoi2.org_information1         = 'INV'
-- End revision for version 1.12
and hoi.organization_id           = mp.organization_id -- org code
and hoi.organization_id           = haou.organization_id -- this gets the organization name
-- Possible to be missing the operating unit, use outer join
and haou2.organization_id (+)     = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
and mp.master_organization_id     = mp2.organization_id
-- Fix for version 1.5
-- and fu.user_id = mp.created_by
and fu.user_id                   = mp.last_updated_by
-- ===========================================
-- Resource code joins
-- ===========================================
and mp.default_material_cost_id  = br.resource_id(+)
and mp.mat_ovhd_cost_type_id     = br2.resource_id(+)
-- ===========================================
-- Lookup code joins
-- ===========================================
-- This joins works for Discrete and Process with Standard Costing
and mp.primary_cost_method       = ml.lookup_code
and ml.lookup_type               = 'MTL_PRIMARY_COST'
and mp.negative_inv_receipt_code = ml2.lookup_code
and ml2.lookup_type              = 'SYS_YES_NO'
-- ===========================================
-- Exclude inventory orgs not in use
-- ===========================================
-- Fix for version 1.2 and 1.7
-- and mp.organization_id <> mp.master_organization_id -- remove the global master org
-- Revision for version 1.20
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                                                                                                   -- p_ledger, p_operating_unit, p_org_code
-- Order by Ledger, Operating_Unit, Organization Code and Hierarchy_Origin
order by 1,3,4,8
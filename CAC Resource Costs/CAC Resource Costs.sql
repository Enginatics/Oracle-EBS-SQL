/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Resource Costs
-- Description: Report to show the resource and outside processing costs by organization and cost type.

/* +=============================================================================+
-- |  Copyright 2006-2022 Douglas Volz Consulting, Inc.                          |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_resource_costs_rept.sql
-- |
-- |  Parameters:
-- |  p_cost_type              -- Cost_Type you wish to report, mandatory
-- |  p_include_non_costed_res -- Yes/No flag to include or not include non-costed resources
-- |  p_org_code               -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit         -- Operating Unit you wish to report, leave blank for all
-- |                              operating units (optional) 
-- |  p_ledger                 -- general ledger you wish to report, leave blank for all
-- |                              ledgers (optional)
-- |
-- |  Description:
-- |  Report to show the resource and outside processing costs by organization and cost type.
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     18 Nov 2010 Douglas Volz   Initial Coding
-- |  1.1     15 Dec 2010 Douglas Volz   Final Coding
-- |  1.2     28 Dec 2010 Douglas Volz   Removed condition to omit Orgs 108, 109, 110 
-- |                                     and 331 as these may be used at any time
-- |  1.3     18 Nov 2015 Douglas Volz   Removed organization restrictions
-- |  1.4     15 Nov 2016 Douglas Volz   Added DFF for Resource_Type, changed
-- |                                     cancatenated segments to separate columns.
-- |  1.5     18 Nov 2016 Douglas Volz   Added Activity to this report
-- |  1.6     16 Feb 2017 Douglas Volz   Added Creation_Date and Who Created
-- |  1.7     17 Feb 2017 Douglas Volz   Add Resource_Description
-- |  1.8     18 Sep 2019 Douglas Volz   Added last update by and last update date
-- |  1.9     27 Jan 2020 Douglas Volz   Changed to multi-language views for the item
-- |                                     master, inventory orgs and operating units.
-- |  1.10    21 Jul 2021 Douglas Volz   Add Basis Type, UOM Code and changed Allow
-- |                                     Costs and Std Rate to lookup codes.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-resource-costs/
-- Library Link: https://www.enginatics.com/reports/cac-resource-costs/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
-- =================================================
-- Get the costed bom resources
-- =================================================
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 br.resource_code Resource_Code,
 -- Revision for version 1.7
 br.description Resource_Description,
 cce.cost_element Cost_Element,
 cct.cost_type Cost_Type,
 gl.currency_code Currency_Code,
 nvl(crc.resource_rate,0) Resource_Rate,
 ml1.meaning Resource_Type,
 ml2.meaning Charge_Type,
 -- Revision for version 1.10
 ml3.meaning Basis_Type,
 br.expenditure_type Expenditure_Type,
 ml4.meaning Allow_Costs,
 br.unit_of_measure UOM_Code,
 ml5.meaning Standard_Rate,
 -- End revision for version 1.10
 msiv.concatenated_segments OSP_Item_Number,
 msiv.description OSP_Item_Description,
 -- Revision for version 1.4 and 1.5 
 -- br.attribute1 Res Type, 
 (select   ca.activity
  from     cst_activities ca
  where    ca.activity_id = br.default_activity_id) Activity, 
 -- End revision for version 1.5
 -- gcc2.concatenated_segments Absorption_Account,
 -- gcc1.concatenated_segments Variance_Account,
 &segment_columns
 -- End revision for version 1.4
 br.disable_date Disable_Date,
 -- Revision for version 1.6
 br.creation_date Creation_Date,
 fu.user_name Created_By,
 -- Revision for version 1.8
 br.last_update_date Last_Update_Date,
 fu2.user_name Last_Updated_By
from cst_resource_costs crc,
 bom_resources br,
 mtl_system_items_vl msiv,
 mtl_parameters mp,
 cst_cost_elements cce,
 cst_cost_types cct,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 mfg_lookups ml1, -- Resource Type
 mfg_lookups ml2, -- Charge Type
 -- Revision for version 1.10
 mfg_lookups ml3, -- Basis Type
 mfg_lookups ml4, -- Allow Costs
 mfg_lookups ml5, -- Standard Rate Flag
 -- End revision for version 1.10
 -- Revision for version 1.4
 gl_code_combinations gcc1,
 gl_code_combinations gcc2,
 -- Revision for version 1.6
 fnd_user fu,
 -- Revision for version 1.8
 fnd_user fu2
-- =================================================
-- Joins for the items, costs and resources
-- =================================================
where crc.resource_id             = br.resource_id
and crc.organization_id         = mp.organization_id
and crc.cost_type_id            = cct.cost_type_id
and 1=1                         -- p_cost_type
and br.purchase_item_id         = msiv.inventory_item_id (+)
and br.organization_id          = msiv.organization_id (+)
and mp.organization_id          = br.organization_id
and br.cost_element_id          = cce.cost_element_id
and br.allow_costs_flag         = 1 -- Yes
-- =================================================
-- Eliminate orgs no longer in use
and mp.organization_id         <> mp.master_organization_id
-- =================================================
-- Joins for the lookup codes
-- =================================================
and ml1.lookup_type             = 'BOM_RESOURCE_TYPE'
and ml1.lookup_code             = br.resource_type
and ml2.lookup_type             = 'BOM_AUTOCHARGE_TYPE'
and ml2.lookup_code             = br.autocharge_type
-- Revision for version 1.10
and ml3.lookup_type             = 'CST_BASIS'
and ml3.lookup_code             = br.default_basis_type
and ml4.lookup_type             = 'SYS_YES_NO'
and ml4.lookup_code             = br.allow_costs_flag
and ml5.lookup_type             = 'SYS_YES_NO'
and ml5.lookup_code             = br.standard_rate_flag
-- End revision for version 1.10
-- =================================================
-- Organization joins to the HR org model
-- =================================================
and hoi.org_information_context = 'Accounting Information'
and hoi.organization_id         = mp.organization_id
and hoi.organization_id         = haou.organization_id   -- this gets the organization name
and haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and 2=2                         -- p_org_code, p_operating_unit, p_ledger
-- =================================================
-- Joins for the account numbers
-- =================================================
and br.rate_variance_account    = gcc1.code_combination_id
and br.absorption_account       = gcc2.code_combination_id
-- =================================================
-- Find the Created_By, revision 1.6 and 1.8
-- =================================================
and fu.user_id                  = br.created_by
and fu2.user_id                 = br.last_updated_by
union all
-- =================================================
-- Get the non-costed bom resources
-- =================================================
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 br.resource_code Resource_Code,
 -- Revision for version 1.7
 br.description Resource_Description,
 null Cost_Element,
 null Cost_Type,
 null Currency_Code,
 null Resource_Rate,
 ml1.meaning Resource_Type,
 ml2.meaning Charge_Type,
 -- Revision for version 1.10
 ml3.meaning Basis_Type,
 br.expenditure_type Expenditure_Type,
 ml4.meaning Allow_Costs,
 br.unit_of_measure UOM_Code,
 ml5.meaning Standard_Rate,
 -- End revision for version 1.10
 msiv.concatenated_segments OSP_Item_Number,
 msiv.description OSP_Item_Description,
 -- Revision for version 1.5
 -- br.attribute1 Res Type, 
 (select   ca.activity
  from     cst_activities ca
  where    ca.activity_id = br.default_activity_id) Activity, 
 -- End revision for version 1.5
 -- null Absorption_Account,
 -- null Variance_Account,
 &segment_columns2
 -- End revision for version 1.4
 br.disable_date Disable_Date,
 -- Revision for version 1.6
 br.creation_date Creation_Date,
 fu.user_name Created_By,
 -- Revision for version 1.8
 br.last_update_date Last_Update_Date,
 fu2.user_name Last_Updated_By
from bom_resources br,
 mtl_system_items_vl msiv,
 mtl_parameters mp,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 mfg_lookups ml1,
 mfg_lookups ml2,
 -- Revision for version 1.10
 mfg_lookups ml3, -- Basis Type
 mfg_lookups ml4, -- Allow Costs
 mfg_lookups ml5, -- Standard Rate Flag
 -- End revision for version 1.10
 -- Revision for version 1.6
 fnd_user fu,
 -- Revision for version 1.8
 fnd_user fu2
-- =================================================
-- Joins for the items, costs and resources
-- =================================================
where br.purchase_item_id         = msiv.inventory_item_id (+)
and br.organization_id          = msiv.organization_id (+)
and mp.organization_id          = br.organization_id
and br.allow_costs_flag         = 2 -- No
-- =================================================
-- Include or exclude non-costed resources
-- =================================================
and 3=3                         -- p_include_non_costed_res
-- =================================================
-- Eliminate orgs no longer in use
and mp.organization_id         <> mp.master_organization_id
-- =================================================
-- Joins for the lookup codes
-- =================================================
and ml1.lookup_type             = 'BOM_RESOURCE_TYPE'
and ml1.lookup_code             = br.resource_type
and ml2.lookup_type             = 'BOM_AUTOCHARGE_TYPE'
and ml2.lookup_code             = br.autocharge_type
-- Revision for version 1.10
and ml3.lookup_type             = 'CST_BASIS'
and ml3.lookup_code             = br.default_basis_type
and ml4.lookup_type             = 'SYS_YES_NO'
and ml4.lookup_code             = br.allow_costs_flag
and ml5.lookup_type             = 'SYS_YES_NO'
and ml5.lookup_code             = br.standard_rate_flag
-- End revision for version 1.10
-- =================================================
-- Organization joins to the HR org model
-- =================================================
and hoi.org_information_context = 'Accounting Information'
and hoi.organization_id         = mp.organization_id
and hoi.organization_id         = haou.organization_id   -- this gets the organization name
and haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and 2=2                         -- p_org_code, p_operating_unit, p_ledger
-- =================================================
-- Find the Created_By, revision 1.6 and 1.8
-- =================================================
and fu.user_id                  = br.created_by
and fu2.user_id                 = br.last_updated_by
-- Order by Ledger, Operating_Unit, Org_Code, Resource and Cost_Element
order by 1,2,3,4,6
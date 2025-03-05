/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Subinventory Accounts Setup
-- Description: Report to show accounts used for the subinventories; these valuation and expense accounts are used with Standard Costing.

/* +=============================================================================+
-- |  Copyright 2009 - 22 Douglas Volz Consulting, Inc.                          |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_subinv_setup_accts_rept.sql
-- |
-- |  Parameters:
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- | 
-- |  Description:
-- |  Report to show accounts used for the subinventories
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     24 Nov 2009 Douglas Volz   Initial Coding
-- |  1.1     28 Mar 2011 Douglas Volz   Minor column heading changes
-- |  1.2     30 Mar 2011 Douglas Volz   Minor column heading changes for Inv Asset,
-- |                                     added quantity tracked and disable date
-- |                                     columns
-- |  1.3     23 Dec 2014 Douglas Volz   Added DFFs for "Use Item Type Accounts".
-- |                                     For OPM orgs, the ICP valuation reports use
-- |                                     this to indicate if the Item Type accounts
-- |                                     or the subinventory valuation accounts are 
-- |                                     displayed on the report. 
-- |  1.4     07 Oct 2015 Douglas Volz   Removed above DFFs for "Use Item Type Accounts",
-- |                                     changed COA to match new client.  Also added
-- |                                     Cost Group Name and accounts. Replaced OOD
-- |                                     with mtl_parameters and mp.organization_name with
-- |                                     haou.name.  And removed prior client's organization
-- |                                     restrictions.   
-- |  1.5     11 Nov 2016 Douglas Volz   Modified chart of accounts for client 
-- |  1.6     28 Mar 2017 Douglas Volz   Added Creation Date, Last Update Date, Created
-- |                                     By, Last Updated By  
-- |  1.7     02 Feb 2020 Douglas Volz   Added Operating Unit and Org Code Parameters
-- |                                     and added outer join to gcc.code_combinations_id 
-- |  1.8     29 Apr 2020 Douglas Volz   Changed to multi-language views for the item
-- |                                     master, inventory orgs and operating units.
-- |  1.9     10 Jul 2022 Douglas Volz   Account Type column now uses a lookup code.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-subinventory-accounts-setup/
-- Library Link: https://www.enginatics.com/reports/cac-subinventory-accounts-setup/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
-- Get the Material Account
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 -- Revision for version 1.4
 haou.name Organization_Name,
 -- Revision for version 1.4
 (select ccg.cost_group
  from cst_cost_groups ccg
  where ccg.cost_group_id  = msub.default_cost_group_id) Cost_Group,
 -- End revision for version 1.4
 msub.secondary_inventory_name Subinventory,
 -- Revision for version 1.8
 ml1.meaning Inventory_Asset,
 ml2.meaning Quantity_Tracked,
 -- Revision for version 1.9
 -- 'Material Account' Account Type,
 ml3.meaning Account_Type,
 &segment_columns
 msub.creation_date Creation_Date,
 msub.disable_date Disable_Date,
 fu1.user_name Created_By,
 fu2.user_name Last_Updated_By
 -- End revision for version 1.6
from -- Revision for version 1.4
 -- Get valuation accounts based on Costing Method and Cost Group Accounting
 -- mtl_secondary_inventories msub,
 (-- Standard Costing, no Cost Group Accounting
  select msub.organization_id,
  msub.secondary_inventory_name,
  msub.material_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and nvl(mp.cost_group_accounting,2) = 2 -- No
  and mp.primary_cost_method = 1 -- Standard Costing
  union all
  -- Not Standard Costing, no Cost Group Accounting
  select msub.organization_id,
  msub.secondary_inventory_name,
  mp.material_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and nvl(mp.cost_group_accounting,2) = 2 -- No
  and mp.primary_cost_method <> 1 -- not Standard Costing
  union all
  -- With Cost Group Accounting
  select msub.organization_id,
  msub.secondary_inventory_name,
  ccga.material_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  cst_cost_group_accounts ccga,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and mp.cost_group_accounting = 1 -- Yes
  and ccga.cost_group_id = msub.default_cost_group_id
  union all
  -- Cost Group Accounting but the Subinventory Cost Group Id is null
  select msub.organization_id,
  msub.secondary_inventory_name,
  ccga.material_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  cst_cost_group_accounts ccga,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and mp.cost_group_accounting = 1 -- Yes
  and msub.default_cost_group_id is null
  and ccga.cost_group_id = mp.default_cost_group_id
 ) msub,
 -- End for revision 1.4
 mtl_parameters mp,
 -- Revision for version 1.8
 mfg_lookups ml1,
 mfg_lookups ml2,
 -- Revision for version 1.9
 mfg_lookups ml3, -- Account Type
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 fnd_user fu1,
 fnd_user fu2
where msub.material_account       = gcc.code_combination_id (+)
and msub.organization_id        = mp.organization_id
-- Revision for version 1.8
and ml1.lookup_type             = 'SYS_YES_NO'
and ml1.lookup_code             = msub.asset_inventory
and ml2.lookup_type             = 'SYS_YES_NO'
and ml2.lookup_code             = msub.quantity_tracked
-- Revision for version 1.9
and ml3.lookup_type             = 'CST_COST_CODE_TYPE'
and ml3.lookup_code             = 1 -- Material
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context = 'Accounting Information'
and hoi.organization_id         = mp.organization_id
and hoi.organization_id         = haou.organization_id -- this gets the organization name
and haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
-- Revision for version 1.4
-- Avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
-- Revision for version 1.6
and fu1.user_id                 = msub.created_by
and fu2.user_id                 = msub.last_updated_by
-- Revision for version 1.1, 1.3
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                                                           -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Material Overhead Account
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 -- Revision for version 1.4
 haou.name Organization_Name,
 -- Revision for version 1.4
 (select ccg.cost_group
  from   cst_cost_groups ccg
  where  ccg.cost_group_id  = msub.default_cost_group_id) Cost_Group,
 -- End revision for version 1.4
 msub.secondary_inventory_name Subinventory,
 -- Revision for version 1.8
 ml1.meaning Inventory_Asset,
 ml2.meaning Quantity_Tracked,
 -- Revision for version 1.9
 -- 'Matl Ovhd Account' Account_Type,
 ml3.meaning Account_Type,
 &segment_columns
 -- Revision for version 1.6
 msub.creation_date Creation_Date,
 msub.disable_date Disable_Date,
 fu1.user_name Created_By,
 fu2.user_name Last_Updated_By
 -- End revision for version 1.6
from -- Revision for version 1.4
 -- Get valuation accounts based on Costing Method and Cost Group Accounting
 -- mtl_secondary_inventories msub,
 (-- Standard Costing, no Cost Group Accounting
  select msub.organization_id,
  msub.secondary_inventory_name,
  msub.material_overhead_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and nvl(mp.cost_group_accounting,2) = 2 -- No
  and mp.primary_cost_method = 1 -- Standard Costing
  union all
  -- Not Standard Costing, no Cost Group Accounting
  select msub.organization_id,
  msub.secondary_inventory_name,
  mp.material_overhead_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and nvl(mp.cost_group_accounting,2) = 2 -- No
  and mp.primary_cost_method <> 1 -- not Standard Costing
  union all
  -- With Cost Group Accounting
  select msub.organization_id,
  msub.secondary_inventory_name,
  ccga.material_overhead_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  cst_cost_group_accounts ccga,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and mp.cost_group_accounting = 1 -- Yes
  and ccga.cost_group_id = msub.default_cost_group_id
  union all
  -- Cost Group Accounting but the Subinventory Cost Group Id is null
  select msub.organization_id,
  msub.secondary_inventory_name,
  ccga.material_overhead_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  cst_cost_group_accounts ccga,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and mp.cost_group_accounting = 1 -- Yes
  and msub.default_cost_group_id is null
  and ccga.cost_group_id = mp.default_cost_group_id
 ) msub,
 -- End for revision 1.4
 mtl_parameters mp,
 -- Revision for version 1.8
 mfg_lookups ml1,
 mfg_lookups ml2,
 -- Revision for version 1.9
 mfg_lookups ml3, -- Account Type
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 fnd_user fu1,
 fnd_user fu2
where msub.material_overhead_account = gcc.code_combination_id (+)
and msub.organization_id        = mp.organization_id
-- Revision for version 1.8
and ml1.lookup_type             = 'SYS_YES_NO'
and ml1.lookup_code             = msub.asset_inventory
and ml2.lookup_type             = 'SYS_YES_NO'
and ml2.lookup_code             = msub.quantity_tracked
-- Revision for version 1.9
and ml3.lookup_type             = 'CST_COST_CODE_TYPE'
and ml3.lookup_code             = 2 -- Material Overhead
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context = 'Accounting Information'
and hoi.organization_id         = mp.organization_id
and hoi.organization_id         = haou.organization_id -- this gets the organization name
and haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
-- Revision for version 1.4
-- Avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
-- Revision for version 1.6
and fu1.user_id                 = msub.created_by
and fu2.user_id                 = msub.last_updated_by
-- Revision for version 1.1, 1.3
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                                                           -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Resource Account
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 -- Revision for version 1.4
 haou.name Organization_Name,
 -- Revision for version 1.4
 (select ccg.cost_group
  from   cst_cost_groups ccg
  where  ccg.cost_group_id  = msub.default_cost_group_id) Cost_Group,
  -- End revision for version 1.4
 msub.secondary_inventory_name Subinventory,
 -- Revision for version 1.8
 ml1.meaning Inventory_Asset,
 ml2.meaning Quantity_Tracked,
 -- Revision for version 1.9
 -- 'Resource Account' Account_Type,
 ml3.meaning Account_Type,
 &segment_columns
 -- Revision for version 1.4
 -- Revision for version 1.3
 -- decode(msub.attribute1, 'Y', 'Yes', 'No') Use Item_Type Accts,
 -- Revision for version 1.6
 msub.creation_date Creation_Date,
 msub.disable_date Disable_Date,
 fu1.user_name Created_By,
 fu2.user_name Last_Updated_By
 -- End revision for version 1.6
from -- Revision for version 1.4
 -- Get valuation accounts based on Costing Method and Cost Group Accounting
 -- mtl_secondary_inventories msub,
 (-- Standard Costing, no Cost Group Accounting
  select msub.organization_id,
  msub.secondary_inventory_name,
  msub.resource_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and nvl(mp.cost_group_accounting,2) = 2 -- No
  and mp.primary_cost_method = 1 -- Standard Costing
  union all
  -- Not Standard Costing, no Cost Group Accounting
  select msub.organization_id,
  msub.secondary_inventory_name,
  mp.resource_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and nvl(mp.cost_group_accounting,2) = 2 -- No
  and mp.primary_cost_method <> 1 -- not Standard Costing
  union all
  -- With Cost Group Accounting
  select msub.organization_id,
  msub.secondary_inventory_name,
  ccga.resource_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  cst_cost_group_accounts ccga,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and mp.cost_group_accounting = 1 -- Yes
  and ccga.cost_group_id = msub.default_cost_group_id
  union all
  -- Cost Group Accounting but the Subinventory Cost Group Id is null
  select msub.organization_id,
  msub.secondary_inventory_name,
  ccga.resource_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  cst_cost_group_accounts ccga,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and mp.cost_group_accounting = 1 -- Yes
  and msub.default_cost_group_id is null
  and ccga.cost_group_id = mp.default_cost_group_id
 ) msub,
 -- End for revision 1.4
 mtl_parameters mp,
 -- Revision for version 1.8
 mfg_lookups ml1,
 mfg_lookups ml2,
 -- Revision for version 1.9
 mfg_lookups ml3, -- Account Type
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 fnd_user fu1,
 fnd_user fu2
where msub.resource_account       = gcc.code_combination_id (+)
and msub.organization_id        = mp.organization_id
-- Revision for version 1.8
and ml1.lookup_type             = 'SYS_YES_NO'
and ml1.lookup_code             = msub.asset_inventory
and ml2.lookup_type             = 'SYS_YES_NO'
and ml2.lookup_code             = msub.quantity_tracked
-- Revision for version 1.9
and ml3.lookup_type             = 'CST_COST_CODE_TYPE'
and ml3.lookup_code             = 3 -- Resource
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context = 'Accounting Information'
and hoi.organization_id         = mp.organization_id
and hoi.organization_id         = haou.organization_id -- this gets the organization name
and haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
-- Revision for version 1.4
-- Avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
-- Revision for version 1.6
and fu1.user_id                 = msub.created_by
and fu2.user_id                 = msub.last_updated_by
-- Revision for version 1.1, 1.3
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                                                           -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Outside Processing Account
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 -- Revision for version 1.4
 haou.name Organization_Name,
 -- Revision for version 1.4
 (select ccg.cost_group
  from   cst_cost_groups ccg
  where  ccg.cost_group_id  = msub.default_cost_group_id) Cost_Group,
  -- End revision for version 1.4
  msub.secondary_inventory_name Subinventory,
 -- Revision for version 1.8
 ml1.meaning Inventory_Asset,
 ml2.meaning Quantity_Tracked,
 -- Revision for version 1.9
 -- 'OSP Account' Account_Type,
 ml3.meaning Account_Type,
 &segment_columns
 -- Revision for version 1.4
 -- Revision for version 1.3
 -- decode(msub.attribute1, 'Y', 'Yes', 'No') Use Item_Type Accts,
 -- Revision for version 1.6
 msub.creation_date Creation_Date,
 msub.disable_date Disable_Date,
 fu1.user_name Created_By,
 fu2.user_name Last_Updated_By
 -- End revision for version 1.6
from -- Revision for version 1.4
 -- Get valuation accounts based on Costing Method and Cost Group Accounting
 -- mtl_secondary_inventories msub,
 (-- Standard Costing, no Cost Group Accounting
  select msub.organization_id,
  msub.secondary_inventory_name,
  msub.outside_processing_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and nvl(mp.cost_group_accounting,2) = 2 -- No
  and mp.primary_cost_method = 1 -- Standard Costing
  union all
  -- Not Standard Costing, no Cost Group Accounting
  select msub.organization_id,
  msub.secondary_inventory_name,
  mp.outside_processing_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and nvl(mp.cost_group_accounting,2) = 2 -- No
  and mp.primary_cost_method <> 1 -- not Standard Costing
  union all
  -- With Cost Group Accounting
  select msub.organization_id,
  msub.secondary_inventory_name,
  ccga.outside_processing_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  cst_cost_group_accounts ccga,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and mp.cost_group_accounting = 1 -- Yes
  and ccga.cost_group_id = msub.default_cost_group_id
  union all
  -- Cost Group Accounting but the Subinventory Cost Group Id is null
  select msub.organization_id,
  msub.secondary_inventory_name,
  ccga.outside_processing_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  cst_cost_group_accounts ccga,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and mp.cost_group_accounting = 1 -- Yes
  and msub.default_cost_group_id is null
  and ccga.cost_group_id = mp.default_cost_group_id
 ) msub,
 -- End for revision 1.4
 mtl_parameters mp,
 -- Revision for version 1.8
 mfg_lookups ml1,
 mfg_lookups ml2,
 -- Revision for version 1.9
 mfg_lookups ml3, -- Account Type
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 fnd_user fu1,
 fnd_user fu2
where msub.outside_processing_account = gcc.code_combination_id (+)
and msub.organization_id        = mp.organization_id
-- Revision for version 1.8
and ml1.lookup_type             = 'SYS_YES_NO'
and ml1.lookup_code             = msub.asset_inventory
and ml2.lookup_type             = 'SYS_YES_NO'
and ml2.lookup_code             = msub.quantity_tracked
-- Revision for version 1.9
and ml3.lookup_type             = 'CST_COST_CODE_TYPE'
and ml3.lookup_code             = 4 -- Outside Processing
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context = 'Accounting Information'
and hoi.organization_id         = mp.organization_id
and hoi.organization_id         = haou.organization_id -- this gets the organization name
and haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
-- Revision for version 1.4
-- Avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
-- Revision for version 1.6
and fu1.user_id                 = msub.created_by
and fu2.user_id                 = msub.last_updated_by
-- Revision for version 1.1, 1.3
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                                                           -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Overhead Account
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 -- Revision for version 1.4
 haou.name Organization_Name,
 -- Revision for version 1.4
 (select ccg.cost_group
  from   cst_cost_groups ccg
  where  ccg.cost_group_id  = msub.default_cost_group_id) Cost_Group,
 -- End revision for version 1.4
 msub.secondary_inventory_name Subinventory,
 -- Revision for version 1.8
 ml1.meaning Inventory_Asset,
 ml2.meaning Quantity_Tracked,
 -- Revision for version 1.9
 -- 'Overhead Account' Account_Type,
 ml3.meaning Account_Type,
 &segment_columns
 -- Revision for version 1.6
 msub.creation_date Creation_Date,
 msub.disable_date Disable_Date,
 fu1.user_name Created_By,
 fu2.user_name Last_Updated_By
 -- End revision for version 1.6
from -- Revision for version 1.4
 -- Get valuation accounts based on Costing Method and Cost Group Accounting
 -- mtl_secondary_inventories msub,
 (-- Standard Costing, no Cost Group Accounting
  select msub.organization_id,
  msub.secondary_inventory_name,
  msub.overhead_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and nvl(mp.cost_group_accounting,2) = 2 -- No
  and mp.primary_cost_method = 1 -- Standard Costing
  union all
  -- Not Standard Costing, no Cost Group Accounting
  select msub.organization_id,
  msub.secondary_inventory_name,
  mp.overhead_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and nvl(mp.cost_group_accounting,2) = 2 -- No
  and mp.primary_cost_method <> 1 -- not Standard Costing
  union all
  -- With Cost Group Accounting
  select msub.organization_id,
  msub.secondary_inventory_name,
  ccga.overhead_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  cst_cost_group_accounts ccga,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and mp.cost_group_accounting = 1 -- Yes
  and ccga.cost_group_id = msub.default_cost_group_id
  union all
  -- Cost Group Accounting but the Subinventory Cost Group Id is null
  select msub.organization_id,
  msub.secondary_inventory_name,
  ccga.overhead_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  cst_cost_group_accounts ccga,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and mp.cost_group_accounting = 1 -- Yes
  and msub.default_cost_group_id is null
  and ccga.cost_group_id = mp.default_cost_group_id
 ) msub,
 -- End for revision 1.4
 mtl_parameters mp,
 -- Revision for version 1.8
 mfg_lookups ml1,
 mfg_lookups ml2,
 -- Revision for version 1.9
 mfg_lookups ml3, -- Account Type
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 fnd_user fu1,
 fnd_user fu2
where msub.overhead_account       = gcc.code_combination_id (+)
and msub.organization_id        = mp.organization_id
-- Revision for version 1.8
and ml1.lookup_type             = 'SYS_YES_NO'
and ml1.lookup_code             = msub.asset_inventory
and ml2.lookup_type             = 'SYS_YES_NO'
and ml2.lookup_code             = msub.quantity_tracked
-- Revision for version 1.9
and ml3.lookup_type             = 'CST_COST_CODE_TYPE'
and ml3.lookup_code             = 5 -- Overhead
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context = 'Accounting Information'
and hoi.organization_id         = mp.organization_id
and hoi.organization_id         = haou.organization_id -- this gets the organization name
and haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
-- Revision for version 1.4
-- Avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
-- Revision for version 1.6
and fu1.user_id                 = msub.created_by
and fu2.user_id                 = msub.last_updated_by
-- Revision for version 1.1, 1.3
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                                                           -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Expense Account
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 -- Revision for version 1.4
 haou.name Organization_Name,
 -- Revision for version 1.4
 (select ccg.cost_group
  from   cst_cost_groups ccg
  where  ccg.cost_group_id  = msub.default_cost_group_id) Cost_Group,
 -- End revision for version 1.4
 msub.secondary_inventory_name Subinventory,
 -- Revision for version 1.8
 ml1.meaning Inventory_Asset,
 ml2.meaning Quantity_Tracked,
 -- Revision for version 1.9
 -- 'Expense Account' Account_Type,
 ml3.meaning Account_Type,
 &segment_columns
 -- Revision for version 1.6
 msub.creation_date Creation_Date,
 msub.disable_date Disable_Date,
 fu1.user_name Created_By,
 fu2.user_name Last_Updated_By
 -- End revision for version 1.6
from -- Revision for version 1.4
 -- Get valuation accounts based on Costing Method and Cost Group Accounting
 -- mtl_secondary_inventories msub,
 (-- Standard Costing, no Cost Group Accounting
  select msub.organization_id,
  msub.secondary_inventory_name,
  msub.expense_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and nvl(mp.cost_group_accounting,2) = 2 -- No
  and mp.primary_cost_method = 1 -- Standard Costing
  union all
  -- Not Standard Costing, no Cost Group Accounting
  select msub.organization_id,
  msub.secondary_inventory_name,
  mp.expense_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and nvl(mp.cost_group_accounting,2) = 2 -- No
  and mp.primary_cost_method <> 1 -- not Standard Costing
  union all
  -- With Cost Group Accounting
  select msub.organization_id,
  msub.secondary_inventory_name,
  ccga.expense_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  cst_cost_group_accounts ccga,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and mp.cost_group_accounting = 1 -- Yes
  and ccga.cost_group_id = msub.default_cost_group_id
  union all
  -- Cost Group Accounting but the Subinventory Cost Group Id is null
  select msub.organization_id,
  msub.secondary_inventory_name,
  ccga.expense_account,
  msub.asset_inventory,
  msub.quantity_tracked,
  msub.default_cost_group_id,
  -- Revision for version 1.6
  msub.creation_date,
  msub.disable_date,
  msub.created_by,
  msub.last_updated_by
  -- End revision for version 1.6
  from mtl_secondary_inventories msub,
  cst_cost_group_accounts ccga,
  mtl_parameters mp
  where msub.organization_id = mp.organization_id
  and mp.cost_group_accounting = 1 -- Yes
  and msub.default_cost_group_id is null
  and ccga.cost_group_id = mp.default_cost_group_id
 ) msub,
 -- End for revision 1.4
 mtl_parameters mp,
 -- Revision for version 1.8
 mfg_lookups ml1,
 mfg_lookups ml2,
 -- Revision for version 1.9
 mfg_lookups ml3, -- Account Type
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 fnd_user fu1,
 fnd_user fu2
where msub.expense_account        = gcc.code_combination_id (+)
and msub.organization_id        = mp.organization_id
-- Revision for version 1.8
and ml1.lookup_type             = 'SYS_YES_NO'
and ml1.lookup_code             = msub.asset_inventory
and ml2.lookup_type             = 'SYS_YES_NO'
and ml2.lookup_code             = msub.quantity_tracked
-- Revision for version 1.9
and ml3.lookup_type             = 'CST_ACCOUNT_TYPE'
and ml3.lookup_code             = 3 -- Expense
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context = 'Accounting Information'
and hoi.organization_id         = mp.organization_id
and hoi.organization_id         = haou.organization_id -- this gets the organization name
and haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
-- Revision for version 1.4
-- Avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
-- Revision for version 1.6
and fu1.user_id                 = msub.created_by
and fu2.user_id                 = msub.last_updated_by
-- Revision for version 1.1, 1.3
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                                                           -- p_org_code, p_operating_unit, p_ledger
-- End revision for version 1.1, 1.3
-- Order by Status, Ledger, Operating_Unit, Org_Code, Cost_Type, Resource_Code, Res Basis, Department and Overhead Code
order by 1,2,3,6,10
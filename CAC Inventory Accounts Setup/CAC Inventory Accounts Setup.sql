/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inventory Accounts Setup
-- Description: Report to show Valuation, Receiving, Profit and Loss and Inter-Org accounts as setup in the inventory organization parameters.

/* +=============================================================================+
-- |  Copyright 2009 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_inv_accts_setup_rept.sql
-- |
-- |  Parameters:
-- |  p_account_group    -- The group of inventory organization parameter accounts
-- |                        you wish to report
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |  Description:
-- |  Report to show Valuation, Receiving, Profit and Loss and Inter-Org accounts
-- |  as setup in the inventory organization parameters
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.11    06 Mar 2019 Douglas Volz   Added Cost Variance Account, used with Average, FIFO, LIFO
-- |  1.12    14 Mar 2019 Douglas Volz   Added Expense A/P Accrual Account, Retroactive Price
-- |                                     Adjustment Account, Receiving Clearing Account.
-- |  1.13    12 Jan 2020 Douglas Volz   Added Org Code and Operating Unit parameters,
-- |                                     an outer join to gcc in case of invalid accounts
-- |                                     and change to gl.short_name.
-- |  1.14    28 Feb 2020 Douglas Volz   Changed to multi-language views for the item
-- |                                     master, inventory orgs and operating units.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-inventory-accounts-setup/
-- Library Link: https://www.enginatics.com/reports/cac-inventory-accounts-setup/
-- Run Report: https://demo.enginatics.com/

select 'Inter-org' Account_Group,
-- ===========================================
-- This first group of select statements is for
-- the Inter-Org Accounts Group
-- ===========================================
 'Inter-Org A/P Account' Account_Type,
 nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 &segment_columns
 mp.last_update_date Last_Update_Date
from mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl
where mp.interorg_payables_account     = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context      = 'Accounting Information'
and hoi.organization_id              = mp.organization_id
and hoi.organization_id              = haou.organization_id -- this gets the organization name
and haou2.organization_id            = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                     = to_number(hoi.org_information1) -- get the ledger_id
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                                                                                                   -- p_ledger, p_operating_unit, p_org_code
and (:p_account_group = 'Inter-Org'
  or
  :p_account_group is null)                                                                          -- inter-org
-- Fix for version 1.4
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
union all
select 'Inter-org' Account_Group,
 'Inter-Org A/R Account' Account_Type,
 nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 &segment_columns
 mp.last_update_date Last_Update_Date
from mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl
where mp.interorg_receivables_account = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                                                                                                   -- p_ledger, p_operating_unit, p_org_code
and (:p_account_group = 'Inter-Org'
  or
  :p_account_group is null)                                                                          -- inter-org
-- Fix for version 1.4
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
union all
select 'Inter-org' Account_Group,
 'Intransit Account' Account_Type,
 nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 &segment_columns
 mp.last_update_date Last_Update_Date
from mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl
where mp.intransit_inv_account        = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                                                                                                   -- p_ledger, p_operating_unit, p_org_code
and (:p_account_group = 'Inter-Org'
  or
  :p_account_group is null)                                                                          -- inter-org
-- Fix for version 1.4
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
union all
select 'Inter-org' Account_Group,
 'Inter-Org PPV Account' Account_Type,
 nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 &segment_columns
 mp.last_update_date Last_Update_Date
from mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl
where mp.interorg_price_var_account   = gcc.code_combination_id (+)
 -- ===========================================
 -- Organization joins to the HR org model
 -- ===========================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                                                                                                   -- p_ledger, p_operating_unit, p_org_code
and (:p_account_group = 'Inter-Org'
  or
  :p_account_group is null)                                                                          -- inter-org
-- Fix for version 1.4
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
union all
select 'Inter-org' Account_Group,
 'Inter-Org Xfer Credit Account' Account_Type,
 nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 &segment_columns
 mp.last_update_date Last_Update_Date
from mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl
where mp.interorg_transfer_cr_account = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                                                                                                   -- p_ledger, p_operating_unit, p_org_code
and (:p_account_group = 'Inter-Org'
  or
  :p_account_group is null)                                                                          -- inter-org
-- Fix for version 1.4
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
union all
-- ===========================================
-- This second group of select statements is
-- for the Profit and Loss Account_Group
-- ===========================================
select 'Profit and Loss' Account_Group,
 'Cost of Goods Sold Account' Account_Type,
 nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 &segment_columns
 mp.last_update_date Last_Update_Date
from mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl
where mp.cost_of_sales_account        = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                                                                                                   -- p_ledger, p_operating_unit, p_org_code
and (:p_account_group = 'Profit and Loss'
  or
  :p_account_group is null)                                                                          -- Profit and Loss
-- Fix for version 1.4
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
union all
select 'Profit and Loss' Account_Group,
 'Sales_Account' Account_Type,
 nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 &segment_columns
 mp.last_update_date Last_Update_Date
from mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl
where mp.sales_account                = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id = to_number(hoi.org_information1) -- get the ledger_id
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                                                                                                   -- p_ledger, p_operating_unit, p_org_codee
and (:p_account_group = 'Profit and Loss'
  or
  :p_account_group is null)                                                                          -- Profit and Loss
-- Fix for version 1.4
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
union all
-- ===========================================
-- This third group of select statements is
-- for the Other Accounts Group
-- ===========================================
-- Revision for version 1.5, change Account_Group for Deferred COGS
-- select 'Profit and Loss' Account_Group,
select 'Other Accounts' Account_Group,
 'Deferred COGS_Account' Account_Type,
 nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 &segment_columns
 mp.last_update_date Last_Update_Date
from mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl
where mp.deferred_cogs_account        = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                                                                                                   -- p_ledger, p_operating_unit, p_org_code
and (:p_account_group = 'Profit and Loss'
  or
  :p_account_group is null)                                                                          -- Profit and Loss
-- Fix for version 1.4
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
/* +=============================================================================+
-- Revision for version 1.15
-- Comment this out, mp.cat_wt_account not found at client site
-- +=============================================================================+
union all
-- Revision for version 1.5, add On-Hand Adjustment Account
-- Usually only in use for OPM organizations
select 'Other Accounts' Account_Group,
 'On-Hand Adjustment Account' Account_Type,
 nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 &segment_columns
 mp.last_update_date Last_Update_Date
from mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl
where mp.cat_wt_account               = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                                                                                                   -- p_ledger, p_operating_unit, p_org_code
and (:p_account_group = 'Other Accounts'
  or
  :p_account_group is null)                                                                          -- Other Accounts
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
-- End revision for version 1.5
-- +=============================================================================+
-- End of commenting out, end of revision for version 1.15
-- +=============================================================================+*/
union all
-- Revision for version 1.6, add Expense Accounts to this report
select 'Other Accounts' Account_Group,
 'Expense Account' Account_Type,
 nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 &segment_columns
 mp.last_update_date Last_Update_Date
from mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl
where mp.expense_account              = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                                                                                                   -- p_ledger, p_operating_unit, p_org_code
and (:p_account_group = 'Other Accounts'
  or
  :p_account_group is null)                                                                          -- Other Accounts
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
-- End revision for version 1.6
union all
-- Revision for version 1.11, add Cost Variance Account to this report
select 'Other Accounts' Account_Group,
 'Avg Cost Variance Account' Account_Type,
 nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 &segment_columns
 mp.last_update_date Last_Update_Date
from mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl
where mp.average_cost_var_account     = gcc.code_combination_id (+)
 -- ===========================================
 -- Organization joins to the HR org model
 -- ===========================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                                                                                                   -- p_ledger, p_operating_unit, p_org_code
and (:p_account_group = 'Other Accounts'
  or
  :p_account_group is null)                                                                          -- Other Accounts
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
-- End revision for version 1.11
union all
-- ===========================================
-- This third group of select statements is
-- for the Receiving Accounts Group
-- ===========================================
select 'Receiving' Account_Group,
 'Inv. A/P Accrual Account' Account_Type,
 nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 &segment_columns
 mp.last_update_date Last_Update_Date
from mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl
where mp.ap_accrual_account           = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                                                                                                   -- p_ledger, p_operating_unit, p_org_code
and (:p_account_group = 'Receiving'
  or
  :p_account_group is null)                                                                          -- Receiving
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
-- End fix for version 1.4
union all
-- Revision for version 1.9, add Warehouse Mgmt System (Wms) 
-- Default Goods Dispatched Account
-- from the Shipping Parameters, wsh_shipping_parameters.  
-- The Trip Stop Interface fails if this ccid is not populated
select 'Shipping' Account_Group,
 'Goods Dispatched Account' Account_Type,
 nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 &segment_columns
 mp.last_update_date Last_Update_Date
from wsh_shipping_parameters wsp,
 mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl
where wsp.organization_id             = mp.organization_id
-- Use an outer join to allow null values
-- as the Shipping Parameters form has this as
-- an optional field as opposed to a required field
and wsp.goods_dispatched_account    = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                                                                                                   -- p_ledger, p_operating_unit, p_org_code
and (:p_account_group = 'Other Accounts'
  or
  :p_account_group is null)                                                                          -- Other Accounts
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
-- End revision for version 1.9
union all
select 'Receiving' Account_Group,
 'IPV Account' Account_Type,
 nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 &segment_columns
 mp.last_update_date Last_Update_Date
from mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl
where mp.invoice_price_var_account    = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                                                                                                   -- p_ledger, p_operating_unit, p_org_code
and (:p_account_group = 'Receiving'
  or
  :p_account_group is null)                                                                          -- Receiving
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
-- End fix for version 1.4
union all
select 'Receiving' Account_Group,
 'PPV Account' Account_Type,
 nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 &segment_columns
 mp.last_update_date Last_Update_Date
from mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl
where mp.purchase_price_var_account   = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release
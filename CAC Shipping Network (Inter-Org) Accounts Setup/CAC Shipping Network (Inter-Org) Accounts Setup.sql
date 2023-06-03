/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Shipping Network (Inter-Org) Accounts Setup
-- Description: Report to show accounts used for the inter-org shipping network.  If the accounts are missing or invalid the account segments are shown as blank entries.

/* +=============================================================================+
-- |  Copyright 2009 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_interorg_setup_accts_rept.sql
-- |
-- |  Parameters:
-- |  p_from_org_code       -- Specific from inventory organization you wish to report (optional)
-- |  p_from_operating_unit -- From operating Unit you wish to report, leave blank for all
-- |                           operating units (optional) 
-- |  p_ledger              -- general ledger you wish to report, leave blank for all
-- |                           ledgers (optional) 
-- |  Description:
-- |  Report to show accounts used for the inter-org shipping network.  If the
-- |  accounts are missing or invalid the account segments are shown as blank entries.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     24 Nov 2009 Douglas Volz   Initial Coding
-- |  1.1     28 Oct 2010 Douglas Volz   Added ledger parameter
-- |  1.2     25 Sep 2014 Douglas Volz   Removed mfg_lookup for FOB point, was 
-- |                                     skipping direct transfers
-- |  1.3     07 Jan 2015 Douglas Volz   Minor bug fixes
-- |  1.4     08 Oct 2015 Douglas Volz   Modify for latest client's COA
-- |  1.5     06 Oct 2016 Douglas Volz   Modified for latest client's COA
-- |  1.6     16 Jan 2017 Douglas Volz   Added Internal Order Flag Required,
-- |                                     Elemental Visibility Enabled and
-- |                                     Profit in Inventory Account
-- |  1.7     21 Jan 2017 Douglas Volz   Added Manual Receipt required for expenses flag
-- |  1.8     17 Jul 2018 Douglas Volz   Modified chart of accounts for client
-- |  1.9     16 Oct 2018 Douglas Volz   Retrofitted to Release 11i and added To-Org
-- |                                     Operating Unit
-- |  1.10    18 Oct 2018 Douglas Volz   Added InterOrg Transfer Code and Percentage
-- |  1.11    11 Jul 2019 Douglas Volz   Changed to G/L short name, chg to Release 12
-- |  1.12    17 Jan 2020 Douglas Volz   Add Org Code and Operating Unit parameters.
-- |  1.13    20 Apr 2020 Douglas Volz   Add outer join for gl code combinations, for
-- |                                     invalid or missing accounts (CCIDs).
-- |  1.14    27 Apr 2020 Douglas Volz   Changed to multi-language views for the 
-- |                                     inventory orgs and operating units.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-shipping-network-inter-org-accounts-setup/
-- Library Link: https://www.enginatics.com/reports/cac-shipping-network-inter-org-accounts-setup/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
 haou2.name From_Operating_Unit,
 mp.organization_code From_Org_Code,
 mp.organization_name From_Org_Name,
 -- Revision for version 1.9
 haou3.name To_Operating_Unit,
 mp2.organization_code To_Org_Code,
 -- Revision for version 1.10
 ml1.meaning Transfer_Charge_Type,
 mip.interorg_trnsfr_charge_percent Transfer_Percent,
 -- End revision for version 1.10
 'Intransit Account' Account_Type,
 -- Revision for version 1.14
 intransit_type.meaning Intransit_Type,
 ml2.meaning FOB_Point,
 ml3.meaning Internal_Order_Required,
 fl1.meaning Elemental_Visibility,
 fl2.meaning Manual_Receipt_at_Expense_Dest,
 -- End revision for version 1.14
 &segment_columns
 mip.creation_date Creation_Date,
 mip.last_update_date Last_Update_Date
from mtl_interorg_parameters mip,
 org_organization_definitions mp,
 mtl_parameters mp2,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 -- Revision for version 1.9
 -- Add in the To-Org Operating_Unit
 hr_organization_information hoi2,
 hr_all_organization_units_vl haou3,
 gl_ledgers gl,
 -- End revision for version 1.9
 -- Revision for version 1.14
 -- Compound join, as the Shipping Network Form
 -- INVSDOSI is hard-coded to 'Direct' and 'Intransit'
 (select 2 lookup_code,
  ml.meaning
  from mfg_lookups ml
  where ml.lookup_type  = 'MSC_CALENDAR_TYPE'
  and ml.lookup_code  = '3' -- Intransit 
  union
  select 1 lookup_code,
  fl.meaning
  from fnd_lookups fl
  where fl.lookup_type  = 'PV_PURCHASE_METHOD'
  and fl.lookup_code  = 'DIRECT'
 ) intransit_type,
 mfg_lookups ml1, -- transfer charge type, SYS_YES_NO
 mfg_lookups ml2, -- FOB_POINT, SYS_YES_NO
 mfg_lookups ml3, -- internal order required, SYS_YES_NO
 fnd_lookups fl1, -- elemental visibility, YES_NO
 fnd_lookups fl2  -- manual receipt expense, YES_NO
 -- End revision for version 1.14
where mip.intransit_inv_account        = gcc.code_combination_id (+)
and mip.from_organization_id         = mp.organization_id
and mip.to_organization_id           = mp2.organization_id
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context      = 'Accounting Information'
and hoi.organization_id              = mp.organization_id
and hoi.organization_id              = haou.organization_id -- this gets the organization name
and haou2.organization_id            = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                     = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and sysdate                          < nvl(haou.date_to, sysdate +1)
-- Add in the To-Org Operating_Unit
and hoi2.org_information_context     = 'Accounting Information'
and hoi2.organization_id             = mp2.organization_id
and haou3.organization_id            = to_number(hoi2.org_information3) -- this gets the operating unit id
-- End revision for version 1.9
and 1=1                              -- p_from_org_code, p_from_operating_unit, p_ledger
-- ===========================================
-- Lookup Codes
-- ===========================================
-- Revision for version 1.14
and intransit_type.lookup_code       = mip.intransit_type
and ml1.lookup_code (+)              = mip.matl_interorg_transfer_code
and ml1.lookup_type (+)              = 'MTL_INTER_INV_TRANSFER'
and ml2.lookup_code (+)              = mip.fob_point
and ml2.lookup_type (+)              = 'MTL_FOB_POINT'
and ml3.lookup_code (+)              = mip.internal_order_required_flag
and ml3.lookup_type (+)              = 'SYS_YES_NO'
and fl1.lookup_code (+)              = mip.elemental_visibility_enabled
and fl1.lookup_type (+)              = 'YES_NO'
and fl2.lookup_code (+)              = mip.manual_receipt_expense
and fl2.lookup_type (+)              = 'YES_NO'
-- End revision for version 1.14
union all
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name From_Operating_Unit,
 mp.organization_code From_Org_Code,
 mp.organization_name From_Org_Name,
 -- Revision for version 1.9
 haou3.name To_Operating_Unit,
 mp2.organization_code To_Org_Code,
 -- Revision for version 1.10
 ml1.meaning Transfer_Charge_Type,
 mip.interorg_trnsfr_charge_percent Transfer_Percent,
 -- End revision for version 1.10
 'InterOrg Xfer CR Account' Account_Type,
 -- Revision for version 1.14
 intransit_type.meaning Intransit_Type,
 ml2.meaning FOB_Point,
 ml3.meaning Internal_Order_Required,
 fl1.meaning Elemental_Visibility,
 fl2.meaning Manual_Receipt_at_Expense_Dest,
 -- End revision for version 1.14
 &segment_columns
 mip.creation_date Creation_Date,
 mip.last_update_date Last_Update_Date
from mtl_interorg_parameters mip,
 org_organization_definitions mp,
 mtl_parameters mp2,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 -- Revision for version 1.9
 -- Add in the To-Org Operating_Unit
 hr_organization_information hoi2,
 hr_all_organization_units_vl haou3,
 gl_ledgers gl,
 -- Revision for version 1.14
 -- Compound join, as the Shipping Network Form
 -- INVSDOSI is hard-coded to 'Direct' and 'Intransit'
 (select 2 lookup_code,
  ml.meaning
  from mfg_lookups ml
  where ml.lookup_type  = 'MSC_CALENDAR_TYPE'
  and ml.lookup_code  = '3' -- Intransit 
  union
  select 1 lookup_code,
  fl.meaning
  from fnd_lookups fl
  where fl.lookup_type  = 'PV_PURCHASE_METHOD'
  and fl.lookup_code  = 'DIRECT'
 ) intransit_type,
 mfg_lookups ml1, -- transfer charge type, SYS_YES_NO
 mfg_lookups ml2, -- FOB_POINT, SYS_YES_NO
 mfg_lookups ml3, -- internal order required, SYS_YES_NO
 fnd_lookups fl1, -- elemental visibility, YES_NO
 fnd_lookups fl2  -- manual receipt expense, YES_NO
 -- End revision for version 1.14
where mip.interorg_transfer_cr_account = gcc.code_combination_id (+)
and mip.from_organization_id         = mp.organization_id
and mip.to_organization_id           = mp2.organization_id
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context      = 'Accounting Information'
and hoi.organization_id              = mp.organization_id
and hoi.organization_id              = haou.organization_id -- this gets the organization name
and haou2.organization_id            = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                     = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and sysdate                          < nvl(haou.date_to, sysdate +1)
-- Add in the To-Org Operating_Unit
and hoi2.org_information_context     = 'Accounting Information'
and hoi2.organization_id             = mp2.organization_id
and haou3.organization_id            = to_number(hoi2.org_information3) -- this gets the operating unit id
-- End revision for version 1.9
and 1=1                              -- p_from_org_code, p_from_operating_unit, p_ledger
-- ===========================================
-- Lookup Codes
-- ===========================================
-- Revision for version 1.14
and intransit_type.lookup_code       = mip.intransit_type
and ml1.lookup_code (+)              = mip.matl_interorg_transfer_code
and ml1.lookup_type (+)              = 'MTL_INTER_INV_TRANSFER'
and ml2.lookup_code (+)              = mip.fob_point
and ml2.lookup_type (+)              = 'MTL_FOB_POINT'
and ml3.lookup_code (+)              = mip.internal_order_required_flag
and ml3.lookup_type (+)              = 'SYS_YES_NO'
and fl1.lookup_code (+)              = mip.elemental_visibility_enabled
and fl1.lookup_type (+)              = 'YES_NO'
and fl2.lookup_code (+)              = mip.manual_receipt_expense
and fl2.lookup_type (+)              = 'YES_NO'
-- End revision for version 1.14
union all
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name From_Operating_Unit,
 mp.organization_code From_Org_Code,
 mp.organization_name From_Org_Name,
 -- Revision for version 1.9
 haou3.name To_Operating_Unit,
 mp2.organization_code To_Org_Code,
 -- Revision for version 1.10
 ml1.meaning Transfer_Charge_Type,
 mip.interorg_trnsfr_charge_percent Transfer_Percent,
 -- End revision for version 1.10
 'InterOrg A/R Account' Account_Type,
 -- Revision for version 1.14
 intransit_type.meaning Intransit_Type,
 ml2.meaning FOB_Point,
 ml3.meaning Internal_Order_Required,
 fl1.meaning Elemental_Visibility,
 fl2.meaning Manual_Receipt_at_Expense_Dest,
 -- End revision for version 1.14
 &segment_columns
 mip.creation_date Creation_Date,
 mip.last_update_date Last_Update_Date
from mtl_interorg_parameters mip,
 org_organization_definitions mp,
 mtl_parameters mp2,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 -- Revision for version 1.9
 -- Add in the To-Org Operating_Unit
 hr_organization_information hoi2,
 hr_all_organization_units_vl haou3,
 gl_ledgers gl,
 -- Revision for version 1.14
 -- Compound join, as the Shipping Network Form
 -- INVSDOSI is hard-coded to 'Direct' and 'Intransit'
 (select 2 lookup_code,
  ml.meaning
  from mfg_lookups ml
  where ml.lookup_type  = 'MSC_CALENDAR_TYPE'
  and ml.lookup_code  = '3' -- Intransit 
  union
  select 1 lookup_code,
  fl.meaning
  from fnd_lookups fl
  where fl.lookup_type  = 'PV_PURCHASE_METHOD'
  and fl.lookup_code  = 'DIRECT'
 ) intransit_type,
 mfg_lookups ml1, -- transfer charge type, SYS_YES_NO
 mfg_lookups ml2, -- FOB_POINT, SYS_YES_NO
 mfg_lookups ml3, -- internal order required, SYS_YES_NO
 fnd_lookups fl1, -- elemental visibility, YES_NO
 fnd_lookups fl2  -- manual receipt expense, YES_NO
 -- End revision for version 1.14
where mip.interorg_receivables_account = gcc.code_combination_id (+)
and mip.from_organization_id         = mp.organization_id
and mip.to_organization_id           = mp2.organization_id
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context      = 'Accounting Information'
and hoi.organization_id              = mp.organization_id
and hoi.organization_id              = haou.organization_id -- this gets the organization name
and haou2.organization_id            = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                     = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and sysdate                          < nvl(haou.date_to, sysdate +1)
-- Add in the To-Org Operating_Unit
and hoi2.org_information_context     = 'Accounting Information'
and hoi2.organization_id             = mp2.organization_id
and haou3.organization_id            = to_number(hoi2.org_information3) -- this gets the operating unit id
-- End revision for version 1.9
and 1=1                              -- p_from_org_code, p_from_operating_unit, p_ledger
-- ===========================================
-- Lookup Codes
-- ===========================================
-- Revision for version 1.14
and intransit_type.lookup_code       = mip.intransit_type
and ml1.lookup_code (+)              = mip.matl_interorg_transfer_code
and ml1.lookup_type (+)              = 'MTL_INTER_INV_TRANSFER'
and ml2.lookup_code (+)              = mip.fob_point
and ml2.lookup_type (+)              = 'MTL_FOB_POINT'
and ml3.lookup_code (+)              = mip.internal_order_required_flag
and ml3.lookup_type (+)              = 'SYS_YES_NO'
and fl1.lookup_code (+)              = mip.elemental_visibility_enabled
and fl1.lookup_type (+)              = 'YES_NO'
and fl2.lookup_code (+)              = mip.manual_receipt_expense
and fl2.lookup_type (+)              = 'YES_NO'
-- End revision for version 1.14
union all
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name From_Operating_Unit,
 mp.organization_code From_Org_Code,
 mp.organization_name From_Org_Name,
 -- Revision for version 1.9
 haou3.name To_Operating_Unit,
 mp2.organization_code To_Org_Code,
 -- Revision for version 1.10
 ml1.meaning Transfer_Charge_Type,
 mip.interorg_trnsfr_charge_percent Transfer_Percent,
 -- End revision for version 1.10
 'InterOrg A/P Account' Account_Type,
 -- Revision for version 1.14
 intransit_type.meaning Intransit_Type,
 ml2.meaning FOB_Point,
 ml3.meaning Internal_Order_Required,
 fl1.meaning Elemental_Visibility,
 fl2.meaning Manual_Receipt_at_Expense_Dest,
 -- End revision for version 1.14
 &segment_columns
 mip.creation_date Creation_Date,
 mip.last_update_date Last_Update_Date
from mtl_interorg_parameters mip,
 org_organization_definitions mp,
 mtl_parameters mp2,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 -- Revision for version 1.9
 -- Add in the To-Org Operating_Unit
 hr_organization_information hoi2,
 hr_all_organization_units_vl haou3,
 gl_ledgers gl,
 -- Revision for version 1.14
 -- Compound join, as the Shipping Network Form
 -- INVSDOSI is hard-coded to 'Direct' and 'Intransit'
 (select 2 lookup_code,
  ml.meaning
  from mfg_lookups ml
  where ml.lookup_type  = 'MSC_CALENDAR_TYPE'
  and ml.lookup_code  = '3' -- Intransit 
  union
  select 1 lookup_code,
  fl.meaning
  from fnd_lookups fl
  where fl.lookup_type  = 'PV_PURCHASE_METHOD'
  and fl.lookup_code  = 'DIRECT'
 ) intransit_type,
 mfg_lookups ml1, -- transfer charge type, SYS_YES_NO
 mfg_lookups ml2, -- FOB_POINT, SYS_YES_NO
 mfg_lookups ml3, -- internal order required, SYS_YES_NO
 fnd_lookups fl1, -- elemental visibility, YES_NO
 fnd_lookups fl2  -- manual receipt expense, YES_NO
 -- End revision for version 1.14
where mip.interorg_payables_account    = gcc.code_combination_id (+)
and mip.from_organization_id         = mp.organization_id
and mip.to_organization_id           = mp2.organization_id
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context      = 'Accounting Information'
and hoi.organization_id              = mp.organization_id
and hoi.organization_id              = haou.organization_id -- this gets the organization name
and haou2.organization_id            = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                     = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and sysdate                          < nvl(haou.date_to, sysdate +1)
-- Add in the To-Org Operating_Unit
and hoi2.org_information_context     = 'Accounting Information'
and hoi2.organization_id             = mp2.organization_id
and haou3.organization_id            = to_number(hoi2.org_information3) -- this gets the operating unit id
-- End revision for version 1.9
and 1=1                              -- p_from_org_code, p_from_operating_unit, p_ledger
-- ===========================================
-- Lookup Codes
-- ===========================================
-- Revision for version 1.14
and intransit_type.lookup_code       = mip.intransit_type
and ml1.lookup_code (+)              = mip.matl_interorg_transfer_code
and ml1.lookup_type (+)              = 'MTL_INTER_INV_TRANSFER'
and ml2.lookup_code (+)              = mip.fob_point
and ml2.lookup_type (+)              = 'MTL_FOB_POINT'
and ml3.lookup_code (+)              = mip.internal_order_required_flag
and ml3.lookup_type (+)              = 'SYS_YES_NO'
and fl1.lookup_code (+)              = mip.elemental_visibility_enabled
and fl1.lookup_type (+)              = 'YES_NO'
and fl2.lookup_code (+)              = mip.manual_receipt_expense
and fl2.lookup_type (+)              = 'YES_NO'
-- End revision for version 1.14
union all
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name From_Operating_Unit,
 mp.organization_code From_Org_Code,
 mp.organization_name From_Org_Name,
 -- Revision for version 1.9
 haou3.name To_Operating_Unit,
 mp2.organization_code To_Org_Code,
 -- Revision for version 1.10
 ml1.meaning Transfer_Charge_Type,
 mip.interorg_trnsfr_charge_percent Transfer_Percent,
 -- End revision for version 1.10
 'Interorg PPV Account' Account_Type,
 -- Revision for version 1.14
 intransit_type.meaning Intransit_Type,
 ml2.meaning FOB_Point,
 ml3.meaning Internal_Order_Required,
 fl1.meaning Elemental_Visibility,
 fl2.meaning Manual_Receipt_at_Expense_Dest,
 -- End revision for version 1.14
 &segment_columns
 mip.creation_date Creation_Date,
 mip.last_update_date Last_Update_Date
from mtl_interorg_parameters mip,
 org_organization_definitions mp,
 mtl_parameters mp2,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 -- Revision for version 1.9
 -- Add in the To-Org Operating_Unit
 hr_organization_information hoi2,
 hr_all_organization_units_vl haou3,
 gl_ledgers gl,
 -- Revision for version 1.14
 -- Compound join, as the Shipping Network Form
 -- INVSDOSI is hard-coded to 'Direct' and 'Intransit'
 (select 2 lookup_code,
  ml.meaning
  from mfg_lookups ml
  where ml.lookup_type  = 'MSC_CALENDAR_TYPE'
  and ml.lookup_code  = '3' -- Intransit 
  union
  select 1 lookup_code,
  fl.meaning
  from fnd_lookups fl
  where fl.lookup_type  = 'PV_PURCHASE_METHOD'
  and fl.lookup_code  = 'DIRECT'
 ) intransit_type,
 mfg_lookups ml1, -- transfer charge type, SYS_YES_NO
 mfg_lookups ml2, -- FOB_POINT, SYS_YES_NO
 mfg_lookups ml3, -- internal order required, SYS_YES_NO
 fnd_lookups fl1, -- elemental visibility, YES_NO
 fnd_lookups fl2  -- manual receipt expense, YES_NO
 -- End revision for version 1.14
where mip.interorg_price_var_account   = gcc.code_combination_id (+)
and mip.from_organization_id         = mp.organization_id
and mip.to_organization_id           = mp2.organization_id
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context      = 'Accounting Information'
and hoi.organization_id              = mp.organization_id
and hoi.organization_id              = haou.organization_id -- this gets the organization name
and haou2.organization_id            = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                     = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and sysdate                          < nvl(haou.date_to, sysdate +1)
-- Add in the To-Org Operating_Unit
and hoi2.org_information_context     = 'Accounting Information'
and hoi2.organization_id             = mp2.organization_id
and haou3.organization_id            = to_number(hoi2.org_information3) -- this gets the operating unit id
-- End revision for version 1.9
and 1=1                              -- p_from_org_code, p_from_operating_unit, p_ledger
-- ===========================================
-- Lookup Codes
-- ===========================================
-- Revision for version 1.14
and intransit_type.lookup_code       = mip.intransit_type
and ml1.lookup_code (+)              = mip.matl_interorg_transfer_code
and ml1.lookup_type (+)              = 'MTL_INTER_INV_TRANSFER'
and ml2.lookup_code (+)              = mip.fob_point
and ml2.lookup_type (+)              = 'MTL_FOB_POINT'
and ml3.lookup_code (+)              = mip.internal_order_required_flag
and ml3.lookup_type (+)              = 'SYS_YES_NO'
and fl1.lookup_code (+)              = mip.elemental_visibility_enabled
and fl1.lookup_type (+)              = 'YES_NO'
and fl2.lookup_code (+)              = mip.manual_receipt_expense
and fl2.lookup_type (+)              = 'YES_NO'
-- End revision for version 1.14
-- Revision for version 1.6, added profit in inventory account
union all
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name From_Operating_Unit,
 mp.organization_code From_Org_Code,
 mp.organization_name From_Org_Name,
 -- Revision for version 1.9
 haou3.name To_Operating_Unit,
 mp2.organization_code To_Org_Code,
 -- Revision for version 1.10
 ml1.meaning Transfer_Charge_Type,
 mip.interorg_trnsfr_charge_percent Transfer_Percent,
 -- End revision for version 1.10
 'Profit in Inventory Account' Account_Type,
 -- Revision for version 1.14
 intransit_type.meaning Intransit_Type,
 ml2.meaning FOB_Point,
 ml3.meaning Internal_Order_Required,
 fl1.meaning Elemental_Visibility,
 fl2.meaning Manual_Receipt_at_Expense_Dest,
 -- End revision for version 1.14
 &segment_columns
 mip.creation_date Creation_Date,
 mip.last_update_date Last_Update_Date
from mtl_interorg_parameters mip,
 org_organization_definitions mp,
 mtl_parameters mp2,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 -- Revision for version 1.9
 -- Add in the To-Org Operating_Unit
 hr_organization_information hoi2,
 hr_all_organization_units_vl haou3,
 gl_ledgers gl,
 -- Revision for version 1.14
 -- Compound join, as the Shipping Network Form
 -- INVSDOSI is hard-coded to 'Direct' and 'Intransit'
 (select 2 lookup_code,
  ml.meaning
  from mfg_lookups ml
  where ml.lookup_type  = 'MSC_CALENDAR_TYPE'
  and ml.lookup_code  = '3' -- Intransit 
  union
  select 1 lookup_code,
  fl.meaning
  from fnd_lookups fl
  where fl.lookup_type  = 'PV_PURCHASE_METHOD'
  and fl.lookup_code  = 'DIRECT'
 ) intransit_type,
 mfg_lookups ml1, -- transfer charge type, SYS_YES_NO
 mfg_lookups ml2, -- FOB_POINT, SYS_YES_NO
 mfg_lookups ml3, -- internal order required, SYS_YES_NO
 fnd_lookups fl1, -- elemental visibility, YES_NO
 fnd_lookups fl2  -- manual receipt expense, YES_NO
 -- End revision for version 1.14
where mip.profit_in_inv_account        = gcc.code_combination_id (+)
and mip.from_organization_id         = mp.organization_id
and mip.to_organization_id           = mp2.organization_id
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context      = 'Accounting Information'
and hoi.organization_id              = mp.organization_id
and hoi.organization_id              = haou.organization_id -- this gets the organization name
and haou2.organization_id            = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                     = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and sysdate                          < nvl(haou.date_to, sysdate +1)
-- Add in the To-Org Operating_Unit
and hoi2.org_information_context     = 'Accounting Information'
and hoi2.organization_id             = mp2.organization_id
and haou3.organization_id            = to_number(hoi2.org_information3) -- this gets the operating unit id
-- End revision for version 1.9
and 1=1                              -- p_from_org_code, p_from_operating_unit, p_ledger
-- ===========================================
-- Lookup Codes
-- ===========================================
-- Revision for version 1.14
and intransit_type.lookup_code       = mip.intransit_type
and ml1.lookup_code (+)              = mip.matl_interorg_transfer_code
and ml1.lookup_type (+)              = 'MTL_INTER_INV_TRANSFER'
and ml2.lookup_code (+)              = mip.fob_point
and ml2.lookup_type (+)              = 'MTL_FOB_POINT'
and ml3.lookup_code (+)              = mip.internal_order_required_flag
and ml3.lookup_type (+)              = 'SYS_YES_NO'
and fl1.lookup_code (+)              = mip.elemental_visibility_enabled
and fl1.lookup_type (+)              = 'YES_NO'
and fl2.lookup_code (+)              = mip.manual_receipt_expense
and fl2.lookup_type (+)              = 'YES_NO'
-- End revision for version 1.14
-- Order by Account_Type, Ledger, From_Operating_Unit, From_Org_Code, To_Operating_Unit, To_Org_Code. FOB_Point, Accounts
order by 
 9,1,2,3,6,7,11,15,16,17,18,19
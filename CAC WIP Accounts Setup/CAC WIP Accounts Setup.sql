/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Accounts Setup
-- Description: Report to show accounts used for WIP accounting classes.

/* +=============================================================================+
-- |  Copyright 2009 - 2022 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_wip_setup_accts_rept.sql
-- |
-- |  Parameters:
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- | 
-- |  Description:
-- |  Report to show accounts used for WIP accounting classes
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     24 Nov 2009 Douglas Volz   Initial Coding
-- |  1.1     28 Mar 2011 Douglas Volz   Added ledger parameter
-- |  1.2     18 Nov 2012 Douglas Volz   Removed client-specific COA segments and
-- |                                     organization conditions
-- |  1.3     02 Feb 2020 Douglas Volz   Outer join for accounts join, short name
-- |                                     for Ledger, Operating Unit and Org Code
-- |                                     parameters.
-- |  1.4     20 Apr 2020 Douglas Volz   Added Creation Date, Last Update Date
-- |                                     Changed to multi-language views for the item
-- |                                     master, inventory orgs and operating units.
-- |  1.5     10 Jul 2022 Douglas Volz   Account Type column now uses a lookup code.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-wip-accounts-setup/
-- Library Link: https://www.enginatics.com/reports/cac-wip-accounts-setup/
-- Run Report: https://demo.enginatics.com/

select 	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	wac.class_code WIP_Class,
	ml1.meaning Class_Type,
	wac.disable_date Disable_Date,
	-- Revision for version 1.5
	-- 'Material Value' Account_Type,
	ml2.meaning Account_Type,
	&segment_columns
        -- Revision for version 1.4
	wac.creation_date Creation_Date,
	wac.last_update_date Last_Update_Date
from 	wip_accounting_classes wac,
	mtl_parameters mp,
	mfg_lookups ml1, -- Class Type
	-- Revision for version 1.5
	mfg_lookups ml2, -- Account Type
	gl_code_combinations gcc,  -- wip class accounts
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl
-- ===========================================
-- WIP_Class Joins
-- ===========================================
where	mp.organization_id          = wac.organization_id
-- ===========================================
-- Lookup Code joins
-- ===========================================
and	ml1.lookup_type             = 'WIP_CLASS_TYPE'
and	ml1.lookup_code             = wac.class_type
-- Revision for version 1.5
and	ml2.lookup_type             = 'WIP_ELEMENT_VAR_TYPE'
and	ml2.lookup_code             = 1 -- Material
-- ===========================================
-- Accounting code combination joins
-- ===========================================
and	wac.material_account        = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context = 'Accounting Information'
and	hoi.organization_id         = mp.organization_id
and	hoi.organization_id         = haou.organization_id   -- this gets the organization name
and	haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and	sysdate                    < nvl(haou.date_to, sysdate +1)
and	1=1                                                           -- p_org_code, p_operating_unit, p_ledger
-- End revision for version 1.3
union all
select 	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	wac.class_code WIP_Class,
	ml1.meaning Class_Type,
	wac.disable_date Disable_Date,
	-- Revision for version 1.5
	-- 'Material Overhead Value' Account_Type,
	ml2.meaning Account_Type,
	&segment_columns
        -- Revision for version 1.4
	wac.creation_date Creation_Date,
	wac.last_update_date Last_Update_Date
from 	wip_accounting_classes wac,
	mtl_parameters mp,
	mfg_lookups ml1, -- Class Type
	-- Revision for version 1.5
	mfg_lookups ml2, -- Account Type
	gl_code_combinations gcc,  -- wip class accounts
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl
-- ===========================================
-- WIP_Class Joins
-- ===========================================
where	mp.organization_id        = wac.organization_id
-- ===========================================
-- Lookup Code joins
-- ===========================================
and	ml1.lookup_type             = 'WIP_CLASS_TYPE'
and	ml1.lookup_code             = wac.class_type
-- Revision for version 1.5
and	ml2.lookup_type             = 'WIP_ELEMENT_VAR_TYPE'
and	ml2.lookup_code             = 2 -- Material Overhead
-- ===========================================
-- Accounting code combination joins
-- ===========================================
and	wac.material_overhead_account = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context = 'Accounting Information'
and	hoi.organization_id         = mp.organization_id
and	hoi.organization_id         = haou.organization_id   -- this gets the organization name
and	haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and	sysdate                     < nvl(haou.date_to, sysdate +1)
and	1=1                                                           -- p_org_code, p_operating_unit, p_ledger
-- End revision for version 1.3
union all
select 	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	wac.class_code WIP_Class,
	ml1.meaning Class_Type,
	wac.disable_date Disable_Date,
	-- Revision for version 1.5
	-- 'Resource Value' Account_Type,
	ml2.meaning Account_Type,
	&segment_columns
        -- Revision for version 1.4
	wac.creation_date Creation_Date,
	wac.last_update_date Last_Update_Date
from 	wip_accounting_classes wac,
	mtl_parameters mp,
	mfg_lookups ml1, -- Class Type
	-- Revision for version 1.5
	mfg_lookups ml2, -- Account Type
	gl_code_combinations gcc,  -- wip class accounts
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl
-- ===========================================
-- WIP_Class Joins
-- ===========================================
where	mp.organization_id          = wac.organization_id
-- ===========================================
-- Lookup Code joins
-- ===========================================
and	ml1.lookup_type             = 'WIP_CLASS_TYPE'
and	ml1.lookup_code             = wac.class_type
-- Revision for version 1.5
and	ml2.lookup_type             = 'WIP_ELEMENT_VAR_TYPE'
and	ml2.lookup_code             = 3 -- Resource
-- ===========================================
-- Accounting code combination joins
-- ===========================================
and	wac.resource_account        = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context = 'Accounting Information'
and	hoi.organization_id         = mp.organization_id
and	hoi.organization_id         = haou.organization_id   -- this gets the organization name
and	haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and	sysdate                    < nvl(haou.date_to, sysdate +1)
and	1=1                                                           -- p_org_code, p_operating_unit, p_ledger
-- End revision for version 1.3
union all
select 	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	wac.class_code WIP_Class,
	ml1.meaning Class_Type,
	wac.disable_date Disable_Date,
	-- Revision for version 1.5
	-- 'Outside Processing Value' Account_Type,
	ml2.meaning Account_Type,
	&segment_columns
        -- Revision for version 1.4
	wac.creation_date Creation_Date,
	wac.last_update_date Last_Update_Date
from 	wip_accounting_classes wac,
	mtl_parameters mp,
	mfg_lookups ml1, -- Class Type
	-- Revision for version 1.5
	mfg_lookups ml2, -- Account Type
	gl_code_combinations gcc,  -- wip class accounts
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl
-- ===========================================
-- WIP_Class Joins
-- ===========================================
where	mp.organization_id          = wac.organization_id
-- ===========================================
-- Lookup Code joins
-- ===========================================
and	ml1.lookup_type             = 'WIP_CLASS_TYPE'
and	ml1.lookup_code             = wac.class_type
-- Revision for version 1.5
and	ml2.lookup_type             = 'WIP_ELEMENT_VAR_TYPE'
and	ml2.lookup_code             = 4 -- Outside Processing
-- ===========================================
-- Accounting code combination joins
-- ===========================================
and	wac.outside_processing_account = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context = 'Accounting Information'
and	hoi.organization_id         = mp.organization_id
and	hoi.organization_id         = haou.organization_id   -- this gets the organization name
and	haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and	sysdate                    < nvl(haou.date_to, sysdate +1)
and	1=1                                                           -- p_org_code, p_operating_unit, p_ledger
-- End revision for version 1.3
union all
select 	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	wac.class_code WIP_Class,
	ml1.meaning Class_Type,
	wac.disable_date Disable_Date,
	-- Revision for version 1.5
	-- 'Overhead Value' Account_Type,
	ml2.meaning Account_Type,
	&segment_columns
        -- Revision for version 1.4
	wac.creation_date Creation_Date,
	wac.last_update_date Last_Update_Date
from 	wip_accounting_classes wac,
	mtl_parameters mp,
	mfg_lookups ml1, -- Class Type
	-- Revision for version 1.5
	mfg_lookups ml2, -- Account Type
	gl_code_combinations gcc,  -- wip class accounts
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl
-- ===========================================
-- WIP_Class Joins
-- ===========================================
where	mp.organization_id          = wac.organization_id
-- ===========================================
-- Lookup Code joins
-- ===========================================
and	ml1.lookup_type             = 'WIP_CLASS_TYPE'
and	ml1.lookup_code             = wac.class_type
-- Revision for version 1.5
and	ml2.lookup_type             = 'WIP_ELEMENT_VAR_TYPE'
and	ml2.lookup_code             = 5 -- Overhead
-- ===========================================
-- Accounting code combination joins
-- ===========================================
and	wac.overhead_account        = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context = 'Accounting Information'
and	hoi.organization_id         = mp.organization_id
and	hoi.organization_id         = haou.organization_id   -- this gets the organization name
and	haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and	sysdate                    < nvl(haou.date_to, sysdate +1)
and	1=1                                                           -- p_org_code, p_operating_unit, p_ledger
-- End revision for version 1.3
union all
select 	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	wac.class_code WIP_Class,
	ml1.meaning Class_Type,
	wac.disable_date Disable_Date,
	-- Revision for version 1.5
	-- 'Material Variance' Account_Type,
	ml2.meaning Account_Type,
	&segment_columns
        -- Revision for version 1.4
	wac.creation_date Creation_Date,
	wac.last_update_date Last_Update_Date
from 	wip_accounting_classes wac,
	mtl_parameters mp,
	mfg_lookups ml1, -- Class Type
	-- Revision for version 1.5
	mfg_lookups ml2, -- Account Type
	gl_code_combinations gcc,  -- wip class accounts
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl
-- ===========================================
-- WIP_Class Joins
-- ===========================================
where	mp.organization_id          = wac.organization_id
-- ===========================================
-- Lookup Code joins
-- ===========================================
and	ml1.lookup_type             = 'WIP_CLASS_TYPE'
and	ml1.lookup_code             = wac.class_type
-- Revision for version 1.5
and	ml2.lookup_type             = 'WIP_ELEMENT_VAR_TYPE'
and	ml2.lookup_code             = 6 -- Material Variance
-- ===========================================
-- Accounting code combination joins
-- ===========================================
and	wac.material_variance_account = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context = 'Accounting Information'
and	hoi.organization_id         = mp.organization_id
and	hoi.organization_id         = haou.organization_id   -- this gets the organization name
and	haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and	sysdate                    < nvl(haou.date_to, sysdate +1)
and	1=1                                                           -- p_org_code, p_operating_unit, p_ledger
-- End revision for version 1.3
union all
select 	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	wac.class_code WIP_Class,
	ml1.meaning Class_Type,
	wac.disable_date Disable_Date,
	-- Revision for version 1.5
	-- 'Resource Variance' Account_Type,
	ml2.meaning Account_Type,
	&segment_columns
        -- Revision for version 1.4
	wac.creation_date Creation_Date,
	wac.last_update_date Last_Update_Date
from 	wip_accounting_classes wac,
	mtl_parameters mp,
	mfg_lookups ml1, -- Class Type
	-- Revision for version 1.5
	mfg_lookups ml2, -- Account Type
	gl_code_combinations gcc,  -- wip class accounts
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl
-- ===========================================
-- WIP_Class Joins
-- ===========================================
where	mp.organization_id          = wac.organization_id
-- ===========================================
-- Lookup Code joins
-- ===========================================
and	ml1.lookup_type             = 'WIP_CLASS_TYPE'
and	ml1.lookup_code             = wac.class_type
-- Revision for version 1.5
and	ml2.lookup_type             = 'WIP_ELEMENT_VAR_TYPE'
and	ml2.lookup_code             = 7 -- Resource Variance
-- ===========================================
-- Accounting code combination joins
-- ===========================================
and	wac.resource_variance_account = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context = 'Accounting Information'
and	hoi.organization_id         = mp.organization_id
and	hoi.organization_id         = haou.organization_id   -- this gets the organization name
and	haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and	sysdate                    < nvl(haou.date_to, sysdate +1)
and	1=1                                                           -- p_org_code, p_operating_unit, p_ledger
-- End revision for version 1.3
union all
select 	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	wac.class_code WIP_Class,
	ml1.meaning Class_Type,
	wac.disable_date Disable_Date,
	-- Revision for version 1.5
	-- 'Outside Processing Variance' Account_Type,
	ml2.meaning Account_Type,
	&segment_columns
        -- Revision for version 1.4
	wac.creation_date Creation_Date,
	wac.last_update_date Last_Update_Date
from 	wip_accounting_classes wac,
	mtl_parameters mp,
	mfg_lookups ml1, -- Class Type
	-- Revision for version 1.5
	mfg_lookups ml2, -- Account Type
	gl_code_combinations gcc,  -- wip class accounts
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl
-- ===========================================
-- WIP_Class Joins
-- ===========================================
where	mp.organization_id          = wac.organization_id
-- ===========================================
-- Lookup Code joins
-- ===========================================
and	ml1.lookup_type             = 'WIP_CLASS_TYPE'
and	ml1.lookup_code             = wac.class_type
-- Revision for version 1.5
and	ml2.lookup_type             = 'WIP_ELEMENT_VAR_TYPE'
and	ml2.lookup_code             = 8 -- Outside Processing Var
-- ===========================================
-- Accounting code combination joins
-- ===========================================
and	wac.outside_proc_variance_account = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context = 'Accounting Information'
and	hoi.organization_id         = mp.organization_id
and	hoi.organization_id         = haou.organization_id   -- this gets the organization name
and	haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and	sysdate                    < nvl(haou.date_to, sysdate +1)
and	1=1                                                           -- p_org_code, p_operating_unit, p_ledger
-- End revision for version 1.3
union all
select 	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	wac.class_code WIP_Class,
	ml1.meaning Class_Type,
	wac.disable_date Disable_Date,
	-- Revision for version 1.5
	-- 'Overhead Variance' Account_Type,
	ml2.meaning Account_Type,
	&segment_columns
        -- Revision for version 1.4
	wac.creation_date Creation_Date,
	wac.last_update_date Last_Update_Date
from 	wip_accounting_classes wac,
	mtl_parameters mp,
	mfg_lookups ml1, -- Class Type
	-- Revision for version 1.5
	mfg_lookups ml2, -- Account Type
	gl_code_combinations gcc,  -- wip class accounts
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl
-- ===========================================
-- WIP_Class Joins
-- ===========================================
where	mp.organization_id          = wac.organization_id
-- ===========================================
-- Lookup Code joins
-- ===========================================
and	ml1.lookup_type             = 'WIP_CLASS_TYPE'
and	ml1.lookup_code             = wac.class_type
-- Revision for version 1.5
and	ml2.lookup_type             = 'WIP_ELEMENT_VAR_TYPE'
and	ml2.lookup_code             = 9 -- Overhead Variance
-- ===========================================
-- Accounting code combination joins
-- ===========================================
and	wac.overhead_variance_account = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context = 'Accounting Information'
and	hoi.organization_id         = mp.organization_id
and	hoi.organization_id         = haou.organization_id   -- this gets the organization name
and	haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and	sysdate                    < nvl(haou.date_to, sysdate +1)
and	1=1                                                           -- p_org_code, p_operating_unit, p_ledger
-- End revision for version 1.3
union all
select 	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	wac.class_code WIP_Class,
	ml1.meaning Class_Type,
	wac.disable_date Disable_Date,
	-- Revision for version 1.5
	-- 'Standard Cost Adjustment' Account_Type,
	ml2.meaning Account_Type,
	&segment_columns
        -- Revision for version 1.4
	wac.creation_date Creation_Date,
	wac.last_update_date Last_Update_Date
from 	wip_accounting_classes wac,
	mtl_parameters mp,
	mfg_lookups ml1, -- Class Type
	-- Revision for version 1.5
	mfg_lookups ml2, -- Account Type
	gl_code_combinations gcc,  -- wip class accounts
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl
-- ===========================================
-- WIP_Class Joins
-- ===========================================
where	mp.organization_id          = wac.organization_id
-- ===========================================
-- Lookup Code joins
-- ===========================================
and	ml1.lookup_type             = 'WIP_CLASS_TYPE'
and	ml1.lookup_code             = wac.class_type
-- Revision for version 1.5
and	ml2.lookup_type             = 'INV_RESERVATION_SOURCE_TYPES'
and	ml2.lookup_code             = 11 -- Standard Cost Update
-- ===========================================
-- Accounting code combination joins
-- ===========================================
and	wac.std_cost_adjustment_account = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context = 'Accounting Information'
and	hoi.organization_id         = mp.organization_id
and	hoi.organization_id         = haou.organization_id   -- this gets the organization name
and	haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and	sysdate                    < nvl(haou.date_to, sysdate +1)
and	1=1                                                           -- p_org_code, p_operating_unit, p_ledger
-- End revision for version 1.3
-- Order by Ledger, Operating_Unit, Org_Code, WIP_Class, Account_Type
order by 1,2,3,4,7
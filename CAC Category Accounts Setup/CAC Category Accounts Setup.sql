/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Category Accounts Setup
-- Description: Report to show the category accounts in use.  If category accounts have been set up with your Subledger Accounting Rules, the Inventory Cost Processor can use them and bypass the organization accounts (Average, LIFO, FIFO Costing) or the subinventory accounts (Standard Costing).

/* +=============================================================================+
-- |  Copyright 2021 Douglas Volz Consulting, Inc.                               |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_category_setup_accts_rept.sql
-- |
-- |  Parameters:
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating_Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- | 
-- |  Description:
-- |  Report to show accounts used for the subinventories
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     16 Aug 2021 Douglas Volz   Initial Coding
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-category-accounts-setup/
-- Library Link: https://www.enginatics.com/reports/cac-category-accounts-setup/
-- Run Report: https://demo.enginatics.com/

select	nvl(gl.short_name, gl.name) Ledger,
-- Get the Material Account
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	haou.name Organization_Name,
	mc.category_concat_segs Category,
	(select	ccg.cost_group
	 from	cst_cost_groups ccg
	 where	ccg.cost_group_id  = mca.cost_group_id) Cost_Group,
	mca.subinventory_code Subinventory,
	(select	ml.meaning
	 from	mfg_lookups ml,
		mtl_secondary_inventories msub
	 where	msub.secondary_inventory_name = mca.subinventory_code
	 and	msub.organization_id          = mca.organization_id
	 and	ml.lookup_type                = 'SYS_YES_NO'
	 and	ml.lookup_code                = msub.asset_inventory) Inventory_Asset,
	'Material Account' Account_Type,
	&segment_columns
	mca.creation_date Creation_Date,
	mca.last_update_date Last_Update_Date,
	fu1.user_name Created_By,
	fu2.user_name Last_Updated_By
from	mtl_category_accounts mca,
	mtl_categories_v mc,
	mtl_parameters mp,
	gl_code_combinations gcc,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl,
	fnd_user fu1,
	fnd_user fu2
where	mca.category_id                = mc.category_id
and	mp.organization_id             = mca.organization_id
and	mca.material_account           = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context    = 'Accounting Information'
and	hoi.organization_id            = mp.organization_id
and	hoi.organization_id            = haou.organization_id -- this gets the organization name
and	haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                   = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
and	fu1.user_id                    = mca.created_by
and	fu2.user_id                    = mca.last_updated_by
and	1=1                            -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Material Overhead Account
select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	haou.name Organization_Name,
	mc.category_concat_segs Category,
	(select	ccg.cost_group
	 from	cst_cost_groups ccg
	 where	ccg.cost_group_id  = mca.cost_group_id) Cost_Group,
	mca.subinventory_code Subinventory,
	(select	ml.meaning
	 from	mfg_lookups ml,
		mtl_secondary_inventories msub
	 where	msub.secondary_inventory_name = mca.subinventory_code
	 and	msub.organization_id          = mca.organization_id
	 and	ml.lookup_type                = 'SYS_YES_NO'
	 and	ml.lookup_code                = msub.asset_inventory) Inventory_Asset,
	'Material Overhead Account' Account_Type,
	&segment_columns
	mca.creation_date Creation_Date,
	mca.last_update_date Last_Update_Date,
	fu1.user_name Created_By,
	fu2.user_name Last_Updated_By
from	mtl_category_accounts mca,
	mtl_categories_v mc,
	mtl_parameters mp,
	gl_code_combinations gcc,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl,
	fnd_user fu1,
	fnd_user fu2
where	mca.category_id                = mc.category_id
and	mp.organization_id             = mca.organization_id
and	mca.material_overhead_account  = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context    = 'Accounting Information'
and	hoi.organization_id            = mp.organization_id
and	hoi.organization_id            = haou.organization_id -- this gets the organization name
and	haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                   = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
and	fu1.user_id                    = mca.created_by
and	fu2.user_id                    = mca.last_updated_by
and	1=1                            -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Resource Account
select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	haou.name Organization_Name,
	mc.category_concat_segs Category,
	(select	ccg.cost_group
	 from	cst_cost_groups ccg
	 where	ccg.cost_group_id  = mca.cost_group_id) Cost_Group,
	mca.subinventory_code Subinventory,
	(select	ml.meaning
	 from	mfg_lookups ml,
		mtl_secondary_inventories msub
	 where	msub.secondary_inventory_name = mca.subinventory_code
	 and	msub.organization_id          = mca.organization_id
	 and	ml.lookup_type                = 'SYS_YES_NO'
	 and	ml.lookup_code                = msub.asset_inventory) Inventory_Asset,
	'Resource Account' Account_Type,
	&segment_columns
	mca.creation_date Creation_Date,
	mca.last_update_date Last_Update_Date,
	fu1.user_name Created_By,
	fu2.user_name Last_Updated_By
from	mtl_category_accounts mca,
	mtl_categories_v mc,
	mtl_parameters mp,
	gl_code_combinations gcc,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl,
	fnd_user fu1,
	fnd_user fu2
where	mca.category_id                = mc.category_id
and	mp.organization_id             = mca.organization_id
and	mca.resource_account           = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context    = 'Accounting Information'
and	hoi.organization_id            = mp.organization_id
and	hoi.organization_id            = haou.organization_id -- this gets the organization name
and	haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                   = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
and	fu1.user_id                    = mca.created_by
and	fu2.user_id                    = mca.last_updated_by
and	1=1                            -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Outside Processing Account
select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	haou.name Organization_Name,
	mc.category_concat_segs Category,
	(select	ccg.cost_group
	 from	cst_cost_groups ccg
	 where	ccg.cost_group_id  = mca.cost_group_id) Cost_Group,
	mca.subinventory_code Subinventory,
	(select	ml.meaning
	 from	mfg_lookups ml,
		mtl_secondary_inventories msub
	 where	msub.secondary_inventory_name = mca.subinventory_code
	 and	msub.organization_id          = mca.organization_id
	 and	ml.lookup_type                = 'SYS_YES_NO'
	 and	ml.lookup_code                = msub.asset_inventory) Inventory_Asset,
	'Outside Processing Account' Account_Type,
	&segment_columns
	mca.creation_date Creation_Date,
	mca.last_update_date Last_Update_Date,
	fu1.user_name Created_By,
	fu2.user_name Last_Updated_By
from	mtl_category_accounts mca,
	mtl_categories_v mc,
	mtl_parameters mp,
	gl_code_combinations gcc,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl,
	fnd_user fu1,
	fnd_user fu2
where	mca.category_id                = mc.category_id
and	mp.organization_id             = mca.organization_id
and	mca.outside_processing_account = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context    = 'Accounting Information'
and	hoi.organization_id            = mp.organization_id
and	hoi.organization_id            = haou.organization_id -- this gets the organization name
and	haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                   = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
and	fu1.user_id                    = mca.created_by
and	fu2.user_id                    = mca.last_updated_by
and	1=1                            -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Overhead Account
select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	haou.name Organization_Name,
	mc.category_concat_segs Category,
	(select	ccg.cost_group
	 from	cst_cost_groups ccg
	 where	ccg.cost_group_id  = mca.cost_group_id) Cost_Group,
	mca.subinventory_code Subinventory,
	(select	ml.meaning
	 from	mfg_lookups ml,
		mtl_secondary_inventories msub
	 where	msub.secondary_inventory_name = mca.subinventory_code
	 and	msub.organization_id          = mca.organization_id
	 and	ml.lookup_type                = 'SYS_YES_NO'
	 and	ml.lookup_code                = msub.asset_inventory) Inventory_Asset,
	'Overhead Account' Account_Type,
	&segment_columns
	mca.creation_date Creation_Date,
	mca.last_update_date Last_Update_Date,
	fu1.user_name Created_By,
	fu2.user_name Last_Updated_By
from	mtl_category_accounts mca,
	mtl_categories_v mc,
	mtl_parameters mp,
	gl_code_combinations gcc,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl,
	fnd_user fu1,
	fnd_user fu2
where	mca.category_id                = mc.category_id
and	mp.organization_id             = mca.organization_id
and	mca.overhead_account           = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context    = 'Accounting Information'
and	hoi.organization_id            = mp.organization_id
and	hoi.organization_id            = haou.organization_id -- this gets the organization name
and	haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                   = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
and	fu1.user_id                    = mca.created_by
and	fu2.user_id                    = mca.last_updated_by
and	1=1                            -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Expense Account
select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	haou.name Organization_Name,
	mc.category_concat_segs Category,
	(select	ccg.cost_group
	 from	cst_cost_groups ccg
	 where	ccg.cost_group_id  = mca.cost_group_id) Cost_Group,
	mca.subinventory_code Subinventory,
	(select	ml.meaning
	 from	mfg_lookups ml,
		mtl_secondary_inventories msub
	 where	msub.secondary_inventory_name = mca.subinventory_code
	 and	msub.organization_id          = mca.organization_id
	 and	ml.lookup_type                = 'SYS_YES_NO'
	 and	ml.lookup_code                = msub.asset_inventory) Inventory_Asset,
	'Expense Account' Account_Type,
	&segment_columns
	mca.creation_date Creation_Date,
	mca.last_update_date Last_Update_Date,
	fu1.user_name Created_By,
	fu2.user_name Last_Updated_By
from	mtl_category_accounts mca,
	mtl_categories_v mc,
	mtl_parameters mp,
	gl_code_combinations gcc,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl,
	fnd_user fu1,
	fnd_user fu2
where	mca.category_id                = mc.category_id
and	mp.organization_id             = mca.organization_id
and	mca.expense_account            = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context    = 'Accounting Information'
and	hoi.organization_id            = mp.organization_id
and	hoi.organization_id            = haou.organization_id -- this gets the organization name
and	haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                   = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
and	fu1.user_id                    = mca.created_by
and	fu2.user_id                    = mca.last_updated_by
and	1=1                            -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Encumbrance Account
select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	haou.name Organization_Name,
	mc.category_concat_segs Category,
	(select	ccg.cost_group
	 from	cst_cost_groups ccg
	 where	ccg.cost_group_id  = mca.cost_group_id) Cost_Group,
	mca.subinventory_code Subinventory,
	(select	ml.meaning
	 from	mfg_lookups ml,
		mtl_secondary_inventories msub
	 where	msub.secondary_inventory_name = mca.subinventory_code
	 and	msub.organization_id          = mca.organization_id
	 and	ml.lookup_type                = 'SYS_YES_NO'
	 and	ml.lookup_code                = msub.asset_inventory) Inventory_Asset,
	'Encumbrance Account' Account_Type,
	&segment_columns
	mca.creation_date Creation_Date,
	mca.last_update_date Last_Update_Date,
	fu1.user_name Created_By,
	fu2.user_name Last_Updated_By
from	mtl_category_accounts mca,
	mtl_categories_v mc,
	mtl_parameters mp,
	gl_code_combinations gcc,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl,
	fnd_user fu1,
	fnd_user fu2
where	mca.category_id                = mc.category_id
and	mp.organization_id             = mca.organization_id
and	mca.encumbrance_account        = gcc.code_combination_id (+)
and	mca.encumbrance_account is not null
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context    = 'Accounting Information'
and	hoi.organization_id            = mp.organization_id
and	hoi.organization_id            = haou.organization_id -- this gets the organization name
and	haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                   = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
and	fu1.user_id                    = mca.created_by
and	fu2.user_id                    = mca.last_updated_by
and	1=1                            -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Bridging Account
select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	haou.name Organization_Name,
	mc.category_concat_segs Category,
	(select	ccg.cost_group
	 from	cst_cost_groups ccg
	 where	ccg.cost_group_id  = mca.cost_group_id) Cost_Group,
	mca.subinventory_code Subinventory,
	(select	ml.meaning
	 from	mfg_lookups ml,
		mtl_secondary_inventories msub
	 where	msub.secondary_inventory_name = mca.subinventory_code
	 and	msub.organization_id          = mca.organization_id
	 and	ml.lookup_type                = 'SYS_YES_NO'
	 and	ml.lookup_code                = msub.asset_inventory) Inventory_Asset,
	'Bridging Account' Account_Type,
	&segment_columns
	mca.creation_date Creation_Date,
	mca.last_update_date Last_Update_Date,
	fu1.user_name Created_By,
	fu2.user_name Last_Updated_By
from	mtl_category_accounts mca,
	mtl_categories_v mc,
	mtl_parameters mp,
	gl_code_combinations gcc,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl,
	fnd_user fu1,
	fnd_user fu2
where	mca.category_id                = mc.category_id
and	mp.organization_id             = mca.organization_id
and	mca.bridging_account           = gcc.code_combination_id (+)
and	mca.bridging_account is not null
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context    = 'Accounting Information'
and	hoi.organization_id            = mp.organization_id
and	hoi.organization_id            = haou.organization_id -- this gets the organization name
and	haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                   = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
and	fu1.user_id                    = mca.created_by
and	fu2.user_id                    = mca.last_updated_by
and	1=1                            -- p_org_code, p_operating_unit, p_ledger
-- Order by Status, Ledger, Operating_Unit, Org_Code, Category, Subinventory, Account Type
order by 1,2,3,5,7,9
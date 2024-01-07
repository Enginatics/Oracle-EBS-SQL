/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Cost Group Accounts Setup
-- Description: Report to show the cost group accounts in use.  If using Average Costing, FIFO Costing, LIFO Costing, WMS (Warehouse Management System) or Project Manufacturing, the Inventory Cost Processor uses the cost group valuation accounts as opposed to subinventory valuation accounts.

Parameters:
===========
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2022 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this
-- |  permission.
-- +=============================================================================+
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     04 Oct 2022 Douglas Volz   Initial Coding
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-cost-group-accounts-setup/
-- Library Link: https://www.enginatics.com/reports/cac-cost-group-accounts-setup/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
-- Get the Material Account
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 ccg.cost_group Cost_Group,
 'Material Account' Account_Type,
 &segment_columns
 ccg.creation_date Creation_Date,
 ccg.last_update_date Last_Update_Date,
 fu1.user_name Created_By,
 fu2.user_name Last_Updated_By
from cst_cost_groups ccg,
 cst_cost_group_accounts ccga,
 mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 fnd_user fu1,
 fnd_user fu2
where ccga.cost_group_id             = ccg.cost_group_id
and ccga.organization_id           = ccg.organization_id
and mp.organization_id             = ccg.organization_id
and ccga.material_account          = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context    = 'Accounting Information'
and hoi.organization_id            = mp.organization_id
and hoi.organization_id            = haou.organization_id -- this gets the organization name
and haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                   = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
and fu1.user_id                    = ccga.created_by
and fu2.user_id                    = ccga.last_updated_by
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                            -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Material Overhead Account
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 ccg.cost_group Cost_Group,
 'Material Overhead Account' Account_Type,
 &segment_columns
 ccg.creation_date Creation_Date,
 ccg.last_update_date Last_Update_Date,
 fu1.user_name Created_By,
 fu2.user_name Last_Updated_By
from cst_cost_groups ccg,
 cst_cost_group_accounts ccga,
 mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 fnd_user fu1,
 fnd_user fu2
where ccga.cost_group_id             = ccg.cost_group_id
and ccga.organization_id           = ccg.organization_id
and mp.organization_id             = ccg.organization_id
and ccga.material_overhead_account = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context    = 'Accounting Information'
and hoi.organization_id            = mp.organization_id
and hoi.organization_id            = haou.organization_id -- this gets the organization name
and haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                   = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
and fu1.user_id                    = ccga.created_by
and fu2.user_id                    = ccga.last_updated_by
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                            -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Resource Account
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 ccg.cost_group Cost_Group,
 'Resource Account' Account_Type,
 &segment_columns
 ccg.creation_date Creation_Date,
 ccg.last_update_date Last_Update_Date,
 fu1.user_name Created_By,
 fu2.user_name Last_Updated_By
from cst_cost_groups ccg,
 cst_cost_group_accounts ccga,
 mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 fnd_user fu1,
 fnd_user fu2
where ccga.cost_group_id             = ccg.cost_group_id
and ccga.organization_id           = ccg.organization_id
and mp.organization_id             = ccg.organization_id
and ccga.resource_account          = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context    = 'Accounting Information'
and hoi.organization_id            = mp.organization_id
and hoi.organization_id            = haou.organization_id -- this gets the organization name
and haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                   = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
and fu1.user_id                    = ccga.created_by
and fu2.user_id                    = ccga.last_updated_by
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                            -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Outside Processing Account
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 ccg.cost_group Cost_Group,
 'Outside Processing Account' Account_Type,
 &segment_columns
 ccg.creation_date Creation_Date,
 ccg.last_update_date Last_Update_Date,
 fu1.user_name Created_By,
 fu2.user_name Last_Updated_By
from cst_cost_groups ccg,
 cst_cost_group_accounts ccga,
 mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 fnd_user fu1,
 fnd_user fu2
where ccga.cost_group_id             = ccg.cost_group_id
and ccga.organization_id           = ccg.organization_id
and mp.organization_id             = ccg.organization_id
and ccga.outside_processing_account = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context    = 'Accounting Information'
and hoi.organization_id            = mp.organization_id
and hoi.organization_id            = haou.organization_id -- this gets the organization name
and haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                   = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
and fu1.user_id                    = ccga.created_by
and fu2.user_id                    = ccga.last_updated_by
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                            -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Overhead Account
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 ccg.cost_group Cost_Group,
 'Overhead Account' Account_Type,
 &segment_columns
 ccg.creation_date Creation_Date,
 ccg.last_update_date Last_Update_Date,
 fu1.user_name Created_By,
 fu2.user_name Last_Updated_By
from cst_cost_groups ccg,
 cst_cost_group_accounts ccga,
 mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 fnd_user fu1,
 fnd_user fu2
where ccga.cost_group_id             = ccg.cost_group_id
and ccga.organization_id           = ccg.organization_id
and mp.organization_id             = ccg.organization_id
and ccga.overhead_account          = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context    = 'Accounting Information'
and hoi.organization_id            = mp.organization_id
and hoi.organization_id            = haou.organization_id -- this gets the organization name
and haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                   = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
and fu1.user_id                    = ccga.created_by
and fu2.user_id                    = ccga.last_updated_by
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                            -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Expense Account
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 ccg.cost_group Cost_Group,
 'Expense Account' Account_Type,
 &segment_columns
 ccg.creation_date Creation_Date,
 ccg.last_update_date Last_Update_Date,
 fu1.user_name Created_By,
 fu2.user_name Last_Updated_By
from cst_cost_groups ccg,
 cst_cost_group_accounts ccga,
 mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 fnd_user fu1,
 fnd_user fu2
where ccga.cost_group_id             = ccg.cost_group_id
and ccga.organization_id           = ccg.organization_id
and mp.organization_id             = ccg.organization_id
and ccga.expense_account           = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context    = 'Accounting Information'
and hoi.organization_id            = mp.organization_id
and hoi.organization_id            = haou.organization_id -- this gets the organization name
and haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                   = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
and fu1.user_id                    = ccga.created_by
and fu2.user_id                    = ccga.last_updated_by
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                            -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Encumbrance Account
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 ccg.cost_group Cost_Group,
 'Encumbrance Account' Account_Type,
 &segment_columns
 ccg.creation_date Creation_Date,
 ccg.last_update_date Last_Update_Date,
 fu1.user_name Created_By,
 fu2.user_name Last_Updated_By
from cst_cost_groups ccg,
 cst_cost_group_accounts ccga,
 mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 fnd_user fu1,
 fnd_user fu2
where ccga.cost_group_id             = ccg.cost_group_id
and ccga.organization_id           = ccg.organization_id
and mp.organization_id             = ccg.organization_id
and ccga.encumbrance_account       = gcc.code_combination_id (+)
and ccga.encumbrance_account is not null
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context    = 'Accounting Information'
and hoi.organization_id            = mp.organization_id
and hoi.organization_id            = haou.organization_id -- this gets the organization name
and haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                   = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
and fu1.user_id                    = ccga.created_by
and fu2.user_id                    = ccga.last_updated_by
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                            -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Average Cost Variance Account
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 ccg.cost_group Cost_Group,
 'Average Cost Variance' Account_Type,
 &segment_columns
 ccg.creation_date Creation_Date,
 ccg.last_update_date Last_Update_Date,
 fu1.user_name Created_By,
 fu2.user_name Last_Updated_By
from cst_cost_groups ccg,
 cst_cost_group_accounts ccga,
 mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 fnd_user fu1,
 fnd_user fu2
where ccga.cost_group_id             = ccg.cost_group_id
and ccga.organization_id           = ccg.organization_id
and mp.organization_id             = ccg.organization_id
and ccga.average_cost_var_account  = gcc.code_combination_id (+)
and ccga.average_cost_var_account is not null
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context    = 'Accounting Information'
and hoi.organization_id            = mp.organization_id
and hoi.organization_id            = haou.organization_id -- this gets the organization name
and haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                   = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
and fu1.user_id                    = ccga.created_by
and fu2.user_id                    = ccga.last_updated_by
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                            -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Payback Material Variance Account
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 ccg.cost_group Cost_Group,
 'Payback Material Variance Account' Account_Type,
 &segment_columns
 ccg.creation_date Creation_Date,
 ccg.last_update_date Last_Update_Date,
 fu1.user_name Created_By,
 fu2.user_name Last_Updated_By
from cst_cost_groups ccg,
 cst_cost_group_accounts ccga,
 mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 fnd_user fu1,
 fnd_user fu2
where ccga.cost_group_id             = ccg.cost_group_id
and ccga.organization_id           = ccg.organization_id
and mp.organization_id             = ccg.organization_id
and ccga.payback_mat_var_account  = gcc.code_combination_id (+)
and ccga.payback_mat_var_account is not null
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context    = 'Accounting Information'
and hoi.organization_id            = mp.organization_id
and hoi.organization_id            = haou.organization_id -- this gets the organization name
and haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                   = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
and fu1.user_id                    = ccga.created_by
and fu2.user_id                    = ccga.last_updated_by
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                            -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Payback Resource Variance Account
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 ccg.cost_group Cost_Group,
 'Payback Resource Variance Account' Account_Type,
 &segment_columns
 ccg.creation_date Creation_Date,
 ccg.last_update_date Last_Update_Date,
 fu1.user_name Created_By,
 fu2.user_name Last_Updated_By
from cst_cost_groups ccg,
 cst_cost_group_accounts ccga,
 mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 fnd_user fu1,
 fnd_user fu2
where ccga.cost_group_id             = ccg.cost_group_id
and ccga.organization_id           = ccg.organization_id
and mp.organization_id             = ccg.organization_id
and ccga.payback_res_var_account  = gcc.code_combination_id (+)
and ccga.payback_res_var_account is not null
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context    = 'Accounting Information'
and hoi.organization_id            = mp.organization_id
and hoi.organization_id            = haou.organization_id -- this gets the organization name
and haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                   = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
and fu1.user_id                    = ccga.created_by
and fu2.user_id                    = ccga.last_updated_by
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                            -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Payback Outside Processing Variance Account
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 ccg.cost_group Cost_Group,
 'Payback Outside Processing Variance Account' Account_Type,
 &segment_columns
 ccg.creation_date Creation_Date,
 ccg.last_update_date Last_Update_Date,
 fu1.user_name Created_By,
 fu2.user_name Last_Updated_By
from cst_cost_groups ccg,
 cst_cost_group_accounts ccga,
 mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 fnd_user fu1,
 fnd_user fu2
where ccga.cost_group_id             = ccg.cost_group_id
and ccga.organization_id           = ccg.organization_id
and mp.organization_id             = ccg.organization_id
and ccga.payback_osp_var_account  = gcc.code_combination_id (+)
and ccga.payback_osp_var_account is not null
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context    = 'Accounting Information'
and hoi.organization_id            = mp.organization_id
and hoi.organization_id            = haou.organization_id -- this gets the organization name
and haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                   = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
and fu1.user_id                    = ccga.created_by
and fu2.user_id                    = ccga.last_updated_by
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                            -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Payback Material Overhead Variance Account
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 ccg.cost_group Cost_Group,
 'Payback Material Overhead Variance Account' Account_Type,
 &segment_columns
 ccg.creation_date Creation_Date,
 ccg.last_update_date Last_Update_Date,
 fu1.user_name Created_By,
 fu2.user_name Last_Updated_By
from cst_cost_groups ccg,
 cst_cost_group_accounts ccga,
 mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 fnd_user fu1,
 fnd_user fu2
where ccga.cost_group_id             = ccg.cost_group_id
and ccga.organization_id           = ccg.organization_id
and mp.organization_id             = ccg.organization_id
and ccga.payback_moh_var_account  = gcc.code_combination_id (+)
and ccga.payback_moh_var_account is not null
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context    = 'Accounting Information'
and hoi.organization_id            = mp.organization_id
and hoi.organization_id            = haou.organization_id -- this gets the organization name
and haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                   = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
and fu1.user_id                    = ccga.created_by
and fu2.user_id                    = ccga.last_updated_by
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                            -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Payback Overhead Variance Account
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 ccg.cost_group Cost_Group,
 'Payback Overhead Variance Account' Account_Type,
 &segment_columns
 ccg.creation_date Creation_Date,
 ccg.last_update_date Last_Update_Date,
 fu1.user_name Created_By,
 fu2.user_name Last_Updated_By
from cst_cost_groups ccg,
 cst_cost_group_accounts ccga,
 mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 fnd_user fu1,
 fnd_user fu2
where ccga.cost_group_id             = ccg.cost_group_id
and ccga.organization_id           = ccg.organization_id
and mp.organization_id             = ccg.organization_id
and ccga.payback_ovh_var_account  = gcc.code_combination_id (+)
and ccga.payback_ovh_var_account is not null
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context    = 'Accounting Information'
and hoi.organization_id            = mp.organization_id
and hoi.organization_id            = haou.organization_id -- this gets the organization name
and haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                   = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
and fu1.user_id                    = ccga.created_by
and fu2.user_id                    = ccga.last_updated_by
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                            -- p_org_code, p_operating_unit, p_ledger
union all
-- Get the Payback Material Overhead Variance Account
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 ccg.cost_group Cost_Group,
 'Payback Material Overhead Variance Account' Account_Type,
 &segment_columns
 ccg.creation_date Creation_Date,
 ccg.last_update_date Last_Update_Date,
 fu1.user_name Created_By,
 fu2.user_name Last_Updated_By
from cst_cost_groups ccg,
 cst_cost_group_accounts ccga,
 mtl_parameters mp,
 gl_code_combinations gcc,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl,
 fnd_user fu1,
 fnd_user fu2
where ccga.cost_group_id             = ccg.cost_group_id
and ccga.organization_id           = ccg.organization_id
and mp.organization_id             = ccg.organization_id
and ccga.payback_moh_var_account  = gcc.code_combination_id (+)
and ccga.payback_moh_var_account is not null
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context    = 'Accounting Information'
and hoi.organization_id            = mp.organization_id
and hoi.organization_id            = haou.organization_id -- this gets the organization name
and haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                   = to_number(hoi.org_information1) -- get the ledger_id
-- Avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
and fu1.user_id                    = ccga.created_by
and fu2.user_id                    = ccga.last_updated_by
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1
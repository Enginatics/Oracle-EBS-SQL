/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Item Master Accounts Setup
-- Description: Report to show item master accounts and related information by item.

/* +=============================================================================+
-- |  Copyright 2011 - 2022 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_item_master_accts_rept.sql
-- |
-- |  Parameters:
-- |  p_include_non_costed_items -- Yes/No flag to include or not include non-costed items
-- |  p_item_number      -- Enter the specific inventory organization code
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |  p_category_set1    -- The first item category set to report, typically the
-- |                        Cost or Product Line Category Set
-- |  p_category_set2    -- The second item category set to report, typically the
-- |                        Inventory Category Set
-- |
-- | Description:
-- | Report to show item master accounts and related information
-- | 
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- |  1.0    30 Mar 2011 Douglas Volz  Initial Coding
-- |  1.1    18 Nov 2012 Douglas Volz  Removed client-specific org conditions
-- |  1.2    12 Feb 2013 Douglas Volz  Changed inventory category to be more generic
-- |  1.3    16 Nov 2015 Douglas Volz  Modified for client's chart of accounts
-- |  1.4    21 Feb 2017 Douglas Volz  Modified for client's chart of accounts and
-- |                                   added parameters to this report
-- |  1.5    17 Jul 2018 Douglas Volz  Modified for client's chart of accounts and
-- |                                   modified to use the default category for Inventory
-- |  1.6    12 Jan 2019 Douglas Volz  Use gl short_name, modify for any two categories,
-- |                                   and add operating unit parameter.
-- |  1.7    28 Apr 2020 Douglas Volz  Changed to multi-language views for the
-- |                                   inventory orgs and operating units.
-- |  1.8    29 Apr 2022 Douglas Volz  Modify summary report into the detailed report.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-item-master-accounts-setup/
-- Library Link: https://www.enginatics.com/reports/cac-item-master-accounts-setup/
-- Run Report: https://demo.enginatics.com/

select
gl.name ledger,
haouv.name operating_unit,
msiv.organization_code,
msiv.segment1 item_number,
msiv.description item_description,
msiv.primary_uom_code uom_code,
&category_columns
misv.inventory_item_status_code_tl item_status,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_or_buy,
xxen_util.meaning(msiv.costing_enabled_flag,'YES_NO',0) allow_costs,
xxen_util.meaning(cic.inventory_asset_flag,'SYS_YES_NO',700) inventory_asset,
xxen_util.meaning(cic.based_on_rollup_flag,'SYS_YES_NO',700) based_on_cost_rollup,
cic.shrinkage_rate,
cct.cost_type,
gl.currency_code,
cic.item_cost,
&segment_columns
xxen_util.user_name(msiv.created_by) item_created_by,
xxen_util.client_time(msiv.creation_date) item_creation_date,
xxen_util.user_name(msiv.last_updated_by) item_last_updated_by,
xxen_util.client_time(msiv.last_update_date) item_last_update_date
from
gl_ledgers gl,
org_organization_definitions ood,
hr_all_organization_units_vl haouv,
(
select
mp.organization_code,
mp.primary_cost_method,
msiv.*
from
mtl_parameters mp,
mtl_system_items_vl msiv
where
mp.organization_id<>mp.master_organization_id and
mp.organization_id=msiv.organization_id
) msiv,
mtl_item_status_vl misv,
cst_item_costs cic,
cst_cost_types cct,
gl_code_combinations gcc1,
gl_code_combinations gcc2,
gl_code_combinations gcc3
where
gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haouv.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1 and
msiv.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
gl.ledger_id=ood.set_of_books_id and
ood.organization_id=msiv.organization_id and
msiv.inventory_item_status_code=misv.inventory_item_status_code(+) and
msiv.organization_id=cic.organization_id(+) and
msiv.inventory_item_id=cic.inventory_item_id(+) and
decode(msiv.costing_enabled_flag,'Y',msiv.primary_cost_method)=cic.cost_type_id(+) and
decode(msiv.costing_enabled_flag,'Y',msiv.primary_cost_method)=cct.cost_type_id(+) and
ood.operating_unit=haouv.organization_id and
msiv.cost_of_sales_account=gcc1.code_combination_id(+) and 
msiv.sales_account=gcc2.code_combination_id(+) and
msiv.expense_account=gcc3.code_combination_id(+)
order by 1,2,3,4,5
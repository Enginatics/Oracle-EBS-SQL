/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Item Cost Summary
-- Description: Report to show item costs in any cost type. For one or more inventory organizations.
-- Parameters:
-- ===========
-- Cost Type: enter the cost type(s) you wish to report (mandatory).
-- Include Uncosted Items: enter Yes to include non-costed items, enter No to exclude them (mandatory).
-- Item Status to Exclude: enter the item status you wish to exclude, defaulted to Inactive (optional).
-- Category Set 1: the first item category set to report, typically the Cost or Product Line Category Set (optional).
-- Category Set 2: the second item category set to report, typically the Inventory Category Set (optional).
-- Item Number: enter the item numbers you wish to report (optional).
-- Organization Code: enter the specific inventory organization(s) you wish to report (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2009-2024 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this
-- -- | permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Description:
-- -- | Report to show item costs in any cost type
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 06 Oct 2009 Douglas Volz Initial Coding
-- -- | 1.1 16 Mar 2010 Douglas Volz Updated with Make/Buy flags
-- -- | 1.2 08 Nov 2010 Douglas Volz Updated with additional columns and parameters
-- -- | 1.3 07 Feb 2011 Douglas Volz Added COGS and Revenue default accounts
-- -- | 1.4 15 Nov 2016 Douglas Volz Added category information
-- -- | 1.5 27 Jan 2020 Douglas Volz Added Org Code and Operating Unit parameters
-- -- | 1.6 27 Apr 2020 Douglas Volz Changed to multi-language views for the item
-- -- | master, inventory orgs and operating units
-- -- | 1.7 21 Jun 2020 Douglas Volz Changed to multi-language views for item
-- -- | status and UOM
-- -- | 1.8 24 Sep 2020 Douglas Volz Added List Price and Market Price to report
-- -- | 1.9 29 Jan 2021 Douglas Volz Added item master dates and Inactive Items parameter
-- -- | 1.10 22 Nov 2023 Douglas Volz Add item master std lot size, costing lot size,
-- -- | remove tabs and add org access controls
-- -- | 1.11 05 Dec 2023 Douglas Volz Added G/L and Operating Unit security restrictions.
-- -- | 1.12 30 Jun 2024 Douglas Volz Reinstalled missing parameter for Item Status to Exclude
-- -- | and commented out G/L and Operating Unit security restrictions.
-- -- | 1.13 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-item-cost-summary/
-- Library Link: https://www.enginatics.com/reports/cac-item-cost-summary/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv.name operating_unit,
mp.organization_code org_code,
cct.cost_type,
msiv.concatenated_segments item_number,
msiv.description item_description,
msiv.primary_uom_code uom_code,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
misv.inventory_item_status_code_tl item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
msiv.std_lot_size,
&category_columns
xxen_util.yes(msiv.costing_enabled_flag) allow_costs,
xxen_util.yes(decode(cic.inventory_asset_flag,1,'Y')) inventory_asset,
xxen_util.yes(decode(cic.defaulted_flag,1,'Y')) use_default_controls,
xxen_util.meaning(cic.based_on_rollup_flag,'CST_BONROLLUP_VAL',700) based_on_rollup,
cic.lot_size costing_lot_size,
cic.shrinkage_rate,
gl.currency_code,
msiv.market_price,
msiv.list_price_per_unit target_or_po_list_price,
nvl(cic.material_cost,0) material_cost,
nvl(cic.material_overhead_cost,0) material_overhead_cost,
nvl(cic.resource_cost,0) resource_cost,
nvl(cic.outside_processing_cost,0) outside_processing_cost,
nvl(cic.overhead_cost,0) overhead_cost,
nvl(cic.item_cost,0) item_cost,
&segment_columns
cic.creation_date cost_creation_date,
cic.last_update_date last_cost_update_date,
msiv.creation_date item_creation_date,
msiv.last_update_date item_last_update_date
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv,
gl_ledgers gl,
mtl_system_items_vl msiv,
mtl_item_status_vl misv,
cst_item_costs cic,
cst_cost_types cct,
gl_code_combinations gcc1,
gl_code_combinations gcc2
where
1=1 and
2=2 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
nvl(haou.date_to,sysdate+1)>sysdate and
to_number(hoi.org_information3)=haouv.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=msiv.organization_id and
msiv.inventory_item_status_code=misv.inventory_item_status_code and
msiv.organization_id=cic.organization_id and
msiv.inventory_item_id=cic.inventory_item_id and
cic.cost_type_id=cct.cost_type_id and
msiv.cost_of_sales_account=gcc1.code_combination_id(+) and
msiv.sales_account=gcc2.code_combination_id(+)
union all
select
nvl(gl.short_name,gl.name) ledger,
haouv.name operating_unit,
mp.organization_code org_code,
null cost_type,
msiv.concatenated_segments item_number,
msiv.description item_description,
msiv.primary_uom_code uom_code,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
misv.inventory_item_status_code_tl item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
msiv.std_lot_size,
&category_columns
null allow_costs,
xxen_util.yes(msiv.inventory_asset_flag) inventory_asset,
null use_default_controls,
null based_on_rollup,
null costing_lot_size,
null shrinkage_rate,
gl.currency_code,
msiv.market_price,
msiv.list_price_per_unit target_or_po_list_price,
null material_cost,
null material_overhead_cost,
null resource_cost,
null outside_processing_cost,
null overhead_cost,
null item_cost,
&segment_columns
null cost_creation_date,
null last_cost_update_date,
msiv.creation_date item_creation_date,
msiv.last_update_date item_last_update_date
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv,
gl_ledgers gl,
mtl_system_items_vl msiv,
mtl_item_status_vl misv,
gl_code_combinations gcc1,
gl_code_combinations gcc2
where
1=1 and
3=3 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
nvl(haou.date_to,sysdate+1)>sysdate and
to_number(hoi.org_information3)=haouv.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=msiv.organization_id and
msiv.costing_enabled_flag='N' and
msiv.inventory_item_status_code=misv.inventory_item_status_code and
msiv.cost_of_sales_account=gcc1.code_combination_id(+) and
msiv.sales_account=gcc2.code_combination_id(+)
order by
ledger,
operating_unit,
org_code,
cost_type,
item_number

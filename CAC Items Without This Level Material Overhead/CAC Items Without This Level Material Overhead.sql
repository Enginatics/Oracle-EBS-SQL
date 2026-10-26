/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Items Without This Level Material Overhead
-- Description: Report to show item costs which do not have this level material overhead, for any cost type. For one or more inventory organizations.
-- Parameters:
-- ===========
-- Cost Type: enter the cost type(s) you wish to report (mandatory).
-- Make or Buy: enter Buy, Make or leave blank to get all items (optional).
-- Based on Rollup: enter Yes to get the rolled up items, No to get the non-rolled-up items (optional).
-- Basis Type: enter the basis type you wish to report, such as Item, Lot, Res Units, Res Value, or Ttl Value (optional).
-- Item Status to Exclude: enter the item status you wish to exclude, defaulted to Inactive (optional).
-- Category Set 1: the first item category set to report, typically the Cost or Product Line Category Set (optional).
-- Category Set 2: the second item category set to report, typically the Inventory Category Set (optional).
-- Category Set 3: the third item category set to report (optional).
-- Item Number: enter the item numbers you wish to report (optional).
-- Organization Code: enter the specific inventory organization(s) you wish to report (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2024 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 15 Nov 2024 Douglas Volz Initial Coding based on the Item Cost Summary Report.
-- -- | 1.1 08 Dec 2024 Douglas Volz Added Ledger and Operating Unit security profiles.
-- -- | 1.2 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-items-without-this-level-material-overhead/
-- Library Link: https://www.enginatics.com/reports/cac-items-without-this-level-material-overhead/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
cct.cost_type,
msiv.concatenated_segments item_number,
msiv.description item_description,
msiv.primary_uom_code uom_code,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
msiv.inventory_item_status_code item_status,
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
nvl(cic.tl_material,0) tl_material_cost,
nvl(cic.tl_material_overhead,0) tl_material_overhead_cost,
nvl(cic.tl_resource,0) tl_resource_cost,
nvl(cic.tl_outside_processing,0) tl_outside_processing_cost,
nvl(cic.tl_overhead,0) tl_overhead_cost,
nvl(cic.tl_item_cost,0) tl_item_cost,
nvl(cic.pl_material,0) pl_material_cost,
nvl(cic.pl_material_overhead,0) pl_material_overhead_cost,
nvl(cic.pl_resource,0) pl_resource_cost,
nvl(cic.pl_outside_processing,0) pl_outside_processing_cost,
nvl(cic.pl_overhead,0) pl_overhead_cost,
nvl(cic.pl_item_cost,0) pl_item_cost,
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
hr_all_organization_units_vl haouv_ou,
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
mp.organization_id<>mp.master_organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
nvl(haou.date_to,sysdate+1)>sysdate and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=msiv.organization_id and
msiv.inventory_item_status_code=misv.inventory_item_status_code and
msiv.organization_id=cic.organization_id and
msiv.inventory_item_id=cic.inventory_item_id and
nvl(cic.tl_material_overhead,0)=0 and
cic.cost_type_id=cct.cost_type_id and
msiv.cost_of_sales_account=gcc1.code_combination_id(+) and
msiv.sales_account=gcc2.code_combination_id(+)
order by
ledger,
operating_unit,
org_code,
cost_type,
item_number

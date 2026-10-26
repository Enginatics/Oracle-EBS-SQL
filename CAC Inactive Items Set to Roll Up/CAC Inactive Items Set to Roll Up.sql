/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inactive Items Set to Roll Up
-- Description: Report to show items which are set to roll up even though these items have an inactive status. The Cost Rollup uses the Based on Rollup Flag to control if an item is rolled up, as opposed to the item status.
-- Parameters:
-- ===========
-- Cost Type: enter the cost type to report (mandatory). Defaults to your Costing Method cost type.
-- Inactive Item Status: enter the item statuses which should not be rolled up (mandatory). Defaults to 'Inactive'.
-- Category Set 1: any item category you wish, typically the Cost or Product Line category set (optional).
-- Category Set 2: any item category you wish, typically the Inventory category set (optional).
-- Item Number: enter the specific item number(s) you wish to report (optional).
-- Organization Code: enter the specific inventory organization(s) you wish to report (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2023 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxinactiveitemssettorolluprept.sql
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 15 Nov 2023 Douglas Volz Initial version
-- -- | 1.1 05 Dec 2023 Douglas Volz Added G/L and Operating Unit security restrictions.
-- -- | 1.2 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-inactive-items-set-to-roll-up/
-- Library Link: https://www.enginatics.com/reports/cac-inactive-items-set-to-roll-up/
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
misv.inventory_item_status_code_tl item_status_code,
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
cic.item_cost
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
mtl_system_items_vl msiv,
mtl_item_status_vl misv,
cst_item_costs cic,
cst_cost_types cct
where
1=1 and
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
cic.based_on_rollup_flag=1 and
cic.cost_type_id=cct.cost_type_id
order by
ledger,
operating_unit,
org_code,
cost_type,
item_number

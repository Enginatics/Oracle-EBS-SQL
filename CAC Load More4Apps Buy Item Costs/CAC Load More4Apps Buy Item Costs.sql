/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Load More4Apps Buy Item Costs
-- Description: Report to fetch all buy items (based on rollup = No). Used as a source of item costs for buy items which you wish to edit or change using the More4Apps Item Cost Wizard or similar tool. You can over-ride the Make Buy Code by removing the defaulted value, but the Oracle Item Cost Interface works best for Buy Items; it does not work well with rolled-up costs and accordingly, this report only downloads items whose costs are not based on the cost rollup.
-- This report approximates the layout for the More4Apps Item Cost Wizard; run this report to get your Buy Item costs into Excel, make your changes in Excel then paste these revised costs into the More4Apps Item Cost Wizard. Columns needed for the More4Apps Item Cost Wizard: Org Code, Cost Type, Item Number, Based on Rollup, Lot Size, Mfg Shrinkage, Cost Element, Sub-Element, Basis Type and Rate or Amount. The additional columns, Currency Code, UOM Code, Make Buy Code and Inventory Asset, are for reference purposes.
-- Parameters:
-- ===========
-- From Cost Type: enter the cost type you are downloading from (mandatory).
-- To Cost Type: enter the cost type you are planning to upload back into the More4Apps Item Cost Wizard. This Cost Type will show up on the report output (mandatory).
-- Item Status to Exclude: enter the item number status you want to exclude. Defaulted to 'Inactive' (optional).
-- Make or Buy: enter the type of item you wish to report. Defaulted to Buy Items, as the Oracle Item Cost Interface works best with items that you purchase, as opposed to rolled up costs (optional).
-- Cost Element: enter the specific cost element you wish to download; for Buy Items typically the Material and Material Overhead Cost Elements (optional).
-- Organization Code: enter the specific inventory organization(s) you wish to report (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2017 - 2023 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this
-- -- | permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxloadm4appbuyitemcosts.sql
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 07 Jun 2017 Douglas Volz Initial Coding
-- -- | 1.1 16 Jun 2017 Douglas Volz Only report based on rollup = No
-- -- | 1.2 12 Nov 2018 Douglas Volz Remove prior client org restriction and
-- -- | add Ledger parameter.
-- -- | 1.3 27 Jan 2020 Douglas Volz Added Operating Unit parameter.
-- -- | 1.4 06 Jul 2022 Douglas Volz Changed to multi-language views for the item
-- -- | master and inventory orgs.
-- -- | 1.5 21 Oct 2023 Douglas Volz Added UOM Code, Make Buy Code and Inventory
-- -- | Asset columns; added Item Status, Make Buy
-- -- | and Cost Element parameters, removed tabs
-- -- | and added org access controls.
-- -- | 1.6 05 Dec 2023 Douglas Volz Added G/L and Operating Unit security restrictions.
-- -- | 1.7 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-load-more4apps-buy-item-costs/
-- Library Link: https://www.enginatics.com/reports/cac-load-more4apps-buy-item-costs/
-- Run Report: https://demo.enginatics.com/

select
mp.organization_code org_code,
:p_to_cost_type to_cost_type,
msiv.concatenated_segments item_number,
decode(cic.based_on_rollup_flag,1,'Yes','No') based_on_rollup,
cic.lot_size,
cic.shrinkage_rate mfg_shrinkage,
cce.cost_element,
br.resource_code subelement,
xxen_util.meaning(cicd.basis_type,'CST_BASIS_SHORT',700) basis_type,
cicd.usage_rate_or_amount rate_or_amount,
gl.currency_code,
msiv.primary_uom_code uom_code,
msiv.inventory_item_status_code item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
xxen_util.meaning(cic.inventory_asset_flag,'SYS_YES_NO',700) inventory_asset
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
mtl_system_items_vl msiv,
mtl_item_status_vl misv,
cst_item_costs cic,
cst_cost_types cct,
cst_item_cost_details cicd,
bom_resources br,
cst_cost_elements cce
where
1=1 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=msiv.organization_id and
msiv.inventory_asset_flag='Y' and
msiv.inventory_item_status_code=misv.inventory_item_status_code and
msiv.organization_id=cic.organization_id and
msiv.inventory_item_id=cic.inventory_item_id and
cic.based_on_rollup_flag=2 and
cic.cost_type_id=cct.cost_type_id and
cic.organization_id=cicd.organization_id and
cic.inventory_item_id=cicd.inventory_item_id and
cic.cost_type_id=cicd.cost_type_id and
cicd.level_type=1 and
cicd.resource_id=br.resource_id and
mp.organization_id=br.organization_id and
br.cost_element_id=cce.cost_element_id
order by
org_code,
to_cost_type,
item_number,
cost_element,
subelement,
basis_type

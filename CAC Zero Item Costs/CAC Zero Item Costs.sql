/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Zero Item Costs
-- Description: Report to show zero item costs in the Costing Method cost type, the creation date, the last transaction id, last transaction date and any onhand stock, based on the item master creation date.
-- Parameters:
-- Creation Date From: starting item master creation date (required).
-- Creation Date To: ending item master creation date (required).
-- Category Set 1: any item category you wish, typically the Cost or Product Line category set (optional).
-- Category Set 2: any item category you wish, typically the Inventory category set (optional).S
-- Item Number: enter the specific item number(s) you wish to report (optional).
-- Organization Code: enter the specific inventory organization(s) you wish to report (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2010 - 2023 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxzeroitemcostrept.sql
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 11 Mar 2010 Douglas Volz Initial Coding
-- -- | 1.1 29 Mar 2010 Douglas Volz Added item status and item type to the
-- -- | report and removed 9xx inventory orgs
-- -- | 1.2 05 Oct 2010 Douglas Volz Added Ledger parameter, updated column headings,
-- -- | added UOMCode column, added union all to
-- -- | select items with no costs at all
-- -- | 1.3 10 Feb 2017 Douglas Volz Removed client-specific org restrictions
-- -- | 1.4 22 May 2017 Douglas Volz Added product type, business code, product family,
-- -- | product line and package code item categories
-- -- | 1.5 17 Jul 2018 Douglas Volz Revised to report any two item categories.
-- -- | 1.6 27 Jan 2020 Douglas Volz Added OrgCode and OperatingUnit parameters.
-- -- | 1.7 27 Apr 2020 Douglas Volz Changed to multi-language views for the item
-- -- | master, inventory orgs and operating units
-- -- | 1.8 07 Nov 2020 Douglas Volz Changed to multi-language for status and UOM
-- -- | 1.9 09 Jul 2023 Douglas Volz Remove tabs and restrict to only orgs you have
-- -- | access to, using the org access view.
-- -- | 1.10 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards, items without an item type are reported.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-zero-item-costs/
-- Library Link: https://www.enginatics.com/reports/cac-zero-item-costs/
-- Run Report: https://demo.enginatics.com/

select
x.ledger,
x.operating_unit,
x.org_code,
x.item_number,
x.item_description,
x.item_type,
x.item_status,
x.make_buy_code,
&category_columns
x.allow_costs,
x.inventory_asset,
x.creation_date,
x.item_cost,
mmt.transaction_id last_transaction_number,
mmt.transaction_date last_transaction_date,
mtt.transaction_type_name last_transaction_type,
x.uom_code,
x.onhand_quantity
from
(
select
nvl(gl.short_name,gl.name) ledger,
haouv.name operating_unit,
mp.organization_code org_code,
msiv.concatenated_segments item_number,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
misv.inventory_item_status_code_tl item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
xxen_util.yes(msiv.costing_enabled_flag) allow_costs,
xxen_util.yes(msiv.inventory_asset_flag) inventory_asset,
msiv.creation_date,
cic.item_cost,
(select /*+ no_unnest*/ max(mmt.transaction_id) from mtl_material_transactions mmt where msiv.inventory_item_id=mmt.inventory_item_id and msiv.organization_id=mmt.organization_id) last_transaction_id,
msiv.primary_uom_code uom_code,
nvl((select sum(moqd.transaction_quantity) from mtl_onhand_quantities_detail moqd where msiv.inventory_item_id=moqd.inventory_item_id and msiv.organization_id=moqd.organization_id),0) onhand_quantity,
msiv.inventory_item_id,
msiv.organization_id
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv,
gl_ledgers gl,
mtl_system_items_vl msiv,
mtl_item_status_vl misv,
cst_item_costs cic
where
1=1 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=msiv.organization_id and
msiv.inventory_item_status_code=misv.inventory_item_status_code and
msiv.organization_id=cic.organization_id and
msiv.inventory_item_id=cic.inventory_item_id and
mp.primary_cost_method=cic.cost_type_id and
cic.item_cost=0
union all
select
nvl(gl.short_name,gl.name) ledger,
haouv.name operating_unit,
mp.organization_code org_code,
msiv.concatenated_segments item_number,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
misv.inventory_item_status_code_tl item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
xxen_util.yes(msiv.costing_enabled_flag) allow_costs,
xxen_util.yes(msiv.inventory_asset_flag) inventory_asset,
msiv.creation_date,
null item_cost,
(select /*+ no_unnest*/ max(mmt.transaction_id) from mtl_material_transactions mmt where msiv.inventory_item_id=mmt.inventory_item_id and msiv.organization_id=mmt.organization_id) last_transaction_id,
msiv.primary_uom_code uom_code,
nvl((select sum(moqd.transaction_quantity) from mtl_onhand_quantities_detail moqd where msiv.inventory_item_id=moqd.inventory_item_id and msiv.organization_id=moqd.organization_id),0) onhand_quantity,
msiv.inventory_item_id,
msiv.organization_id
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv,
gl_ledgers gl,
mtl_system_items_vl msiv,
mtl_item_status_vl misv
where
1=1 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=msiv.organization_id and
msiv.inventory_item_status_code=misv.inventory_item_status_code and
(msiv.organization_id,msiv.inventory_item_id,mp.primary_cost_method) not in (select cic.organization_id, cic.inventory_item_id, cic.cost_type_id from cst_item_costs cic)
) x,
mtl_material_transactions mmt,
mtl_transaction_types mtt
where
x.last_transaction_id=mmt.transaction_id(+) and
mmt.transaction_type_id=mtt.transaction_type_id(+)
order by
x.ledger,
x.operating_unit,
x.org_code,
x.item_number

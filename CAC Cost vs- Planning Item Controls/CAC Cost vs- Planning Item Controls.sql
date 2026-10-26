/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Cost vs. Planning Item Controls
-- Description: Compare item make/buy controls vs. costing based on rollup controls, to find errors with your cost rollup results. There are twelve included reports, see below description for more information.
-- Available Reports:
-- 1. Based on Rollup Yes - No BOMS
-- Find make items where the item is set to be rolled up but there are no BOMs. May roll up to a zero cost.
-- 2. Based on Rollup Yes - No Routing
-- Find make items costs are based on the cost rollup, but there are no routings.
-- 3. Based on Rollup Yes - No Rollup
-- Find make items where it is set to be rolled up but there are no rolled up costs
-- 4. Based on Rollup Yes - Buy Items
-- Find buy items where the item is set to rolled up
-- 5. Based on Rollup No - With BOMS
-- Find make items where the item is not set to be rolled up but BOMS or routings exist.
-- 6. Based on Rollup No - With Sourcing Rules
-- Find buy items where costs are not based on the cost rollup, but sourcing rules exist.
-- 7. Based on Rollup No - Make Items
-- Find make items where the item is not set to rolled up, whether or not BOMs or routings exist.
-- 8. Lot-Based Resources With Lot Size One
-- Find make items where there are charges based on Lot but the lot size is one. Duplicates the setup charges for each item you make.
-- 9. BOMs With No Components
-- Find make items with BOMS that have no components.
-- 10. Item Costing vs. Item Asset Controls
-- Find items where the item master costed flag (costed enabled) and the item asset flag do not match.
-- 11. Item Asset vs. Costing Asset Controls
-- Find items where the item master asset and the costing asset flags do not match.
-- 12. Based on Rollup No - Defaulted Costs
-- Find items where the item is not rolled up but the defaulted flag says Yes
-- Parameters:
-- ===========
-- Cost Type: the Frozen or Pending cost type you wish to report (mandatory).
-- Assignment Set: for your organization sourcing rules, enter an assignment set (optional).
-- Category Sets 1 - 3: any item category you wish, typically the Cost or Product Line category sets (optional).
-- Item Number: enter the specific item number(s) you wish to report (optional).
-- Organization Code: enter the specific inventory organization(s) you wish to report (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2008-2025 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- +=============================================================================+
-- -- | 1.0 15 Oct 2008 Douglas Volz Initial Coding
-- -- | 1.34 06 May 2021 Douglas Volz Using a with statement, summarized report type queries for efficiency.
-- -- | 1.35 23 Apr 2022 Douglas Volz Add new column "Defaulted Costs" and new report type "Based on
-- -- | Rollup No - Defaulted Costs". The defaulted flag indicates
-- -- | whether the cost of the item is defaulted from the default cost
-- -- | type during cost rollup.
-- -- | 1.36 07 Jan 2024 Douglas Volz Add current onhand quantities, to help find valuation issues. Remove
-- -- | tabs, add operating unit and ledger security and inventory access controls.
-- -- | 1.37 10 Apr 2025 Douglas Volz Added in new GL and OU security profiles.
-- -- | 1.38 13 Apr 2025 Douglas Volz Fix ORA-43916 Collation Error for character expressions 'Y', 'N'.
-- -- | 1.39 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-cost-vs-planning-item-controls/
-- Library Link: https://www.enginatics.com/reports/cac-cost-vs-planning-item-controls/
-- Run Report: https://demo.enginatics.com/

select
decode(rowgen.column_value,
1,'Based on Rollup Yes - No BOMs',
2,'Based on Rollup Yes - No Routing',
3,'Based on Rollup Yes - No Rollup',
4,'Based on Rollup Yes - Buy Items',
5,'Based on Rollup No - With BOMs',
6,'Based on Rollup No - With Sourcing Rules',
7,'Based on Rollup No - Make Items',
8,'Lot-Based Resources With Lot Size 1',
9,'BOMs With No Components',
10,'Item Costing vs. Item Asset Controls',
11,'Item Asset vs. Costing Asset Controls',
12,'Based on Rollup No - Defaulted Costs') report_type,
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
x.organization_code org_code,
x.cost_type,
x.item_number,
x.item_description,
x.uom_code,
xxen_util.meaning(x.item_type,'ITEM_TYPE',3) item_type,
x.item_status,
xxen_util.meaning(x.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
&category_columns
xxen_util.yes(x.bom) bom,
xxen_util.yes(x.routing) routing,
xxen_util.yes(x.sourcing_rule) sourcing_rule,
xxen_util.meaning(x.based_on_rollup_flag,'CST_BONROLLUP_VAL',700) based_on_rollup,
xxen_util.yes(decode(x.defaulted_flag,1,'Y')) defaulted_flag,
xxen_util.yes(x.costing_enabled_flag) costing_enabled,
xxen_util.yes(x.inventory_asset_flag) item_inventory_asset,
xxen_util.yes(decode(x.cost_asset_flag,1,'Y')) cost_inventory_asset,
x.std_lot_size item_std_lot_size,
x.cost_lot_size,
gl.currency_code,
x.item_cost,
x.onhand_quantity,
x.cost_creation_date,
x.item_creation_date
from
(
select
mp.organization_code,
cct.cost_type,
cic.cost_type_id,
msiv.organization_id,
msiv.inventory_item_id,
msiv.concatenated_segments item_number,
msiv.description item_description,
msiv.primary_uom_code uom_code,
msiv.item_type,
misv.inventory_item_status_code_tl item_status,
msiv.planning_make_buy_code,
case when exists (select null from bom_structures_b bsb where msiv.inventory_item_id=bsb.assembly_item_id and msiv.organization_id=bsb.organization_id and bsb.alternate_bom_designator is null) then 'Y' else 'N' end bom,
case when exists (select null from bom_operational_routings bor where msiv.inventory_item_id=bor.assembly_item_id and msiv.organization_id=bor.organization_id and bor.alternate_routing_designator is null) then 'Y' else 'N' end routing,
case when exists (select null from mrp_sr_assignments msa, mrp_assignment_sets mas, mrp_sr_receipt_org msro, mrp_sr_source_org msso where msiv.inventory_item_id=msa.inventory_item_id and msiv.organization_id=msa.organization_id and msa.assignment_set_id=mas.assignment_set_id and 3=3 and msa.sourcing_rule_id=msro.sourcing_rule_id and msro.sr_receipt_id=msso.sr_receipt_id and msso.source_organization_id is not null) then 'Y' else 'N' end sourcing_rule,
cic.based_on_rollup_flag,
cic.defaulted_flag,
msiv.costing_enabled_flag,
msiv.inventory_asset_flag,
cic.inventory_asset_flag cost_asset_flag,
msiv.std_lot_size,
cic.lot_size cost_lot_size,
cic.item_cost,
(select sum(moqd.primary_transaction_quantity) from mtl_onhand_quantities_detail moqd where msiv.inventory_item_id=moqd.inventory_item_id and msiv.organization_id=moqd.organization_id and moqd.is_consigned=2) onhand_quantity,
cic.creation_date cost_creation_date,
msiv.creation_date item_creation_date
from
mtl_parameters mp,
cst_item_costs cic,
cst_cost_types cct,
mtl_system_items_vl msiv,
mtl_item_status_vl misv
where
2=2 and
4=4 and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=cic.organization_id and
cic.cost_type_id=cct.cost_type_id and
cic.organization_id=msiv.organization_id and
cic.inventory_item_id=msiv.inventory_item_id and
msiv.inventory_item_status_code<>'Inactive' and
msiv.inventory_item_status_code=misv.inventory_item_status_code
) x,
table(xxen_util.rowgen(12)) rowgen,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl
where
1=1 and
x.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
case rowgen.column_value
when 1 then case when x.costing_enabled_flag='Y' and x.planning_make_buy_code=1 and x.based_on_rollup_flag=1 and x.bom='N' then 'Y' end
when 2 then case when x.costing_enabled_flag='Y' and x.planning_make_buy_code=1 and x.based_on_rollup_flag=1 and x.routing='N' then 'Y' end
when 3 then case when x.costing_enabled_flag='Y' and (x.planning_make_buy_code=1 or x.planning_make_buy_code=2 and x.sourcing_rule='Y') and x.based_on_rollup_flag=1 and not exists (select null from cst_item_cost_details cicd where x.inventory_item_id=cicd.inventory_item_id and x.organization_id=cicd.organization_id and x.cost_type_id=cicd.cost_type_id and cicd.rollup_source_type=3) then 'Y' end
when 4 then case when x.costing_enabled_flag='Y' and x.planning_make_buy_code=2 and x.based_on_rollup_flag=1 and x.sourcing_rule='N' then 'Y' end
when 5 then case when x.costing_enabled_flag='Y' and x.planning_make_buy_code=1 and x.based_on_rollup_flag=2 and (x.bom='Y' or x.routing='Y') then 'Y' end
when 6 then case when x.costing_enabled_flag='Y' and x.based_on_rollup_flag=2 and x.sourcing_rule='Y' then 'Y' end
when 7 then case when x.costing_enabled_flag='Y' and x.planning_make_buy_code=1 and x.based_on_rollup_flag=2 then 'Y' end
when 8 then case when x.costing_enabled_flag='Y' and nvl(x.cost_lot_size,1)=1 and x.planning_make_buy_code=1 and exists (select null from cst_item_cost_details cicd where x.inventory_item_id=cicd.inventory_item_id and x.organization_id=cicd.organization_id and x.cost_type_id=cicd.cost_type_id and cicd.basis_type=2) then 'Y' end
when 9 then case when x.costing_enabled_flag='Y' and x.based_on_rollup_flag=1 and x.bom='Y' and not exists (select null from bom_structures_b bsb, bom_components_b bcb where x.inventory_item_id=bsb.assembly_item_id and x.organization_id=bsb.organization_id and bsb.bill_sequence_id=bcb.bill_sequence_id and bcb.effectivity_date<=sysdate and nvl(bcb.disable_date,sysdate+1)>sysdate) then 'Y' end
when 10 then case when x.costing_enabled_flag<>x.inventory_asset_flag then 'Y' end
when 11 then case when x.inventory_asset_flag<>decode(x.cost_asset_flag,1,'Y','N') then 'Y' end
when 12 then case when x.defaulted_flag=1 and x.based_on_rollup_flag=2 then 'Y' end
end='Y'
order by
report_type,
ledger,
operating_unit,
org_code,
x.cost_type,
x.item_number

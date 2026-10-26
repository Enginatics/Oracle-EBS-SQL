/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Where Used by Cost Type
-- Description: Report to download the single-level bills of materials and related component information, by organization by cost type. And while exploding the bills of material you can also compare with two cost types, as well as limit the report to only assemblies and component items with a zero item cost.
-- / +=============================================================================+
-- -- | Copyright 2013 - 2019 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxwhereusedbycosttyperept.sql
-- -- |
-- -- | Parameters:
-- -- | pcosttype -- Cost type costs to report, enter a cost type name.
-- -- | Required.
-- -- | pcategoryset1 -- The first item category set to report, typically the
-- -- | Cost or Product Line Category Set
-- -- | pcategoryset2 -- The second item category set to report, typically the
-- -- | Inventory Category Set
-- -- | passemblynumber -- Enter the specific assembly number you wish to report (optional)
-- -- | pcomponentnumber -- Enter the specific component number you wish to report (optional)
-- -- | ponlyzerocosts -- Show assemblies and components with a zero cost (optional)
-- -- | pincludeexpenseitems -- Yes/No flag to include or not include non-asset (not valued)
-- -- | pincludeuncosteditems -- Yes/No flag to include or not costing not enabled items (optional)
-- -- | porgcode -- Specific inventory organization you wish to report (optional)
-- -- | poperatingunit -- Operating Unit you wish to report, leave blank for all
-- -- | operating units (optional)
-- -- | pledger -- general ledger you wish to report, leave blank for all
-- -- | ledgers (optional)
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 08-Jun-2017 Douglas Volz Initial Coding based on xxxslbomextract.sql
-- -- | 1.1 05-Nov-2018 Douglas Volz Modified to client's item categories, don't
-- -- | report obsolete items and remove location info.
-- -- | 1.2 03 Sep 2019 Douglas Volz Add Ledger, Operating Unit, Item Type, Status
-- -- | and item categories for cost and inventory.
-- -- | 1.3 27 Jan 2020 Douglas Volz Added Operating Unit and Ledger parameters.
-- -- | 1.4 13 Jul 2020 Douglas Volz Added item costs, parameters for components
-- -- | and assemblies at a zero item cost, and
-- -- | changed to multi-language views for translation.
-- -- | 1.5 24 Aug 2020 Douglas Volz Component WIP Supply Type not always populated,
-- -- | needed to add an outer join on the lookup code.
-- -- | 1.6 01 Sep 2020 Douglas Volz Revision to avoid getting other cost type
-- -- | entries for non-asset and uncosted items.
-- -- | 1.7 14 Sep 2020 Douglas Volz Revision for faster queries by item number.
-- -- | 1.9 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-where-used-by-cost-type/
-- Library Link: https://www.enginatics.com/reports/cac-where-used-by-cost-type/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
x.organization_code org_code,
msiv.concatenated_segments assembly,
msiv.description assembly_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) assembly_item_type,
msiv.inventory_item_status_code assembly_status_code,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) assembly_make_buy_code,
xxen_util.yes(msiv.costing_enabled_flag) assembly_costing_enabled,
xxen_util.yes(msiv.inventory_asset_flag) assembly_asset,
msiv.primary_uom_code uom_code,
xxen_util.meaning(1,'BOM_TRANSITION_TYPE',700) bom_type,
x.implementation_date date_implemented,
(select max(mirb.revision) from mtl_item_revisions_b mirb where msiv.inventory_item_id=mirb.inventory_item_id and msiv.organization_id=mirb.organization_id and mirb.effectivity_date<=sysdate) item_revision,
&category_columns
nvl(cic_assy2.item_cost,0) "&p_cost_type2 Assembly Cost",
nvl(cic_assy.item_cost,0) "&p_cost_type Assembly Cost",
nvl(cic_assy2.item_cost,0)-nvl(cic_assy.item_cost,0) assembly_cost_difference,
round(
case
when round(nvl(cic_assy2.item_cost,0)-nvl(cic_assy.item_cost,0),5)=0 then 0
when round(nvl(cic_assy2.item_cost,0),5)=0 then -100
when round(nvl(cic_assy.item_cost,0),5)=0 then 100
else round(nvl(cic_assy2.item_cost,0)-nvl(cic_assy.item_cost,0),5)/round(nvl(cic_assy.item_cost,0),5)*100
end,2) assembly_percent_difference,
x.operation_seq_num op_seq,
x.item_num item_seq,
msiv2.concatenated_segments component,
msiv2.description component_description,
msiv2.primary_uom_code component_uom,
xxen_util.meaning(msiv2.item_type,'ITEM_TYPE',3) component_item_type,
msiv2.inventory_item_status_code component_status_code,
xxen_util.meaning(msiv2.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) component_make_buy_code,
xxen_util.yes(msiv2.costing_enabled_flag) component_costing_enabled,
xxen_util.yes(msiv2.inventory_asset_flag) component_asset,
x.component_quantity quantity_per_assembly,
x.effectivity_date effective_from,
x.disable_date effective_to,
nvl(x.planning_factor,0) planning_percent,
x.component_yield_factor yield,
xxen_util.yes(decode(x.include_in_cost_rollup,1,'Y')) include_in_cost_rollup,
xxen_util.meaning(x.wip_supply_type,'WIP_SUPPLY',700) wip_supply_type,
nvl(cic_comp2.item_cost,0) "&p_cost_type2 Component Cost",
nvl(cic_comp.item_cost,0) "&p_cost_type Component Cost",
nvl(cic_comp2.item_cost,0)-nvl(cic_comp.item_cost,0) component_cost_difference,
round(
case
when round(nvl(cic_comp2.item_cost,0)-nvl(cic_comp.item_cost,0),5)=0 then 0
when round(nvl(cic_comp2.item_cost,0),5)=0 then -100
when round(nvl(cic_comp.item_cost,0),5)=0 then 100
else round(nvl(cic_comp2.item_cost,0)-nvl(cic_comp.item_cost,0),5)/round(nvl(cic_comp.item_cost,0),5)*100
end,2) component_percent_difference,
nvl((select sum(moqd.primary_transaction_quantity) from mtl_onhand_quantities_detail moqd where msiv.inventory_item_id=moqd.inventory_item_id and msiv.organization_id=moqd.organization_id),0) assembly_onhand_quantity,
nvl((select sum(moqd.primary_transaction_quantity) from mtl_onhand_quantities_detail moqd where msiv2.inventory_item_id=moqd.inventory_item_id and msiv2.organization_id=moqd.organization_id),0) component_onhand_quantity
from
(
select
mp.organization_code,
bsb.organization_id,
bsb.assembly_item_id,
bsb.implementation_date,
bcb.item_num,
bcb.operation_seq_num,
bcb.component_item_id,
bcb.component_quantity,
max(bcb.effectivity_date) effectivity_date,
bcb.disable_date,
bcb.planning_factor,
bcb.component_yield_factor,
bcb.include_in_cost_rollup,
bcb.wip_supply_type,
bcb.supply_subinventory,
bcb.supply_locator_id
from
mtl_parameters mp,
bom_structures_b bsb,
bom_components_b bcb
where
5=5 and
8=8 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=bsb.organization_id and
bsb.assembly_type=1 and
bsb.alternate_bom_designator is null and
bsb.common_assembly_item_id is null and
bsb.bill_sequence_id=bcb.bill_sequence_id and
bcb.effectivity_date<=sysdate and
nvl(bcb.disable_date,sysdate+1)>sysdate
group by
mp.organization_code,
bsb.organization_id,
bsb.assembly_item_id,
bsb.implementation_date,
bcb.item_num,
bcb.operation_seq_num,
bcb.component_item_id,
bcb.component_quantity,
bcb.disable_date,
bcb.planning_factor,
bcb.component_yield_factor,
bcb.include_in_cost_rollup,
bcb.wip_supply_type,
bcb.supply_subinventory,
bcb.supply_locator_id
) x,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
mtl_system_items_vl msiv,
mtl_system_items_vl msiv2,
(select cic.organization_id, cic.inventory_item_id, cic.item_cost from cst_item_costs cic, cst_cost_types cct where cic.cost_type_id=cct.cost_type_id and 4=4) cic_assy,
(select cic.organization_id, cic.inventory_item_id, cic.item_cost from cst_item_costs cic, cst_cost_types cct where cic.cost_type_id=cct.cost_type_id and 4=4) cic_comp,
(select cic.organization_id, cic.inventory_item_id, cic.item_cost from cst_item_costs cic, cst_cost_types cct where cic.cost_type_id=cct.cost_type_id and 9=9) cic_assy2,
(select cic.organization_id, cic.inventory_item_id, cic.item_cost from cst_item_costs cic, cst_cost_types cct where cic.cost_type_id=cct.cost_type_id and 9=9) cic_comp2
where
1=1 and
6=6 and
7=7 and
x.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
x.organization_id=msiv.organization_id and
x.assembly_item_id=msiv.inventory_item_id and
msiv.inventory_item_status_code<>'Inactive' and
x.organization_id=msiv2.organization_id and
x.component_item_id=msiv2.inventory_item_id and
msiv2.inventory_item_status_code<>'Inactive' and
msiv.organization_id=cic_assy.organization_id(+) and
msiv.inventory_item_id=cic_assy.inventory_item_id(+) and
msiv2.organization_id=cic_comp.organization_id(+) and
msiv2.inventory_item_id=cic_comp.inventory_item_id(+) and
msiv.organization_id=cic_assy2.organization_id(+) and
msiv.inventory_item_id=cic_assy2.inventory_item_id(+) and
msiv2.organization_id=cic_comp2.organization_id(+) and
msiv2.inventory_item_id=cic_comp2.inventory_item_id(+)
order by
ledger,
operating_unit,
org_code,
assembly,
op_seq,
item_seq,
component

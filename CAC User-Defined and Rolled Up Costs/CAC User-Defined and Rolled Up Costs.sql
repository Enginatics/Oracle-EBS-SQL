/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC User-Defined and Rolled Up Costs
-- Description: Use this report to find items with both user-defined (manually entered) and rolled up costs, for material and other cost elements. Useful to find rolled up assemblies where the item costs have been accidentally doubled-up.
-- Parameters:
-- ===========
-- Cost Type: enter the cost type to report (mandatory).
-- Category Set 1: any item category you wish, typically the Cost or Product Line category set (optional).
-- Category Set 2: any item category you wish, typically the Inventory category set (optional).
-- Assignment Set: enter the sourcing rule assignment set, used when transferring items between inventory organizations on internal requisitions.
-- Item Number: enter the specific item number(s) you wish to report (optional).
-- Organization Code: enter the specific inventory organization(s) you wish to report (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2010-2023 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this
-- -- | permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxuserdefinedrolledupcostrept.sql
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 29 Dec 2010 Douglas Volz Create new report to find items with
-- -- | both manually entered and rolled up material costs
-- -- | 1.1 24 May 2011 Douglas Volz Bug fix for the resource code column
-- -- | 1.2 19 Oct 2019 Douglas Volz Add columns for non-material costs
-- -- | 1.3 27 Jan 2020 Douglas Volz Added OperatingUnit parameter and outer
-- -- | join for ItemType.
-- -- | 1.4 05 May 2021 Douglas Volz Modify for multi-language tables.
-- -- | 1.5 12 Jan 2023 Douglas Volz Correction for definition of manually entered
-- -- | material costs.
-- -- | 1.6 20 Nov 2023 Douglas Volz Fix for Manual Other Costs and Rolled Up Other Costs columns.
-- -- | 1.7 05 Dec 2023 Douglas Volz Added G/L and Operating Unit security restrictions.
-- -- | 1.8 07 Jan 2024 Douglas Volz Add onhand quantities, to help find valuation issues. Remove tabs.
-- -- | 1.10 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-user-defined-and-rolled-up-costs/
-- Library Link: https://www.enginatics.com/reports/cac-user-defined-and-rolled-up-costs/
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
&category_columns
(select max(xxen_util.meaning(cicd.rollup_source_type,'CST_SOURCE_TYPE',700)) from cst_item_cost_details cicd, bom_resources br where cic.inventory_item_id=cicd.inventory_item_id and cic.organization_id=cicd.organization_id and cic.cost_type_id=cicd.cost_type_id and cicd.item_cost<>0 and cicd.cost_element_id=1 and cicd.resource_id=br.resource_id) rollup_source_type,
(select max(br.resource_code) from cst_item_cost_details cicd, bom_resources br where cic.inventory_item_id=cicd.inventory_item_id and cic.organization_id=cicd.organization_id and cic.cost_type_id=cicd.cost_type_id and cicd.item_cost<>0 and cicd.cost_element_id=1 and cicd.resource_id=br.resource_id) material_sub_element,
xxen_util.yes(case when exists (select null from bom_structures_b bsb where msiv.inventory_item_id=bsb.assembly_item_id and msiv.organization_id=bsb.organization_id and bsb.alternate_bom_designator is null) then 'Y' end) bom,
xxen_util.yes((select 'Y' from bom_operational_routings bor where msiv.inventory_item_id=bor.assembly_item_id and msiv.organization_id=bor.organization_id and bor.alternate_routing_designator is null)) routing,
xxen_util.yes(case when exists (select null from mrp_sr_assignments msa, mrp_assignment_sets mas, mrp_sr_receipt_org msro, mrp_sr_source_org msso where msiv.inventory_item_id=msa.inventory_item_id and msiv.organization_id=msa.organization_id and msa.assignment_set_id=mas.assignment_set_id and 2=2 and msa.sourcing_rule_id=msro.sourcing_rule_id and msro.sr_receipt_id=msso.sr_receipt_id and msso.source_organization_id is not null) then 'Y' end) sourcing_rule,
xxen_util.meaning(cic.based_on_rollup_flag,'CST_BONROLLUP_VAL',700) based_on_rollup,
xxen_util.yes(decode(cic.inventory_asset_flag,1,'Y')) inventory_asset,
gl.currency_code,
cic.item_cost,
nvl((select sum(cicd.item_cost) from cst_item_cost_details cicd, bom_resources br where cic.inventory_item_id=cicd.inventory_item_id and cic.organization_id=cicd.organization_id and cic.cost_type_id=cicd.cost_type_id and cicd.item_cost<>0 and cicd.cost_element_id=1 and cicd.level_type=1 and cicd.rollup_source_type=1 and cicd.resource_id=br.resource_id),0) manual_material_costs,
nvl((select sum(cicd.item_cost) from cst_item_cost_details cicd where cic.inventory_item_id=cicd.inventory_item_id and cic.organization_id=cicd.organization_id and cic.cost_type_id=cicd.cost_type_id and cicd.item_cost<>0 and cicd.cost_element_id=1 and cicd.level_type=2 and cicd.rollup_source_type=3),0) rolled_up_material_costs,
nvl((select sum(cicd.item_cost) from cst_item_cost_details cicd where cic.inventory_item_id=cicd.inventory_item_id and cic.organization_id=cicd.organization_id and cic.cost_type_id=cicd.cost_type_id and cicd.item_cost<>0 and cicd.cost_element_id<>1 and cicd.level_type=1 and cicd.rollup_source_type=1),0) manual_other_costs,
nvl((select sum(cicd.item_cost) from cst_item_cost_details cicd where cic.inventory_item_id=cicd.inventory_item_id and cic.organization_id=cicd.organization_id and cic.cost_type_id=cicd.cost_type_id and cicd.item_cost<>0 and cicd.cost_element_id<>1 and cicd.rollup_source_type in (2,3)),0) rolled_up_other_costs,
(select sum(moqd.primary_transaction_quantity) from mtl_onhand_quantities_detail moqd where msiv.inventory_item_id=moqd.inventory_item_id and msiv.organization_id=moqd.organization_id and moqd.is_consigned=2) onhand_quantity,
cic.creation_date cost_creation_date,
msiv.creation_date item_creation_date
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
cst_item_costs cic,
cst_cost_types cct,
mtl_system_items_vl msiv
where
1=1 and
3=3 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=cic.organization_id and
cic.cost_type_id=cct.cost_type_id and
cic.based_on_rollup_flag=1 and
cic.organization_id=msiv.organization_id and
cic.inventory_item_id=msiv.inventory_item_id and
msiv.inventory_item_status_code<>'Inactive' and
exists (select null from cst_item_cost_details cicd where cic.inventory_item_id=cicd.inventory_item_id and cic.organization_id=cicd.organization_id and cic.cost_type_id=cicd.cost_type_id and cicd.item_cost<>0 and cicd.cost_element_id=1 and cicd.level_type=1 and cicd.rollup_source_type=1) and
exists (select null from cst_item_cost_details cicd where cic.inventory_item_id=cicd.inventory_item_id and cic.organization_id=cicd.organization_id and cic.cost_type_id=cicd.cost_type_id and cicd.item_cost<>0 and cicd.cost_element_id=1 and cicd.level_type=2 and cicd.rollup_source_type=3) and
(
exists (select null from bom_structures_b bsb where cic.inventory_item_id=bsb.assembly_item_id and cic.organization_id=bsb.organization_id and bsb.alternate_bom_designator is null) or
exists (select null from bom_operational_routings bor where cic.inventory_item_id=bor.assembly_item_id and cic.organization_id=bor.organization_id) or
exists (select null from mrp_sr_assignments msa, mrp_assignment_sets mas, mrp_sr_receipt_org msro, mrp_sr_source_org msso where cic.inventory_item_id=msa.inventory_item_id and cic.organization_id=msa.organization_id and msa.assignment_set_id=mas.assignment_set_id and 2=2 and msa.sourcing_rule_id=msro.sourcing_rule_id and msro.sr_receipt_id=msso.sr_receipt_id and msso.source_organization_id is not null)
)
order by
ledger,
operating_unit,
org_code,
cct.cost_type,
item_number

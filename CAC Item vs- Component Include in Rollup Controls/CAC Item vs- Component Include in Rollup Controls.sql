/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Item vs. Component Include in Rollup Controls
-- Description: Use this report to find items where the item master default setting for include in rollup does not match the BOM component include in rollup setting. This report includes items which are available for costing, where the inventory costing enabled flag is Yes. And excludes inactive items. (This report was removed from the Cost vs. Planning Item Control Report, for performance reasons.)
-- / +=============================================================================+
-- -- | Copyright 2021 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxitemincludeinbomctrlsrepts.sql
-- -- |
-- -- | Parameters:
-- -- |
-- -- | pcosttype -- Desired cost type, mandatory
-- -- | passignmentset -- The assignment set you wish to report (optional)
-- -- | pitemnumber -- Specific item number, to get all values enter a
-- -- | null value or blank value
-- -- | porgcode -- Specific inventory organization you wish to report (optional)
-- -- | poperatingunit -- OperatingUnit you wish to report, leave blank for all
-- -- | operating units (optional)
-- -- | pledger -- general ledger you wish to report, leave blank for all
-- -- | ledgers (optional)
-- -- |
-- -- | Description:
-- -- | Use the below SQL scripts to find items where the item default include in
-- -- | rollup does not match the BOM component include in rollup. (Removed from
-- -- | the Cost vs. Planning Item Control Report, for performance reasons.)
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 07 May 2021 Douglas Volz Initial Coding, based on the Cost vs.
-- -- | Planning Item Control Report, version 33.
-- -- | 1.1 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-item-vs-component-include-in-rollup-controls/
-- Library Link: https://www.enginatics.com/reports/cac-item-vs-component-include-in-rollup-controls/
-- Run Report: https://demo.enginatics.com/

select distinct
'Compare Item vs. Component Include in Rollup Controls' report_type,
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
cct.cost_type,
msiv.concatenated_segments component_number,
msiv.description component_description,
msiv_assy.concatenated_segments assembly_number,
msiv_assy.description assembly_description,
msiv.primary_uom_code uom_code,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
misv.inventory_item_status_code_tl item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
&category_columns
xxen_util.yes(case when exists (select null from bom_structures_b bsb2 where msiv.inventory_item_id=bsb2.assembly_item_id and msiv.organization_id=bsb2.organization_id and bsb2.alternate_bom_designator is null) then 'Y' end) bom,
xxen_util.yes((select 'Y' from bom_operational_routings bor where msiv.inventory_item_id=bor.assembly_item_id and msiv.organization_id=bor.organization_id and bor.alternate_routing_designator is null)) routing,
xxen_util.yes(case when exists (select null from mrp_sr_assignments msa, mrp_assignment_sets mas, mrp_sr_receipt_org msro, mrp_sr_source_org msso where msiv.inventory_item_id=msa.inventory_item_id and msiv.organization_id=msa.organization_id and msa.assignment_set_id=mas.assignment_set_id and 3=3 and msa.sourcing_rule_id=msro.sourcing_rule_id and msro.sr_receipt_id=msso.sr_receipt_id and msso.source_organization_id is not null) then 'Y' end) sourcing_rule,
xxen_util.meaning(cic.based_on_rollup_flag,'CST_BONROLLUP_VAL',700) based_on_rollup,
xxen_util.yes(msiv.costing_enabled_flag) costing_enabled,
xxen_util.yes(msiv.inventory_asset_flag) item_inventory_asset,
xxen_util.yes(decode(cic.inventory_asset_flag,1,'Y')) cost_inventory_asset,
xxen_util.yes(msiv.default_include_in_rollup_flag) item_include_in_rollup,
xxen_util.yes(decode(bcb.include_in_cost_rollup,1,'Y')) bom_include_in_rollup,
xxen_util.meaning(bcb.wip_supply_type,'WIP_SUPPLY',700) wip_supply_type,
gl.currency_code,
cic.item_cost,
msiv.creation_date item_creation_date
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
cst_item_costs cic,
cst_cost_types cct,
mtl_system_items_vl msiv,
mtl_item_status_vl misv,
bom_components_b bcb,
bom_structures_b bsb,
mtl_system_items_vl msiv_assy
where
1=1 and
2=2 and
4=4 and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=cic.organization_id and
cic.cost_type_id=cct.cost_type_id and
cic.organization_id=msiv.organization_id and
cic.inventory_item_id=msiv.inventory_item_id and
msiv.costing_enabled_flag='Y' and
msiv.inventory_item_status_code<>'Inactive' and
msiv.inventory_item_status_code=misv.inventory_item_status_code and
msiv.inventory_item_id=bcb.component_item_id and
bcb.effectivity_date<=sysdate and
nvl(msiv.default_include_in_rollup_flag,'N')<>decode(bcb.include_in_cost_rollup,1,'Y',2,'N') and
bcb.bill_sequence_id=bsb.bill_sequence_id and
msiv.organization_id=bsb.organization_id and
bsb.assembly_type=1 and
bsb.alternate_bom_designator is null and
bsb.common_assembly_item_id is null and
bsb.organization_id=msiv_assy.organization_id and
bsb.assembly_item_id=msiv_assy.inventory_item_id and
msiv_assy.inventory_item_status_code<>'Inactive'
order by
ledger,
operating_unit,
org_code,
cct.cost_type,
component_number,
assembly_number

/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Last Standard Item Cost
-- Description: Report to show the last standard item cost as of a specified cost update date; expecially useful if you have not saved off your Frozen costs at year-end, before updating to your new standard costs for the following year. Including various item controls, last cost update submission, last standard item cost and current (Frozen) item cost. And whether or not BOMs, routings or (inventory organization) sourcing rules exist for the item as of the specified cost update date. And as allowed with no onhand or intransit quantities, if an item cost has been directly entered into the Frozen Cost Type, the Cost Update Request Id, Cost Update Description, Cost Update Status and related cost update submission columns will be blank or empty.
-- This report complements the CAC New Standard Item Cost report. The CAC New Standard Item Cost report shows you the cost update history over a range of Standard Cost Revision Dates, useful to track standard cost changes on a weekly basis. The CAC Last Standard Item Cost report shows you how each item got its last Standard Item Cost as of a given Standard Cost Revision Date. Useful to assess when the current standard costs were created and by whom.
-- Parameters:
-- ==========
-- Cost Update Date To: ending cost update revision date, based on standard cost submission history (required).
-- Category Set 1: any item category you wish, typically the Cost or Product Line category set (optional).
-- Category Set 2: any item category you wish, typically the Inventory category set (optional).
-- Item Status to Exclude: enter the item status to exclude from this report, defaults to Inactive (optional).
-- Item Number: enter the specific item number(s) you wish to report (optional).
-- Organization Code: enter the specific inventory organization(s) you wish to report (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2024 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxlaststandarditemcostrept.sql
-- -- |
-- -- | Description:
-- -- | Report to show the last standard cost for all items in an inventory organization,
-- -- | up to the entered Cost Update Date parameter.
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 15 Jan 2024 Douglas Volz Initial coding based on the New Standard Item Cost report.
-- -- | 1.1 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-last-standard-item-cost/
-- Library Link: https://www.enginatics.com/reports/cac-last-standard-item-cost/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
msiv.concatenated_segments item_number,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
msiv.creation_date item_creation_date,
msiv.last_update_date item_last_update_date,
xxen_util.user_name(msiv.created_by) item_created_by,
xxen_util.user_name(msiv.last_updated_by) item_last_updated_by,
misv.inventory_item_status_code_tl item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
msiv.std_lot_size,
xxen_util.yes(case when csc.inventory_item_id is not null and exists (select null from bom_structures_b bsb where msiv.inventory_item_id=bsb.assembly_item_id and msiv.organization_id=bsb.organization_id and bsb.alternate_bom_designator is null and bsb.implementation_date<:p_cost_update_date_to+1) then 'Y' end) bom,
xxen_util.yes(case when csc.inventory_item_id is not null and exists (select null from bom_operational_routings bor where msiv.inventory_item_id=bor.assembly_item_id and msiv.organization_id=bor.organization_id and bor.alternate_routing_designator is null and bor.creation_date<:p_cost_update_date_to+1) then 'Y' end) routing,
xxen_util.yes(case when csc.inventory_item_id is not null and exists (select null from mrp_sr_assignments msa, mrp_assignment_sets mas, mrp_sr_receipt_org msro, mrp_sr_source_org msso where msiv.inventory_item_id=msa.inventory_item_id and msiv.organization_id=msa.organization_id and msa.creation_date<:p_cost_update_date_to+1 and msa.assignment_set_id=mas.assignment_set_id and 5=5 and msa.sourcing_rule_id=msro.sourcing_rule_id and msro.sr_receipt_id=msso.sr_receipt_id and msso.source_organization_id is not null) then 'Y' end) sourcing_rule,
&category_columns
xxen_util.yes(msiv.costing_enabled_flag) allow_costs,
xxen_util.yes(decode(cic.inventory_asset_flag,1,'Y')) inventory_asset,
xxen_util.meaning(cic.based_on_rollup_flag,'CST_BONROLLUP_VAL',700) based_on_rollup,
cic.lot_size costing_lot_size,
cic.shrinkage_rate,
csc.standard_cost_revision_date cost_update_date,
csc.cost_update_id,
xxen_util.user_name(csc.created_by) cost_update_created_by,
ccu.request_id cost_update_request_id,
csc.standard_cost last_standard_cost,
cic.item_cost current_standard_cost,
msiv.primary_uom_code uom_code,
csc.inventory_adjustment_quantity inventory_adjustment_qty,
csc.inventory_adjustment_value,
csc.intransit_adjustment_quantity intransit_adjustment_qty,
csc.intransit_adjustment_value,
csc.wip_adjustment_quantity wip_adjustment_qty,
csc.wip_adjustment_value,
nvl(cct_ccu.cost_type,cct.cost_type) "From Cost Type",
ccu.description "Cost Update Description",
xxen_util.meaning(ccu.status,'CST_COST_UPDATE_STATUS',700) cost_update_status,
xxen_util.meaning(ccu.range_option,'CST_ITEM_RANGE',700) cost_update_range,
msiv_ccu.concatenated_segments single_item_number,
msiv_ccu.description single_item_description,
ccu.item_range_low,
ccu.item_range_high,
(select mcsv.category_set_name from mtl_category_sets_vl mcsv where ccu.category_set_id=mcsv.category_set_id) category_set,
(select mcv.category_concat_segs from mtl_categories_v mcv where ccu.category_id=mcv.category_id) category_name,
xxen_util.yes(decode(ccu.snapshot_saved_flag,1,'Y')) cost_details_saved,
xxen_util.yes(decode(ccu.update_resource_ovhd_flag,1,'Y')) updated_resources_overheads,
xxen_util.yes(decode(ccu.update_activity_flag,1,'Y')) updated_activity_costs,
&segment_columns
gcck.concatenated_segments adjustment_account
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
cst_cost_types cct,
cst_item_costs cic,
mtl_system_items_vl msiv,
mtl_item_status_vl misv,
(
select
csc.organization_id,
csc.inventory_item_id,
csc.cost_update_id,
csc.standard_cost_revision_date,
csc.created_by,
csc.standard_cost,
csc.inventory_adjustment_quantity,
csc.inventory_adjustment_value,
csc.intransit_adjustment_quantity,
csc.intransit_adjustment_value,
csc.wip_adjustment_quantity,
csc.wip_adjustment_value,
row_number() over (partition by csc.organization_id,csc.inventory_item_id order by csc.cost_update_id desc) rn
from
mtl_parameters mp,
cst_standard_costs csc
where
2=2 and
3=3 and
4=4 and
mp.organization_id=csc.organization_id
) csc,
cst_cost_updates ccu,
cst_cost_types cct_ccu,
mtl_system_items_vl msiv_ccu,
gl_code_combinations_kfv gcck
where
1=1 and
3=3 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.primary_cost_method=cct.cost_type_id and
mp.organization_id=cic.organization_id and
mp.primary_cost_method=cic.cost_type_id and
cic.organization_id=msiv.organization_id and
cic.inventory_item_id=msiv.inventory_item_id and
msiv.inventory_item_status_code=misv.inventory_item_status_code and
msiv.organization_id=csc.organization_id(+) and
msiv.inventory_item_id=csc.inventory_item_id(+) and
csc.rn(+)=1 and
csc.cost_update_id=ccu.cost_update_id(+) and
ccu.cost_type_id=cct_ccu.cost_type_id(+) and
ccu.organization_id=msiv_ccu.organization_id(+) and
ccu.single_item=msiv_ccu.inventory_item_id(+) and
ccu.inv_adjustment_account=gcck.code_combination_id(+)
order by
ledger,
operating_unit,
org_code,
item_number,
cost_update_date,
csc.cost_update_id

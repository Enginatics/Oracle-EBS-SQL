/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC New Standard Item Costs
-- Description: Report to show items which have recent item cost changes, including various item controls, last cost update submission, new standard item cost, prior item cost and current (Frozen) item cost, by cost update date. And whether or not BOMs, routings or (inventory organization) sourcing rules exist for the item. As allowed with no onhand or intransit quantities, if an item cost has been directly entered into the Frozen Cost Type, the Cost Update Request Id, Cost Update Description, Cost Update Status and related cost update submission columns will be blank or empty.
-- Parameters:
-- Cost Update Date From: starting cost update date, based on standard cost submission history (required).
-- Cost Update Date To: ending cost update date, based on standard cost submission history (required).
-- From Cost Type: enter the cost type implemented by the Standard Cost Update into the Frozen costs (optional).
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
-- -- | Program Name: xxxnewstandarditemcostrept.sql
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 29 Sep 2023 Douglas Volz Initial coding based on the Cost Update
-- -- | Submissions report.
-- -- | 1.1 30 Oct 2023 Douglas Volz Added Item Created By, Last Updated By
-- -- | and BOM/Routing/Sourcing Rules exist columns.
-- -- | 1.2 22 Nov 2023 Douglas Volz Add item master and costing lot sizes, and
-- -- | use default controls columns.
-- -- | 1.3 05 Dec 2023 Douglas Volz Added G/L and Operating Unit security restrictions.
-- -- | 1.4 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-new-standard-item-costs/
-- Library Link: https://www.enginatics.com/reports/cac-new-standard-item-costs/
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
xxen_util.yes(case when exists (select null from bom_structures_b bsb where msiv.inventory_item_id=bsb.assembly_item_id and msiv.organization_id=bsb.organization_id and bsb.alternate_bom_designator is null) then 'Y' end) bom,
xxen_util.yes((select 'Y' from bom_operational_routings bor where msiv.inventory_item_id=bor.assembly_item_id and msiv.organization_id=bor.organization_id and bor.alternate_routing_designator is null)) routing,
xxen_util.yes(case when exists (select null from mrp_sr_assignments msa, mrp_sr_receipt_org msro, mrp_sr_source_org msso where msiv.inventory_item_id=msa.inventory_item_id and msiv.organization_id=msa.organization_id and msa.sourcing_rule_id=msro.sourcing_rule_id and msro.sr_receipt_id=msso.sr_receipt_id and msso.source_organization_id is not null) then 'Y' end) sourcing_rule,
&category_columns
xxen_util.yes(msiv.costing_enabled_flag) allow_costs,
xxen_util.yes(decode(cic.inventory_asset_flag,1,'Y')) inventory_asset,
xxen_util.yes(decode(cic.defaulted_flag,1,'Y')) use_default_controls,
xxen_util.meaning(cic.based_on_rollup_flag,'CST_BONROLLUP_VAL',700) based_on_rollup,
cic.lot_size costing_lot_size,
cic.shrinkage_rate,
csc.standard_cost_revision_date cost_update_date,
csc.cost_update_id,
xxen_util.user_name(csc.created_by) cost_update_created_by,
ccu.request_id cost_update_request_id,
csc.standard_cost new_standard_cost,
csc.prior_standard_cost,
cic.item_cost current_standard_cost,
msiv.primary_uom_code uom_code,
csc.inventory_adjustment_quantity inventory_adjustment_qty,
csc.inventory_adjustment_value,
csc.intransit_adjustment_quantity intransit_adjustment_qty,
csc.intransit_adjustment_value,
csc.wip_adjustment_quantity wip_adjustment_qty,
csc.wip_adjustment_value,
decode(ccu.cost_type_id,mp.primary_cost_method,null,cct.cost_type) from_cost_type,
ccu.description cost_update_description,
xxen_util.meaning(ccu.status,'CST_COST_UPDATE_STATUS',700) cost_update_status,
xxen_util.meaning(ccu.range_option,'CST_ITEM_RANGE',700) cost_update_range,
msiv_ccu.concatenated_segments specific_item_number,
msiv_ccu.description specific_item_description,
ccu.item_range_low,
ccu.item_range_high,
(select mcsv.category_set_name from mtl_category_sets_vl mcsv where ccu.category_set_id=mcsv.category_set_id) category_set,
(select mcv.category_concat_segs from mtl_categories_v mcv where ccu.category_id=mcv.category_id) category_name,
gl.currency_code,
xxen_util.yes(decode(ccu.snapshot_saved_flag,1,'Y')) cost_details_saved,
xxen_util.yes(decode(ccu.update_resource_ovhd_flag,1,'Y')) updated_resources_overheads,
xxen_util.yes(decode(ccu.update_activity_flag,1,'Y')) updated_activity_costs,
csc.prior_cost_update_id,
csc.prior_cost_update_date,
xxen_util.user_name(csc.prior_created_by) prior_created_by,
&segment_columns
gcck.concatenated_segments adjustment_account
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
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
lag(csc.cost_update_id) over (partition by csc.organization_id,csc.inventory_item_id order by csc.standard_cost_revision_date,csc.cost_update_id) prior_cost_update_id,
lag(csc.standard_cost_revision_date) over (partition by csc.organization_id,csc.inventory_item_id order by csc.standard_cost_revision_date,csc.cost_update_id) prior_cost_update_date,
lag(csc.created_by) over (partition by csc.organization_id,csc.inventory_item_id order by csc.standard_cost_revision_date,csc.cost_update_id) prior_created_by,
lag(csc.standard_cost) over (partition by csc.organization_id,csc.inventory_item_id order by csc.standard_cost_revision_date,csc.cost_update_id) prior_standard_cost
from
mtl_parameters mp,
cst_standard_costs csc
where
3=3 and
6=6 and
mp.organization_id=csc.organization_id
) csc,
mtl_system_items_vl msiv,
mtl_item_status_vl misv,
cst_item_costs cic,
cst_cost_updates ccu,
cst_cost_types cct,
mtl_system_items_vl msiv_ccu,
gl_code_combinations_kfv gcck
where
1=1 and
2=2 and
3=3 and
4=4 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=csc.organization_id and
csc.organization_id=msiv.organization_id and
csc.inventory_item_id=msiv.inventory_item_id and
msiv.inventory_item_status_code=misv.inventory_item_status_code and
msiv.organization_id=cic.organization_id and
msiv.inventory_item_id=cic.inventory_item_id and
mp.primary_cost_method=cic.cost_type_id and
csc.cost_update_id=ccu.cost_update_id(+) and
nvl(ccu.cost_type_id,mp.primary_cost_method)=cct.cost_type_id and
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

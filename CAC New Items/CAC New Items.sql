/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC New Items
-- Description: Report to show items which have been recently created, including various item controls, item costs (per your Costing Method), item master accounts, last transaction and onhand stock, based on the item master creation date.
-- Parameters:
-- ===========
-- Creation Date From: starting item master creation date (required).
-- Creation Date To: ending item master creation date (required).
-- Include Uncosted Items: enter Yes to display items which are set to not be costed in your Costing Method Cost Type, defaulted as Yes (mandatory).
-- Category Set 1: any item category you wish, typically the Cost or Product Line category set (optional).
-- Category Set 2: any item category you wish, typically the Inventory category set (optional).S
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
-- -- | Program Name: xxxnewitemsrept.sql
-- -- |
-- -- |
-- -- | Description:
-- -- | Report to show zero item costs in the "costing method" cost type,
-- -- | the creation date and any onhand stock.
-- -- |
-- -- | version modified on modified by description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 14 jun 2017 Douglas Volz Initial coding based on the zero item cost
-- -- | report, xxxzeroitemcostreport.sql, version 1.3
-- -- | 1.1 20 Jan 2020 Douglas Volz Added Org Code and Operating Unit parameters.
-- -- | 1.2 07 Jul 2022 Douglas Volz Changed to multi-language views for the item
-- -- | master and inventory orgs. Added item master
-- -- | accounts and costs by cost element.
-- -- | 1.3 09 Jul 2023 Douglas Volz Remove tabs and restrict to only orgs you have
-- -- | access to, using the org access view.
-- -- | 1.4 08 Aug 2023 Douglas Volz Fix item status code to use translated values.
-- -- | 1.5 22 Nov 2023 Douglas Volz Add BOM/Routing/Sourcing Rule columns, item master
-- -- | created by and std lot size and costing created by,
-- -- | costing lot size and defaulted flag.
-- -- | 1.6 05 Dec 2023 Douglas Volz Added G/L and Operating Unit security restrictions.
-- -- | 1.7 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-new-items/
-- Library Link: https://www.enginatics.com/reports/cac-new-items/
-- Run Report: https://demo.enginatics.com/

select
x.ledger,
x.operating_unit,
x.org_code,
x.item_number,
x.item_description,
xxen_util.meaning(x.item_type,'ITEM_TYPE',3) item_type,
x.item_creation_date,
xxen_util.user_name(x.created_by) item_created_by,
x.item_status,
xxen_util.meaning(x.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
x.std_lot_size,
xxen_util.yes(case when exists (select null from bom_structures_b bsb where x.inventory_item_id=bsb.assembly_item_id and x.organization_id=bsb.organization_id and bsb.alternate_bom_designator is null) then 'Y' end) bom,
xxen_util.yes((select 'Y' from bom_operational_routings bor where x.inventory_item_id=bor.assembly_item_id and x.organization_id=bor.organization_id and bor.alternate_routing_designator is null)) routing,
xxen_util.yes(case when exists (select null from mrp_sr_assignments msa, mrp_assignment_sets mas, mrp_sr_receipt_org msro, mrp_sr_source_org msso where x.inventory_item_id=msa.inventory_item_id and x.organization_id=msa.organization_id and msa.assignment_set_id=mas.assignment_set_id and 4=4 and msa.sourcing_rule_id=msro.sourcing_rule_id and msro.sr_receipt_id=msso.sr_receipt_id and msso.source_organization_id is not null) then 'Y' end) sourcing_rule,
&category_columns
xxen_util.yes(x.costing_enabled_flag) allow_costs,
xxen_util.yes(decode(cic.inventory_asset_flag,1,'Y')) inventory_asset,
xxen_util.yes(decode(cic.defaulted_flag,1,'Y')) use_default_controls,
xxen_util.meaning(cic.based_on_rollup_flag,'CST_BONROLLUP_VAL',700) based_on_rollup,
cic.lot_size costing_lot_size,
cic.shrinkage_rate,
x.currency_code,
x.market_price,
x.list_price_per_unit target_or_po_list_price,
cic.material_cost,
cic.material_overhead_cost,
cic.resource_cost,
cic.outside_processing_cost,
cic.overhead_cost,
cic.item_cost,
mmt.transaction_id last_transaction_number,
mmt.transaction_date last_transaction_date,
(select mtt.transaction_type_name from mtl_transaction_types mtt where mmt.transaction_type_id=mtt.transaction_type_id) last_transaction_type,
x.primary_uom_code uom_code,
nvl((select sum(moqd.primary_transaction_quantity) from mtl_onhand_quantities_detail moqd where x.inventory_item_id=moqd.inventory_item_id and x.organization_id=moqd.organization_id),0) onhand_quantity,
&segment_columns
cic.creation_date cost_creation_date,
xxen_util.user_name(cic.created_by) cost_created_by
from
(
select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
mp.primary_cost_method,
gl.currency_code,
msiv.organization_id,
msiv.inventory_item_id,
msiv.concatenated_segments item_number,
msiv.description item_description,
msiv.item_type,
msiv.creation_date item_creation_date,
msiv.created_by,
misv.inventory_item_status_code_tl item_status,
msiv.planning_make_buy_code,
msiv.std_lot_size,
msiv.costing_enabled_flag,
msiv.market_price,
msiv.list_price_per_unit,
msiv.primary_uom_code,
msiv.cost_of_sales_account,
msiv.sales_account,
msiv.expense_account,
(select /*+ no_unnest*/ max(mmt.transaction_id) from mtl_material_transactions mmt where msiv.inventory_item_id=mmt.inventory_item_id and msiv.organization_id=mmt.organization_id) last_transaction_id
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
mtl_system_items_vl msiv,
mtl_item_status_vl misv
where
1=1 and
2=2 and
3=3 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=msiv.organization_id and
msiv.inventory_item_status_code=misv.inventory_item_status_code
) x,
cst_item_costs cic,
mtl_material_transactions mmt,
gl_code_combinations gcc1,
gl_code_combinations gcc2,
gl_code_combinations gcc3
where
x.organization_id=cic.organization_id(+) and
x.inventory_item_id=cic.inventory_item_id(+) and
x.primary_cost_method=cic.cost_type_id(+) and
x.last_transaction_id=mmt.transaction_id(+) and
x.cost_of_sales_account=gcc1.code_combination_id(+) and
x.sales_account=gcc2.code_combination_id(+) and
x.expense_account=gcc3.code_combination_id(+)
order by
x.ledger,
x.operating_unit,
x.org_code,
x.item_number,
x.item_description

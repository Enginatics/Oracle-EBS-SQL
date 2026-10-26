/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Calculate ICP PII Item Costs by Where Used
-- Description: Report to identify the intercompany "To Org" profit in inventory (also known as PII or ICP) for each inventory organization and item. Gets the PII item costs by joining the sourcing rule information from the first "hop" from the sourcing rule information to the second "hop". In addition, if an item has a source org in the item master, but the sourcing rule does not exist, this item relationship will still be reported. This report also assumes that the first hop may have profit in inventory from another source organization and will not include any profit in inventory from the source org for the "To Org" profit in inventory calculations. Likewise for the "To Org", any this level material overheads, resources, outside processing or overhead costs are ignored for the profit in inventory calculations. In addition, inactive items and disabled organizations are ignored. And while calculating the profit in inventory item costs, this report also shows where these components are being used on the To Org bills of material.
-- Parameters:
-- Assignment Set: the set of sourcing rules to use with calculating the PII item costs (mandatory).
-- From (Source) Organization: the source organization where the goods come from (optional).
-- To Organization: the organization where the goods are being shipped to (optional).
-- Cost Type: the cost type to use for the item costs, such as Frozen or Pending (mandatory).
-- PII Cost Type: the profit in inventory cost type you wish to report (mandatory).
-- PII Sub-Element: the sub-element or resource for profit in inventory, such as PII or ICP (mandatory).
-- Currency Conversion Date: the exchange rate conversion date that was used to set the standard costs (mandatory).
-- Currency Conversion Type: the exchange rate conversion type that was used to set the standard costs (mandatory).
-- Period Name: the accounting period you wish to report for; this value does not change any PII or item costs, it is merely a reference value for reporting purposes (mandatory).
-- Include Transfers to Same OU: allows you to include or exclude transfers within the same Operating Unit (OU). Defaulted to not include these internal transfers.
-- Include Expense Items: enter Yes or No to indicate if you want to include expense items on the bills of material (mandatory). Defaulted to No.
-- Include Uncosted Items: enter Yes or No to indicate if you want to include uncosted items on the bills of material (mandatory). Defaulted to No.
-- Category Set 1: any item category you wish, typically the Cost or Product Line category set (optional).
-- Category Set 2: any item category you wish, typically the Inventory category set (optional).
-- Component Number: enter the specific component(s) you wish to report (optional).
-- Assembly Number: enter the specific assembly or assemblies you wish to report (optional).
-- Include Unimplemented ECOs: enter Yes or No to indicate if you want to include engineering changes which have not been implemented (mandatory).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- Hidden Parameters:
-- Numeric Sign for PII: to set the sign of the profit in inventory amounts. This parameter determines if PII is normally entered as a positive or negative amount (mandatory).
-- -- | Copyright 2018 - 2024 Douglas Volz Consulting, Inc., all rights reserved.
-- -- | Permission to use this code is granted provided the original author is acknowledged. No warranties, express or otherwise is included in this permission.
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.6 29 Jan 2024 Doug Volz Remove tabs, add org access controls, fix for G/L Daily Rates,
-- -- | Make three parameters non-hidden: Include Transfers to Same OU, Include Expense Items and Include Uncosted Items.
-- Excel Example Output: https://www.enginatics.com/example/cac-calculate-icp-pii-item-costs-by-where-used/
-- Library Link: https://www.enginatics.com/reports/cac-calculate-icp-pii-item-costs-by-where-used/
-- Run Report: https://demo.enginatics.com/

with c as (
select /*+ inline */
cic.organization_id,
cic.inventory_item_id,
cic.item_cost,
cic.item_cost-cic.tl_material_overhead-cic.tl_resource-cic.tl_outside_processing-cic.tl_overhead net_cost,
nvl((select sum(cicd.item_cost) from cst_item_cost_details cicd, cst_cost_types cct, bom_resources br where cic.inventory_item_id=cicd.inventory_item_id and cic.organization_id=cicd.organization_id and cicd.cost_type_id=cct.cost_type_id and cicd.resource_id=br.resource_id and 9=9),0) pii_cost
from
mtl_parameters mp,
cst_item_costs cic
where
mp.organization_id=cic.organization_id and
(
cic.cost_type_id in (select cct.cost_type_id from cst_cost_types cct where 10=10) or
cic.cost_type_id=mp.primary_cost_method and not exists (select null from cst_item_costs cic2, cst_cost_types cct where cic.organization_id=cic2.organization_id and cic.inventory_item_id=cic2.inventory_item_id and cic2.cost_type_id=cct.cost_type_id and 10=10)
)
)
select
x.period_name,
x.source_ledger,
x.to_ledger,
x.source_operating_unit,
x.to_operating_unit,
x.src_org,
x.to_org,
x.assignment_set,
x.sourcing_rule,
x.assembly,
x.assembly_description,
x.assembly_item_type,
x.assembly_status_code,
x.assembly_make_buy_code,
x.uom_code,
x.bom_type,
x.date_implemented,
x.item_revision,
&category_columns
x.item_seq,
x.op_seq,
x.component,
x.component_description,
x.source_item_type,
x.source_status_code,
x.source_make_buy_code,
x.source_uom,
x.to_org_item_type,
x.to_org_status_code,
x.to_org_make_buy_code,
x.to_org_uom,
x.quantity_per_assembly,
x.effective_from,
x.effective_to,
x.planning_percent,
x.yield component_yield,
x.include_in_cost_rollup,
x.wip_supply_type,
x.source_component_onhand_qty,
x.src_currency_code,
x.src_component_item_cost,
x.source_component_onhand_qty*x.src_component_item_cost src_component_onhand_value,
x.source_item_cost,
:p_conversion_date currency_conversion_date,
x.conversion_rate currency_conversion_rate,
x.to_org_currency_code,
round(x.conversion_rate*x.source_item_cost,5) converted_source_item_cost,
x.to_org_net_item_cost,
x.to_org_net_item_cost-round(x.conversion_rate*x.source_item_cost,5) calculated_to_org_pii,
round((x.to_org_net_item_cost-round(x.conversion_rate*x.source_item_cost,5))/decode(round(x.conversion_rate*x.source_item_cost,5),0,1,round(x.conversion_rate*x.source_item_cost,5))*100,1) source_pii_percent,
round((x.to_org_net_item_cost-round(x.conversion_rate*x.source_item_cost,5))/decode(x.to_org_item_cost,0,1,x.to_org_item_cost)*100,1) to_org_pii_percent,
x.cost_type_pii_item_cost,
x.to_org_net_item_cost-round(x.conversion_rate*x.source_item_cost,5)-x.cost_type_pii_item_cost pii_cost_difference,
x.to_org_assembly_onhand_qty,
x.to_org_component_onhand_qty,
x.to_org_item_cost to_org_total_item_cost,
x.to_org_component_onhand_qty*x.src_component_item_cost to_org_component_onhand_value
from
(
select
:p_period_name period_name,
nvl(gl_src.short_name,gl_src.name) source_ledger,
nvl(gl_to.short_name,gl_to.name) to_ledger,
haouv_src.name source_operating_unit,
haouv_to.name to_operating_unit,
s.src_org_code src_org,
s.to_org_code to_org,
s.assignment_set,
s.sourcing_rule,
msiv.concatenated_segments assembly,
msiv.description assembly_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) assembly_item_type,
misv.inventory_item_status_code_tl assembly_status_code,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) assembly_make_buy_code,
msiv.primary_uom_code uom_code,
xxen_util.meaning(1,'BOM_TRANSITION_TYPE',700) bom_type,
w.implementation_date date_implemented,
(select max(mirb.revision) from mtl_item_revisions_b mirb where msiv.inventory_item_id=mirb.inventory_item_id and msiv.organization_id=mirb.organization_id and mirb.effectivity_date<=sysdate) item_revision,
msiv2.inventory_item_id component_item_id,
msiv2.organization_id,
w.item_num item_seq,
w.operation_seq_num op_seq,
msiv2.concatenated_segments component,
msiv2.description component_description,
xxen_util.meaning(s.src_item_type,'ITEM_TYPE',3) source_item_type,
(select misv3.inventory_item_status_code_tl from mtl_item_status_vl misv3 where s.src_item_status_code=misv3.inventory_item_status_code) source_status_code,
xxen_util.meaning(s.src_mb_code,'MTL_PLANNING_MAKE_BUY',700) source_make_buy_code,
s.src_uom_code source_uom,
xxen_util.meaning(msiv2.item_type,'ITEM_TYPE',3) to_org_item_type,
misv2.inventory_item_status_code_tl to_org_status_code,
xxen_util.meaning(msiv2.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) to_org_make_buy_code,
msiv2.primary_uom_code to_org_uom,
w.component_quantity quantity_per_assembly,
w.effectivity_date effective_from,
w.disable_date effective_to,
nvl(w.planning_factor,0) planning_percent,
w.component_yield_factor yield,
xxen_util.yes(decode(w.include_in_cost_rollup,1,'Y')) include_in_cost_rollup,
xxen_util.meaning(w.wip_supply_type,'WIP_SUPPLY',700) wip_supply_type,
nvl((select sum(moqd.primary_transaction_quantity) from mtl_onhand_quantities_detail moqd where s.src_item_id=moqd.inventory_item_id and s.src_org_id=moqd.organization_id),0) source_component_onhand_qty,
gl_src.currency_code src_currency_code,
gl_to.currency_code to_org_currency_code,
decode(gl_src.currency_code,gl_to.currency_code,1,(select gdr.conversion_rate from gl_daily_rates gdr, gl_daily_conversion_types gdct where gl_src.currency_code=gdr.from_currency and gl_to.currency_code=gdr.to_currency and gdr.conversion_date=:p_conversion_date and gdr.conversion_type=gdct.conversion_type and gdct.user_conversion_type=:p_user_conversion_type)) conversion_rate,
nvl(c_src.item_cost,0) src_component_item_cost,
round(nvl(c_src.item_cost,0)-sign(:p_sign_pii)*nvl(c_src.pii_cost,0),5) source_item_cost,
round(nvl(c_to.net_cost,0),5) to_org_net_item_cost,
c_to.pii_cost cost_type_pii_item_cost,
nvl((select sum(moqd.primary_transaction_quantity) from mtl_onhand_quantities_detail moqd where msiv.inventory_item_id=moqd.inventory_item_id and msiv.organization_id=moqd.organization_id),0) to_org_assembly_onhand_qty,
nvl((select sum(moqd.primary_transaction_quantity) from mtl_onhand_quantities_detail moqd where msiv2.inventory_item_id=moqd.inventory_item_id and msiv2.organization_id=moqd.organization_id),0) to_org_component_onhand_qty,
nvl(c_to.item_cost,0) to_org_item_cost
from
(
select
mp_to.organization_code to_org_code,
mp_src.organization_code src_org_code,
mp_to.organization_id to_org_id,
mp_src.organization_id src_org_id,
mas.assignment_set_name assignment_set,
msr.sourcing_rule_name sourcing_rule,
msiv2.inventory_item_id src_item_id,
msiv2.primary_uom_code src_uom_code,
msiv2.inventory_item_status_code src_item_status_code,
msiv2.item_type src_item_type,
msiv2.planning_make_buy_code src_mb_code
from
mrp_assignment_sets mas,
mrp_sr_assignments msa,
mrp_sourcing_rules msr,
mrp_sr_receipt_org msro,
mrp_sr_source_org msso,
mtl_parameters mp_to,
mtl_parameters mp_src,
mtl_system_items_vl msiv2
where
2=2 and
3=3 and
4=4 and
mas.assignment_set_id=msa.assignment_set_id and
msa.sourcing_rule_id=msr.sourcing_rule_id and
msa.sourcing_rule_id=msro.sourcing_rule_id and
msro.sr_receipt_id=msso.sr_receipt_id and
msso.source_organization_id is not null and
msa.organization_id=mp_to.organization_id and
mp_to.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp_to.organization_id<>mp_to.master_organization_id and
msso.source_organization_id=mp_src.organization_id and
mp_src.organization_id<>mp_src.master_organization_id and
msso.source_organization_id=msiv2.organization_id and
msa.inventory_item_id=msiv2.inventory_item_id and
msiv2.inventory_item_status_code<>'Inactive'
union all
select
mp_to.organization_code,
mp_src.organization_code,
mp_to.organization_id,
msiv2.source_organization_id,
null,
null,
msiv2.inventory_item_id,
msiv2.primary_uom_code,
msiv2.inventory_item_status_code,
msiv2.item_type,
msiv2.planning_make_buy_code
from
mtl_parameters mp_to,
mtl_system_items_vl msiv2,
mtl_parameters mp_src
where
3=3 and
4=4 and
mp_to.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp_to.organization_id=msiv2.organization_id and
msiv2.organization_id<>mp_to.master_organization_id and
msiv2.inventory_item_status_code<>'Inactive' and
msiv2.source_organization_id=mp_src.organization_id and
msiv2.source_organization_id<>mp_src.master_organization_id and
not exists (select null from mrp_assignment_sets mas, mrp_sr_assignments msa, mrp_sr_receipt_org msro, mrp_sr_source_org msso where msiv2.inventory_item_id=msa.inventory_item_id and msiv2.organization_id=msa.organization_id and msa.assignment_set_id=mas.assignment_set_id and 2=2 and msa.sourcing_rule_id=msro.sourcing_rule_id and msro.sr_receipt_id=msso.sr_receipt_id and msso.source_organization_id=mp_src.organization_id)
) s,
(
select
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
mtl_parameters mp_to,
bom_structures_b bsb,
bom_components_b bcb
where
4=4 and
6=6 and
mp_to.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp_to.organization_id=bsb.organization_id and
bsb.assembly_type=1 and
bsb.alternate_bom_designator is null and
bsb.common_assembly_item_id is null and
bsb.bill_sequence_id=bcb.bill_sequence_id and
bcb.effectivity_date<=sysdate and
nvl(bcb.disable_date,sysdate+1)>sysdate
group by
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
) w,
mtl_system_items_vl msiv,
mtl_item_status_vl misv,
mtl_system_items_vl msiv2,
mtl_item_status_vl misv2,
c c_to,
c c_src,
hr_organization_information hoi_to,
hr_all_organization_units haou_to,
hr_all_organization_units_vl haouv_to,
gl_ledgers gl_to,
hr_organization_information hoi_src,
hr_all_organization_units haou_src,
hr_all_organization_units_vl haouv_src,
gl_ledgers gl_src
where
1=1 and
5=5 and
7=7 and
8=8 and
13=13 and
s.to_org_id=w.organization_id and
s.src_item_id=w.component_item_id and
w.organization_id=msiv.organization_id and
w.assembly_item_id=msiv.inventory_item_id and
msiv.inventory_item_status_code<>'Inactive' and
msiv.inventory_item_status_code=misv.inventory_item_status_code and
w.organization_id=msiv2.organization_id and
w.component_item_id=msiv2.inventory_item_id and
msiv2.inventory_item_status_code<>'Inactive' and
msiv2.inventory_item_status_code=misv2.inventory_item_status_code and
s.to_org_id=c_to.organization_id and
s.src_item_id=c_to.inventory_item_id and
s.src_org_id=c_src.organization_id and
s.src_item_id=c_src.inventory_item_id and
s.to_org_id=hoi_to.organization_id and
hoi_to.org_information_context='Accounting Information' and
hoi_to.organization_id=haou_to.organization_id and
sysdate<nvl(haou_to.date_to,sysdate+1) and
to_number(hoi_to.org_information3)=haouv_to.organization_id and
to_number(hoi_to.org_information1)=gl_to.ledger_id and
s.src_org_id=hoi_src.organization_id and
hoi_src.org_information_context='Accounting Information' and
hoi_src.organization_id=haou_src.organization_id and
sysdate<nvl(haou_src.date_to,sysdate+1) and
to_number(hoi_src.org_information3)=haouv_src.organization_id and
to_number(hoi_src.org_information1)=gl_src.ledger_id
) x
order by
x.period_name,
x.source_ledger,
x.to_ledger,
x.source_operating_unit,
x.to_operating_unit,
x.to_org,
x.src_org,
x.assembly,
x.component,
x.op_seq

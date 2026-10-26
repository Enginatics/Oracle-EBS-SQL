/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Item Cost & Routing
-- Description: Report to show detailed item costs for buy and make items for one or any two cost types. If you enter multiple cost types you will get a row-by-row comparison in detail.
-- Note: to find all the items with a specific Basis Type, such as Lot or Ttl value (Total value), use the Basis Type parameter.
-- Parameters:
-- ===========
-- Cost Type: enter the cost type(s) you wish to report (mandatory).
-- Category Set 1: the first item category set to report, typically the Cost or Product Line Category Set (optional).
-- Category Set 2: the second item category set to report, typically the Inventory Category Set (optional).
-- Make or Buy: enter Buy, Make or leave blank to get all items (optional).
-- Based on Rollup: enter Yes to get the rolled up items, No to get the non-rolled-up items (optional).
-- Basis Type: enter the basis type you wish to report, such as Item, Lot, Res Units, Res Value, or Ttl Value (optional).
-- Item Status to Exclude: enter the item number status you want to exclude. Defaulted to 'Inactive' (optional).
-- Item Number: enter the item numbers you wish to report (optional).
-- Organization Code: enter the specific inventory organization(s) you wish to report (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2010 - 2023 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxitemcostsroutingrept.sql
-- -- |
-- -- | Description:
-- -- | Report to show detailed items costs for buy and make items for any two cost types.
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 06 Oct 2009 Douglas Volz Initial Coding
-- -- | 1.1 16 Mar 2010 Douglas Volz Updated with Make/Buy flags
-- -- | 1.2 26 Aug 2010 Douglas Volz Added two cost types and effectivity date
-- -- | parameters.
-- -- | 1.3 12 Oct 2010 Douglas Volz Added parameters for business objects
-- -- | 1.4 26 Oct 2010 Douglas Volz Added parameter for specific ItemNumber
-- -- | 1.5 01 Feb 2017 Douglas Volz Added Resource Activity and Cost Category
-- -- | 1.6 22 May 2017 Douglas Volz Added inventory item category
-- -- | 1.7 27 Jan 2020 Douglas Volz Added OperatingUnit and OrgCode parameters
-- -- | 1.8 26 Apr 2020 Douglas Volz Changed to multi-language views for the item
-- -- | master, inventory orgs and operating units.
-- -- | 1.9 21 Oct 2020 Douglas Volz Added Category1, Category2, Cost Creation
-- -- | Date, Last Cost Update Date, screen out
-- -- | the item master orgs.
-- -- | 1.10 17 Mar 2021 Douglas Volz Add parameter for Inactive Items.
-- -- | 1.11 26 Oct 2023 Douglas Volz Added item master std lot size and defaulted
-- -- | columns, removed tabs, added Basis Type, Based on Rollup
-- -- | and Make/Buy parameters and org access controls.
-- -- | Removed Cost Type2, not needed with Multiple Value
-- -- | functionality.
-- -- | 1.12 07 Dec 2023 Douglas Volz Added G/L and Operating Unit security restrictions.
-- -- | 1.13 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-item-cost-routing/
-- Library Link: https://www.enginatics.com/reports/cac-item-cost-routing/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
msiv.concatenated_segments item_number,
msiv.description item_description,
msiv.primary_uom_code uom_code,
&category_columns
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
msiv.inventory_item_status_code item_status,
xxen_util.yes(decode(cic.defaulted_flag,1,'Y')) use_default_controls,
xxen_util.meaning(cic.based_on_rollup_flag,'CST_BONROLLUP_VAL',700) based_on_rollup,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
msiv.std_lot_size,
bd.department_code department,
xxen_util.meaning(x.level_type,'CST_LEVEL',700) level_type,
x.operation_seq_num operation_seq_number,
x.resource_seq_num resource_seq_number,
mp_src.organization_code source_org,
x.allocation_percent,
cce.cost_element,
br.resource_code sub_element,
br.unit_of_measure sub_element_uom,
(select ca.activity from cst_activities ca where br.default_activity_id=ca.activity_id) activity,
cct.cost_type,
xxen_util.meaning(x.rollup_source_type,'CST_SOURCE_TYPE',700) cost_source,
xxen_util.meaning(x.basis_type,'CST_BASIS_SHORT',700) basis_type,
cic.lot_size costing_lot_size,
cic.shrinkage_rate,
x.basis_factor,
x.net_yield_or_shrinkage_factor shrinkage_factor,
x.resource_rate,
x.usage_rate_or_amount rate_or_amount,
gl.currency_code,
x.item_cost detailed_item_cost,
decode(x.level_type,null,null,nvl(cic.item_cost,0)) total_item_cost,
cic.creation_date cost_creation_date,
cic.last_update_date cost_last_update_date,
msiv.creation_date item_creation_date,
msiv.last_update_date item_last_update_date
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
cst_item_costs cic,
cst_cost_types cct,
mtl_system_items_vl msiv,
(
select
cicd.organization_id,
cicd.inventory_item_id,
cicd.cost_type_id,
cicd.department_id,
cicd.level_type,
cicd.operation_seq_num,
cicd.resource_seq_num,
cicd.source_organization_id,
cicd.allocation_percent,
cicd.cost_element_id,
cicd.resource_id,
cicd.rollup_source_type,
cicd.basis_type,
cicd.basis_factor,
cicd.net_yield_or_shrinkage_factor,
cicd.resource_rate,
cicd.usage_rate_or_amount,
cicd.item_cost
from
cst_item_cost_details cicd
union all
select
bor.organization_id,
bor.assembly_item_id,
cic.cost_type_id,
bos.department_id,
null,
bos.operation_seq_num,
bores.resource_seq_num,
null,
null,
br.cost_element_id,
bores.resource_id,
null,
bores.basis_type,
null,
null,
null,
bores.usage_rate_or_amount,
null
from
bom_operational_routings bor,
cst_item_costs cic,
bom_operation_sequences bos,
bom_operation_resources bores,
bom_resources br
where
bor.alternate_routing_designator is null and
bor.routing_type=1 and
bor.common_assembly_item_id is null and
bor.organization_id=cic.organization_id and
bor.assembly_item_id=cic.inventory_item_id and
bor.routing_sequence_id=bos.routing_sequence_id and
bos.operation_sequence_id=bores.operation_sequence_id and
bores.resource_id=br.resource_id and
br.allow_costs_flag=2
) x,
cst_cost_elements cce,
bom_resources br,
bom_departments bd,
mtl_parameters mp_src
where
1=1 and
2=2 and
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
cic.organization_id=msiv.organization_id and
cic.inventory_item_id=msiv.inventory_item_id and
cic.organization_id=x.organization_id and
cic.inventory_item_id=x.inventory_item_id and
cic.cost_type_id=x.cost_type_id and
x.cost_element_id=cce.cost_element_id and
x.resource_id=br.resource_id(+) and
x.department_id=bd.department_id(+) and
x.source_organization_id=mp_src.organization_id(+)
order by
ledger,
operating_unit,
org_code,
item_number,
department,
level_type,
cce.cost_element,
operation_seq_number,
resource_seq_number,
sub_element,
cct.cost_type

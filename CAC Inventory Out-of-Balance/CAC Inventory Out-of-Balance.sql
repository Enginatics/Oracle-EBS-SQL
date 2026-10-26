/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inventory Out-of-Balance
-- Description: Report to show any differences in the period end snapshot that is created when you close the inventory periods. This represents any differences between the cumulative inventory accounting entries and the onhand valuation of the subinventories and intransit stock locations.
-- Parameters:
-- ===========
-- Period Name (Closed): the closed inventory accounting period you wish to report (mandatory).
-- Minimum Value Difference: the minimum difference to report, defaulted to a value of one. To see all differences enter a value of zero (mandatory).
-- Category Set 1: any item category you wish, typically the Cost or Product Line category set (optional).
-- Category Set 2: any item category you wish, typically the Inventory category set (optional).
-- Item Number: enter the specific item number(s) you wish to report (optional).
-- Organization Code: enter the specific inventory organization(s) you wish to report (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- // +=============================================================================+
-- -- | Copyright 2006-2024 Douglas Volz Consulting, Inc.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxinvsnapshotdiffrept.sql
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 02 APR 2006 Douglas Volz Initial Coding
-- -- | 1.14 19 Nov 2015 Douglas Volz Commented out the Cost Group information. Not Consistent.
-- -- | 1.15 17 Jul 2018 Douglas Volz Now report G/L short name.
-- -- | 1.16 06 Jan 2020 Douglas Volz Added Org Code and Operating Unit parameters.
-- -- | 1.17 30 Apr 2020 Douglas Volz Changed to multi-language views for the item
-- -- | master, inventory orgs and operating units.
-- -- | 1.18 18 May 2020 Douglas Volz Added language for item status.
-- -- | 1.19 14 Jun 2024 Douglas Volz Remove tabs, reinstall parameters and org access controls.
-- -- | 1.20 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-inventory-out-of-balance/
-- Library Link: https://www.enginatics.com/reports/cac-inventory-out-of-balance/
-- Run Report: https://demo.enginatics.com/

select
x.ledger,
x.operating_unit,
x.org_code,
x.period_name,
&segment_columns
x.item_number,
x.item_description,
x.item_type,
x.item_status,
&category_columns
x.subinventory_or_intransit,
x.uom_code,
round(sum(x.rollback_quantity),3) quantity,
round(sum(x.rollback_value),2) onhand_value,
round(sum(x.accounted_value),2) accounted_value,
round(sum(x.value_discrepancy),2) difference
from
(
select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
oap.period_name,
msiv.concatenated_segments item_number,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
misv.inventory_item_status_code_tl item_status,
nvl(cpcs.subinventory_code,xxen_util.meaning(14,'CST_ACCOUNTING_LINE_TYPE',700)) subinventory_or_intransit,
msiv.primary_uom_code uom_code,
nvl(cpcs.rollback_quantity,0) rollback_quantity,
nvl(cpcs.rollback_value,0) rollback_value,
nvl(cpcs.accounted_value,0) accounted_value,
nvl(cpcs.onhand_value_discrepancy,0)+nvl(cpcs.intransit_value_discrepancy,0) value_discrepancy,
case
when cpcs.subinventory_code is null then mp.intransit_inv_account
when mp.cost_group_accounting=1 then (select ccga.material_account from cst_cost_group_accounts ccga where nvl(msi.default_cost_group_id,mp.default_cost_group_id)=ccga.cost_group_id and mp.organization_id=ccga.organization_id)
when mp.primary_cost_method=1 then msi.material_account
else mp.material_account
end account_id,
msiv.inventory_item_id,
msiv.organization_id
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
org_acct_periods oap,
cst_period_close_summary cpcs,
mtl_secondary_inventories msi,
mtl_system_items_vl msiv,
mtl_item_status_vl misv
where
1=1 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haouv.organization_id and
nvl(haouv.date_to,sysdate+1)>sysdate and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=oap.organization_id and
oap.acct_period_id=cpcs.acct_period_id and
oap.organization_id=cpcs.organization_id and
cpcs.organization_id=msi.organization_id(+) and
cpcs.subinventory_code=msi.secondary_inventory_name(+) and
cpcs.organization_id=msiv.organization_id and
cpcs.inventory_item_id=msiv.inventory_item_id and
msiv.inventory_item_status_code=misv.inventory_item_status_code
) x,
gl_code_combinations gcc
where
x.account_id=gcc.code_combination_id(+)
group by
x.ledger,
x.operating_unit,
x.org_code,
x.period_name,
&segment_columns2
x.item_number,
x.item_description,
x.item_type,
x.item_status,
x.subinventory_or_intransit,
x.uom_code,
x.inventory_item_id,
x.organization_id
having
abs(sum(x.value_discrepancy))>=:p_min_value_diff
order by
x.ledger,
x.operating_unit,
x.org_code,
x.period_name,
&segment_columns2
x.item_number,
x.subinventory_or_intransit

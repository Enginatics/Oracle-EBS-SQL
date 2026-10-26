/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Cost Type Costs Not in Period Close Inventory Snapshot
-- Description: Report comparing the month-end items, balances and costs against any entered Cost Type, showing which item numbers in your month-end inventory which are not in your Cost Type. You automatically save off your month-end quantities and values when you close the inventory accounting period.
-- Parameters:
-- ==========
-- Period Name (Closed): the closed inventory accounting period you wish to report (mandatory).
-- Cost Type: enter a Cost Type to compare against the stored month-end items, quantities and values (mandatory).
-- Item Number: enter the specific item number(s) you wish to report (optional).
-- Organization Code: any inventory organization, defaults to your session's inventory organization (optional).
-- Operating Unit: specific operating unit (optional)
-- Ledger: specific ledger (optional)
-- / +=============================================================================+
-- -- | Copyright 2024 - 2025 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- | ===================================================================
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 15 Jan 2024 Douglas Volz Initial Coding
-- -- | 1.1 04 Mar 2025 Douglas Volz Removed tabs, add ledger and operating unit
-- -- | columns and security access profiles.
-- -- | 1.2 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-cost-type-costs-not-in-period-close-inventory-snapshot/
-- Library Link: https://www.enginatics.com/reports/cac-cost-type-costs-not-in-period-close-inventory-snapshot/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
x.period_name,
msiv.concatenated_segments item_number,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
misv.inventory_item_status_code_tl item_status,
round(x.rollback_value/decode(x.rollback_quantity,0,1,x.rollback_quantity),5) item_cost,
nvl(x.subinventory_code,xxen_util.meaning(3,'MSC_CALENDAR_TYPE',700)) subinventory_or_intransit,
nvl(msi.description,xxen_util.meaning(3,'MSC_CALENDAR_TYPE',700)) description,
xxen_util.yes(decode(msi.asset_inventory,2,null,'Y')) asset,
msiv.primary_uom_code uom_code,
round(x.rollback_quantity,3) onhand_quantity,
round(x.rollback_value,2) onhand_value
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
(
select
oap.organization_id,
oap.period_name,
cpcs.inventory_item_id,
cpcs.subinventory_code,
sum(cpcs.rollback_quantity) rollback_quantity,
sum(cpcs.rollback_value) rollback_value
from
org_acct_periods oap,
cst_period_close_summary cpcs
where
4=4 and
oap.acct_period_id=cpcs.acct_period_id and
oap.organization_id=cpcs.organization_id and
cpcs.rollback_quantity<>0
group by
oap.organization_id,
oap.period_name,
cpcs.inventory_item_id,
cpcs.subinventory_code
) x,
mtl_system_items_vl msiv,
mtl_item_status_vl misv,
mtl_secondary_inventories msi
where
1=1 and
2=2 and
5=5 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=x.organization_id and
x.organization_id=msiv.organization_id and
x.inventory_item_id=msiv.inventory_item_id and
msiv.inventory_asset_flag='Y' and
msiv.inventory_item_status_code=misv.inventory_item_status_code and
x.organization_id=msi.organization_id(+) and
x.subinventory_code=msi.secondary_inventory_name(+) and
not exists
(
select
null
from
cst_item_costs cic,
cst_cost_types cct
where
msiv.organization_id=cic.organization_id and
msiv.inventory_item_id=cic.inventory_item_id and
cic.cost_type_id=cct.cost_type_id and
3=3
)
order by
ledger,
operating_unit,
org_code,
x.period_name,
item_number,
subinventory_or_intransit

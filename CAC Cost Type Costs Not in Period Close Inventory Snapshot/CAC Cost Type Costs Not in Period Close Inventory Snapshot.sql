/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Cost Type Costs Not in Period Close Inventory Snapshot
-- Description: Report comparing the month-end items, balances and costs against any entered Cost Type, showing which item numbers in your month-end inventory which are not in your Cost Type.  You automatically save off your month-end quantities and values when you close the inventory accounting period.

Parameters:
==========
Period Name (Closed):  the closed inventory accounting period you wish to report (mandatory).
Cost Type:  enter a Cost Type to compare against the stored month-end items, quantities and values (mandatory).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  any inventory organization, defaults to your session's inventory organization (optional).
Operating Unit:  specific operating unit (optional)
Ledger:  specific ledger (optional)

/* +=============================================================================+
-- | Copyright 2024 - 2025 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- | ===================================================================
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     15 Jan 2024 Douglas Volz Initial Coding
-- | 1.1     04 Mar 2025 Douglas Volz Removed tabs, add ledger and operating unit
-- |                                  columns and security access profiles.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-cost-type-costs-not-in-period-close-inventory-snapshot/
-- Library Link: https://www.enginatics.com/reports/cac-cost-type-costs-not-in-period-close-inventory-snapshot/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name) Ledger,
        haou2.name Operating_Unit,
        mp.organization_code Org_Code,
        onhand.period_name Period_Name,
        onhand.concatenated_segments Item_Number,
        onhand.description Item_Description,
        fcl.meaning Item_Type,
        misv.inventory_item_status_code_tl Item_Status,
        decode(onhand.subinventory_code,
                        null, round(nvl(onhand.rollback_intransit_value,0) /
                                decode(nvl(onhand.rollback_quantity,0), 0, 1,
                                nvl(onhand.rollback_quantity,0)),5),
                        round((nvl(onhand.rollback_value,0)) /
                                decode(nvl(onhand.rollback_quantity,0), 0, 1,
                                nvl(onhand.rollback_quantity,0)),5)
              ) Item_Cost,
        nvl(onhand.subinventory_code, ml1.meaning) Subinventory_or_Intransit,
        nvl(regexp_replace(msub.description,'[^[:alnum:]'' '']', null), ml1.meaning) Description,
        ml2.meaning Asset,
        muomv.uom_code UOM_Code,
        round(nvl(onhand.rollback_quantity,0),3) Onhand_Quantity,
        decode(onhand.subinventory_code,
                null, round(nvl(onhand.rollback_intransit_value,0),2),
                round(nvl(onhand.rollback_value,0),2)
              ) Onhand_Value
from    mtl_parameters mp,
        mtl_units_of_measure_vl muomv,
        mtl_item_status_vl misv,
        fnd_common_lookups fcl, -- Item Type
        mfg_lookups ml1, -- Intransit
        mfg_lookups ml2, -- Inventory Asset
        mtl_secondary_inventories msub,
        hr_organization_information hoi,
        hr_all_organization_units_vl haou,  -- inv_organization_id
        hr_all_organization_units_vl haou2, -- operating unit
        gl_ledgers gl,
        -- Inner query for onhand quantities and values
        (-- For non-category accounting
         select mp.organization_id,
                msiv.inventory_item_id,
                msiv.concatenated_segments,
                regexp_replace(msiv.description,'[^[:alnum:]'' '']', null) description,
                msiv.primary_uom_code,
                msiv.inventory_item_status_code,
                msiv.item_type,
                msiv.inventory_asset_flag,
                oap.period_name,
                cpcs.acct_period_id,
                nvl(cpcs.subinventory_code, 'Intransit') subinventory_code,
                sum(cpcs.rollback_quantity) rollback_quantity,
                sum(cpcs.rollback_value) rollback_value,
                sum(cpcs.rollback_intransit_value) rollback_intransit_value                
         from   mtl_system_items_vl msiv,
                cst_period_close_summary cpcs,
                org_acct_periods oap,
                mtl_parameters mp
         where  mp.organization_id              = msiv.organization_id
         and    oap.acct_period_id              = cpcs.acct_period_id
         and    oap.organization_id             = cpcs.organization_id
         and    oap.organization_id             = mp.organization_id
         and    msiv.organization_id            = cpcs.organization_id
         and    msiv.inventory_item_id          = cpcs.inventory_item_id
         -- Don't get zero quantities
         and    nvl(cpcs.rollback_quantity,0)  <> 0
         -- Don't report expense items
         and    msiv.inventory_asset_flag       = 'Y'
         and    4=4                             -- p_period_name
         and    2=2                             -- p_org_code
         -- Need to group by due to possibility for having multiple cost groups by subinventory
         group by
                mp.organization_id,
                msiv.inventory_item_id,
                msiv.concatenated_segments,
                regexp_replace(msiv.description,'[^[:alnum:]'' '']', null),
                msiv.primary_uom_code,
                msiv.inventory_item_status_code,
                msiv.item_type,
                msiv.inventory_asset_flag,
                oap.period_name,
                cpcs.acct_period_id,
                cpcs.subinventory_code
        ) onhand
-- ========================================================================
-- Subinventory, mtl parameter, item master and period close snapshot joins
-- ========================================================================
where   mp.organization_id              = onhand.organization_id
and     2=2                             -- p_org_code
and     muomv.uom_code                  = onhand.primary_uom_code
and     misv.inventory_item_status_code = onhand.inventory_item_status_code
and     onhand.subinventory_code        = msub.secondary_inventory_name (+)
and     onhand.organization_id          = msub.organization_id (+)
-- ===========================================
-- Lookup Codes
-- ===========================================
and     fcl.lookup_code (+)             = onhand.item_type
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
and     ml1.lookup_code                 = 3 -- Intransit
and     ml1.lookup_type                 = 'MSC_CALENDAR_TYPE'
and     ml2.lookup_code                 = nvl(msub.asset_inventory,1)
and     ml2.lookup_type                 = 'SYS_YES_NO'
and     not exists
        (select 'x'
         from   cst_item_costs cic,
                cst_cost_types cct
         where  cic.organization_id    = onhand.organization_id
         and    cic.inventory_item_id  = onhand.inventory_item_id
         and    cic.cost_type_id       = cct.cost_type_id
         and    3=3                    -- p_cost_type
        )
-- ===================================================================
-- Using the base tables to avoid using views
-- ===================================================================
and     hoi.org_information_context     = 'Accounting Information'
and     hoi.organization_id             = mp.organization_id
and     hoi.organization_id             = haou.organization_id   -- this gets the organization name
and     haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and     gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
-- avoid selecting disabled inventory organizations
and     sysdate < nvl(haou.date_to, sysdate + 1)
-- Revision for version 1.1, Operating Unit and Ledger Controls and Parameters
and     (nvl(fnd_profile.value('XXEN_REPORT_USE_LEDGER_SECURITY'),'N')='N' or gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+)))
and     (nvl(fnd_profile.value('XXEN_REPORT_USE_OPERATING_UNIT_SECURITY'),'N')='N' or haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11))
and     1=1                          -- p_operating_unit, p_ledger
-- order by Ledger, Operating_Unit, Org_Code, and Item
order by
        nvl(gl.short_name, gl.name), -- Ledger
        haou2.name, -- Operating_Unit
        mp.organization_code, -- Org_Code
        onhand.period_name, -- Period_Name
        onhand.concatenated_segments, -- Item_Number
        nvl(onhand.subinventory_code, ml1.meaning) -- Subinventory_or_Intransit
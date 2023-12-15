/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Item Cost Break-Out by Activity
-- Description: Report to show item costs by cost element, by activity.  Using up to five entered activities.  In order for this report to show your activity costs you must first define your activities and then associate your sub-elements by activity.

/* +=============================================================================+
-- |  Copyright 2009-2022 Douglas Volz Consulting, Inc.                          |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged. No warranties, express or otherwise is included in this      |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name: xxx_item_cost_break_out_by_activity_rept.sql
-- |
-- |  Parameters:
- |  p_cost_type            -- The cost type you wish to report
-- |  p_org_code             -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit       -- Operating Unit you wish to report, leave blank for all
-- |                            operating units (optional) 
-- |  p_ledger               -- general ledger you wish to report, leave blank for all
-- |                            ledgers (optional)
-- |  p_item_number          -- Enter the specific item number you wish to report
-- |  p_activity1            -- First activity to report
-- |  p_activity2            -- Second activity to report
-- |  p_activity3            -- Third activity to report
-- |  p_activity4            -- Fourth activity to report
-- |  p_activity5            -- Fifth activity to report
-- |  p_category_set1        -- The first item category set to report, typically the
-- |                            Cost or Product Line Category Set
-- |  p_category_set2        -- The second item category set to report, typically the
-- |                            Inventory Category Set 
-- |
-- |  Description:
-- |  Report to show Frozen costs in the Frozen cost type, by activity.  Using
-- |  up to six parameters activities.
-- |  
-- |  Version Modified on Modified by Description
-- |  ======  =========== ============== =========================================
-- |  1.0     08 Nov 2016 Douglas Volz  Initial Coding based on XXX_ITEM_COST_REPT.sql\
-- |                                    Hard-coded for activities starting with S (Sort),
-- |                                    A (Assembly), T (Test), BE (Back-End) or UNASSIGNED.
-- |  1.1     09 Nov 2016 Douglas Volz  Added PL item costs with no sub-element (resource_id)
-- |  1.2     10 Nov 2016 Douglas Volz  Added Business Code, Product Family and 
-- |                                    Product Type item categories
-- |  1.3     18 Nov 2016 Douglas Volz  Modified to use the Resource Activity assignments
-- |  1.4     21 Jan 2017 Douglas Volz  Changed the report to assume that all
-- |                                    resources have been assigned to an activity
-- |  1.5     07 Sep 2019 Douglas Volz  Reported activities are now parameters.
-- |                                    Up to five activity parameters.
-- |  1.6     09 Sep 2019 Douglas Volz  Added a max(mc.segment1) for the category
-- |                                    column select statements due to having
-- |                                    multiple category values for the same org,
-- |                                    item and category set id (Inventory). 
-- |  1.7     27 Jan 2020 Douglas Volz  Added Operating Unit and Org Code parameters.
-- |  1.8     02 Jul 2022 Douglas Volz  Change for multi-language and lookup types.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-item-cost-break-out-by-activity/
-- Library Link: https://www.enginatics.com/reports/cac-item-cost-break-out-by-activity/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 cct.cost_type Cost_Type,
        msiv.concatenated_segments Item_Number,
        msiv.description Item_Description,
 -- Revision for version 1.8
 -- msiv.primary_uom_code UOM_Code,
 muomv.uom_code UOM_Code,
 fcl.meaning Item_Type,
 -- Revision for version 1.8
 misv.inventory_item_status_code Item_Status,
 ml1.meaning Make_Buy_Code,
 -- Revision for version 1.6
&category_columns
 -- Revision for version 1.8
 fl1.meaning Allow_Costs,
 ml2.meaning Inventory_Asset,
 ml3.meaning Based_on_Rollup,
 cic.shrinkage_rate Shrinkage_Rate,
 gl.currency_code Currency_Code,
 -- End revision for version 1.8
 nvl(cic.material_cost,0) Material_Cost,
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd,
     -- Revision for version 1.8
        --cst_cost_types cct,
     bom_resources br,
     cst_activities ca
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    br.resource_id         = cicd.resource_id
     and    haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                    -- p_activity1
     and    br.default_activity_id = ca.activity_id
     and    cct.cost_type_id       = cicd.cost_type_id
     and    br.cost_element_id     = 3 -- Resource
    ),0),5) "Resource &p_activity1 Amount",
 round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd,
     -- Revision for version 1.8
        --cst_cost_types cct,
     bom_resources br,
     cst_activities ca
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    br.resource_id         = cicd.resource_id
     and    haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                    -- p_activity1
     and    br.default_activity_id = ca.activity_id
     and    cct.cost_type_id       = cicd.cost_type_id
     and    br.cost_element_id     = 4 -- Outside Processing
    ),0),5) "OSP &p_activity1 Amount",
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd,
     -- Revision for version 1.8
        --cst_cost_types cct,
     bom_resources bro,
     cst_activities ca
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    bro.resource_id        = cicd.resource_id
     and    haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                    -- p_activity1
     and    bro.default_activity_id = ca.activity_id
     and    cct.cost_type_id       = cicd.cost_type_id
     and    bro.cost_element_id    = 5 -- Overhead
    ),0),5) "Overhead &p_activity1 Amount",
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd,
     -- Revision for version 1.8
        --cst_cost_types cct,
     bom_resources br,
     cst_activities ca
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    br.resource_id         = cicd.resource_id
     and    2=2                    -- p_activity2
     and    br.default_activity_id = ca.activity_id
     and    cct.cost_type_id       = cicd.cost_type_id
     and    br.cost_element_id     = 3 -- Resource
    ),0),5) "Resource &p_activity2 Amount",
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd,
     -- Revision for version 1.8
        --cst_cost_types cct,
     bom_resources br,
     cst_activities ca
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    br.resource_id         = cicd.resource_id
     and    2=2                    -- p_activity2
     and    br.default_activity_id = ca.activity_id
     and    cct.cost_type_id       = cicd.cost_type_id
     and    br.cost_element_id     = 4 -- Outside Processing
    ),0),5) "OSP &p_activity2 Amount",
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd,
     -- Revision for version 1.8
        --cst_cost_types cct,
     bom_resources bro,
     cst_activities ca
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    bro.resource_id        = cicd.resource_id
     and    2=2                    -- p_activity2
     and    bro.default_activity_id = ca.activity_id
     and    cct.cost_type_id       = cicd.cost_type_id
     and    bro.cost_element_id    = 5 -- Overhead
    ),0),5) "Overhead &p_activity2 Amount",
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd,
     -- Revision for version 1.8
        --cst_cost_types cct,
     bom_resources br,
     cst_activities ca
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    br.resource_id         = cicd.resource_id
     and    3=3                    -- p_activity3
     and    br.default_activity_id = ca.activity_id
     and    cct.cost_type_id       = cicd.cost_type_id
     and    br.cost_element_id     = 3 -- Resource
    ),0),5) "Resource &p_activity3 Amount",
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd,
     -- Revision for version 1.8
        --cst_cost_types cct,
     bom_resources br,
     cst_activities ca
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    br.resource_id         = cicd.resource_id
     and    3=3                    -- p_activity3
     and    br.default_activity_id = ca.activity_id
     and    cct.cost_type_id       = cicd.cost_type_id
     and    br.cost_element_id     = 4 -- Outside Processing
    ),0),5) "OSP &p_activity3 Amount",
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd,
     -- Revision for version 1.8
        --cst_cost_types cct,
     bom_resources bro,
     cst_activities ca
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    bro.resource_id        = cicd.resource_id
     and    3=3                    -- p_activity3
     and    bro.default_activity_id = ca.activity_id
     and    cct.cost_type_id       = cicd.cost_type_id
     and    bro.cost_element_id    = 5 -- Overhead
    ),0),5) "Overhead &p_activity3 Amount",
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd,
     -- Revision for version 1.8
        --cst_cost_types cct,
     bom_resources br,
     cst_activities ca
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    br.resource_id         = cicd.resource_id
     and    4=4                    -- p_activity4
     and    br.default_activity_id = ca.activity_id
     and    cct.cost_type_id       = cicd.cost_type_id
     and    br.cost_element_id     = 3 -- Resource
    ),0),5) "Resource &p_activity4 Amount",
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd,
     -- Revision for version 1.8
        --cst_cost_types cct,
     bom_resources br,
     cst_activities ca
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    br.resource_id         = cicd.resource_id
     and    4=4                    -- p_activity4
     and    br.default_activity_id = ca.activity_id
     and    cct.cost_type_id       = cicd.cost_type_id
     and    br.cost_element_id     = 4 -- Outside Processing
    ),0),5) "OSP &p_activity4 Amount",
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd,
     -- Revision for version 1.8
        --cst_cost_types cct,
     bom_resources bro,
     cst_activities ca
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    bro.resource_id        = cicd.resource_id
     and    4=4                    -- p_activity4
     and    bro.default_activity_id = ca.activity_id
     and    cct.cost_type_id       = cicd.cost_type_id
     and    bro.cost_element_id    = 5 -- Overhead
    ),0),5) "Overhead &p_activity4 Amount",
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd,
     -- Revision for version 1.8
        --cst_cost_types cct,
     bom_resources br,
     cst_activities ca
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    br.resource_id         = cicd.resource_id
     and    5=5                    -- p_activity5
     and    br.default_activity_id = ca.activity_id
     and    cct.cost_type_id       = cicd.cost_type_id
     and    br.cost_element_id     = 3 -- Resource
    ),0),5) "Resource &p_activity5 Amount",
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd,
     -- Revision for version 1.8
        --cst_cost_types cct,
     bom_resources br,
     cst_activities ca
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    br.resource_id         = cicd.resource_id
     and    5=5                    -- p_activity5
     and    br.default_activity_id = ca.activity_id
     and    cct.cost_type_id       = cicd.cost_type_id
     and    br.cost_element_id     = 4 -- Outside Processing
    ),0),5) "OSP &p_activity5 Amount",
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd,
     -- Revision for version 1.8
        --cst_cost_types cct,
     bom_resources bro,
     cst_activities ca
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    bro.resource_id        = cicd.resource_id
     and    5=5                    -- p_activity5
     and    bro.default_activity_id = ca.activity_id
     and    cct.cost_type_id       = cicd.cost_type_id
     and    bro.cost_element_id    = 5 -- Overhead
    ),0),5) "Overhead &p_activity5 Amount",
 -- Non-Sort overheads based on resources
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd,
     -- Revision for version 1.8
        --cst_cost_types cct,
     bom_resources bro,
     cst_activities ca
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    bro.resource_id        = cicd.resource_id
     and    bro.resource_code not in (:p_activity1,:p_activity2,:p_activity3,:p_activity4,:p_activity5) 
     and    bro.default_activity_id = ca.activity_id (+)
     and    bro.resource_code not in ('PII','ICP')
     and    cct.cost_type_id       = cicd.cost_type_id
     and    bro.cost_element_id    = 5 -- Overhead
    ),0),5) Other_Overhead_Amounts,
 round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd,
     -- Revision for version 1.8
        --cst_cost_types cct,
     bom_resources br,
     cst_activities ca
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    br.resource_id         = cicd.resource_id
     and    nvl(ca.activity,'UNASSIGNED') = 'UNASSIGNED'
     -- End revision for version 1.4
     and    br.default_activity_id = ca.activity_id (+)
     and    cct.cost_type_id       = cicd.cost_type_id
     and    br.cost_element_id     = 3 -- Resource
    ),0),5) Unassigned_Resource_Amount,
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd,
     -- Revision for version 1.8
        --cst_cost_types cct,
     bom_resources br,
     cst_activities ca
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    br.resource_id         = cicd.resource_id
     and    nvl(ca.activity,'UNASSIGNED') = 'UNASSIGNED'
     -- End revision for version 1.4
     and    br.default_activity_id = ca.activity_id (+)
     and    cct.cost_type_id       = cicd.cost_type_id
     and    br.cost_element_id     = 4 -- Outside Processing
    ),0),5) Unassigned_OSP_Amount,
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd
     -- Revision for version 1.8
        --cst_cost_types cct
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    cicd.level_type        = 1 -- This Level
     and    cct.cost_type_id       = cicd.cost_type_id
     and    cicd.cost_element_id   = 2 -- Matl Overhead
    ),0),5) TL_Material_Overhead,
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd
     -- Revision for version 1.8
        --cst_cost_types cct
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    cicd.level_type        = 2 -- Previous Level
     and    cct.cost_type_id       = cicd.cost_type_id
     and    cicd.cost_element_id   = 2 -- Matl Overhead
    ),0),5) PL_Material_Overhead,
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd
     -- Revision for version 1.8
        --cst_cost_types cct
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    cicd.resource_id is null
     and    cicd.level_type        = 1 -- This Level
     and    cct.cost_type_id       = cicd.cost_type_id
     and    cicd.cost_element_id   = 3 -- Resource
    ),0),5) TL_Resource_No_SubElement,
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd
     -- Revision for version 1.8
        --cst_cost_types cct
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    cicd.resource_id is null
     and    cicd.level_type        = 2 -- Previous Level
     and    cct.cost_type_id       = cicd.cost_type_id
     and    cicd.cost_element_id   = 3 -- Resource
    ),0),5) PL_Resource_No_SubElement,
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd
     -- Revision for version 1.8
        --cst_cost_types cct
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    cicd.resource_id is null
     and    cicd.level_type        = 1 -- This Level
     and    cct.cost_type_id       = cicd.cost_type_id
     and    cicd.cost_element_id   = 4 -- Outside Processing
    ),0),5) TL_OSP_No_SubElement,
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd
     -- Revision for version 1.8
        --cst_cost_types cct
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    cicd.resource_id is null
     and    cicd.level_type        = 2 -- Previous Level
     and    cct.cost_type_id       = cicd.cost_type_id
     and    cicd.cost_element_id   = 4 -- Outside Processing
    ),0),5) PL_OSP_No_SubElement,
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd
     -- Revision for version 1.8
        --cst_cost_types cct
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    cicd.resource_id is null
     and    cicd.level_type        = 1 -- This Level
     and    cct.cost_type_id       = cicd.cost_type_id
     and    cicd.cost_element_id   = 5 -- Overhead
    ),0),5) TL_Overhead_No_SubElement,
  round(nvl((select sum(nvl(cicd.item_cost,0))
     from   cst_item_cost_details cicd
     -- Revision for version 1.8
        --cst_cost_types cct
     where  cicd.inventory_item_id = msiv.inventory_item_id
     and    cicd.organization_id   = mp.organization_id
     and    cicd.resource_id is null
     and    cicd.level_type        = 2 -- Previous Level
     and    cct.cost_type_id       = cicd.cost_type_id
     and    cicd.cost_element_id   = 5 -- Overhead
    ),0),5) PL_Overhead_No_SubElement,
 nvl(cic.material_cost,0) Material_Cost,
 nvl(cic.material_overhead_cost,0) Material_Overhead_Cost,
 nvl(cic.resource_cost,0) Resource_Cost,
 nvl(cic.outside_processing_cost,0) Outside_Processing_Cost,
 nvl(cic.overhead_cost,0) Overhead_Cost,
        nvl(cic.item_cost,0) Item_Cost,
 cic.creation_date Cost_Creation_Date,
 cic.last_update_date Last_Cost_Update_Date
from    cst_item_costs cic,
 cst_cost_types cct,
 mtl_system_items_vl msiv,
 mtl_parameters mp,
 -- Revision for version 1.8
 mtl_item_status_vl misv,
 mtl_units_of_measure_vl muomv,
 mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
 mfg_lookups ml2, -- inventory_asset_flag, SYS_YES_NO
 mfg_lookups ml3, -- based on rollup, CST_BONROLLUP_VAL
 fnd_lookups fl1, -- allow costs, YES_NO
 -- End revision for version 1.8
 fnd_common_lookups fcl,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,  -- inv_organization_id
 hr_all_organization_units_vl haou2, -- operating unit
 gl_ledgers gl
-- ===================================================================
-- Item master, organization and item master to cost joins
-- ===================================================================
where mp.organization_id              = msiv.organization_id
and     msiv.inventory_item_id          = cic.inventory_item_id
and     msiv.organization_id            = cic.organization_id
and cic.cost_type_id                = cct.cost_type_id
-- Revision for version 1.8
and msiv.primary_uom_code           = muomv.uom_code
and msiv.inventory_item_status_code = misv.inventory_item_status_code
-- End revision for version 1.8
and 6=6                             -- p_cost_type
-- ===================================================================
-- Don't report the unused inventory organizations
-- ===================================================================
-- Fix for version 1.4
and mp.organization_id             <> mp.master_organization_id    -- remove the global master org
-- ===================================================================
-- Lookup codes
-- ===================================================================
-- Revision for version 1.8
and ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and ml1.lookup_code                 = msiv.planning_make_buy_code
and ml2.lookup_type                 = 'SYS_YES_NO'
and ml2.lookup_code                 = to_char(cic.inventory_asset_flag)
and ml3.lookup_type                 = 'CST_BONROLLUP_VAL'
and ml3.lookup_code                 = cic.based_on_rollup_flag
and fl1.lookup_type                 = 'YES_NO'
and fl1.lookup_code                 = msiv.costing_enabled_flag
-- End revision for version 1.8
and fcl.lookup_type (+)             = 'ITEM_TYPE'
and fcl.lookup_code (+)             = msiv.item_type
-- ===================================================================
-- using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ===================================================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id   -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and 7=7                             -- p_item_number, p_org_code, p_operating_unit, p_ledger
order by
 nvl(gl.short_name,gl.name), -- Ledger
 haou2.name, -- Operating_Unit
 mp.organization_code, -- Org_Code
 cct.cost_type, -- Cost_Type
        msiv.concatenated_segments -- Item_Number
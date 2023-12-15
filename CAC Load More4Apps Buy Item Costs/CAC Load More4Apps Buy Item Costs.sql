/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Load More4Apps Buy Item Costs
-- Description: Report to fetch all buy items (based on rollup = No).   Used as a source of item costs for buy items which you wish to edit or change using the More4Apps Item Cost Wizard or similar tool.  You can over-ride the Make Buy Code by removing the defaulted value, but the Oracle Item Cost Interface works best for Buy Items; it does not work well with rolled-up costs and accordingly, this report only downloads items whose costs are not based on the cost rollup.

This report approximates the layout for the More4Apps Item Cost Wizard; run this report to get your Buy Item costs into Excel, make your changes in Excel then paste these revised costs into the More4Apps Item Cost Wizard.  Columns needed for the More4Apps Item Cost Wizard:  Org Code, Cost Type, Item Number, Based on Rollup, Lot Size, Mfg Shrinkage, Cost Element, Sub-Element, Basis Type and Rate or Amount.  The additional columns, Currency Code, UOM Code, Make Buy Code and Inventory Asset, are for reference purposes.

Parameters:
===========
From Cost Type:  enter the cost type you are downloading from (mandatory).
To Cost Type:  enter the cost type you are planning to upload back into the More4Apps Item Cost Wizard.  This Cost Type will show up on the report output (mandatory).
Item Status to Exclude:  enter the item number status you want to exclude.  Defaulted to 'Inactive' (optional).
Make or Buy:  enter the type of item you wish to report.  Defaulted to Buy Items, as the Oracle Item Cost Interface works best with items that you purchase, as opposed to rolled up costs (optional).
Cost Element:  enter the specific cost element you wish to download; for Buy Items typically the Material and Material Overhead Cost Elements (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2017 - 2023 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this
-- | permission.
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_load_m4app_buy_item_costs.sql
-- | 
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- |  1.0    07 Jun 2017 Douglas Volz  Initial Coding
-- |  1.1    16 Jun 2017 Douglas Volz  Only report based on rollup = No
-- |  1.2    12 Nov 2018 Douglas Volz  Remove prior client org restriction and
-- |                                   add Ledger parameter.
-- |  1.3    27 Jan 2020 Douglas Volz  Added Operating Unit parameter.
-- |  1.4    06 Jul 2022 Douglas Volz  Changed to multi-language views for the item
-- |                                   master and inventory orgs.
-- |  1.5    21 Oct 2023 Douglas Volz  Added UOM Code, Make Buy Code and Inventory
-- |                                   Asset columns; added Item Status, Make Buy
-- |                                   and Cost Element parameters, removed tabs
-- |                                   and added org access controls.
-- +=============================================================================+*/

-- Excel Examle Output: https://www.enginatics.com/example/cac-load-more4apps-buy-item-costs/
-- Library Link: https://www.enginatics.com/reports/cac-load-more4apps-buy-item-costs/
-- Run Report: https://demo.enginatics.com/

select  mp.organization_code Org_Code,
        :p_to_cost_type To_Cost_Type,                                                -- p_to_cost_type
        msiv.concatenated_segments Item_Number,
        decode(cic.based_on_rollup_flag,1,'Yes','No')  Based_on_Rollup,
        cic.lot_size Lot_Size,
        cic.shrinkage_rate MFG_Shrinkage,
        cce.cost_element Cost_Element,
        br.resource_code SubElement,
        ml1.meaning Basis_Type,
        cicd.usage_rate_or_amount Rate_or_Amount,
        gl.currency_code Currency_Code,
        -- Revision for version 1.5
        muomv.uom_code UOM_Code,
        misv.inventory_item_status_code Item_Status,
        ml2.meaning Make_Buy_Code,
        ml3.meaning Inventory_Asset
        -- End revision for version 1.5
from    bom_resources br,
        mtl_system_items_vl msiv,
        -- Revision for version 1.5
        mtl_item_status_vl misv,
        mtl_units_of_measure_vl muomv,
        -- End revision for version 1.5
        mtl_parameters mp, 
        cst_cost_types cct,
        cst_cost_elements cce,
        cst_item_costs cic,
        cst_item_cost_details cicd,
        mfg_lookups ml1, -- basis type
        mfg_lookups ml2, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
        mfg_lookups ml3, -- inventory_asset_flag, SYS_YES_NO
        hr_organization_information hoi,
        hr_all_organization_units_vl haou,  -- inv_organization_id
        hr_all_organization_units_vl haou2, -- operating unit
        gl_ledgers gl
where   mp.organization_id              = msiv.organization_id
and     msiv.inventory_asset_flag       = 'Y'  -- only valued items
-- Revision for version 1.5
and     msiv.primary_uom_code           = muomv.uom_code
and     msiv.inventory_item_status_code = misv.inventory_item_status_code
-- End revision for version 1.5
-- ========================================================
-- Cost Type Joins
-- ========================================================
and     cic.inventory_item_id           = msiv.inventory_item_id
and     cic.organization_id             = msiv.organization_id
and     cic.cost_type_id                = cct.cost_type_id
and     cicd.cost_type_id               = cct.cost_type_id
and     cicd.organization_id            = cic.organization_id
and     cicd.inventory_item_id          = cic.inventory_item_id
and     cicd.level_type                 = 1 -- This level
and     cicd.cost_type_id               = cct.cost_type_id
-- ========================================================
-- Organization, Bom Resources and Cost Element Joins
-- ========================================================
and     cicd.resource_id                = br.resource_id
and     cce.cost_element_id             = br.cost_element_id
-- Revision for version 1.5, comment this out
-- and     br.cost_element_id in (1,2)  -- Material and material overhead
and     mp.organization_id              = br.organization_id
-- Revision for version 1.1
and     cic.based_on_rollup_flag        = 2  -- 2 = No
-- ========================================================
-- Lookup Joins
-- ========================================================
and     ml1.lookup_type                 = 'CST_BASIS_SHORT'
and     ml1.lookup_code                 = cicd.basis_type
-- Revision for version 1.5
and     ml2.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and     ml2.lookup_code                 = msiv.planning_make_buy_code
and     ml3.lookup_type                 = 'SYS_YES_NO'
and     ml3.lookup_code                 = to_char(cic.inventory_asset_flag)
-- End revision for version 1.5
-- ========================================================
-- using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ========================================================
and     hoi.org_information_context     = 'Accounting Information'
and     hoi.organization_id             = mp.organization_id
and     hoi.organization_id             = haou.organization_id            -- this gets the organization name
and     haou2.organization_id           = hoi.org_information3            -- this gets the operating unit id
and     gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and     mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and     gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                             -- p_from_cost_type, p_to_cost_type, p_item_status_to_exclude, p_make_or_buy, p_cost_element, p_org_code, p_operating_unit, p_ledger
-- order by Org Code, Item, Cost Type, Cost Element and Sub-Element
order by 1,2,3,7,8,9
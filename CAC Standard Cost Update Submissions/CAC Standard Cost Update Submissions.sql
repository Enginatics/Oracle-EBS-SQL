/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Standard Cost Update Submissions
-- Description: Report to show the Standard Cost Update submissions, by Cost Update Date.  Including the parameters used and the overall inventory and WIP adjustment values.

Parameters:
Cost Update Date From:  starting cost update date, based on standard cost submission history (required).
Cost Update Date To: ending cost update date, based on standard cost submission history (required).
From Cost Type:  enter the cost type implemented by the Standard Cost Update into the Frozen costs (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2023 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_cost_update_submissions_rept.sql
-- | 
-- | Version Modified on Modified by    Description
-- | ======= =========== ============== =========================================
-- |  1.0    28 Sep 2023 Douglas Volz   Initial coding
-- +=============================================================================+*/


-- Excel Examle Output: https://www.enginatics.com/example/cac-standard-cost-update-submissions/
-- Library Link: https://www.enginatics.com/reports/cac-standard-cost-update-submissions/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name) Ledger,
        haou2.name Operating_Unit,
        ccu.organization_code Org_Code,
        ccu.update_date Cost_Update_Date,
        ccu.cost_update_id Cost_Update_Id,
        fu.user_name Cost_Update_Created_By,
        ccu.request_id Cost_Update_Request_Id, 
        ccu.cost_type From_Cost_Type,
        ccu.description Cost_Update_Description,
        ml1.meaning Cost_Update_Status,
        ml2.meaning Cost_Update_Range,
        ccu.concatenated_segments Specific_Item_Number,
        ccu.item_description Specific_Item_Description,
        ccu.item_range_low Item_Range_Low,
        ccu.item_range_high Item_Range_High,
        (select   mcsv.category_set_name
         from     mtl_category_sets_vl mcsv
         where    mcsv.category_set_id        = ccu.category_set_id
         and      ccu.category_set_id is not null
        ) Category_Set,
        (select   mcv.category_concat_segs
         from     mtl_categories_v mcv
         where    mcv.category_id             = ccu.category_id
         and      ccu.category_id is not null
        ) Category_Name,
        gl.currency_code Currency_Code,
        ccu.inventory_adjustment_value Total_Onhand_Adjustments,
        ccu.intransit_adjustment_value Total_Intransit_Adjustments,
        ccu.wip_adjustment_value Total_WIP_Adjustments,
        ccu.scrap_adjustment_value Total_Scrap_Adjustments,
        ml3.meaning Details_Saved,
        ml4.meaning Updated_Resources_Overheads,
        ml5.meaning Updated_Activity_Costs,
&segment_columns
        gcc.concatenated_segments Adjustment_Account 
from    (select   ccu.cost_update_id,
                  ccu.last_update_date,
                  ccu.last_updated_by,
                  ccu.creation_date,
                  ccu.last_update_login,
                  ccu.created_by,
                  ccu.status,
                  ccu.organization_id,
                  ccu.cost_type_id,
                  ccu.update_date,
                  ccu.description,
                  ccu.range_option,
                  ccu.update_resource_ovhd_flag,
                  ccu.update_activity_flag,
                  ccu.snapshot_saved_flag,
                  ccu.inv_adjustment_account,
                  ccu.single_item,
                  ccu.category_set_id,
                  ccu.category_id,
                  ccu.item_range_low,
                  ccu.item_range_high,
                  ccu.inventory_adjustment_value,
                  ccu.intransit_adjustment_value,
                  ccu.wip_adjustment_value,
                  ccu.scrap_adjustment_value,
                  ccu.request_id,
                  mp.organization_code,
                  cct.cost_type,
                  msiv.inventory_item_id,
                  msiv.concatenated_segments,
                  msiv.description item_description
         from     cst_cost_updates ccu,
                  cst_cost_types cct,
                  mtl_system_items_vl msiv,
                  mtl_parameters mp
         where    ccu.organization_id             = mp.organization_id
         and      ccu.cost_type_id                = cct.cost_type_id
         and      ccu.single_item                 = msiv.inventory_item_id (+)
         and      ccu.organization_id             = msiv.organization_id (+)
         and      2=2                             -- p_cost_update_date_from, p_cost_update_date_to, p_org_code, p_cost_type
         and    mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
        ) ccu,
        mfg_lookups ml1, -- cost update status
        mfg_lookups ml2, -- cost update submission range
        mfg_lookups ml3, -- snapshot saved, YES_NO
        mfg_lookups ml4, -- update resource overheads, YES_NO
        mfg_lookups ml5, -- activity costs saved, YES_NO
        fnd_user fu,
        gl_code_combinations_kfv gcc,
        gl_ledgers gl,
        hr_organization_information hoi,
        hr_all_organization_units_vl haou,  -- inv_organization_id
        hr_all_organization_units_vl haou2  -- operating unit
where   gcc.code_combination_id (+)     = ccu.inv_adjustment_account
and     fu.user_id                      = ccu.created_by
-- ===================================================================
-- Lookup codes
-- ===================================================================
and     ml1.lookup_type                 = 'CST_COST_UPDATE_STATUS'
and     ml1.lookup_code                 = ccu.status
and     ml2.lookup_type                 = 'CST_ITEM_RANGE'
and     ml2.lookup_code                 = ccu.range_option
and     ml3.lookup_type                 = 'SYS_YES_NO'
and     ml3.lookup_code                 = ccu.snapshot_saved_flag
and     ml3.lookup_type                 = 'SYS_YES_NO'
and     ml4.lookup_code                 = ccu.update_resource_ovhd_flag
and     ml4.lookup_type                 = 'SYS_YES_NO'
and     ml5.lookup_code                 = ccu.update_activity_flag
and     ml5.lookup_type                 = 'SYS_YES_NO'
-- ===================================================================
-- Using the base tables to avoid using org_organization_definitions
-- and hr_operating_units
-- ===================================================================
and     hoi.org_information_context     = 'Accounting Information'
and     hoi.organization_id             = ccu.organization_id
and     hoi.organization_id             = haou.organization_id   -- this gets the organization name
and     haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and     gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and     gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                             -- p_operating_unit, p_ledger
order by
        nvl(gl.short_name, gl.name), -- Ledger
        haou2.name, -- Operating Unit
        ccu.organization_code, -- Org Code
        ccu.update_date,
        ccu.cost_update_id
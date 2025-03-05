/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC OPM Batch Material Summary
-- Description: Report showing Batch materials in summary for each product, byproduct and ingredient.  Displaying batches which were open during the monthly inventory accounting period or batches which were closed during the monthly inventory accounting period.  If you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end item costs.

Parameters:
==========
Period Name:  enter the monthly inventory accounting period you wish to report (mandatory).
Cost Type:  enter a Cost Type to value the quantities using the Cost Type item costs; if Cost Type is not entered the report will use the Cost Type from your Fiscal Policies (optional).
OPM Calendar Code:  choose the OPM Calendar Code which corresponds to the period costs you wish to report (mandatory).
OPM Period Code:  enter the OPM Period Code which corresponds to the period costs and OPM Calendar Code you wish to report (mandatory).
Category Sets 1 - 3:  enter up to three item category sets you wish to report (optional).
Item Number:  specific Product, By-Product or Ingredient you wish to report (optional).
Batch Number: enter any batch number which is open or was closed within the date range of the OPM Period Code and Calendar Code (optional).
Batch Status:  to minimize the report size, specify the batch statuses you wish to report (optional).
Batch Number From:  (optional).
Batch Number To:  (optional).
Organization Code:  enter the inventory organization(s), defaults to your session's inventory organization (optional).
Operating Unit:  enter the operating unit(s) you wish to report (optional).
Ledger:  enter the ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2025 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     22 Jan 2025 Douglas Volz Initial Coding based on client's sample report.
-- +=============================================================================*/

-- Excel Examle Output: https://www.enginatics.com/example/cac-opm-batch-material-summary/
-- Library Link: https://www.enginatics.com/reports/cac-opm-batch-material-summary/
-- Run Report: https://demo.enginatics.com/

with item_cost as
-- For the batch materials, get the item costs
    (-- If the cost type is null, get the item
     -- costs from the month-end item costs.
     select gps.legal_entity_id,
            gic.cost_type_id,
            cmm.cost_mthd_code cost_type,
            cmm.cost_mthd_desc cost_type_desc,
            mp.organization_code,
            mp.organization_id,
            gic.inventory_item_id,
            msiv.concatenated_segments,
            msiv.description item_description,
            msiv.item_type,
            msiv.inventory_item_status_code,
            msiv.planning_make_buy_code,
            msiv.primary_uom_code,
            gps.calendar_code,
            gps.period_code,
            gps.period_id,
            -- To avoid rounding errors, use decimal precision 9
            round(sum(nvl(gic.acctg_cost,0)),9) item_cost
     from   gl_item_cst gic,
            cm_mthd_mst cmm, -- Cost Types
            gmf_period_statuses gps,
            gmf_fiscal_policies gfp,
            gmf_calendar_assignments gca,
            mtl_system_items_vl msiv,
            -- Use this logic in case of cost organizations
            (select mp.organization_id,
                    mp.organization_code,
                    to_number(hoi.org_information2) legal_entity_id,
                    nvl(cwa.cost_organization_id, mp.organization_id) cost_organization_id
             from   mtl_parameters mp,
                    hr_organization_information hoi, -- Legal Entity Id
                    cm_whse_asc cwa
             where  2=2                              -- p_org_code
             and    hoi.org_information_context     = 'Accounting Information'
             and    hoi.organization_id             = mp.organization_id
             and    mp.organization_id              = cwa.organization_id (+)
            ) mp
     where  gic.cost_type_id                = gfp.cost_type_id
     and    cmm.cost_type_id                = gic.cost_type_id
     and    mp.organization_id              = msiv.organization_id
     and    mp.cost_organization_id         = gic.organization_id
     and    gic.inventory_item_id           = msiv.inventory_item_id
     and    gic.period_id                   = gps.period_id
     and    gic.delete_mark                 = 0 -- Active
     and    msiv.inventory_asset_flag       = 'Y'
     and    gps.legal_entity_id             = gfp.legal_entity_id
     and    gps.cost_type_id                = gfp.cost_type_id
     and    gps.cost_type_id                = gca.cost_type_id
     and    gps.legal_entity_id             = gca.legal_entity_id
     and    gps.calendar_code               = gca.calendar_code
     -- After running the Cost Update in Final Mode the gic.calendar_code
     -- is set to a null value.
     -- and    gps.calendar_code               = gic.calendar_code
     and    mp.legal_entity_id              = gps.legal_entity_id
     and    :p_cost_type is null            -- p_cost_type
     -- The Inventory Accounting Period Name may be different from the OPM Period Code
     and    2=2                             -- p_org_code
     and    4=4                             -- p_item_number, p_calendar_code, p_period_code
     group by
            gps.legal_entity_id,
            gic.cost_type_id,
            cmm.cost_mthd_code, -- cost_type
            cmm.cost_mthd_desc, -- cost_type_description
            mp.organization_code,
            mp.organization_id,
            gic.inventory_item_id,
            msiv.concatenated_segments,
            msiv.description,
            msiv.item_type,
            msiv.inventory_item_status_code,
            msiv.planning_make_buy_code,
            msiv.primary_uom_code,
            gps.calendar_code,
            gps.period_code,
            gps.period_id
     union all
     -- If the cost type is not null, get the item
     -- costs from entered cost type.
     select gps.legal_entity_id,
            cmm.cost_type_id,
            cmm.cost_mthd_code cost_type,
            cmm.cost_mthd_desc cost_type_description,
            mp.organization_code,
            mp.organization_id,
            ccd.inventory_item_id,
            msiv.concatenated_segments,
            msiv.description item_description,
            msiv.item_type,
            msiv.inventory_item_status_code,
            msiv.planning_make_buy_code,
            msiv.primary_uom_code,
            gps.calendar_code,
            gps.period_code,
            gps.period_id,
            -- To avoid rounding errors, use decimal precision 9
            round(sum(nvl(ccd.cmpnt_cost,0)),9) item_cost
     from   cm_cmpt_dtl ccd,
            cm_cmpt_mst_b ccm,
            cm_mthd_mst cmm, -- Cost Types
            gmf_period_statuses gps,
            gmf_calendar_assignments gca,
            mtl_system_items_vl msiv,
            -- Use this logic in case of cost organizations
            (select mp.organization_id,
                    mp.organization_code,
                    to_number(hoi.org_information2) legal_entity_id,
                    nvl(cwa.cost_organization_id, mp.organization_id) cost_organization_id
             from   mtl_parameters mp,
                    hr_organization_information hoi, -- Legal Entity Id
                    cm_whse_asc cwa
             where  2=2                             -- p_org_code
             and    hoi.org_information_context     = 'Accounting Information'
             and    hoi.organization_id             = mp.organization_id
             and    mp.organization_id              = cwa.organization_id (+)
            ) mp
     where  ccd.cost_cmpntcls_id            = ccm.cost_cmpntcls_id
     and    ccm.product_cost_ind            = 1 -- Yes
     and    ccd.cost_type_id                = cmm.cost_type_id
     -- Use Period Id, not Calendar Code with ccd
     and    ccd.period_id                   = gps.period_id
     and    ccd.organization_id             = mp.cost_organization_id
     and    mp.organization_id              = msiv.organization_id
     and    ccd.inventory_item_id           = msiv.inventory_item_id
     and    ccd.delete_mark                 = 0 -- Active
     and    msiv.inventory_asset_flag       = 'Y'
     and    gps.cost_type_id                = ccd.cost_type_id
     and    gps.cost_type_id                = gca.cost_type_id
     and    gps.legal_entity_id             = gca.legal_entity_id
     and    gps.legal_entity_id             = mp.legal_entity_id
     and    gps.calendar_code               = gca.calendar_code
     and    :p_cost_type is not null        -- p_cost_type
     and    2=2                             -- p_org_code
     and    3=3                             -- p_cost_type
     and    4=4                             -- p_item_number, p_calendar_code, p_period_code
     group by
            gps.legal_entity_id,
            cmm.cost_type_id,
            cmm.cost_mthd_code, -- cost_type
            cmm.cost_mthd_desc, -- cost_type_description
            mp.organization_code,
            mp.organization_id,
            ccd.inventory_item_id,
            msiv.concatenated_segments,
            msiv.description,
            msiv.item_type,
            msiv.inventory_item_status_code,
            msiv.planning_make_buy_code,
            msiv.primary_uom_code,
            gps.calendar_code,
            gps.period_code,
            gps.period_id
    ) -- item_cost

----------------main query starts here--------------

select  nvl(gl.short_name, gl.name) Ledger,
        haou2.name Operating_Unit,
        mp.organization_code Org_Code,
        gps.calendar_code Calendar_Code,
        gps.period_code Period_Code,
        gbh.batch_no Batch_Number,
        gbh.plan_start_date Batch_Start_Date,
        gbh.plan_cmplt_date Planned_Completion_Date,
        gbh.actual_cmplt_date Actual_Completion_Date,
        gbh.batch_close_date Closed_Date,
        gl1.meaning Batch_Status,
        msiv.concatenated_segments Item_Number,
        msiv.description Item_Description,
        gl2.meaning Row_Type,
        fcl.meaning Item_Type,
        misv.inventory_item_status_code Item_Status,
        ml1.meaning Make_Buy_Code,
&category_segments1
&category_segments2
&category_segments3
        gmd.plan_qty * mucv.conversion_rate Primary_Planned_Quantity,
        msiv.primary_uom_code Primary_UOM_Code,
        gmd.plan_qty Planned_Transacted_Quantity,
        gmd.dtl_um Planned_Transacted_UOM,
        gmd.actual_qty Actual_Transacted_Quantity,
        gmd.dtl_um Transacted_UOM_Code,
        gmd.actual_qty * mucv.conversion_rate Primary_Actual_Quantity,
        msiv.primary_uom_code Primary_UOM_Code,
        msiv.primary_uom_code Primary_UOM,
        ic.cost_type Cost_Type,
        ic.cost_type_desc Cost_Type_Description,
        ic.item_cost Item_Cost
from    gme_batch_header gbh,
        gme_material_details gmd,
        mtl_uom_conversions_view mucv,
        item_cost ic,
        gmf_period_statuses gps,
        gmf_fiscal_policies gfp,
        gmf_calendar_assignments gca,
        org_acct_periods oap,
        mtl_system_items_vl msiv, -- Product, Byproduct or Ingredient
        mtl_item_status_vl misv,
        gem_lookups gl1, -- Batch Status
        gem_lookups gl2, -- Line Type
        fnd_common_lookups fcl, -- Item Type
        mfg_lookups ml1, -- Make Buy Code
        mtl_parameters mp,
        hr_organization_information hoi,
        hr_all_organization_units_vl haou, -- inv_organization_id
        hr_all_organization_units_vl haou2, -- operating unit
        gl_ledgers gl
where   mp.organization_id              = gbh.organization_id
and     oap.organization_id             = mp.organization_id
and     gmd.batch_id                    = gbh.batch_id
and     gbh.delete_mark                 = 0
and     ic.inventory_item_id            = gmd.inventory_item_id
and     ic.organization_id              = gmd.organization_id
and     mucv.uom_code                   = gmd.dtl_um
and     mucv.inventory_item_id          = gmd.inventory_item_id
and     mucv.organization_id            = gmd.organization_id
and     gps.legal_entity_id             = gfp.legal_entity_id
and     gps.cost_type_id                = gfp.cost_type_id
and     gps.cost_type_id                = gca.cost_type_id
and     gps.legal_entity_id             = gca.legal_entity_id
and     gps.calendar_code               = gca.calendar_code 
and     msiv.organization_id            = mp.organization_id
and     msiv.organization_id            = gmd.organization_id
and     msiv.inventory_item_id          = gmd.inventory_item_id
and     gl1.lookup_type (+)             = 'GME_BATCH_STATUS'
and     gl1.lookup_code (+)             = gbh.batch_status
and     gl2.lookup_type (+)             = 'LINE_TYPE'
and     gl2.lookup_code (+)             = gmd.line_type
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
and     fcl.lookup_code (+)             = msiv.item_type
and     misv.inventory_item_status_code = msiv.inventory_item_status_code
and     ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and     ml1.lookup_code                 = msiv.planning_make_buy_code
-- Avoid the item master organization
and     mp.organization_id             <> mp.master_organization_id
-- Avoid disabled inventory organizations
and     sysdate                        <  nvl(haou.date_to, sysdate +1)
-- Get process organizations
and     nvl(mp.process_enabled_flag, 'N') = 'Y'
-- Limit to either open batches or batches closed after the period start date
and    ((gbh.batch_close_date is null and nvl(gbh.actual_start_date, sysdate) < oap.schedule_close_date + 1)
         or
        (gbh.batch_close_date is not null and gbh.batch_close_date >= oap.period_start_date)
       )
and     hoi.org_information_context     = 'Accounting Information'
and     hoi.organization_id             = mp.organization_id
and     hoi.organization_id             = haou.organization_id   -- this gets the organization name
and     haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and     gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
--and     (nvl(fnd_profile.value('XXEN_REPORT_USE_LEDGER_SECURITY'),'N')='N' or gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+)))
--and     (nvl(fnd_profile.value('XXEN_REPORT_USE_OPERATING_UNIT_SECURITY'),'N')='N' or haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11))
--and     mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) 
and     1=1                             -- p_ledger, p_operating_unit, p_period_name, p_batch_number
and     2=2                             -- p_org_code
and     4=4                             -- p_item_number, p_calendar_code, p_period_code
and     5=5                             -- p_status_to_include
order by
        nvl(gl.short_name, gl.name),
        haou2.name,
        mp.organization_code,
        gps.calendar_code,
        gps.period_code,
        gbh.batch_no, -- Batch Number
        gl2.meaning, -- Line_Type
        msiv.concatenated_segments, -- Item_Number
        msiv.description, -- Item_Description
        fcl.meaning -- Inventory Item_Type
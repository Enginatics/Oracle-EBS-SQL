/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC OPM Costed Formula
-- Description: eport showing OPM formulas and item costs, by OPM Cost Component Class.   The report automatically displays the first thirty Cost Components, sorted by Usage Indicator (1-Material, 2-Overhead, 3-Resource, 4-Expense Alloc), then by the Cost Component Class.  With the "Other Costs" column summing up any other non-displayed Cost Component Classes.  For a different selection of Cost Component Classes, you may override any of the defaulted Cost Component Classes.  If you have fewer than thirty Cost Components the report automatically displays "Not Available", for the succeeding Cost Component columns.  And if you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end item costs.

Note:  The Label Approval column is from a user-defined Formula field, attribute4.  Your use of these descriptive flexfields, may be different and may require you to customize this report.

General Parameters:
===================
Cost Type:  enter a Cost Type to value the quantities using the Cost Type item costs; or, if Cost Type is not entered the report will use the stored month-end snapshot values (optional).
OPM Calendar Code:  choose the OPM Calendar Code which corresponds to the inventory accounting period you wish to report (mandatory).
OPM Period Code:  enter the OPM Period Code related to the inventory accounting period and OPM Calendar Code you wish to report (mandatory).
Only Show Latest Version:  enter Yes to report the latest formula and recipe version.  Enter No to see all versions (mandatory).
Show More Details:  enter Yes to display Ingredient Scale Type, Contribute to Yield, Standard Lot Size and End Date (from the validity rule).  Mandatory.
Effective Date:  for material line items and validity rules, enter the last ending date to report.  Defaults to today's date (mandatory).
Status to Include:  to minimize the report size, specify the formula, recipe and validity rule statuses you wish to report (optional).
Product Category Set:  the Product category set you wish to report (optional).
Line Category Set 1:  for the formula line item numbers, the first item category set to report (optional).
Line Category Set 2:  for the formula line item numbers, the second item category set to report (optional)
Item Number:  specific Product, By-Product or Ingredient you wish to report (optional).
Organization Code:  any inventory organization, defaults to your session's inventory organization (optional).
Operating Unit:  specific operating unit (optional).
Ledger:  specific ledger (optional).
Cost Component 1 - 30:  the defaulted Cost Component Classes.  You may override these defaulted values.

-- | Version Modified on Modified by Description
-- | ======= =========== ==============
-- | 1.0     02 Jun 2024 Douglas Volz Initial Coding based on client's sample report.
-- | 1.1     03 Jun 2024 Douglas Volz UOM conversions for formula line quantities
-- | 1.2     08 Jun 2024 Douglas Volz Replaced Cost Component rownum sort logic.
-- | 1.3     12 Jun 2024 Douglas Volz Cleaned-up naming for Cost Component parameters, fixed item number parameter.
-- | 1.4     03 Aug 2024 Douglas Volz Add OPM Cost Organizations to get correct item costs.
-- | 1.5     05 Aug 2024 Douglas Volz Add inventory organization access control security.
-- | 1.6     07 Aug 2024 Douglas Volz Not all formulas are assigned to classes, needs outer join.
-- | 1.7     08 Aug 2024 Douglas Volz Add item status and Make/Buy columns.
-- | 1.8     09 Aug 2024 Douglas Volz Add parameter "Show More Details" for Scale Type, Contribute to Yield, Std Lot Size and End Date.
-- | 1.9     17 Aug 2024 Douglas Volz Add parameters "Only Show Latest Version" and "Effective Date".
-- | 1.10    18 Aug 2024 Douglas Volz Restructured code.
-- | 1.11    07 Sep 2024 Douglas Volz Fixed Cost Component parameters, from lexicals to bind variables.
-- | 1.12    10 Sep 2024 Douglas Volz Add Std Lot Size UOM column.

-- Excel Examle Output: https://www.enginatics.com/example/cac-opm-costed-formula/
-- Library Link: https://www.enginatics.com/reports/cac-opm-costed-formula/
-- Run Report: https://demo.enginatics.com/

with ccmv as
    -- Order the Cost Components by usage_ind (1-Material, 2-Overhead, 3-Resource, 4-Expense Alloc) then by Cost Component Code
    (select row_number() over (order by ccmv.usage_ind, gl.meaning, ccmv.cost_cmpntcls_code) row_number,
            usage_ind,
            gl.meaning cost_component_type,
            ccmv.cost_cmpntcls_code cost_component_code,
            ccmv.cost_cmpntcls_desc,
            ccmv.cost_cmpntcls_id cost_component_id
     from   cm_cmpt_mst_vl ccmv,  -- Cost Component Master
            gem_lookups gl
     where  gl.lookup_type   = 'COST_COMPONENT_TYPE'
     and    gl.lookup_code   = ccmv.usage_ind
     and    ccmv.delete_mark = 0 -- Active
     order by 
            usage_ind,
            gl.meaning,
            ccmv.cost_cmpntcls_code
    ),
-- For the formula lines (msiv2), get the item costs by Cost Component
line_cost as
    (-- If the cost type is null, get the item
     -- costs from the month-end item costs.
     select gps.legal_entity_id,
            gic.cost_type_id,
            cmm.cost_mthd_code cost_type,
            cmm.cost_mthd_desc cost_type_desc,
            mp.organization_code,
            -- Revision for version 1.4
            -- gic.organization_id,
            mp.organization_id,
            -- End revision for version 1.4
            gic.inventory_item_id,
            -- Revision for version 1.3
            msiv2.concatenated_segments,
            msiv2.description item_description,
            msiv2.item_type,
            msiv2.inventory_item_status_code,
            msiv2.planning_make_buy_code,
            msiv2.primary_uom_code,
            -- End revision for version 1.3
            gps.calendar_code,
            gps.period_code,
            gps.period_id,
            gid.cost_cmpntcls_id cost_component_id,
            -- To avoid rounding errors, use decimal precision 9
            round(sum(nvl(gid.cmptcost_amt,0)),9) component_cost
     from   gl_item_cst gic,
            gl_item_dtl gid,
            cm_mthd_mst cmm, -- Cost Types
            gmf_period_statuses gps,
            gmf_fiscal_policies gfp,
            gmf_calendar_assignments gca,
            -- Revision for version 1.3
            -- mtl_system_items_vl msiv,
            mtl_system_items_vl msiv2,
            -- End revision for version 1.3
            -- Revision for version 1.4
            -- gmf_organization_definitions mp
            (select mp.organization_id,
                    mp.organization_code,
                    to_number(hoi.org_information2) legal_entity_id,
                    nvl(cwa.cost_organization_id, mp.organization_id) cost_organization_id
             from   mtl_parameters mp,
                    hr_organization_information hoi, -- Legal Entity Id
                    cm_whse_asc cwa
             where  32=32                           -- p_org_code
             and    hoi.org_information_context     = 'Accounting Information'
             and    hoi.organization_id             = mp.organization_id
             and    mp.organization_id              = cwa.organization_id (+)
            ) mp
            -- End revision for version 1.4
     where  gic.cost_type_id                = gfp.cost_type_id
     and    cmm.cost_type_id                = gic.cost_type_id
     -- Revision for version 1.4
     -- and    gic.organization_id          = msiv2.organization_id
     -- and    mp.organization_id           = gic.organization_id
     and    mp.organization_id              = msiv2.organization_id
     and    mp.cost_organization_id         = gic.organization_id
     -- End revision for version 1.4
     -- Revision for version 1.3
     and    gic.inventory_item_id           = msiv2.inventory_item_id
     -- End revision for version 1.3
     and    gic.period_id                   = gps.period_id
     and    gic.delete_mark                 = 0 -- Active
     and    gid.itemcost_id                 = gic.itemcost_id
     -- Revision for version 1.3
     and    msiv2.inventory_asset_flag      = 'Y'
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
     and    32=32                           -- p_org_code
     and    34=34                           -- p_item_number
     and    35=35                           -- p_calendar_code
     and    36=36                           -- p_period_code
     group by
            gps.legal_entity_id,
            gic.cost_type_id,
            cmm.cost_mthd_code, -- cost_type
            cmm.cost_mthd_desc, -- cost_type_description
            mp.organization_code,
            -- Revision for version 1.4
            -- gic.organization_id,
            mp.organization_id,
            -- End revision for version 1.4
            gic.inventory_item_id,
            -- Revision for version 1.3
            msiv2.concatenated_segments,
            msiv2.description,
            msiv2.item_type,
            msiv2.inventory_item_status_code,
            msiv2.planning_make_buy_code,
            msiv2.primary_uom_code,
            -- End revision for version 1.3
            gps.calendar_code,
            gps.period_code,
            gps.period_id,
            gid.cost_cmpntcls_id -- cost_component_id
     union all
     -- If the cost type is not null, get the item
     -- costs from entered cost type.
     select gps.legal_entity_id,
            cmm.cost_type_id,
            cmm.cost_mthd_code cost_type,
            cmm.cost_mthd_desc cost_type_description,
            mp.organization_code,
            -- Revision for version 1.4
            -- ccd.organization_id,
            mp.organization_id,
            -- End revision for version 1.4
            ccd.inventory_item_id,
            -- Revision for version 1.3
            msiv2.concatenated_segments,
            msiv2.description item_description,
            msiv2.item_type,
            msiv2.inventory_item_status_code,
            msiv2.planning_make_buy_code,
            msiv2.primary_uom_code,
            -- End revision for version 1.3
            gps.calendar_code,
            gps.period_code,
            gps.period_id,
            ccm.cost_cmpntcls_id cost_component_id,
            -- To avoid rounding errors, use decimal precision 9
            round(sum(nvl(ccd.cmpnt_cost,0)),9) item_cost
     from   cm_cmpt_dtl ccd,
            cm_cmpt_mst_b ccm,
            cm_mthd_mst cmm, -- Cost Types
            gmf_period_statuses gps,
            gmf_calendar_assignments gca,
            -- Revision for version 1.3
            mtl_system_items_vl msiv2,
            -- Revision for version 1.4
            -- gmf_organization_definitions mp
            (select mp.organization_id,
                    mp.organization_code,
                    to_number(hoi.org_information2) legal_entity_id,
                    nvl(cwa.cost_organization_id, mp.organization_id) cost_organization_id
             from   mtl_parameters mp,
                    hr_organization_information hoi, -- Legal Entity Id
                    cm_whse_asc cwa
             where  32=32                           -- p_org_code
             and    hoi.org_information_context     = 'Accounting Information'
             and    hoi.organization_id             = mp.organization_id
             and    mp.organization_id              = cwa.organization_id (+)
            ) mp
            -- End revision for version 1.4
     where  ccd.cost_cmpntcls_id            = ccm.cost_cmpntcls_id
     and    ccm.product_cost_ind            = 1 -- Yes
     and    ccd.cost_type_id                = cmm.cost_type_id
     -- Use Period Id, not Calendar Code with ccd
     and    ccd.period_id                   = gps.period_id
     -- Revision for version 1.4
     -- and    ccd.organization_id             = mp.organization_id
     -- and    ccd.organization_id             = msiv2.organization_id
     and    ccd.organization_id             = mp.cost_organization_id
     and    mp.organization_id              = msiv2.organization_id
     -- End revision for version 1.4
     -- Revision for version 1.3
     and    ccd.inventory_item_id           = msiv2.inventory_item_id
     -- End revision for version 1.3
     and    ccd.delete_mark                 = 0 -- Active
     -- Revision for version 1.3
     and    msiv2.inventory_asset_flag       = 'Y'
     and    gps.cost_type_id                = ccd.cost_type_id
     and    gps.cost_type_id                = gca.cost_type_id
     and    gps.legal_entity_id             = gca.legal_entity_id
     and    gps.legal_entity_id             = mp.legal_entity_id
     and    gps.calendar_code               = gca.calendar_code
     and    :p_cost_type is not null        -- p_cost_type
     and    32=32                           -- p_org_code
     and    33=33                           -- p_cost_type
     and    34=34                           -- p_item_number
     and    35=35                           -- p_calendar_code
     and    36=36                           -- p_period_code
     group by
            gps.legal_entity_id,
            cmm.cost_type_id,
            cmm.cost_mthd_code, -- cost_type
            cmm.cost_mthd_desc, -- cost_type_description
            mp.organization_code,
            -- Revision for version 1.4
            -- ccd.organization_id,
            mp.organization_id,
            -- End revision for version 1.4
            ccd.inventory_item_id,
            -- Revision for version 1.3
            msiv2.concatenated_segments,
            msiv2.description,
            msiv2.item_type,
            msiv2.inventory_item_status_code,
            msiv2.planning_make_buy_code,
            msiv2.primary_uom_code,
            -- End revision for version 1.3
            gps.calendar_code,
            gps.period_code,
            gps.period_id,
            ccm.cost_cmpntcls_id -- cost_component_id
    ),
-- Revision for version 1.10
last_formula as
    (select distinct
            ffmv2.formula_id,
            ffmv2.owner_organization_id organization_id,
            max(ffmv2.formula_vers) keep (dense_rank last order by ffmv2.formula_vers) over (partition by ffmv2.owner_organization_id, ffmv2.formula_no) version
     from   fm_form_mst_vl ffmv2,
            mtl_parameters mp,
            gmd_status_vl gsv -- Formula Status
     where  ffmv2.owner_organization_id     = mp.organization_id
     and    ffmv2.delete_mark               = 0 -- Active
     and    gsv.status_code                 = ffmv2.formula_status
     and    32=32                           -- p_org_code
     and    37=37                           -- p_status_to_include
    )

----------------main query starts here--------------

select  nvl(gl.short_name, gl.name) Ledger,
        haou2.name Operating_Unit,
        mp.organization_code Org_Code,
        gps.calendar_code Calendar_Code,
        gps.period_code Period_Code,
&category_segments1
        ffmv.formula_no Formula_Number,
        ffmv.formula_vers Formula_Version,
        gsv.status_code Status_Code,
        gsv.meaning Status_Description,
        ffmv.formula_desc1 Formula_Description1,
        ffmv.formula_class Formula_Class,
        gfcv.formula_class_desc Formula_Class_Description,
        msiv.concatenated_segments Product_Item_Number,
&category_segments2
&category_segments3
        nvl(ffmv.attribute4, msiv.attribute4) Label_Approval,
        fmd.line_no Line_No,
        msiv2.concatenated_segments Line_Item_Number,
        msiv2.description Line_Item_Description,
        fcl.meaning Item_Type,
        gl1.meaning Formula_Item_Type,
        -- Revision for version 1.7
        misv.inventory_item_status_code Item_Status,
        ml1.meaning Make_Buy_Code,
        -- End revision for version 1.7
        -- Revision for version 1.8
        &p_show_more_details
        fmd.detail_uom Detailed_UOM,
        -- Revision for version 1.1 and 1.4
        -- fmd.item_um Primary_UOM,
        msiv2.primary_uom_code Primary_UOM,
        -- End revision for version 1.4
        fmd.qty Quantity,
        -- Revision for version 1.1
        fmd.qty * mucv.conversion_rate Primary_Quantity,
    nvl((select max(line_cost.cost_type) from line_cost
         where  line_cost.inventory_item_id = msiv.inventory_item_id
         and    line_cost.organization_id   = msiv.organization_id),'') Cost_Type,
    nvl((select max(line_cost.cost_type_desc) from line_cost
         where  line_cost.inventory_item_id = msiv.inventory_item_id
         and    line_cost.organization_id   = msiv.organization_id),'') Cost_Type_Description,

  -- Cost_Component1
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    1=1                         -- p_cost_component1
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component1",

  -- Cost_Component2
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    2=2                         -- p_cost_component2
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component2",

  -- Cost_Component3
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    3=3                         -- p_cost_component3
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component3",

  -- Cost_Component4
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    4=4                         -- p_cost_component4
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component4",

  -- Cost_Component5
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    5=5                         -- p_cost_component5
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component5",

  -- Cost_Component6
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    6=6                         -- p_cost_component6
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component6",

  -- Cost_Component7
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    7=7                         -- p_cost_component7
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component7",

  -- Cost_Component8
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    8=8                         -- p_cost_component8
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component8",

  -- Cost_Component9
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    9=9                         -- p_cost_component9
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component9",

  -- Cost_Component10
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    10=10                       -- p_cost_component10
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component10",

  -- Cost_Component11
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    11=11                       -- p_cost_component11
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component11",

  -- Cost_Component12
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    12=12                       -- p_cost_component12
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component12",

  -- Cost_Component13
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    13=13                       -- p_cost_component13
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component13",

  -- Cost_Component14
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    14=14                       -- p_cost_component14
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component14",

  -- Cost_Component15
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    15=15                       -- p_cost_component15
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component15",

  -- Cost_Component16
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    16=16                       -- p_cost_component16
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component16",

  -- Cost_Component17
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    17=17                       -- p_cost_component17
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component17",

  -- Cost_Component18
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    18=18                       -- p_cost_component18
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component18",

  -- Cost_Component19
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    19=19                       -- p_cost_component19
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component19",

  -- Cost_Component20
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    20=20                       -- p_cost_component20
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component20",

  -- Cost_Component21
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    21=21                       -- p_cost_component21
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component21",

  -- Cost_Component22
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    22=22                       -- p_cost_component22
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component22",

  -- Cost_Component23
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    23=23                       -- p_cost_component23
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component23",

  -- Cost_Component24
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    24=24                       -- p_cost_component24
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component24",

  -- Cost_Component25
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    25=25                       -- p_cost_component25
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component25",

  -- Cost_Component26
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    26=26                       -- p_cost_component26
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component26",

  -- Cost_Component27
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    27=27                       -- p_cost_component27
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component27",

  -- Cost_Component28
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    28=28                       -- p_cost_component28
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component28",

  -- Cost_Component29
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    29=29                       -- p_cost_component29
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component29",

  -- Cost_Component30
    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where  ccmv.cost_component_id      = line_cost.cost_component_id
         and    30=30                       -- p_cost_component30
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) "&p_cost_component30",

    nvl((select sum(nvl(line_cost.component_cost,0)) from ccmv, line_cost
         where   ccmv.cost_component_id     = line_cost.cost_component_id
         and     ccmv.cost_component_code not in
               (:p_cost_component1,  :p_cost_component2,  :p_cost_component3,  :p_cost_component4,  :p_cost_component5,
                :p_cost_component6,  :p_cost_component7,  :p_cost_component8,  :p_cost_component9,  :p_cost_component10,
                :p_cost_component11, :p_cost_component12, :p_cost_component13, :p_cost_component14, :p_cost_component15,
                :p_cost_component16, :p_cost_component17, :p_cost_component18, :p_cost_component19, :p_cost_component20,
                :p_cost_component21, :p_cost_component22, :p_cost_component23, :p_cost_component24, :p_cost_component25,
                :p_cost_component26, :p_cost_component27, :p_cost_component28, :p_cost_component29, :p_cost_component30
               )
         and    line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) Other_Costs,
    nvl((select sum(nvl(line_cost.component_cost,0)) from line_cost
         where  line_cost.inventory_item_id = msiv2.inventory_item_id
         and    line_cost.organization_id   = msiv2.organization_id),0) Total_Item_Cost
from    fm_form_mst_vl ffmv,
        -- Revision for version 1.10
        &p_latest_formula_table
        fm_matl_dtl fmd,
        -- Revision for version 1.1
        mtl_uom_conversions_view mucv,
        gmf_period_statuses gps,
        gmf_fiscal_policies gfp,
        gmf_calendar_assignments gca,
        mtl_system_items_vl msiv, -- Formula Product Information
        mtl_system_items_vl msiv2, -- Formula Item Number Information
        -- Revision for version 1.7
        mtl_item_status_vl misv,
        gmd_status_vl gsv, -- Formula Status
        gmd_formula_class_vl gfcv, -- Formula Class Description
        -- Revision for version 1.9
        &p_show_more_dtl_tables
        gem_lookups gl1, -- Formula Line Type
        fnd_common_lookups fcl, -- Item Type
        -- Revision for version 1.7
        mfg_lookups ml1, -- Make Buy Code
        mtl_parameters mp,
        hr_organization_information hoi,
        hr_all_organization_units_vl haou, -- inv_organization_id
        hr_all_organization_units_vl haou2, -- operating unit
        gl_ledgers gl
where   mp.organization_id              = ffmv.owner_organization_id
and     ffmv.formula_id                 = fmd.formula_id
and     ffmv.delete_mark                = 0 -- Active
-- Revision for version 1.1
and     mucv.uom_code                   = fmd.detail_uom
and     mucv.inventory_item_id          = fmd.inventory_item_id
and     mucv.organization_id            = fmd.organization_id
-- End revision for version 1.1
-- Revision for version 1.10
&p_latest_formula_joins
and     gps.legal_entity_id             = gfp.legal_entity_id
and     gps.cost_type_id                = gfp.cost_type_id
and     gps.cost_type_id                = gca.cost_type_id
and     gps.legal_entity_id             = gca.legal_entity_id
and     gps.calendar_code               = gca.calendar_code 
and     msiv.organization_id            = mp.organization_id
and     msiv.inventory_item_id in
        (select max(fmd.inventory_item_id)
         from   fm_matl_dtl fmd 
         where  fmd.line_type  = 1 -- Product, may be multiple formula versions
         and    fmd.formula_id = ffmv.formula_id
        )
and     msiv2.organization_id           = fmd.organization_id
and     msiv2.inventory_item_id         = fmd.inventory_item_id
and     gsv.status_code                 = ffmv.formula_status
-- Revision for version 1.6
and     gfcv.formula_class (+)          = ffmv.formula_class
and     gl1.lookup_type (+)             = 'GMD_FORMULA_ITEM_TYPE'
and     gl1.lookup_code (+)             = fmd.line_type
-- Revision for version 1.8
&p_show_more_dtl_joins
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
and     fcl.lookup_code (+)             = msiv2.item_type
-- Revision for version 1.7
and     misv.inventory_item_status_code = msiv2.inventory_item_status_code
and     ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and     ml1.lookup_code                 = msiv2.planning_make_buy_code
-- End revision for version 1.7
-- Avoid the item master organization
and     mp.organization_id             <> mp.master_organization_id
-- Avoid disabled inventory organizations
and     sysdate                        <  nvl(haou.date_to, sysdate +1)
-- Get process organizations
and     nvl(mp.process_enabled_flag, 'N') = 'Y'
and     hoi.org_information_context     = 'Accounting Information'
and     hoi.organization_id             = mp.organization_id
and     hoi.organization_id             = haou.organization_id   -- this gets the organization name
and     haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and     gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
-- Revision for version 1.5
and     mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) 
and     31=31                           -- p_ledger, p_operating_unit
and     32=32                           -- p_org_code
-- Revision for version 1.3
and     34=34                           -- p_item_number
and     35=35                           -- p_calendar_code
and     36=36                           -- p_period_code
and     37=37                           -- p_status_to_include
-- Revision for version 1.9
and     38=38                           -- p_effective_date
group by
        nvl(gl.short_name, gl.name),
        haou2.name,
        mp.organization_code,
        gps.calendar_code,
        gps.period_code,
        -- For category_segments1
        msiv.inventory_item_id,
        msiv.organization_id,
        ffmv.formula_no,
        ffmv.formula_vers,
        gsv.status_code,
        gsv.meaning, -- Status_Description
        ffmv.formula_desc1,
        ffmv.formula_class,
        gfcv.formula_class_desc,
        msiv.concatenated_segments, -- Product_Item_Number
        -- For category_segments2 and 3
        msiv2.inventory_item_id,
        msiv2.organization_id,
        nvl(ffmv.attribute4, msiv.attribute4), -- Label_Approval
        fmd.line_no,
        msiv2.concatenated_segments, -- Line_Item_Number
        msiv2.description,
        fcl.meaning, -- Item_Type
        gl1.meaning, -- Formula_Item_Type
        -- Revision for version 1.7
        misv.inventory_item_status_code,
        ml1.meaning, -- Make_Buy_Code
        -- Revision for version 1.8
        &p_show_more_dtl_grp
        fmd.detail_uom, -- Detailed_UOM
        -- Revision for version 1.1 and 1.4
        -- fmd.item_um, -- Primary_UOM,
        msiv2.primary_uom_code, -- Primary_UOM
        -- End revision for version 1.4
        fmd.qty,
        -- Revision for version 1.1
        fmd.qty * mucv.conversion_rate -- Primary_Quantity
order by
        nvl(gl.short_name, gl.name),
        haou2.name,
        mp.organization_code,
        gps.calendar_code,
        gps.period_code,
        ffmv.formula_no,
        ffmv.formula_vers,
        gl1.meaning desc, -- Line_Type
        msiv.concatenated_segments, -- Formula_Item_Number
        fmd.line_no, -- Line_No
        msiv2.concatenated_segments, -- Line_Item_Number
        msiv2.description, -- Line_Item_Description
        fcl.meaning -- Inventory Item_Type
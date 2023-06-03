/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Calculate ICP PII Item Costs
-- Description: Report to identify the intercompany "To Org" profit in inventory (also known as PII or ICP) for each inventory organization and item.  Report gets the PII item costs across organizations, by joining the sourcing rule information from the first "hop" to the sourcing rule information to the second "hop".  In addition, if an item has a source organization in the item master, but the sourcing rule does not exist, this item relationship will still be reported.  This report also assumes that the first hop may have profit in inventory from another source organization and will not include any profit in inventory from the source org for the "To Org" profit in inventory calculations.  Likewise for the "To Org", any this level material overheads, resources, outside processing or overhead costs are ignored for the profit in inventory calculations.  In addition, inactive items and disabled organizations are ignored.

Note:  there are two hidden parameters: 
1) Numeric Sign for PII which allows you to set the sign of the profit in inventory amounts.  You can specify positive or negative values based on how you enter PII amounts.  Defaulted as positive (+1).
2) Include Transfers to Same OU which allows you to include or exclude transfers within the same Operating Unit (OU).  Defaulted to include these internal transfers.

Hidden Parameters:
Numeric Sign for PII:  Hidden parameter to set the sign of the profit in inventory amounts.  This parameter determines if PII is normally entered as a positive or negative amount.
Include Transfers to Same OU:  Hidden parameter to include or not include sourcing rules within the same operating unit.
Displayed Parameters:
Assignment Set:  the assignment set used by all Orgs (mandatory)
Cost Type:  the Frozen or Pending cost type you wish to report
PII Cost Type:  the profit in inventory cost type you wish to report
PII Sub-Element:  the sub-element or resource for profit in inventory, such as PII or ICP
Currency Conversion Date:  the exchange rate conversion date that was used to set the standard costs
Currency Conversion Type:  the exchange rate conversion type that was used to set the standard costs
Period Name:  the accounting period you wish to report for; this value does not change any PII or item costs, it is merely a reference value for reporting purposes.
From Organization: the shipping from inventory organization you wish to report (optional)
To Organization: the shipping to inventory organization you wish to report (optional)
Category Set 1:  the first item category set to report, typically the Cost or Product Line Category Set
Category Set 2:  the second item category set to report, typically the Inventory Category Set
Item Number:  enter a specific item number you wish to report (optional)

/* +=============================================================================+
-- | Copyright 2009-22 Douglas Volz Consulting, Inc.                             |
-- | All rights reserved.                                                        |
-- +=============================================================================+
-- | Note:  Run at month-end to get your pii cost and manually input into your 
-- |        PII cost type by organization.
-- | ============================================================================
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     26 Sep 2009 Douglas Volz   Initial Coding
-- | 1.35    26 Feb 2022 Douglas Volz   Add category sets and To Org and From Org
-- |                                    parameters. Add two hidden parameters,
-- |                                    Include Same OU Transfers and set Sign
-- |                                    for PII Amounts (p_sign_pii), to determine 
-- |                                    if PII is entered as a positive or negative.
+=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-calculate-icp-pii-item-costs/
-- Library Link: https://www.enginatics.com/reports/cac-calculate-icp-pii-item-costs/
-- Run Report: https://demo.enginatics.com/

select gp.period_name Period_Name,
-- ===============================================================================
-- Run the main query for the Calculate PII Item Cost Report  
-- ===============================================================================
 item_sourcing.item_number Item_Number,
 item_sourcing.item_description Item_Description,
 item_sourcing.primary_uom_code UOM_Code,
 -- Revision for version 1.29
 item_sourcing.item_type Item_Type,
 -- Revision for version 1.30 and 1.34
 ml.meaning Source_Make_Buy_Code,
 item_sourcing.item_status_code Source_Status_Code,
 -- End revision for version 1.29
 -- Revision for version 1.28
 -- item_sourcing.firstorg_prod_grp Cost Category,
 -- Revision for version 1.35
 -- nvl(item_sourcing.firstorg_prod_grp, '') p_category_set1,
 -- End revision for version 1.28
&category_columns
 -- End revision for version 1.35
 item_sourcing.firstorg_src_org Src_Org,
 item_sourcing.firstorg_assignment_set Src_Org_Assignment_Set,
 -- Revision for version 1.26
 -- item_sourcing.thirdorg_assignment_set To_Org_Assignment_Set,
 item_sourcing.firstorg_sourcing_rule Sourcing_Rule,
 gdr.from_currency Src_Curr_Code,
 -- Revision for version 1.30, 1.32
 -- Use the Planning Make/Buy Code, not the MFG Org Code
 round(decode(item_sourcing.firstorg_make_buy_code,
    -- Revision for version 1.30, 1.32
    -- 1 = Make
    -- 2 = Buy
    -- If Make or Buy item, take away source org PII for comparison purposes
    -- This assumes the transfer price is marked up at each hop, including any TL costs
    -- Revision for version 1.35
    -- Note that PII may be a negative or positive value, use a parameter to resolve
    1, nvl(src_org_costs.item_cost,0) - sign(:p_sign_pii) * nvl(src_org_costs.pii_cost,0),
    2, nvl(src_org_costs.item_cost,0) - sign(:p_sign_pii) * nvl(src_org_costs.pii_cost,0),
    nvl(src_org_costs.item_cost,0) - sign(:p_sign_pii) * nvl(src_org_costs.pii_cost,0)
      )
 -- End revision for version 1.30, 1.32
    ,5)                                                                                   Source_Item_Cost,
 gdr.conversion_date Currency_Conversion_Date,
 gdr.conversion_rate  Currency_Conversion_Rate,
 gdr.to_currency To_Org_Currency_Code,
 round(gdr.conversion_rate * 
  -- Revision for version 1.30, 1.32
  -- Use the Planning Make/Buy Code, not the MFG Org_Code
  decode(item_sourcing.firstorg_make_buy_code,
    -- 1 = Make
    -- 2 = Buy
    -- If Make or Buy item, take away source org PII for comparison purposes
    -- This assumes the transfer price is marked up at each hop, including any TL costs
    -- Revision for version 1.35
    -- Note that PII may be a negative or positive value, use a parameter to resolve
    1, nvl(src_org_costs.item_cost,0) - sign(:p_sign_pii) * nvl(src_org_costs.pii_cost,0),
    2, nvl(src_org_costs.item_cost,0) - sign(:p_sign_pii) * nvl(src_org_costs.pii_cost,0),
    nvl(src_org_costs.item_cost,0) - sign(:p_sign_pii) * nvl(src_org_costs.pii_cost,0)
        )
 -- End revision for version 1.30, 1.32
    ,5)                                                                      Converted_Source_Item_Cost,
 item_sourcing.thirdorg_to_org To_Org,
 -- Revision for version 1.30
 -- Use the Planning Make/Buy Code, not the MFG Org_Code
 round(decode(item_sourcing.thirdorg_make_buy_code,
    -- 1 = Make
    -- 2 = Buy
    -- If Make or buy item, use net costs for comparison purposes (without TL costs)
    1, nvl(to_org_costs.net_cost,0),
    2, nvl(to_org_costs.net_cost,0),
    nvl(to_org_costs.net_cost,0)
      )
 -- End revision for version 1.30, 1.32
    ,5)                                                                                  To_Org_Item_Cost,
 -- Converted_Source_Item_Cost minus the To_Org_Item_Cost = Calculated_To_Org PII
 -- Converted_Source_Item_Cost
 round((gdr.conversion_rate * 
  -- Revision for version 1.30, 1.32
  -- Use the Planning Make/Buy Code, not the MFG Org_Code
  decode(item_sourcing.firstorg_make_buy_code,
    -- 1 = Make
    -- 2 = Buy
    -- If Make or Buy item, take away source org PII for comparison purposes
    -- This assumes the transfer price is marked up at each hop, including any TL costs
    -- Revision for version 1.35
    -- Note that PII may be a negative or positive value, use a parameter to resolve
    1, nvl(src_org_costs.item_cost,0) - sign(:p_sign_pii) * nvl(src_org_costs.pii_cost,0),
    2, nvl(src_org_costs.item_cost,0) - sign(:p_sign_pii) * nvl(src_org_costs.pii_cost,0),
    nvl(src_org_costs.item_cost,0) - sign(:p_sign_pii) * nvl(src_org_costs.pii_cost,0)
        ) -
  -- End revision for version 1.30, 1.32
 -- minus the To_Org_Item_Cost
  -- Revision for version 1.30, 1.32
  -- Use the Planning Make/Buy Code, not the MFG Org_Code
  decode(item_sourcing.thirdorg_make_buy_code,
    -- Revision for version 1.30, 1.32
    -- 1 = Make
    -- 2 = Buy
    -- If Make or buy item, use net costs for comparison purposes (without TL costs)
    1, nvl(to_org_costs.net_cost,0),
    2, nvl(to_org_costs.net_cost,0),
    nvl(to_org_costs.net_cost,0)
        )
       )
 -- End revision for version 1.30, 1.32
 -- Revision for version 1.35, match to the sign of the PII amount
   * sign(:p_sign_pii) * -1
    ,5)                                                                                 Calculated_To_Org_PII,
 -- Calculated_To_Org PII / To_Org_Item_Cost = PII_Percent 
 -- Converted_Source_Item_Cost
 round((gdr.conversion_rate * 
  -- Revision for version 1.30, 1.32
  -- Use the Planning Make/Buy Code, not the MFG Org_Code
  decode(item_sourcing.firstorg_make_buy_code,
    -- Revision for version 1.30, 1.32
    -- 1 = Make
    -- 2 = Buy
    -- If Make or Buy item, take away source org PII for comparison purposes
    -- This assumes the transfer price is marked up at each hop, including any TL costs
    -- Revision for version 1.35
    -- Note that PII may be a negative or positive value, use a parameter to resolve
    1, nvl(src_org_costs.item_cost,0) - sign(:p_sign_pii) * nvl(src_org_costs.pii_cost,0),
    2, nvl(src_org_costs.item_cost,0) - sign(:p_sign_pii) * nvl(src_org_costs.pii_cost,0),
    nvl(src_org_costs.item_cost,0) - sign(:p_sign_pii) * nvl(src_org_costs.pii_cost,0)
        ) -
  -- End revision for version 1.30, 1.32
 -- minus the To_Org_Item_Cost
  -- Revision for version 1.30, 1.32
  -- Use the Planning Make/Buy Code, not the MFG Org_Code
  decode(item_sourcing.thirdorg_make_buy_code,
    -- Revision for version 1.30, 1.32   
    -- 1 = Make
    -- 2 = Buy
    -- If Make or buy item, use net costs for comparison purposes (without TL costs)
    1, nvl(to_org_costs.net_cost,0),
    2, nvl(to_org_costs.net_cost,0),
    nvl(to_org_costs.net_cost,0)
        )
       )
 -- End revision for version 1.30, 1.32
   / decode(decode(item_sourcing.thirdorg_make_buy_code,
    -- 1 = Make
    -- 2 = Buy
    -- If Make or buy item, take away To Org This Level Costs for comparison purposes
    1, nvl(to_org_costs.net_cost,0),
    2, nvl(to_org_costs.net_cost,0),
    nvl(to_org_costs.net_cost,0)
    -- End revision for version 1.30, 1.32
          ), 0, 1,
    -- Revision for version 1.30, 1.32
    -- Use the Planning Make/Buy Code, not the MFG Org_Code
    decode(item_sourcing.thirdorg_make_buy_code,
    -- 1 = Make
    -- 2 = Buy
    -- If Make or Buy item, use net costs for comparison purposes (without TL costs)
    1, nvl(to_org_costs.net_cost,0),
    2, nvl(to_org_costs.net_cost,0),
    nvl(to_org_costs.net_cost,0)
    -- End revision for version 1.30, 1.32
          )
    )
  * 100 -- turn into a percent
  -- Revision for version 1.35, match to the sign of the PII amount
  * case
       when nvl(to_org_costs.pii_cost,0) = 0 then sign(:p_sign_pii) * -1
       when nvl(to_org_costs.pii_cost,0) < 0 then 1
       when nvl(to_org_costs.pii_cost,0) > 0 then -1
       else 1 
    end
    ,1) PII_Percent,
 to_org_costs.pii_cost PII_Item_Cost,
 -- Calculated To Org PII minus PROD PII Item_Cost = PII Difference
 -- Converted_Source_Item_Cost minus the To Org Item Cost = Calculated_To_Org PII
 -- Converted_Source_Item_Cost
 (round((gdr.conversion_rate * 
  -- Revision for version 1.30, 1.32
  -- Use the Planning Make/Buy Code, not the MFG Org Code
  decode(item_sourcing.firstorg_make_buy_code,
    -- 1 = Make
    -- 2 = Buy
    -- If Make or Buy item, take away Source Org PII for comparison purposes
    -- This assumes the transfer price is marked up at each hop, including any TL costs
    -- Revision for version 1.35
    -- Note that PII may be a negative or positive value, use a parameter to resolve
    1, nvl(src_org_costs.item_cost,0) - sign(:p_sign_pii) * nvl(src_org_costs.pii_cost,0),
    2, nvl(src_org_costs.item_cost,0) - sign(:p_sign_pii) * nvl(src_org_costs.pii_cost,0),
    nvl(src_org_costs.item_cost,0) - sign(:p_sign_pii) * nvl(src_org_costs.pii_cost,0)
  -- End revision for version 1.30, 1.32
        ) -
  -- To_Org_Item_Cost
  -- Revision for version 1.30,1.32
  -- Use the Planning Make/Buy Code, not the MFG Org Code
  decode(item_sourcing.thirdorg_make_buy_code,
    -- 1 = Make
    -- 2 = Buy
    -- If Make or buy item, use net costs for comparison purposes (without TL costs)
    -- This assumes the transfer price is marked up at each hop, including any TL costs
    1, nvl(to_org_costs.net_cost,0),
    2, nvl(to_org_costs.net_cost,0),
    nvl(to_org_costs.net_cost,0)
        )
  -- End revision for version 1.30, 1.32
        )
  -- Revision for version 1.35, invert the sign for the Converted Source Item Cost
  * decode(sign(src_org_costs.pii_cost),1,-1,-1,1,-1)
     ,5)
  -- Revision for version 1.35 Correct the sign for the PII costs
  - case
       when nvl(to_org_costs.pii_cost,0) = 0 then 0
       when nvl(to_org_costs.pii_cost,0) < 0 then nvl(to_org_costs.pii_cost,0) * -1
       when nvl(to_org_costs.pii_cost,0) > 0 then nvl(to_org_costs.pii_cost,0) * 1
       else 0
    end
 ) *
 -- PROD PII Item Cost
 -- Revision for version 1.35, correct the sign for the overall PII cost difference
 case
    when nvl(to_org_costs.pii_cost,0) = 0 then sign(:p_sign_pii)                    -- p_sign_pii
    when nvl(to_org_costs.pii_cost,0) < 0 then -1
    when nvl(to_org_costs.pii_cost,0) > 0 then 1
    else 1
 end PII_Cost_Difference
from gl_periods gp,
 -- Revision for version 1.33 and 1.34
 gl_ledgers gl,
 hr_organization_information hoi,
 mfg_lookups ml,
 -- End of revision for version 1.33 and 1.34
 (select FirstOrg.item_number item_number,
  FirstOrg.inventory_item_id inventory_item_id,
  FirstOrg.description item_description,
  FirstOrg.primary_uom_code primary_uom_code,
  -- Revision for version 1.29
  FirstOrg.item_type item_type,
  FirstOrg.item_status_code,
  -- End revision for version 1.29
  -- Revision for version 1.30
  FirstOrg.planning_make_buy_code firstorg_make_buy_code,
  -- Revision for version 1.35
  -- nvl(mc.segment1,'') firstorg_prod_grp,
  FirstOrg.src_org firstorg_src_org,
  FirstOrg.src_org_id firstorg_src_org_id,
  FirstOrg.assignment_set firstorg_assignment_set,
  ThirdOrg.assignment_set thirdorg_assignment_set,
  FirstOrg.sourcing_rule firstorg_sourcing_rule,
  ThirdOrg.to_org_id thirdorg_to_org_id,
  ThirdOrg.to_org thirdorg_to_org,
  -- Revision for version 1.30
  ThirdOrg.planning_make_buy_code thirdorg_make_buy_code
  -- Revision for version 1.35
  -- from mtl_categories_v mc,
  --  mtl_item_categories mic,
  --  mtl_category_sets_b mcs,
  --  mtl_category_sets_tl mcs_tl,
  from
  -- ==========================================================
  -- Get the First Org Information
  -- ========================================================== 
  (select inv_to_org.organization_code to_org,
   inv_to_org.organization_id to_org_id, 
   inv_src_org.organization_code src_org,
   inv_src_org.organization_id src_org_id,
   -- Revision for version 1.24
   -- Client only has one Assignment Set
   mas.assignment_set_name assignment_set,
   -- End revision for version 1.24
   msr.sourcing_rule_name sourcing_rule,
   msiv.concatenated_segments item_number,
   msiv.inventory_item_id inventory_item_id,
   -- Revision for version 1.33
   muomv.uom_code primary_uom_code,
   msiv.description description,
   -- Revision for version 1.29
   fcl.meaning item_type,
   -- Revision for version 1.33
   misv.inventory_item_status_code_tl item_status_code,
   -- End revision for version 1.29
   -- Revision for version 1.30
   msiv.planning_make_buy_code,
   decode(msso.source_organization_id, null, 'VENDOR','ORG') SrcType
   from mrp_sr_source_org msso,
   mrp_sr_receipt_org msro,
   mrp_sourcing_rules msr,
   mrp_sr_assignments msa,
   mrp_assignment_sets mas,
   mtl_system_items_vl msiv,
   -- Revision for version 1.33
   mtl_units_of_measure_vl muomv,
   mtl_item_status_vl misv, 
   -- End revision for version 1.33
   mtl_parameters inv_to_org,
   mtl_parameters inv_src_org,
   -- Revision for version 1.29
   fnd_common_lookups fcl
   -- ====================================
   -- Sourcing_Rule Joins
   -- ====================================
   where msso.sr_receipt_id              = msro.sr_receipt_id
   and msr.sourcing_rule_id            = msro.sourcing_rule_id
   and msa.sourcing_rule_id            = msr.sourcing_rule_id
   -- Revision for version 1.24
   -- Client only has one Assignment Set
   and 1=1                             -- p_assignment_set
   -- End revision for version 1.24
   and msa.assignment_set_id           = mas.assignment_set_id
   and msiv.organization_id            = msa.organization_id
   and msiv.inventory_item_id          = msa.inventory_item_id
   -- Revision for version 1.33
   and msiv.primary_uom_code           = muomv.uom_code
   and misv.inventory_item_status_code = msiv.inventory_item_status_code
   -- End revision for version 1.33
   -- fix for version 1.15, exclude disabled items
   and msiv.inventory_item_status_code <> 'Inactive'
   -- Fix for version 1.28, screen out sourcing rules where the To_Org = Src_Org
   and inv_to_org.organization_id      <>  inv_src_org.organization_id
   -- ====================================
   -- Material Parameter joins for to_org
   -- ====================================
   and msa.organization_id             = inv_to_org.organization_id
   and msso.source_organization_id     = inv_src_org.organization_id
   -- ====================================
   -- Revision for version 1.24, exclude Master Org_Code
   and inv_to_org.organization_id     <> inv_to_org.master_organization_id
   and inv_src_org.organization_id    <> inv_src_org.master_organization_id
   -- End revision for version 1.24
   -- Revision for version 1.29
   -- Lookup codes for item types
   and fcl.lookup_code (+)             = msiv.item_type
   and fcl.lookup_type (+)             = 'ITEM_TYPE'
   -- =================================================
   -- Revision for version 1.29
   -- Add in items with no sourcing rules but have an
   -- item master source organization
   -- =================================================
   union all
   select inv_to_org.organization_code to_org,
   inv_to_org.organization_id to_org_id,  
   inv_src_org.organization_code src_org,
   inv_src_org.organization_id src_org_id,
   '' assignment_set,
   '' sourcing_rule,
   msiv.concatenated_segments item_number,
   msiv.inventory_item_id inventory_item_id,
   -- Revision for version 1.33
   muomv.uom_code primary_uom_code,
   msiv.description description,
   fcl.meaning item_type,
   -- Revision for version 1.33
   misv.inventory_item_status_code_tl item_status_code,
   -- Revision for version 1.30
   msiv.planning_make_buy_code,
   'ORG' SrcType
   from mtl_system_items_vl msiv,
   -- Revision for version 1.33
   mtl_units_of_measure_vl muomv,
   mtl_item_status_vl misv, 
   -- End revision for version 1.33
   mtl_parameters inv_to_org,
   mtl_parameters inv_src_org,
   -- Revision for version 1.29
   fnd_common_lookups fcl,
   -- Get the Operating_Unit Information
   hr_organization_information hoi1,
   hr_all_organization_units_vl haou1,
   hr_organization_information hoi2,
   hr_all_organization_units_vl haou2
   where msiv.organization_id            = inv_to_org.organization_id
   and msiv.source_organization_id     = inv_src_org.organization_id
   -- fix for version 1.15, exclude disabled items
   and msiv.inventory_item_status_code <> 'Inactive'
   and msiv.source_organization_id is not null
   and msiv.organization_id           <> inv_to_org.master_organization_id
   and msiv.source_organization_id    <> inv_src_org.master_organization_id
   -- Revision for version 1.33
   and msiv.primary_uom_code           = muomv.uom_code
   and misv.inventory_item_status_code = msiv.inventory_item_status_code
   -- End revision for version 1.33
   and not exists (
        select 'x'
        from mrp_sr_source_org msso,
      mrp_sr_receipt_org msro,
      mrp_sourcing_rules msr,
      mrp_sr_assignments msa,
      mrp_assignment_sets mas
        where msso.sr_receipt_id            = msro.sr_receipt_id
        and  msr.sourcing_rule_id          = msro.sourcing_rule_id
        and  msa.sourcing_rule_id          = msr.sourcing_rule_id
        -- Client only has one Assignment Set
        and  1=1                           -- p_assignment_set
        and  msa.assignment_set_id         = mas.assignment_set_id
        and  msiv.organization_id          = msa.organization_id
        and  msiv.inventory_item_id        = msa.inventory_item_id
        -- Material Parameter joins for to_org
        and  msa.organization_id           = inv_to_org.organization_id
        and  msso.source_organization_id   = inv_src_org.organization_id
       )
   -- Lookup codes for item types
   and fcl.lookup_code (+)             = msiv.item_type
   and fcl.lookup_type (+)             = 'ITEM_TYPE'
   -- =================================================
   -- Remove the OU to OU transfers across inventory orgs
   -- =================================================
   and hoi1.org_information_context    = 'Accounting Information'
   and hoi1.organization_id            = inv_to_org.organization_id
   and haou1.organization_id           = to_number(hoi1.org_information3) -- this gets the operating unit id
   and hoi2.org_information_context    = 'Accounting Information'
   and hoi2.organization_id            = inv_src_org.organization_id
   and haou2.organization_id           = to_number(hoi2.org_information3) -- this gets the operating unit id
   -- Revision for version 1.35, add p_include_same_ou_xfers parameter
   -- and haou1.organization_id          <> haou2.organization_id
   and 10=10                           -- p_include_same_ou_xfers
  ) FirstOrg,
  /* +=============================================================================+
  -- Revision for version 1.28
  -- Comment out the Second Org Information, not using this
  -- ==============================================================================+
  -- Get the Second Org Information
  -- ========================================================== 
  (select inv_to_org.organization_code to_org, 
   inv_to_org.organization_id to_org_id, 
   inv_src_org.organization_code src_org,
   inv_src_org.organization_id src_org_id,
   -- Revision for version 1.24
   -- Client only has one Assignment Set
   mas.assignment_set_name assignment_set,
   -- End revision for version 1.24
   msr.sourcing_rule_name sourcing_rule,
   msiv.concatenated_segments item_number,
   msiv.inventory_item_id inventory_item_id,
   -- Revision for version 1.33
   muomv.uom_code primary_uom_code,
   msiv.description description,
   -- Revision for version 1.29
   fcl.meaning item_type,
   -- Revision for version 1.33
   misv.inventory_item_status_code_tl item_status_code,
   -- End revision for version 1.29
   -- Revision for version 1.30
   msiv.planning_make_buy_code,
   decode(msso.source_organization_id, null, 'VENDOR','ORG') SrcType
   from mrp_sr_source_org msso,
   mrp_sr_receipt_org msro,
   mrp_sourcing_rules msr,
   mrp_sr_assignments msa,
   mrp_assignment_sets mas,
   mtl_system_items_vl msiv,
   -- Revision for version 1.33
   mtl_units_of_measure_vl muomv,
   mtl_item_status_vl misv, 
   -- End revision for version 1.33
   -- Revision for version 1.26
   -- gl_code_combinations gcc,
   mtl_parameters inv_to_org,
   mtl_parameters inv_src_org,
   -- Revision for version 1.29
   fnd_common_lookups fcl
   -- ====================================
   -- Sourcing_Rule Joins
   -- ====================================
   where msso.sr_receipt_id              = msro.sr_receipt_id
   and msr.sourcing_rule_id            = msro.sourcing_rule_id
   and msa.sourcing_rule_id            = msr.sourcing_rule_id
   -- Revision for version 1.24
   -- Client only has one Assignment Set
   and 1=1                             -- p_assignment_set
   and mas.assignment_set_name         = '&p_assignment_set'            -- p_assignment_set
   -- End revision for version 1.24
   and msa.assignment_set_id           = mas.assignment_set_id
   and msiv.organization_id            = msa.organization_id
   and msiv.inventory_item_id          = msa.inventory_item_id
   -- Revision for version 1.33
   and msiv.primary_uom_code           = muomv.uom_code
   and misv.inventory_item_status_code = msiv.inventory_item_status_code
   -- End revision for version 1.33
   -- Revision for version 1.29
   -- fix for version 1.15, exclude disabled items
   and msiv.inventory_item_status_code <> 'Inactive'
   -- End fix for version 1.29
   -- Fix for version 1.28, screen out sourcing rules where the To_Org = Src_Org
   and  inv_to_org.organization_id      <>  inv_src_org.organization_id
   -- ====================================
   -- Material Parameter joins for to_org
   -- ====================================
   and msa.organization_id             = inv_to_org.organization_id
   and inv_src_org.organization_id     = msso.source_organization_id
   -- Revision for version 1.24, Exclude Master Org_Code more generically
   and inv_to_org.organization_id     <> inv_to_org.master_organization_id
   and inv_src_org.organization_id    <> inv_src_org.master_organization_id
   -- End revision for version 1.24
   -- Revision for version 1.29
   -- Lookup codes for item types
   and fcl.lookup_code (+)             = msiv.item_type
   and fcl.lookup_type (+)             = 'ITEM_TYPE'
   -- =================================================
   -- Revision for version 1.29
   -- Add in items with no sourcing rules but have an
   -- item master source organization
   -- =================================================
   union all
   select inv_to_org.organization_code to_org,
   inv_to_org.organization_id to_org_id,  
   inv_src_org.organization_code src_org,
   inv_src_org.organization_id src_org_id,
   '' assignment_set,
   '' sourcing_rule,
   msiv.concatenated_segments item_number,
   msiv.inventory_item_id inventory_item_id,
   -- Revision for version 1.33
   muomv.uom_code primary_uom_code,
   msiv.description description,
   fcl.meaning item_type,
   -- Revision for version 1.33
   misv.inventory_item_status_code_tl item_status_code,
   -- Revision for version 1.30
   msiv.planning_make_buy_code,
   'ORG' SrcType
   from mtl_system_items_vl msiv,
   -- Revision for version 1.33
   mtl_units_of_measure_vl muomv,
   mtl_item_status_vl misv, 
   -- End revision for version 1.33
   mtl_parameters inv_to_org,
   mtl_parameters inv_src_org,
   fnd_common_lookups fcl,
   -- Get the Operating_Unit Information
   hr_organization_information hoi1,
   hr_all_organization_units_vl haou1,
   hr_organization_information hoi2,
   hr_all_organization_units_vl haou2
   where msiv.organization_id            = inv_to_org.organization_id
   and msiv.source_organization_id     = inv_src_org.organization_id
   -- Revision for version 1.33
   and msiv.primary_uom_code           = muomv.uom_code
   and misv.inventory_item_status_code = msiv.inventory_item_status_code
   -- End revision for version 1.33
   -- fix for version 1.15, exclude disabled items
   and msiv.inventory_item_status_code <> 'Inactive'
   and msiv.source_organization_id is not null
   and msiv.organization_id            <> inv_to_org.master_organization_id
   and msiv.source_organization_id     <> inv_src_org.master_organization_id
   and not exists (
        select 'x'
        from mrp_sr_source_org msso,
      mrp_sr_receipt_org msro,
      mrp_sourcing_rules msr,
      mrp_sr_assignments msa,
      mrp_assignment_sets mas
        where msso.sr_receipt_id            = msro.sr_receipt_id
        and  msr.sourcing_rule_id          = msro.sourcing_rule_id
        and  msa.sourcing_rule_id          = msr.sourcing_rule_id
        -- Client only has one Assignment Set
        and  1=1                           -- p_assignment_set
        and  mas.assignment_set_name       = '&p_assignment_set'            -- p_assignment_set
        and  msa.assignment_set_id         = mas.assignment_set_id
        and  msiv.organization_id           = msa.organization_id
        and  msiv.inventory_item_id         = msa.inventory_item_id
        -- ====================================
        -- Material Parameter joins for to_org
        -- ====================================
        and  msa.organization_id           = inv_to_org.organization_id
        and  msso.source_organization_id   = inv_src_org.organization_id
       )
   -- Lookup codes for item types
   and fcl.lookup_code (+)             = msiv.item_type
   and fcl.lookup_type (+)             = 'ITEM_TYPE'
   -- =================================================
   -- Remove the OU to OU transfers across inventory orgs
   -- =================================================
   and hoi1.org_information_context    = 'Accounting Information'
   and hoi1.organization_id            = inv_to_org.organization_id
   and haou1.organization_id           = to_number(hoi1.org_information3) -- this gets the operating unit id
   and hoi2.org_information_context    = 'Accounting Information'
   and hoi2.organization_id            = inv_src_org.organization_id
   and haou2.organization_id           = to_number(hoi2.org_information3) -- this gets the operating unit id
   -- Revision for version 1.35, add p_include_same_ou_xfers parameter
   -- and haou1.organization_id           <> haou2.organization_id
   and 10=10                           -- p_include_same_ou_xfers
  ) SecOrg,
  +================================================================================+
  -- End revision for version 1.28
  -- End comment out the Second Org Information, not using this
  -- +=============================================================================+*/
  -- ==========================================================
  -- Get the Third Org Information
  -- ========================================================== 
  (select inv_to_org.organization_code to_org, 
   inv_to_org.organization_id to_org_id, 
   inv_src_org.organization_code src_org,
   inv_src_org.organization_id src_org_id,
   -- Revision for version 1.24
   -- Client only has one Assignment Set
   mas.assignment_set_name assignment_set,
   msr.sourcing_rule_name sourcing_rule,
   msiv.concatenated_segments item_number,
   msiv.inventory_item_id inventory_item_id,
   -- Revision for version 1.33
   muomv.uom_code primary_uom_code,
   msiv.description description,
   -- Revision for version 1.29
   fcl.meaning item_type,
   -- Revision for version 1.33
   misv.inventory_item_status_code_tl item_status_code,
   -- Revision for version 1.30
   msiv.planning_make_buy_code,
   decode(msso.source_organization_id, null, 'VENDOR','ORG') SrcType
   from mrp_sr_source_org msso,
   mrp_sr_receipt_org msro,
   mrp_sourcing_rules msr,
   mrp_sr_assignments msa,
   mrp_assignment_sets mas,
   mtl_system_items_vl msiv,
   -- Revision for version 1.33
   mtl_units_of_measure_vl muomv,
   mtl_item_status_vl misv, 
   -- End revision for version 1.33
   -- Revision for version 1.26
   -- gl_code_combinations gcc,
   mtl_parameters inv_to_org,
   mtl_parameters inv_src_org,
   -- Revision for version 1.29
   fnd_common_lookups fcl
   -- ====================================
   -- Sourcing_Rule Joins
   -- ====================================
   where msso.sr_receipt_id              = msro.sr_receipt_id
   and msr.sourcing_rule_id            = msro.sourcing_rule_id
   and msa.sourcing_rule_id            = msr.sourcing_rule_id
   -- Revision for version 1.24
   -- Client only has one Assignment Set
   and 1=1                             -- p_assignment_set
   -- End revision for version 1.24           
   and msa.assignment_set_id           = mas.assignment_set_id
   and msiv.organization_id            = msa.organization_id
   and msiv.inventory_item_id          = msa.inventory_item_id
   -- Revision for version 1.33
   and msiv.primary_uom_code           = muomv.uom_code
   and misv.inventory_item_status_code = msiv.inventory_item_status_code
   -- End revision for version 1.33
   -- Revision for version 1.29
   -- fix for version 1.15, exclude disabled items
   and msiv.inventory_item_status_code <> 'Inactive'
   -- End fix for version 1.29
   -- Fix for version 1.28, screen out sourcing rules where the To_Org = Src_Org
   and  inv_to_org.organization_id        <>  inv_src_org.organization_id
   -- ====================================
   -- Material Parameter joins for to_org
   -- ====================================
   and msa.organization_id             = inv_to_org.organization_id
   and inv_src_org.organization_id     = msso.source_organization_id
   -- ====================================
   -- Revision for version 1.26, don't need this join anymore
   -- and gcc.code_combination_id         = msiv.cost_of_sales_account
   -- Revision for version 1.24, exclude Master Org, code this more generically
   and inv_to_org.organization_id        <> inv_to_org.master_organization_id
   and inv_src_org.organization_id       <> inv_src_org.master_organization_id
   -- End revision for version 1.24
   -- Revision for version 1.29
   -- Lookup codes for item types
   and fcl.lookup_code (+)             = msiv.item_type
   and fcl.lookup_type (+)             = 'ITEM_TYPE'
   -- =================================================
   -- Revision for version 1.29
   -- Add in items with no sourcing rules but have an
   -- item master source organization
   -- =================================================
   union all
   select inv_to_org.organization_code to_org,
   inv_to_org.organization_id to_org_id,  
   inv_src_org.organization_code src_org,
   inv_src_org.organization_id src_org_id,
   '' assignment_set,
   '' sourcing_rule,
   msiv.concatenated_segments item_number,
   msiv.inventory_item_id inventory_item_id,
   -- Revision for version 1.33
   muomv.uom_code primary_uom_code,
   msiv.description description,
   fcl.meaning item_type,
   -- Revision for version 1.33
   misv.inventory_item_status_code_tl item_status_code,
   -- Revision for version 1.30
   msiv.planning_make_buy_code,
   'ORG' SrcType
   from mtl_system_items_vl msiv,
   -- Revision for version 1.33
   mtl_units_of_measure_vl muomv,
   mtl_item_status_vl misv, 
   -- End revision for version 1.33
   mtl_parameters inv_to_org,
   mtl_parameters inv_src_org,
   fnd_common_lookups fcl,
   -- Get the Operating_Unit Information
   hr_organization_information hoi1,
   hr_all_organization_units_vl haou1,
   hr_organization_information hoi2,
   hr_all_organization_units_vl haou2
   where msiv.organization_id            = inv_to_org.organization_id
   and msiv.source_organization_id     = inv_src_org.organization_id
   -- Revision for version 1.33
   and msiv.primary_uom_code           = muomv.uom_code
   and misv.inventory_item_status_code = msiv.inventory_item_status_code
   -- End revision for version 1.33
   -- fix for version 1.15, exclude disabled items
   and msiv.inventory_item_status_code <> 'Inactive'
   and msiv.source_organization_id is not null
   and msiv.organization_id            <> inv_to_org.master_organization_id
   and msiv.source_organization_id     <> inv_src_org.master_organization_id
   and not exists (
        select 'x'
        from mrp_sr_source_org msso,
      mrp_sr_receipt_org msro,
      mrp_sourcing_rules msr,
      mrp_sr_assignments msa,
      mrp_assignment_sets mas
        where msso.sr_receipt_id            = msro.sr_receipt_id
        and  msr.sourcing_rule_id          = msro.sourcing_rule_id
        and  msa.sourcing_rule_id          = msr.sourcing_rule_id
        -- Client only has one Assignment Set
        and  1=1                           -- p_assignment_set
        and  msa.assignment_set_id         = mas.assignment_set_id
        and  msiv.organization_id           = msa.organization_id
        and  msiv.inventory_item_id         = msa.invento
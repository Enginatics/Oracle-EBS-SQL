/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Calculate ICP PII Item Costs
-- Description: Report to identify the intercompany "To Org" profit in inventory (also known as PII or ICP) for each inventory organization and item.  Report gets the PII item costs across organizations, by joining the sourcing rule information from the first "hop" to the sourcing rule information to the second "hop".  In addition, if an item has a source organization in the item master, but the sourcing rule does not exist, this item relationship will still be reported.  This report also assumes that the first hop may have profit in inventory from another source organization and will not include any profit in inventory from the source org for the "To Org" profit in inventory calculations.  Likewise for the "To Org", any this level material overheads, resources, outside processing or overhead costs are ignored for the profit in inventory calculations.  In addition, inactive items and disabled organizations are ignored.

Note:  there is one hidden parameter: 
1) Numeric Sign for PII which allows you to set the sign of the profit in inventory amounts.  You can specify positive or negative values based on how you enter PII amounts.  Defaulted as positive (+1).

Displayed Parameters:
Assignment Set:  the set of sourcing rules to use with calculating the PII item costs (mandatory).
Cost Type:  the cost type to use for the item costs, such as Frozen or Pending (mandatory).
PII Cost Type:  the profit in inventory cost type you wish to report (mandatory).  May or may not be the same as the Cost Type parameter.
PII Sub-Element:  the sub-element or resource for profit in inventory, such as PII or ICP (mandatory).
Currency Conversion Date:  the exchange rate conversion date that was used to set the standard costs (mandatory).
Currency Conversion Type:  the exchange rate conversion type that was used to set the standard costs (mandatory).
Period Name:  the accounting period you wish to report for; this value does not change any PII or item costs, it is merely a reference value for reporting purposes (mandatory).
Include Transfers to Same OU:  allows you to include or exclude transfers within the same Operating Unit (OU).  Defaulted to include these internal transfers.
From Organization: the shipping from inventory organization you wish to report (optional).
To Organization: the shipping to inventory organization you wish to report (optional).
Category Set 1:  the first item category set to report, typically the Cost or Product Line Category Set.
Category Set 2:  the second item category set to report, typically the Inventory Category Set.
Item Number:  enter a specific item number you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2009-23 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     26 Sep 2009 Douglas Volz   Initial Coding
-- | 1.34     05 May 2021 Douglas Volz   Add Make Buy Code.
-- | 1.35    26 Feb 2022 Douglas Volz   Add category sets and To Org and From Org
-- |                                    parameters. Add two hidden parameters,
-- |                                    Include Same OU Transfers and set Sign
-- |                                    for PII Amounts (p_sign_pii), to determine 
-- |                                    if PII is entered as a positive or negative.
-- | 1.36     28 Nov 2023 Andy Haack     Remove tabs, add org access controls, fix for G/L Daily Rates, outer joins
-- | 1.37     28 Jan 2024 Douglas Volz   Make Include Transfers to Same OU a displayed parameter. 
+=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-calculate-icp-pii-item-costs/
-- Library Link: https://www.enginatics.com/reports/cac-calculate-icp-pii-item-costs/
-- Run Report: https://demo.enginatics.com/

select   :p_period_name Period_Name,
-- ===============================================================================
-- Run the main query for the Calculate PII Item Cost Report  
-- ===============================================================================
        item_sourcing.item_number Item_Number,
        item_sourcing.item_description Item_Description,
        item_sourcing.primary_uom_code UOM_Code,
        -- Revision for version 1.29
        item_sourcing.item_type Item_Type,
        -- Revision for version 1.30, 1.34 and 1.36
        -- ml.meaning Source_Make_Buy_Code,
        xxen_util.meaning(item_sourcing.firstorg_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) Source_Make_Buy_Code,
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
        -- Revision for version 1.36
        -- gdr.from_currency Src_Currency_Code,
        item_sourcing.firstorg_src_currency Src_Curr_Code,
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
           ,5) Source_Item_Cost,
        -- Revision for version 1.36
        -- gdr.conversion_date Currency_Conversion_Date,
        :p_conversion_date Currency_Conversion_Date,
        nvl(gdr.conversion_rate,1) Currency_Conversion_Rate,
        -- gdr.to_currency To_Org_Currency_Code,
        item_sourcing.thirdorg_to_currency To_Org_Currency_Code,
        round(nvl(gdr.conversion_rate,1) * 
        -- End revision for version 1.36
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
           ,5) Converted_Source_Item_Cost,
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
           ,5) To_Org_Item_Cost,
        -- Converted_Source_Item_Cost minus the To_Org_Item_Cost = Calculated_To_Org PII
        -- Converted_Source_Item_Cost
        -- Revision for version 1.36
        round((nvl(gdr.conversion_rate,1) * 
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
           ,5) Calculated_To_Org_PII,
        -- Calculated_To_Org PII / To_Org_Item_Cost = PII_Percent 
        -- Converted_Source_Item_Cost
        -- Revision for version 1.36
        round((nvl(gdr.conversion_rate,1) * 
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
        -- Revision for version 1.36
        (round((nvl(gdr.conversion_rate,1) * 
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
        -- Revision for version 1.36
from    gl_ledgers gl,
        -- gl_periods gp,
        -- Revision for version 1.33, 1.34 and 1.36
        -- hr_organization_information hoi,
        -- mfg_lookups ml,
        -- End of revision for version 1.33, 1.34 and 1.36
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
                -- Revision for version 1.36
                FirstOrg.src_ledger_id firstorg_src_ledger_id,
                FirstOrg.src_currency firstorg_src_currency,
                -- End revision for version 1.36
                FirstOrg.assignment_set firstorg_assignment_set,
                ThirdOrg.assignment_set thirdorg_assignment_set,
                FirstOrg.sourcing_rule firstorg_sourcing_rule,
                ThirdOrg.to_org_id thirdorg_to_org_id,
                -- Revision for version 1.36
                ThirdOrg.to_currency thirdorg_to_currency,
                ThirdOrg.to_org thirdorg_to_org,
                -- Revision for version 1.30
                ThirdOrg.planning_make_buy_code thirdorg_make_buy_code
         -- Revision for version 1.35
         -- from   mtl_categories_v mc,
         --        mtl_item_categories mic,
         --        mtl_category_sets_b mcs,
         --        mtl_category_sets_tl mcs_tl,
         from
                -- ==========================================================
                -- Get the First Org Information
                -- ==========================================================
                -- Revision for version 1.36
                (select msrov.organization_code to_org,
                        msrov.receipt_organization_id to_org_id, 
                        mssov.source_organization_code src_org,
                        mssov.source_organization_id src_org_id,
                        mas.assignment_set_name assignment_set,
                        msr.sourcing_rule_name sourcing_rule,
                        msiv.concatenated_segments item_number,
                        msiv.inventory_item_id inventory_item_id,
                        -- Revision for version 1.33 and 1.36
                        -- muomv.uom_code primary_uom_code,
                        msiv.primary_uom_code,
                        msiv.description description,
                        -- Revision for version 1.29 and 1.36
                        -- fcl.meaning item_type,
                        xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
                        -- Revision for version 1.33
                        misv.inventory_item_status_code_tl item_status_code,
                        msiv.planning_make_buy_code,
                        -- Revision for version 1.36
                        -- decode(msso.source_organization_id, null, 'VENDOR','ORG') SrcType
                        nvl2(mssov.source_organization_id, 'ORG', 'VENDOR') SrcType,
                        ood.set_of_books_id src_ledger_id,
                        gl.currency_code src_currency
                 from   mrp_sourcing_rules msr,
                        mrp_sr_receipt_org_v msrov,
                        mrp_sr_source_org_v mssov,
                        mrp_sr_assignments msa,
                        mrp_assignment_sets mas,
                        mtl_system_items_vl msiv,
                        -- Revision for version 1.33 and 1.36
                        -- mtl_units_of_measure_vl muomv,
                        mtl_item_status_vl misv,
                        org_organization_definitions ood,
                        gl_ledgers gl
                 where  1=1                             -- p_assignment_set
                 and    msr.sourcing_rule_id            = msrov.sourcing_rule_id
                 and    mssov.sr_receipt_id             = msrov.sr_receipt_id
                 and    msa.sourcing_rule_id            = msr.sourcing_rule_id
                 and    msa.assignment_set_id           = mas.assignment_set_id
                 and    msiv.organization_id            = msa.organization_id
                 and    msiv.inventory_item_id          = msa.inventory_item_id
                 and    misv.inventory_item_status_code = msiv.inventory_item_status_code
                 and    msiv.inventory_item_status_code <> 'Inactive'
                 and    msrov.receipt_organization_id   <> mssov.source_organization_id
                 and    msrov.receipt_organization_id not in (select mp.master_organization_id from mtl_parameters mp)
                 and    mssov.source_organization_id not in (select mp.master_organization_id from mtl_parameters mp)
                 and    mssov.source_organization_id    = ood.organization_id
                 and    ood.set_of_books_id             = gl.ledger_id
                 -- End revision for version 1.36
                 -- =================================================
                 -- Revision for version 1.29 and 1.36
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
                        -- Revision for version 1.33 and 1.36
                        -- muomv.uom_code primary_uom_code,
                        msiv.primary_uom_code,
                        msiv.description description,
                        -- fcl.meaning item_type,
                        xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
                        misv.inventory_item_status_code_tl item_status_code,
                        msiv.planning_make_buy_code,
                        'ORG' SrcType,
                        inv_src_org.set_of_books_id src_ledger_id,
                        gl.currency_code src_currency
                 from   mtl_system_items_vl msiv,
                        -- mtl_units_of_measure_vl muomv,
                        mtl_item_status_vl misv, 
                        org_organization_definitions inv_to_org,
                        org_organization_definitions inv_src_org,
                        gl_ledgers gl
                 where  10=10                           -- p_include_same_ou_xfers
                 and    msiv.organization_id            = inv_to_org.organization_id
                 and    msiv.source_organization_id     = inv_src_org.organization_id
                 -- fix for version 1.15, exclude disabled items
                 and    msiv.inventory_item_status_code <> 'Inactive'
                 and    inv_to_org.organization_id not in (select mp.master_organization_id from mtl_parameters mp)                                                                   
                 and    inv_src_org.organization_id not in (select mp.master_organization_id from mtl_parameters mp)                                               
                 and    misv.inventory_item_status_code = msiv.inventory_item_status_code
                 and    inv_src_org.set_of_books_id     = gl.ledger_id
                 and    not exists (
                                    select 'x'
                                    from   mrp_sr_receipt_org msro,
                                           mrp_sr_source_org msso,
                                           -- Revision for version 1.36
                                           -- mrp_sourcing_rules msr,
                                           mrp_sr_assignments msa,
                                           mrp_assignment_sets mas
                                    where  msso.sr_receipt_id            = msro.sr_receipt_id
                                    -- Revision for version 1.36
                                    -- and    msr.sourcing_rule_id          = msro.sourcing_rule_id
                                    -- and    msa.sourcing_rule_id          = msr.sourcing_rule_id
                                    and    msa.sourcing_rule_id          = msro.sourcing_rule_id
                                    -- Client only has one Assignment Set
                                    and    1=1                           -- p_assignment_set
                                    and    msa.assignment_set_id         = mas.assignment_set_id
                                    and    msiv.organization_id          = msa.organization_id
                                    and    msiv.inventory_item_id        = msa.inventory_item_id
                                    -- Material Parameter joins for to_org
                                    and     msa.organization_id           = msiv.organization_id
                                    and     msso.source_organization_id   = msiv.source_organization_id
                                   )
                ) FirstOrg,
                -- ==========================================================
                -- Get the Third Org Information
                -- ========================================================== 
                (select  msrov.organization_code to_org,
                         msrov.receipt_organization_id to_org_id, 
                         mssov.source_organization_code src_org,
                         mssov.source_organization_id src_org_id,
                         mas.assignment_set_name assignment_set,
                         msr.sourcing_rule_name sourcing_rule,
                         msiv.concatenated_segments item_number,
                         msiv.inventory_item_id inventory_item_id,
                         msiv.primary_uom_code,
                         msiv.description description,
                         xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
                         misv.inventory_item_status_code_tl item_status_code,
                         msiv.planning_make_buy_code,
                         nvl2(mssov.source_organization_id, 'ORG', 'VENDOR') SrcType,
                         gl.currency_code to_currency
                 from    mrp_sourcing_rules msr,
                         mrp_sr_receipt_org_v msrov,
                         mrp_sr_source_org_v mssov,
                         mrp_sr_assignments msa,
                         mrp_assignment_sets mas,
                         mtl_system_items_vl msiv,
                         mtl_item_status_vl misv,
                         org_organization_definitions ood,
                         gl_ledgers gl
                 -- ====================================
                 -- Sourcing_Rule Joins
                 -- ====================================
                 where   1=1                             -- p_assignment_set
                 and     msr.sourcing_rule_id            = msrov.sourcing_rule_id
                 and     mssov.sr_receipt_id             = msrov.sr_receipt_id
                 and     msa.sourcing_rule_id            = msr.sourcing_rule_id
                 and     msa.assignment_set_id           = mas.assignment_set_id
                 and     msiv.organization_id            = msa.organization_id
                 and     msiv.inventory_item_id          = msa.inventory_item_id
                 and     misv.inventory_item_status_code = msiv.inventory_item_status_code
                 and     msiv.inventory_item_status_code <> 'Inactive'
                 and     msrov.receipt_organization_id   <>  mssov.source_organization_id
                 and     msrov.receipt_organization_id not in (select mp.master_organization_id from mtl_parameters mp)
                 and     mssov.source_organization_id not in (select mp.master_organization_id from mtl_parameters mp)
                 and     msrov.receipt_organization_id   = ood.organization_id
                 and     ood.set_of_books_id             = gl.ledger_id
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
                        -- Revision for version 1.33 and 1.36
                        msiv.primary_uom_code,
                        msiv.description description,
                        -- fcl.meaning item_type,
                        xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
                        -- Revision for version 1.33
                        misv.inventory_item_status_code_tl item_status_code,
                        -- Revision for version 1.30
                        msiv.planning_make_buy_code,
                        'ORG' SrcType,
                        -- Revision for version 1.36
                        gl.currency_code to_currency
                 from   mtl_system_items_vl msiv,
                        mtl_item_status_vl misv, 
                        org_organization_definitions inv_to_org,
                        org_organization_definitions inv_src_org,
                        gl_ledgers gl
                 where  10=10                           -- p_include_same_ou_xfers
                 and    msiv.organization_id            = inv_to_org.organization_id
                 and    msiv.source_organization_id     = inv_src_org.organization_id
                 and    msiv.inventory_item_status_code <> 'Inactive'
                 and    inv_to_org.organization_id not in (select mp.master_organization_id from mtl_parameters mp)
                 and    inv_src_org.organization_id not in (select mp.master_organization_id from mtl_parameters mp)
                 and    misv.inventory_item_status_code = msiv.inventory_item_status_code
                 and    inv_to_org.set_of_books_id      = gl.ledger_id
                 and    not exists (
                                    select 'x'
                                    from   mrp_sr_receipt_org msro,
                                           mrp_sr_source_org msso,
                                           mrp_sr_assignments msa,
                                           mrp_assignment_sets mas
                                    where  msso.sr_receipt_id            = msro.sr_receipt_id
                                    and    msa.sourcing_rule_id          = msro.sourcing_rule_id
                                    -- Client only has one Assignment Set
                                    and    1=1                           -- p_assignment_set
                                    and    msa.assignment_set_id         = mas.assignment_set_id
                                    and    msiv.organization_id          = msa.organization_id
                                    and    msiv.inventory_item_id        = msa.inventory_item_id
                                    -- ====================================
                                    -- Material Parameter joins for to_org
                                    -- ====================================
                                    and    msa.organization_id           = msiv.organization_id
                                    and    msso.source_organization_id   = msiv.source_organization_id
                                   )
                ) ThirdOrg
         -- =================================================
         -- This logic is OK, item number is always the same
         -- =================================================
         -- Revision for version 1.28, comment out SecOrg
         -- where  SecOrg.item_number         = FirstOrg.item_number 
         -- and    SecOrg.item_number         = ThirdOrg.item_number
         where  FirstOrg.item_number       = ThirdOrg.item_number
         -- End revision for version 1.28
         -- =================================================
         -- Change for version 1.27
         -- =================================================
         -- Logic changes, Client only has point-to-point sourcing rules with no hops
         -- as currently set up.  Cannot use the three hop logic until Client changes the
         -- point-to-point sourcing rules to three hops (Src => Distr => Distr)
         -- =========================
         -- Change for version 1.9
         -- =========================
         -- Get both the items with three sourcing rules and the items with two sourcing rules
         -- Commented out from version 1.9
         --     and  (Firstorg.to_org = Secorg.src_org and SecOrg.to_org = ThirdOrg.src_org)
         -- Logic from version 1.9, commented out from version 1.27
         -- 1.27 and    (
         -- 1.27           (Firstorg.to_org = Secorg.src_org and SecOrg.to_org = ThirdOrg.src_org)
         -- 1.27                OR
         -- 1.27           (Firstorg.to_org = Secorg.src_org and SecOrg.to_org <> ThirdOrg.src_org)
         -- 1.27         )
         -- Only use point-to-point sourcing rule logic, using the first and third set 
         -- of sourcing rules.
         and    (Firstorg.to_org = ThirdOrg.to_org)
         -- =============================
         -- End change for version 1.9
         -- =============================
         -- End revision for version 1.27
         -- =================================================
         -- Revision for version 1.28
         -- Joins for category product line values
         -- =================================================
         -- Revision for version 1.35
         -- and    mcs.category_set_id        = mcs_tl.category_set_id
         -- and    mcs_tl.language            = userenv('lang')
         -- and         mic.inventory_item_id      = FirstOrg.inventory_item_id (+)
         -- and    mic.organization_id        = FirstOrg.src_org_id  (+)
         -- and    mic.category_id            = mc.category_id
         -- and    mic.category_set_id        = mcs.category_set_id
         -- and    mcs_tl.category_set_name   = 'p_cost_category_set'
         -- End revision for version 1.28 and 1.35
         -- =================================================
         -- change for version 1.10
         -- Now exclude PII if is zero
         -- =================================================
         -- Change for version 1.21
         -- Don't exclude if the costs are the same as there
         -- still may be PII from lower level or previous 
         -- level costs.
         -- =================================================
         -- and (FirstOrg.source_item_cost) - ThirdOrg.to_org_item_cost <> 0
         group by 
                FirstOrg.item_number,
                FirstOrg.inventory_item_id,
                FirstOrg.description,
                FirstOrg.primary_uom_code,
                -- Revision for version 1.29
                FirstOrg.item_type,
                FirstOrg.item_status_code,
                -- End revision for version 1.29
                -- Revision for version 1.30
                FirstOrg.planning_make_buy_code,
                -- Revision for version 1.28 and 1.35
                -- nvl(mc.segment1,''), -- Product group category
                FirstOrg.src_org,
                FirstOrg.src_org_id,
                -- Revision for version 1.36
                FirstOrg.src_ledger_id,
                FirstOrg.src_currency,
                FirstOrg.assignment_set,
                ThirdOrg.assignment_set,
                FirstOrg.sourcing_rule,
                ThirdOrg.to_org,
                ThirdOrg.to_org_id,
                -- Revision for version 1.36
                ThirdOrg.to_currency,
                -- revision for version 1.30
                ThirdOrg.planning_make_buy_code
         ) item_sourcing,
        -- =================================================
        -- Get To Org Cost information
        -- =================================================
         (select cic.organization_id,
                 cic.inventory_item_id,
                 cic.cost_type_id,
                 cic.item_cost,
                 cic.material_cost,
                 cic.tl_material_overhead,
                 cic.tl_resource,
                 cic.tl_outside_processing,
                 cic.tl_overhead,
                 cic.item_cost - cic.tl_material_overhead - cic.tl_resource - 
                                 cic.tl_outside_processing - cic.tl_overhead net_cost,
                 nvl((select sum(cicd.item_cost)
                      from   cst_item_cost_details cicd,
                             cst_cost_types cct,
                             bom_resources br
                      where  cicd.cost_type_id      = cct.cost_type_id
                      and    2=2                    -- p_pii_cost_type
                      and    cicd.inventory_item_id = cic.inventory_item_id
                      and    cicd.organization_id   = cic.organization_id
                      and    cicd.resource_id       = br.resource_id
                      -- Revision for version 1.33
                      and    8=8                    -- p_pii_sub_element
                     ),0) pii_cost
         from   cst_item_costs cic,
                cst_cost_types cct
         -- ====================================
         -- Item_Cost Joins for the To_Org
         -- ====================================
         where  cic.cost_type_id              = cct.cost_type_id
         and    3=3                           -- p_cost_type
         union all
         select cic.organization_id,
                cic.inventory_item_id,
                cic.cost_type_id,
                cic.item_cost,
                cic.material_cost,
                cic.tl_material_overhead,
                cic.tl_resource,
                cic.tl_outside_processing,
                cic.tl_overhead,
                cic.item_cost - cic.tl_material_overhead - cic.tl_resource - 
                                cic.tl_outside_processing - cic.tl_overhead net_cost,
                nvl((select sum(cicd.item_cost)
                     from   cst_item_cost_details cicd,
                            cst_cost_types cct,
                            bom_resources br
                     where  cicd.cost_type_id      = cct.cost_type_id
                     and    2=2                    -- p_pii_cost_type
                     and    cicd.inventory_item_id = cic.inventory_item_id
                     and    cicd.organization_id   = cic.organization_id
                     and    cicd.resource_id       = br.resource_id
                     -- Revision for version 1.33
                     and    8=8                    -- p_pii_sub_element
                    ),0) pii_cost
         from   cst_item_costs cic,
                cst_cost_types cct,
                mtl_parameters mp
         -- ====================================
         -- Item_Cost Joins for the To Org
         -- ====================================
         where  cic.organization_id           = mp.organization_id
         and    cic.cost_type_id              = mp.primary_cost_method  -- this gets the Frozen Costs
         and    cct.cost_type_id             <> mp.primary_cost_method  -- this avoids getting the Frozen costs twice
         and    3=3                           -- p_cost_type
         -- ====================================
         -- Find all the Frozen costs not in the
         -- Pending or unimplemented cost type
         -- ====================================
         and    not exists
                        (select 'x'
                         from   cst_item_costs cic2
                         where  cic2.organization_id   = cic.organization_id
                         and    cic2.inventory_item_id = cic.inventory_item_id
                         and    cic2.cost_type_id      = cct.cost_type_id
                        )
        ) to_org_costs,
        -- =================================================
        -- Get Source Org Cost information
        -- =================================================
        (select cic.organization_id,
                cic.inventory_item_id,
                cic.cost_type_id,
                cic.item_cost,
                cic.material_cost,
                cic.tl_material_overhead,
                cic.tl_resource,
                cic.tl_outside_processing,
                cic.tl_overhead,
                cic.item_cost - cic.tl_material_overhead - cic.tl_resource - 
                                cic.tl_outside_processing - cic.tl_overhead net_cost,
                nvl((select sum(cicd.item_cost)
                     from   cst_item_cost_details cicd,
                            cst_cost_types cct,
                            bom_resources br
                     where  cicd.cost_type_id      = cct.cost_type_id
                     and    2=2                    -- p_pii_cost_type
                     and    cicd.inventory_item_id = cic.inventory_item_id
                     and    cicd.organization_id   = cic.organization_id
                     and    cicd.resource_id       = br.resource_id
                     -- Revision for version 1.33
                     and    8=8                    -- p_pii_sub_element
                    ),0) pii_cost
         from  cst_item_costs cic,
               cst_cost_types cct
         -- ====================================
         -- Item_Cost Joins for the Source Org
         -- ====================================
         where  cic.cost_type_id              = cct.cost_type_id
         and    3=3                           -- p_cost_type
         union all
         select cic.organization_id,
                cic.inventory_item_id,
                cic.cost_type_id,
                cic.item_cost,
                cic.material_cost,
                cic.tl_material_overhead,
                cic.tl_resource,
                cic.tl_outside_processing,
                cic.tl_overhead,
                cic.item_cost - cic.tl_material_overhead - cic.tl_resource - 
                                cic.tl_outside_processing - cic.tl_overhead net_cost,
                nvl((select sum(cicd.item_cost)
                     from   cst_item_cost_details cicd,
                            cst_cost_types cct,
                            bom_resources br
                     where  cicd.cost_type_id      = cct.cost_type_id
                     and    2=2                    -- p_pii_cost_type
                     and    cicd.inventory_item_id = cic.inventory_item_id
                     and    cicd.organization_id   = cic.organization_id
                     and    cicd.resource_id       = br.resource_id
                     -- Revision for version 1.33
                     and    8=8                    -- p_pii_sub_element
                    ),0) pii_cost
         from   cst_item_costs cic,
                cst_cost_types cct,
                mtl_parameters mp
         -- ====================================
         -- Item_Cost Joins for the Source Org
         -- ====================================
         where  cic.organization_id           = mp.organization_id
         and    cic.cost_type_id              = mp.primary_cost_method  -- this gets the Frozen Costs
         and    cct.cost_type_id             <> mp.primary_cost_method  -- this avoids getting the Frozen costs twice
         and    3=3                           -- p_cost_type
         -- ====================================
         -- Find all the Frozen costs not in the
         -- Pending or unimplemented cost type
         -- ====================================
         and   not exists 
                        (select 'x'
                         from   cst_item_costs cic2
                         where  cic2.organization_id   = cic.organization_id
                         and    cic2.inventory_item_id = cic.inventory_item_id
                         and    cic2.cost_type_id      = cct.cost_type_id
                        )
        ) src_org_costs,
        -- =================================================
        -- Get To Org Currency information
        -- =================================================
 -- Tables to get currency exchange rate information for the inventory orgs
 -- Select Currency Rates based on the currency conversion date and type
 -- ===========================================================================
(select gdr.* from gl_daily_rates gdr, gl_daily_conversion_types gdct where gdr.conversion_date=:p_conversion_date and gdct.user_conversion_type=:p_user_conversion_type and gdct.conversion_type=gdr.conversion_type) gdr
-- ============================================
-- Joins for inv orgs and curr to sourcing rules
-- ============================================
where   gdr.from_currency(+)            = item_sourcing.firstorg_src_currency
and     gdr.to_currency(+)              = item_sourcing.thirdorg_to_currency
-- ============================================
-- Joins for inv orgs and item costs
-- ============================================
and     to_org_costs.organization_id    = item_sourcing.thirdorg_to_org_id  -- get the To Org costs
and     to_org_costs.inventory_item_id  = item_sourcing.inventory_item_id   -- get the To Org costs
and     src_org_costs.organization_id   = item_sourcing.firstorg_src_org_id -- get the Source Org costs
and     src_org_costs.inventory_item_id = item_sourcing.inventory_item_id   -- get the Source Org costs
and     gl.ledger_id                    = item_sourcing.firstorg_src_ledger_id
-- ============================================
-- Change for version 1.17
-- Logic to not report where the firstorg_src_org
-- code equals the thirdorg_to_org code
-- ============================================
and     item_sourcing.firstorg_src_org <> item_sourcing.thirdorg_to_org
and     item_sourcing.thirdorg_to_org in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and     7=7                             -- p_from_org_code, p_to_org_code
-- Revision for version 1.35
and     9=9                             -- p_item_number
order by
        -- Revision for version 1.36
        -- gp.period_name, -- Period_Name
        item_sourcing.item_number, -- Item_Number
        item_sourcing.thirdorg_to_org, -- To_Org
        item_sourcing.firstorg_src_org -- Src_Org
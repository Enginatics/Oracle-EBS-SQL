/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Intercompany SO Price List vs. Item Cost Comparison
-- Description: Report to show the internal SO price lists, source org item costs and compare against the "To Org" item costs and PII (profit in inventory) amounts.  This report is used to ensure the profit in inventory (PII) cost model is working correctly.

Parameters:
===========
Price Effective Date: the date the sales order list prices are effective (mandatory).
Currency Conversion Date:  the exchange rate conversion date to use to convert the sales price to the same currency as the item cost (mandatory).
Currency Conversion Type:  the desired currency conversion type to use to convert the sales price to the same currency as the item cost (mandatory).
PII Cost Type:  the profit in inventory cost type you wish to report (mandatory).
PII Sub-Element:  the sub-element or resource for profit in inventory, such as PII or ICP (mandatory).
Assignment Set:  the set of sourcing rules to use with calculating the PII item costs (mandatory).
Cost Type:  the cost type to use for the item costs, such as Frozen or Pending (mandatory).
Category Set:  any item category you wish, typically the Cost or Product Line category set (optional).
Item Number:  enter the specific item numbers(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
To Org Code:  enter the specific To Org you wish to report (optional).
To Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
To Org Ledger:  enter the specific "To Org" ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2010 - 2024 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_so_price_cost_pii_rept.sql
-- | 
-- |  Version Modified on  Modified  by   Description
-- |  ======= =========== =========================================
-- |     1.0  26 Nov 2010 Douglas Volz    Created initial Report
-- |    1.18 13 Dec 2018 Douglas Volz     Add Source Org OU to the InterCo_OUs inline table, to ensure 
-- |                                      uniqueness.  Add Source Org joins for Src_Org item costs.
-- |                                      Removed Release 11i edits.  Replaced gl.name with gl.short_name.
-- |    1.19 17 Jun 2019 Douglas Volz     Replace Oracle function apps.qp_price_list_pvt.get_product_uom_code
-- |                                      with "and ucr.uom_code = qpa.product_uom_code".  Comment out Source
-- |                                      and To Org Added Costs columns.
-- |    1.20 21 Aug 2019 Douglas Volz     Removed client-specific SQL logic.
-- |    1.21 25 Oct 2019 Douglas Volz     Correction to p_price_effective_date parameter
-- |    1.22 17 Jul 2022 Douglas Volz     Changes for multi-language lookup values.  Changed
-- |                                      back to Oracle QP price packages, to get price list
-- |                                      information based on both category or item-specific price lists.
-- |    1.23 28 Nov 2023 Andy Haack       Added G/L security for the "To Org" G/L and removed tabs.
-- |    1.24 06 Feb 2024 Douglas Volz     Fix for G/L Daily Rates and add "To Org" inventory security.
-- |    1.25 25 Jun 2024 Douglas Volz     Reinstall missing parameters, Item Number and To Operating Unit.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-intercompany-so-price-list-vs-item-cost-comparison/
-- Library Link: https://www.enginatics.com/reports/cac-intercompany-so-price-list-vs-item-cost-comparison/
-- Run Report: https://demo.enginatics.com/

select  rpt.Source_Ledger Source_Ledger,
        rpt.Source_Operating_Unit Source_Operating_Unit,
        rpt.Source_Org Source_Org,
        rpt.Assignment_Set Assignment_Set,
        rpt.Sourcing_Rule Sourcing_Rule,
        rpt.Item_Number Item_Number,
        rpt.Item_Description Item_Description,
        rpt.Uom_Code UOM_Code,
        rpt.Item_Status Item_Status,
        rpt.item_type Item_Type,
        rpt.Source_Make_Buy_Code Source_Make_Buy_Code,
        rpt.To_Org_Make_Buy_Code To_Org_Make_Buy_Code,
        rpt.Category_Set Category_Set,
        rpt.Source_Category Source_Category,
        rpt.To_Org_Category To_Org_Category,
        rpt.Source_Price_List_Name Source_Price_List_Name,
        rpt.Price_Currency_Code Price_Currency_Code,
        rpt.List_Price_in_Primary_UOM List_Price_in_Primary_UOM, 
        :p_conversion_date Currency_Conversion_Date,
        round(nvl(Price_gdr.conversion_rate,1),6) Currency_Conversion_Rate,
        rpt.To_Org_Currency_Code To_Org_GL_Currency_Code,
        round(rpt.List_Price_in_Primary_UOM * nvl(Price_gdr.conversion_rate,1),5) Converted_Source_List_Price,
        rpt.Source_Currency_Code Source_Currency_Code,
        rpt.Source_Item_Cost Source_Item_Cost,
        :p_conversion_date To_Org_Currency_Conv_Date,
        round(nvl(To_Org_gdr.conversion_rate,1),6) To_Org_Currency_Conv_Rate,
        rpt.To_Org_Currency_Code To_Org_Currency_Code,
        round(rpt.Source_Item_Cost * nvl(To_Org_gdr.conversion_rate,1),5) Converted_Src_Item_Cost,
        round(rpt.List_Price_in_Primary_UOM * nvl(Price_gdr.conversion_rate,1),5) - 
                       round(rpt.Source_Item_Cost * nvl(To_Org_gdr.conversion_rate,1),5) Converted_Src_InterCo_Margin,
        rpt.Source_PII_Cost Source_PII_Cost,
        rpt.To_Org_Ledger To_Org_Ledger,
        rpt.To_Org_Operating_Unit To_Org_Operating_Unit,
        rpt.To_Org_Code To_Org,
        rpt.To_Org_Item_Cost To_Org_Item_Cost,
        round(rpt.List_Price_in_Primary_UOM * nvl(Price_gdr.conversion_rate,1),5) - rpt.To_Org_Item_Cost Source_Price_vs_To_Org_Cost,
        round(rpt.Source_Item_Cost * nvl(To_Org_gdr.conversion_rate,1),5) - rpt.To_Org_Item_Cost Src_Org_Cost_vs_To_Org_Cost,
        rpt.To_Org_PII_Cost To_Org_Prod_PII_Cost,
        rpt.Price_Start_Date Price_Start_Date,
        rpt.Price_Revision_Date Price_Revision_Date
        -- ===========================================================================
        -- Use one select statement to avoid outer joins with multiple tables 
        -- ===========================================================================
from    (select Src_Org.ledger Source_Ledger,
                Src_Org.operating_unit Source_Operating_Unit,
                Src_Org.organization_code Source_Org,
                max(To_Org.assignment_set) Assignment_Set,
                To_Org.sourcing_rule Sourcing_Rule,
                List_Price.item_number Item_Number,
                List_Price.item_description Item_Description,
                Src_Org.primary_uom_code UOM_Code,
                Src_Org.item_status Item_Status,
                Src_Org.item_type Item_Type,
                -- To_Org.item_type To_Org_Item_Type,
                Src_Org.mb_code Source_Make_Buy_Code,
                To_Org.mb_code To_Org_Make_Buy_Code,
                -- Revision for version 1.22
                Src_Org.category_set_name Category_Set,
                Src_Org.prod_grp Source_Category,
                To_Org.prod_grp To_Org_Category,
                -- End revision for version 1.22
                List_Price.name Source_Price_List_Name,
                List_Price.currency_code Price_Currency_Code,
                List_Price.price_in_primary_uom List_Price_in_Primary_UOM, 
                To_Org.currency_code To_Org_Currency_Code,
                Src_Org.currency_code Source_Currency_Code,
                Src_Org.item_cost Source_Item_Cost, 
                Src_Org.pii_cost Source_PII_Cost,
                To_Org.ledger To_Org_Ledger,
                To_Org.operating_unit To_Org_Operating_Unit,
                To_Org.organization_code To_Org_Code,
                To_Org.item_cost To_Org_Item_Cost,
                To_Org.pii_cost To_Org_PII_Cost,
                List_Price.start_date Price_Start_Date,
                List_Price.revision_date Price_Revision_Date        
                -- ===========================================================================
                -- Tables to get the price list and selling operating units.  Use a table
                -- select statement to group by price_list_id and sell_organization_id 
                -- ===========================================================================
         -- Revision for version 1.14
         -- from (select hsu.price_list_id,
         from   (select nvl(hsu.price_list_id, hca.price_list_id) price_list_id,
                        mip.sell_organization_id,
                        -- Revision for version 1.18
                        mip.ship_organization_id
                        -- Fix for version 1.5
                        -- hz.party_name,
                        -- pv.vendor_name
                 from   hz_cust_site_uses_all hsu,           -- joins to intercompany relationships
                        mtl_intercompany_parameters mip,     -- intercompany ship (from) and sell to relationships
                        -- Fix for version 1.14
                        hz_cust_acct_sites_all hcs,
                        hz_cust_accounts hca
                        -- End revision for version 1.14
                        -- Fix for version 1.5
                        -- ar.hz_parties hz,
                        -- po_vendors pv,
                 where  mip.customer_site_id             = hsu.site_use_id            -- internal customer information
                 -- Fix for version 1.5
                 -- and    hca.party_id                     = hz.party_id
                 -- and    mip.vendor_id = pv.vendor_id
                 -- End fix for version 1.5
                 -- Revision for version 1.14
                 and    hca.cust_account_id              = hcs.cust_account_id
                 and    hcs.cust_acct_site_id            = hsu.cust_acct_site_id
                 -- and    hsu.price_list_id is not null
                 -- End revision for version 1.14 
                 -- Fix for version 1.4, the customer type is not set correctly for orgs 1xx
                 -- This condition was preventing the 1xx To Orgs from being selected
                 -- and    hca.customer_type                = 'I'  -- Internal Customers
                 group by
                        -- Revision for version 1.14
                        -- hsu.price_list_id,
                        nvl(hsu.price_list_id, hca.price_list_id),
                        mip.sell_organization_id,
                        -- Revision for version 1.18
                        mip.ship_organization_id
                         -- Fix for version 1.5
                        -- hz.party_name
                ) InterCo_OUs,        
                -- ===========================================================================
                -- Tables to get the most current list price based on the Price Effective Date
                -- ===========================================================================
                -- Revision for version 1.22, revert back
                -- Revision for version 1.16
                -- Hint to make the price list header the driving table
                -- (select    /*+ leading(ic_price_list)*/  
                (select qlh_b.list_header_id list_header_id,
                 -- End revision for version 1.22
                        qlh_tl.name name,
                        qlh_tl.description description,
                        msiv.concatenated_segments Item_number,
                        msiv.description item_description,
                        -- Revision for version 1.22
                        misv.inventory_item_status_code,
                        mucv.primary_uom_code,
                        -- End revision for version 1.22
                        msiv.inventory_item_id inventory_item_id,
                        msiv.organization_id validation_org_id,
                        qlh_b.currency_code currency_code,
                        qpll.operand price,
                        qpll.operand * mucv.conversion_rate price_in_primary_uom, 
                        max(qpll.start_date_active) start_date,
                        trunc(qpll.revision_date) revision_date
                 from   qp_list_headers_b qlh_b,
                        qp_list_headers_tl qlh_tl,
                        qp_list_lines qpll,
                        -- Revision for version 1.22, revert back to Oracle functions, remove qpa and revision 1.16
                        -- Revision for version 1.16
                        -- qp_pricing_attributes qpa,
                        -- Revision for version 1.16
                        -- Revision for version 1.13
                        -- (select hsu.price_list_id
                        --  from   ar.hz_cust_site_uses_all hsu,                   -- joins to intercompany relationships
                        --         inv.mtl_intercompany_parameters mip             -- interco ship (from) and sell to relationships     
                        --  where  mip.customer_site_id          = hsu.site_use_id -- internal customer information
                        --  and    hsu.price_list_id is not null
                        --  group by
                        --         hsu.price_list_id) ic_price_list,
                        (select distinct nvl(hsu.price_list_id, hca.price_list_id) price_list_id
                         from   mtl_intercompany_parameters mip,
                                hz_cust_site_uses_all hsu,
                                hz_cust_accounts hca,
                                hz_cust_acct_sites_all hcs
                         where  mip.customer_site_id             = hsu.site_use_id            -- internal customer information
                         and    hsu.cust_acct_site_id            = hcs.cust_acct_site_id
                         and    hcs.cust_account_id              = hca.cust_account_id
                         -- Revision for version 1.19
                         and nvl(hsu.price_list_id, hca.price_list_id) is not null
                        ) ic_price_list,
                        -- End revision for version 1.16
                        mtl_system_items_vl msiv,                            -- item master per the validation organization
                        mtl_uom_conversions_view mucv,                       -- item master UOM conversion view
                        -- Revision for version 1.22
                        mtl_item_status_vl misv
                 -- =======================================================
                 -- For the price lists, joins to the item master and UOM 
                 -- conversions. The price list may be in a different UOM 
                 -- than the primary UOM code.  The item costs are in the 
                 -- primary UOM code only.  Assume the uom_code is the same 
                 -- across all inventory organizations
                 -- =======================================================
                 where  mucv.inventory_item_id           = msiv.inventory_item_id
                 and    mucv.organization_id             = msiv.organization_id -- join to the validation org
                 -- Revision for version 1.22, revert back to Oracle pricing functions
                 -- Revision for version 1.19, eliminate joins to private functions
                 -- Will get one price qualifier row per inventory_item_id
                 -- and    msiv.inventory_item_id           = to_number(qpa.product_attr_value)
                 -- and    ucr.uom_code                     = qpa.product_uom_code
                 -- and    qpa.product_attr_value <> 'ALL'
                 -- Non-unique index on qpa.list_line_id and qpa.excluder_flag
                 -- and    qpa.list_line_id                 = qpll.list_line_id
                 -- and    qpa.excluder_flag                = 'N'
                 -- and    qpa.product_attribute_context    = 'ITEM'
                 -- Find the item master validation organizations
                 -- and    msiv.organization_id             = (select   max(to_number(ospa.parameter_value))
                 --                                            from  oe_sys_parameters_all ospa
                 --                                            where  ospa.parameter_code = 'MASTER_ORGANIZATION_ID'
                 --                                           )
                 -- End revision for version 1.19
                 -- =======================================================
                 -- Joins to the Price List, based on qp_price_list_lines_v
                 -- =======================================================
                 -- Revision for version 1.16 and 1.22
                 and    msiv.inventory_item_id           = qp_price_list_pvt.get_inventory_item_id(qpll.list_line_id)
                 and    msiv.organization_id             = qp_util.get_item_validation_org
                 and    mucv.uom_code                    = qp_price_list_pvt.get_product_uom_code(qpll.list_line_id) -- uom code
                 and    msiv.inventory_item_status_code  = misv.inventory_item_status_code
                 -- End revision for version 1.22
                 -- Revision for version 1.16 and 1.20, exclude inactive items
                 and    msiv.inventory_item_status_code <> 'Inactive'
                 and    qlh_b.list_header_id             = qlh_tl.list_header_id
                 -- Revision for version 1.11
                 -- and    qlh_tl.language                  = 'US'
                 and    qlh_tl.language                  = userenv('lang')
                 -- Revision for version 1.16
                 -- Non-unique index on qpll.list_line_type_code and qpll.modifier_level_code
                 and    qpll.list_line_type_code         = 'PLL'
                 and    qpll.modifier_level_code         = 'LINE'
                 and    qlh_b.list_header_id             = qpll.list_header_id
                 -- Revision for version 1.13, get price list Ids based on intercompany relationships
                 and    qlh_b.list_header_id             = ic_price_list.price_list_id
                 -- Avoid selecting inactive specific list prices (sales prices)
                 and    1=1                              -- p_price_effective_date
                 group by
                        qlh_b.list_header_id,                   -- list_header_id
                        qlh_tl.name,                            -- price_list
                        qlh_tl.description,                     -- price_list_description
                        msiv.concatenated_segments,             -- item number
                        msiv.description,                       -- item description
                        -- Revision for version 1.22
                        misv.inventory_item_status_code,        -- item status code
                        mucv.primary_uom_code,                  -- primary uom code
                        -- End revision for version 1.22
                        msiv.inventory_item_id,                 -- inventory_item_id
                        msiv.organization_id,                   -- validation_org_id
                        qlh_b.currency_code,                    -- price_curr_code
                        qpll.operand,                           -- price
                        qpll.operand * mucv.conversion_rate,    -- price_in_primary_uom 
                        QPLL.revision_date                      -- price_revision_date
                ) List_Price,
                -- =======================================================
                -- Get the source orgs, items and item cost information
                -- =======================================================
                (select nvl(gl.short_name, gl.name) ledger,
                        gl.ledger_id ledger_id,
                         gl.currency_code currency_code,
                        haou2.name operating_unit,
                        haou2.organization_id operating_unit_id,
                        mp.organization_code organization_code,
                        cic.organization_id src_organization_id,
                        -- Revision for version 1.16
                        srcg_rules.to_organization_id to_organization_id,
                        cic.inventory_item_id inventory_item_id,
                        msiv.primary_uom_code,
                        msiv.inventory_item_status_code item_status,
                        fcl.meaning item_type,
                        ml1.meaning mb_code,
                        -- Revision for version 1.22
                        mcs_tl.category_set_name,
                        -- Revision for version 1.15
                        -- gcc.segment5 prod_grp,
                        mc.category_concat_segs prod_grp,
                        -- End revision for version 1.15
                        -- End revision for version 1.22
                        nvl(cic.tl_material_overhead,0) tl_material_overhead_cost,
                        nvl(cic.tl_resource,0) tl_resource_cost,
                        nvl(cic.tl_outside_processing,0) tl_outside_processing_cost,
                        nvl(cic.tl_overhead,0) tl_overhead_cost,
                        nvl(cic.tl_material_overhead,0) + nvl(cic.tl_resource,0) + nvl(cic.tl_outside_processing,0) + nvl(cic.tl_overhead,0) tl_added_cost,
                        nvl(cic.item_cost,0) - nvl(cic.tl_material_overhead,0) - nvl(cic.tl_resource,0) - 
                                nvl(cic.tl_outside_processing,0) - nvl(cic.tl_overhead,0) net_item_cost,
                        nvl(cic.item_cost,0) item_cost,
                        nvl((select sum(cicd.item_cost)
                             from   cst_item_cost_details cicd,
                                    cst_cost_types cct,
                                    bom_resources br
                             where  cicd.cost_type_id      = cct.cost_type_id
                             and    4=4                    -- p_pii_cost_type, p_pii_sub_element
                             and    cicd.inventory_item_id = cic.inventory_item_id  -- get the source org item id
                             and    cicd.organization_id   = cic.organization_id    -- get the source org id
                             and    cicd.resource_id       = br.resource_id
                            ),0)                                        pii_cost
                 -- =======================================================
                 -- Item, costs, organization and ledger tables
                 -- =======================================================
                 from   cst_item_costs cic,
                        cst_cost_types cct,
                        mtl_parameters mp,
                        mtl_system_items_vl msiv,
                        -- Revision for version 1.15
                        mtl_categories_v mc,
                        mtl_item_categories mic,
                        mtl_category_sets_b mcs,
                        mtl_category_sets_tl mcs_tl,
                        -- End revision for version 1.15
                        -- Revision for version 1.17
                        -- Add in the item master source organizations
                        -- Revision for version 1.16
                        -- Limit the source org costs by sourcing rule
                        -- mrp_sr_source_org msso,
                        -- mrp_sr_receipt_org msro,
                        -- mrp_sourcing_rules msr,
                        -- mrp_sr_assignments msa,
                        -- mrp_assignment_sets mas,
                        -- End revision for version 1.16
                        -- =======================================================
                        -- Revision for version 1.17
                        -- Get both sourcing rules and item master source org
                        -- information.  Missing lots of sourcing rules.
                        -- =======================================================
                        (select msa.organization_id to_organization_id,
                                msso.source_organization_id src_organization_id,
                                msa.inventory_item_id inventory_item_id
                         from   mrp_sr_source_org msso,
                                mrp_sr_receipt_org msro,
                                -- Revision for version 1.24, remove unneeded joins
                                -- mrp_sourcing_rules msr,
                                mrp_sr_assignments msa,
                                mrp_assignment_sets mas
                         where  msso.sr_receipt_id              = msro.sr_receipt_id
                         -- Revision for version 1.24, remove unneeded joins
                         -- and    msr.sourcing_rule_id            = msro.sourcing_rule_id
                         -- and    msa.sourcing_rule_id            = msr.sourcing_rule_id
                         and    msa.sourcing_rule_id            = msro.sourcing_rule_id
                         -- End revision for version 1.24
                         -- Client only has one Assignment Set
                         and    5=5                             -- p_assignment_set
                         and    msa.assignment_set_id           = mas.assignment_set_id
                         -- exclude vendor sourcing rules
                         and    msso.source_organization_id is not null
                         union all
                         select msiv.organization_id to_organization_id,
                                msiv.source_organization_id src_organization_id,
                                msiv.inventory_item_id inventory_item_id
                         from   mtl_system_items_vl msiv,
                                mtl_parameters inv_to_org,
                                mtl_parameters inv_src_org
                         where  msiv.source_organization_id is not null
                         and    msiv.organization_id           = inv_to_org.organization_id
                         and    msiv.source_organization_id    = inv_src_org.organization_id
                         -- Revision for version 1.20
                         and    msiv.inventory_item_status_code <> 'Inactive'
                         and    msiv.organization_id          <> inv_to_org.master_organization_id
                         and    msiv.source_organization_id   <> inv_src_org.master_organization_id
                         and    (msiv.organization_id,msiv.source_organization_id,msiv.inventory_item_id) not in
                                        (
                                         select msa.organization_id,msso.source_organization_id,msa.inventory_item_id
                                         from   mrp_sr_source_org msso,
                                                mrp_sr_receipt_org msro,
                                                -- Revision for version 1.24, remove unneeded joins
                                                -- mrp_sourcing_rules msr,
                                                mrp_sr_assignments msa,
                                                mrp_assignment_sets mas
                                         where  msso.sr_receipt_id            = msro.sr_receipt_id
                                         -- Revision for version 1.24, remove unneeded joins
                                         -- and    msr.sourcing_rule_id          = msro.sourcing_rule_id
                                         -- and    msa.sourcing_rule_id          = msr.sourcing_rule_id
                                         and    msa.sourcing_rule_id          = msro.sourcing_rule_id
                                         -- End revision for version 1.24
                                         -- Client only has one Assignment Set
                                         and    5=5                           -- p_assignment_set
                                         and    msa.assignment_set_id         = mas.assignment_set_id
                                         and    msiv.organization_id          = msa.organization_id
                                         and    msiv.inventory_item_id        = msa.inventory_item_id
                                         and    msso.source_organization_id is not null
                                         -- ====================================
                                         -- Material Parameter joins for to_org
                                         -- ====================================
                                         and    msa.organization_id           = inv_to_org.organization_id
                                         and    msso.source_organization_id   = inv_src_org.organization_id
                                        )
                        ) srcg_rules,
                        -- End for revision 1.17
                        -- Revision for version 1.15
                        -- gl_code_combinations gcc,
                        hr_organization_information hoi,
                        hr_all_organization_units_vl haou,
                        hr_all_organization_units_vl haou2,
                        gl_ledgers gl,
                        mfg_lookups ml1,
                        fnd_common_lookups fcl
                 -- =======================================================
                 -- Organization, cost type, item cost and COGS acct joins
                 -- =======================================================
                 where  cct.cost_type_id                = cic.cost_type_id
                 and    6=6                             -- p_cost_type, p_category_set, p_item_number
                 and    cic.organization_id             = mp.organization_id
                 and    msiv.organization_id            = mp.organization_id
                 and    cic.inventory_item_id           = msiv.inventory_item_id
                 -- Revision for version 1.15
                 -- and    msiv.cost_of_sales_account      = gcc.code_combination_id
                 -- Revision for version 1.20
                 -- Revision for version 1.16
                 and    msiv.inventory_item_status_code <> 'Inactive'
                 -- End revision for version 1.20
                 -- =======================================================
                 -- Sourcing rule joins
                 -- =======================================================
                 and    msiv.organization_id            = srcg_rules.src_organization_id
                 and    msiv.inventory_item_id          = srcg_rules.inventory_item_id
                 -- =================================================
                 -- Revision for version 1.15
                 -- Joins for category product line values
                 -- =================================================
                 and    mcs.category_set_id             = mcs_tl.category_set_id
                 and    mcs_tl.language                 = userenv('lang')
                 and    mic.inventory_item_id           = msiv.inventory_item_id (+)
                 and    mic.organization_id             = msiv.organization_id  (+)
                 and    mic.category_id                 = mc.category_id
                 and    mic.category_set_id             = mcs.category_set_id
                 -- End revision for version 1.15
                 -- ===========================================
                 -- Organization joins to the HR org model
                 -- ===========================================
                 and    hoi.org_information_context     = 'Accounting Information'        -- for inventory orgs
                 and    hoi.organization_id             = mp.organization_id              -- joins for the inventory org
                 and    hoi.organization_id             = haou.organization_id            -- this gets the organization name
                 and    haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
                 and    gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
                 -- avoid selecting disabled inventory organizations
                 and    sysdate                                       < nvl(haou.date_to, sysdate +1)
                 -- Revision for version 1.11
                 -- Eliminate orgs not in use
                 and    mp.organization_id             <> mp.master_organization_id
                 -- =======================================================
                 -- joins for the Lookups Codes
                 -- =======================================================
                 and    ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
                 and    ml1.lookup_code                 = msiv.planning_make_buy_code
                 -- Lookup codes for item types
                 and    fcl.lookup_code (+)             = msiv.item_type
                 and    fcl.lookup_type (+)             = 'ITEM_TYPE'
                 -- Revision for version 1.11
                 -- and    mp.process_enabled_flag = 'N'-- Added to restrict only discrete orgs 11/3/14
                ) Src_Org,
                -- ===========================================================================
                -- Tables to get the "To-Org", items and costs based on the sourcing rules
                -- ===========================================================================
                (select nvl(gl.short_name, gl.name) ledger,
                        gl.ledger_id ledger_id,
                        gl.currency_code currency_code,
                        haou2.name operating_unit,
                        haou2.organization_id operating_unit_id,
                        mp.organization_code organization_code,
                        srcg_rules.to_organization_id to_organization_id,
                        srcg_rules.src_organization_id src_organization_id,
                        srcg_rules.assignment_set_name assignment_set,
                        srcg_rules.sourcing_rule_name sourcing_rule,
                        cic.inventory_item_id inventory_item_id,
                        msiv.primary_uom_code,
                        msiv.inventory_item_status_code item_status,
                        fcl.meaning item_type,
                        ml1.meaning mb_code,
                        ml2.meaning based_on_rollup,
                        -- Revision for version 1.15
                        -- gcc.segment5 prod_grp,
                        mc.category_concat_segs prod_grp,
                        -- End revision for version 1.15
                         nvl(cic.tl_material_overhead,0) tl_material_overhead_cost,
                        nvl(cic.tl_resource,0) tl_resource_cost,
                        nvl(cic.tl_outside_processing,0) tl_outside_processing_cost,
                        nvl(cic.tl_overhead,0) tl_overhead_cost,
                        nvl(cic.tl_material_overhead,0) + nvl(cic.tl_resource,0) + nvl(cic.tl_outside_processing,0) + nvl(cic.tl_overhead,0) tl_added_cost,
                        nvl(cic.item_cost,0) - nvl(cic.tl_material_overhead,0) - nvl(cic.tl_resource,0) - 
                                nvl(cic.tl_outside_processing,0) - nvl(cic.tl_overhead,0) net_item_cost,
                        nvl(cic.item_cost,0) item_cost,
                        nvl((select sum(cicd.item_cost)
                             from   cst_item_cost_details cicd,
                                    cst_cost_types cct,
                                    bom_resources br
                             where  cicd.cost_type_id      = cct.cost_type_id
                             and    4=4                    -- p_pii_cost_type, p_pii_sub_element
                             and    cct.cost_type          = '&p_pii_cost_type'                                         -- p_pii_cost_type
                             and    br.resource_code       = '&p_pii_sub_element'                                       -- p_pii_sub_element
                             and    cicd.inventory_item_id = cic.inventory_item_id  -- get the source org item id
                             and    cicd.organization_id   = cic.organization_id    -- get the source org id
                             and    cicd.resource_id       = br.resource_id
                            ),0)                                        pii_cost
                 -- =======================================================
                 -- Item, costs, organization and ledger tables
                 -- =======================================================
                 from   cst_item_costs cic,
                        cst_cost_types cct,
                        mtl_parameters mp,
                        mtl_system_items_vl msiv,
                        -- Revision for version 1.15
                        mtl_categories_v mc,
                        mtl_item_categories mic,
                        mtl_category_sets_b mcs,
                        mtl_category_sets_tl mcs_tl,
                        -- End revision for version 1.15
                        -- Revision for version 1.17
                        -- Add in the item master source organizations
                        -- mrp_sr_source_org msso,
                        -- mrp_sr_receipt_org msro,
                        -- mrp_sourcing_rules msr,
                        -- mrp_sr_assignments msa,
                        -- mrp_assignment_sets mas,
                        -- =======================================================
                        -- Revision for version 1.17
                        -- Get both sourcing rules and item master source org
                        -- information.  Missing lots of sourcing rules.
                        -- =======================================================
                        (select mas.assignment_set_name assignment_set_name,
                                msr.sourcing_rule_name sourcing_rule_name,
                                msa.organization_id to_organization_id,
                                msso.source_organization_id src_organization_id,
                                msa.inventory_item_id inventory_item_id
                         from   mrp_sr_source_org msso,
                                mrp_sr_receipt_org msro,
                                mrp_sourcing_rules msr,
                                mrp_sr_assignments msa,
                                mrp_assignment_sets mas
                         where  msso.sr_receipt_id              = msro.sr_receipt_id
                         and    msr.sourcing_rule_id            = msro.sourcing_rule_id
                         and    msa.sourcing_rule_id            = msr.sourcing_rule_id
                         -- Most clients only have one Assignment Set
                         and    5=5                             -- p_assignment_set
                         and    mas.assignment_set_name         = '&p_assignment_set'                          -- p_assignment_set
                         and    msa.assignment_set_id           = mas.assignment_set_id
                         -- exclude vendor sourcing rules
                         and    msso.source_organization_id is not null
                         union all
                         -- Revision for version 1.22
                         -- select   'None' assignment_set_name,
                         --         'None' sourcing_rule_name,
                         select ml.meaning assignment_set_name,
                                ml.meaning sourcing_rule_name,
                         -- End revision for version 1.22
                                msiv.organization_id to_organization_id,
                                msiv.source_organization_id src_organization_id,
                                msiv.inventory_item_id inventory_item_id
                         from   mtl_system_items_vl msiv,
                                mtl_parameters inv_to_org,
                                mtl_parameters inv_src_org,
                                -- Revision for version 1.22
                                mfg_lookups ml
                         where  msiv.source_organization_id is not null
                         and    msiv.organization_id           = inv_to_org.organization_id
                         and    msiv.source_organization_id    = inv_src_org.organization_id
                         and    msiv.inventory_item_status_code <>'Inactive'
                         -- Revision for version 1.22
                         and    ml.lookup_type                 = 'YES_NO_SYS'
                         and    ml.lookup_code                 = 2 -- None
                         -- End revision for version 1.22
                         and    msiv.organization_id          <> inv_to_org.master_organization_id
                         and    msiv.source_organization_id   <> inv_src_org.master_organization_id
                         and    (msiv.organization_id,msiv.source_organization_id,msiv.inventory_item_id) not in
                                        (select msa.organization_id,msso.source_organization_id,msa.inventory_item_id
                                         from   mrp_sr_source_org msso,
                                                mrp_sr_receipt_org msro,
                                                mrp_sourcing_rules msr,
                                                mrp_sr_assignments msa,
                                                mrp_assignment_sets mas
                                         where  msso.sr_receipt_id            = msro.sr_receipt_id
                                         and           msr.sourcing_rule_id          = msro.sourcing_rule_id
                                         and           msa.sourcing_rule_id          = msr.sourcing_rule_id
                                         -- Most clients only have one Assignment Set
                                         and           5=5                           -- p_assignment_set
                                         and           msa.assignment_set_id         = mas.assignment_set_id
                                         and           msiv.organization_id          = msa.organization_id
                                         and           msiv.inventory_item_id        = msa.inventory_item_id
                                         and           msso.source_organization_id is not null
                                         -- ===================================
                                         -- Material Parameter joins for to_org
                                         -- ====================================
                                         and           msa.organization_id           = inv_to_org.organization_id
                                         and           msso.source_organization_id   = inv_src_org.organization_id
                                        )
                        ) srcg_rules,
                        -- End for revision 1.17
                        hr_organization_information hoi,
                        hr_all_organization_units_vl haou,
                        hr_all_organization_units_vl haou2,
                        gl_ledgers gl,
                        -- Revision for version 1.15
                        -- gl_code_combinations gcc,
                        mfg_lookups ml1, 
                        mfg_lookups ml2,
                        fnd_common_lookups fcl
                 -- =======================================================
                 -- Organization, cost type, item cost and COGS acct joins
                 -- =======================================================
                 where  cct.cost_type_id                = cic.cost_type_id
                 and    6=6                             -- p_cost_type, p_category_set, p_item_number
                 and    cic.organization_id             = msiv.organization_id
                 and    cic.inventory_item_id           = msiv.inventory_item_id
                 and    mp.organization_id              = srcg_rules.to_organization_id  -- To_Org Organization Id
                 -- Revision for version 1.15
                 and    msiv.inventory_item_status_code <> 'Inactive'
                 -- End revision for version 1.20
                 -- =======================================================
                 -- Sourcing rule joins
                 -- =======================================================
                 and    msiv.organization_id            = srcg_rules.to_organization_id
                 and    msiv.inventory_item_id          = srcg_rules.inventory_item_id
                 -- ====================================
                 -- Item Master Lookup Code Joins
                 -- ====================================
                 and    msiv.planning_make_buy_code     = ml1.lookup_code
                 and    ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
                 and    ml2.lookup_code                 = cic.based_on_rollup_flag
                 and    ml2.lookup_type                 = 'SYS_YES_NO'
                 -- Lookup codes for item types
                 and    fcl.lookup_code (+)             = msiv.item_type
                 and    fcl.lookup_type (+)             = 'ITEM_TYPE'
                 -- =================================================
                 -- Revision for version 1.15
                 -- Joins for category product line values
                 -- =================================================
                 and    mcs.category_set_id             = mcs_tl.category_set_id
                 and    mcs_tl.language                 = userenv('lang')
                 and    mic.inventory_item_id           = msiv.inventory_item_id (+)
                 and    mic.organization_id             = msiv.organization_id  (+)
                 and    mic.category_id                 = mc.category_id
                 and    mic.category_set_id             = mcs.category_set_id
                 -- End revision for version 1.15
                 -- ====================================
                 -- Revision for version 1.15
                 -- Not applicable, client does not have product line accounting segment
                 -- Account code combination joins
                 -- ====================================
                 -- and    gcc.code_combination_id        = msiv.cost_of_sales_account
                 -- ===========================================
                 -- Organization joins to the HR org model
                 -- ===========================================
                 and    hoi.org_information_context    = 'Accounting Information'
                 and    hoi.organization_id            = mp.organization_id
                 and    hoi.organization_id            = haou.organization_id            -- this gets the organization name
                 and    haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
                 and    gl.ledger_id                   = to_number(hoi.org_information1) -- get the ledger_id
                 -- Revision for version 1.24
                 and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                 and    7=7                            -- p_to_org_ledger, p_to_org_code, p_to_operating_unit
                 -- =================================================
                 -- Don't pick up the master org - no transactions
                 -- =================================================
                 and    mp.organization_id            <> mp.master_organization_id
                 -- Revision for version 1.11
                 -- and mp.process_enabled_flag = 'N'--Added to restrict only discrete orgs 11/3/14
                ) To_Org
        -- =======================================================
        -- Joins for mtl_intercompany_parameters "Interco" to the
        -- To_Org operating unit, Src-Org operating unit and price lists
        -- =======================================================
        where  InterCo_OUs.sell_organization_id = To_Org.operating_unit_id   -- operating unit joins
        -- The SELL organization is the OU getting the goods from the SHIP organization/OU
        -- Revision for version 1.18
        and    InterCo_OUs.ship_organization_id = Src_Org.operating_unit_id   -- operating unit joins
        -- The SHIP organization is the OU sending the goods to the SELL organization/OU
        and    List_Price.list_header_id        = InterCo_OUs.price_list_id
        and    List_Price.inventory_item_id     = To_Org.inventory_item_id   -- joining to the validation item master
        -- =======================================================
        -- Source org joins for the org, item master and costs
        -- =======================================================
        and    Src_Org.inventory_item_id        = To_Org.inventory_item_id   -- joins to the To_Org item master
        and    Src_Org.src_organization_id      = To_Org.src_organization_id -- joins to sourcing rules from the To_Org
        -- Revision for version 1.16
        and    Src_Org.to_organization_id       = To_Org.to_organization_id
        -- Revision for version 1.11
        -- Group to reduce the number of rows
        group by
                Src_Org.ledger,
                Src_Org.operating_unit,
                Src_Org.organization_code,
                -- Revision for version 1.10
                -- To_Org.assignment_set,
                To_Org.sourcing_rule,
                List_Price.item_number,
                List_Price.item_description,
                Src_Org.primary_uom_code,
                Src_Org.item_status,
                Src_Org.item_type,
                Src_Org.mb_code,
                To_Org.mb_code,
                -- Revision for version 1.22
                Src_Org.category_set_name,
                Src_Org.prod_grp,
                To_Org.prod_grp,
                List_Price.name,
                List_Price.currency_code,
                List_Price.price_in_primary_uom, 
                To_Org.currency_code,
                Src_Org.currency_code,
                -- Revision for version 1.19
                -- Src_Org.tl_material_overhead_cost,
                -- Src_Org.tl_resource_cost,
                -- Src_Org.tl_outside_processing_cost,
                -- Src_Org.tl_overhead_cost,
                -- Src_Org.tl_added_cost,
                -- End revision for version 1.19
                Src_Org.item_cost, 
                To_Org.currency_code,
                Src_Org.pii_cost,
                To_Org.ledger,
                To_Org.operating_unit,
                To_Org.organization_code,
                -- Fix for version 1.5
                -- InterCo.party_name "Internal Customer",
                -- Revision for version 1.19
                -- To_Org.tl_material_overhead_cost,
                -- To_Org.tl_resource_cost,
                -- To_Org.tl_outside_processing_cost,
                -- To_Org.tl_overhead_cost,
                -- To_Org.tl_added_cost,
                -- End revision for version 1.19
                To_Org.item_cost,
                To_Org.pii_cost,
                List_Price.start_date,
                List_Price.revision_date
        ) rpt,
        -- ===========================================================================
        -- Tables to get currency exchange rate information for the Price List prices
        -- Select Currency Rates based on the currency conversion date
        -- ===========================================================================
        (select gdr.* from gl_daily_rates gdr, gl_daily_conversion_types gdct where gdr.conversion_date=:p_conversion_date and gdct.user_conversion_type=:p_user_conversion_type and gdct.conversion_type=gdr.conversion_type) Price_gdr,
        -- ===========================================================================
        -- Tables to get currency exchange rate information for the To_Org
        -- Select Currency Rates based on the currency conversion date
        -- ===========================================================================
        (select gdr.* from gl_daily_rates gdr, gl_daily_conversion_types gdct where gdr.conversion_date=:p_conversion_date and gdct.user_conversion_type=:p_user_conversion_type and gdct.conversion_type=gdr.conversion_type) To_Org_gdr
        -- End revision for version 1.24
        -- =======================================================
        -- Joins for the currency exchange rates for the Price Lists
        -- =======================================================
        where   Price_gdr.from_currency (+)      = rpt.Price_Currency_Code   -- price list currency code
        and     Price_gdr.to_currency (+)        = rpt.To_Org_Currency_Code  -- will translate prices into the "To_Org" currency
        -- =======================================================
        -- Joins for the currency exchange rates for the Src_Org
        -- =======================================================
        and     To_Org_gdr.from_currency (+)     = rpt.Source_Currency_Code  -- Source Org currency code
        and     To_Org_gdr.to_currency (+)       = rpt.To_Org_Currency_Code  -- will translate source costs into the "To_Org" currency
        -- End revision for version 1.24
order by
        rpt.source_ledger,
        rpt.source_operating_unit,
        rpt.source_org,
        rpt.item_number,
        rpt.to_org_ledger,
        rpt.to_org_operating_unit,
        rpt.to_org_code
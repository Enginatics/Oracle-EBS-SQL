/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Intercompany SO Price List
-- Description: Report to show the intercompany sales order (SO) price list information, including the item number, price list name and related information.  Price list parameter list of values are from the Intercompany Relationship Setups (from Oracle Inventory), per the price lists associated with the internal customers.

/* +=============================================================================+
-- |  Copyright 2010 - 2022 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_so_price_list_rept.sql
-- |
-- |  Parameters:
-- |  p_price_effective_date -- Date the sales order list prices are effective, mandatory.
-- |  p_price_list           -- Specific intercompany price list name to report
-- |  p_item_number          -- Specific item number you wish to report, optional.
-- |  p_category_set1        -- The first item category set to report, typically the
-- |                            Cost or Product Line Category Set
-- |  p_category_set2        -- The second item category set to report, typically the
-- |                            Inventory Category Set
-- | 
-- |  Description:
-- |  Report to show the SO price list information, including the item number, price
-- |  list name and related information.
-- | 
-- |  Version Modified on  Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |      1.0 19 Sep 2010 Douglas Volz   Created initial Report based on qp_price_list_lines_v
-- |      1.1 15 Dec 2010 Douglas Volz   Cleaned up report for BO Repository
-- |      1.2 22 Dec 2010 Douglas Volz   Fix for the Price End Date logic, change
-- |                                     sysdate to '&p_price_effective_date' to
-- |      1.3 01 Dec 2014 Douglas Volz   Add Item Type column
-- |      1.4 15 Oct 2018 Douglas Volz   Get price list Ids based on intercompany
-- |                                     relationships, as opposed to hard-coding
-- |      1.5 16 Oct 2018 Douglas Volz   And get prices from Customer default price
-- |                                     list from hz_cust_accounts
-- |      1.6 20 Nov 2018 Douglas Volz   Get Item Type from fnd_common_lookups as
-- |                                     fnd_lookup_values as a duplicate 'KIT'
-- |      1.7 11 Dec 2018 Douglas Volz   Avoid using the qp_price_list_pvt package,
-- |                                     to see if this is faster.  Use the query
-- |                                     to finding the price list headers as the
-- |                                     driving query or table, including the hint
-- |                                     to make the price list header the driving table
-- |      1.8 17 Jun 2019 Douglas Volz   Replace Oracle function 
-- |                                     apps.qp_price_list_pvt.get_product_uom_code
-- |                                     with "qpa.product_uom_code".
-- |      1.9 18 Sep 2019 Douglas Volz   Added item status column and item categories
-- |     1.10 09 Jul 2022 Douglas Volz   Changed back to Oracle QP price packages, to
-- |                                     get price list information based on both
-- |                                     categoryor item-specific price lists.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-intercompany-so-price-list/
-- Library Link: https://www.enginatics.com/reports/cac-intercompany-so-price-list/
-- Run Report: https://demo.enginatics.com/

select /*+ leading(price_lists)*/  
 -- Revision for version 1.10
 flv.meaning Price_List_Type, -- Intercompany
 qlh_tl.name Price_List_Name,
 qlh_tl.description Price_List_Description,
 qlh_b.currency_code Currency_Code,
 msiv.concatenated_segments Item_Number,
 msiv.description Item_Description,
 -- Revision for version 1.6
 fcl.meaning Item_Type,
 -- Revision for version 1.9 and 1.10
 misv.inventory_item_status_code Item_Status,
&category_columns
 -- Revision for version 1.10
 muomv.uom_code Primary_UOM_Code,
 -- qpa.product_uom_code Price_UOM_Code, 
 qp_price_list_pvt.get_product_uom_code(qpll.list_line_id) Price_UOM_Code, 
 -- End revision for version 1.10
 qpll.operand List_Price, 
 qpll.start_date_active Start_Date, 
 qpll.end_date_active End_Date,
 trunc(qpll.creation_date) Creation_Date
from ( -- Revision for version 1.4 and 1.7
  select distinct nvl(hsu.price_list_id, hca.price_list_id) price_list_id
  from mtl_intercompany_parameters mip,
  hz_cust_site_uses_all hsu,
  hz_cust_accounts hca,
  hz_cust_acct_sites_all hcs
  where  mip.customer_site_id             = hsu.site_use_id            -- internal customer information
  and hsu.cust_acct_site_id            = hcs.cust_acct_site_id
  and hcs.cust_account_id              = hca.cust_account_id
 ) price_lists,
 mtl_system_items_vl msiv,
 -- Revision for version 1.10
 mtl_item_status_vl misv,
 mtl_units_of_measure_vl muomv,
 fnd_lookup_values flv, -- SOURCE, Price_List Type
 -- End revision for version 1.10
 qp_list_headers_b qlh_b,
 qp_list_headers_tl qlh_tl,
 qp_list_lines qpll,
 -- Revision for version 1.10, reverse version 1.7
 -- Revision for version 1.7
 -- qp_pricing_attributes qpa,
 -- Revision for version 1.6
 fnd_common_lookups fcl -- Item_Type
where price_lists.price_list_id       = qlh_b.list_header_id
-- Revision for version 1.10, comment out changes from version 1.8
-- Will get one price qualifier row per inventory_item_id
-- and msiv.inventory_item_id          = to_number(qpa.product_attr_value)
-- Non-unique index on qpa.list_line_id and qpa.excluder_flag
-- and qpa.list_line_id                = qpll.list_line_id
-- and qpa.excluder_flag               = 'N'
-- and qpa.product_attribute_context   = 'ITEM'
-- Screen out invalid inventory item id
-- and qpa.product_attr_value <> 'ALL'
-- and msiv.organization_id            = (select max(to_number(ospa.parameter_value))
--       from oe_sys_parameters_all ospa
--       where ospa.parameter_code = 'MASTER_ORGANIZATION_ID')
-- End of commenting out changes from version 1.8
-- Revert back to packages from prior versions
and msiv.inventory_item_id          = qp_price_list_pvt.Get_Inventory_Item_Id(qpll.list_line_id)
-- Get the inventory master organization from the Order Mgmt setups
and msiv.organization_id            = qp_util.Get_Item_Validation_Org
and msiv.primary_uom_code           = muomv.uom_code
and msiv.inventory_item_status_code = misv.inventory_item_status_code
and flv.lookup_type                 = 'SOURCE'
and flv.lookup_code                 = 'Intercompany'
and flv.language                    = userenv('lang')
-- End revision for version 1.10
-- Revision for version 1.7
-- Exclude inactive items
and msiv.inventory_item_status_code <> 'Inactive'
and qlh_b.list_header_id            = qpll.list_header_id
and qlh_b.list_header_id            = qlh_tl.list_header_id
and qlh_tl.language                 = userenv('lang')
-- Non-unique index on qpll.list_line_type_code and qpll.modifier_level_code
and qpll.list_line_type_code        = 'PLL'
and qpll.modifier_level_code        = 'LINE'
-- Revision for version 1.6
and fcl.lookup_code (+)             = msiv.item_type
and fcl.lookup_type (+)             = 'ITEM_TYPE'
and 1=1
order by
 qlh_tl.name, -- Price_List_Name
 msiv.concatenated_segments -- Item_Number
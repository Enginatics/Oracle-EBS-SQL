/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Intercompany SO Price List
-- Description: Report to show the intercompany sales order (SO) price list information, including the item number, price list name and related information. Price list parameter list of values are from the Intercompany Relationship Setups (from Oracle Inventory), per the price lists associated with the internal customers.
-- / +=============================================================================+
-- -- | Copyright 2010 - 2022 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxsopricelistrept.sql
-- -- |
-- -- | Parameters:
-- -- | ppriceeffectivedate -- Date the sales order list prices are effective, mandatory.
-- -- | ppricelist -- Specific intercompany price list name to report
-- -- | pitemnumber -- Specific item number you wish to report, optional.
-- -- | pcategoryset1 -- The first item category set to report, typically the
-- -- | Cost or Product Line Category Set
-- -- | pcategoryset2 -- The second item category set to report, typically the
-- -- | Inventory Category Set
-- -- |
-- -- | Description:
-- -- | Report to show the SO price list information, including the item number, price
-- -- | list name and related information.
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 19 Sep 2010 Douglas Volz Created initial Report based on qppricelistlinesv
-- -- | 1.1 15 Dec 2010 Douglas Volz Cleaned up report for BO Repository
-- -- | 1.2 22 Dec 2010 Douglas Volz Fix for the Price End Date logic, change
-- -- | sysdate to '&ppriceeffectivedate' to
-- -- | 1.3 01 Dec 2014 Douglas Volz Add Item Type column
-- -- | 1.4 15 Oct 2018 Douglas Volz Get price list Ids based on intercompany
-- -- | relationships, as opposed to hard-coding
-- -- | 1.5 16 Oct 2018 Douglas Volz And get prices from Customer default price
-- -- | list from hzcustaccounts
-- -- | 1.6 20 Nov 2018 Douglas Volz Get Item Type from fndcommonlookups as
-- -- | fndlookupvalues as a duplicate 'KIT'
-- -- | 1.7 11 Dec 2018 Douglas Volz Avoid using the qppricelistpvt package,
-- -- | to see if this is faster. Use the query
-- -- | to finding the price list headers as the
-- -- | driving query or table, including the hint
-- -- | to make the price list header the driving table
-- -- | 1.8 17 Jun 2019 Douglas Volz Replace Oracle function
-- -- | apps.qppricelistpvt.getproductuomcode
-- -- | with "qpa.productuomcode".
-- -- | 1.9 18 Sep 2019 Douglas Volz Added item status column and item categories
-- -- | 1.10 09 Jul 2022 Douglas Volz Changed back to Oracle QP price packages, to
-- -- | get price list information based on both
-- -- | categoryor item-specific price lists.
-- -- | 1.11 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-intercompany-so-price-list/
-- Library Link: https://www.enginatics.com/reports/cac-intercompany-so-price-list/
-- Run Report: https://demo.enginatics.com/

select
xxen_util.meaning('Intercompany','SOURCE',200) price_list_type,
qlhv.name price_list_name,
qlhv.description price_list_description,
qlhv.currency_code,
msiv.concatenated_segments item_number,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
msiv.inventory_item_status_code item_status,
&category_columns
msiv.primary_uom_code,
qllv.product_uom_code price_uom_code,
qllv.operand list_price,
qllv.start_date_active start_date,
qllv.end_date_active end_date,
trunc(qllv.creation_date) creation_date
from
qp_list_headers_vl qlhv,
qp_list_lines_v qllv,
mtl_system_items_vl msiv
where
1=1 and
qlhv.list_header_id in
(
select
nvl(hcsua.price_list_id,hca.price_list_id)
from
mtl_intercompany_parameters mip,
hz_cust_site_uses_all hcsua,
hz_cust_acct_sites_all hcasa,
hz_cust_accounts hca
where
mip.customer_site_id=hcsua.site_use_id and
hcsua.cust_acct_site_id=hcasa.cust_acct_site_id and
hcasa.cust_account_id=hca.cust_account_id
) and
qlhv.list_header_id=qllv.list_header_id and
qllv.list_line_type_code='PLL' and
qllv.modifier_level_code='LINE' and
qllv.product_attribute_context='ITEM' and
qllv.product_attribute='PRICING_ATTRIBUTE1' and
to_number(qllv.product_attr_value)=msiv.inventory_item_id and
qp_util.get_item_validation_org=msiv.organization_id and
msiv.inventory_item_status_code<>'Inactive'
order by
price_list_name,
item_number

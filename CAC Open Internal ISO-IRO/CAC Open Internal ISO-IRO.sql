/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Open Internal ISO-IRO
-- Description: Report to display the open internal sales orders and requisition numbers, with aging dates and other useful information.

/* +=============================================================================+
-- |  Copyright 2009 - 2022 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_open_iro.sql
-- |
-- |  Parameters:
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |  p_category_set1    -- The first item category set to report, typically the
-- |                        Cost or Product Line Category Set
-- |  p_category_set2    -- The second item category set to report, typically the
-- |                        Inventory Category Set
-- |
-- |  Description:
-- |  Report to display the open internal sales orders and requisition numbers, 
-- |  with aging dates and other useful information.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     12 Nov 2009 Douglas Volz   Initial Coding for Client
-- |  1.1     01 Sep 2010 Douglas Volz   Added Ledger and Operating Unit info
-- |                                     Added condition to avoid old pre-conversion orgs
-- |  1.2     30 Mar 2011 Douglas Volz   Added condition to avoid disabled orgs,
-- |                                     added Ledger parameter
-- |  1.3     18 Nov 2012 Douglas Volz   Removed client-specific org conditions
-- |  1.4     16 Jan 2020 Douglas Volz   Added org code, operating unit parameters
-- |                                     category set parameters, item type and status.
-- |  1.5     09 Apr 2020 Douglas Volz   Replaced tables for multi-language capabilities:
-- |                                     mtl_system_items with mtl_system_items_vl
-- |                                     mtl_categories_b with mtl_categories_vl
-- |                                     hr_all_organization_units with hr_all_organization_units_vl
-- |  1.6     07 Jul 2022 Douglas Volz   Replace with multi-lang item status and UOM_Codes.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-open-internal-iso-iro/
-- Library Link: https://www.enginatics.com/reports/cac-open-internal-iso-iro/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Ship_From_Org,
 mp2.organization_code Ship_To_Org,
 msiv.concatenated_segments Item_Number,
 msiv.description Item_Description,
 -- Revision for version 1.4 and 1.7
 muomv.uom_code UOM_Code,
 fcl.meaning Item_Type,
 misv.inventory_item_status_code Item_Status,
 ml1.meaning Make_Buy_Code,
&category_columns
 hz.party_name Customer,
 hca.account_number Customer_Number,
 iso.order_number Sales_Order_Number,
 iso_line.line_number SO_Line,
 decode(iso.order_source_id, 10, iso.orig_sys_document_ref, '') Requisition_Number,
 fu_iso.user_name IRO_Created_By,
 fu_iso2.user_name IRO_Last_Updated_By,
 ottt.name Order_Type,
 iso_line.flow_status_code Status,
 hz.address1 Address_Line_1,
 hz.address2 Address_Line_2,
 hsu.location Location_Number,
 hl.city City,
 hl.state State,
 hl.county County,
 hl.country Country,
 trunc(iso_line.creation_date) Creation_Date,
 trunc(iso_line.request_date) Request_Date,
 trunc(iso_line.promise_date) Promise_Date,
 trunc((sysdate - iso.request_date)) Days_Outstanding,
 case 
  when (sysdate - iso.request_date) < 31  then '30 days'
  when (sysdate - iso.request_date) < 61  then '31 to 60 days'
  when (sysdate - iso.request_date) < 91  then '61 to 90 days'
  when (sysdate - iso.request_date) < 121 then '91 to 120 days'
  when (sysdate - iso.request_date) < 151 then '121 to 150 days'
  when (sysdate - iso.request_date) < 181 then '151 to 180 days'
   else 'Over 180 days'
 end Aging_Date,
 iso_line.ORDER_QUANTITY_UOM Order_UOM,
 iso_line.ordered_quantity Ordered_Quantity,
 gl.currency_code Currency_Code,
 cic.item_cost Unit_Cost,
 round(iso_line.ordered_quantity * cic.item_cost,2) COGS_Amount
from mtl_system_items_vl msiv,
 -- Revision for version 1.6
 mtl_item_status_vl misv,
 mtl_units_of_measure_vl muomv,
 -- End revision for version 1.6
 cst_item_costs cic,    
 oe_order_headers_all iso,  
 oe_order_lines_all iso_line,  
 oe_transaction_types_tl ottt,
 po_requisition_headers_all prh,   
 po_requisition_lines_all prl,
 mtl_parameters mp,    
 mtl_parameters mp2,
 -- Revision for version 1.4
 fnd_common_lookups fcl,
 -- Revision for version 1.6
 mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
 fnd_user fu_iso,
 fnd_user fu_iso2,
 hz_cust_accounts_all hca,
 hz_cust_acct_sites_all hcs,
 hz_cust_site_uses_all hsu,
 hz_parties hz,
 hz_party_sites hps,
 hz_locations hl,
 -- fix for version 1.1
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 gl_ledgers gl    
-- =============================================
-- Internal order, item, cost and org joins
-- =============================================
where iso_line.open_flag              = 'Y'
and msiv.inventory_item_id          = iso_line.inventory_item_id  
and msiv.organization_id            = iso_line.ship_from_org_id
-- Revision for version 1.6
and msiv.primary_uom_code           = muomv.uom_code
and msiv.inventory_item_status_code = misv.inventory_item_status_code
-- End revision for version 1.6
and msiv.inventory_item_id          = cic.inventory_item_id  
and msiv.organization_id            = cic.organization_id
-- Revision for version 1.6
and cic.cost_type_id                = mp.primary_cost_method     
and iso_line.line_category_code in ('ORDER')
-- use this condition to limit this sql for internal requisitions
and iso_line.order_source_id        = 10 -- internal requisitions
and iso.header_id                   = iso_line.header_id
and iso_line.line_type_id           = ottt.transaction_type_id  
and ottt.language                   = userenv('lang')
and mp.organization_id              = msiv.organization_id
-- Revision for version 1.3
-- Avoid selecting disabled inventory organizations
and sysdate                         <  nvl(haou.date_to, sysdate +1)
-- =============================================
-- Use these conditions to join to purchase reqs
-- =============================================
and prh.type_lookup_code            = 'INTERNAL'
and iso.source_document_id          = prh.requisition_header_id
and prl.requisition_header_id       = prh.requisition_header_id
and prl.requisition_line_id         = iso_line.source_document_line_id
and mp2.organization_id             = prl.DESTINATION_organization_id
and fu_iso.user_id                  = prh.created_by
and fu_iso2.user_id                 = prh.last_updated_by
-- =============================================
-- Lookup codes for item types
and fcl.lookup_code (+)             = msiv.item_type
and fcl.lookup_type (+)             = 'ITEM_TYPE'
-- Revision for version 1.6
and ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and ml1.lookup_code                 = msiv.planning_make_buy_code
-- =============================================
 -- added for customer ship-to-information
 -- and replaces use of ra_customers
 -- d.volz 6-Oct-08
and iso_line.sold_to_org_id         = hca.cust_account_id
and iso_line.Ship_to_org_id         = hsu.site_use_id
and hcs.cust_acct_site_id           = hsu.cust_acct_site_id
and hca.cust_account_id             = hcs.cust_account_id
and hca.party_id                    = hz.party_id
and hcs.party_site_id               = hps.party_site_id
and hps.location_id                 = hl.location_id
-- =============================================
-- Organization joins to the HR org model
-- Fix for version 1.1
-- =============================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id   -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
-- =============================================
-- Parameters, revision for version 1.1 and 1.4
-- =============================================
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                             -- p_item number, p_org_code, p_operating Unit, p_ledger
-- Order by Ledger, Operating_Unit, Ship From, Ship To, Item, customer, order number and order line
order by 
 nvl(gl.short_name, gl.name), -- Ledger
 haou2.name, --  Operating_Unit
 mp.organization_code, --  Ship_From_Org
 mp2.organization_code, --  Ship_To_Org
 msiv.concatenated_segments, --  Item_Number
 hz.party_name, --  Customer
 iso.order_number, --  SO Number
 iso_line.line_number --  SO Line
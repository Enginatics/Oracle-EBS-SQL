/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Shipping Networks Missing Interco OU Relationships
-- Description: Report to show the missing inventory intercompany operating unit relationships.  This report has no parameters.

/* +=============================================================================+
-- |  Copyright 2009 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_missing_interco_setups_for_shipping_networks_v1.sql
-- |
-- |  Parameters:
-- |  None
-- | 
-- |  Description:
-- |  Report to show the missing inventory intercompany operating unit relationships.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     16 Oct 2018 Douglas Volz   Initial Coding
-- |  1.1     11 Apr 2019 Douglas Volz   Revert to Release 12
-- |  1.2     29 Apr 2020 Douglas Volz   Changed to multi-language views for the 
-- |                                     inventory orgs and operating units.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-shipping-networks-missing-interco-ou-relationships/
-- Library Link: https://www.enginatics.com/reports/cac-shipping-networks-missing-interco-ou-relationships/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
 haou2.name From_Operating_Unit,
 mp.organization_code From_Org_Code,
 mp.organization_name From_Org_Name,
 -- Revision for version 1.9
 haou3.name To_Operating_Unit,
 mp2.organization_code To_Org_Code,
 -- Revision for version 1.2
 intransit_type.meaning Intransit_Type,
 ml1.meaning FOB_Point,
 ml2.meaning Internal_Order_Required,
 fl1.meaning Elemental_Visibility,
 fl2.meaning Manual_Receipt_at_Expense_Dest
 -- End revision for version 1.2
from mtl_interorg_parameters mip,
 org_organization_definitions mp,
 mtl_parameters mp2,
 -- Revision for version 1.2
 -- Compound join, as the Shipping Network Form
 -- INVSDOSI is hard-coded to 'Direct' and 'Intransit'
 (select 2 lookup_code,
  ml.meaning
  from mfg_lookups ml
  where ml.lookup_type  = 'MSC_CALENDAR_TYPE'
  and ml.lookup_code  = '3' -- Intransit 
  union
  select 1 lookup_code,
  fl.meaning
  from fnd_lookups fl
  where fl.lookup_type  = 'PV_PURCHASE_METHOD'
  and fl.lookup_code  = 'DIRECT'
 ) intransit_type,
 mfg_lookups ml1,  -- FOB_POINT
 mfg_lookups ml2, -- internal order required, SYS_YES_NO
 fnd_lookups fl1, -- elemental visibility, YES_NO
 fnd_lookups fl2, -- manual receipt expense, YES_NO
 -- End revision for version 1.2
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,
 hr_all_organization_units_vl haou2,
 hr_organization_information hoi2,
 hr_all_organization_units_vl haou3,
 -- Revert to Release 12
 -- Retrofit to Release 11i
 gl_ledgers gl
 -- gl_sets_of_books gl
 -- End revision for retrofit to Release 11i
where mip.from_organization_id     = mp.organization_id
and mip.to_organization_id       = mp2.organization_id
 -- Revision for version 1.2
and intransit_type.lookup_code   = mip.intransit_type
and ml1.lookup_type (+)          = 'MTL_FOB_POINT'
and ml1.lookup_code (+)          = mip.fob_point
and ml1.lookup_type (+)          = 'FOB_POINT'
and ml2.lookup_code (+)          = mip.internal_order_required_flag
and ml2.lookup_type (+)          = 'SYS_YES_NO'
and fl1.lookup_type (+)          = 'YES_NO'
and fl1.lookup_code (+)          = mip.elemental_visibility_enabled
and fl2.lookup_type (+)          = 'YES_NO'
and fl2.lookup_code (+)          = mip.manual_receipt_expense
 -- End revision for version 1.2
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context  = 'Accounting Information'
and hoi.organization_id          = mp.organization_id
and hoi.organization_id          = haou.organization_id -- this gets the organization name
and haou2.organization_id        = to_number(hoi.org_information3) -- this gets the operating unit id
-- Revert to Release 12
-- Revision for Retrofit to Release 11i
and gl.ledger_id                 = to_number(hoi.org_information1) -- get the ledger_id
-- and gl.set_of_books_id            = to_number(hoi.org_information1) -- get the ledger_id
-- End revision for Retrofit to Release 11i
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
-- Add in the To-Org Operating_Unit
and hoi2.org_information_context = 'Accounting Information'
and hoi2.organization_id         = mp2.organization_id
and haou3.organization_id        = to_number(hoi2.org_information3) -- this gets the operating unit id
and haou2.name                  <> haou3.name
and not exists
 (select 'x'
  from mtl_intercompany_parameters mip,
  hr_organization_units hou1, 
  hr_organization_units hou2, 
  po_vendors pv, 
  po_vendor_sites_all pvs, 
  (select cust_account_id customer_id , 
   party.party_name customer_name , 
   cust_acct.account_number customer_number,
   cust_acct.price_list_id price_list_id 
   from hz_parties party, 
   hz_cust_accounts cust_acct 
   where cust_acct.party_id = party.party_id
  ) rc, 
  ra_cust_trx_types_all rctta, 
  hz_cust_site_uses_all rsua,
  qp_list_headers_tl qlh_tl
  where hou1.organization_id            = mip.ship_organization_id 
  and hou2.organization_id            = mip.sell_organization_id 
  and pv.vendor_id (+)                = mip.vendor_id 
  and pvs.vendor_site_id (+)          = mip.vendor_site_id 
  and pvs.org_id (+)                  = mip.sell_organization_id 
  and rc.customer_id                  = mip.customer_id 
  and rsua.cust_acct_site_id          = mip.address_id 
  and rsua.site_use_id                = mip.customer_site_id 
  and rctta.cust_trx_type_id          = mip.cust_trx_type_id 
  and rctta.org_id                    = mip.ship_organization_id
  and qlh_tl.list_header_id           = nvl(rsua.price_list_id, RC.price_list_id)
  and qlh_tl.language                 = userenv('lang')
  and (hou1.name||hou2.name)          = (haou2.name||haou3.name)
 )
-- order by Ledger, Operating_Unit, From_Org_Code, To_Operating_Unit, To_Org_Code
order by 1,2,3,5,6
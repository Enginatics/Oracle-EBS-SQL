/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Intercompany Relationship Setup
-- Description: Report to show accounts used for the intercompany parameters and relationships across operating units.

/* +=============================================================================+
-- |  Copyright 2018 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_interco_parameters_rept.sql
-- |
-- |  Parameters:
-- |  none
-- |
-- |  Description:
-- |  Report to show accounts used for the intercompany parameters and relationships
-- |  across operating units.
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     16 Oct 2018 Douglas Volz   Initial Coding, based on mtl_intercompany_parameters_v
-- |  1.1      7 Mar 2020 Douglas Volz   Add Advanced Accounting Option based on view
-- |                                     mtl_transaction_flows_v.
-- |  1.2     27 Apr 2020 Douglas Volz   Changed to multi-language views for the
-- |                                     inventory orgs and operating units.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-intercompany-relationship-setup/
-- Library Link: https://www.enginatics.com/reports/cac-intercompany-relationship-setup/
-- Run Report: https://demo.enginatics.com/

select hou1.name From_Ship_Operating_Unit,
 hou2.name To_Sell_Operating_Unit,
 -- Revision for version 1.1
 -- null Adv Acctg,
 -- null Ship_From/To_Org,
 -- null Details Req'd,
 fl.meaning Advanced_Accounting,
 mp.organization_code Ship_From_To_Org,
 -- End revision for version 1.1
 ml.meaning Flow_Type,
 rc.customer_name Customer_Name,
 rc.customer_number Customer_Number,
 qlh_tl.name Price_List,
 rsua.location Location,
 rctta.name Receivables_Transaction_Type,
 gcc_ic_cogs.concatenated_segments InterCompany_COGS,
 -- Revision for version 1.1
 decode(mip.inv_currency_code,
  1, 'Currency Code of From_Operating_Unit',
  2, 'Currency Code of To_Operating_Unit',
  3, 'Currency Code of Order',
  '') Currency_Setting,
 -- End revision for version 1.1
 pv.vendor_name Supplier,
 pvs.vendor_site_code Supplier_Site,
 gcc_frt.concatenated_segments Freight_Account,
 gcc_ia.concatenated_segments Inventory_Accrual_Account,
 gcc_ea.concatenated_segments Expense_Accrual_Account,
 -- Revision for version 1.1
 mip.last_update_date Last_Update_Date
from mtl_intercompany_parameters mip,
 hr_all_organization_units_vl hou1,
 hr_all_organization_units_vl hou2,
 -- Revision for version 1.1
 mtl_transaction_flow_headers mtfh, 
 mtl_transaction_flow_lines mtfl, 
 mtl_parameters mp,
 fnd_lookups fl, -- advanced accounting, YES_NO
 mfg_lookups ml, -- Flow_Type, INV_TRANSACTION_FLOW_TYPE
 -- End revision for version 1.1
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
 qp_list_headers_tl qlh_tl,
 -- G/L Accounts
 gl_code_combinations_kfv gcc_ic_cogs,
 gl_code_combinations_kfv gcc_frt,
 gl_code_combinations_kfv gcc_ia,
 gl_code_combinations_kfv gcc_ea
where hou1.organization_id                = mip.ship_organization_id
and hou2.organization_id                = mip.sell_organization_id
-- Revision for version 1.2
-- Avoid selecting disabled inventory organizations
and sysdate < nvl(hou1.date_to, sysdate + 1)
and sysdate < nvl(hou2.date_to, sysdate + 1)
-- Revision for version 1.1
and mtfh.header_id                      = mtfl.header_id 
and mtfl.from_org_id                    = mip.ship_organization_id 
and mtfl.to_org_id                      = mip.sell_organization_id 
and mtfh.flow_type                      = mip.flow_type
and mp.organization_id              (+) = mtfh.organization_id
and fl.lookup_type                      = 'YES_NO'
and fl.lookup_code                      = nvl(mtfh.new_accounting_flag,'N')
and ml.lookup_type                      = 'INV_TRANSACTION_FLOW_TYPE'
and ml.lookup_code                      = mtfh.flow_type
-- End revision for version 1.1
and pv.vendor_id(+)                     = mip.vendor_id
and pvs.vendor_site_id(+)               = mip.vendor_site_id
and pvs.org_id(+)                       = mip.sell_organization_id
and rc.customer_id                      = mip.customer_id
and rsua.cust_acct_site_id              = mip.address_id
and rsua.site_use_id                    = mip.customer_site_id
and rctta.cust_trx_type_id              = mip.cust_trx_type_id
and rctta.org_id                        = mip.ship_organization_id
and qlh_tl.list_header_id               = nvl(rsua.price_list_id, rc.price_list_id)
and qlh_tl.language                     = userenv('lang')
and gcc_ic_cogs.code_combination_id (+) = mip.intercompany_cogs_account_id
and gcc_frt.code_combination_id     (+) = mip.freight_code_combination_id
and gcc_ia.code_combination_id      (+) = mip.inventory_accrual_account_id
and gcc_ea.code_combination_id      (+) = mip.expense_accrual_account_id
order by 
 hou1.name, -- From/Ship_Operating_Unit
 hou2.name -- To/Sell_Operating_Unit
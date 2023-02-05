/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Order Type Setup
-- Description: Report to display the sales order transaction types with the corresponding receivables (A/R) transaction types.

/* +=============================================================================+
-- |  Copyright 2016 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_oe_transaction_types.sql
-- |
-- |  Parameters:
-- |  p_operating_unit       -- Operating Unit you wish to report, leave blank for all
-- |                            operating units (optional) 
-- |  p_ledger               -- general ledger you wish to report, leave blank for all
-- |                            ledgers (optional)
-- |  Description:
-- |  Report to display the sales order transaction types with the corresponding
-- |  receivables (A/R) transaction types. 
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     15 Nov 2016 Douglas Volz   Initial Coding
-- |  1.1     09 Jan 2017 Douglas Volz   Added description and Receivables Txn Type
-- |  1.2     11 Jan 2017 Douglas Volz   Added Order Category, Order Type (DFF),
-- |                                     and Disti Plus Pricing (DFF), and add a
-- |                                     new section for Order Types with no COGS
-- |                                     account.
-- |  1.3     14 Mar 2017 Douglas Volz   Changed apps.ra_cust_trx_types to 
-- |                                     apps.ra_cust_trx_types_all, added A/R
-- |                                     revenue account
-- |  1.4     23 Aug 2017 Douglas Volz   Add user-defined field (descriptive flex-
-- |                                     field) for the COGS ICP account, a contra-
-- |                                     account which is used to record the ICP
-- |                                     portion of the COGS entry.
-- |  1.5     13 Mar 2019 Douglas Volz   Added Operating Unit Parameter.
-- |  1.6     22 May 2019 Douglas Volz   Added missing ORG_ID join
-- |  1.7     14 Apr 2020 Douglas Volz   Added creation date to report
-- |  1.8     16 Apr 2020 Douglas Volz   Moved sales ccid joins to outer query
-- |                                     and added Ledger parameter.
-- |  1.9     28 Apr 2020 Douglas Volz   Changed to multi-language views for the
-- |                                     inventory orgs and operating units.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-order-type-setup/
-- Library Link: https://www.enginatics.com/reports/cac-order-type-setup/
-- Run Report: https://demo.enginatics.com/

select	nvl(gl.short_name, gl.name) Ledger,
	haou.name Operating_Unit,
	ottt.name Order_Type_Name,
	otta.transaction_type_id Order_Type_Id,
	otta.transaction_type_code Transaction_Type_Code,
	otta.order_category_code Order_Category,
	otta.currency_code Currency_Code,
	otta.start_date_active Start_Date,
	otta.end_date_active End_Date,
	rctt.name AR_Transaction_Name,
	rctt.description AR_Transaction_Description,
	rctt.type AR_Transaction_Type,
	&segment_columns
	-- Revision for version 1.8
	&segment_columns2
	-- Revision for version 1.7
	otta.creation_date Creation_Date,
	otta.last_update_date Last_Update_Date
from	oe_transaction_types_tl ottt,
	oe_transaction_types_all otta,
	gl_code_combinations gcc1, -- COGS_Accounts
	-- Revision for version 1.8
	gl_code_combinations gcc2, -- Sales_Accounts
	-- Revision for version 1.3
	-- Revision for version 1.1
	-- ra_cust_trx_types rctt,
	(select  rctt.cust_trx_type_id,
	 rctt.org_id,
	 rctt.name,
	 rctt.description,
	 rctt.type,
	 rctt.gl_id_rev
	 from	ra_cust_trx_types_all rctt
	) rctt,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,  -- operating unit
	gl_ledgers gl
where   ottt.transaction_type_id    = otta.transaction_type_id
and	ottt.language               = userenv('lang')
and	gcc1.code_combination_id (+)= otta.cost_of_goods_sold_account
-- Revision for version 1.8
and	gcc2.code_combination_id (+)= rctt.gl_id_rev
-- Revision for version 1.2
and	otta.cust_trx_type_id       = rctt.cust_trx_type_id (+)
and	otta.transaction_type_code <> 'LINE'
-- Revision for version 1.6
and	otta.org_id                 = rctt.org_id
-- Revision for version 1.7
and	hoi.org_information_context = 'Operating Unit Information'
and	hoi.organization_id         = haou.organization_id -- this gets the operating unit id
and	gl.ledger_id                = to_number(hoi.org_information3) -- this joins OU to GL
-- End revision for version 1.7	
and	haou.organization_id        = otta.org_id -- this gets the operating unit id
and	1=1                         -- p_operating_unit, p_ledger
order by 1,2,3,4,5,7
/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Order Type Setup
-- Description: Report to display the sales order transaction types with the corresponding receivables (A/R) transaction types.
-- / +=============================================================================+
-- -- | Copyright 2016 - 2020 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxoetransactiontypes.sql
-- -- |
-- -- | Parameters:
-- -- | poperatingunit -- Operating Unit you wish to report, leave blank for all
-- -- | operating units (optional)
-- -- | pledger -- general ledger you wish to report, leave blank for all
-- -- | ledgers (optional)
-- -- | Description:
-- -- | Report to display the sales order transaction types with the corresponding
-- -- | receivables (A/R) transaction types.
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 15 Nov 2016 Douglas Volz Initial Coding
-- -- | 1.1 09 Jan 2017 Douglas Volz Added description and Receivables Txn Type
-- -- | 1.2 11 Jan 2017 Douglas Volz Added Order Category, Order Type (DFF),
-- -- | and Disti Plus Pricing (DFF), and add a
-- -- | new section for Order Types with no COGS
-- -- | account.
-- -- | 1.3 14 Mar 2017 Douglas Volz Changed apps.racusttrxtypes to
-- -- | apps.racusttrxtypesall, added A/R
-- -- | revenue account
-- -- | 1.4 23 Aug 2017 Douglas Volz Add user-defined field (descriptive flex-
-- -- | field) for the COGS ICP account, a contra-
-- -- | account which is used to record the ICP
-- -- | portion of the COGS entry.
-- -- | 1.5 13 Mar 2019 Douglas Volz Added Operating Unit Parameter.
-- -- | 1.6 22 May 2019 Douglas Volz Added missing ORGID join
-- -- | 1.7 14 Apr 2020 Douglas Volz Added creation date to report
-- -- | 1.8 16 Apr 2020 Douglas Volz Moved sales ccid joins to outer query
-- -- | and added Ledger parameter.
-- -- | 1.9 28 Apr 2020 Douglas Volz Changed to multi-language views for the
-- -- | inventory orgs and operating units.
-- -- | 1.10 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-order-type-setup/
-- Library Link: https://www.enginatics.com/reports/cac-order-type-setup/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv.name operating_unit,
ottt.name order_type_name,
otta.transaction_type_id order_type_id,
xxen_util.meaning(otta.transaction_type_code,'TRANSACTION_TYPE',660) transaction_type_code,
xxen_util.meaning(otta.order_category_code,'ORDER_CATEGORY',660) order_category,
otta.currency_code,
otta.start_date_active start_date,
otta.end_date_active end_date,
rctta.name ar_transaction_name,
rctta.description ar_transaction_description,
xxen_util.meaning(rctta.type,'INV/CM',222) ar_transaction_type,
&segment_columns
&segment_columns2
otta.creation_date,
otta.last_update_date
from
oe_transaction_types_all otta,
oe_transaction_types_tl ottt,
hr_all_organization_units_vl haouv,
hr_organization_information hoi,
gl_ledgers gl,
ra_cust_trx_types_all rctta,
gl_code_combinations gcc1,
gl_code_combinations gcc2
where
1=1 and
otta.transaction_type_code<>'LINE' and
otta.transaction_type_id=ottt.transaction_type_id and
ottt.language=userenv('lang') and
otta.org_id=haouv.organization_id and
haouv.organization_id=hoi.organization_id and
hoi.org_information_context='Operating Unit Information' and
to_number(hoi.org_information3)=gl.ledger_id and
otta.cust_trx_type_id=rctta.cust_trx_type_id(+) and
otta.org_id=rctta.org_id(+) and
otta.cost_of_goods_sold_account=gcc1.code_combination_id(+) and
rctta.gl_id_rev=gcc2.code_combination_id(+)
order by
ledger,
operating_unit,
order_type_name,
order_type_id,
otta.transaction_type_code,
otta.currency_code

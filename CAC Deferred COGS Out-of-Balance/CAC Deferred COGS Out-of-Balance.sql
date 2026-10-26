/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Deferred COGS Out-of-Balance
-- Description: Report to find the out-of-balance deferred COGS entries by organization, item and sales order number. You do not need to run Create Accounting as this report uses the pre-Create Accounting material accounting entries.
-- / +=============================================================================+
-- -- | Copyright 2019 - 2020 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxmtldistxlaoobdcogsrept.sql
-- -- |
-- -- | Parameters:
-- -- | ptrxdatefrom -- Starting accounting date for the transaction lines
-- -- | ptrxdateto -- Ending accounting date for the transaction lines
-- -- | pcategoryset1 -- The first item category set to report, typically the
-- -- | Cost or Product Line Category Set
-- -- | pcategoryset2 -- The second item category set to report, typically the
-- -- | Inventory Category Set
-- -- | porgcode -- Specific inventory organization you wish to report (optional)
-- -- | poperatingunit -- Operating Unit you wish to report, leave blank for all
-- -- | operating units (optional)
-- -- | pledger -- general ledger you wish to report, leave blank for all
-- -- | ledgers (optional)
-- -- |
-- -- | Description:
-- -- | Report to find the out-of-balance deferred COGS entries.
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 07 Jun 2019 Douglas Volz Initial Coding, based on version 1.25 for
-- -- | the xxxmtldistxladetailrept.sql.
-- -- | 1.1 06 Feb 2020 Douglas Volz Adding Operating Unit and Org Code parameters.
-- -- | 1.2 20 Apr 2020 Douglas Volz Changed to multi-lang views for the item
-- -- | master, item category sets and operating units.
-- -- | 1.3 26 Jul 2020 Douglas Volz Removed Ledger, Operating Unit, subinventory,
-- -- | Item Type, Subledger Accounting tables and joins.
-- -- | Removed Create Accounting from this report;
-- -- | get the quantities from mmt, when the item
-- -- | cost is zero the DCOGS entries are not
-- -- | recorded on the COGS Recognition Txn Type.
-- -- | 1.4 29 Jun 2022 Douglas Volz Added back Ledger, Operating Unit, item type, plus
-- -- | added language tables for item status and UOM.
-- -- | 1.5 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-deferred-cogs-out-of-balance/
-- Library Link: https://www.enginatics.com/reports/cac-deferred-cogs-out-of-balance/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
x.organization_code org_code,
oap.period_name,
&segment_columns
msiv.concatenated_segments item_number,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
msiv.inventory_item_status_code item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
&category_columns
xxen_util.meaning(36,'CST_ACCOUNTING_LINE_TYPE',700) accounting_line_type,
mtst.transaction_source_type_name transaction_source,
ooha.order_number sales_order_number,
ottt.name order_type,
msiv.primary_uom_code uom_code,
x.quantity net_deferred_cogs_quantity,
gl.currency_code curr_code,
x.amount net_deferred_cogs_amount
from
(
select
mp.organization_code,
mmt.organization_id,
mmt.acct_period_id,
mta.reference_account,
mmt.inventory_item_id,
mmt.transaction_source_type_id,
oola.header_id,
-sum(mmt.primary_quantity) quantity,
sum(mta.base_transaction_value) amount
from
mtl_parameters mp,
mtl_material_transactions mmt,
mtl_transaction_accounts mta,
oe_order_lines_all oola
where
4=4 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=mmt.organization_id and
mmt.transaction_source_type_id in (2,12) and
mmt.transaction_id=mta.transaction_id and
mta.accounting_line_type=36 and
mta.transaction_source_type_id in (2,12) and
mmt.trx_source_line_id=oola.line_id(+)
group by
mp.organization_code,
mmt.organization_id,
mmt.acct_period_id,
mta.reference_account,
mmt.inventory_item_id,
mmt.transaction_source_type_id,
oola.header_id
having
sum(mmt.primary_quantity)<>0 and
sum(mta.base_transaction_value)<>0
) x,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
org_acct_periods oap,
mtl_system_items_vl msiv,
mtl_txn_source_types mtst,
oe_order_headers_all ooha,
oe_transaction_types_tl ottt,
gl_code_combinations gcc
where
1=1 and
x.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
x.acct_period_id=oap.acct_period_id and
x.organization_id=oap.organization_id and
x.organization_id=msiv.organization_id and
x.inventory_item_id=msiv.inventory_item_id and
x.transaction_source_type_id=mtst.transaction_source_type_id and
x.header_id=ooha.header_id(+) and
ooha.order_type_id=ottt.transaction_type_id(+) and
ottt.language(+)=userenv('lang') and
x.reference_account=gcc.code_combination_id(+)
order by
ledger,
operating_unit,
org_code,
oap.period_name,
item_number,
transaction_source,
sales_order_number

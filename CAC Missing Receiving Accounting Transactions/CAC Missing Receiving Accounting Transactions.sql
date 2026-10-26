/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Missing Receiving Accounting Transactions
-- Description: Report to find receiving transactions where the receiving accounting entries do not exist, for PO receipts into receiving and for returns from inventory and outside processing (work in process). To get all transactions which are missing receiving accounting entries, even for transactions where the transaction amounts are too small, set the Minimum Transaction Amount to zero (0). And note the quantities and purchase order unit prices are expressed in the item's primary unit of measure.
-- Note: To find missing purchase order deliveries into inventory or work in process, use the CAC Missing Material Transactions and the CAC Missing WIP Transactions reports.
-- / +=============================================================================+
-- -- | Copyright 2022 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: findmissingreceivingaccountingentries.sql
-- -- |
-- -- | Parameters:
-- -- | ptrxdatefrom -- Starting transaction date, mandatory
-- -- | ptrxdateto -- Ending transaction date, mandatory
-- -- | pminimumamount -- The absolute smallest transaction amount to be reported
-- -- | pcategoryset1 -- The first item category set to report, typically the
-- -- | Cost or Product Line Category Set
-- -- | pcategoryset2 -- The second item category set to report, typically the
-- -- | Inventory Category Set
-- -- | pitemnumber -- Specific item number you wish to report (optional)
-- -- | porgcode -- Specific inventory organization you wish to report (optional)
-- -- | poperatingunit -- Operating Unit you wish to report, leave blank for all
-- -- | operating units (optional)
-- -- | pledger -- general ledger you wish to report, leave blank for all
-- -- | ledgers (optional)
-- -- |
-- -- | Description:
-- -- | Report to find receiving transactions where the receiving accounting entries do not
-- -- | exist.
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 14 Jul 2022 Douglas Volz Initial Coding
-- -- | 1.1 15 Jul 2022 Douglas Volz Added PO number, PO Line, decode on receipt
-- -- | quantity.
-- -- | 1.2 18 Jul 2022 Douglas Volz Correct logic for CORRECT transaction types.
-- -- | 1.3 23 Jul 2022 Douglas Volz Added Parent Transaction Type to report.
-- -- | Additional exclusions for CORRECT transactions.
-- -- | 1.4 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-missing-receiving-accounting-transactions/
-- Library Link: https://www.enginatics.com/reports/cac-missing-receiving-accounting-transactions/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
(select oap.period_name from org_acct_periods oap where rt.organization_id=oap.organization_id and rt.transaction_date>=oap.period_start_date and rt.transaction_date<oap.schedule_close_date+1) period_name,
(select mtst.transaction_source_type_name from mtl_txn_source_types mtst where mtst.transaction_source_type_id=1) transaction_source,
xxen_util.meaning(rt.transaction_type,'RCV TRANSACTION TYPE',201) transaction_type,
(select xxen_util.meaning(rt2.transaction_type,'RCV TRANSACTION TYPE',201) from rcv_transactions rt2 where rt.parent_transaction_id=rt2.transaction_id) parent_transaction_type,
rt.transaction_id,
rt.parent_transaction_id,
pha.segment1 po_number,
pla.line_num po_line,
rt.transaction_date,
rt.creation_date,
msiv.concatenated_segments item_number,
msiv.description item_description,
&category_columns
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
xxen_util.yes(msiv.costing_enabled_flag) allow_costs,
xxen_util.yes(msiv.inventory_asset_flag) inventory_asset,
xxen_util.yes(msiv.mtl_transactions_enabled_flag) material_transaction_enabled,
msiv.primary_uom_code uom_code,
decode(rt.transaction_type,'RETURN TO VENDOR',-1,1)*rt.primary_quantity primary_quantity,
nvl(rt.po_unit_price,0)*rt.quantity/rt.primary_quantity po_unit_price,
round(decode(rt.transaction_type,'RETURN TO VENDOR',-1,1)*rt.quantity*nvl(rt.po_unit_price,0),2) extended_receipt_amount
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
rcv_transactions rt,
po_headers_all pha,
po_lines_all pla,
mtl_system_items_vl msiv
where
1=1 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=rt.organization_id and
rt.transaction_type in ('RECEIVE','RETURN TO VENDOR','CORRECT') and
nvl(rt.consigned_flag,'N')='N' and
rt.transaction_id not in (select rrsl.rcv_transaction_id from rcv_receiving_sub_ledger rrsl) and
(rt.transaction_type<>'CORRECT' or nvl((select rt2.transaction_type from rcv_transactions rt2 where rt.parent_transaction_id=rt2.transaction_id),'x') not in ('ACCEPT','DELIVER','REJECT','RETURN TO RECEIVING','TRANSFER')) and
abs(round(decode(rt.transaction_type,'RETURN TO VENDOR',-1,1)*rt.quantity*nvl(rt.po_unit_price,0),2))>=:p_minimum_amount and
rt.po_header_id=pha.po_header_id and
rt.po_line_id=pla.po_line_id and
rt.organization_id=msiv.organization_id and
pla.item_id=msiv.inventory_item_id
order by
ledger,
operating_unit,
org_code,
transaction_source,
rt.transaction_date

/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Receiving Account Detail
-- Description: Receiving accounting distributions in detail by item, purchase order, release, transaction date, creation date, created by and transaction id.
-- Show SLA Accounting = Yes reports the Subledger Accounting (Create Accounting) account, and only distributions accounted in Subledger Accounting. No reports the receiving subledger account.
-- Show Project Information and Show WIP Outside Processing add the project and task, and the WIP job and outside processing resource columns.
-- Purchasing Category is the purchase order line category, which also categorizes expense receipts without an item.
-- On instances with India Localization, GST columns (GST/PAN/TAN, tax, HSN/SAC, NR Tax) are also included.
-- / +=============================================================================+
-- -- | Copyright 2010 - 2022 Douglas Volz Consulting, Inc.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this
-- -- | permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxrcvdistxladetailrept.sql
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 05 Apr 2010 Douglas Volz Initial Coding based on XXXRCVDISTXLASUMREPT.sql
-- -- | 1.18 21 Aug 2022 Douglas Volz Streamline dynamic SQL code.
-- -- | 1.19 03 Sep 2022 Douglas Volz Add Accounting Line Type, Transaction Type and Minimum Amount parameters.
-- -- | And language translations for Accounting Line Types.
-- -- | 1.20 08 Oct 2022 Douglas Volz Add project task information.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-receiving-account-detail/
-- Library Link: https://www.enginatics.com/reports/cac-receiving-account-detail/
-- Run Report: https://demo.enginatics.com/

select /*+ leading(mp rae) use_nl(rrsl) */
gl.name ledger,
haouv.name operating_unit,
mp.organization_code org_code,
rrsl.period_name,
&segment_columns
msiv.concatenated_segments item_number,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
&category_columns
mck.concatenated_segments purchasing_category,
rrsl.accounting_line_type,
xxen_util.meaning(rt.transaction_type,'RCV TRANSACTION TYPE',201) transaction_type,
rt.transaction_id,
rt.transaction_date,
rt.creation_date,
xxen_util.user_name(rt.created_by) created_by,
aps.vendor_name supplier_name,
xxen_util.meaning(pda.destination_type_code,'DESTINATION TYPE',201) destination_type,
pha.segment1 po_number,
pla.line_num po_line,
(select pra.release_num from po_releases_all pra where rt.po_release_id=pra.po_release_id) release_number,
&project_columns
&wip_osp_columns
msiv.primary_uom_code uom_code,
decode(sign(nvl(rrsl.accounted_dr,0)-nvl(rrsl.accounted_cr,0)),0,rt.primary_quantity,sign(nvl(rrsl.accounted_dr,0)-nvl(rrsl.accounted_cr,0))*abs(rt.primary_quantity)) quantity,
gl.currency_code,
rae.unit_price,
nvl(rrsl.accounted_dr,0)-nvl(rrsl.accounted_cr,0) amount
&il_reg_columns
&il_columns_amt
&il_columns_rate
&il_columns_tp
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv,
gl_ledgers gl,
rcv_accounting_events rae,
rcv_receiving_sub_ledger rrsl,
rcv_transactions rt,
rcv_shipment_lines rsl,
po_headers_all pha,
po_lines_all pla,
po_distributions_all pda,
ap_suppliers aps,
mtl_system_items_vl msiv,
mtl_categories_kfv mck,
&project_tables
&sla_tables
gl_code_combinations_kfv gcck
&il_from
where
1=1 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=rae.organization_id and
rae.rcv_transaction_id=rrsl.rcv_transaction_id and
rae.accounting_event_id=rrsl.accounting_event_id and
rrsl.rcv_transaction_id=rt.transaction_id and
rt.shipment_line_id=rsl.shipment_line_id and
rt.po_header_id=pha.po_header_id and
rt.po_line_id=pla.po_line_id and
nvl(rt.po_distribution_id,to_number(rrsl.reference3))=pda.po_distribution_id and
pha.vendor_id=aps.vendor_id and
rsl.item_id=msiv.inventory_item_id(+) and
rsl.to_organization_id=msiv.organization_id(+) and
pla.category_id=mck.category_id(+) and
&project_joins
&account_join
&account_join_sla
&il_where
order by
gl.name,
haouv.name,
mp.organization_code,
rrsl.period_name,
gcck.concatenated_segments,
msiv.concatenated_segments,
rt.transaction_date,
rt.transaction_id,
rrsl.accounting_line_type

/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Receiving Account Summary
-- Description: Report to get the receiving accounting distributions, in summary, by item, purchase order, purchase order line, release and project number. With the Show SLA Accounting parameter you can choose to use the Release 12 Subledger Accounting (Create Accounting) account setups by selecting Yes. And if you have not modified your SLA accounting rules, select No to allow this report to run a bit faster. With parameters to limit the report size, to display or not display purchase information (purchase order, line, release) and WIP outside processing information (WIP job and OSP resource code). And if you accrue expense receipts at time of receipt, for expense destinations when there is no item number, this report will get the expense category information and put it into the columns for the first category set.
-- (Note: this report has not been tested with encumbrance entries.)
-- / +=============================================================================+
-- -- | Copyright 2009- 2022 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this
-- -- | permission.
-- -- +=============================================================================+
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 06 Nov 2009 Douglas Volz Initial Coding
-- -- | 1.15 17 Sep 2021 Douglas Volz Parameter changes, adding item number, PO number.
-- -- | 1.16 08 Jul 2022 Douglas Volz Subledger Accounting performance improvements
-- -- | and parameter to show or not show PO information.
-- -- | 1.17 14 Aug 2022 Douglas Volz Revision for expense/no item receipts.
-- -- | Combine SLA and Non-SLA Receiving Acct Reports. Make
-- -- | Show SLA, Show PO and Show WIP OSP dynamic SQL parameters.
-- -- | 1.18 21 Aug 2022 Douglas Volz Streamline dynamic SQL code.
-- -- | 1.19 03 Sep 2022 Douglas Volz Language translations for Accounting Line Types.
-- -- | 1.20 24 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-receiving-account-summary/
-- Library Link: https://www.enginatics.com/reports/cac-receiving-account-summary/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
x.organization_code org_code,
x.period_name,
&segment_columns
x.item_number,
x.item_description,
x.item_type,
&category_columns
nvl(xxen_util.meaning(x.accounting_line_type,'XLA_ACCOUNTING_CLASSES',602),x.accounting_line_type) accounting_line_type,
xxen_util.meaning(x.transaction_type,'RCV TRANSACTION TYPE',201) transaction_type,
x.vendor_name supplier_name,
xxen_util.meaning(x.destination_type_code,'DESTINATION TYPE',201) destination_type,
&p_show_purchase_order
&p_show_project
&p_show_wip_osp
x.primary_uom_code uom_code,
sum(x.primary_quantity) quantity,
gl.currency_code,
sum(x.amount) amount
from
(
select
mp.organization_code,
rt.organization_id,
rrsl.period_name,
rrsl.code_combination_id,
rrsl.rcv_sub_ledger_id,
msiv.concatenated_segments item_number,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
rsl.item_id,
rsl.to_organization_id,
pla.category_id,
rrsl.accounting_line_type,
rt.transaction_type,
aps.vendor_name,
pda.destination_type_code,
pha.segment1 po_num,
pla.line_num po_line,
rt.po_release_id,
pda.project_id,
rt.wip_entity_id,
rt.bom_resource_id,
msiv.primary_uom_code,
decode(sign(nvl(rrsl.accounted_dr,0)-nvl(rrsl.accounted_cr,0)),1,abs(rt.primary_quantity),-1,-abs(rt.primary_quantity),rt.primary_quantity) primary_quantity,
nvl(rrsl.accounted_dr,0)-nvl(rrsl.accounted_cr,0) amount
from
rcv_receiving_sub_ledger rrsl,
rcv_accounting_events rae,
rcv_transactions rt,
mtl_parameters mp,
rcv_shipment_lines rsl,
po_headers_all pha,
po_lines_all pla,
po_distributions_all pda,
ap_suppliers aps,
mtl_system_items_vl msiv
where
4=4 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
rrsl.accounting_event_id=rae.accounting_event_id and
rrsl.rcv_transaction_id=rt.transaction_id and
rae.rcv_transaction_id=rt.transaction_id and
rt.organization_id=mp.organization_id and
rt.shipment_line_id=rsl.shipment_line_id and
rt.po_header_id=pha.po_header_id and
rt.po_line_id=pla.po_line_id and
nvl(rt.po_distribution_id,to_number(rrsl.reference3))=pda.po_distribution_id and
pha.vendor_id=aps.vendor_id and
rsl.item_id=msiv.inventory_item_id(+) and
rsl.to_organization_id=msiv.organization_id(+)
) x,
org_acct_periods oap,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
&wip_osp_tables
&project_tables
&rcv_sla_tables
gl_code_combinations gcc
where
1=1 and
x.organization_id=oap.organization_id and
x.period_name=oap.period_name and
x.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id
&project_table_joins
&osp_wip_table_joins
&rcv_sla_table_joins
&rcv_non_sla_table_joins
group by
nvl(gl.short_name,gl.name),
haouv_ou.name,
x.organization_code,
x.period_name,
&segment_columns_grp
x.item_number,
x.item_description,
x.item_type,
x.item_id,
x.to_organization_id,
x.category_id,
x.accounting_line_type,
x.transaction_type,
x.vendor_name,
x.destination_type_code,
&group_by_purchase_order
&group_by_project
&group_by_wip_osp
x.primary_uom_code,
gl.currency_code
order by
ledger,
operating_unit,
org_code,
x.period_name,
&segment_columns_grp
item_number,
accounting_line_type,
transaction_type,
destination_type
&order_by_purchase_order
&order_by_project
&order_by_wip_osp

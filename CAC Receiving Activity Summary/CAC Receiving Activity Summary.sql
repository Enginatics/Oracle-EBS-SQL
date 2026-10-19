/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Receiving Activity Summary
-- Description: Especially for companies who do not use separate inspection receipt processes, this report nets the purchase order receipts into receiving against the deliveries into stock and WIP outside processing (OSP), using the Subledger Accounting entries on the organization's receiving account for the entered transaction date range.
-- Each row is one subledger journal line on the receiving account, with the receiving transaction details shown in the Receiving Transactions form. With Unbalanced Distributions Only set to Yes, only PO distributions whose net amount per period, organization and receiving account is not zero are listed, so receipts and deliveries that offset each other drop out.
-- Differences may be due to the initial receipt occurring in the prior month, not running Create Accounting in the current month, the goods never delivered into stock or OSP, or the delivery not processed by Create Accounting.
-- Template Summary by PO Distribution sums the amount per PO distribution and account.
-- Parameters:
-- ==========
-- Transaction Date From: enter the starting transaction date (mandatory). Defaults to the current period starting date.
-- Transaction Date To: enter the ending transaction date (mandatory). Defaults to the current period ending date.
-- Organization Code: enter the specific inventory organization(s) you wish to report (optional). Defaults to your session's organization code.
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2010 - 2024 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxrcvactivityrept.sql
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 6 Jan 2010 Douglas Volz Initial Coding
-- -- | 1.1 05 Apr 2010 Douglas Volz Added PO number, PO Distribution id to query
-- -- | 1.2 25 Oct 2017 Douglas Volz Now use the receiving parameter Receiving ccid
-- -- | and added transaction source.
-- -- | 1.3 13 Mar 2018 Douglas Volz Added Ledger parameter
-- -- | 1.4 08 Jul 2022 Douglas Volz Multi-language tables for item master.
-- -- | 1.5 24 Jun 2024 Douglas Volz Remove tabs, reinstall parameters and inventory org access controls.
-- -- | 1.6 16 Oct 2026 Andy Haack One row per subledger journal line with the receiving transaction columns.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-receiving-activity-summary/
-- Library Link: https://www.enginatics.com/reports/cac-receiving-activity-summary/
-- Run Report: https://demo.enginatics.com/

select
xxen_util.meaning(pda.destination_type_code,'DESTINATION TYPE',201) destination_type,
x.ledger,
x.operating_unit,
x.organization_code org_code,
x.period_name,
x.accounting_line_type,
xxen_util.meaning(rt.transaction_type,'RCV TRANSACTION TYPE',201) transaction_type,
xxen_util.client_time(rt.transaction_date) transaction_date,
xxen_util.meaning(rsh.receipt_source_code,'SHIPMENT SOURCE TYPE',201) source,
rsh.receipt_num receipt,
(select aps.vendor_name from ap_suppliers aps where rt.vendor_id=aps.vendor_id) supplier,
pha.segment1 po_number,
pla.line_num po_line,
plla.shipment_num po_shipment,
pda.po_distribution_id,
&segment_columns
gcck1.concatenated_segments account,
gcck2.concatenated_segments charge_account,
(select we.wip_entity_name from wip_entities we where pda.wip_entity_id=we.wip_entity_id) wip_job,
msiv.concatenated_segments item_number,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
nvl(rsl.packing_slip,rsh.packing_slip) packing_slip,
rt.currency_code currency,
rt.currency_conversion_rate rate,
rt.currency_conversion_date rate_date,
(select gdct.user_conversion_type from gl_daily_conversion_types gdct where rt.currency_conversion_type=gdct.conversion_type) rate_type,
rt.rma_reference rma_number,
(select wlpn.license_plate_number from wms_license_plate_numbers wlpn where rt.lpn_id=wlpn.lpn_id) lpn,
(select wlpn.license_plate_number from wms_license_plate_numbers wlpn where rt.transfer_lpn_id=wlpn.lpn_id) transfer_lpn,
rt.subinventory,
(select max(papf.full_name) keep (dense_rank last order by papf.effective_start_date) from per_all_people_f papf where rt.employee_id=papf.person_id) receiver,
rsh.bill_of_lading,
rsh.shipment_num shipment,
rt.comments,
x.gl_date,
xxen_util.meaning(x.accounting_class_code,'XLA_ACCOUNTING_CLASS',602) accounting_class,
x.accounted_dr,
x.accounted_cr,
x.amount
from
(
select
y.*,
sum(y.amount) over (partition by y.organization_id,y.period_name,y.po_distribution_id,y.code_combination_id) net_amount
from
(
select
mp.organization_code,
nvl(gl.short_name,gl.name) ledger,
haouv.name operating_unit,
z.*,
nvl(z.accounted_dr,0)-nvl(z.accounted_cr,0) amount
from
(
select
rt.organization_id,
xah.ledger_id,
xah.period_name,
rrsl.accounting_line_type,
rt.transaction_id,
to_number(rrsl.reference3) po_distribution_id,
xal.code_combination_id,
xah.accounting_date gl_date,
xal.accounting_class_code,
xal.accounted_dr,
xal.accounted_cr
from
mtl_parameters mp,
rcv_parameters rp,
rcv_receiving_sub_ledger rrsl,
rcv_transactions rt,
xla_distribution_links xdl,
xla_ae_lines xal,
xla_ae_headers xah
where
1=1 and
mp.organization_id=rp.organization_id and
rp.receiving_account_id=rrsl.code_combination_id and
rrsl.accounting_line_type<>'Accrual' and
rrsl.rcv_transaction_id=rt.transaction_id and
rp.organization_id=rt.organization_id and
rt.source_document_code not in ('RMA','REQ') and
rrsl.rcv_sub_ledger_id=xdl.source_distribution_id_num_1 and
xdl.source_distribution_type='RCV_RECEIVING_SUB_LEDGER' and
xdl.application_id=707 and
xdl.ae_header_id=xal.ae_header_id and
xdl.ae_line_num=xal.ae_line_num and
xal.application_id=707 and
rrsl.code_combination_id=xal.code_combination_id and
xal.ae_header_id=xah.ae_header_id and
xah.application_id=707
union all
select
wta.organization_id,
xah.ledger_id,
xah.period_name,
xxen_util.meaning(wta.accounting_line_type,'CST_ACCOUNTING_LINE_TYPE',700) accounting_line_type,
rt.transaction_id,
rt.po_distribution_id,
xal.code_combination_id,
xah.accounting_date gl_date,
xal.accounting_class_code,
xal.accounted_dr,
xal.accounted_cr
from
mtl_parameters mp,
rcv_parameters rp,
wip_transaction_accounts wta,
wip_transactions wt,
rcv_transactions rt,
xla_distribution_links xdl,
xla_ae_lines xal,
xla_ae_headers xah
where
2=2 and
mp.organization_id=rp.organization_id and
rp.organization_id=wta.organization_id and
rp.receiving_account_id=wta.reference_account and
wta.accounting_line_type in (4,5) and --osp deliveries can carry resource absorption (4) instead of receiving inspection (5) on the receiving account
wta.transaction_id=wt.transaction_id and
wt.rcv_transaction_id=rt.transaction_id and
wta.wip_sub_ledger_id=xdl.source_distribution_id_num_1 and
xdl.source_distribution_type='WIP_TRANSACTION_ACCOUNTS' and
xdl.application_id=707 and
xdl.ae_header_id=xal.ae_header_id and
xdl.ae_line_num=xal.ae_line_num and
xal.application_id=707 and
wta.reference_account=xal.code_combination_id and
xal.ae_header_id=xah.ae_header_id and
xah.application_id=707
union all
select
mta.organization_id,
xah.ledger_id,
xah.period_name,
xxen_util.meaning(mta.accounting_line_type,'CST_ACCOUNTING_LINE_TYPE',700) accounting_line_type,
rt.transaction_id,
rt.po_distribution_id,
xal.code_combination_id,
xah.accounting_date gl_date,
xal.accounting_class_code,
xal.accounted_dr,
xal.accounted_cr
from
mtl_parameters mp,
rcv_parameters rp,
mtl_transaction_accounts mta,
mtl_material_transactions mmt,
rcv_transactions rt,
xla_distribution_links xdl,
xla_ae_lines xal,
xla_ae_headers xah
where
3=3 and
mp.organization_id=rp.organization_id and
rp.organization_id=mta.organization_id and
rp.receiving_account_id=mta.reference_account and
mta.accounting_line_type=5 and
mta.transaction_id=mmt.transaction_id and
mmt.transaction_source_type_id=1 and
mmt.rcv_transaction_id=rt.transaction_id and
mta.inv_sub_ledger_id=xdl.source_distribution_id_num_1 and
xdl.source_distribution_type='MTL_TRANSACTION_ACCOUNTS' and
xdl.application_id=707 and
xdl.ae_header_id=xal.ae_header_id and
xdl.ae_line_num=xal.ae_line_num and
xal.application_id=707 and
mta.reference_account=xal.code_combination_id and
xal.ae_header_id=xah.ae_header_id and
xah.application_id=707
) z,
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv,
gl_ledgers gl
where
4=4 and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
z.organization_id=mp.organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
z.ledger_id=gl.ledger_id
) y
) x,
rcv_transactions rt,
rcv_shipment_headers rsh,
rcv_shipment_lines rsl,
po_distributions_all pda,
po_headers_all pha,
po_lines_all pla,
po_line_locations_all plla,
mtl_system_items_vl msiv,
gl_code_combinations_kfv gcck1,
gl_code_combinations_kfv gcck2
where
5=5 and
x.transaction_id=rt.transaction_id and
rt.shipment_header_id=rsh.shipment_header_id and
rt.shipment_line_id=rsl.shipment_line_id and
x.po_distribution_id=pda.po_distribution_id and
pda.po_header_id=pha.po_header_id and
pda.po_line_id=pla.po_line_id and
pda.line_location_id=plla.line_location_id and
rsl.item_id=msiv.inventory_item_id(+) and
rsl.to_organization_id=msiv.organization_id(+) and
x.code_combination_id=gcck1.code_combination_id and
pda.code_combination_id=gcck2.code_combination_id
order by
x.organization_code,
x.period_name,
pha.segment1,
pla.line_num,
pda.po_distribution_id,
rt.transaction_date,
rt.transaction_id

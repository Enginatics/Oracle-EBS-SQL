/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST AP and PO Accrual Reconciliation
-- Description: Imported from Concurrent Program
Application: Bills of Material
Source: AP and PO Accrual Reconciliation Report
Short Name: CSTACRAP

-- Excel Examle Output: https://www.enginatics.com/example/cst-ap-and-po-accrual-reconciliation/
-- Library Link: https://www.enginatics.com/reports/cst-ap-and-po-accrual-reconciliation/
-- Run Report: https://demo.enginatics.com/

with capr as
(
 select
  gsob.name ledger,
  haou.name operating_unit,
  fnd_flex_xml_publisher_apis.process_kff_combination_1('c_bal_segment', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') balancing_segment,
  fnd_flex_xml_publisher_apis.process_kff_combination_1('c_acc_segment', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE') account_segment,
  fnd_flex_xml_publisher_apis.process_kff_combination_1('c_cct_segment', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE') cost_center_segment,
  gcc.concatenated_segments account,
  crc.displayed_field transaction_type,
  decode(capr.invoice_distribution_id, NULL, decode(capr.write_off_id, NULL, 'PO', 'WO'), 'AP') transaction_source,
  trunc(capr.transaction_date) transaction_date,
  pov.vendor_name vendor,
  apia.invoice_num invoice_number,
  aida.invoice_line_number invoice_line,
  nvl(poh.clm_document_number,poh.segment1) po_number,
  por.release_num po_release,
  nvl(pol.line_num_display, to_char(pol.line_num)) po_line,
  poll.shipment_num po_shipment,
  pod.distribution_num po_distribution,
  nvl(poh.clm_document_number,poh.segment1) ||
    nvl2(por.release_num,' (' || por.release_num || ')','') po_num_rel_ref,
  nvl(poh.clm_document_number,poh.segment1) ||
    nvl2(por.release_num,' (' || por.release_num || ')','') || ' - ' ||
    nvl(pol.line_num_display, to_char(pol.line_num)) || '/' || poll.shipment_num || '/' || pod.distribution_num po_num_rel_line_ship_dist_ref,
  rsh.receipt_num receipt_number,
  crs.po_balance po_balance,
  crs.ap_balance ap_balance,
  crs.write_off_balance wo_balance,
  (nvl(crs.po_balance,0) + nvl(crs.ap_balance,0) + nvl(crs.write_off_balance,0)) total_balance,
  gsob.currency_code currency,
  capr.quantity transaction_quantity,
  decode(capr.write_off_id, NULL, pol.unit_meas_lookup_code, NULL ) uom,
  capr.amount accounted_amount,
  capr.entered_amount entered_amount,
  capr.currency_code entered_currency,
  trunc(sysdate - decode(fnd_profile.value('CST_ACCRUAL_AGE_IN_DAYS'), 1, nvl(crs.last_receipt_date,crs.last_invoice_dist_date), greatest(nvl(crs.last_receipt_date,crs.last_invoice_dist_date), nvl(crs.last_invoice_dist_date, crs.last_receipt_date)) ) ) age_in_days,
  nvl2(crs.inventory_item_id,
       (select msi.concatenated_segments
        from mtl_system_items_vl msi
        where inventory_item_id = crs.inventory_item_id and
        rownum <2
       ),
       null) item,
  decode(capr.inventory_organization_id, NULL, NULL, mp.organization_code) inventory_organization,
  pdt.displayed_field destination,
  crs.po_distribution_id po_distribution_id,
  capr.write_off_id write_off_id,
 --
  nvl(:p_aging_days,0) aging_days,
  decode(nvl(:p_aging_days,0), 0, 0, floor( ( sysdate - decode(fnd_profile.value('CST_ACCRUAL_AGE_IN_DAYS'), 1, nvl(crs.last_receipt_date,crs.last_invoice_dist_date), greatest(nvl(crs.last_receipt_date,crs.last_invoice_dist_date), nvl(crs.last_invoice_dist_date, crs.last_receipt_date)) )) / decode(nvl(:p_aging_days,0),0,1,:p_aging_days))*nvl(:p_aging_days,0))  aging_period_days_from,
  decode(nvl(:p_aging_days,0), 0, 0, ceil(( sysdate - decode(fnd_profile.value('CST_ACCRUAL_AGE_IN_DAYS'), 1, nvl(crs.last_receipt_date,crs.last_invoice_dist_date), greatest(nvl(crs.last_receipt_date,crs.last_invoice_dist_date), nvl(crs.last_invoice_dist_date, crs.last_receipt_date)) ) ) / decode(nvl(:p_aging_days,0),0,1,:p_aging_days))*nvl(:p_aging_days,0)-1) aging_period_days_to
 from
  cst_reconciliation_codes crc,
  cst_ap_po_reconciliation capr,
  ap_invoices_all apia,
  ap_invoice_distributions_all aida,
  mtl_parameters mp,
  rcv_transactions rct,
  rcv_shipment_headers rsh,
  cst_reconciliation_summary crs,
  po_distributions_all pod,
  po_line_locations_all poll,
  po_releases_all por,
  po_lines_all pol,
  po_headers_all poh,
  po_vendors pov,
  po_destination_types_all_v pdt,
  gl_code_combinations_kfv gcc,
  cst_accrual_accounts caa,
  hr_all_organization_units haou,
  hr_organization_information hoi,
  gl_sets_of_books gsob
 where
  crc.lookup_code = to_char(capr.transaction_type_code) and
  crc.lookup_type in ( 'RCV TRANSACTION TYPE', 'ACCRUAL WRITE-OFF ACTION','ACCRUAL TYPE') and
  aida.invoice_distribution_id(+) = capr.invoice_distribution_id and
  apia.invoice_id(+) = aida.invoice_id and
  mp.organization_id(+) = capr.inventory_organization_id and
  rct.transaction_id(+) = capr.rcv_transaction_id and
  rsh.shipment_header_id(+) = rct.shipment_header_id and
  capr.po_distribution_id = crs.po_distribution_id and
  crs.accrual_account_id = capr.accrual_account_id and
  pod.po_distribution_id = crs.po_distribution_id and
  poll.line_location_id = pod.line_location_id and
  pod.po_release_id = por.po_release_id(+) and
  pol.po_line_id = pod.po_line_id and
  poh.po_header_id = pod.po_header_id and
  pdt.lookup_code(+) = crs.destination_type_code and
  pov.vendor_id(+) = crs.vendor_id and
  crs.accrual_account_id = gcc.code_combination_id and
  crs.accrual_account_id = caa.accrual_account_id and
  caa.operating_unit_id = crs.operating_unit_id and
  capr.operating_unit_id = crs.operating_unit_id and
  crs.operating_unit_id = haou.organization_id and
  hoi.organization_id = haou.organization_id and
  hoi.org_information_context = 'Operating Unit Information' and
  gsob.set_of_books_id = to_number(hoi.org_information3)
)
--
-- Main Query Starts Here
select distinct
 capr.ledger,
 capr.operating_unit,
 capr.balancing_segment,
 capr.account_segment,
 capr.cost_center_segment,
 capr.account,
 capr.vendor,
 capr.po_number,
 capr.po_release,
 capr.po_line,
 capr.po_shipment,
 capr.po_distribution,
 capr.po_distribution_id,
 capr.po_balance,
 capr.ap_balance,
 capr.wo_balance,
 capr.total_balance,
 capr.age_in_days,
 capr.destination,
 capr.item,
 --
 null transaction_source,
 null transaction_type,
 to_date(null) transaction_date,
 to_number(null) transaction_quantity,
 null uom,
 to_number(null) accounted_amount,
 to_number(null) entered_amount,
 null entered_currency,
 null invoice_number,
 to_number(null) invoice_line,
 null receipt_number,
 null inventory_organization,
 to_number(null) write_off_id,
 'Balance' record_type,
 capr.po_num_rel_ref,
 capr.po_num_rel_line_ship_dist_ref,
 capr.aging_period_days_from,
 capr.aging_period_days_to,
 case nvl(:p_aging_days,0)
 when 0
 then 'All Aging Period Days'
 else to_char(capr.aging_period_days_from,'999990') || ' - ' || to_char(capr.aging_period_days_to) || ' Days'
 end aging_period_days,
 decode(:p_sort_by,
        'ITEM'       , capr.item,
        'AGE IN DAYS', decode(sign(capr.age_in_days),-1, chr(0) || translate( to_char(abs(capr.age_in_days), '000000000999.999'), '0123456789', '9876543210'), to_char(capr.age_in_days , '000000000999.999' ) ),
        'VENDOR', vendor,
        'TOTAL BALANCE', decode(sign(capr.total_balance),-1, chr(0) || translate( to_char(abs(capr.total_balance), '000000000999.999'), '0123456789', '9876543210'),to_char(capr.total_balance, '000000000999.999' ) ),
        'PO NUMBER', capr.po_number
       ) sort_key
from
 capr
where
 1=1
union all
select
 capr.ledger,
 capr.operating_unit,
 capr.balancing_segment,
 capr.account_segment,
 capr.cost_center_segment,
 capr.account,
 capr.vendor,
 capr.po_number,
 capr.po_release,
 capr.po_line,
 capr.po_shipment,
 capr.po_distribution,
 capr.po_distribution_id,
 to_number(null) po_balance,
 to_number(null) ap_balance,
 to_number(null) wo_balance,
 to_number(null) total_balance,
 capr.age_in_days,
 capr.destination,
 capr.item,
 --
 capr.transaction_source,
 capr.transaction_type,
 capr.transaction_date,
 capr.transaction_quantity,
 capr.uom,
 capr.accounted_amount,
 capr.entered_amount,
 capr.entered_currency,
 capr.invoice_number,
 capr.invoice_line,
 capr.receipt_number,
 capr.inventory_organization,
 capr.write_off_id,
 'Transaction' record_type,
 capr.po_num_rel_ref,
 capr.po_num_rel_line_ship_dist_ref,
 capr.aging_period_days_from,
 capr.aging_period_days_to,
 case nvl(:p_aging_days,0)
 when 0
 then 'All Aging Period Days'
 else to_char(capr.aging_period_days_from,'999990') || ' - ' || to_char(capr.aging_period_days_to) || ' Days'
 end aging_period_days,
 decode(:p_sort_by,
        'ITEM'       , capr.item,
        'AGE IN DAYS', decode(sign(capr.age_in_days),-1, chr(0) || translate( to_char(abs(capr.age_in_days), '000000000999.999'), '0123456789', '9876543210'), to_char(capr.age_in_days , '000000000999.999' ) ),
        'VENDOR', vendor,
        'TOTAL BALANCE', decode(sign(capr.total_balance),-1, chr(0) || translate( to_char(abs(capr.total_balance), '000000000999.999'), '0123456789', '9876543210'),to_char(capr.total_balance, '000000000999.999' ) ),
        'PO NUMBER', capr.po_number
       ) sort_key
from
 capr
where
 1=1 and
 :p_show_transactions = 'Y'
order by
 sort_key,
 po_number,
 po_release,
 po_line,
 po_shipment,
 po_distribution,
 record_type
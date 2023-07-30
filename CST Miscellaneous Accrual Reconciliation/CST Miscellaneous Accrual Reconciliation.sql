/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Miscellaneous Accrual Reconciliation
-- Description: Imported from Concurrent Program
Application: Bills of Material
Source: Miscellaneous Accrual Reconciliation Report
Short Name: CSTACRMI
DB package:
-- Excel Examle Output: https://www.enginatics.com/example/cst-miscellaneous-accrual-reconciliation/
-- Library Link: https://www.enginatics.com/reports/cst-miscellaneous-accrual-reconciliation/
-- Run Report: https://demo.enginatics.com/

with cmr as
(
  select
   gsob.name ledger,
   haou.name operating_unit,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('c_bal_segment', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') balancing_segment,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('c_acc_segment', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE') account_segment,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('c_cct_segment', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE') cost_center_segment,
   gcc.concatenated_segments account,
   decode(cmr.invoice_distribution_id, null, 'INV', 'AP') transaction_source,
   decode(cmr.invoice_distribution_id,
     null,(select mtt.transaction_type_name
           from   mtl_transaction_types mtt
           where  cmr.transaction_type_code = to_char(mtt.transaction_type_id)
          ),
          (select crc.displayed_field
           from   cst_reconciliation_codes crc
           where  crc.lookup_code = cmr.transaction_type_code and
           crc.lookup_type in ( 'ACCRUAL WRITE-OFF ACTION','ACCRUAL TYPE')
          )
         ) transaction_type,
   trunc(cmr.transaction_date) transaction_date,
   cmr.quantity quantity,
   decode(cmr.invoice_distribution_id, null, mmt.transaction_uom, pol.unit_meas_lookup_code) uom,
   cmr.amount accounted_amount,
   cmr.entered_amount entered_amount,
   cmr.currency_code entered_currency,
   pov.vendor_name vendor,
   apia.invoice_num invoice_number,
   aida.invoice_line_number invoice_line,
   nvl(poh.clm_document_number,poh.segment1) po_number,
   por.release_num po_release,
   nvl(POL.line_num_display, to_char(POL.line_num)) po_line,
   poll.shipment_num po_shipment,
   pod.distribution_num po_distribution,
   cmr.po_distribution_id po_distribution_id,
   ( select rsh.receipt_num
     from  rcv_shipment_headers rsh,
           rcv_transactions rt
     where rsh.shipment_header_id = rt.shipment_header_id and
           rt.transaction_id = mmt.rcv_transaction_id and
           mmt.source_code = 'RCV' and
           rownum=1
   ) receipt_number,
   cmr.inventory_transaction_id inventory_transaction_id,
   nvl2(cmr.inventory_item_id,
        (select msiv.concatenated_segments
         from mtl_system_items_vl msiv
         where 
         msiv.inventory_item_id = cmr.inventory_item_id and
         msiv.organization_id = nvl(mp.organization_id,msiv.organization_id) and
         rownum <2
        ),
        null) item,
   nvl2(cmr.inventory_item_id,
        (select msiv.description
         from mtl_system_items_vl msiv
         where 
         msiv.inventory_item_id = cmr.inventory_item_id and
         msiv.organization_id = nvl(mp.organization_id,msiv.organization_id) and
         rownum <2
        ),
        null) item_description,
   nvl2(cmr.inventory_item_id,
        (select xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3)
         from mtl_system_items_vl msiv
         where 
         msiv.inventory_item_id = cmr.inventory_item_id and
         msiv.organization_id = nvl(mp.organization_id,msiv.organization_id) and
         rownum <2
        ),
        null) user_item_type,
   mp.organization_code inventory_organization
  from
   cst_misc_reconciliation cmr,
   ap_invoices_all apia,
   ap_invoice_distributions_all aida,
   po_vendors pov,
   mtl_parameters mp,
   gl_code_combinations_kfv gcc,
   po_distributions_all pod,
   po_line_locations_all poll,
   po_releases_all por,
   po_lines_all pol,
   po_headers_all poh,
   mtl_material_transactions mmt,
   cst_accrual_accounts caa,
   hr_all_organization_units haou,
   hr_organization_information hoi,
   gl_sets_of_books gsob
  where
   cmr.invoice_distribution_id = aida.invoice_distribution_id(+) and
   aida.invoice_id = apia.invoice_id(+) and
   cmr.vendor_id = pov.vendor_id(+) and
   cmr.inventory_organization_id = mp.organization_id(+) and
   cmr.accrual_account_id = gcc.code_combination_id and
   cmr.accrual_account_id = caa.accrual_account_id and
   caa.operating_unit_id = cmr.operating_unit_id and
   pod.po_distribution_id(+) = cmr.po_distribution_id and
   cmr.inventory_transaction_id = mmt.transaction_id (+) and
   poll.line_location_id(+) = pod.line_location_id and
   pod.po_release_id = por.po_release_id(+) and
   pol.po_line_id(+) = pod.po_line_id and
   poh.po_header_id(+) = pod.po_header_id and
   cmr.operating_unit_id = haou.organization_id and
   hoi.organization_id = haou.organization_id and
   hoi.org_information_context = 'Operating Unit Information' and
   gsob.set_of_books_id = to_number(hoi.org_information3)
)
--
-- Main Query Starts Here
select
  cmr.*,
  case when cmr.transaction_source = 'AP'
    then 'AP: ' || cmr.invoice_number
    else case when cmr.po_number is not null
    then 'PO: ' || cmr.po_number
    else case when cmr.receipt_number is not null
    then 'RCV: ' || cmr.receipt_number
    else 'INV: ' || cmr.inventory_transaction_id
    end end end transaction_ref,
  decode( :p_sort_by ,
          'ITEM', item,
          'AMOUNT', decode(sign(cmr.accounted_amount),-1, chr(0) || translate( to_char(abs(cmr.accounted_amount), '000000000999.999'), '0123456789', '9876543210'), to_char(cmr.accounted_amount, '000000000999.999' ) ),
          'DATE', to_char(cmr.transaction_date, 'yyyymmddhh24miss')
        ) sort_key
from
  cmr
where
  1=1
order by
  sort_key
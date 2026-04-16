/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Uninvoiced Receipts
-- Description: Application: Bills of Material
Description: Uninvoiced Receipts Report
Templates: Select a template to show Accruals summarized by 
- PO/Release Distributions (Default)
- PO/Release Shipments
- PO/Release Lines

Each template includes a Pivot summarizing the accruals by Accrual Account and the Pivot/Sort Parameter Value (Vendor, Category, PO/Release Number)

Source: Uninvoiced Receipts Report
Short Name: CSTACREP
DB Package: XXEN_CST
-- Excel Examle Output: https://www.enginatics.com/example/cst-uninvoiced-receipts/
-- Library Link: https://www.enginatics.com/reports/cst-uninvoiced-receipts/
-- Run Report: https://demo.enginatics.com/

select
 :p_ledger                ledger,
 :p_operating_unit        operating_unit,
 :p_period_name           period,
 q.po_header_status,
 q.po_line_status,
 q.po_number,
 q.po_release_number,
 q.line_num,
 q.line_type,
 q.item_name,
 q.user_item_type,
 q.category,
 q.item_description,
 q.vendor_name,
 case
  when q.line_qty_accrued > 0 then round(q.line_accrual_amt / q.line_qty_accrued,q.po_precision)
  when q.line_qty_accrued = 0 then round(q.po_unit_price,q.po_precision)
 end                      line_po_unit_price,
 case
  when q.line_qty_accrued > 0 then round(q.line_func_accrual_amt / q.line_qty_accrued,q.po_func_precision)
  when q.line_qty_accrued = 0 then round(q.func_unit_price,q.po_func_precision)
 end                      line_functional_unit_price,
 q.line_bill_of_lading,
 -- shipment
 q.shipment_num,
 case
  when q.ship_qty_accrued > 0 then round(q.ship_accrual_amt / q.ship_qty_accrued,q.po_precision)
  when q.ship_qty_accrued = 0 then round(q.po_unit_price,q.po_precision)
 end                      ship_po_unit_price,
 case
  when q.ship_qty_accrued > 0 then round(q.ship_func_accrual_amt / q.ship_qty_accrued,q.po_func_precision)
  when q.ship_qty_accrued = 0 then round(q.func_unit_price,q.po_func_precision)
 end                      ship_functional_unit_price,
 q.bill_of_lading,
 q.receipt_num,
 q.receipt_date,
 -- distribution
 q.distribution_num,
 q.uom_code,
 q.quantity_received,
 q.quantity_billed,
 q.quantity_accrued,
 q.po_currency_code,
 q.po_unit_price          dist_po_unit_price,
 q.accrual_amount         accrual_amount,
 q.accrual_currency_code,
 q.func_unit_price        dist_functional_unit_price,
 q.func_accrual_amount    functional_accrual_amount,
 q.age_in_days,
 q.charge_account,
 q.accrual_account,
 q.item_expense_account,
 &dff_columns2
 --
 q.pivot_sort_value,
 q.po_num_po_release_num  "PO (Release) Number"
from
 (
   select
    x.*,
    decode(:p_orderby, 'Category', x.category, 'Vendor', x.vendor_name,x.po_num_po_release_num) pivot_sort_value,
    dense_rank() over (partition by x.po_line_id order by x.shipment_num) line_rank,
    sum(x.quantity_accrued)    over (partition by x.po_line_id) line_qty_accrued,
    sum(x.accrual_amount)      over (partition by x.po_line_id) line_accrual_amt,
    sum(x.func_accrual_amount) over (partition by x.po_line_id) line_func_accrual_amt,
    dense_rank() over (partition by x.po_shipment_id order by x.distribution_num) ship_rank,
    sum(x.quantity_accrued)    over (partition by x.po_shipment_id) ship_qty_accrued,
    sum(x.accrual_amount)      over (partition by x.po_shipment_id) ship_accrual_amt,
    sum(x.func_accrual_amount) over (partition by x.po_shipment_id) ship_func_accrual_amt,
    listagg(x.bill_of_lading,',') within group (order by x.bill_of_lading) over (partition by x.po_header_id,x.po_line_id,x.po_release_number) line_bill_of_lading
   from
    (
      select
       nvl( pha.clm_document_number,
            pha.segment1)                        po_number,
       pra.release_num                          po_release_number,
       nvl( pha.clm_document_number, pha.segment1) || nvl2(pra.release_num,' (' || lpad(pra.release_num,6,' ') || ')',null) po_num_po_release_num,
       pha.po_header_id                          po_header_id,
       pla.po_line_id                            po_line_id,
       cpeat.shipment_id                          po_shipment_id,
       cpeat.distribution_id                      po_distribution_id,
       plt.line_type                             line_type,
       nvl( pla.line_num_display,
            to_char(pla.line_num))               line_num,
       msibk.concatenated_segments                 item_name,
       xxen_util.meaning(msibk.item_type,'ITEM_TYPE',3) user_item_type,
       mck.concatenated_segments                 category,
       pla.item_description                      item_description,
       pv.vendor_name                           vendor_name,
       xxen_util.meaning(nvl(pha.closed_code,'OPEN'),'DOCUMENT STATE',201) po_header_status,
       xxen_util.meaning(nvl(pla.closed_code,'OPEN'),'DOCUMENT STATE',201) po_line_status,
       fc2.currency_code                        accrual_currency_code,
       plla.shipment_num                         shipment_num,
       plla.unit_meas_lookup_code                uom_code,
       pda.distribution_num                      distribution_num,
       round( nvl(cpeat.quantity_received, 0),
              :p_qty_precision)                  quantity_received,
       round( nvl(cpeat.quantity_billed, 0),
              :p_qty_precision)                  quantity_billed,
       round( nvl(cpeat.accrual_quantity, 0),
              :p_qty_precision)                  quantity_accrued,
       round( cpeat.unit_price,
              nvl(fc2.extended_precision, 2))   po_unit_price,
       cpeat.currency_code                        po_currency_code,
       round( decode( nvl(fc1.minimum_accountable_unit, 0),
                      0, cpeat.unit_price * cpeat.currency_conversion_rate,
                         (cpeat.unit_price / fc1.minimum_accountable_unit) * cpeat.currency_conversion_rate * fc1.minimum_accountable_unit
                   ),
              nvl(fc1.extended_precision, 2))   func_unit_price,
       gcck1.concatenated_segments                charge_account,
       gcck2.concatenated_segments                accrual_account,
       gcck3.concatenated_segments                item_expense_account,
       &dff_columns
       cpeat.accrual_amount                       accrual_amount,
       round( decode( nvl(fc1.minimum_accountable_unit, 0),
                      0, cpeat.accrual_amount * cpeat.currency_conversion_rate,
                         (cpeat.accrual_amount / fc1.minimum_accountable_unit) * cpeat.currency_conversion_rate * fc1.minimum_accountable_unit),
              nvl(fc2.precision, 2))            func_accrual_amount,
       nvl(fc2.extended_precision,2)            po_precision,
       nvl(fc1.extended_precision,2)            po_func_precision,
       nvl(fc2.precision,2)                     accr_precision,
       ( select
           trunc(sysdate - max(rt.transaction_date))
         from
           rcv_transactions rt
         where
           rt.po_line_location_id = cpeat.shipment_id and
           rt.transaction_type IN ('RECEIVE','MATCH') and
           rt.transaction_date <= :p_end_date
       ) age_in_days,
       ( select
           trunc(max(rt.transaction_date))
         from
           rcv_transactions rt
         where
           rt.po_line_location_id = cpeat.shipment_id and
           rt.transaction_type IN ('RECEIVE','MATCH') and
           rt.transaction_date <= :p_end_date
       ) receipt_date,
       ( select
           listagg(rsh.bill_of_lading,',') within group (order by rsh.bill_of_lading)
         from
          ( select distinct
              rt.po_line_location_id,
              rsh.bill_of_lading
            from
              rcv_transactions rt,
              rcv_shipment_headers rsh
            where
              rsh.shipment_header_id = rt.shipment_header_id and
              rt.transaction_type IN ('RECEIVE','MATCH') and
              rt.transaction_date <= :p_end_date and
              rsh.bill_of_lading is not null
          ) rsh
         where
           rsh.po_line_location_id = plla.line_location_id
       ) bill_of_lading,
       ( select
           listagg(rsh.receipt_num,',') within group (order by rsh.shipment_header_id)
         from
          ( select distinct
              rt.po_line_location_id,
              rsh.receipt_num,
              rsh.shipment_header_id
            from
              rcv_transactions rt,
              rcv_shipment_headers rsh
            where
              rsh.shipment_header_id = rt.shipment_header_id and
              rt.transaction_type IN ('RECEIVE','MATCH') and
              rt.transaction_date <= :p_end_date and
              rsh.receipt_num is not null
          ) rsh
         where
           rsh.po_line_location_id = plla.line_location_id
       ) receipt_num
      from
       cst_per_end_accruals_temp cpeat,
       po_headers_all            pha,
       po_lines_all              pla,
       po_line_locations_all     plla,
       po_distributions_all      pda,
       po_vendors                pv,
       po_line_types             plt,
       po_releases_all           pra,
       mtl_system_items_b_kfv    msibk,
       gl_sets_of_books          gsob,
       fnd_currencies            fc1,
       fnd_currencies            fc2,
       mtl_categories_kfv        mck,
       gl_code_combinations_kfv  gcck1,
       gl_code_combinations_kfv  gcck2,
       gl_code_combinations_kfv  gcck3
      where
       cpeat.distribution_id=pda.po_distribution_id and
       pha.po_header_id=pla.po_header_id and
       pla.po_line_id=plla.po_line_id and
       plla.line_location_id=pda.line_location_id and
       pha.vendor_id=pv.vendor_id and
       pla.line_type_id=plt.line_type_id and
       plla.po_release_id=pra.po_release_id(+) and
       pla.item_id=msibk.inventory_item_id(+) and
       (msibk.organization_id is null or msibk.organization_id=plla.ship_to_organization_id) and
       gsob.set_of_books_id=:p_ledger_id and
       cpeat.currency_code=fc1.currency_code and
       gsob.currency_code=fc2.currency_code and
       cpeat.category_id=mck.category_id(+) and
       pda.code_combination_id=gcck1.code_combination_id and
       pda.accrual_account_id=gcck2.code_combination_id and
       msibk.expense_account=gcck3.code_combination_id(+)
    ) x
 ) q
order by
 decode(:p_orderby, 'Category' , q.category, 'Vendor' , q.vendor_name,null),
 q.po_number,
 q.po_release_number,
 q.line_num,
 q.shipment_num,
 q.distribution_num
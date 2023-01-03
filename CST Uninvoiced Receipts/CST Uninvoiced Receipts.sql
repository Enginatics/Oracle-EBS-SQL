/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
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
 q.po_number,
 q.po_release_number,
 q.line_num,
 q.line_type,
 q.item_name,
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
       nvl( poh.clm_document_number,
            poh.segment1)                        po_number,
       porl.release_num                          po_release_number,
       nvl( poh.clm_document_number, poh.segment1) || nvl2(porl.release_num,' (' || lpad(porl.release_num,6,' ') || ')',null) po_num_po_release_num,
       poh.po_header_id                          po_header_id,
       pol.po_line_id                            po_line_id,
       cpea.shipment_id                          po_shipment_id,
       cpea.distribution_id                      po_distribution_id,
       plt.line_type                             line_type,
       nvl( pol.line_num_display,
            to_char(pol.line_num))               line_num,
       msi.concatenated_segments                 item_name,
       mca.concatenated_segments                 category,
       pol.item_description                      item_description,
       pov.vendor_name                           vendor_name,
       fnc2.currency_code                        accrual_currency_code,
       poll.shipment_num                         shipment_num,
       poll.unit_meas_lookup_code                uom_code,
       pod.distribution_num                      distribution_num,
       round( nvl(cpea.quantity_received, 0),
              :p_qty_precision)                  quantity_received,
       round( nvl(cpea.quantity_billed, 0),
              :p_qty_precision)                  quantity_billed,
       round( nvl(cpea.accrual_quantity, 0),
              :p_qty_precision)                  quantity_accrued,
       round( cpea.unit_price,
              nvl(fnc2.extended_precision, 2))   po_unit_price,
       cpea.currency_code                        po_currency_code,
       round( decode( nvl(fnc1.minimum_accountable_unit, 0),
                      0, cpea.unit_price * cpea.currency_conversion_rate,
                         (cpea.unit_price / fnc1.minimum_accountable_unit) * cpea.currency_conversion_rate * fnc1.minimum_accountable_unit
                   ),
              nvl(fnc1.extended_precision, 2))   func_unit_price,
       gcc1.concatenated_segments                charge_account,
       gcc2.concatenated_segments                accrual_account,
       cpea.accrual_amount                       accrual_amount,
       round( decode( nvl(fnc1.minimum_accountable_unit, 0),
                      0, cpea.accrual_amount * cpea.currency_conversion_rate,
                         (cpea.accrual_amount / fnc1.minimum_accountable_unit) * cpea.currency_conversion_rate * fnc1.minimum_accountable_unit),
              nvl(fnc2.precision, 2))            func_accrual_amount,
       nvl(fnc2.extended_precision,2)            po_precision,
       nvl(fnc1.extended_precision,2)            po_func_precision,
       nvl(fnc2.precision,2)                     accr_precision,
       ( select
           trunc(sysdate - max(rt.transaction_date))
         from
           rcv_transactions rt
         where
           rt.po_line_location_id = cpea.shipment_id and
           rt.transaction_type IN ('RECEIVE','MATCH') and
           rt.transaction_date <= :p_end_date
       ) age_in_days,
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
           rsh.po_line_location_id = poll.line_location_id
       ) bill_of_lading
      from
       cst_per_end_accruals_temp cpea,
       po_headers_all            poh,
       po_lines_all              pol,
       po_line_locations_all     poll,
       po_distributions_all      pod,
       po_vendors                pov,
       po_line_types             plt,
       po_releases_all           porl,
       mtl_system_items_b_kfv      msi,
       fnd_currencies            fnc1,
       fnd_currencies            fnc2,
       mtl_categories_kfv        mca,
       gl_code_combinations_kfv  gcc1,
       gl_code_combinations_kfv  gcc2,
       gl_sets_of_books          sob
      where
       pod.po_distribution_id    = cpea.distribution_id and
       poh.po_header_id          = pol.po_header_id and
       pol.po_line_id            = poll.po_line_id and
       poll.line_location_id     = pod.line_location_id and
       pol.line_type_id          = plt.line_type_id and
       porl.po_release_id (+)    = poll.po_release_id and
       poh.vendor_id             = pov.vendor_id and
       msi.inventory_item_id (+) = pol.item_id and
       ( msi.organization_id    is null or
         (msi.organization_id    = poll.ship_to_organization_id and msi.organization_id is not null)
       ) and
       fnc1.currency_code        = cpea.currency_code and
       fnc2.currency_code        = sob.currency_code and
       cpea.category_id          = mca.category_id(+) and
       gcc1.code_combination_id  = pod.code_combination_id and
       gcc2.code_combination_id  = pod.accrual_account_id and
       sob.set_of_books_id       = :p_ledger_id
    ) x
 ) q
order by
 decode(:p_orderby, 'Category' , q.category, 'Vendor' , q.vendor_name,null),
 q.po_number,
 q.po_release_number,
 q.line_num,
 q.shipment_num,
 q.distribution_num
/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Invoices with PO, Intercompany and SLA Details
-- Description: AP Invoices with PO, Intercompany and SLA Details
-- Excel Examle Output: https://www.enginatics.com/example/ap-invoices-with-po-intercompany-and-sla-details/
-- Library Link: https://www.enginatics.com/reports/ap-invoices-with-po-intercompany-and-sla-details/
-- Run Report: https://demo.enginatics.com/

with ap_inv as -- ap invoice data
  ( select
      gl.name                          ledger
    , haouv.name                       operating_unit
    , asup.vendor_name
    , asup.segment1                    vendor_num
    , assa.vendor_site_code
    , aia.source
    , aia.invoice_id
    , aia.invoice_num
    , aia.invoice_date
    , xxen_util.ap_invoice_status(aia.invoice_id,aia.invoice_amount,aia.payment_status_flag,aia.invoice_type_lookup_code,aia.validation_request_id)
                                       invoice_status
    , xxen_util.meaning(aia.invoice_type_lookup_code,'INVOICE TYPE',200)
                                       invoice_type
    , aia.description                  invoice_description
    , aia.invoice_currency_code
    , aia.invoice_amount
    , nvl(aia.base_amount,aia.invoice_amount)    
                                       invoice_acctd_amount
    , aia.total_tax_amount
    , aia.amount_paid
    , aia.cancelled_date               invoice_cancelled_date
    , aia.cancelled_amount             invoice_cancelled_amount
    , aia.exchange_rate
    , gdct.user_conversion_type        exchange_rate_type
    , aia.exchange_date
    , aila.line_number
    , xxen_util.meaning(aila.line_type_lookup_code,'INVOICE LINE TYPE',200)
                                       line_type
    , xxen_util.meaning(aila.line_source,'LINE SOURCE',200)
                                       line_source
    , decode(aila.discarded_flag,'Y','Y',null)  line_discarded_flag
    , msi.item
    , msi.item_type
    , msi.description                  item_description
    , aila.quantity_invoiced           line_qty_invoiced
    , nvl(mufm.uom_code
         ,aila.unit_meas_lookup_code)  uom
    , aila.unit_price
    , aila.amount                      line_amount
    , nvl(aila.base_amount
         ,aila.amount)                 line_acctd_amount
    , aila.description                 line_description
    , zl.tax                           tax_type
    , zl.tax_rate_code                 tax_rate_code
    , zl.tax_rate                      tax_rate
    , aida.invoice_distribution_id
    , aida.distribution_line_number    dist_line_number
    , xxen_util.meaning(aida.line_type_lookup_code,'INVOICE DISTRIBUTION TYPE',200)
                                       dist_type
    , aida.quantity_invoiced           dist_qty_invoiced
    , aida.amount                      dist_amount
    , nvl(aida.base_amount
         ,aida.amount)                 dist_acctd_amount
    , aida.accounting_date             dist_accounting_date
    , aida.period_name                 dist_period
    , aida.description                 dist_description
    , nvl(aida.dist_match_type
         ,aila.match_type)             dist_match_type
    , case aia.source
      when 'Intercompany'
      then (select min(rsh.receipt_num)
            from   mtl_material_transactions mmt1
               ,   mtl_material_transactions mmt2
               ,   rcv_transactions          rt
               ,   rcv_shipment_headers      rsh
            where
                   mmt1.transaction_id          = to_number(aida.reference_2)
            and    mmt2.transfer_transaction_id = mmt1.transaction_id
            and    rt.transaction_id            = mmt2.rcv_transaction_id
            and    rsh.shipment_header_id       = rt.shipment_header_id
           )
      else (select rsh.receipt_num
            from   rcv_transactions             rt
               ,   rcv_shipment_headers         rsh
            where  rt.transaction_id       = nvl(aida.rcv_transaction_id,aila.rcv_transaction_id)
            and  rsh.shipment_header_id  = rt.shipment_header_id
           )
      end                              dist_matched_receipt_num
    , aida.set_of_books_id             dist_ledger_id
    , aida.accounting_event_id         dist_accounting_event_id
    , nvl(aida.po_distribution_id,aila.po_distribution_id)  po_distribution_id
    , decode(aia.source,'Intercompany',to_number(aia.reference_1),null)          customer_trx_id
    , decode(aia.source,'Intercompany',to_number(aila.reference_1),null)         customer_trx_line_id
    , case aia.source
      when 'Intercompany'
      then (select min(mmt2.transaction_id)
            from   mtl_material_transactions mmt1
               ,   mtl_material_transactions mmt2
            where
                   mmt1.transaction_id = to_number(aida.reference_2)
            and    mmt2.transfer_transaction_id = mmt1.transaction_id
           )
      else (select min(mmt.transaction_id)
            from   rcv_transactions             rt1
               ,   rcv_transactions             rt2
               ,   mtl_material_transactions    mmt
            where  rt1.transaction_id       = nvl(aida.rcv_transaction_id,aila.rcv_transaction_id)
              and  rt2.shipment_header_id   = rt1.shipment_header_id
              and  rt2.shipment_line_id     = rt1.shipment_line_id
              and  rt2.transaction_type     = 'DELIVER'
              and  mmt.rcv_transaction_id   = rt2.transaction_id
           )
      end                              sla_inv_transaction_id
    , msi.inventory_item_id
    , msi.organization_id
    from
      ap_invoices_all              aia
    , ap_invoice_lines_all         aila
    , ap_invoice_distributions_all aida
    , ap_suppliers                 asup
    , ap_supplier_sites_all        assa
    , hr_all_organization_units_vl haouv
    , gl_ledgers                   gl
    , gl_daily_conversion_types    gdct
    , mtl_units_of_measure         mufm
    , (select
         fspa.org_id
       , msiv.inventory_item_id
       , msiv.segment1             item
       , xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type
       , msiv.description
       , msiv.organization_id      organization_id
       from
         financials_system_params_all fspa
       , mtl_system_items_vl          msiv
       where
           msiv.organization_id = fspa.inventory_organization_id
       )                           msi
    , ( select /*+ push_pred */ distinct
          zl1.trx_id
        , zl1.trx_line_id
        , listagg (zl1.tax,'/ ') within group (order by zl1.tax) over (partition by zl1.trx_id,zl1.trx_line_id) tax
        , listagg (zl1.tax_rate_code,'/ ') within group (order by zl1.tax, zl1.tax_rate_code) over (partition by zl1.trx_id,zl1.trx_line_id) tax_rate_code
        , listagg (to_char(zl1.tax_rate),'/ ') within group (order by zl1.tax, zl1.tax_rate_code) over (partition by zl1.trx_id,zl1.trx_line_id) tax_rate
        from (select
                zl2.trx_id
              , zl2.trx_line_id
              , zl2.tax
              , zl2.tax_rate_code
              , zl2.tax_rate
              , sum(lengthb(zl2.tax)+2) over (partition by zl2.trx_id,zl2.trx_line_id order by zl2.tax rows between unbounded preceding and current row) len1
              , sum(lengthb(zl2.tax_rate_code)+2) over (partition by zl2.trx_id,zl2.trx_line_id order by zl2.tax_rate_code rows between unbounded preceding and current row) len2
              from
                zx_lines zl2
              where zl2.application_id    = 200
              and   zl2.entity_code       = 'AP_INVOICES'
              and   zl2.trx_level_type    = 'LINE'
              group by
                zl2.trx_id
              , zl2.trx_line_id
              , zl2.tax
              , zl2.tax_rate_code
              , zl2.tax_rate
             ) zl1
        where zl1.len1 <= 4000 and zl1.len2 <= 4000
      ) zl
    where
        aila.invoice_id                = aia.invoice_id
    and aida.invoice_id                = aila.invoice_id
    and aida.invoice_line_number       = aila.line_number
    and aia.vendor_id                  = asup.vendor_id
    and aia.vendor_site_id             = assa.vendor_site_id
    and haouv.organization_id          = aia.org_id
    and gl.ledger_id                   = aia.set_of_books_id
    and gdct.conversion_type       (+) = aia.exchange_rate_type
    and mufm.unit_of_measure       (+) = aila.unit_meas_lookup_code
    and msi.inventory_item_id      (+) = aila.inventory_item_id
    and msi.org_id                 (+) = aila.org_id
    and zl.trx_id                  (+) = aila.invoice_id
    and zl.trx_line_id             (+) = aila.line_number
  )
, po as
  ( select
      pda.po_distribution_id
    , haouv.name                                       po_operating_unit
    , ( select
          prha.segment1 po_requisition
        from
          po_req_distributions_all         prda
        , po_requisition_lines_all         prla
        , po_requisition_headers_all       prha
        where
            prda.requisition_line_id   = prla.requisition_line_id
        and prla.requisition_header_id = prha.requisition_header_id
        and prda.distribution_id       = pda.req_distribution_id
      )                                                po_requisition_num
    , pha.segment1                                     po_num
    , pra.release_num                                  po_release_num
    , trunc(pha.creation_date)                         po_creation_date
    , pra.release_date                                 po_release_date
    , pla.line_num || '.' || plla.shipment_num         po_line_shipment_num
    , pltv.line_type                                   po_line_type
    , msi.item                                         item
    , msi.item_type
    , msi.description                                  item_description
    , plla.quantity  - nvl(plla.quantity_cancelled,0)  po_shipment_qty_ordered
    , plla.quantity_accepted                           po_shipment_qty_accepted
    , plla.quantity_rejected                           po_shipment_qty_rejected
    , plla.quantity_billed                             po_shipment_qty_billed
    , nvl( mufm.uom_code, plla.unit_meas_lookup_code)  po_uom
    , pda.distribution_num                             po_dist_num
    , pda.quantity_ordered
        - nvl(pda.quantity_cancelled,0)                po_dist_qty_ordered
    , pda.quantity_delivered                           po_dist_qty_delivered
    , pda.quantity_billed                              po_dist_qty_billed
    , mp1.organization_code                            po_ship_to_organization
    , mp2.organization_code                            po_destination_organization
    , pdr.receipt_nums                                 po_dist_receipt_nums
    , msi.inventory_item_id
    , msi.organization_id
    from
      po_distributions_all         pda
    , po_line_locations_all        plla
    , po_lines_all                 pla
    , po_headers_all               pha
    , po_releases_all              pra
    , po_line_types_v              pltv
    , mtl_units_of_measure         mufm
    , mtl_parameters               mp1
    , mtl_parameters               mp2
    , hr_all_organization_units_vl haouv
    , (select
         fspa.org_id
       , msiv.inventory_item_id
       , msiv.segment1                item
       , xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type
       , msiv.description
       , msiv.organization_id
       from
         financials_system_params_all fspa
       , mtl_system_items_vl          msiv
       where
           msiv.organization_id = fspa.inventory_organization_id
       )                           msi
    , (select distinct
         po_line_location_id
       , po_distribution_id
       , listagg(receipt_num,',') within group (order by receipt_num) over (partition by po_line_location_id,po_distribution_id) receipt_nums
       from
         (select
            po_line_location_id
          , po_distribution_id
          , receipt_num
          , sum(lengthb(receipt_num)+1) over (partition by po_line_location_id,po_distribution_id order by receipt_num rows between unbounded preceding and current row) len
          from
            (select distinct
               rt.po_line_location_id
             , rt.po_distribution_id
             , rsh.receipt_num
             from
               rcv_transactions rt
             , rcv_shipment_headers rsh
             where
               rsh.shipment_header_id = rt.shipment_header_id and
               rt.po_line_location_id is not null
            )
         )
       where
         len <= 4000
      )  pdr
    where
        pda.po_header_id          = plla.po_header_id
    and pda.po_line_id            = plla.po_line_id
    and pda.line_location_id      = plla.line_location_id
    and plla.po_header_id         = pla.po_header_id
    and plla.po_line_id           = pla.po_line_id
    and pla.po_header_id          = pha.po_header_id
    and haouv.organization_id     = pha.org_id
    and pltv.line_type_id         = pla.line_type_id
    and pra.po_release_id     (+) = plla.po_release_id
    and msi.inventory_item_id (+) = pla.item_id
    and msi.org_id            (+) = pla.org_id
    and mufm.unit_of_measure  (+) = plla.unit_meas_lookup_code
    and mp1.organization_id   (+) = plla.ship_to_organization_id
    and mp2.organization_id   (+) = pda.destination_organization_id
    and pdr.po_line_location_id (+) = pda.line_location_id
    and nvl(pdr.po_distribution_id,pda.po_distribution_id) = pda.po_distribution_id
  )
&l_ico_table
&l_ap_sla_table
&l_inv_sla_table
-- *******************************************
-- ** Main Query Starts Here
-- *******************************************
select
  ap_inv.ledger                         ledger
, ap_inv.operating_unit                 operating_unit
, ap_inv.vendor_name                    vendor_name
, ap_inv.vendor_num                     vendor_num
, ap_inv.vendor_site_code               vendor_site_code
, ap_inv.source                         invoice_source
, ap_inv.invoice_num                    invoice_num
, ap_inv.invoice_date                   invoice_date
, ap_inv.invoice_type                   invoice_type
, ap_inv.invoice_status                 invoice_status
, ap_inv.invoice_description            invoice_description
, ap_inv.invoice_currency_code          currency
, ap_inv.invoice_amount                 invoice_amount
, ap_inv.invoice_acctd_amount           invoice_accounted_amount
, ap_inv.total_tax_amount               invoice_tax_amoumt
, ap_inv.amount_paid                    invoice_paid_amount
, ap_inv.exchange_rate                  exchange_rate
, ap_inv.exchange_rate_type             exchange_rate_type
, ap_inv.exchange_date                  exchange_rate_date
, ap_inv.line_number                    invoice_line_num
, ap_inv.line_type                      invoice_line_type
, ap_inv.line_source                    invoice_line_source
, ap_inv.line_discarded_flag            invoice_line_discarded
&l_item_sel
, ( select distinct
      listagg(micv.category_concat_segs,', ') within group (order by micv.category_concat_segs)
    from   mtl_item_categories_v micv
    where  micv.category_set_id   = :p_category_set_id
    &l_category_set_joins
  )                                     &l_category_set_name
, ap_inv.line_description               invoice_line_description
, ap_inv.line_qty_invoiced              invoice_line_qty
, ap_inv.uom                            uom
, ap_inv.unit_price                     unit_price
, ap_inv.line_amount                    invoice_line_amount
, ap_inv.line_acctd_amount              invoice_line_accounted_amount
, ap_inv.tax_type                       invoice_line_tax_type
, ap_inv.tax_rate_code                  invoice_line_tax_rate_code
, ap_inv.tax_rate                       invoice_line_tax_rate
, ap_inv.dist_line_number               invoice_dist_line_num
, ap_inv.dist_type                      invoice_dist_type
, ap_inv.dist_description               invoice_dist_description
, ap_inv.dist_qty_invoiced              invoice_dist_qty
, ap_inv.dist_amount                    invoice_dist_amount
, ap_inv.dist_acctd_amount              invoice_dist_accounted_amount
, ap_inv.dist_accounting_date           accounting_date
, ap_inv.dist_period                    period_name
, ap_inv.dist_match_type                match_type
, ap_inv.dist_matched_receipt_num       matched_receipt_num
--
&l_ap_sla_sel
&l_inv_sla_sel
--
, po.po_operating_unit
, po.po_requisition_num
, po.po_num
, po.po_release_num
, po.po_creation_date
, po.po_release_date
, po.po_line_shipment_num
, po.po_line_type
, po.po_shipment_qty_ordered
, po.po_shipment_qty_accepted
, po.po_shipment_qty_rejected
, po.po_shipment_qty_billed
, po.po_uom
, po.po_dist_num
, po.po_dist_qty_ordered
, po.po_dist_qty_delivered
, po.po_dist_qty_billed
, po.po_ship_to_organization
, po.po_destination_organization
, po.po_dist_receipt_nums
--
&l_ico_sel
from
  ap_inv
, po
&l_ico_fr
&l_ap_sla_fr
&l_inv_sla_fr
where
  1=1
and po.po_distribution_id         (+) = ap_inv.po_distribution_id
&l_ico_join
&l_ap_sla_join
&l_inv_sla_join
order by 
  ap_inv.ledger
, ap_inv.operating_unit
, trunc(ap_inv.invoice_date)
, ap_inv.invoice_num
, ap_inv.line_number
, ap_inv.dist_line_number
/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Intercompany Invoice Reconciliation
-- Description: Intercompany invoice reconciliation for inventory transactions, including shipping and receiving organizations, ordered, transacted and invoiced quantities, amounts and possible discrepancies.
It also includes all intercompany Receivables (AR) and Payables (AP) invoice details.
-- Excel Examle Output: https://www.enginatics.com/example/inv-intercompany-invoice-reconciliation/
-- Library Link: https://www.enginatics.com/reports/inv-intercompany-invoice-reconciliation/
-- Run Report: https://demo.enginatics.com/

with mmt as -- driving inventory transactions for intercompany
  (
    select
      'Sales Order'                    source_document
    , ooha.ordered_date                source_document_date
    , to_char(ooha.order_number)       source_document_num
    , oe_order_misc_pub.get_concat_line_number(oola.line_id)
                                       source_document_line_num
    , oola.ordered_quantity            source_document_qty
    , oola.order_quantity_uom          source_document_uom
    , 'INTERCOMPANY'                   source_line_context
    , oola.line_id                     source_line_id
    , to_number(hoi.org_information3)  shipping_ou_id
    , oola.org_id                      selling_ou_id
    , mmt.transaction_id
    , mmt.transaction_type_id
    , mmt.transaction_action_id
    , mmt.transaction_date
    , mmt.organization_id
    , mmt.transfer_organization_id
    , mmt.inventory_item_id
    , mmt.transaction_quantity
    , mmt.transaction_uom
    , mmt.primary_quantity
    , mmt.transaction_cost
    , mmt.actual_cost
    , mmt.transfer_price
    , mmt.currency_code
    , mmt.currency_conversion_rate
    , mmt.currency_conversion_type
    , mmt.currency_conversion_date
    , mmt.costed_flag
    , mmt.invoiced_flag
    from
      mtl_material_transactions    mmt
    , hr_organization_information  hoi
    , oe_order_lines_all           oola
    , oe_order_headers_all         ooha
    , mtl_intercompany_parameters  mip
    where
        mmt.transaction_source_type_id        in (2,12)  -- sales order/rma
    and mmt.transaction_action_id               in (1,27)  -- issue from stores/receipt into stores
    and mmt.logical_transactions_created    is null 
    and oola.line_id                         = mmt.trx_source_line_id
    and ooha.header_id                       = oola.header_id
    and hoi.organization_id                  = mmt.organization_id
    and hoi.org_information_context          = 'Accounting Information'
    and mip.ship_organization_id             = to_number(hoi.org_information3)
    and mip.sell_organization_id             = oola.org_id
    union
    select
      'Internal Sales Order'           source_document
    , ooha.ordered_date                source_document_date
    , to_char(ooha.order_number)       source_document_num
    , oe_order_misc_pub.get_concat_line_number(oola.line_id)
                                       source_document_line_num
    , oola.ordered_quantity            source_document_qty
    , oola.order_quantity_uom          source_document_uom
    , 'INTERCOMPANY'                   source_line_context
    , oola.line_id                     source_line_id
    , to_number(hoi1.org_information3) shipping_ou_id
    , to_number(hoi2.org_information3) selling_ou_id
    , mmt.transaction_id
    , mmt.transaction_type_id
    , mmt.transaction_action_id
    , mmt.transaction_date
    , mmt.organization_id
    , mmt.transfer_organization_id
    , mmt.inventory_item_id
    , mmt.transaction_quantity
    , mmt.transaction_uom
    , mmt.primary_quantity
    , mmt.transaction_cost
    , mmt.actual_cost
    , mmt.transfer_price
    , mmt.currency_code
    , mmt.currency_conversion_rate
    , mmt.currency_conversion_type
    , mmt.currency_conversion_date
    , mmt.costed_flag
    , mmt.invoiced_flag
    from
      mtl_material_transactions    mmt
    , oe_order_lines_all           oola
    , oe_order_headers_all         ooha
    , hr_organization_information  hoi1
    , hr_organization_information  hoi2
    , mtl_intercompany_parameters  mip
    where
        mmt.transaction_source_type_id      in (8)     -- internal order
    and mmt.transaction_action_id           in (21)    -- intransit shipment
    and oola.line_id                         = mmt.trx_source_line_id
    and ooha.header_id                       = oola.header_id
    and hoi1.organization_id                 = mmt.organization_id
    and hoi1.org_information_context         = 'Accounting Information'
    and hoi2.organization_id                 = mmt.transfer_organization_id
    and hoi2.org_information_context         = 'Accounting Information'
    and mip.ship_organization_id             = to_number(hoi1.org_information3)
    and mip.sell_organization_id             = to_number(hoi2.org_information3)
    and fnd_profile.value('INV_INTERCOMPANY_INVOICE_INTERNAL_ORDER')
                                             =1
    union
    select
      'Sales Order'                    source_document
    , ooha.ordered_date                source_document_date
    , to_char(ooha.order_number)       source_document_num
    , oe_order_misc_pub.get_concat_line_number(oola.line_id)
                                       source_document_line_num
    , oola.ordered_quantity            source_document_qty
    , oola.order_quantity_uom          source_document_uom
    , 'INTERCOMPANY'                   source_line_context
    , oola.line_id                     source_line_id
    , to_number(hoi1.org_information3) shipping_ou_id
    , to_number(hoi2.org_information3) selling_ou_id
    , mmt.transaction_id
    , mmt.transaction_type_id
    , mmt.transaction_action_id
    , mmt.transaction_date
    , mmt.organization_id
    , mmt.transfer_organization_id
    , mmt.inventory_item_id
    , mmt.transaction_quantity
    , mmt.transaction_uom
    , mmt.primary_quantity
    , mmt.transaction_cost
    , mmt.actual_cost
    , mmt.transfer_price
    , mmt.currency_code
    , mmt.currency_conversion_rate
    , mmt.currency_conversion_type
    , mmt.currency_conversion_date
    , mmt.costed_flag
    , mmt.invoiced_flag
    from
      mtl_material_transactions    mmt
    , oe_order_lines_all           oola
    , oe_order_headers_all         ooha
    , hr_organization_information  hoi1
    , hr_organization_information  hoi2
    , mtl_transaction_flow_headers mtfh
    , mtl_intercompany_parameters  mip
    where
        mmt.transaction_source_type_id      in (13)    -- invenory
    and mmt.transaction_action_id           in (9,14)  -- logical sales order issue/logical sales order receipt
    and mmt.logical_trx_type_code           in (2,5)
    and oola.line_id                         = mmt.trx_source_line_id
    and ooha.header_id                       = oola.header_id
    and hoi1.organization_id                 = mmt.organization_id
    and hoi1.org_information_context         = 'Accounting Information'
    and hoi2.organization_id                 = mmt.transfer_organization_id
    and hoi2.org_information_context         = 'Accounting Information'
    and mtfh.header_id                       = mmt.trx_flow_header_id
    and mtfh.flow_type                       = 1
    and mip.ship_organization_id             = to_number(hoi1.org_information3)
    and mip.sell_organization_id             = to_number(hoi2.org_information3)
    union
    select
      'Purchase Order'                 source_document
    , pha.creation_date                source_document_date
    , pha.segment1                     source_document_num
    , pla.line_num || '.' || plla.shipment_num
                                       source_document_line_num
    , plla.quantity  - nvl(plla.quantity_cancelled,0)
                                       source_document_qty
    , nvl( ( select mufm.uom_code
             from  mtl_units_of_measure mufm
             where mufm.unit_of_measure = plla.unit_meas_lookup_code
             and   rownum <= 1
            )
         ,  plla.unit_meas_lookup_code
         )                             source_document_uom
    , 'GLOBAL_PROCUREMENT'             source_line_context
    , plla.line_location_id            source_line_id
    , to_number(hoi1.org_information3) shipping_ou_id
    , to_number(hoi2.org_information3) selling_ou_id
    , mmt.transaction_id
    , mmt.transaction_type_id
    , mmt.transaction_action_id
    , mmt.transaction_date
    , mmt.organization_id
    , mmt.transfer_organization_id
    , mmt.inventory_item_id
    , mmt.transaction_quantity
    , mmt.transaction_uom
    , mmt.primary_quantity
    , mmt.transaction_cost
    , mmt.actual_cost
    , mmt.transfer_price
    , mmt.currency_code
    , mmt.currency_conversion_rate
    , mmt.currency_conversion_type
    , mmt.currency_conversion_date
    , mmt.costed_flag
    , mmt.invoiced_flag
    from
      mtl_material_transactions    mmt
    , po_headers_all               pha
    , rcv_transactions             rt
    , po_line_locations_all        plla
    , po_lines_all                 pla
    , hr_organization_information  hoi1
    , hr_organization_information  hoi2
    , mtl_transaction_flow_headers mtfh
    , mtl_intercompany_parameters  mip
    where
        mmt.transaction_source_type_id      in (13)    -- invenory
    and mmt.transaction_action_id           in (9,14)  -- logical sales order issue/logical sales order receipt
    and mmt.logical_trx_type_code           in (1,3)
    and pha.po_header_id                     = mmt.transaction_source_id
    and rt.transaction_id                (+) = mmt.rcv_transaction_id
    and plla.line_location_id            (+) = rt.po_line_location_id
    and pla.po_line_id                   (+) = rt.po_line_id
    and hoi1.organization_id                 = mmt.organization_id
    and hoi1.org_information_context         = 'Accounting Information'
    and hoi2.organization_id                 = mmt.transfer_organization_id
    and hoi2.org_information_context         = 'Accounting Information'
    and mtfh.header_id                       = mmt.trx_flow_header_id
    and mtfh.flow_type                       = 2
    and mip.ship_organization_id             = to_number(hoi1.org_information3)
    and mip.sell_organization_id             = to_number(hoi2.org_information3)
  )
, ar_ico as
  ( select
      rctla.interface_line_context
    , rctla.interface_line_attribute6
    , rctla.interface_line_attribute7
    , rctla.customer_trx_id
    , rctla.customer_trx_line_id
    , hp.party_name            customer_name
    , hca.account_number       customer_num
    , hcsua.location           customer_location
    , apsa.trx_number
    , apsa.trx_date
    , apsa.invoice_currency_code
    , case apsa.status
      when 'OP' then 'Open'
      when 'CL' then 'Closed'
                else apsa.status
      end   status
    , apsa.amount_due_original
    , apsa.tax_original
    , apsa.exchange_rate
    , apsa.exchange_rate_type
    , apsa.exchange_date
    , rctla.line_number
    , rctla.quantity_invoiced
    , rctla.uom_code
    , rctla.unit_selling_price
    , rctla.extended_amount
    from
      ra_customer_trx_lines_all    rctla
    , ra_customer_trx_all          rcta
    , ar_payment_schedules_all     apsa
    , hz_cust_accounts             hca
    , hz_parties                   hp
    , hz_cust_site_uses_all        hcsua
    where
        rctla.interface_line_context  in ('INTERCOMPANY','GLOBAL_PROCUREMENT')
    and rctla.line_type                = 'LINE'
    and rcta.customer_trx_id           = rctla.customer_trx_id
    and apsa.customer_trx_id           = rctla.customer_trx_id
    and hca.cust_account_id            = rcta.bill_to_customer_id
    and hp.party_id                    = hca.party_id
    and hcsua.site_use_id              = rcta.bill_to_site_use_id
  )
, ar_intf as -- ar interface data
  ( select
      rila.interface_line_context
    , rila.interface_line_attribute6
    , rila.interface_line_attribute7
    , rila.interface_line_id
    , rila.interface_status
    , rila.request_id
    , listagg(riea.message_text,chr(10))
      within group (order by riea.message_text)
      over (partition by rila.interface_line_context,rila.interface_line_attribute6,rila.interface_line_attribute7,rila.interface_line_id,rila.interface_status,rila.request_id) error
    from
      ra_interface_lines_all  rila
    , (select distinct
         interface_line_id
       , message_text
       from
         ra_interface_errors_all
       )                      riea
    where
        rila.interface_line_id          = riea.interface_line_id (+)
    and nvl(rila.interface_status,'U') != 'P'
  )
, ap_ico as -- ap invoice data
  ( select
      aia.reference_1          customer_trx_id
    , aila.reference_1         customer_trx_line_id
    , aia.invoice_id
    , asup.vendor_name
    , asup.segment1            vendor_num
    , assa.vendor_site_code
    , aia.invoice_num
    , aia.invoice_date
    , aia.invoice_currency_code
    , aia.invoice_amount
    , aia.total_tax_amount
    , aia.amount_paid
    , aia.exchange_rate
    , aia.exchange_rate_type
    , aia.exchange_date
    , aila.line_number
    , aila.quantity_invoiced
    , nvl( ( select mufm.uom_code
             from  mtl_units_of_measure mufm
             where mufm.unit_of_measure = aila.unit_meas_lookup_code
             and   rownum <= 1
            )
         ,  aila.unit_meas_lookup_code
         )                     unit_meas_lookup_code
    , aila.unit_price
    , aila.amount              line_amount
    from
      ap_invoices_all          aia
    , ap_invoice_lines_all     aila
    , ap_suppliers             asup
    , ap_supplier_sites_all    assa
    where
        aila.invoice_id                  = aia.invoice_id
    and aia.vendor_id                    = asup.vendor_id
    and aia.vendor_site_id               = assa.vendor_site_id
    and aia.source                       = 'Intercompany'
    and aila.line_type_lookup_code       = 'ITEM'
    and nvl(aila.discarded_flag,'N')     = 'N'
  )
, ap_intf as -- ap interface data
  (
    select
      aii.reference_1     customer_trx_id
    , aili.reference_1    customer_trx_line_id
    , aii.invoice_id
    , aii.status
    , aii.request_id
    , listagg(air1.reject_lookup_code,chr(10))
      within group (order by air1.reject_lookup_code)
      over (partition by aii.reference_1,aili.reference_1,aii.invoice_id,aii.status,aii.request_id) error_h
    , listagg(air2.reject_lookup_code,chr(10))
      within group (order by air2.reject_lookup_code)
      over (partition by aii.reference_1,aili.reference_1,aii.invoice_id,aii.status,aii.request_id) error_l
    from
      ap_invoices_interface      aii
    , ap_invoice_lines_interface aili
    , (select distinct
         parent_table
       , parent_id
       , reject_lookup_code
       from
         ap_interface_rejections
       where
         parent_table = 'AP_INVOICES_INTERFACE'
       )    air1
    , (select distinct
         parent_table
       , parent_id
       , reject_lookup_code
       from
         ap_interface_rejections
       where
         parent_table = 'AP_INVOICE_LINES_INTERFACE'
       )    air2
    where
        aii.invoice_id           = aili.invoice_id
    and air1.parent_id       (+) = aii.invoice_id
    and air2.parent_id       (+) = aili.invoice_line_id
    and aii.source       = 'Intercompany'
    and aii.status      != 'PROCESSED'
  )
-- ******************************************************
-- main query start here
-- ******************************************************
select
   &lp_select_columns1
   &lp_select_columns2
from
  mmt                          mmt   -- inventory material transaction
, mtl_trx_types_view           mttv
, mtl_system_items_kfv         msik
, mtl_parameters               mp1
, mtl_parameters               mp2
, hr_all_organization_units    haou1
, hr_all_organization_units    haou2
, ar_intf                      ar_intf  -- ar invoice interface lines
, ar_ico                       ar_ico   -- ar ico invoices
, ap_intf                      ap_intf  -- ap invoice interface
, ap_ico                       ap_ico   -- ap ico invoices
where
-- inventory
    mmt.transaction_type_id                = mttv.transaction_type_id
and mmt.organization_id                    = msik.organization_id
and mmt.inventory_item_id                  = msik.inventory_item_id
and mmt.organization_id                    = mp1.organization_id
and mmt.transfer_organization_id           = mp2.organization_id (+)
and mmt.shipping_ou_id                     = haou1.organization_id
and mmt.selling_ou_id                      = haou2.organization_id
-- ar interface
and ar_intf.interface_line_context     (+) = mmt.source_line_context
and ar_intf.interface_line_attribute6  (+) = to_char(mmt.source_line_id)
and ar_intf.interface_line_attribute7  (+) = to_char(mmt.transaction_id)
-- ar invoice
and ar_ico.interface_line_context      (+) = mmt.source_line_context
and ar_ico.interface_line_attribute6   (+) = to_char(mmt.source_line_id)
and ar_ico.interface_line_attribute7   (+) = to_char(mmt.transaction_id)
-- ap interface
and ap_intf.customer_trx_id            (+) = to_char(ar_ico.customer_trx_id)
and ap_intf.customer_trx_line_id       (+) = to_char(ar_ico.customer_trx_line_id)
-- ap invoice
and ap_ico.customer_trx_id             (+) = to_char(ar_ico.customer_trx_id)
and ap_ico.customer_trx_line_id        (+) = to_char(ar_ico.customer_trx_line_id)
--
and 1=1
&lp_group_by_columns
order by
  haou1.name
, haou2.name
, ar_ico.trx_date
, ar_ico.trx_number
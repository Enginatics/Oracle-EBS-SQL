/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Intercompany Invoice Details
-- Description: AP Intercompany Invoice Details

-- Excel Examle Output: https://www.enginatics.com/example/ap-intercompany-invoice-details/
-- Library Link: https://www.enginatics.com/reports/ap-intercompany-invoice-details/
-- Run Report: https://demo.enginatics.com/

select
      gl.name                                    ledger
    , hou.name                                   operating_unit
    , aia.source                                 invoice_source
    , aps.vendor_name
    , aps.segment1                               vendor_num
    , assa.vendor_site_code
    , aia.invoice_num
    , xxen_util.meaning(aia.invoice_type_lookup_code,'INVOICE TYPE',200)
                                                 invoice_type
    , aia.invoice_date
    , xxen_util.ap_invoice_status(aia.invoice_id,aia.invoice_amount,aia.payment_status_flag,aia.invoice_type_lookup_code,aia.validation_request_id)
                                                 invoice_status
    , xxen_util.client_time(aia.creation_date)   invoice_creation_date
    , aida.accounting_date                       accounting_date
    , aida.period_name                           period
    , aia.invoice_amount                         invoice_amount
    , aia.total_tax_amount                       invoice_tax_amount
    , aia.amount_paid                            invoice_paid_amount
    , aia.invoice_currency_code
    , aia.exchange_rate
    , aia.exchange_rate_type
    , aia.exchange_date
    , nvl(aia.base_amount,aia.invoice_amount)    invoice_acctd_amount
    , aia.cancelled_date                         invoice_cancelled_date
    , aia.cancelled_amount                       invoice_cancelled_amount
    , aila.line_number
    , msik.product
    , msik.product_description
    , aila.description                           invoice_line_description
    , aila.quantity_invoiced
    , nvl( ( select mufm.uom_code
             from  mtl_units_of_measure mufm
             where mufm.unit_of_measure = aila.unit_meas_lookup_code
             and   rownum <= 1
            )
         ,  aila.unit_meas_lookup_code
         )                                       unit_meas_lookup_code
    , aila.unit_price
    , aila.amount                                line_amount
    , aida.distribution_line_number
    , gcck.concatenated_segments                 distribution_account
    , aida.amount                                distribution_amount
    , aida.base_amount                           distribution_acctd_amount
    , aia.invoice_id
    , aia.reference_1                            customer_trx_id
    , aila.reference_1                           customer_trx_line_id
    from
      ap_invoices_all              aia
    , ap_invoice_lines_all         aila
    , ap_invoice_distributions_all aida
    , ap_suppliers                 aps
    , ap_supplier_sites_all        assa
    , hr_operating_units           hou
    , gl_ledgers                   gl
    , gl_code_combinations_kfv     gcck
    , ( select msik.inventory_item_id
             , msik.concatenated_segments product
             , msik.description           product_description
        from   mtl_system_items_kfv       msik
        where  msik.organization_id =
               (select mp.master_organization_id
                from   mtl_parameters mp
                where  rownum <= 1
               )
       )                           msik
    where
        aia.invoice_id                   = aila.invoice_id
    and aila.invoice_id                  = aida.invoice_id (+)
    and aila.line_number                 = aida.invoice_line_number (+)
    and aia.vendor_id                    = aps.vendor_id
    and aia.vendor_site_id               = assa.vendor_site_id
    and aia.set_of_books_id              = gl.ledger_id
    and aia.org_id                       = hou.organization_id
    and aila.inventory_item_id           = msik.inventory_item_id (+)
    and aida.dist_code_combination_id    = gcck.code_combination_id (+)
    and aia.source                       = 'Intercompany'
    and aila.line_type_lookup_code       = 'ITEM'
    and nvl(aila.discarded_flag,'N')     = 'N'
    and 1=1
    order by
      gl.name
    , hou.name
    , aps.vendor_name
    , assa.vendor_site_code
    , aia.invoice_date
    , aia.invoice_num
    , aila.line_number
    , aida.distribution_line_number
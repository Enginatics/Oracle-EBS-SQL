/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Invoice Price Variance
-- Description: Report to display the Invoice Price Variances (IPV), Exchange Rate Variances (ERV) and A/P Accrual Write-Off Variances for an entered date range.  IPV is the difference between the PO unit price and the invoice unit cost times the quantity invoiced.  ERV is the difference between the purchase order exchange rate and the exchange rate used by the A/P invoice.  For a given invoice line, both the IPV and ERV amounts will be shown on the same row, in separate columns.  These entries have the Type "IPV-ERV".  The A/P Accrual Write-Off Variances appear as separate rows with the Type "INV WO" for invoice write-off amounts.  The A/P Accrual Write-Off Variances typically use the IPV account so for completeness, are also displayed on this report.  

/* +=============================================================================+
-- |  Copyright 2006-2021 Douglas Volz Consulting, Inc.                          |
-- |  All rights reserved.                                                       |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_ipv_rept.sql
-- |
-- |  Parameters:
-- |  p_trx_date_from        -- starting accounting date for the payables invoices
-- |  p_trx_date_to          -- ending accounting date for the payables invoices
-- |  p_category_set1        -- The first item category set to report, typically the
-- |                            Cost or Product Line Category Set
-- |  p_category_set2        -- The second item category set to report, typically the
-- |                            Inventory Category Set 
-- |  p_vendor_name          -- Vendor you want to report (optional)
-- |  p_operating_unit       -- Operating Unit you wish to report, leave blank for all
-- |                            operating units (optional) 
-- |  p_ledger               -- general ledger you wish to report, leave blank for all
-- |                            ledgers (optional)
-- |
-- |  Description:
-- |  Report to display the invoice price variances for an entered date range.
-- |  IPV is the difference between the PO unit price and the invoice unit
-- |  cost times the quantity invoiced.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     01 Jun 2006 Douglas Volz   Initial Coding based on XXX_IPV_REPT.sql
-- |  1.1     17 Apr 2010 Douglas Volz   Modified for Release 12 for Client, the IPV
-- |                                     columns are now null as a new line type
-- |                                     exists for IPV in AID, and the amount columns
-- |                                     only have the PO amounts, not the total invoice
-- |                                     amount.
-- |  1.11    22 May 2017 Douglas Volz   Added product type, business code, product family and
-- |                                     and product line inventory categories
-- |  1.12    20 Jul 2019 Douglas Volz   Removed all item categories except COSTING.
-- |  1.13    18 Feb 2021 Douglas Volz   Changed to multi-org views for items, categories
-- |                                     and HR organizations.
-- |  1.14    12 Apr 2021 Douglas Volz   Removed redundant joins and tables to improve performance.
-- +=============================================================================+*/

-- Excel Examle Output: https://www.enginatics.com/example/cac-invoice-price-variance/
-- Library Link: https://www.enginatics.com/reports/cac-invoice-price-variance/
-- Run Report: https://demo.enginatics.com/

select gl.name Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 ap_txns.period_name Period_Name,
&segment_columns
 -- Revision for version 1.8
 ap_txns.type Type,
 flv.meaning Accounting_Class_Code,
 -- End revision for version 1.8
 pov.vendor_name Supplier,
 he.full_name Buyer,
 msiv.concatenated_segments Item_Number,
 msiv.description Item_Description,
 -- Revision for version 1.11 and 1.12
&category_columns
 -- End revision for version 1.11
 pl.displayed_field Destination_Type,
 poh.segment1 PO_Number,
 to_char(pol.line_num) PO_Line,
 pr.release_num PO_Release,
 api.invoice_num Invoice_Number,
 -- Revision for version 1.8
 -- Decode to enable a null value for the additional union all for A/P Accrual Write-Offs
 -- ap_txns.ipv_distribution_line_number IPV_Inv._Line,
 -- ap_txns.erv_distribution_line_number ERV_Inv._Line,
 decode(ap_txns.ipv_distribution_line_number, 0, null, ap_txns.ipv_distribution_line_number)  IPV_Invoice_Line,
 decode(ap_txns.erv_distribution_line_number, 0, null, ap_txns.erv_distribution_line_number) ERV_Invoice_Line,
 -- End revision for version 1.8
 api.invoice_date Invoice_Date,
 ap_txns.accounting_date Accounting_Date,
 pol.unit_meas_lookup_code PO_UOM,
 ap_txns.quantity_invoiced * ucr.conversion_rate  Invoice_Quantity,
 nvl(poh.currency_code, gl.currency_code) PO_Currency_Code,
 pll.price_override PO_Unit_Price,
 nvl(ap_txns.rate,1) PO_Exchange_Rate,
 gl.currency_code GL_Currency_Code,
 round(nvl(ap_txns.rate,1) * pll.price_override,6) Converted_PO_Unit_Price,
 nvl(ap_txns.rate,1) * pll.price_override * (ap_txns.quantity_invoiced * ucr.conversion_rate) Total_PO_Amount,
 nvl(api.invoice_currency_code, gl.currency_code) Invoice_Currency_Code,
 ap_txns.unit_price Payables_Unit_Cost,
 nvl(api.exchange_rate,1) Payables_Exchange_Rate,
 gl.currency_code GL_Currency_Code,
 round(decode(api.exchange_rate,null,nvl(ap_txns.unit_price,0),
                nvl(ap_txns.unit_price,0)*api.exchange_rate),6) Converted_Invoice_Unit_Cost,
 round(decode(api.exchange_rate,null,nvl(ap_txns.unit_price,0),
                nvl(ap_txns.unit_price,0)*api.exchange_rate),6)  -
                  round(nvl(ap_txns.rate,1) * pll.price_override,6) Unit_Cost_Variance,
 round(decode(api.exchange_rate,null,nvl(ap_txns.unit_price,0),
                    nvl(ap_txns.unit_price,0)*api.exchange_rate) * ap_txns.quantity_invoiced * ucr.conversion_rate,2) Total_Invoice_Amount,
    round(  (decode(api.exchange_rate,null,nvl(ap_txns.unit_price,0),
                    nvl(ap_txns.unit_price,0)*api.exchange_rate) * ap_txns.quantity_invoiced * ucr.conversion_rate
                   ) -
     (nvl(ap_txns.rate,1) * pll.price_override * (ap_txns.quantity_invoiced * ucr.conversion_rate)
     ),2) Total_Calculated_IPV,
 ap_txns.ipv_amount General_Ledger_IPV_Amount,
 ap_txns.erv_amount General_Ledger_ERV_Amount,
 round((
  (decode(api.exchange_rate,null,nvl(ap_txns.unit_price,0),
                nvl(ap_txns.unit_price,0)*api.exchange_rate) * ap_txns.quantity_invoiced * ucr.conversion_rate
  ) -
  (nvl(ap_txns.rate,1) * pll.price_override * (ap_txns.quantity_invoiced * ucr.conversion_rate)
  )
 )
       /  abs(decode(nvl(ap_txns.rate,1) * pll.price_override * (ap_txns.quantity_invoiced * ucr.conversion_rate),0,1,nvl(ap_txns.rate,1)
         * pll.price_override * (ap_txns.quantity_invoiced * ucr.conversion_rate))) * 100,1) Percent
from ap_invoices_all                     api,
 ap_system_parameters_all            asp,
 po_vendors                          pov,
 po_headers_all                      poh,
 po_lines_all                        pol,
 po_line_locations_all               pll,
 po_releases_all                     pr,
 mtl_parameters                      mp,
 mtl_system_items_vl                 msiv,
 mtl_uom_conversions_view            ucr,
 gl_code_combinations                gcc1,
 gl_code_combinations                gcc2,
 hr_employees                        he,
 po_lookup_codes                     pl,
 -- Revision for version 1.8
 fnd_lookup_values                   flv,
 -- End revision for version 1.8
 hr_organization_information         hoi,
 hr_all_organization_units_vl        haou,  -- inv_organization_id
 hr_all_organization_units_vl        haou2, -- operating unit
 gl_ledgers                          gl,
 -- =================================================================================
 -- Use inline tables to select information from both the IPV and ERV AID lines 
 -- AID lines of IPV and ERV don't have an invoice quantity but AID Accrual lines do
 -- AID invoice_distribution_id lines for IPV and ERV will join to the correct 
 -- SLA accounting entries, so we need a combination of information from the ACCRUAL,
 -- IPV and ERV AID lines to report the variances correctly
 -- =================================================================================
 -- =================================================================================
 -- Join condensed rows with aid for ACCRUAL AP invoice distribution lines in order
 -- to get the matched_uom_lookup_code, quantity_invoiced and unit_price information
 -- =================================================================================
 (select net_ipv_erv_txns.invoice_id invoice_id,
  net_ipv_erv_txns.period_name period_name,
  net_ipv_erv_txns.accounting_date accounting_date,
  net_ipv_erv_txns.ipv_code_combination_id ipv_code_combination_id,
  net_ipv_erv_txns.erv_code_combination_id erv_code_combination_id,
  -- Revision for version 1.8
  net_ipv_erv_txns.type type,
  net_ipv_erv_txns.accounting_class_code accounting_class_code,
  -- End Revision for version 1.8
  net_ipv_erv_txns.ipv_distribution_line_number ipv_distribution_line_number,
  net_ipv_erv_txns.erv_distribution_line_number erv_distribution_line_number,
  net_ipv_erv_txns.ipv_invoice_distribution_id ipv_invoice_distribution_id,
  net_ipv_erv_txns.erv_invoice_distribution_id erv_invoice_distribution_id,
  net_ipv_erv_txns.invoice_line_number invoice_line_number,
  aid.matched_uom_lookup_code matched_uom_lookup_code,
  net_ipv_erv_txns.po_distribution_id po_distribution_id,
  sum(nvl(aid.quantity_invoiced,0)) quantity_invoiced, -- IPV and ERV lines have no quantity information
  net_ipv_erv_txns.related_id related_id,
  sum(nvl(aid.unit_price,0)) unit_price, -- IPV and ERV lines have no unit price information
  sum(nvl(aid.base_amount,0)) accrual_amount,
  sum(net_ipv_erv_txns.ipv_amount) ipv_amount,
  sum(net_ipv_erv_txns.erv_amount) erv_amount,
  net_ipv_erv_txns.po_line_id po_line_id,
  net_ipv_erv_txns.line_location_id line_location_id,
  net_ipv_erv_txns.rate rate,
  net_ipv_erv_txns.destination_type_code destination_type_code
 from ap.ap_invoice_distributions_all aid,
  -- =================================================================================
  -- Condense into one row per invoice_id, invoice_line_number, related_id
  -- =================================================================================
  (select ipv_erv_txns.invoice_id invoice_id,
   ipv_erv_txns.period_name period_name,
   ipv_erv_txns.accounting_date accounting_date,
   sum(ipv_erv_txns.ipv_code_combination_id) ipv_code_combination_id,
   sum(ipv_erv_txns.erv_code_combination_id) erv_code_combination_id,
   -- Revision for version 1.8
   max(ipv_erv_txns.type) type,
   max(ipv_erv_txns.accounting_class_code) accounting_class_code,
   -- End Revision for version 1.8
   sum(ipv_erv_txns.ipv_distribution_line_number) ipv_distribution_line_number,
   sum(ipv_erv_txns.erv_distribution_line_number) erv_distribution_line_number,
   sum(ipv_erv_txns.ipv_invoice_distribution_id) ipv_invoice_distribution_id,
   sum(ipv_erv_txns.erv_invoice_distribution_id) erv_invoice_distribution_id,
   ipv_erv_txns.invoice_line_number invoice_line_number,
   ipv_erv_txns.matched_uom_lookup_code matched_uom_lookup_code,
   ipv_erv_txns.po_distribution_id po_distribution_id,
   ipv_erv_txns.quantity_invoiced quantity_invoiced, -- IPV and ERV lines have no quantity information
   ipv_erv_txns.related_id related_id,
   ipv_erv_txns.unit_price unit_price, -- IPV and ERV lines have no unit price information
   sum(ipv_erv_txns.accrual_amount) accrual_amount,
   sum(ipv_erv_txns.ipv_amount) ipv_amount,
   sum(ipv_erv_txns.erv_amount) erv_amount,
   ipv_erv_txns.po_line_id po_line_id,
   ipv_erv_txns.line_location_id line_location_id,
   ipv_erv_txns.rate rate,
   ipv_erv_txns.destination_type_code destination_type_code
   -- =================================================================================
   -- Get the Invoice Price Variances and Exchange Rate Variances from aid
   -- =================================================================================
   from
   -- =================================================================================
   -- Get the IPV transactions from AID and join to the SLA tables to get the ccid
   -- Join to PO distributions to get non-EXPENSE entries and foreign key references
   -- =================================================================================
   (select aid.invoice_id invoice_id,
    aid.period_name period_name,
    aid.accounting_date accounting_date,
    al.code_combination_id ipv_code_combination_id,
    null erv_code_combination_id,
    -- Revision for version 1.8
    'IPV-ERV' type,
    al.accounting_class_code accounting_class_code,
    -- End revision for version 1.8
    -- Fix for version 1.9
    -- aid.distribution_line_number ipv_distribution_line_number,
    aid.invoice_line_number ipv_distribution_line_number,
    -- End fix for version 1.9
    null erv_distribution_line_number,
    aid.invoice_distribution_id ipv_invoice_distribution_id,
    null erv_invoice_distribution_id,
    aid.invoice_line_number invoice_line_number,
    aid.line_type_lookup_code line_type_lookup_code,
    aid.matched_uom_lookup_code matched_uom_lookup_code,
    aid.po_distribution_id po_distribution_id,
    aid.quantity_invoiced quantity_invoiced, -- IPV and ERV lines have no quantity information
    aid.related_id related_id,
    aid.unit_price unit_price, -- IPV and ERV lines have no unit price information
    0 accrual_amount,
    aid.base_amount ipv_amount,
    0 erv_amount,
    pod.po_line_id po_line_id,
    pod.line_location_id line_location_id,
    pod.rate rate,
    pod.destination_type_code destination_type_code
    from ap_invoice_distributions_all        aid,
    po_distributions_all                pod,
    -- Revision 1.14, remove tables to increase performance
    -- xla_transaction_entities            ent,
    -- xla_events                          xe,
    -- End revision for version 1.14
    xla_distribution_links              xdl,
    xla_ae_headers                      ah,
    xla_ae_lines                        al
    where aid.line_type_lookup_code    = 'IPV'
    and 2=2                          -- p_trx_date_from, p_trx_date_to
    and aid.po_distribution_id       = pod.po_distribution_id
    and pod.destination_type_code   <> 'EXPENSE'
    -- ========================================================
    -- SLA table joins to get the exact account numbers
    -- ========================================================
    -- Revision for version 1.14, performance improvements
    -- and ent.entity_code              = 'AP_INVOICES'
    -- and ent.application_id           = 200
    -- and xe.application_id            = ent.application_id
    -- and xe.event_id                  = xdl.event_id
    -- and ah.event_id                  = xe.event_id
    -- and ah.entity_id                 = ent.entity_id
    -- and ah.ledger_id                 = ent.ledger_id
    -- and al.application_id            = ent.application_id
    -- and xdl.application_id           = ent.application_id
    -- End revisions for version 1.14
    and ah.application_id            = al.application_id
    and ah.application_id            = 200
    and ah.ae_header_id              = al.ae_header_id
    and al.ledger_id                 = ah.ledger_id
    and al.ae_header_id              = xdl.ae_header_id
    and al.ae_line_num               = xdl.ae_line_num
    and al.accounting_class_code     = 'IPV'
    and xdl.application_id           = 200
    and xdl.source_distribution_type = 'AP_INV_DIST'
    and xdl.source_distribution_id_num_1 = aid.invoice_distribution_id
    union all
   -- =================================================================================
   -- Get the ERV transactions from AID and join to the SLA tables to get the ccid
   -- Join to PO distributions to get non-expense entries and foreign key references
   -- =================================================================================
    select aid.invoice_id invoice_id,
    aid.period_name period_name,
    aid.accounting_date accounting_date,
    null ipv_code_combination_id,
    al.code_combination_id erv_code_combination_id,
    -- Revision for version 1.8
    'IPV-ERV' type,
    al.accounting_class_code accounting_class_code,
    -- End revision for version 1.8
    null ipv_distribution_line_number,
    -- Fix for version 1.9
    aid.invoice_line_number erv_distribution_line_number,
    -- aid.distribution_line_number erv_distribution_line_number,
    -- End fix for version 1.9
    null ipv_invoice_distribution_id,
    aid.invoice_distribution_id erv_invoice_distribution_id,
    aid.invoice_line_number invoice_line_number,
    aid.line_type_lookup_code line_type_lookup_code,
    aid.matched_uom_lookup_code matched_uom_lookup_code,
    aid.po_distribution_id po_distribution_id,
    aid.quantity_invoiced quantity_invoiced, -- IPV and ERV lines have no quantity information
    aid.related_id related_id,
    aid.unit_price unit_price, -- IPV and ERV lines have no unit price information
    0 accrual_amount,
    0 ipv_amount,
    aid.base_amount erv_amount,
    pod.po_line_id po_line_id,
    pod.line_location_id line_location_id,
    pod.rate rate,
    pod.destination_type_code destination_type_code
     from ap_invoice_distributions_all        aid,
    po_distributions_all                pod,
    -- Revision 1.14, remove tables to increase performance
    -- xla_transaction_entities            ent,
    -- xla_events                          xe,
    -- End revision for version 1.14
    xla_distribution_links              xdl,
    xla_ae_headers                      ah,
    xla_ae_lines                        al
     where aid.line_type_lookup_code    =  'ERV'
    and 2=2                          -- p_trx_date_from, p_trx_date_to
    and aid.po_distribution_id       = pod.po_distribution_id
    and pod.destination_type_code   <> 'EXPENSE'
    -- ========================================================
    -- SLA table joins to get the exact account numbers
    -- ========================================================
    -- Revision for version 1.14, performance improvements
    -- and ent.entity_code              = 'AP_INVOICES'
    -- and ent.application_id           = 200
    -- and xe.application_id            = ent.application_id
    -- and xe.event_id                  = xdl.event_id
    -- and ah.event_id                  = xe.event_id
    -- and ah.entity_id                 = ent.entity_id
    -- and ah.ledger_id                 = ent.ledger_id
    -- and al.application_id            = ent.application_id
    -- and xdl.application_id           = ent.application_id
    -- End revisions for version 1.14
    and ah.application_id            = al.application_id
    and ah.application_id            = 200
    and ah.ae_header_id              = al.ae_header_id
    and al.ledger_id                 = ah.ledger_id
    and al.ae_header_id              = xdl.ae_header_id
    and al.ae_line_num               = xdl.ae_line_num
    and al.accounting_class_code     = 'EXCHANGE_RATE_VARIANCE'
    and xdl.application_id           = 200
    and xdl.source_distribution_type = 'AP_INV_DIST'
    and xdl.source_distribution_id_num_1 = aid.invoice_distribution_id) ipv_erv_txns
  group by
   ipv_erv_txns.invoice_id,
   ipv_erv_txns.period_name,
   ipv_erv_txns.accounting_date,
   ipv_erv_txns.invoice_line_number,
   ipv_erv_txns.matched_uom_lookup_code,
   ipv_erv_txns.po_distribution_id,
   ipv_erv_txns.quantity_invoiced,
   ipv_erv_txns.related_id,
   ipv_erv_txns.unit_price,
   ipv_erv_txns.po_line_id,
   ipv_erv_txns.line_location_id,
   ipv_erv_txns.rate,
   ipv_erv_txns.destination_type_code) net_ipv_erv_txns
 where aid.line_type_lookup_code    =  'ACCRUAL'
 and aid.related_id               = net_ipv_erv_txns.related_id
 group by
  net_ipv_erv_txns.invoice_id,
  net_ipv_erv_txns.period_name,
  net_ipv_erv_txns.accounting_date,
  net_ipv_erv_txns.ipv_code_combination_id,
  net_ipv_erv_txns.erv_code_combination_id,
  -- Revision for version 1.8
  net_ipv_erv_txns.type,
  net_ipv_erv_txns.accounting_class_code,
  -- End Revision for version 1.8
  net_ipv_erv_txns.ipv_distribution_line_number,
  net_ipv_erv_txns.erv_distribution_line_number,
  net_ipv_erv_txns.ipv_invoice_distribution_id,
  net_ipv_erv_txns.erv_invoice_distribution_id,
  net_ipv_erv_txns.invoice_line_number,
  aid.matched_uom_lookup_code,
  net_ipv_erv_txns.po_distribution_id,
  net_ipv_erv_txns.related_id,
  net_ipv_erv_txns.po_line_id,
  net_ipv_erv_txns.line_location_id,
  net_ipv_erv_txns.rate,
  net_ipv_erv_txns.destination_type_code) ap_txns
-- ===================================================================
-- Join the condensed and summarized AP IPV and ERV transactions
-- with the rest of the information needed to report IPV and ERV
-- ===================================================================
where api.invoice_id               = ap_txns.invoice_id
and asp.org_id                   = to_number(hoi.org_information3)
and asp.org_id                   = api.org_id
and asp.org_id                   = poh.org_id
and pol.po_line_id               = ap_txns.po_line_id
and poh.po_header_id             = pol.po_header_id
and pll.line_location_id         = ap_txns.line_location_id
and pll.po_line_id               = pol.po_line_id     
and pll.po_release_id            = pr.po_release_id (+)
and pov.vendor_id                = poh.vendor_id
and msiv.inventory_item_id       = pol.item_id
and msiv.inventory_item_id       = ucr.inventory_item_id
and msiv.organization_id         = ucr.organization_id
and ucr.unit_of_measure          = pol.unit_meas_lookup_code
and mp.organization_id           = msiv.organization_id
and msiv.organization_id         = pll.ship_to_organization_id
and gcc1.code_combination_id (+) = ap_txns.ipv_code_combination_id
and gcc2.code_combination_id (+) = ap_txns.erv_code_combination_id
and poh.agent_id                 = he.employee_id
and pl.lookup_type               = 'DESTINATION TYPE'
and pl.lookup_code               = ap_txns.destination_type_code
-- Added for version 1.8
and flv.lookup_type              = 'XLA_ACCOUNTING_CLASS'
and flv.lookup_code              = ap_txns.accounting_class_code
and flv.language                 = userenv('lang')
-- End revision for version 1.8
-- End revision for version 1.10
--and nvl((round(decode(api.exchange_rate, 
--    null, nvl(ap_txns.unit_price,0),
--           nvl(aid_txns.unit_price,0)*api.exchange_rate),4) * aid_txns.quantity_invoiced) -
--   (nvl(aid_txns.rate,1) * pll.price_override * aid_txns.quantity_invoiced),0) <> 0
-- ===================================================================
-- using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ===================================================================
and hoi.org_information_context  = 'Accounting Information'
and hoi.organization_id          = mp.organization_id
and hoi.organization_id          = haou.organization_id   -- this gets the organization name
and haou2.organization_id        = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                 = to_number(hoi.org_information1) 
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and 1=1                          -- p_operating_unit, p_ledger
and 3=3                          -- p_vendor_name
-- ===================================================================
-- Revision for version 1.8
-- Include A/P Accrual Write-Offs on this report
-- ===================================================================
union all
select gl.name Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 wo_txns.period_name Period_Name,
&segment_columns2
 wo_txns.write_off_type Type,
 flv.meaning Accounting_Class_Code,
 wo_txns.vendor_name Supplier,
 wo_txns.full_name Buyer,
 wo_txns.item_number Item_Number,
 wo_txns.item_description Item_Description,
 -- Revision for version 1.11 and 1.12
&category_columns2
 -- End revision for version 1.11
 pl.displayed_field Destination_Type,
 wo_txns.po_num PO_Number,
 wo_txns.po_line_num PO_Line,
 wo_txns.release_num PO_Release,
 wo_txns.invoice_num Invoice_Number,
 decode(wo_txns.ipv_distribution_line_number, 0, null, wo_txns.ipv_distribution_line_number)  IPV_Invoice_Line,
 decode(wo_txns.erv_distribution_line_number, 0, null, wo_txns.erv_distribution_line_number) ERV_Invoice_Line,
 wo_txns.invoice_date Invoice_Date,
 wo_txns.accounting_date Accounting_Date,
 wo_txns.unit_meas_lookup_code PO_UOM,
 wo_txns.quantity_invoiced * wo_txns.conversion_rate  Invoice_Quantity,
 nvl(wo_txns.currency_code, gl.currency_code) PO_Currency_Code,
 wo_txns.price_override PO_Unit_Price,
 nvl(wo_txns.rate,1) PO_Exchange_Rate,
 gl.currency_code GL_Currency_Code,
 round(nvl(wo_txns.rate,1) * wo_txns.price_override,6) Converted_PO_Unit_Price,
 nvl(wo_txns.rate,1) * wo_txns.price_override * (wo_txns.quantity_invoiced * wo_txns.conversion_rate) Total_PO_Amount,
 nvl(wo_txns.invoice_currency_code, gl.currency_code) Invoice_Currency_Code,
 wo_txns.unit_price Payables_Unit_Cost,
 nvl(wo_txns.exchange_rate,1) Payables_Exchange_Rate,
 gl.currency_code GL_Currency_Code,
 round(decode(wo_txns.exchange_rate,null,nvl(wo_txns.unit_price,0),
                nvl(wo_txns.unit_price,0)*wo_txns.exchange_rate),6) Converted_Invoice_Unit_Cost,
 0 Unit_Cost_Variance,
 round(decode(wo_txns.exchange_rate,null,nvl(wo_txns.unit_price,0),
                    nvl(wo_txns.unit_price,0)*wo_txns.exchange_rate) * wo_txns.quantity_invoiced * wo_txns.conversion_rate,2) Total_Invoice_Amount,
 round(  (decode(wo_txns.exchange_rate,null,nvl(wo_txns.unit_price,0),
                    nvl(wo_txns.unit_price,0)*wo_txns.exchange_rate) * wo_txns.quantity_invoiced * wo_txns.conversion_rate
                ) -
         (nvl(wo_txns.rate,1) * wo_txns.price_override * (wo_txns.quantity_invoiced * wo_txns.conversion_rate)
      ),2) Total_Calculated_IPV,
 wo_txns.ipv_amount General_Ledger_IPV_Amount,
 wo_txns.erv_amount General_Ledger_ERV_Amount,
 round((
  (decode(wo_txns.exchange_rate,null,nvl(wo_txns.unit_price,0),
                nvl(wo_txns.unit_price,0)*wo_txns.exchange_rate) * wo_txns.quantity_invoiced * wo_txns.conversion_rate
  ) -
  (nvl(wo_txns.rate,1) * wo_txns.price_override * (wo_txns.quantity_invoiced * wo_txns.conversion_rate)
  )
 )
       /  abs(decode(nvl(wo_txns.rate,1) * wo_txns.price_override * (wo_txns.quantity_invoiced * wo_txns.conversion_rate),0,1,nvl(wo_txns.rate,1)
         * wo_txns.price_override * (wo_txns.quantity_invoiced * wo_txns.conversion_rate))) * 100,1) Percent
from mtl_parameters                      mp,
 hr_organization_information         hoi,
 hr_all_organization_units_vl        haou,  -- inv_organization_id
 hr_all_organization_units_vl        haou2, -- operating unit
 gl_ledgers                          gl,
 gl_code_combinations                gcc1,
 po_lookup_codes                     pl,
 fnd_lookup_values                   flv,
 -- =================================================================================
 -- Use union all selects to get the following Accrual Write-Offs:  rows that have
 -- and inventory_transaction_id (from mtl_material_transactions), rows that have
 -- a PO distribution ID (may be from AP, PO or Receiving), or rows which have a
 -- invoice_distribution_id (from A/P which is not matched to a PO line).
 -- =================================================================================
 -- =================================================================================
 -- 1.0 union all
 -- Get the Accrual Write-Offs which join to an Inventory Transaction_Id (mmt and mta)
 -- =================================================================================
 (select null vendor_name,
  fu.user_name full_name,
  msiv.organization_id,
  ah.period_name,
  msiv.concatenated_segments item_number,
  -- Revision for version 1.11
  msiv.inventory_item_id,
  msiv.description item_description,
  cwo.destination_type_code destination_type_code,
  al.code_combination_id,
  cwo.offset_account_id,
  cwo.accrual_account_id,
  cwo.write_off_id,
  'INV WO' write_off_type,
  al.accounting_class_code,
  null po_num,
  null po_line_num,
  null release_num,
  null invoice_num,
  -- Set to value of 0 so the union all works with no errors
  0 ipv_distribution_line_number,
  0 erv_distribution_line_number,
  ml.meaning accounting_line_type,
  mmt.transaction_id,
  null invoice_date,
  cwo.transaction_date accounting_date,
  msiv.primary_unit_of_measure unit_meas_lookup_code,
  mta.primary_quantity quantity_invoiced,
  nvl(cwo.currency_conversion_rate,1) conversion_rate,
  cwo.currency_code,
  mmt.actual_cost price_override,
  nvl(mmt.currency_conversion_rate,1) rate,
  null invoice_currency_code,
  0 unit_price,
  1 exchange_rate,
  sum(nvl(al.accounted_dr,0) - nvl(al.accounted_cr,0)) ipv_amount,
  sum(0) erv_amount
  from cst_write_offs                      cwo,
  mtl_material_transactions           mmt,
  mtl_transaction_accounts            mta,
  mtl_system_items_vl                 msiv,
  mtl_uom_conversions_view            ucr,
  mfg_lookups                         ml,
  fnd_user                            fu,
  -- Revision 1.14, remove tables to increase performance
  -- xla_transaction_entities            ent,
  -- xla_events                          xe,
  -- End revision for version 1.14
  xla_distribution_links              xdl,
  xla_ae_headers                      ah,
  xla_ae_lines                        al
  where cwo.transaction_date        >= :p_trx_from         -- p_trx_date_from
  and cwo.transaction_date        <  :p_trx_to           -- p_trx_date_to
  and cwo.inventory_transaction_id = mmt.transaction_id
  and mmt.transaction_id           = mta.transaction_id
  and mta.reference_account        = cwo.accrual_account_id
  and mmt.created_by               = fu.user_id
  and msiv.inventory_item_id       = mmt.inventory_item_id
  and msiv.organization_id         = mta.organization_id
  and msiv.inventory_item_id       = ucr.inventory_item_id
  and msiv.organization_id         = ucr.organization_id
  and ml.lookup_type               = 'CST_ACCOUNTING_LINE_TYPE'
  and ml.lookup_code               = mta.accounting_line_type
  -- ========================================================
  -- SLA table joins to get the exact account numbers
  -- ========================================================
  -- Revision for version 1.14, performance improvements
  -- and ent.entity_code              = 'WO_ACCOUNTING_EVENTS'
  -- and ent.application_id           = 707
  -- and xe.application_id            = ent.application_id
  -- and xe.event_id                  = xdl.event_id
  -- and ah.event_id                  = xe.event_id
  -- and ah.entity_id                 = ent.entity_id
  -- and ah.ledger_id                 = ent.ledger_id
  -- and al.application_id            = ent.application_id
  -- and xdl.application_id           = ent.application_id
  -- End revisions for version 1.14
  and ah.application_id            = al.application_id
  and ah.application_id            = 707
  and ah.ae_header_id              = al.ae_header_id
  and al.ledger_id                 = ah.ledger_id 
  and al.ae_header_id              = xdl.ae_header_id
  and al.ae_line_num               = xdl.ae_line_num
  and xdl.application_id           = 707
  and xdl.source_distribution_type = 'CST_WRITE_OFFS'
  and xdl.source_distribution_id_num_1 = cwo.write_off_id 
  group by
  null, -- vendor_name
  fu.user_name, -- full_name
  msiv.organization_id,
  ah.period_name,
  msiv.concatenated_segments, -- item_number
  -- Revision for version 1.11
  msiv.inventory_item_id,
  msiv.description, -- item_description
  cwo.destination_type_code, -- destination_type_code
  al.code_combination_id,
  cwo.offset_account_id,
  cwo.accrual_account_id,
  cwo.write_off_id,
  'INV WO', -- Accrual Write-Off Type
  al.accounting_class_code,
  null, -- po_num
  null, -- po_line_num
  null, -- release_num
  null, -- invoice_num
  -- Set to value of 0 so the union all works with no errors
  0, -- ipv_distribution_line_number
  0, -- erv_distribution_line_number
  ml.meaning, -- accounting_line_type
  mmt.transaction_id,
  null, -- invoice_date
  cwo.transaction_date, -- accounting_date,
  msiv.primary_unit_of_measure,  -- unit_meas_lookup_code
  mta.primary_quantity, -- quantity_invoiced
  nvl(cwo.currency_conversion_rate,1), -- conversion_rate
  cwo.currency_code,
  mmt.actual_cost, -- price_override
  nvl(mmt.currency_conversion_rate,1), -- rate
  null, -- invoice_currency_code
  0,  -- unit_price
  1  -- exchange_rate
 -- =================================================================================
 -- 2.0 union all
 -- Get the Accrual Write-Offs which join to a purchase order line and which join
 -- to an item number (cannot have more than one outer-join per select).  This
 -- select will get both INVENTORY and EXPENSE destination type codes.
 -- =================================================================================
  union all
  select pov.vendor_name vendor_name,
  he.full_name full_name,
  msiv.organization_id,
  ah.period_name,
  msiv.concatenated_segments item_number,
  -- Revision for version 1.11
  msiv.inventory_item_id,
  msiv.description item_description,
  cwo.destination_type_code destination_type_code,
  al.code_combination_id,
  cwo.offset_account_id,
  cwo.accrual_account_id,
  cwo.write_off_id,
  'AP-PO WO' write_off_type,
  al.accounting_class_code,
  poh.segment1 po_num,
  to_char(pol.line_num) po_line_num,
  pr.release_num release_num,
  null invoice_num,
  -- Set to value of 0 so the union all works with no errors
  0 ipv_distribution_line_number,
  0 erv_distribution_line_number,
  null accounting_line_type,
  null transaction_id,
  null invoice_date,
  cwo.transaction_date accounting_date,
  pol.unit_meas_lookup_code,
  0 quantity_invoiced,
  nvl(cwo.CURRENCY_conversion_rate,1) conversion_rate,
  cwo.currency_code,
  pll.price_override price_override,
  nvl(pod.rate, poh.rate) rate,
  null invoice_currency_code,
  0 unit_price,
  1 exchange_rate,
  sum(nvl(al.accounted_dr,0) - nvl(al.accounted_cr,0)) ipv_amount,
  sum(0) erv_amount
  from cst_write_offs                       cwo,
  po_distributions_all                 pod,
  po_vendors                           pov,
  po_headers_all                       poh,
  po_lines_all                         pol,
  po_line_locations_all                pll,
  po_releases_all                      pr,
  mtl_system_items_vl                  msiv,
  mtl_uom_conversions_view             ucr,
  hr_employees                         he,
  -- Revision 1.14, remove tables to increase performance
  -- xla_transaction_entities            ent,
  -- xla_events                          xe,
  -- End revision for version 1.14
  xla_distribution_links               xdl,
  xla_ae_headers                       ah,
  xla_ae_lines                         al
  where cwo.transaction_date        >= :p_trx_from         -- p_trx_date_from
  and cwo.transaction_date        <  :p_trx_to           -- p_trx_date_to
  and cwo.po_distribution_id       = pod.po_distribution_id
  and pod.line_location_id         = pll.line_location_id
  and pod.po_header_id             = poh.po_header_id
  and pod.po_line_id               = pol.po_line_id   
  and pll.po_release_id            = pr.po_release_id (+)
  and pov.vendor_id                = poh.vendor_id
  and poh.agent_id                 = he.employee_id
  and msiv.inventory_item_id       = pol.item_id
  and msiv.inventory_item_id       = ucr.inventory_item_id
  and msiv.organization_id         = ucr.organization_id
  and ucr.unit_of_measure          = pol.unit_meas_lookup_code
  and msiv.organization_id         = pll.ship_to_organization_id
  -- ========================================================
  -- SLA t
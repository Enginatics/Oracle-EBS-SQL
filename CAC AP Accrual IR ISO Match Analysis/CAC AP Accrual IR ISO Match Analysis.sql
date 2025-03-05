/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC AP Accrual IR ISO Match Analysis
-- Description: Use this report to match the A/P Accrual entries for internal order inventory receipts with the internal order payables invoices, by the internal sale order and line number.  If run in Detail Mode, shows inventory receipts and payables invoices on separate lines with detailed information, if run in Summary Mode, the sales order line is summarized into one row.

Parameters:
===========
Report Mode:  you can get a summary by sales order and line or a detailed report, enter Detail or Summary (mandatory).
Transaction Date from:  enter the IR/ISO beginning transaction date you wish to report (optional).
Transaction Date to:  enter the IR/ISO ending transaction date you wish to report (optional).
Transaction Type:  enter the transaction type you wish to report (optional).
Category Set 1:  the first item category set to report, typically the Cost or Product Line Category Set (optional).
Category Set 2:  the second item category set to report, typically the Inventory Category Set (optional).
Category Set 3:  the third item category set to report (optional).
Item Number:  enter the item numbers you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2016 - 2025 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.09o warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     23 Nov 2016 Douglas Volz   Initial Coding 
-- |  1.1     15 Dec 2016 Douglas Volz   Added Customer Name for A/P Invoice
-- |  1.2     20 Dec 2016 Douglas Volz   Fixed calculation bug for Net Amount
-- |  1.3     10 Jan 2017 Douglas Volz   Added Transaction Type Code 61 and Transaction
-- |                                     Source Type 7 in order to report internal 
-- |                                     order receipts for txn type Int Req Intr Rcpt
-- |                                     and corrected SIGN of net quantity.
-- |  1.4     17 Jan 2017 Douglas Volz   Added Int Req Intr Rcpt to the Inventory Queries
-- |                                     corrected the transaction type code for material
-- |                                     transactions, truncated the transaction date 
-- |                                     and corrected the report sort by order number and
-- |                                     transaction type (receipts first).
-- |  1.5     18 Jan 2017 Douglas Volz   Added Vendor Name and Transaction Source.
-- |  1.6     19 Jan 2017 Douglas Volz   Commented out the customer type indicator, was
-- |                                     preventing A/P invoices from being reported.
-- |  1.7     09 Jun 2017 Douglas Volz   Added new section to report Intransit Shipments
-- |                                     for FOB Shipment with the order booked in one
-- |                                     OU but shipped from another OU
-- |  1.8     11 Jun 2017 Douglas Volz   Added Transaction Date and Operating Unit
-- |                                     Parameters.  Added new section 5 for Payables
-- |                                     invoices which are unmatched to POs or for IR/ISOs.
-- |  1.9     26 Feb 2025 Douglas Volz   Removed tabs, cleaned up for Blitz Report.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-ap-accrual-ir-iso-match-analysis/
-- Library Link: https://www.enginatics.com/reports/cac-ap-accrual-ir-iso-match-analysis/
-- Run Report: https://demo.enginatics.com/

select  ml.meaning Report_Mode,
        &p_det_col1
-- nvl(gl.short_name, gl.name) Ledger,
        iso_match.operating_unit Operating_Unit,
        &p_det_col2
-- iso_match.organization_code Org_Code,
        iso_match.period_name Period_Name,
        gcc.concatenated_segments Accounts,
        &segment_columns
        iso_match.order_number ISO_Number,
        iso_match.line_number ISO_Line_Num,
        &p_det_col3
-- iso_match.transaction_source Transaction_Source,
-- iso_match.party_name Customer,
-- iso_match.party_number Customer_Number,
        iso_match.vendor_name Supplier,
        &p_det_col4
-- trunc(iso_match.transaction_date) Transaction_Date,
-- iso_match.transaction_type_code Transaction_Type,
        msiv.concatenated_segments Item_Number,
        msiv.description Item_Description,
&category_columns
        &p_det_col5
-- iso_match.inventory_transaction_id Inventory_Transaction_Id,
-- iso_match.ap_invoice_num Invoice_Number,
-- iso_match.ap_invoice_line AP_Line_Num,
        sum(nvl(iso_match.receipt_quantity,0)) Receipt_Quantity,
        sum(nvl(iso_match.invoice_quantity,0)) Invoice_Quantity,
        sum(nvl(iso_match.receipt_quantity,0)) + sum(nvl(iso_match.invoice_quantity,0)) Net_Quantity,
        sum(nvl(iso_match.receipt_amount,0)) Receipt_Amount,
        sum(nvl(iso_match.invoice_amount,0)) Invoice_Amount,
        sum(nvl(iso_match.receipt_amount,0)) + sum(nvl(iso_match.invoice_amount,0)) Net_Amount
from    gl_code_combinations_kfv gcc,
        gl_ledgers gl,
        mtl_system_items_vl msiv,
        mfg_lookups ml,
        -- ==============================================
        -- 1.0 Select the Inventory Internal Order Activity
        --     for Logical Intercompany Receipts and Returns
        -- ==============================================
        (select to_number(hoi.org_information1) ledger_id,
                haou2.name operating_unit,
                mp.organization_code,
                cmr.operating_unit_id,
                cmr.inventory_organization_id,
                xah.period_name,
                xal.code_combination_id,
                iso.order_number,
                iso_line.line_number,
                'INV' transaction_source,
                cmr.transaction_date,
                mtt.transaction_type_name transaction_type_code, 
                cmr.inventory_item_id,
                cmr.inventory_transaction_id,
                null ap_invoice_num,
                null ap_invoice_line,
                null party_name,
                null party_number,
                pv.vendor_name,
                cmr.vendor_id,
                sum(nvl(cmr.quantity,0) * -1) receipt_quantity,
                sum(0) invoice_quantity,
                sum(nvl(cmr.quantity,0) * -1) net_quantity,
                sum(nvl(cmr.amount,0)) receipt_amount,
                sum(0) invoice_amount,
                sum(nvl(cmr.amount,0)) net_amount
         from   cst_misc_reconciliation cmr,
                mtl_material_transactions mmt,
                mtl_transaction_types mtt,
                oe_order_headers_all iso,
                oe_order_lines_all iso_line,
                po_vendors pv,
                xla_ae_headers xah,
                xla_ae_lines xal,
                mtl_parameters mp,
                hr_organization_information hoi,
                hr_all_organization_units haou,  -- inv_organization_id
                hr_all_organization_units haou2  -- operating unit
         -- ======================================================== 
         -- Join Misc. Accrual Internal Order entries to Material Txns
         -- ========================================================
         where  mmt.transaction_id              = cmr.inventory_transaction_id
         -- Revision for version 1.4, went back to version 1.2 and added a new union all
         and    cmr.transaction_type_code IN ('10','13')
         -- ======================================================== 
         -- Internal SO joins, headers to lines, to Material Txns
         -- ========================================================
         -- Revision for version 1.8
         -- Needed to add iso_line.order_source_id = 6 for Logical
         -- Intercompany Shipment Receipt transactions
         and    iso_line.order_source_id IN (0,6)  -- "this is an Oracle WOW"
         and    iso_line.line_category_code     = 'ORDER'
         and    iso.header_id                   = iso_line.header_id
         and    mmt.trx_source_line_id          = iso_line.line_id
         and    mmt.inventory_item_id           = iso_line.inventory_item_id
         -- Revision for version 1.4, went back to version 1.2 and added a new union all
         -- for Txn Source Type 7 for Int Req Intr Rcpt transactions
         and    mmt.transaction_source_type_id  = 13
         and    mmt.inventory_item_id           = cmr.inventory_item_id
         and    mtt.transaction_type_id         = mmt.transaction_type_id
         and    mp.organization_id              = cmr.inventory_organization_id
         and    cmr.ae_header_id                = xah.ae_header_id
         and    xah.ae_header_id                = xal.ae_header_id
         and    cmr.ae_line_num                 = xal.ae_line_num
         and    pv.vendor_id (+)                = cmr.vendor_id
         -- Inventory org and operating units joins
         and    hoi.org_information_context     = 'Accounting Information'
         and    hoi.organization_id             = mp.organization_id
         and    hoi.organization_id             = haou.organization_id   -- this gets the organization name
         and    haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
         and    cmr.operating_unit_id           = haou2.organization_id
         -- Revision for Operating Unit Security
         and     (nvl(fnd_profile.value('XXEN_REPORT_USE_OPERATING_UNIT_SECURITY'),'N')='N' or haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11))
         and    2=2                             -- p_operating_unit, p_trx_date_from, p_trx_date_to, p_transaction_type
         group by
                to_number(hoi.org_information1), -- ledger_id
                haou2.name,
                mp.organization_code,
                cmr.operating_unit_id,
                cmr.inventory_organization_id,
                xah.period_name,
                xal.code_combination_id,
                iso.order_number,
                iso_line.line_number,
                'INV',
                cmr.transaction_date,
                mtt.transaction_type_name,
                cmr.inventory_item_id,
                cmr.inventory_transaction_id,
                null,   -- ap_invoice_line
                null,   -- ap_invoice_num
                null,   -- party_name,
                null,   -- party_number
                pv.vendor_name,
                cmr.vendor_id
        -- ==============================================
        -- 2.0 Select the Inventory Internal Order Activity
        --     for Internal Order Intransit Receipts
        --     Note:  get the SO information from the parent
        --            material intransit shipment transaction
        -- ==============================================
         union all
         select to_number(hoi.org_information1) ledger_id,
                haou2.name operating_unit,
                mp.organization_code,
                cmr.operating_unit_id,
                cmr.inventory_organization_id,
                xah.period_name,
                xal.code_combination_id,
                iso.order_number,
                iso_line.line_number,
                'INV' transaction_source,
                cmr.transaction_date,
                mtt.transaction_type_name transaction_type_code, 
                cmr.inventory_item_id,
                cmr.inventory_transaction_id,
                null ap_invoice_num,
                null ap_invoice_line,
                null party_name,
                null party_number,
                pv.vendor_name,
                cmr.vendor_id,
                sum(nvl(cmr.quantity,0) * -1) receipt_quantity,
                sum(0) invoice_quantity,
                sum(nvl(cmr.quantity,0) * -1) net_quantity,
                sum(nvl(cmr.amount,0)) receipt_amount,
                sum(0) invoice_amount,
                sum(nvl(cmr.amount,0)) net_amount
         from   cst_misc_reconciliation cmr,
                mtl_material_transactions mmt,
                mtl_transaction_types mtt,
                mtl_material_transactions mmt2,
                oe_order_headers_all iso,
                oe_order_lines_all iso_line,
                po_vendors pv,
                xla_ae_headers xah,
                xla_ae_lines xal,
                mtl_parameters mp,
                hr_organization_information hoi,
                hr_all_organization_units haou,  -- inv_organization_id
                hr_all_organization_units haou2  -- operating unit
         -- ======================================================== 
         -- Join Misc. Accrual Internal Order entries to Material Txns
         -- ========================================================
         where  mmt.transaction_id              = cmr.inventory_transaction_id
         and    cmr.transaction_type_code       = '61'
         and    mmt.transaction_source_type_id  = 7  -- Int Order Intr Rcpt
         and    mtt.transaction_type_id         = mmt.transaction_type_id
         -- Joins to find the Internal Order Shipment Transaction
         and    mmt.transfer_transaction_id     = mmt2.transaction_id
         and    mmt2.transaction_source_type_id = 8  -- Int Order Intr Ship
         -- ======================================================== 
         -- Internal SO joins, headers to lines, to internal order shipments
         -- ========================================================
         and    iso_line.order_source_id        = 10  -- for internal orders
         and    iso_line.line_category_code     = 'ORDER'
         and    iso.header_id                   = iso_line.header_id
         and    mmt2.trx_source_line_id         = iso_line.LINE_ID
         and    mmt2.inventory_item_id          = iso_line.inventory_item_id
         and    mmt.inventory_item_id           = cmr.inventory_item_id
         and    mp.organization_id              = cmr.inventory_organization_id
         and    cmr.ae_header_id                = xah.ae_header_id
         and    xah.ae_header_id                = xal.ae_header_id
         and    cmr.ae_line_num                 = xal.ae_line_num
         and    pv.vendor_id (+)                = cmr.vendor_id
         -- Inventory org and operating units joins
         and    hoi.org_information_context     = 'Accounting Information'
         and    hoi.organization_id             = mp.organization_id
         and    hoi.organization_id             = haou.organization_id   -- this gets the organization name
         and    haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
         and    cmr.operating_unit_id           = haou2.organization_id
         -- Revision for Operating Unit Security
         and     (nvl(fnd_profile.value('XXEN_REPORT_USE_OPERATING_UNIT_SECURITY'),'N')='N' or haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11))
         and    2=2                             -- p_operating_unit, p_trx_date_from, p_trx_date_to, p_transaction_type
         group by
                to_number(hoi.org_information1), -- ledger_id
                haou2.name,
                mp.organization_code,
                cmr.operating_unit_id,
                cmr.inventory_organization_id,
                xah.period_name,
                xal.code_combination_id,
                iso.order_number,
                iso_line.line_number,
                'INV',
                cmr.transaction_date,
                mtt.transaction_type_name,
                cmr.inventory_item_id,
                cmr.inventory_transaction_id,
                null,   -- ap_invoice_line
                null,   -- ap_invoice_num
                null,   -- party_name,
                null,   -- party_number
                pv.vendor_name,
                cmr.vendor_id
        -- ==============================================
        -- 3.0 Select the Payables Internal Order Activity
        -- ==============================================
         union all
         select to_number(hoi.org_information1) ledger_id,
                haou2.name operating_unit,
                mp.organization_code,
                cmr.operating_unit_id,
                rctl.warehouse_id inventory_organization_id,
                xah.period_name,
                xal.code_combination_id,
                to_number(rctl.sales_order) order_number,
                to_number(rctl.interface_line_attribute2) line_number,
                'A/P' transaction_source,
                cmr.transaction_date,
                cmr.transaction_type_code,
                cmr.inventory_item_id,
                null inventory_transaction_id,
                ai.invoice_num ap_invoice_num,
                ail.line_number ap_invoice_line,
                hp.party_name customer_name,
                hp.party_number customer_number,
                pv.vendor_name,
                cmr.vendor_id,
                sum(0) receipt_quantity,
                -- cmr has a null quantity, had to use rctl
                sum(nvl(rctl.quantity_invoiced,0)) invoice_quantity,
                sum(nvl(rctl.quantity_invoiced,0)) net_quantity,
                sum(0) receipt_amount,
                sum(nvl(cmr.amount,0)) invoice_amount,
                sum(nvl(cmr.amount,0)) net_amount
         from   cst_misc_reconciliation cmr,
                ap_invoices_all ai,
                ap_invoice_lines_all ail,
                ap_invoice_distributions_all aid,
                ra_customer_trx_lines_all rctl,
                ra_customer_trx_all rct,
                po_vendors pv,
                hz_cust_accounts hca,
                hz_parties hp,
                xla_ae_headers xah,
                xla_ae_lines xal,
                mtl_parameters mp,
                hr_organization_information hoi,
                hr_all_organization_units haou,  -- inv_organization_id
                hr_all_organization_units haou2  -- operating unit
         -- ========================================================
         -- Invoice, invoice line, distribution and PO Vendor Joins
         -- ========================================================
         where  cmr.transaction_type_code       = 'AP NO PO'
         and    cmr.invoice_distribution_id     = aid.invoice_distribution_id
         and    ai.invoice_id                   = aid.invoice_id
         and    ai.invoice_id                   = ail.invoice_id
         -- aid has an index on invoice_id, invoice_ line_number and org_id
         -- ail has an index on invoice_id and line_number
         and    aid.invoice_id                  = ail.invoice_id
         and    aid.invoice_line_number         = ail.line_number
         and    aid.po_distribution_id is null -- AP entries not matched to POs
         -- ========================================================
         -- Only get A/P distributions for Internal Orders
         -- ========================================================
         and    aid.reference_1 is not null -- Internal Orders customer_trx_line_id
         and    aid.Reference_2 is not null -- Internal Orders Logical IC Sales Issue
         -- ========================================================
         -- Join Payables to Receivables to get internal order info
         -- ========================================================
         -- Use ail to join to RA tables to avoid to_number qualifiers
         -- on aid reference columns
         and    ail.source_trx_id               = rctl.customer_trx_id
         and    ail.source_line_id              = rctl.customer_trx_line_id
         and    rctl.interface_line_context     = 'INTERCOMPANY'
         and    rct.customer_trx_id             = rctl.customer_trx_id
         -- ========================================================
         -- Joins for Items, Organizations and Customers
         -- Note:  ra_customers does not have organizations as customers
         -- ========================================================
         and    cmr.inventory_item_id           = rctl.inventory_item_id
         and    cmr.inventory_organization_id   = rctl.warehouse_id
         and    mp.organization_id              = rctl.warehouse_id
         and    hca.cust_account_id             = rct.sold_to_customer_id
         -- Revision for version 1.6
         -- Comment out the customer type, bad client setups
         -- and    hca.customer_type            = 'I'  -- Inventory
         and    hp.party_id                     = hca.party_id
         and    hp.party_type                   = 'ORGANIZATION'
         and    cmr.ae_header_id                = xah.ae_header_id
         and    xah.ae_header_id                = xal.ae_header_id
         and    cmr.ae_line_num                 = xal.ae_line_num
         and    pv.vendor_id (+)                = cmr.vendor_id
         -- Inventory org and operating units joins
         and    hoi.org_information_context     = 'Accounting Information'
         and    hoi.organization_id             = mp.organization_id
         and    hoi.organization_id             = haou.organization_id   -- this gets the organization name
         and    cmr.operating_unit_id           = haou2.organization_id 
         -- Revision for Operating Unit Security
         and     (nvl(fnd_profile.value('XXEN_REPORT_USE_OPERATING_UNIT_SECURITY'),'N')='N' or haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11))
         and    2=2                             -- p_operating_unit, p_trx_date_from, p_trx_date_to, p_transaction_type
         group by
                to_number(hoi.org_information1), -- ledger_id
                haou2.name, -- operating_unit
                mp.organization_code,
                cmr.operating_unit_id,
                rctl.warehouse_id,
                xah.period_name,
                xal.code_combination_id,
                to_number(rctl.sales_order),
                to_number(rctl.interface_line_attribute2),
                'A/P',
                cmr.transaction_date,
                cmr.transaction_type_code,
                cmr.inventory_item_id,
                null,   -- inventory_transaction_id
                ai.invoice_num,
                ail.line_number,
                hp.party_name,
                hp.party_number,
                pv.vendor_name,
                cmr.vendor_id
        -- ==============================================
        -- Revision for version 1.7
        -- 4.0 Select the Inventory Internal Order Activity
        --     for Internal Order Intransit Shipments
        --     Where the order is booked in one Operating
        --     Unit but shipped from another Operating Unit
        --     Note:  directly get the SO information from 
        --            the Intransit Shipment Transaction.
        -- ==============================================
         union all
         select to_number(hoi.org_information1) ledger_id,
                haou2.name operating_unit,
                mp.organization_code,
                cmr.operating_unit_id,
                cmr.inventory_organization_id,
                xah.period_name,
                xal.code_combination_id,
                iso.order_number,
                iso_line.line_number,
                'INV' transaction_source,
                cmr.transaction_date,
                mtt.transaction_type_name transaction_type_code,
                cmr.inventory_item_id,
                cmr.inventory_transaction_id,
                null ap_invoice_num,
                null ap_invoice_line,
                null party_name,
                null party_number,
                pv.vendor_name,
                cmr.vendor_id,
                -- Already a negative quantity
                sum(nvl(cmr.quantity,0)) receipt_quantity,
                sum(0) invoice_quantity,
                -- Already a negative quantity
                sum(nvl(cmr.quantity,0)) net_quantity,
                sum(nvl(cmr.amount,0)) receipt_amount,
                sum(0) invoice_amount,
                sum(nvl(cmr.amount,0)) net_amount
         FROM   cst_misc_reconciliation cmr,
                mtl_material_transactions mmt,
                mtl_transaction_types mtt,
                oe_order_headers_all iso,
                oe_order_lines_all iso_line,
                po_vendors pv,
                xla_ae_headers xah,
                xla_ae_lines xal,
                mtl_parameters mp,
                hr_organization_information hoi,
                hr_all_organization_units haou,  -- inv_organization_id
                hr_all_organization_units haou2  -- operating unit
         -- ======================================================== 
         -- Join Misc. Accrual Internal Order entries to Material Txns
         -- ========================================================
         where  mmt.transaction_id              = cmr.inventory_transaction_id
         and    mtt.transaction_type_id         = mmt.transaction_type_id
         -- Joins to find the Internal Order Shipment Transaction
         and    cmr.transaction_type_code       = '62'
         and    mmt.transaction_source_type_id  = 8  -- Int Order Intr Ship
         -- ======================================================== 
         -- Internal SO joins, headers to lines, to internal SOs and items
         -- ========================================================
         and    iso_line.order_source_id        = 10  -- for internal orders
         and    iso_line.line_category_code     = 'ORDER'
         and    iso.header_id                   = iso_line.header_id
         and    mmt.trx_source_line_id          = iso_line.line_id
         and    mmt.inventory_item_id           = iso_line.inventory_item_id
         -- ======================================================== 
         -- Joins for the item master and inventory organization
         -- ========================================================
         and    mmt.inventory_item_id           = cmr.inventory_item_id
         and    mp.organization_id              = cmr.inventory_organization_id
         and    cmr.ae_header_id                = xah.ae_header_id
         and    xah.ae_header_id                = xal.ae_header_id
         and    cmr.ae_line_num                 = xal.ae_line_num
         and    pv.vendor_id (+)                = cmr.vendor_id
         -- Inventory org and operating units joins
         and    hoi.org_information_context     = 'Accounting Information'
         -- Get the organization information from where the goods 
         -- are being shipped to as the FOB Point is FOB Shipment
         and    hoi.organization_id             = mmt.transfer_organization_id
         and    hoi.organization_id             = haou.organization_id   -- this gets the organization name
         and    haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
         and    cmr.operating_unit_id           = haou2.organization_id 
         -- Revision for Operating Unit Security
         and     (nvl(fnd_profile.value('XXEN_REPORT_USE_OPERATING_UNIT_SECURITY'),'N')='N' or haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11))
         and    2=2                             -- p_operating_unit, p_trx_date_from, p_trx_date_to, p_transaction_type
         group by
                to_number(hoi.org_information1), -- ledger_id
                haou2.name,
                mp.organization_code,
                cmr.operating_unit_id,
                cmr.inventory_organization_id,
                xah.period_name,
                xal.code_combination_id,
                iso.order_number,
                iso_line.line_number,
                'INV', -- transaction_source
                cmr.transaction_date,
                mtt.transaction_type_name,
                cmr.inventory_item_id,
                cmr.inventory_transaction_id,
                null,   -- ap_invoice_line
                null,   -- ap_invoice_num
                null,   -- party_name,
                null,   -- party_number
                pv.vendor_name,
                cmr.vendor_id
        -- ==============================================
        -- 5.0 Select the Payables Activity Not Related
        --     to intercompany IR/ISO or Logical Transactions
        --     Revision for version 1.8
        -- ==============================================
         union all
         select to_number(hoi.org_information1) ledger_id,
                haou2.name operating_unit,
                mp.organization_code,
                cmr.operating_unit_id,
                mp.organization_id inventory_organization_id,
                xah.period_name,
                xal.code_combination_id,
                null order_number,
                null line_number,
                'A/P' transaction_source,
                cmr.transaction_date,
                cmr.transaction_type_code,
                null inventory_item_id,
                null inventory_transaction_id,
                ai.invoice_num ap_invoice_num,
                ail.line_number ap_invoice_line,
                null customer_name,
                null customer_number,
                pv.vendor_name,
                cmr.vendor_id,
                sum(0) receipt_quantity,
                -- cmr has a null quantity, had to use rctl
                sum(nvl(cmr.quantity,0)) invoice_quantity,
                sum(nvl(cmr.quantity,0)) net_quantity,
                sum(0) receipt_amount,
                sum(nvl(cmr.amount,0)) invoice_amount,
                sum(nvl(cmr.amount,0)) net_amount
         from   cst_misc_reconciliation cmr,
                ap_invoices_all ai,
                ap_invoice_lines_all ail,
                ap_invoice_distributions_all aid,
                po_vendors pv,
                financials_system_params_all fsp,
                mtl_parameters mp,
                xla_ae_headers xah,
                xla_ae_lines xal,
                hr_organization_information hoi,
                hr_all_organization_units haou,  -- inv_organization_id
                hr_all_organization_units haou2  -- operating unit
         -- ========================================================
         -- Invoice, invoice line, distribution and PO Vendor Joins
         -- ========================================================
         where  cmr.transaction_type_code       = 'AP NO PO'
         and    cmr.invoice_distribution_id     = aid.invoice_distribution_id
         and    ai.invoice_id                   = aid.invoice_id
         and    ai.invoice_id                   = ail.invoice_id
         -- aid has an index on invoice_id, invoice_ line_number and org_id
         -- ail has an index on invoice_id and line_number
         and    aid.invoice_id                  = ail.invoice_id
         and    aid.invoice_line_number         = ail.line_number
         and    aid.po_distribution_id is null -- A/P distributions not matched to POs
         -- ========================================================
         -- Get A/P distributions not related to Internal Orders
         -- ========================================================
         and    aid.reference_1 is null -- not related to Internal Orders customer_trx_line_id
         and    aid.reference_2 is null -- not related to Internal Orders Logical IC Sales Issue
         and    cmr.ae_header_id                = xah.ae_header_id
         and    xah.ae_header_id                = xal.ae_header_id
         and    cmr.ae_line_num                 = xal.ae_line_num
         and    pv.vendor_id (+)                = cmr.vendor_id
         -- Inventory org and operating units joins
         and    fsp.org_id                      = cmr.operating_unit_id
         and    mp.organization_id              = fsp.inventory_organization_id
         and    hoi.org_information_context     = 'Accounting Information'
         and    hoi.organization_id             = mp.organization_id
         and    hoi.organization_id             = haou.organization_id   -- this gets the organization name
         and    cmr.operating_unit_id           = haou2.organization_id
         -- Revision for Operating Unit Security
         and     (nvl(fnd_profile.value('XXEN_REPORT_USE_OPERATING_UNIT_SECURITY'),'N')='N' or haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11))
         and    2=2                             -- p_operating_unit, p_trx_date_from, p_trx_date_to, p_transaction_type
         group by
                to_number(hoi.org_information1), -- ledger_id
                haou2.name, -- operating_unit
                mp.organization_code,
                cmr.operating_unit_id,
                mp.organization_id,
                xah.period_name,
                xal.code_combination_id,
                null, -- Sales Order
                null,  -- Line Number
                'A/P',
                cmr.transaction_date,
                cmr.transaction_type_code,
                null, -- item number
                null, -- item description
                null, -- inventory_item_id,
                null, -- inventory_transaction_id
                ai.invoice_num,
                ail.line_number,
                null, -- customer name,
                null, -- customer number
                pv.vendor_name,
                cmr.vendor_id
        ) iso_match
where   gcc.code_combination_id     = iso_match.code_combination_id
and     gl.ledger_id                = iso_match.ledger_id
and     msiv.inventory_item_id (+)  = iso_match.inventory_item_id
and     msiv.organization_id (+)    = iso_match.inventory_organization_id
and     ml.lookup_type              = 'CST_RPT_DETAIL_OPTION'
and     ml.meaning                  = :p_report_mode
-- Revision for GL Security
and     (nvl(fnd_profile.value('XXEN_REPORT_USE_LEDGER_SECURITY'),'N')='N' or gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+)))
and     1=1                         -- p_ledger, p_report_type, p_item_number
group by
        ml.meaning, -- Report Mode
        &p_det_grp1
-- nvl(gl.short_name, gl.name),
        iso_match.operating_unit,
        &p_det_grp2
-- iso_match.organization_code,
        iso_match.period_name,
        gcc.concatenated_segments,
        &segment_columns_grp
        iso_match.order_number,
        iso_match.line_number,
        &p_det_grp3
-- iso_match.transaction_source,
-- iso_match.party_name,
-- iso_match.party_number,
        iso_match.vendor_name,
        &p_det_grp4
-- trunc(iso_match.transaction_date),
-- iso_match.transaction_type_code,
        msiv.concatenated_segments,
        msiv.description,
        -- Needed for category selects
        msiv.inventory_item_id,
        msiv.organization_id
        &p_det_grp5
-- ,iso_match.inventory_transaction_id,
-- iso_match.ap_invoice_num,
-- iso_match.ap_invoice_line
order by 4,5,6,7,8,9,10,11,12,13,14,15 desc
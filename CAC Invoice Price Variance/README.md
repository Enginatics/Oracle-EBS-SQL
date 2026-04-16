---
layout: default
title: 'CAC Invoice Price Variance | Oracle EBS SQL Report'
description: 'Report to display the Invoice Price Variances (IPV), Exchange Rate Variances (ERV) and A/P Accrual Write-Off Variances for an entered date range. IPV is…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Nidec changes, R12 only, CAC, Invoice, Price, Variance, ap_invoices_all, po_vendors, po_headers_all'
permalink: /CAC%20Invoice%20Price%20Variance/
---

# CAC Invoice Price Variance – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-invoice-price-variance/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to display the Invoice Price Variances (IPV), Exchange Rate Variances (ERV) and A/P Accrual Write-Off Variances for an entered date range.  IPV is the difference between the PO unit price and the invoice unit cost times the quantity invoiced.  ERV is the difference between the purchase order exchange rate and the exchange rate used by the A/P invoice.  For a given invoice line, both the IPV and ERV amounts will be shown on the same row, in separate columns.  These entries have the Type "IPV-ERV".  The A/P Accrual Write-Off Variances appear as separate rows with the Type "INV WO" for invoice write-off amounts.  The A/P Accrual Write-Off Variances typically use the IPV account so for completeness, are also displayed on this report.  

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


## Report Parameters
Transaction Date From, Transaction Date To, Category Set 1, Category Set 2, Category Set 3, Supplier Name, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_uom_conversions_view](https://www.enginatics.com/library/?pg=1&find=mtl_uom_conversions_view), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [hr_employees](https://www.enginatics.com/library/?pg=1&find=hr_employees), [po_lookup_codes](https://www.enginatics.com/library/?pg=1&find=po_lookup_codes), [fnd_lookup_values](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [ap_invoice_distributions_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_distributions_all), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all), [xla_distribution_links](https://www.enginatics.com/library/?pg=1&find=xla_distribution_links), [xla_ae_lines](https://www.enginatics.com/library/?pg=1&find=xla_ae_lines), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual), [cst_write_offs](https://www.enginatics.com/library/?pg=1&find=cst_write_offs), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions), [mtl_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_accounts), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [xla_ae_headers](https://www.enginatics.com/library/?pg=1&find=xla_ae_headers)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Nidec changes](https://www.enginatics.com/library/?pg=1&category[]=Nidec%20changes), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Invoice Price Variance 07-Jul-2022 144732.xlsx](https://www.enginatics.com/example/cac-invoice-price-variance/) |
| Blitz Report™ XML Import | [CAC_Invoice_Price_Variance.xml](https://www.enginatics.com/xml/cac-invoice-price-variance/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-invoice-price-variance/](https://www.enginatics.com/reports/cac-invoice-price-variance/) |

## Case Study & Technical Analysis: CAC Invoice Price Variance

### Executive Summary
The **CAC Invoice Price Variance** report is a procurement performance and financial analysis tool. It details the differences between the Purchase Order (PO) price and the actual Accounts Payable (AP) Invoice price. It captures both the **Invoice Price Variance (IPV)** (operational price difference) and the **Exchange Rate Variance (ERV)** (currency fluctuation difference), providing a complete picture of purchase cost performance.

### Business Challenge
Standard Costing relies on the PO price being an accurate reflection of cost. When the Invoice differs:
*   **Margin Erosion**: Higher than expected material costs eat into product margins.
*   **Vendor Performance**: Frequent IPV suggests that a vendor is changing prices after the PO is cut, or that the PO pricing maintenance is poor.
*   **Currency Risk**: Large ERV indicates that currency volatility is impacting the cost of goods sold.

### Solution
This report provides line-level visibility into these variances.
*   **Dual Variance**: Separates IPV and ERV into distinct columns, allowing users to distinguish between "Vendor raised price" (IPV) and "Dollar got weaker" (ERV).
*   **Write-Offs**: Includes AP Accrual Write-Offs, ensuring that all adjustments to the inventory value are captured.
*   **Drill Down**: Provides PO Number, Invoice Number, Vendor, and Item details for every variance line.

### Technical Architecture
The report bridges Purchasing and Payables:
*   **Source Data**: `ap_invoice_distributions_all` (where the variance is booked).
*   **Linkage**: Joins to `po_headers_all` and `po_lines_all` to retrieve the original commitment details.
*   **Accounting**: Identifies the specific IPV and ERV accounts charged.

### Parameters
*   **Transaction Date From/To**: (Mandatory) The date range for the AP Invoices.
*   **Category Set**: (Optional) To analyze variances by commodity (e.g., "Steel", "Plastics").
*   **Vendor**: (Optional) To audit a specific supplier.

### Performance
*   **Transaction Volume**: Performance depends on the number of invoice lines in the selected date range.
*   **Indexed**: Uses standard date indexes on AP tables.

### FAQ
**Q: What is the difference between IPV and PPV?**
A: PPV (Purchase Price Variance) is the difference between Standard Cost and PO Price. IPV is the difference between PO Price and Invoice Price.

**Q: Does this report show PPV?**
A: No, this report focuses strictly on the AP side (IPV/ERV). Use the "Purchase Price Variance" report for PPV.

**Q: Why is IPV important for Standard Costing?**
A: IPV is expensed immediately (usually). It represents a "leak" in the standard cost model that needs to be monitored.


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics

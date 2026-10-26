---
layout: default
last_modified_at: 2026-10-26
title: 'CAC Invoice Price Variance | Oracle EBS SQL Report'
description: 'Report to display the Invoice Price Variances (IPV), Exchange Rate Variances (ERV) and A/P Accrual Write-Off Variances for an entered date range. IPV is…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, R12 only, CAC, Invoice, Price, Variance, hr_employees, ap_invoice_distributions_all, po_distributions_all'
permalink: /CAC%20Invoice%20Price%20Variance/
report_name: 'CAC Invoice Price Variance'
report_web_name: cac-invoice-price-variance
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Invoice Price Variance – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-invoice-price-variance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

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
-- |  1.15    23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Transaction Date From, Transaction Date To, Category Set 1, Category Set 2, Category Set 3, Supplier Name, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[hr_employees](https://www.enginatics.com/library/?pg=1&find=hr_employees&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [ap_invoice_distributions_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [xla_distribution_links](https://www.enginatics.com/library/?pg=1&find=xla_distribution_links&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [xla_ae_lines](https://www.enginatics.com/library/?pg=1&find=xla_ae_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [mtl_uom_conversions_view](https://www.enginatics.com/library/?pg=1&find=mtl_uom_conversions_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [mtl_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [oe_system_parameters_all](https://www.enginatics.com/library/?pg=1&find=oe_system_parameters_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [cst_write_offs](https://www.enginatics.com/library/?pg=1&find=cst_write_offs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [xla_ae_headers](https://www.enginatics.com/library/?pg=1&find=xla_ae_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance)

## Related Reports
[GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [CAC Purchase Price Variance](/CAC%20Purchase%20Price%20Variance/ "CAC Purchase Price Variance Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [PO Procure to Pay Tracker](/PO%20Procure%20to%20Pay%20Tracker/ "PO Procure to Pay Tracker Oracle EBS SQL Report"), [INV Material Account Distribution Detail](/INV%20Material%20Account%20Distribution%20Detail/ "INV Material Account Distribution Detail Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Invoice%20Price%20Variance/CAC%20Invoice%20Price%20Variance.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Invoice Price Variance 07-Jul-2022 144732.xlsx](https://www.enginatics.com/example/cac-invoice-price-variance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance) |
| Blitz Report™ XML Import | [CAC_Invoice_Price_Variance.xml](https://www.enginatics.com/xml/cac-invoice-price-variance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance) |
| SQL Source | [CAC Invoice Price Variance.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Invoice%20Price%20Variance/CAC%20Invoice%20Price%20Variance.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-invoice-price-variance/](https://www.enginatics.com/reports/cac-invoice-price-variance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-invoice-price-variance)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

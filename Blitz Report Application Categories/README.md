---
layout: default
title: 'Blitz Report Application Categories | Oracle EBS SQL Report'
description: 'Oracle application -> Blitz Report assignment via lookup XXENREPORTAPPSCATEGORIES. This setup controls how automatically imported BI publisher reports and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, Application, Categories, fnd_lookup_values, table, fnd_application_vl'
permalink: /Blitz%20Report%20Application%20Categories/
---

# Blitz Report Application Categories – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-application-categories/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Oracle application -> Blitz Report assignment via lookup XXEN_REPORT_APPS_CATEGORIES.

This setup controls how automatically imported BI publisher reports and concurrent programs are assigned to Blitz Report categories.

## Report Parameters


## Oracle EBS Tables Used
[fnd_lookup_values](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values), [table](https://www.enginatics.com/library/?pg=1&find=table), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [CAC Receiving Account Detail](/CAC%20Receiving%20Account%20Detail/ "CAC Receiving Account Detail Oracle EBS SQL Report"), [GL Balance by Account Hierarchy](/GL%20Balance%20by%20Account%20Hierarchy/ "GL Balance by Account Hierarchy Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Report Application Categories 18-Jan-2018 225804.xlsx](https://www.enginatics.com/example/blitz-report-application-categories/) |
| Blitz Report™ XML Import | [Blitz_Report_Application_Categories.xml](https://www.enginatics.com/xml/blitz-report-application-categories/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-report-application-categories/](https://www.enginatics.com/reports/blitz-report-application-categories/) |

## Blitz Report Application Categories - Case Study & Technical Analysis

### Executive Summary

The **Blitz Report Application Categories** report is a configuration audit and setup tool. It defines the mapping between Oracle E-Business Suite Applications (e.g., "Payables", "Receivables") and Blitz Report Categories. This mapping drives the automatic categorization of reports when they are imported from standard Concurrent Programs or BI Publisher, ensuring an organized and intuitive report repository.

### Business Challenge

When migrating hundreds of legacy reports into Blitz Report, organization is key.
*   **Clutter:** Without categorization, a library of 500 reports becomes unsearchable.
*   **Manual Effort:** Manually assigning a category to every imported report is tedious.
*   **Consistency:** Different developers might categorize "Invoice Aging" differently (e.g., "AP" vs. "Payables" vs. "Finance").

### Solution

The **Blitz Report Application Categories** setup automates this organization:
*   **Auto-Assignment:** When a report is imported (e.g., `APXAGING`), the system looks up its application (`SQLAP`), finds the mapped category (e.g., "Accounts Payable"), and assigns it automatically.
*   **Standardization:** Enforces a consistent taxonomy across the organization.
*   **Maintenance:** Allows for easy re-mapping if category structures change.

### Technical Architecture

The logic relies on a specific lookup type that acts as the mapping table.

#### Key Tables & Joins

*   **Mapping:** `FND_LOOKUP_VALUES` (specifically the lookup type `XXEN_REPORT_APPS_CATEGORIES`) stores the relationship.
    *   *Lookup Code:* The Oracle Application Short Name (e.g., 'SQLAP').
    *   *Meaning:* The Blitz Report Category Name (e.g., 'Accounts Payable').
*   **Application:** `FND_APPLICATION_VL` validates the application codes.

#### Logic

1.  **Retrieval:** Lists all defined mappings from the lookup type.
2.  **Validation:** Ensures that the Application Short Name exists in FND_APPLICATION.
3.  **Usage:** This mapping is consumed by the "Import" feature in Blitz Report.

### Parameters

*   **None:** Typically runs as a full list of all mappings.

### FAQ

**Q: What happens if an application is not mapped?**
A: If a report belongs to an application that isn't in this mapping, it is usually assigned to a default category (e.g., "Uncategorized" or "Other") or the category matching the application name itself.

**Q: Can I map multiple applications to one category?**
A: Yes. For example, you could map both 'SQLAP' (Payables) and 'AP' (Payables Intelligence) to the single category "Accounts Payable".

**Q: How do I add a new mapping?**
A: You add a new code to the `XXEN_REPORT_APPS_CATEGORIES` lookup type via the standard Oracle Lookups form or via a setup upload.


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

---
layout: default
last_modified_at: 2026-10-19
title: 'PA Supplier Invoice Audit | Oracle EBS SQL Report'
description: 'AP invoices charged to projects showing vendor, invoice, cost distribution, and GL transfer details for supplier expenditure audit.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Projects, Enginatics, R12 only, Supplier, Invoice, Audit, pa_cost_distribution_lines_all, pa_expenditure_items_all, pa_expenditures_all'
permalink: /PA%20Supplier%20Invoice%20Audit/
report_name: 'PA Supplier Invoice Audit'
report_web_name: pa-supplier-invoice-audit
module: 'Projects'
module_url: /modules/projects/
---

# PA Supplier Invoice Audit – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-supplier-invoice-audit/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit).
**Oracle EBS module:** [Projects](/modules/projects/ "Oracle EBS Projects reports") · [all Projects reports](/modules/projects/)  

## Overview
AP invoices charged to projects showing vendor, invoice, cost distribution, and GL transfer details for supplier expenditure audit.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Project, Vendor, GL Date From, GL Date To

## Oracle EBS Tables Used
[pa_cost_distribution_lines_all](https://www.enginatics.com/library/?pg=1&find=pa_cost_distribution_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit), [pa_expenditure_items_all](https://www.enginatics.com/library/?pg=1&find=pa_expenditure_items_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit), [pa_expenditures_all](https://www.enginatics.com/library/?pg=1&find=pa_expenditures_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit)

## Related Reports
[PA Cost Audit](/PA%20Cost%20Audit/ "PA Cost Audit Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AP Distribution Set Listing](/AP%20Distribution%20Set%20Listing/ "AP Distribution Set Listing Oracle EBS SQL Report"), [AP Distribution Set Upload](/AP%20Distribution%20Set%20Upload/ "AP Distribution Set Upload Oracle EBS SQL Report"), [PA Project Subledger Detail by Expenditure Type](/PA%20Project%20Subledger%20Detail%20by%20Expenditure%20Type/ "PA Project Subledger Detail by Expenditure Type Oracle EBS SQL Report"), [CAC Open Purchase Orders](/CAC%20Open%20Purchase%20Orders/ "CAC Open Purchase Orders Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Supplier%20Invoice%20Audit/PA%20Supplier%20Invoice%20Audit.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PA Supplier Invoice Audit 04-Apr-2026 023352.xlsx](https://www.enginatics.com/example/pa-supplier-invoice-audit/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit) |
| Blitz Report™ XML Import | [PA_Supplier_Invoice_Audit.xml](https://www.enginatics.com/xml/pa-supplier-invoice-audit/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit) |
| SQL Source | [PA Supplier Invoice Audit.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Supplier%20Invoice%20Audit/PA%20Supplier%20Invoice%20Audit.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/pa-supplier-invoice-audit/](https://www.enginatics.com/reports/pa-supplier-invoice-audit/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit) |

## Case Study & Technical Analysis: PA Supplier Invoice Audit

### Executive Summary
The PA Supplier Invoice Audit report shows supplier invoices that have been charged to Oracle Projects, with the vendor, the invoice, the project and task, the cost distribution and the general ledger transfer details. It is written for project accounting teams, internal auditors and project controllers who must verify that supplier costs have been charged to the right project and task and transferred to the general ledger. Each row is a cost distribution line of type R, which is the Payables-originated cost, so the report traces a supplier invoice from Payables into project costing and on to the GL account. It sits in the Projects module and is restricted to R12.

### Business Challenge
*   **Supplier cost on projects:** Supplier invoices charged to projects must be validated, because a wrong task or project distorts project profitability and billing.
*   **Tracing to the GL:** Auditors need to see whether each project cost has been transferred to the general ledger and on which date.
*   **Transfer failures:** Cost distributions that have not transferred are a control weakness, and their status must be visible.
*   **Audit evidence:** Expenditure audits require the invoice number, vendor, date and amount alongside the project coding.

### The Solution
*   **Invoice-to-project trace:** Each row links an Accounts Payable invoice to its project expenditure item, project, task and expenditure, so the path from supplier to project is shown.
*   **Distribution-level detail:** The report returns the distribution line number, the accounting period, the GL date and transfer date, and the transfer status.
*   **Cost amounts:** Raw cost and burdened cost are shown for each distribution, with the expenditure item quantity.
*   **GL account visibility:** The debit account of the cost distribution is shown as a concatenated GL account.
*   **Audit trail:** The creator and creation date of each distribution are returned.

### Technical Architecture (High Level)
#### Primary Tables
*   `PA_COST_DISTRIBUTION_LINES_ALL`: the cost distribution lines, with the amounts, GL date, transfer date and transfer status.
*   `PA_EXPENDITURE_ITEMS_ALL`: the expenditure items, with the expenditure type, quantity, date and document header link.
*   `PA_EXPENDITURES_ALL`: the expenditure batch that holds the items.
*   `PA_PROJECTS_ALL`: the projects.
*   `PA_TASKS`: the project tasks.
*   `AP_INVOICES_ALL`: the Payables invoice that is the source of the cost.
*   `AP_SUPPLIERS`: the vendor name and number.
*   `GL_CODE_COMBINATIONS_KFV`: the debit account of the distribution.
*   `MO_GLOB_ORG_ACCESS_TMP` and `DUAL`: the organisations accessible to the current user.

#### Logical Relationships
1. `PA_COST_DISTRIBUTION_LINES_ALL` joins to `PA_EXPENDITURE_ITEMS_ALL` on the expenditure item identifier.
2. Expenditure items join to `PA_EXPENDITURES_ALL`, `PA_PROJECTS_ALL` and `PA_TASKS` on their identifiers.
3. Expenditure items join to `AP_INVOICES_ALL` as an outer join on the document header identifier, which is the invoice identifier for supplier items.
4. The invoice joins to `AP_SUPPLIERS` as an outer join on the vendor identifier.
5. The distribution joins to `GL_CODE_COMBINATIONS_KFV` as an outer join on the debit code combination.
6. The project's operating unit is joined through `HR_ALL_ORGANIZATION_UNITS_VL`.
7. Only distribution lines of type R, and expenditure items with the VI system linkage function, are returned.

### Parameters & Filtering
*   **Operating Unit:** The description lists it as a parameter. The SQL restricts the output to organisations in the access table, so the operating unit is applied within that set.
*   **Project:** Restricts the rows to one project.
*   **Vendor:** Restricts the rows to one supplier.
*   **GL Date From and GL Date To:** Bound the GL date of the cost distribution lines.

The SQL text in the library does not reference these parameters by name, so the filters are applied by the report framework and not by predicates shown in the query.

### Performance & Optimization
*   **Fixed linkage filters:** The query restricts distribution lines to type R and expenditure items to the VI linkage function before the joins, which reduces the set to supplier invoice costs.
*   **Organisation access filter:** Projects are limited to the operating units in the access table, which keeps the scan to permitted organisations.
*   **Outer joins for transfers:** Invoice, supplier and account joins are outer, so distributions that have not transferred or are not linked to an invoice are still listed for audit.

### FAQ
**Q: How do I see which supplier invoices were charged to a project in Oracle Projects?**
A: Run PA Supplier Invoice Audit and filter by project number. Each row shows the invoice number, vendor, task and cost.

**Q: How can I check whether a supplier cost has transferred to the general ledger?**
A: Read the transfer status, transfer date and GL date columns for the distribution line.

**Q: Which cost amounts does the report show?**
A: It shows the raw cost and burdened cost of each cost distribution line, along with the expenditure item quantity.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-supplier-invoice-audit)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

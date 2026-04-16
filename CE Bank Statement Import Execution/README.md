---
layout: default
title: 'CE Bank Statement Import Execution | Oracle EBS SQL Report'
description: 'Application: Cash Management Source: Bank Statement Import Execution Report Short Name: CEIMPERR DB package: CECEXINERRXMLPPKG'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, BI Publisher, Enginatics, R12 only, Bank, Statement, Import, Execution, ce_statement_headers_int, ce_lookups, ce_bank_accts_gt_v'
permalink: /CE%20Bank%20Statement%20Import%20Execution/
---

# CE Bank Statement Import Execution – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ce-bank-statement-import-execution/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Application: Cash Management
Source: Bank Statement Import Execution Report
Short Name: CEIMPERR
DB package: CE_CEXINERR_XMLP_PKG

## Report Parameters
Bank Name, Bank Branch Name, Bank Account Name, Bank Account Number, Statement Number From, Statement Number To, Statement Date From, Statement Date To, Show Warnings/Errors Only

## Oracle EBS Tables Used
[ce_statement_headers_int](https://www.enginatics.com/library/?pg=1&find=ce_statement_headers_int), [ce_lookups](https://www.enginatics.com/library/?pg=1&find=ce_lookups), [ce_bank_accts_gt_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_accts_gt_v), [ce_bank_branches_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_branches_v), [ce_statement_headers](https://www.enginatics.com/library/?pg=1&find=ce_statement_headers), [ce_statement_lines](https://www.enginatics.com/library/?pg=1&find=ce_statement_lines), [ar_cash_receipts_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipts_all), [ar_cash_receipt_history_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipt_history_all), [ce_statement_reconcils_all](https://www.enginatics.com/library/?pg=1&find=ce_statement_reconcils_all), [ce_reconciliation_errors](https://www.enginatics.com/library/?pg=1&find=ce_reconciliation_errors), [ce_header_interface_errors](https://www.enginatics.com/library/?pg=1&find=ce_header_interface_errors)

## Report Categories
[BI Publisher](https://www.enginatics.com/library/?pg=1&category[]=BI%20Publisher), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CE Bank Statement Import Execution 22-Feb-2022 234911.xlsx](https://www.enginatics.com/example/ce-bank-statement-import-execution/) |
| Blitz Report™ XML Import | [CE_Bank_Statement_Import_Execution.xml](https://www.enginatics.com/xml/ce-bank-statement-import-execution/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ce-bank-statement-import-execution/](https://www.enginatics.com/reports/ce-bank-statement-import-execution/) |

## Executive Summary
The **CE Bank Statement Import Execution** report is a technical and operational log of the bank statement import process. When bank statements (BAI2, MT940, etc.) are loaded into Oracle, this report tracks the success or failure of that interface process. It highlights specific errors (e.g., "Invalid Account Number", "Duplicate Statement"), allowing the technical team or cash users to troubleshoot and correct the data before attempting to re-import.

## Business Challenge
Automated bank statement import is critical for daily cash visibility. However, file format changes, invalid characters, or configuration mismatches can cause imports to fail.
*   **Silent Failures**: Without a clear report, a missing statement might go unnoticed until month-end.
*   **Troubleshooting**: Error messages in the standard log file can be cryptic or hard to parse.
*   **Data Integrity**: Ensuring that the file was loaded completely (header and all lines) is essential before starting reconciliation.

## Solution
This report queries the interface and error tables to provide a readable summary of the import execution.

**Key Features:**
*   **Error Filtering**: Option to "Show Warnings/Errors Only" to focus immediately on problems.
*   **Interface Visibility**: Shows data sitting in the interface tables (`CE_STATEMENT_HEADERS_INT`) that failed to load into the main tables.
*   **Detailed Messages**: Displays the specific error message (e.g., "Bank Account not defined") associated with each failed line or header.

## Architecture
The report checks `CE_HEADER_INTERFACE_ERRORS` and `CE_RECONCILIATION_ERRORS` linked to the statement interface tables.

**Key Tables:**
*   `CE_STATEMENT_HEADERS_INT`: The staging table for incoming statements.
*   `CE_HEADER_INTERFACE_ERRORS`: Stores validation errors for the statement header.
*   `CE_RECONCILIATION_ERRORS`: Stores errors related to the auto-reconciliation process (if triggered during import).
*   `CE_BANK_ACCOUNTS`: To validate the account number in the file.

## Impact
*   **System Reliability**: Ensures that bank data feeds are monitoring and maintained.
*   **Rapid Resolution**: Helps IT and Treasury quickly identify why a file failed (e.g., "New bank branch code in file") and fix the setup.
*   **Process Assurance**: Confirms that the daily cash data has been successfully loaded and is ready for reconciliation.


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

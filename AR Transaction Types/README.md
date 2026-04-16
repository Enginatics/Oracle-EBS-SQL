---
layout: default
title: 'AR Transaction Types | Oracle EBS SQL Report'
description: 'Imported from BI Publisher Description: Print a listing of the Transaction Types Application: Receivables Source: Transaction Types Listing (XML) Short…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Transaction, Types, ra_cust_trx_types, ra_terms, hr_operating_units'
permalink: /AR%20Transaction%20Types/
---

# AR Transaction Types – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-transaction-types/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from BI Publisher
Description: Print a listing of the Transaction Types
Application: Receivables
Source: Transaction Types Listing (XML)
Short Name: RAXTTL_XML
DB package: AR_RAXTTL_XMLP_PKG

## Report Parameters
Operating Unit

## Oracle EBS Tables Used
[ra_cust_trx_types](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_types), [ra_terms](https://www.enginatics.com/library/?pg=1&find=ra_terms), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[ONT Transaction Types and Line WF Processes](/ONT%20Transaction%20Types%20and%20Line%20WF%20Processes/ "ONT Transaction Types and Line WF Processes Oracle EBS SQL Report"), [PN Billing/Payment Term Upload](/PN%20Billing-Payment%20Term%20Upload/ "PN Billing/Payment Term Upload Oracle EBS SQL Report"), [AR Transaction Upload](/AR%20Transaction%20Upload/ "AR Transaction Upload Oracle EBS SQL Report"), [AR Transactions and Lines 11i](/AR%20Transactions%20and%20Lines%2011i/ "AR Transactions and Lines 11i Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AR Transaction Types 21-Aug-2025 223301.xlsx](https://www.enginatics.com/example/ar-transaction-types/) |
| Blitz Report™ XML Import | [AR_Transaction_Types.xml](https://www.enginatics.com/xml/ar-transaction-types/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-transaction-types/](https://www.enginatics.com/reports/ar-transaction-types/) |

## AR Transaction Types - Case Study & Technical Analysis

### Executive Summary

The **AR Transaction Types** report is a configuration audit tool that lists all defined transaction types within the Oracle Receivables module. Transaction types are the fundamental building blocks of AR, defining the behavior of Invoices, Credit Memos, Debit Memos, Chargebacks, and Guarantees. This report is essential for System Administrators and Finance Managers to verify that the system's accounting logic and operational rules are correctly configured.

### Business Challenge

The behavior of every billing document is controlled by its Transaction Type.
*   **Accounting Integrity:** If a transaction type is incorrectly set to "Post to GL = No," sales will be recorded in the subledger but missing from the financial statements.
*   **Process Control:** Types control whether a transaction creates a positive or negative sign (Invoice vs. Credit Memo) and whether it updates the customer's open balance.
*   **Standardization:** Over time, organizations may create duplicate types (e.g., "Manual Invoice" vs. "Manual Inv"), leading to inconsistent reporting.

### Solution

The **AR Transaction Types** report provides a detailed inventory of these definitions:
*   **Behavioral Flags:** Shows critical settings like "Open Receivable" (updates balance) and "Post to GL" (creates accounting).
*   **Default Accounting:** Displays the default General Ledger accounts (Revenue, Receivable, Tax, Freight) mapped to each type, ensuring that AutoAccounting works as expected.
*   **Terms & Dates:** Verifies default payment terms and date rules.

### Technical Architecture

The report queries the core setup table for transaction types.

#### Key Tables & Joins

*   **Definition:** `RA_CUST_TRX_TYPES_ALL` is the primary table containing the configuration flags and names.
*   **Accounting:** `GL_CODE_COMBINATIONS_KFV` is joined to display the human-readable account strings for the default GL accounts.
*   **Terms:** `RA_TERMS` links to the default payment terms assigned to the type.
*   **Organization:** `HR_OPERATING_UNITS` filters the types by the specific business unit.

#### Logic

1.  **Retrieval:** Fetches all transaction types for the selected Operating Unit.
2.  **Decoding:** Translates internal flags (e.g., 'INV', 'CM') into user-friendly descriptions.
3.  **Mapping:** Joins to the GL code combinations to show the full account structure for each of the default accounts (Receivable, Revenue, etc.).

### Parameters

*   **Operating Unit:** The specific business entity whose configuration is being reviewed.

### FAQ

**Q: What does the "Open Receivable" flag do?**
A: If set to 'Yes', the transaction will increase (or decrease) the customer's outstanding balance. If 'No', it is a memo-only transaction (like a Pro Forma invoice) that does not affect the amount owed.

**Q: Why is the "Revenue Account" blank for some types?**
A: Some types might rely on AutoAccounting rules to derive the revenue account dynamically based on the item or salesperson, rather than having a hardcoded default.

**Q: Can I delete a Transaction Type?**
A: No, once a type has been used to create a transaction, it cannot be deleted. It can only be end-dated to prevent future use.


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

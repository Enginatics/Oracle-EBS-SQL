---
layout: default
title: 'CE Bank Branches | Oracle EBS SQL Report'
description: 'This Report is the repository of all bank branches covering both internal and external bank accounts and will list the bank branches along with an…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Bank, Branches, ce_bank_accounts, iby_ext_bank_accounts, iby_pmt_instr_uses_all'
permalink: /CE%20Bank%20Branches/
---

# CE Bank Branches – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ce-bank-branches/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
This Report is the repository of all bank branches covering both internal and external bank accounts and will list the bank branches along with an indication of usage:
-Internal
-Supplier
-Customer


## Report Parameters
Bank Name, Bank Branch Name, Show Internal Usage, Show Supplier Usage, Show Customer Usage

## Oracle EBS Tables Used
[ce_bank_accounts](https://www.enginatics.com/library/?pg=1&find=ce_bank_accounts), [iby_ext_bank_accounts](https://www.enginatics.com/library/?pg=1&find=iby_ext_bank_accounts), [iby_pmt_instr_uses_all](https://www.enginatics.com/library/?pg=1&find=iby_pmt_instr_uses_all), [iby_external_payees_all](https://www.enginatics.com/library/?pg=1&find=iby_external_payees_all), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers), [iby_external_payers_all](https://www.enginatics.com/library/?pg=1&find=iby_external_payers_all), [ce_bank_branches_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_branches_v), [ce_banks_v](https://www.enginatics.com/library/?pg=1&find=ce_banks_v), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report"), [AP Suppliers](/AP%20Suppliers/ "AP Suppliers Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CE Bank Branches 02-Aug-2024 090909.xlsx](https://www.enginatics.com/example/ce-bank-branches/) |
| Blitz Report™ XML Import | [CE_Bank_Branches.xml](https://www.enginatics.com/xml/ce-bank-branches/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ce-bank-branches/](https://www.enginatics.com/reports/ce-bank-branches/) |

## Executive Summary
The **CE Bank Branches** report serves as a master directory of all bank branches defined in the system, covering both internal (company-owned) and external (supplier/customer) banks. It provides a clear view of the banking network relationships, indicating whether a branch is used for internal treasury operations, supplier payments, or customer receipts. This report is vital for Master Data Management (MDM) teams to maintain a clean and accurate banking hierarchy.

## Business Challenge
As organizations grow, the number of bank branches in the system can proliferate, leading to:
*   **Duplicate Records**: Multiple entries for the same physical branch (e.g., "Citibank NY" vs. "Citi New York").
*   **Obsolete Data**: Branches that are no longer in use but remain active in the system.
*   **Routing Errors**: Payments failing because they are routed to an incorrect or inactive branch code (SWIFT/BIC).

Maintaining a clean "Golden Source" of bank branch data is critical for payment processing efficiency.

## Solution
This report lists every bank branch along with its parent Bank and its usage flags.

**Key Features:**
*   **Usage Indicators**: Clearly marks if a branch is used for:
    *   *Internal*: Linked to the company's own bank accounts.
    *   *Supplier*: Linked to supplier payment details.
    *   *Customer*: Linked to customer remittance details.
*   **Global Coverage**: Includes branches from all territories and countries.
*   **Integration**: Links to the underlying party tables (`HZ_PARTIES`) to show the full relationship structure.

## Architecture
The report queries `CE_BANK_BRANCHES_V` and `CE_BANKS_V` for the core branch data. It joins to `IBY` (Payments) tables to determine usage.

**Key Tables:**
*   `CE_BANK_BRANCHES_V`: The primary view for bank branch definitions.
*   `CE_BANK_ACCOUNTS`: To identify internal usage.
*   `IBY_EXT_BANK_ACCOUNTS`: To identify external (supplier/customer) usage.
*   `AP_SUPPLIERS`: To link branches to specific suppliers.

## Impact
*   **Data Hygiene**: Enables the identification and cleanup of duplicate or unused branch records.
*   **Payment Success**: Reduces payment rejections caused by invalid branch routing codes.
*   **Compliance**: Helps ensure that the banking master data matches official bank records.


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

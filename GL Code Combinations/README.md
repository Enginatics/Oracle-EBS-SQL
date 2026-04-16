---
layout: default
title: 'GL Code Combinations | Oracle EBS SQL Report'
description: 'Parameter ''Show Misclassified Accounts'' can be used to identify code combinations, which have a different account type than their flexfield value setup…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Code, Combinations, gl_summary_templates, gl_code_combinations_kfv, fnd_flex_values'
permalink: /GL%20Code%20Combinations/
---

# GL Code Combinations – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-code-combinations/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Parameter 'Show Misclassified Accounts' can be used to identify code combinations, which have a different account type than their flexfield value setup.
There is an Oracle note explaining the implications of correcting these:
R12: Troubleshooting Misclassified Accounts in General Ledger (KB706390)
<a href="https://support.oracle.com/support/?kmContentId=872162" rel="nofollow" target="_blank">https://support.oracle.com/support/?kmContentId=872162</a>

## Report Parameters
Chart of Accounts, Ledger, Show Balance and Posted Date, Account Type, Show Misclassified Accounts, Child Accounts Only, Segment1 like, Segment1 From, Segment1 To, Segment2 like, Segment2 From, Segment2 To, Segment3 like, Segment3 From, Segment3 To, Segment4 like, Segment4 From, Segment4 To, Segment5 like, Segment5 From, Segment5 To

## Oracle EBS Tables Used
[gl_summary_templates](https://www.enginatics.com/library/?pg=1&find=gl_summary_templates), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [fnd_flex_values](https://www.enginatics.com/library/?pg=1&find=fnd_flex_values), [fnd_segment_attribute_values](https://www.enginatics.com/library/?pg=1&find=fnd_segment_attribute_values), [fnd_id_flex_structures_vl](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_structures_vl), [fnd_id_flex_segments](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_segments), [gl_balances](https://www.enginatics.com/library/?pg=1&find=gl_balances), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods), [gl_je_headers](https://www.enginatics.com/library/?pg=1&find=gl_je_headers), [gl_je_lines](https://www.enginatics.com/library/?pg=1&find=gl_je_lines)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis 11g](/GL%20Account%20Analysis%2011g/ "GL Account Analysis 11g Oracle EBS SQL Report"), [GL Balance](/GL%20Balance/ "GL Balance Oracle EBS SQL Report"), [GL Balance by Account Hierarchy](/GL%20Balance%20by%20Account%20Hierarchy/ "GL Balance by Account Hierarchy Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL Code Combinations 31-May-2025 130542.xlsx](https://www.enginatics.com/example/gl-code-combinations/) |
| Blitz Report™ XML Import | [GL_Code_Combinations.xml](https://www.enginatics.com/xml/gl-code-combinations/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-code-combinations/](https://www.enginatics.com/reports/gl-code-combinations/) |

## GL Code Combinations - Case Study & Technical Analysis

### Executive Summary
The **GL Code Combinations** report is a master data management tool designed to audit, analyze, and maintain the Chart of Accounts structure. It lists valid accounting flexfield combinations, their attributes (such as account type and enabled status), and helps identify misclassified accounts or setup inconsistencies. This report is critical for maintaining the integrity of the financial reporting structure and ensuring that data entry adheres to corporate governance standards.

### Business Use Cases
*   **Master Data Governance**: Ensures all created account combinations adhere to corporate naming conventions and validation rules, preventing the proliferation of invalid or duplicate accounts.
*   **Misclassification Audit**: Identifies accounts with incorrect types (e.g., an Asset account incorrectly flagged as an Expense), which can severely distort financial statements and trial balances.
*   **Cleanup Initiatives**: Assists in identifying disabled, end-dated, or unused code combinations to streamline the chart of accounts and improve system performance.
*   **Cross-Validation Rule Testing**: Verifies that existing combinations comply with newly defined cross-validation rules (CVRs) and security rules.
*   **Revaluation Setup**: Validates that revaluation tracking is enabled for the correct foreign currency accounts.

### Technical Analysis

#### Core Tables
*   `GL_CODE_COMBINATIONS` (often aliased as `GCC`): The central table storing every unique combination of segment values used in the system.
*   `FND_FLEX_VALUES`: Stores the definitions and attributes of individual segment values.
*   `FND_ID_FLEX_STRUCTURES_VL`: Provides metadata about the Chart of Accounts structure.

#### Key Joins & Logic
*   **Segment Validation**: The report iterates through `GL_CODE_COMBINATIONS`. It joins to `FND_FLEX_VALUES` for each segment to retrieve descriptions and attributes.
*   **Misclassification Logic**: A critical feature is the detection of misclassified accounts. The logic typically compares the `ACCOUNT_TYPE` on the `GL_CODE_COMBINATIONS` record (which is stamped upon creation) against the `COMPILED_VALUE_ATTRIBUTE1` (Account Type) of the natural account segment value in `FND_FLEX_VALUES`. If they differ (e.g., the natural account is now an 'Asset' but the combination remains 'Expense'), it flags the record for correction.
*   **Flexfield Hierarchy**: The query dynamically handles the number of segments defined in the user's Chart of Accounts (COA) structure.

#### Key Parameters
*   **Chart of Accounts**: The specific accounting structure to analyze.
*   **Account Type**: Filter to view only Assets, Liabilities, Expenses, Revenue, or Equity.
*   **Show Misclassified Accounts**: A boolean flag to trigger the logic that identifies discrepancies between segment attributes and combination attributes.
*   **Segment Ranges**: Allows filtering by specific companies, cost centers, or natural accounts.


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

---
layout: default
title: 'GL Balance by Account Hierarchy | Oracle EBS SQL Report'
description: 'Summary GL report including one line per GL account. This report has multiple collapsible/expandable summary levels based on the GL account hierarchy…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Balance, Account, Hierarchy, gl_daily_conversion_types, gl_daily_rates, gl_ledgers'
permalink: /GL%20Balance%20by%20Account%20Hierarchy/
---

# GL Balance by Account Hierarchy – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-balance-by-account-hierarchy/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Summary GL report including one line per GL account. This report has multiple collapsible/expandable summary levels based on the GL account hierarchy, with starting balance, total amount per month, ending total and YTD balance.
Parameter 'Additional Segment' can be used to include additional segments e.g. cost center or balancing segment.

## Report Parameters
Ledger, Ledger Category, Period, Show Full Year, Hierarchy Segment, Additional Segment1, Additional Segment2, Additional Segment3, Sort by Additional Segment, Hierarchy Name, Show Account Type, Account Type, Show Child Account Level, Summary Template only, Revaluation Currency, Revaluation Conversion Type, Balance Type, Budget Name, Encumbrance Type, Exclude Inactive

## Oracle EBS Tables Used
[gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types), [gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_period_statuses](https://www.enginatics.com/library/?pg=1&find=gl_period_statuses), [gl_balances](https://www.enginatics.com/library/?pg=1&find=gl_balances), [fnd_id_flex_segments](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_segments), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [fnd_flex_values](https://www.enginatics.com/library/?pg=1&find=fnd_flex_values), [fnd_flex_value_norm_hierarchy](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_norm_hierarchy), [table](https://www.enginatics.com/library/?pg=1&find=table), [fnd_segment_attribute_values](https://www.enginatics.com/library/?pg=1&find=fnd_segment_attribute_values), [gl_summary_templates](https://www.enginatics.com/library/?pg=1&find=gl_summary_templates), [fnd_lookup_values_vl](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL Balance by Account Hierarchy 12-Nov-2020 012923.xlsx](https://www.enginatics.com/example/gl-balance-by-account-hierarchy/) |
| Blitz Report™ XML Import | [GL_Balance_by_Account_Hierarchy.xml](https://www.enginatics.com/xml/gl-balance-by-account-hierarchy/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-balance-by-account-hierarchy/](https://www.enginatics.com/reports/gl-balance-by-account-hierarchy/) |

## GL Balance by Account Hierarchy - Case Study & Technical Analysis

### Executive Summary
The **GL Balance by Account Hierarchy** report is a sophisticated financial reporting solution that leverages Oracle General Ledger's parent-child account relationships. It presents balances in a hierarchical format, allowing users to drill down from high-level summary accounts to detailed child accounts. This report is vital for producing financial statements (like Balance Sheets and Income Statements) directly from the system, respecting the defined rollup structures.

### Business Challenge
Organizations define complex account hierarchies to structure their financial reporting. However, extracting data that respects these hierarchies can be challenging:
- **Hierarchy Complexity:** Parent accounts often aggregate data from multiple child accounts across different ranges.
- **Reporting Gaps:** Standard reports often show only detail accounts or flat lists, losing the context of the financial structure.
- **Maintenance:** As hierarchies change (e.g., new cost centers, reorganized departments), reports must automatically reflect these changes without manual updates.
- **Visibility:** Managers need to see both the summary level performance and the contributing details in a single view.

### Solution
The **GL Balance by Account Hierarchy** report dynamically traverses the defined Flexfield Value Set Hierarchies to present a structured view of GL balances.

**Key Features:**
- **Hierarchical Display:** Shows parent accounts and their children in a collapsible/expandable format (in tools that support it) or structured list.
- **Rollup Logic:** Automatically aggregates balances from child accounts to their respective parents.
- **Multi-Level Analysis:** Supports multiple levels of nesting within the account structure.
- **Segment Flexibility:** Allows reporting based on the hierarchy of a specific segment (usually the Natural Account or Cost Center).
- **Additional Segmentation:** Users can include additional segments (e.g., Balancing Segment) to analyze the hierarchy within specific business units.

### Technical Architecture
The report relies on the recursive relationships defined in the Application Object Library (AOL) flexfield tables to build the hierarchy and join it with GL balances.

#### Key Tables and Views
- **`FND_FLEX_VALUE_NORM_HIERARCHY`**: Defines the parent-child ranges for flexfield values.
- **`FND_FLEX_VALUES`**: Stores the individual segment values (both parents and children).
- **`GL_BALANCES`**: The source of financial data.
- **`GL_CODE_COMBINATIONS`**: Links balances to specific accounts.
- **`FND_ID_FLEX_SEGMENTS`**: Used to identify which segment holds the hierarchy.
- **`GL_SUMMARY_TEMPLATES`**: (Optional) Used if summary templates are leveraged for performance.

#### Core Logic
1.  **Hierarchy Traversal:** The query uses hierarchical SQL (e.g., `CONNECT BY`) or recursive joins on `FND_FLEX_VALUE_NORM_HIERARCHY` to establish the parent-child tree structure.
2.  **Balance Assignment:** Detail balances from `GL_BALANCES` are assigned to the lowest level (child) nodes in the tree.
3.  **Aggregation:** Balances are rolled up the tree, summing child balances to populate parent nodes.
4.  **Filtering:** The report filters by Ledger, Period, and the specific Hierarchy Name selected by the user.

### Business Impact
- **Strategic Reporting:** Enables the generation of hierarchy-based financial statements directly from Oracle EBS.
- **Data Consistency:** Ensures that reporting always reflects the current, active account hierarchy definition.
- **Drill-Down Capability:** Provides transparency into the composition of summary balances, aiding in variance analysis.
- **User Empowerment:** Allows finance users to validate hierarchy changes immediately by running the report.


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

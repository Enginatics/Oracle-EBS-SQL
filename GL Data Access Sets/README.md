---
layout: default
title: 'GL Data Access Sets | Oracle EBS SQL Report'
description: 'Master data report showing ledger security. Listing of all GL data access sets and the ledgers or ledger sets that each access set can access.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Data, Access, Sets, gl_access_sets_v, gl_access_set_norm_assign, gl_ledger_set_norm_assign_v'
permalink: /GL%20Data%20Access%20Sets/
---

# GL Data Access Sets – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-data-access-sets/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Master data report showing ledger security.
Listing of all GL data access sets and the ledgers or ledger sets that each access set can access.

## Report Parameters
Access Set

## Oracle EBS Tables Used
[gl_access_sets_v](https://www.enginatics.com/library/?pg=1&find=gl_access_sets_v), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report"), [CAC Material Overhead Setup](/CAC%20Material%20Overhead%20Setup/ "CAC Material Overhead Setup Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC Standard Cost Update Submissions](/CAC%20Standard%20Cost%20Update%20Submissions/ "CAC Standard Cost Update Submissions Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL Data Access Sets 12-Apr-2019 022216.xlsx](https://www.enginatics.com/example/gl-data-access-sets/) |
| Blitz Report™ XML Import | [GL_Data_Access_Sets.xml](https://www.enginatics.com/xml/gl-data-access-sets/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-data-access-sets/](https://www.enginatics.com/reports/gl-data-access-sets/) |

## GL Data Access Sets - Case Study & Technical Analysis

### Executive Summary
The **GL Data Access Sets** report analyzes the security configuration of the General Ledger, specifically focusing on Data Access Sets. It details which ledgers and ledger sets are accessible to specific users or responsibilities, ensuring proper segregation of duties and data security. This report is a key component of system administration and internal audit workflows, providing visibility into "who can see what" within the financial system.

### Business Use Cases
*   **Security Audit**: Verifies that users only have access to the ledgers relevant to their role (e.g., ensuring US users access only US ledgers and cannot view or post to European ledgers).
*   **System Administration**: Assists in troubleshooting "access denied" issues or empty reports by confirming the active Data Access Set configuration for a specific responsibility.
*   **Compliance Reporting**: Documents data access controls for SOX (Sarbanes-Oxley) or internal audit requirements, proving that financial data is protected from unauthorized access.
*   **Implementation Verification**: Validates that the complex hierarchy of Ledgers and Ledger Sets has been correctly mapped to Data Access Sets during system setup.

### Technical Analysis

#### Core Tables
*   `GL_ACCESS_SETS`: Defines the header information for a data access set (Name, Security Code, Chart of Accounts ID).
*   `GL_ACCESS_SET_ASSIGNMENTS`: Maps the Data Access Set to specific Ledgers or Ledger Sets.
*   `GL_LEDGERS`: Stores details about the ledgers themselves.
*   `GL_LEDGER_SET_NORM_ASSIGN_V`: A view that helps resolve the flattened list of ledgers contained within a Ledger Set.

#### Key Joins & Logic
*   **Access Mapping**: The query joins `GL_ACCESS_SETS` to `GL_ACCESS_SET_ASSIGNMENTS` to find the scope of access.
*   **Ledger Resolution**: It links to `GL_LEDGERS` to retrieve the names of the accessible entities.
*   **Hierarchy Flattening**: A Data Access Set can grant access to a "Ledger Set" (a group of ledgers). The report logic often needs to expand this Ledger Set to list the individual underlying ledgers to provide a complete picture of access.
*   **Privilege Check**: The report distinguishes between `READ_ONLY` and `READ_WRITE` privileges, which is stored in the assignment table.

#### Key Parameters
*   **Access Set Name**: The specific data access set to analyze.
*   **Ledger Name**: Filter to see which access sets provide access to a specific ledger.


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

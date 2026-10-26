---
layout: default
last_modified_at: 2026-10-26
title: 'INV Organization Access | Oracle EBS SQL Report'
description: 'Inventory organization access for all responsibilities, either through hr security profile or individual orgaccess assignment.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Inventory, Enginatics, INV, Organization, Access, mtl_parameters, org_access_view, org_access'
permalink: /INV%20Organization%20Access/
report_name: 'INV Organization Access'
report_web_name: inv-organization-access
module: 'Inventory'
module_url: /modules/inventory/
---

# INV Organization Access – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-organization-access/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-access) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-access).
**Oracle EBS module:** [Inventory](/modules/inventory/ "Oracle EBS Inventory reports") · [all Inventory reports](/modules/inventory/)  

## Overview
Inventory organization access for all responsibilities, either through hr security profile or individual org_access assignment.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-access) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Application Name, Responsibility Name

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-access), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-access), [org_access](https://www.enginatics.com/library/?pg=1&find=org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-access), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-access), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-access)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-access)

## Related Reports
[INV Onhand Quantities](/INV%20Onhand%20Quantities/ "INV Onhand Quantities Oracle EBS SQL Report"), [INV Item Default Transaction Locators](/INV%20Item%20Default%20Transaction%20Locators/ "INV Item Default Transaction Locators Oracle EBS SQL Report"), [BOM Calendar Exceptions](/BOM%20Calendar%20Exceptions/ "BOM Calendar Exceptions Oracle EBS SQL Report"), [PO Approved Supplier List](/PO%20Approved%20Supplier%20List/ "PO Approved Supplier List Oracle EBS SQL Report"), [EAM Assets](/EAM%20Assets/ "EAM Assets Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Subinventories](/INV%20Subinventories/ "INV Subinventories Oracle EBS SQL Report"), [INV Stock Locators](/INV%20Stock%20Locators/ "INV Stock Locators Oracle EBS SQL Report"), [INV Safety Stocks](/INV%20Safety%20Stocks/ "INV Safety Stocks Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Organization%20Access/INV%20Organization%20Access.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-access) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Organization Access 18-Jan-2018 222609.xlsx](https://www.enginatics.com/example/inv-organization-access/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-access) |
| Blitz Report™ XML Import | [INV_Organization_Access.xml](https://www.enginatics.com/xml/inv-organization-access/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-access) |
| SQL Source | [INV Organization Access.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Organization%20Access/INV%20Organization%20Access.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-organization-access/](https://www.enginatics.com/reports/inv-organization-access/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-access) |

## INV Organization Access - Case Study & Technical Analysis

### Executive Summary
The **INV Organization Access** report is a security audit tool. In Oracle EBS, access to inventory organizations is controlled by the "Organization Access" form (mapping Responsibilities to Orgs). This report lists which responsibilities have access to which organizations, ensuring that users are not granted excessive privileges.

### Business Challenge
In multi-org environments (e.g., a company with 50 warehouses globally), managing security is complex. Risks include:
-   **Data Leakage:** A user in the "US Warehouse" responsibility accidentally seeing "China Manufacturing" data.
-   **Transaction Errors:** A user transacting in the wrong organization because they have access to too many.
-   **Audit Failures:** Auditors require proof that access is restricted on a "Need to Know" basis.

### Solution
The **INV Organization Access** report provides a clear matrix of Responsibility-to-Organization mappings. It validates the security setup defined in the `ORG_ACCESS` table.

**Key Features:**
-   **Security Matrix:** Shows exactly which Orgs are visible to which Responsibilities.
-   **Application Context:** Identifies the application (Inventory, Purchasing, BOM) associated with the responsibility.
-   **User Mapping:** Can be extended to show which *Users* have those responsibilities.

### Technical Architecture
The report queries the security definition tables used by the `ORG_ACCESS_VIEW` mechanism.

#### Key Tables and Views
-   **`ORG_ACCESS`**: The table storing the link between `RESPONSIBILITY_ID` and `ORGANIZATION_ID`.
-   **`FND_RESPONSIBILITY_VL`**: Responsibility definitions.
-   **`HR_ALL_ORGANIZATION_UNITS`**: Organization definitions.
-   **`ORG_ACCESS_VIEW`**: The standard view that enforces this security at runtime.

#### Core Logic
1.  **Mapping Retrieval:** Selects all records from `ORG_ACCESS`.
2.  **Resolution:** Joins IDs to names for Responsibilities and Organizations.
3.  **Validation:** Checks if the responsibility is still active.

### Business Impact
-   **Security Compliance:** Ensures adherence to Segregation of Duties (SoD) and data access policies.
-   **Error Prevention:** Reduces the risk of accidental transactions in the wrong organization.
-   **Audit Readiness:** Provides immediate evidence of access controls for IT audits.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-access)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-access)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-access)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-access)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-access)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-access)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-access)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

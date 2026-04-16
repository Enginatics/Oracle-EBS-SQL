---
layout: default
title: 'INV Organization Access | Oracle EBS SQL Report'
description: 'Inventory organization access for all responsibilities, either through hr security profile or individual orgaccess assignment.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Organization, Access, mtl_parameters, org_access_view, org_access'
permalink: /INV%20Organization%20Access/
---

# INV Organization Access – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-organization-access/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Inventory organization access for all responsibilities, either through hr security profile or individual org_access assignment.

## Report Parameters
Organization Code, Application Name, Responsibility Name

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [org_access](https://www.enginatics.com/library/?pg=1&find=org_access), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Missing Receiving Accounting Transactions](/CAC%20Missing%20Receiving%20Accounting%20Transactions/ "CAC Missing Receiving Accounting Transactions Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report"), [CAC Missing WIP Accounting Transactions](/CAC%20Missing%20WIP%20Accounting%20Transactions/ "CAC Missing WIP Accounting Transactions Oracle EBS SQL Report"), [CAC Receiving Account Detail](/CAC%20Receiving%20Account%20Detail/ "CAC Receiving Account Detail Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report"), [CAC Item Cost Summary](/CAC%20Item%20Cost%20Summary/ "CAC Item Cost Summary Oracle EBS SQL Report"), [CAC OPM WIP Account Value](/CAC%20OPM%20WIP%20Account%20Value/ "CAC OPM WIP Account Value Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Organization Access 18-Jan-2018 222609.xlsx](https://www.enginatics.com/example/inv-organization-access/) |
| Blitz Report™ XML Import | [INV_Organization_Access.xml](https://www.enginatics.com/xml/inv-organization-access/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-organization-access/](https://www.enginatics.com/reports/inv-organization-access/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics

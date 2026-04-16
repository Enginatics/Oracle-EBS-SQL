---
layout: default
title: 'GL Ledgers and Organizations | Oracle EBS SQL Report'
description: 'Master data report showing business group, ledger set, ledger, ledger category, currency, chart of accounts name, operating unit, organization code…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Ledgers, Organizations, mtl_parameters, gl_ledgers, fnd_id_flex_structures_vl'
permalink: /GL%20Ledgers%20and%20Organizations/
---

# GL Ledgers and Organizations – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-ledgers-and-organizations/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Master data report showing business group, ledger set, ledger, ledger category, currency, chart of accounts name, operating unit, organization code, country, legal entity, ledger id, chart of accounts code. It also includes support elements such as chart of accounts ID, operating unit ID, and  organization ID.

## Report Parameters
Chart of Accounts, Ledger, Operating Unit, Organization Code, Country, Active Organizations only

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [fnd_id_flex_structures_vl](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_structures_vl), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[INV Organization Parameters](/INV%20Organization%20Parameters/ "INV Organization Parameters Oracle EBS SQL Report"), [CAC Where Used by Cost Type](/CAC%20Where%20Used%20by%20Cost%20Type/ "CAC Where Used by Cost Type Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs by Where Used](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/ "CAC Calculate ICP PII Item Costs by Where Used Oracle EBS SQL Report"), [CAC Item vs. Component Include in Rollup Controls](/CAC%20Item%20vs-%20Component%20Include%20in%20Rollup%20Controls/ "CAC Item vs. Component Include in Rollup Controls Oracle EBS SQL Report"), [PO Approval Groups](/PO%20Approval%20Groups/ "PO Approval Groups Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL Ledgers and Organizations 11-Mar-2020 070723.xlsx](https://www.enginatics.com/example/gl-ledgers-and-organizations/) |
| Blitz Report™ XML Import | [GL_Ledgers_and_Organizations.xml](https://www.enginatics.com/xml/gl-ledgers-and-organizations/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-ledgers-and-organizations/](https://www.enginatics.com/reports/gl-ledgers-and-organizations/) |

## GL Ledgers and Organizations - Case Study & Technical Analysis

### Executive Summary
The **GL Ledgers and Organizations** report extends the structural analysis of the system by mapping Ledgers down to the Operating Unit and Inventory Organization level. It provides a complete "vertical" view of the organization structure, from the Business Group down to the specific warehouse or manufacturing plant. This report is critical for system administrators and supply chain managers to understand how operational entities relate to financial ledgers.

### Business Use Cases
*   **Multi-Org Access Control (MOAC) Review**: Helps administrators verify which Operating Units are linked to which Ledgers, aiding in the setup of security profiles.
*   **Supply Chain Configuration**: Validates that Inventory Organizations are assigned to the correct Operating Units and Ledgers, ensuring that material transactions post to the correct GL accounts.
*   **Implementation Documentation**: Generates a "As-Built" document of the organization structure after a new implementation or rollout.
*   **Troubleshooting Accounting Issues**: When a subledger transaction fails to post, this report helps confirm that the originating organization is correctly mapped to a valid ledger.

### Technical Analysis

#### Core Tables
*   `HR_OPERATING_UNITS`: Defines the Operating Units (Org ID).
*   `ORG_ORGANIZATION_DEFINITIONS`: A key view that links Inventory Orgs to Operating Units and Ledgers.
*   `GL_LEDGERS`: The financial ledger.
*   `HR_ALL_ORGANIZATION_UNITS`: The base table for all organization types (Business Groups, OUs, Inv Orgs).
*   `HR_LOCATIONS_ALL`: Provides address and country information.

#### Key Joins & Logic
*   **Organizational Hierarchy**: The query typically joins `ORG_ORGANIZATION_DEFINITIONS` (which contains `SET_OF_BOOKS_ID`/`LEDGER_ID`) to `GL_LEDGERS`.
*   **Operating Unit Link**: It links Inventory Orgs to their parent Operating Unit via `OPERATING_UNIT` column.
*   **Business Group Context**: It resolves the Business Group to show the highest level of the hierarchy.
*   **Location Details**: Joins to `HR_LOCATIONS_ALL` to retrieve the country and address, which is useful for tax and legal compliance checks.

#### Key Parameters
*   **Ledger**: Filter by specific ledger.
*   **Operating Unit**: Filter by specific OU.
*   **Organization Code**: Filter by specific Inventory Org code (e.g., "M1").
*   **Active Organizations only**: A flag to exclude end-dated or inactive organizations.


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

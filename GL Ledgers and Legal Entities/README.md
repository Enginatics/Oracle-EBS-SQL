---
layout: default
title: 'GL Ledgers and Legal Entities | Oracle EBS SQL Report'
description: 'Master data report showing ledger set, ledger name, ledger category, currency, legal entity, and balancing segment across all ledgers and legal entities.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Ledgers, Legal, Entities, gl_ledger_set_norm_assign_v, gl_ledgers, gl_legal_entities_bsvs'
permalink: /GL%20Ledgers%20and%20Legal%20Entities/
---

# GL Ledgers and Legal Entities – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-ledgers-and-legal-entities/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Master data report showing ledger set, ledger name, ledger category, currency, legal entity, and  balancing segment across all ledgers and legal entities.

## Report Parameters
Ledger, Country

## Oracle EBS Tables Used
[gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_legal_entities_bsvs](https://www.enginatics.com/library/?pg=1&find=gl_legal_entities_bsvs), [fnd_flex_values_vl](https://www.enginatics.com/library/?pg=1&find=fnd_flex_values_vl), [fnd_id_flex_structures_vl](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_structures_vl), [gl_ledger_config_details](https://www.enginatics.com/library/?pg=1&find=gl_ledger_config_details), [xle_firstparty_information_v](https://www.enginatics.com/library/?pg=1&find=xle_firstparty_information_v), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Summary](/CAC%20ICP%20PII%20Material%20Account%20Summary/ "CAC ICP PII Material Account Summary Oracle EBS SQL Report"), [CAC ICP PII WIP Pending Cost Adjustment](/CAC%20ICP%20PII%20WIP%20Pending%20Cost%20Adjustment/ "CAC ICP PII WIP Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL Ledgers and Legal Entities 11-Mar-2020 085737.xlsx](https://www.enginatics.com/example/gl-ledgers-and-legal-entities/) |
| Blitz Report™ XML Import | [GL_Ledgers_and_Legal_Entities.xml](https://www.enginatics.com/xml/gl-ledgers-and-legal-entities/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-ledgers-and-legal-entities/](https://www.enginatics.com/reports/gl-ledgers-and-legal-entities/) |

## GL Ledgers and Legal Entities - Case Study & Technical Analysis

### Executive Summary
The **GL Ledgers and Legal Entities** report is a comprehensive master data report that maps the complex hierarchy of the Oracle E-Business Suite financial structure. It visualizes the relationships between Ledger Sets, Ledgers, Legal Entities, and Balancing Segments. This report is essential for verifying the enterprise structure setup, ensuring that legal entities are correctly assigned to ledgers and that balancing segment values (Company Codes) are properly mapped.

### Business Use Cases
*   **Enterprise Structure Verification**: Validates that the system configuration matches the designed corporate structure (e.g., "Does the UK Legal Entity correctly roll up to the UK Ledger?").
*   **Balancing Segment Audit**: Ensures that every Balancing Segment Value (BSV) is assigned to a Legal Entity, preventing "unassigned" transactions that could cause intercompany accounting failures.
*   **Merger & Acquisition Integration**: Assists in planning the integration of new entities by providing a clear picture of the existing ledger and legal entity landscape.
*   **Tax Reporting Setup**: Verifies that Legal Entities (which are the tax reporting units) are associated with the correct Ledgers and Currencies.

### Technical Analysis

#### Core Tables
*   `GL_LEDGERS`: The central table defining the ledgers.
*   `XLE_ENTITY_PROFILES` (via `XLE_FIRSTPARTY_INFORMATION_V`): Stores Legal Entity definitions.
*   `GL_LEGAL_ENTITIES_BSVS`: The mapping table that assigns Balancing Segment Values to Legal Entities.
*   `GL_LEDGER_CONFIG_DETAILS`: Stores configuration details linking ledgers to legal entities.
*   `GL_LEDGER_SET_NORM_ASSIGN_V`: Resolves Ledger Set memberships.

#### Key Joins & Logic
*   **Hierarchy Traversal**: The query likely starts from `GL_LEDGERS` and joins to `GL_LEDGER_CONFIG_DETAILS` to find the associated Legal Entities.
*   **BSV Mapping**: It joins to `GL_LEGAL_ENTITIES_BSVS` to list the specific segment values (e.g., Company 01, 02) assigned to each entity.
*   **Ledger Set Expansion**: Uses `GL_LEDGER_SET_NORM_ASSIGN_V` to show which Ledger Sets these ledgers belong to, providing a top-down view.
*   **Flexfield Resolution**: Joins to `FND_FLEX_VALUES_VL` to display the descriptions of the balancing segment values.

#### Key Parameters
*   **Ledger**: Filter by a specific Ledger or Ledger Set.
*   **Country**: Filter by the country defined in the Legal Entity or Location.


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

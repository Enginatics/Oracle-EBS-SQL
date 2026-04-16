---
layout: default
title: 'XLA Entity ID Mappings | Oracle EBS SQL Report'
description: 'Shows the column link between table xlatransactionentities and subledger source tables such as and AP invoiceid or AR customertrxid, used when writing…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, XLA, Entity, Mappings, xla_entity_id_mappings, fnd_application_vl'
permalink: /XLA%20Entity%20ID%20Mappings/
---

# XLA Entity ID Mappings – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/xla-entity-id-mappings/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Shows the column link between table xla_transaction_entities and subledger source tables such as and AP invoice_id or AR customer_trx_id, used when writing queries linking GL to subledger such as the GL Account Analysis report <a href="www.enginatics.com/reports/gl-account-analysis/" rel="nofollow" target="_blank">www.enginatics.com/reports/gl-account-analysis/</a>

## Report Parameters


## Oracle EBS Tables Used
[xla_entity_id_mappings](https://www.enginatics.com/library/?pg=1&find=xla_entity_id_mappings), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [CAC OPM WIP Account Value](/CAC%20OPM%20WIP%20Account%20Value/ "CAC OPM WIP Account Value Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [XLA Entity ID Mappings 18-Feb-2026 015632.xlsx](https://www.enginatics.com/example/xla-entity-id-mappings/) |
| Blitz Report™ XML Import | [XLA_Entity_ID_Mappings.xml](https://www.enginatics.com/xml/xla-entity-id-mappings/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/xla-entity-id-mappings/](https://www.enginatics.com/reports/xla-entity-id-mappings/) |

## Case Study & Technical Analysis: XLA Entity ID Mappings Report

### Executive Summary

The XLA Entity ID Mappings report is a crucial technical reference and debugging tool for Oracle Subledger Accounting (SLA). It provides a detailed listing of how the generic `source_id_int_N` columns in SLA tables (`xla_transaction_entities`) map to the primary key columns of various original subledger source tables (e.g., Accounts Payable invoices, Accounts Receivable transactions). This report is indispensable for technical consultants, developers, and advanced functional analysts to understand the complex linkages between General Ledger entries and their originating subledger transactions, debug accounting flows, and build custom reports that trace financial data from the GL back to its source.

### Business Challenge

Oracle Subledger Accounting (SLA) is designed to create a flexible bridge between subledger transactions and the General Ledger. However, understanding the technical data model, particularly how transactions are linked across modules, can be a significant challenge:

-   **Opaque Data Linkages:** The `xla_transaction_entities` table uses generic `source_id_int_N` columns to store primary keys of source subledger transactions. Without clear mappings, it's difficult to know which specific column (e.g., `invoice_id`, `customer_trx_id`) from which subledger table corresponds to `source_id_int_1` for a given SLA entity.
-   **Debugging GL Reconciliations:** When performing GL reconciliation or investigating why a specific GL entry was created, tracing it back to the original subledger transaction requires precise knowledge of these ID mappings. Manual investigation is time-consuming and error-prone.
-   **Custom Reporting Development:** Building custom reports that join GL data (via SLA) back to original subledger details (e.g., an Account Analysis report that drills down to AP invoice lines) critically depends on knowing these `entity_id` mappings.
-   **System Understanding:** For new technical staff or during system upgrades, understanding the SLA data model and how it links various subledgers to the GL is fundamental but can be a steep learning curve.

### The Solution

This report offers a powerful, consolidated, and transparent solution for deciphering SLA entity ID mappings, bringing clarity to complex financial data flows.

-   **Clear ID Mapping Reference:** It provides a detailed list showing the column names and table names in the source subledgers that correspond to the generic `source_id_int_N` columns in `xla_transaction_entities` for each application and entity type. This serves as a vital technical reference.
-   **Accelerated Debugging:** For technical analysts, the report is invaluable for quickly identifying the correct join conditions to link SLA data back to original subledger transactions, dramatically speeding up the diagnosis of accounting errors or data flow issues.
-   **Streamlined Custom Report Development:** Developers can use this report as a blueprint for writing efficient SQL queries that join GL/SLA data to specific subledger details, enabling the creation of powerful drill-down reports.
-   **Enhanced System Understanding:** By clarifying the underlying data model, the report significantly improves the understanding of how SLA processes transactions from various Oracle modules, benefiting system maintenance and upgrades.

### Technical Architecture (High Level)

The report queries core Oracle Subledger Accounting (XLA) and FND tables that store entity ID mapping definitions.

-   **Primary Tables Involved:**
    -   `xla_entity_id_mappings` (the central table storing the mappings between generic SLA source ID columns and specific subledger table columns).
    -   `fnd_application_vl` (for application names, providing context).
-   **Logical Relationships:** The report directly selects from `xla_entity_id_mappings`. This table contains records for each `application_id`, `entity_code`, and `source_id_int_N` column, specifying the `source_table_name` and `source_column_name` to which it corresponds. The `fnd_application_vl` table is joined to translate the `application_id` into a user-friendly application name (e.g., 'Payables', 'Receivables', 'Projects').

### Parameters & Filtering

**No Explicit Parameters:** The `README.md` indicates no specific parameters for this report. This implies that, by design, it provides a comprehensive dump of all configured XLA entity ID mappings across all applications and entity types within the system. This is advantageous for a complete, unfiltered technical reference.

### Performance & Optimization

As a configuration and meta-data report, it is highly optimized for efficient retrieval of setup data.

-   **Low Data Volume:** The `xla_entity_id_mappings` table is a setup table with a relatively small number of rows compared to transactional tables, ensuring fast query execution.
-   **Direct Table Access:** The report directly accesses the core definition tables within Oracle SLA, minimizing complex joins to transactional data.

### FAQ

**1. What is the main purpose of `xla_entity_id_mappings`?**
   Its main purpose is to define the technical blueprint for how Oracle's Subledger Accounting (SLA) module links its generic `source_id_int_N` columns (which contain primary keys from subledger transactions) to the actual, specific primary key columns in the original subledger tables. This mapping is crucial for tracing transactions through SLA.

**2. How does this report help when creating custom GL Account Analysis reports?**
   When you want to drill down from a GL account balance to the original subledger transaction (e.g., an AP invoice number), you need to join through SLA. This report tells you precisely *which* columns in `xla_distribution_links` or `xla_transaction_entities` map to the primary keys of your desired subledger tables, providing the exact join conditions needed for your custom queries.

**3. Is it possible for different subledgers to use the same `source_id_int_N` column for different purposes?**
   Yes. The meaning of `source_id_int_1` (or `2`, `3`, etc.) is dependent on the `application_id` and `entity_code`. This is precisely why `xla_entity_id_mappings` exists – to provide this context-sensitive mapping. For example, `source_id_int_1` might map to `AP_INVOICE_ID` for Payables transactions but to `CUSTOMER_TRX_ID` for Receivables transactions.


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

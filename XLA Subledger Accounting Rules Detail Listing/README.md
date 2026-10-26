---
layout: default
last_modified_at: 2026-10-26
title: 'XLA Subledger Accounting Rules Detail Listing | Oracle EBS SQL Report'
description: 'Lists the complete Subledger Accounting rule setup in one flat grid, combining the seven separate queries of the Oracle standard XLASARDLR Subledger…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Subledger Accounting, Enginatics, R12 only, XLA, Subledger, Accounting, Rules, xla_descriptions_fvl, xla_desc_priorities, xla_acctg_method_rules_fvl'
permalink: /XLA%20Subledger%20Accounting%20Rules%20Detail%20Listing/
report_name: 'XLA Subledger Accounting Rules Detail Listing'
report_web_name: xla-subledger-accounting-rules-detail-listing
module: 'Subledger Accounting'
module_url: /modules/subledger-accounting/
---

# XLA Subledger Accounting Rules Detail Listing – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/xla-subledger-accounting-rules-detail-listing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing).
**Oracle EBS module:** [Subledger Accounting](/modules/subledger-accounting/ "Oracle EBS Subledger Accounting reports") · [all Subledger Accounting reports](/modules/subledger-accounting/)  

## Overview
Lists the complete Subledger Accounting rule setup in one flat grid, combining the seven separate queries of the Oracle standard XLASARDLR Subledger Accounting Rules Detail Listing BI Publisher report.

There is one row per journal line type and account derivation rule priority, so the accounting method, application accounting definition, event class and type, journal line definition, journal line type, segment, derivation rule, its priority, condition and derived value all sit on the same row and can be filtered and pivoted directly.

Journal line type and account derivation rule conditions are rendered as readable text up to 8000 characters. Header and line descriptions are shown by name, with their priorities, conditions and detail aggregated into a single cell.

The Oracle report requires one application and one accounting method per run. Here every parameter is optional and accepts multiple values, so leaving them blank lists the whole instance.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Application, Accounting Method Owner, Accounting Method, Event Class, Event Type, AMB Context

## Oracle EBS Tables Used
[xla_descriptions_fvl](https://www.enginatics.com/library/?pg=1&find=xla_descriptions_fvl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing), [xla_desc_priorities](https://www.enginatics.com/library/?pg=1&find=xla_desc_priorities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing), [xla_acctg_method_rules_fvl](https://www.enginatics.com/library/?pg=1&find=xla_acctg_method_rules_fvl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing), [xla_acctg_methods_fvl](https://www.enginatics.com/library/?pg=1&find=xla_acctg_methods_fvl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing), [xla_product_rules_fvl](https://www.enginatics.com/library/?pg=1&find=xla_product_rules_fvl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing), [xla_aad_line_defn_assgns](https://www.enginatics.com/library/?pg=1&find=xla_aad_line_defn_assgns&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing), [xla_line_definitions_vl](https://www.enginatics.com/library/?pg=1&find=xla_line_definitions_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing), [xla_prod_header_desc_fvl](https://www.enginatics.com/library/?pg=1&find=xla_prod_header_desc_fvl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing), [xla_event_classes_fvl](https://www.enginatics.com/library/?pg=1&find=xla_event_classes_fvl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing), [xla_event_types_vl](https://www.enginatics.com/library/?pg=1&find=xla_event_types_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing), [xla_line_defn_jlt_assgns](https://www.enginatics.com/library/?pg=1&find=xla_line_defn_jlt_assgns&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing), [xla_acct_line_types_fvl](https://www.enginatics.com/library/?pg=1&find=xla_acct_line_types_fvl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing), [xla_line_defn_adr_assgns_f_v](https://www.enginatics.com/library/?pg=1&find=xla_line_defn_adr_assgns_f_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing), [xla_sources_vl](https://www.enginatics.com/library/?pg=1&find=xla_sources_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing), [xla_mapping_sets_vl](https://www.enginatics.com/library/?pg=1&find=xla_mapping_sets_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing), [xla_seg_rules_fvl](https://www.enginatics.com/library/?pg=1&find=xla_seg_rules_fvl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing), [fnd_flex_values_vl](https://www.enginatics.com/library/?pg=1&find=fnd_flex_values_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing), [xla_seg_rule_details](https://www.enginatics.com/library/?pg=1&find=xla_seg_rule_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing)

## Related Reports
[AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/XLA%20Subledger%20Accounting%20Rules%20Detail%20Listing/XLA%20Subledger%20Accounting%20Rules%20Detail%20Listing.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [XLA Subledger Accounting Rules Detail Listing 24-Aug-2026 235725.xlsx](https://www.enginatics.com/example/xla-subledger-accounting-rules-detail-listing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing) |
| Blitz Report™ XML Import | [XLA_Subledger_Accounting_Rules_Detail_Listing.xml](https://www.enginatics.com/xml/xla-subledger-accounting-rules-detail-listing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing) |
| SQL Source | [XLA Subledger Accounting Rules Detail Listing.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/XLA%20Subledger%20Accounting%20Rules%20Detail%20Listing/XLA%20Subledger%20Accounting%20Rules%20Detail%20Listing.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/xla-subledger-accounting-rules-detail-listing/](https://www.enginatics.com/reports/xla-subledger-accounting-rules-detail-listing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing) |

## Case Study & Technical Analysis: XLA Subledger Accounting Rules Detail Listing

### Executive Summary
This report lists the complete Subledger Accounting (SLA) rule setup of an Oracle E-Business Suite instance in one flat grid. It combines the seven separate queries of the Oracle standard XLASARDLR Subledger Accounting Rules Detail Listing report, so that the accounting method, application accounting definition, event class and type, journal line definition, journal line type, segment and account derivation rule sit on the same row. Accounting analysts and finance systems teams use it to document, review and compare SLA rules across applications. It is an R12 report run through Blitz Report™.

### Business Challenge
*   **Rule documentation:** SLA rules are spread across many forms and reports, and a review needs them in one document.
*   **Account derivation review:** Each journal line segment is derived by an ordered set of rules and conditions, which must be checked for correctness before an accounting change.
*   **Cross-application comparison:** Rules for different applications and accounting methods must be compared with the same columns.
*   **Instance-wide audit:** Auditors need the full setup of an instance, not one application at a time.

### The Solution
*   Returns one row for each journal line type and account derivation rule priority, so that the rule can be filtered and pivoted directly.
*   Shows the accounting method and its dates, the application accounting definition and its compile status, and the event class and type.
*   Presents the journal line definition, the journal line type and its accounting class, balance type, natural side, transfer mode and business flow settings.
*   Renders the conditions of journal line types and account derivation rules as readable text, and shows the header and line descriptions by name with their priorities and details.

### Technical Architecture (High Level)
#### Primary Tables
*   `XLA_ACCTG_METHOD_RULES_FVL` and `XLA_ACCTG_METHODS_FVL`: the accounting method rules, with their effective dates, and the accounting method definitions.
*   `XLA_PRODUCT_RULES_FVL`: the application accounting definitions, with their compile status and enabled flag.
*   `XLA_AAD_LINE_DEFN_ASSGNS`: the assignments of journal line definitions to an application accounting definition.
*   `XLA_LINE_DEFINITIONS_VL`: the journal line definitions, with their enabled and budgetary control settings.
*   `XLA_PROD_HEADER_DESC_FVL`: the header description assigned to an application accounting definition.
*   `XLA_EVENT_CLASSES_FVL` and `XLA_EVENT_TYPES_VL`: the event classes and event types.
*   `XLA_LINE_DEFN_JLT_ASSGNS`: the assignments of journal line types to a journal line definition, with their active flag.
*   `XLA_ACCT_LINE_TYPES_FVL`: the journal line types, with accounting class, balance type and transfer settings.
*   `XLA_DESCRIPTIONS_FVL` and `XLA_DESC_PRIORITIES`: the descriptions and their priorities, used for header and line descriptions.
*   `XLA_LINE_DEFN_ADR_ASSGNS_F_V`, `XLA_SEG_RULES_FVL`, `XLA_SEG_RULE_DETAILS`, `XLA_SOURCES_VL`, `XLA_MAPPING_SETS_VL` and `FND_FLEX_VALUES_VL`: the account derivation rule assignments, rule details, sources, mapping sets and flexfield values.

#### Logical Relationships
1.  Each accounting method rule is joined to its accounting method and to its application accounting definition, restricted to rules active on the current date.
2.  The application accounting definition is joined to its journal line definition assignments, and each assignment to its enabled line definition and its event class and type.
3.  Each journal line definition is joined to its journal line type assignments, which are restricted to active assignments, and to the journal line type definitions.
4.  Each row is joined to the aggregated header description and to the aggregated line description, which hold the priorities, conditions and details of each description in one cell.
5.  Each journal line type is joined to its account derivation rule assignments and the rule details, values and conditions.
6.  Results are ordered by application, accounting method, event, journal line type, segment and derivation priority.

### Parameters & Filtering
*   **Application:** restricts the rules to one Oracle application.
*   **Accounting Method Owner**, **Accounting Method:** restrict the rules to one accounting method and its owner.
*   **Event Class** and **Event Type:** restrict the rules to one event class or event type.
*   **AMB Context:** restricts the rules to one accounting method builder context.
### Performance & Optimization
*   The description detail is an aggregated subquery joined on description keys, so each description is built once.
*   Conditions are rendered by a condition display function up to 4,000 characters, and a second call extends the text only when the first result is exactly 4,000 characters long.
*   The derivation rule details sit in their own derived table, joined to the assignments.

### FAQ
**Q: How can I see every account derivation rule for one application?**
A: Enter the application in the Application parameter, and the report returns one row for each journal line type segment with its derivation rule, priority, condition and derived value.

**Q: How long can a rule condition be in the output?**
A: Journal line type and account derivation rule conditions are rendered as readable text up to 8,000 characters, in the same column.

**Q: Does the report run for the whole instance at once?**
A: Yes, leaving every parameter blank lists the whole instance, whereas the Oracle standard report needs one application and one accounting method.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-accounting-rules-detail-listing)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

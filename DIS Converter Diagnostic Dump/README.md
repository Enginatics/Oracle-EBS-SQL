---
layout: default
last_modified_at: 2026-10-26
title: 'DIS Converter Diagnostic Dump | Oracle EBS SQL Report'
description: 'Diagnostic dump of all metadata and flattened staging data needed to reproduce the xxenxdo Discoverer-to-Blitz conversion logic offline. Outputs a single…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Discoverer, Enginatics, DIS, Converter, Diagnostic, Dump, eul5_qpp_stats, eul5_documents, xxen_discoverer_workbook_xmls'
permalink: /DIS%20Converter%20Diagnostic%20Dump/
report_name: 'DIS Converter Diagnostic Dump'
report_web_name: dis-converter-diagnostic-dump
module: 'Discoverer'
module_url: /modules/discoverer/
---

# DIS Converter Diagnostic Dump – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-converter-diagnostic-dump/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump).
**Oracle EBS module:** [Discoverer](/modules/discoverer/ "Oracle EBS Discoverer reports") · [all Discoverer reports](/modules/discoverer/)  

## Overview
Diagnostic dump of all metadata and flattened staging data needed to reproduce the xxen_xdo Discoverer-to-Blitz conversion logic offline.

Outputs a single result set with rows discriminated by the data_type column. Each row populates only the columns relevant to its data_type; all others are null. The dump is used by a Python parser to investigate why workbook or worksheets in discoverer eex files are not converted into Blitz templates or reports

Data types emitted: OBJECT_USE_KEY (one per object_use_key in scope, with link to existing Blitz report if imported), WORKBOOK_LINK (object_use_key to doc_id/sheet_name/qs_id link), EUL_OBJ (eul5_objs metadata per folder, with dis_folder_sql2 for COBJ/CUO), QPP_STAT (eul5_qpp_stats per qs_id with join key_ids), KEY_CONS (eul5_key_cons rows for referenced keys), EXPRESSION (eul5_expressions rows with formula1 CLOB), STAGING_WORKBOOK (xxen_discoverer_workbooks rows), STAGING_SHEET (xxen_discoverer_sheets rows), STAGING_PIVOT (xxen_discoverer_pivot_fields rows), ITEM_SQL (per-item SQL via dis_formula_sql / xml_expression_to_sql), JOIN_PREDICATE (per-join SQL via dis_formula_sql), FROM_FRAGMENT (per-folder FROM-clause entry).

Filter parameters: End User Layer (required), Object Use Key (optional, restrict to specific OUKs), Include Imported (default Yes - include OUKs already converted to Blitz reports).

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
End User Layer, Object Use Key, Include Imported

## Oracle EBS Tables Used
[eul5_qpp_stats](https://www.enginatics.com/library/?pg=1&find=eul5_qpp_stats&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump), [eul5_documents](https://www.enginatics.com/library/?pg=1&find=eul5_documents&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump), [xxen_discoverer_workbook_xmls](https://www.enginatics.com/library/?pg=1&find=xxen_discoverer_workbook_xmls&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump), [eul5_key_cons](https://www.enginatics.com/library/?pg=1&find=eul5_key_cons&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump), [xxen_discoverer_workbooks](https://www.enginatics.com/library/?pg=1&find=xxen_discoverer_workbooks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump), [xxen_discoverer_sheets](https://www.enginatics.com/library/?pg=1&find=xxen_discoverer_sheets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump), [eul5_expressions](https://www.enginatics.com/library/?pg=1&find=eul5_expressions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump), [xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump), [eul5_objs](https://www.enginatics.com/library/?pg=1&find=eul5_objs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump), [xxen_discoverer_pivot_fields](https://www.enginatics.com/library/?pg=1&find=xxen_discoverer_pivot_fields&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump), [xxen_discoverer_workbooks_v](https://www.enginatics.com/library/?pg=1&find=xxen_discoverer_workbooks_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump)

## Related Reports
[DIS Workbook Import Validation](/DIS%20Workbook%20Import%20Validation/ "DIS Workbook Import Validation Oracle EBS SQL Report"), [DIS Workbook Conversion Selection](/DIS%20Workbook%20Conversion%20Selection/ "DIS Workbook Conversion Selection Oracle EBS SQL Report"), [DIS End User Layers](/DIS%20End%20User%20Layers/ "DIS End User Layers Oracle EBS SQL Report"), [DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/ "DIS Workbooks, Folders, Items and LOVs Oracle EBS SQL Report"), [DIS Worksheet SQLs](/DIS%20Worksheet%20SQLs/ "DIS Worksheet SQLs Oracle EBS SQL Report"), [DIS Discoverer and Blitz Report Users](/DIS%20Discoverer%20and%20Blitz%20Report%20Users/ "DIS Discoverer and Blitz Report Users Oracle EBS SQL Report"), [DIS Access Privileges](/DIS%20Access%20Privileges/ "DIS Access Privileges Oracle EBS SQL Report"), [DIS Worksheet Execution History](/DIS%20Worksheet%20Execution%20History/ "DIS Worksheet Execution History Oracle EBS SQL Report"), [DIS Folders, Business Areas, Items and LOVs](/DIS%20Folders-%20Business%20Areas-%20Items%20and%20LOVs/ "DIS Folders, Business Areas, Items and LOVs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Converter%20Diagnostic%20Dump/DIS%20Converter%20Diagnostic%20Dump.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/dis-converter-diagnostic-dump/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump) |
| Blitz Report™ XML Import | [DIS_Converter_Diagnostic_Dump.xml](https://www.enginatics.com/xml/dis-converter-diagnostic-dump/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump) |
| SQL Source | [DIS Converter Diagnostic Dump.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Converter%20Diagnostic%20Dump/DIS%20Converter%20Diagnostic%20Dump.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dis-converter-diagnostic-dump/](https://www.enginatics.com/reports/dis-converter-diagnostic-dump/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump) |

## Case Study & Technical Analysis: DIS Converter Diagnostic Dump

### Executive Summary
The DIS Converter Diagnostic Dump is a diagnostic extract for the Oracle Discoverer module. It returns, in one result set, the Discoverer End User Layer (EUL) metadata and the staged workbook data needed to reproduce offline the logic that converts Discoverer workbooks into Blitz templates. Each row carries a data type that identifies what it represents, and only the columns relevant to that type are populated. Conversion engineers and DBAs use it to find out why a workbook or worksheet in a Discoverer export is not converted into a Blitz template or report. The dump is consumed by a Python parser.

### Business Challenge
*   **Silent conversion gaps:** A Discoverer workbook can fail to convert without an obvious error, so the cause must be traced through the metadata that defines its folders, joins and expressions.
*   **Scattered metadata:** The definition of a single Discoverer report is spread across the EUL object, query, key and expression tables and the staging tables, which is hard to inspect in the database.
*   **Reproducibility offline:** Conversion logic must be reproduced without access to the live Discoverer environment, which requires a complete snapshot of the relevant rows.
*   **Existing imports:** Users need to see whether an object use key was already imported.

### The Solution
*   **Scoped snapshot:** Only the End User Layer and optional object use keys are included.
*   **Latest query statistics:** For each document, sheet and owner, the most recent query statistics row is selected, so the dump reflects the current definition.
*   **Import status:** Each object use key is compared with existing Blitz reports whose description carries its object IDs and EUL name, and is marked IMPORTED or NEW.
*   **Typed output:** Metadata, staging and generated SQL fragments are emitted as typed rows, so one parser can process the whole dump.

### Technical Architecture (High Level)
#### Primary Tables
*   `EUL5_QPP_STATS`: query statistics for each Discoverer worksheet query, including the join key identifiers.
*   `EUL5_DOCUMENTS`: Discoverer documents, used to map a document name and owner to a document identifier.
*   `XXEN_DISCOVERER_WORKBOOK_XMLS`: the stored workbook XML for each document in the EUL.
*   `XXEN_DISCOVERER_WORKBOOKS` and `XXEN_DISCOVERER_WORKBOOKS_V`: the staged workbook items and their derived SQL and expression text.
*   `XXEN_DISCOVERER_SHEETS`: the staged worksheet definitions, including display sequence and sort order.
*   `XXEN_DISCOVERER_PIVOT_FIELDS`: the staged pivot field definitions for each sheet.
*   `EUL5_OBJS`: EUL object definitions, such as folders, items and their external tables.
*   `EUL5_KEY_CONS`: key constraints that define joins between objects.
*   `EUL5_EXPRESSIONS`: calculated expressions and join predicates, with their formula text.
*   `XXEN_REPORTS_V`: existing Blitz reports, matched by their description to detect prior imports.

#### Logical Relationships
1. The `SCOPE` block selects the latest query statistics row for each document name, sheet and owner, and joins it to `EUL5_DOCUMENTS` and to `XXEN_DISCOVERER_WORKBOOK_XMLS`.
2. Object use keys are split into object IDs, and join key IDs are read from the query statistics and then resolved through `EUL5_KEY_CONS` to the objects at each end of the join.
3. Referenced objects are added from the staged workbook and sheet reference keys, and all object IDs are combined into one set.
4. `EUL5_OBJS` returns the object definitions for that set, and `EUL5_EXPRESSIONS` returns the expressions linked to the join keys or to the objects.
5. The final `UNION ALL` emits OBJECT_USE_KEY, WORKBOOK_LINK, EUL_OBJ, QPP_STAT, KEY_CONS, EXPRESSION, STAGING_WORKBOOK, STAGING_SHEET, STAGING_PIVOT, ITEM_SQL, JOIN_PREDICATE and FROM_FRAGMENT rows, ordered by data type and identifiers.

### Parameters & Filtering
*   **End User Layer:** The required EUL owner. It is substituted into every EUL table reference and into the workbook filters.
*   **Object Use Key:** Optionally restricts the dump to specific object use keys. When empty, all keys in the EUL are in scope.
*   **Include Imported:** When Yes, object use keys that already have a Blitz report are included, with the status IMPORTED and the report identifier and name. When No, they are excluded from the scope.

### Performance & Optimization
*   The scope subquery is materialized with the `materialize` hint, because it is referenced by many of the later blocks.
*   The latest-statistics selection uses analytic `max` and `keep (dense_rank last)` expressions over partitions by document, sheet and owner, which avoids a separate self-join.
*   Comma-separated lists are split with `regexp_substr` against a row generator table function.

### FAQ
**Q: Why is my Discoverer workbook not converted into a Blitz report?**
A: Run the dump for the End User Layer and object use key of the workbook, then review the WORKBOOK_LINK, STAGING_SHEET and EXPRESSION rows to see which definitions are present.

**Q: How do I check whether a Discoverer object use key is already imported?**
A: Each OBJECT_USE_KEY row shows the status IMPORTED or NEW, with the Blitz report identifier and name when a matching report exists.

**Q: Which tables does the dump read to reproduce the join SQL?**
A: It reads `EUL5_QPP_STATS`, `EUL5_KEY_CONS` and `EUL5_EXPRESSIONS`, and emits the predicates as JOIN_PREDICATE rows.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-converter-diagnostic-dump)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

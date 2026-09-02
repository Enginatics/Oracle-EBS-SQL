---
layout: default
title: 'DIS Converter Diagnostic Dump | Oracle EBS SQL Report'
description: 'Diagnostic dump of all metadata and flattened staging data needed to reproduce the xxenxdo Discoverer-to-Blitz conversion logic offline. Outputs a single…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DIS, Converter, Diagnostic, Dump, eul5_qpp_stats, eul5_documents, xxen_discoverer_workbook_xmls'
permalink: /DIS%20Converter%20Diagnostic%20Dump/
---

# DIS Converter Diagnostic Dump – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-converter-diagnostic-dump/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Diagnostic dump of all metadata and flattened staging data needed to reproduce the xxen_xdo Discoverer-to-Blitz conversion logic offline.

Outputs a single result set with rows discriminated by the data_type column. Each row populates only the columns relevant to its data_type; all others are null. The dump is used by a Python parser to investigate why workbook or worksheets in discoverer eex files are not converted into Blitz templates or reports

Data types emitted: OBJECT_USE_KEY (one per object_use_key in scope, with link to existing Blitz report if imported), WORKBOOK_LINK (object_use_key to doc_id/sheet_name/qs_id link), EUL_OBJ (eul5_objs metadata per folder, with dis_folder_sql2 for COBJ/CUO), QPP_STAT (eul5_qpp_stats per qs_id with join key_ids), KEY_CONS (eul5_key_cons rows for referenced keys), EXPRESSION (eul5_expressions rows with formula1 CLOB), STAGING_WORKBOOK (xxen_discoverer_workbooks rows), STAGING_SHEET (xxen_discoverer_sheets rows), STAGING_PIVOT (xxen_discoverer_pivot_fields rows), ITEM_SQL (per-item SQL via dis_formula_sql / xml_expression_to_sql), JOIN_PREDICATE (per-join SQL via dis_formula_sql), FROM_FRAGMENT (per-folder FROM-clause entry).

Filter parameters: End User Layer (required), Object Use Key (optional, restrict to specific OUKs), Include Imported (default Yes - include OUKs already converted to Blitz reports).

## Report Parameters
End User Layer, Object Use Key, Include Imported

## Oracle EBS Tables Used
[eul5_qpp_stats](https://www.enginatics.com/library/?pg=1&find=eul5_qpp_stats), [eul5_documents](https://www.enginatics.com/library/?pg=1&find=eul5_documents), [xxen_discoverer_workbook_xmls](https://www.enginatics.com/library/?pg=1&find=xxen_discoverer_workbook_xmls), [scope](https://www.enginatics.com/library/?pg=1&find=scope), [table](https://www.enginatics.com/library/?pg=1&find=table), [key_ids_per_ouk](https://www.enginatics.com/library/?pg=1&find=key_ids_per_ouk), [eul5_key_cons](https://www.enginatics.com/library/?pg=1&find=eul5_key_cons), [xxen_discoverer_workbooks](https://www.enginatics.com/library/?pg=1&find=xxen_discoverer_workbooks), [xxen_discoverer_sheets](https://www.enginatics.com/library/?pg=1&find=xxen_discoverer_sheets), [obj_from_ouk](https://www.enginatics.com/library/?pg=1&find=obj_from_ouk), [obj_from_joins](https://www.enginatics.com/library/?pg=1&find=obj_from_joins), [obj_from_ref](https://www.enginatics.com/library/?pg=1&find=obj_from_ref), [eul5_expressions](https://www.enginatics.com/library/?pg=1&find=eul5_expressions), [key_ids_all](https://www.enginatics.com/library/?pg=1&find=key_ids_all), [all_obj_ids](https://www.enginatics.com/library/?pg=1&find=all_obj_ids), [scope_ouk](https://www.enginatics.com/library/?pg=1&find=scope_ouk), [xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v), [eul5_objs](https://www.enginatics.com/library/?pg=1&find=eul5_objs)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/dis-converter-diagnostic-dump/) |
| Blitz Report™ XML Import | [DIS_Converter_Diagnostic_Dump.xml](https://www.enginatics.com/xml/dis-converter-diagnostic-dump/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dis-converter-diagnostic-dump/](https://www.enginatics.com/reports/dis-converter-diagnostic-dump/) |



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

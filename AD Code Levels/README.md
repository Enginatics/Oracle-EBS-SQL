---
layout: default
last_modified_at: 2026-10-16
title: 'AD Code Levels | Oracle EBS SQL Report'
description: 'Code level and baseline of each Oracle EBS product and product family, as maintained by the patching utilities in ADTRACKABLEENTITIES. Patch readme files…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Applications DBA, Enginatics, R12 only, Code, Levels, ad_trackable_entities'
permalink: /AD%20Code%20Levels/
report_name: 'AD Code Levels'
report_web_name: ad-code-levels
module: 'Applications DBA'
module_url: /modules/applications-dba/
---

# AD Code Levels – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ad-code-levels/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-code-levels) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-code-levels).
**Oracle EBS module:** [Applications DBA](/modules/applications-dba/ "Oracle EBS Applications DBA reports") · [all Applications DBA reports](/modules/applications-dba/)  

## Overview
Code level and baseline of each Oracle EBS product and product family, as maintained by the patching utilities in AD_TRACKABLE_ENTITIES.

Patch readme files and My Oracle Support notes state prerequisites as code levels, for example R12.AD.C.Delta.15 for AD code level C.15.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-code-levels) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Entity Type, Abbreviation

## Oracle EBS Tables Used
[ad_trackable_entities](https://www.enginatics.com/library/?pg=1&find=ad_trackable_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-code-levels)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-code-levels), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-code-levels)

## Related Reports
[INV Item Attribute Master/Child Conflicts](/INV%20Item%20Attribute%20Master-Child%20Conflicts/ "INV Item Attribute Master/Child Conflicts Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AD%20Code%20Levels/AD%20Code%20Levels.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-code-levels) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AD Code Levels 12-Oct-2026 061523.xlsx](https://www.enginatics.com/example/ad-code-levels/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-code-levels) |
| Blitz Report™ XML Import | [AD_Code_Levels.xml](https://www.enginatics.com/xml/ad-code-levels/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-code-levels) |
| SQL Source | [AD Code Levels.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AD%20Code%20Levels/AD%20Code%20Levels.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ad-code-levels/](https://www.enginatics.com/reports/ad-code-levels/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-code-levels) |

## Case Study & Technical Analysis: AD Code Levels

### Executive Summary
The AD Code Levels report lists the code level and baseline of every Oracle E-Business Suite product and product family as recorded by the patching utilities in `AD_TRACKABLE_ENTITIES`. It is written for Applications DBAs who must confirm which AD code level an R12 instance is actually running before a patch is applied, and for upgrade and audit teams who need a dated, reproducible record of the installed patch baseline. Patch readme files and My Oracle Support notes express prerequisites as code levels, for example R12.AD.C.Delta.15 for AD code level C.15, so the report turns a written prerequisite into a direct comparison against the database.

### Business Challenge
*   **Patch prerequisite verification:** Patch readmes state required code levels, and the DBA needs to confirm each one before the patch run rather than discovering a mismatch part way through.
*   **Inconsistent notation across products:** Code levels are written in a release-product-letter-delta form, which is easy to misread when checked by hand against several products.
*   **Baseline evidence for upgrades:** Cutover and upgrade projects need a reproducible listing of each product's code level and baseline at a point in time.
*   **Support escalation:** When Oracle Support asks which AD level is installed, the answer should come from the instance itself rather than from memory of the last patch session.

### The Solution
*   **Single register read:** The report reads one table, `AD_TRACKABLE_ENTITIES`, which is the register the patching utilities maintain for each trackable entity.
*   **Clear identification:** Each row returns the entity abbreviation, its full name and its type, so a product family can be identified without knowing internal identifiers.
*   **Code level as stored:** The `codelevel` value is returned as `code_level`, so it can be compared directly with the text of a patch prerequisite.
*   **Baseline flag included:** The `baseline` column is returned alongside the code level, so the listing shows both the current level and the baseline reference for each entity.
*   **Spreadsheet comparison:** Running the report in Excel through Blitz Report lets the DBA filter by type or abbreviation and compare several environments in one workbook.

### Technical Architecture (High Level)
#### Primary Tables
*   `AD_TRACKABLE_ENTITIES`: the patching register of trackable products and product families, holding the abbreviation, name, type, code level and baseline of each entity.

#### Logical Relationships
1. The report selects directly from `AD_TRACKABLE_ENTITIES` under an alias `ate`, with no join to any other table.
2. The `where 1=1` clause is a placeholder, so the SQL text applies no row restriction of its own.
3. The result is ordered by `type` and then by `abbreviation`, which gives a stable order for comparison across instances.

### Parameters & Filtering
*   **Entity Type:** Intended to restrict the listing to one class of trackable entity, such as products or product families. The SQL text in the library does not reference this parameter, so it is not coded as a predicate in the query shown.
*   **Abbreviation:** Intended to narrow the output to one entity, for example the single row for the Applications DBA code level. Like Entity Type, the parameter does not appear in the query text.

Because neither parameter is bound in the SQL, the report as written returns the complete register of trackable entities. Users who need a single product should filter the output in Excel by the `abbreviation` column.

### Performance & Optimization
*   **Single-table access:** The query touches one table with no joins, subqueries or analytic functions, so its cost is one table read followed by a sort.
*   **Register-sized data:** `AD_TRACKABLE_ENTITIES` holds the patching utilities' register of entities rather than transactional history, so the full listing is compact.
*   **Ordering only:** The only non-trivial work is the `order by` on `type` and `abbreviation`, which is applied to the complete result set.

### FAQ
**Q: How do I find the AD code level of my Oracle EBS instance?**
A: Run AD Code Levels and read the `code_level` value on the row whose abbreviation identifies the product, such as the Applications DBA entry.

**Q: How should a code level such as R12.AD.C.Delta.15 be read?**
A: The Oracle EBS documentation uses this notation for prerequisites, and the code level for that entry is AD code level C.15, as stated in the report description. The report returns the value exactly as it is stored.

**Q: Can this report confirm that a patch prerequisite is met?**
A: The report lists the stored values for each entity, and the comparison with the prerequisite in a patch readme is made by the user against the returned `code_level` column.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-code-levels)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-code-levels)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-code-levels)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-code-levels)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-code-levels)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-code-levels)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-code-levels)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

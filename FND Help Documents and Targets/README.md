---
layout: default
last_modified_at: 2026-10-19
title: 'FND Help Documents and Targets | Oracle EBS SQL Report'
description: 'Oracle EBS Application Object Library SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Help, Documents, Targets, fnd_application_vl, fnd_help_documents, fnd_lobs'
permalink: /FND%20Help%20Documents%20and%20Targets/
report_name: 'FND Help Documents and Targets'
report_web_name: fnd-help-documents-and-targets
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Help Documents and Targets – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-help-documents-and-targets/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-help-documents-and-targets) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-help-documents-and-targets).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview


> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-help-documents-and-targets) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Application Name, Application Short Name, Show Targets, Show File Data, Cutomization Level from, Language Code

## Oracle EBS Tables Used
[fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-help-documents-and-targets), [fnd_help_documents](https://www.enginatics.com/library/?pg=1&find=fnd_help_documents&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-help-documents-and-targets), [fnd_lobs](https://www.enginatics.com/library/?pg=1&find=fnd_lobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-help-documents-and-targets), [fnd_help_targets](https://www.enginatics.com/library/?pg=1&find=fnd_help_targets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-help-documents-and-targets)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-help-documents-and-targets)

## Related Reports
[FND Attached Documents (Operating Unit Secured)](/FND%20Attached%20Documents%20%28Operating%20Unit%20Secured%29/ "FND Attached Documents (Operating Unit Secured) Oracle EBS SQL Report"), [FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [GL Journals (Drilldown)](/GL%20Journals%20%28Drilldown%29/ "GL Journals (Drilldown) Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report"), [GL Journals (Drilldown) 11g](/GL%20Journals%20%28Drilldown%29%2011g/ "GL Journals (Drilldown) 11g Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Help%20Documents%20and%20Targets/FND%20Help%20Documents%20and%20Targets.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-help-documents-and-targets) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Help Documents and Targets 12-May-2020 185936.xlsx](https://www.enginatics.com/example/fnd-help-documents-and-targets/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-help-documents-and-targets) |
| Blitz Report™ XML Import | [FND_Help_Documents_and_Targets.xml](https://www.enginatics.com/xml/fnd-help-documents-and-targets/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-help-documents-and-targets) |
| SQL Source | [FND Help Documents and Targets.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Help%20Documents%20and%20Targets/FND%20Help%20Documents%20and%20Targets.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-help-documents-and-targets/](https://www.enginatics.com/reports/fnd-help-documents-and-targets/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-help-documents-and-targets) |

## Executive Summary
The **FND Help Documents and Targets** report lists the custom help files and targets registered in the Oracle EBS Help System.

## Business Challenge
*   **Training Support:** Verifying that custom help documents are properly linked to application screens.
*   **Content Management:** Reviewing the list of uploaded help files to identify obsolete content.

## The Solution
This Blitz Report lists the help configuration:
*   **Application:** The owning application.
*   **Target:** The link target (used to call help from a form).
*   **File Data:** Can optionally show the content of the help file.

## Technical Architecture
The report queries `FND_HELP_DOCUMENTS` and `FND_HELP_TARGETS`.

## Parameters & Filtering
*   **Application Name:** Filter by module.
*   **Show File Data:** Toggle to include the BLOB/CLOB content (use with caution).

## Performance & Optimization
*   **Large Data:** Avoid "Show File Data" unless you are looking for a specific document, as it can pull large amounts of text.

## FAQ
*   **Q: Is this commonly used?**
    *   A: Less so in modern R12 environments where UPK or external knowledge bases are preferred, but still relevant for legacy help customizations.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-help-documents-and-targets)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-help-documents-and-targets)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-help-documents-and-targets)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-help-documents-and-targets)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-help-documents-and-targets)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-help-documents-and-targets)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-help-documents-and-targets)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

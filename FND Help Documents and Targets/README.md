---
layout: default
title: 'FND Help Documents and Targets | Oracle EBS SQL Report'
description: ' – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Help, Documents, Targets, fnd_application_vl, fnd_help_documents, fnd_lobs'
permalink: /FND%20Help%20Documents%20and%20Targets/
---

# FND Help Documents and Targets – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-help-documents-and-targets/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
None

## Report Parameters
Application Name, Application Short Name, Show Targets, Show File Data, Cutomization Level from, Language Code

## Oracle EBS Tables Used
[fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_help_documents](https://www.enginatics.com/library/?pg=1&find=fnd_help_documents), [fnd_lobs](https://www.enginatics.com/library/?pg=1&find=fnd_lobs), [fnd_help_targets](https://www.enginatics.com/library/?pg=1&find=fnd_help_targets)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report"), [GL Journals (Drilldown)](/GL%20Journals%20%28Drilldown%29/ "GL Journals (Drilldown) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Help Documents and Targets 12-May-2020 185936.xlsx](https://www.enginatics.com/example/fnd-help-documents-and-targets/) |
| Blitz Report™ XML Import | [FND_Help_Documents_and_Targets.xml](https://www.enginatics.com/xml/fnd-help-documents-and-targets/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-help-documents-and-targets/](https://www.enginatics.com/reports/fnd-help-documents-and-targets/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics

---
layout: default
title: 'AD Applied Patches | Oracle EBS SQL Report'
description: 'AD applied patches, patch runs, included bugs, filenames and actions – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Applied, Patches, ad_comprising_patches, ad_bugs, ad_appl_tops'
permalink: /AD%20Applied%20Patches/
---

# AD Applied Patches – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ad-applied-patches/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
AD applied patches, patch runs, included bugs, filenames and actions

## Report Parameters
Display Level, Application Name, Application Short Name, Filename, Patch, Bug Number, Applied within Days, Applied Date from, Applied Date to, Show Executed Actions only, Show Successfuly Applied only

## Oracle EBS Tables Used
[ad_comprising_patches](https://www.enginatics.com/library/?pg=1&find=ad_comprising_patches), [ad_bugs](https://www.enginatics.com/library/?pg=1&find=ad_bugs), [ad_appl_tops](https://www.enginatics.com/library/?pg=1&find=ad_appl_tops), [ad_applied_patches](https://www.enginatics.com/library/?pg=1&find=ad_applied_patches), [ad_patch_drivers](https://www.enginatics.com/library/?pg=1&find=ad_patch_drivers), [ad_patch_runs](https://www.enginatics.com/library/?pg=1&find=ad_patch_runs), [ad_patch_run_bugs](https://www.enginatics.com/library/?pg=1&find=ad_patch_run_bugs), [ad_patch_run_bug_actions](https://www.enginatics.com/library/?pg=1&find=ad_patch_run_bug_actions), [ad_patch_common_actions](https://www.enginatics.com/library/?pg=1&find=ad_patch_common_actions), [ad_files](https://www.enginatics.com/library/?pg=1&find=ad_files), [ad_file_versions](https://www.enginatics.com/library/?pg=1&find=ad_file_versions), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[AD Applied Patches 11i](/AD%20Applied%20Patches%2011i/ "AD Applied Patches 11i Oracle EBS SQL Report"), [AD Applied Patches R12.2](/AD%20Applied%20Patches%20R12-2/ "AD Applied Patches R12.2 Oracle EBS SQL Report"), [FA Additions By Source](/FA%20Additions%20By%20Source/ "FA Additions By Source Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AD Applied Patches 11-Apr-2020 004347.xlsx](https://www.enginatics.com/example/ad-applied-patches/) |
| Blitz Report™ XML Import | [AD_Applied_Patches.xml](https://www.enginatics.com/xml/ad-applied-patches/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ad-applied-patches/](https://www.enginatics.com/reports/ad-applied-patches/) |

## AD Applied Patches Report

### Executive Summary
The AD Applied Patches report provides a comprehensive overview of all patches applied to the Oracle E-Business Suite environment. It offers detailed insights into patch history, including patch runs, associated bugs, and the specific file changes involved. This report is essential for maintaining a clear and auditable record of system updates, ensuring compliance, and simplifying patch management.

### Business Challenge
Tracking applied patches in Oracle EBS can be a complex and time-consuming task. Without a centralized and easily accessible report, organizations struggle with:
- **Lack of Visibility:** Difficulty in quickly identifying which patches have been applied, when they were applied, and what changes they introduced.
- **Compliance Risks:** Inability to provide auditors with a clear and accurate history of system updates, leading to potential compliance issues.
- **Manual Effort:** Spending significant time and resources manually gathering patch information from various sources, leading to inefficiencies and a higher risk of human error.
- **Troubleshooting Complexity:** Difficulty in correlating system issues with specific patch applications, making it harder to identify the root cause of problems.

### The Solution
The AD Applied Patches report, powered by Blitz Report, solves these challenges by providing a detailed and actionable view of patch history. The report offers:
- **Centralized Patch Information:** A single, consolidated view of all applied patches, including patch numbers, application dates, and associated bug numbers.
- **Detailed Patch Analysis:** In-depth information on each patch run, including the files that were changed and the actions that were executed.
- **Improved Auditability:** A clear and easily verifiable record of all system updates, ensuring that you can meet audit requirements with confidence.
- **Simplified Troubleshooting:** The ability to quickly identify which patches were applied around the time a system issue occurred, helping to accelerate the troubleshooting process.

### Technical Architecture (High Level)
The report leverages a set of core Oracle EBS tables to provide a comprehensive view of applied patches. The primary tables involved include:
- **ad_applied_patches:** The main table that stores information about applied patches.
- **ad_patch_runs:** Contains details about each patch run, including the start and end times.
- **ad_patch_run_bugs:** Links patch runs to the specific bugs that they address.
- **ad_files:** Provides information about the files that were changed by each patch.
- **fnd_application_vl:** Used to retrieve the full name of the application associated with each patch.

The report joins these tables to provide a holistic view of patch history, from the high-level patch information down to the individual file changes.

### Parameters & Filtering
The report includes a range of parameters that allow users to filter and customize the output to their specific needs. These parameters include:
- **Application Name:** Filter the report to show patches for a specific application.
- **Patch Number:** View the details of a specific patch.
- **Applied Date Range:** See all patches that were applied within a specific date range.
- **Bug Number:** Find the patch that addresses a specific bug.

These filtering options make it easy to find the exact information you need, without having to sift through irrelevant data.

### Performance & Optimization
The AD Applied Patches report is designed for optimal performance, ensuring that you can get the information you need quickly and efficiently. The report uses direct database extraction to bypass the performance-intensive XML parsing process, and it is indexed on date columns to ensure fast retrieval of data.

### FAQ
**Q: Can I use this report to see the patches applied to a specific application?**
A: Yes, the report includes an "Application Name" parameter that allows you to filter the output to show patches for a specific application.

**Q: Can I see the specific files that were changed by a patch?**
A: Yes, the report provides a detailed view of each patch run, including the specific files that were changed and the actions that were executed.

**Q: How can I use this report to troubleshoot a system issue?**
A: If you are experiencing a system issue, you can use the "Applied Date Range" parameter to see all patches that were applied around the time the issue started. This can help you to identify if a recent patch may be the cause of the problem.

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

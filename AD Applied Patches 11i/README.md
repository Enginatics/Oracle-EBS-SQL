---
layout: default
title: 'AD Applied Patches 11i | Oracle EBS SQL Report'
description: 'AD applied patches, patch runs, included bugs, filenames and actions. – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Applied, Patches, 11i, ad_comprising_patches, ad_bugs, ad_appl_tops'
permalink: /AD%20Applied%20Patches%2011i/
---

# AD Applied Patches 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ad-applied-patches-11i/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
AD applied patches, patch runs, included bugs, filenames and actions.

## Report Parameters
Display Level, Application Name, Application Short Name, Filename, Patch, Bug Number, Applied within Days, Applied Date from, Applied Date to, Show Executed Actions only, Show Executed Actions Only, Show Successfuly Applied only, Show Successfuly Applied Only

## Oracle EBS Tables Used
[ad_comprising_patches](https://www.enginatics.com/library/?pg=1&find=ad_comprising_patches), [ad_bugs](https://www.enginatics.com/library/?pg=1&find=ad_bugs), [ad_appl_tops](https://www.enginatics.com/library/?pg=1&find=ad_appl_tops), [ad_applied_patches](https://www.enginatics.com/library/?pg=1&find=ad_applied_patches), [ad_patch_drivers](https://www.enginatics.com/library/?pg=1&find=ad_patch_drivers), [ad_patch_runs](https://www.enginatics.com/library/?pg=1&find=ad_patch_runs), [ad_patch_run_bugs](https://www.enginatics.com/library/?pg=1&find=ad_patch_run_bugs), [ad_patch_run_bug_actions](https://www.enginatics.com/library/?pg=1&find=ad_patch_run_bug_actions), [ad_patch_common_actions](https://www.enginatics.com/library/?pg=1&find=ad_patch_common_actions), [ad_files](https://www.enginatics.com/library/?pg=1&find=ad_files), [ad_file_versions](https://www.enginatics.com/library/?pg=1&find=ad_file_versions), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[AD Applied Patches](/AD%20Applied%20Patches/ "AD Applied Patches Oracle EBS SQL Report"), [AD Applied Patches R12.2](/AD%20Applied%20Patches%20R12-2/ "AD Applied Patches R12.2 Oracle EBS SQL Report"), [FA Additions By Source](/FA%20Additions%20By%20Source/ "FA Additions By Source Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ad-applied-patches-11i/) |
| Blitz Report™ XML Import | [AD_Applied_Patches_11i.xml](https://www.enginatics.com/xml/ad-applied-patches-11i/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ad-applied-patches-11i/](https://www.enginatics.com/reports/ad-applied-patches-11i/) |

## AD Applied Patches 11i Report

### Executive Summary
The AD Applied Patches 11i report provides a comprehensive overview of all patches applied to Oracle E-Business Suite 11i environments. It delivers crucial insights into patch history, including patch runs, associated bugs, and specific file changes. This report is vital for maintaining a clear, auditable record of system updates, ensuring compliance, and streamlining patch management for legacy systems.

### Business Challenge
Tracking applied patches in Oracle EBS 11i presents unique challenges due to the system's age and the volume of patches accumulated over time. Without a centralized reporting tool, organizations face:
- **Poor Visibility:** Difficulty in quickly identifying which patches have been applied, their application dates, and the changes they introduced.
- **Compliance Risks:** Inability to provide auditors with a clear and accurate history of system updates, leading to potential compliance issues.
- **Manual Patch Tracking:** Significant time and resources are spent manually gathering patch information from various sources, leading to inefficiencies and a higher risk of human error.
- **Complex Troubleshooting:** Difficulty in correlating system issues with specific patch applications, making it harder to identify the root cause of problems in a mature environment.

### The Solution
The AD Applied Patches 11i report, powered by Blitz Report, addresses these challenges by offering a detailed and actionable view of patch history. The report provides:
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
The AD Applied Patches 11i report is designed for optimal performance, ensuring that you can get the information you need quickly and efficiently. The report uses direct database extraction to bypass the performance-intensive XML parsing process, and it is indexed on date columns to ensure fast retrieval of data.

### FAQ
**Q: Can I use this report to see the patches applied to a specific application in my 11i instance?**
A: Yes, the report includes an "Application Name" parameter that allows you to filter the output to show patches for a specific application.

**Q: Can I see the specific files that were changed by a patch?**
A: Yes, the report provides a detailed view of each patch run, including the specific files that were changed and the actions that were executed.

**Q: How can this report help with an 11i audit?**
A: This report provides a clear and easily verifiable record of all system updates, which is essential for meeting audit requirements for change management and system maintenance.

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

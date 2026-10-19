---
layout: default
last_modified_at: 2026-10-19
title: 'OKS Contract Termination Upload | Oracle EBS SQL Report'
description: 'Terminates service contracts (full termination), terminates individual contract lines and sublines (partial termination), and deletes lines from Entered…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, OKS, Contract, Termination, mtl_system_items_vl, csi_item_instances, csi_counters_tl'
permalink: /OKS%20Contract%20Termination%20Upload/
report_name: 'OKS Contract Termination Upload'
report_web_name: oks-contract-termination-upload
---

# OKS Contract Termination Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/oks-contract-termination-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload).

## Overview
Terminates service contracts (full termination), terminates individual contract lines and sublines (partial termination), and deletes lines from Entered contracts - the Terminate action of the Service Contracts Authoring form (okc_terminate_pub / okc_contract_pub).

Set Terminate Contract to Yes on any row of the contract for a full termination, Terminate Line to Yes to terminate that row's line or subline, or Delete Line to Yes to delete the line (Entered contracts only). Termination Date and Termination Reason are required for terminations.

A termination cannot be undone by this upload - statuses, credits, billing schedules and history are produced by the Oracle termination engine exactly as from the form.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Operating Unit, Contract Number, Contract Status, Line Status

## Oracle EBS Tables Used
[mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload), [csi_item_instances](https://www.enginatics.com/library/?pg=1&find=csi_item_instances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload), [csi_counters_tl](https://www.enginatics.com/library/?pg=1&find=csi_counters_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload), [okc_k_items](https://www.enginatics.com/library/?pg=1&find=okc_k_items&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload), [okc_k_headers_all_b](https://www.enginatics.com/library/?pg=1&find=okc_k_headers_all_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload), [okc_statuses_v](https://www.enginatics.com/library/?pg=1&find=okc_statuses_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload), [okc_k_lines_b](https://www.enginatics.com/library/?pg=1&find=okc_k_lines_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload), [okc_line_styles_tl](https://www.enginatics.com/library/?pg=1&find=okc_line_styles_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload)

## Related Reports
[OKS Service Contract Line Upload](/OKS%20Service%20Contract%20Line%20Upload/ "OKS Service Contract Line Upload Oracle EBS SQL Report"), [AR Transactions and Lines 11i](/AR%20Transactions%20and%20Lines%2011i/ "AR Transactions and Lines 11i Oracle EBS SQL Report"), [OKL Termination Quotes](/OKL%20Termination%20Quotes/ "OKL Termination Quotes Oracle EBS SQL Report"), [CSI Counter Readings](/CSI%20Counter%20Readings/ "CSI Counter Readings Oracle EBS SQL Report"), [CSI Customer Products Summary](/CSI%20Customer%20Products%20Summary/ "CSI Customer Products Summary Oracle EBS SQL Report"), [OKS Service Contracts Billing Schedule](/OKS%20Service%20Contracts%20Billing%20Schedule/ "OKS Service Contracts Billing Schedule Oracle EBS SQL Report"), [OKS Service Contracts Billing History](/OKS%20Service%20Contracts%20Billing%20History/ "OKS Service Contracts Billing History Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OKS%20Contract%20Termination%20Upload/OKS%20Contract%20Termination%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/oks-contract-termination-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload) |
| Blitz Report™ XML Import | [OKS_Contract_Termination_Upload.xml](https://www.enginatics.com/xml/oks-contract-termination-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload) |
| SQL Source | [OKS Contract Termination Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OKS%20Contract%20Termination%20Upload/OKS%20Contract%20Termination%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/oks-contract-termination-upload/](https://www.enginatics.com/reports/oks-contract-termination-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload) |

## Case Study & Technical Analysis: OKS Contract Termination Upload

### Executive Summary
The OKS Contract Termination Upload is a Blitz Report upload for terminating Oracle Service Contracts. It performs a full termination of a service contract, terminates an individual contract line or subline, or deletes a line from a contract that is still in the Entered status. The upload follows the Terminate action of the Service Contracts Authoring form, so the termination is processed by the same Oracle termination engine. Service contract administrators and renewals teams use it to close out many contracts or lines at the end of an agreement, after a customer cancels coverage, or when an installed base item is withdrawn. The workflow runs in Excel through Blitz Report.

### Business Challenge
*   **Contract close-out at scale:** Expired or cancelled service agreements must be terminated in bulk, and each termination must carry a date and a reason for audit.
*   **Partial terminations:** When one covered product is withdrawn, only its line or subline must be terminated, leaving the rest of the contract active.
*   **Irreversible actions:** A termination cannot be undone by the upload, so the rows must be reviewed carefully before they are applied.
*   **Consistency with the form:** Credits, billing schedules and statuses must be produced as they would be by the authoring form, not by direct table updates.

### The Solution
*   **Row-level actions:** Each row can request a full contract termination, a line or subline termination, or the deletion of a line on an Entered contract.
*   **Required termination data:** Termination date and termination reason are required for any termination.
*   **Engine-based processing:** The upload calls the Oracle service contract termination and contract publication APIs, so statuses, credits, billing schedules and history are produced by the engine.
*   **Scope control:** Only service contracts authored in the accessible operating units are listed, and only line styles that can be terminated or deleted are included.

### Technical Architecture (High Level)
#### Primary Tables
*   `OKC_K_HEADERS_ALL_B`: the contract header, with the contract number, modifier, status, start and end dates and the authoring organization.
*   `OKC_K_LINES_B`: the contract lines and sublines, with their line style, status, dates and negotiated amount.
*   `OKC_LINE_STYLES_TL`: the line type name for each line style.
*   `OKC_STATUSES_V`: the contract and line status meanings.
*   `OKC_K_ITEMS`: the item or object that each line covers.
*   `MTL_SYSTEM_ITEMS_VL`: the inventory item of a service or usage line.
*   `CSI_ITEM_INSTANCES`: the installed base instance of a customer product line.
*   `CSI_COUNTERS_TL`: the counter name of a counter line.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit of the contract.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units accessible to the current user.

#### Logical Relationships
1.  `OKC_K_HEADERS_ALL_B` is filtered to service contracts (the SCS code SERVICE) in the accessible authoring organizations, and joins to its operating unit and status.
2.  The header joins to `OKC_K_LINES_B` on the contract ID, restricted to the line styles that the termination can act on.
3.  Each line joins to its parent line through an outer join, so sublines show the parent line number.
4.  Each line joins to `OKC_LINE_STYLES_TL` for the line type name, and to `OKC_STATUSES_V` for the line status.
5.  The object of the line is resolved from `OKC_K_ITEMS` and, depending on its object type, from the inventory item, the installed base instance or the counter.

### Parameters & Filtering
*   **Upload Mode:** sets the download or the upload action.
*   **Operating Unit:** limits the contracts to one authoring organization.
*   **Contract Number:** selects one contract.
*   **Contract Status:** filters by the status of the contract header.
*   **Line Status:** filters by the status of the contract line.

### Performance & Optimization
*   The operating unit restriction is an `IN` subquery on `MO_GLOB_ORG_ACCESS_TMP`, which keeps the header read to the accessible organizations.
*   The item lookup is a correlated subquery that returns one object name per line using `ROWNUM`, so each line produces one row.
*   The parent line join is an outer join on the parent line ID, so top-level lines and sublines are read in one pass.
*   Only the line styles in the termination set are read, which limits the lines returned to those that the upload can act on.

### FAQ
**Q: Can a termination be reversed through this upload?**
A: No. The description states that a termination cannot be undone by this upload, and that statuses, credits and billing schedules are produced by the Oracle termination engine.

**Q: Which fields are needed to terminate a contract?**
A: The termination date and the termination reason are required for any termination.

**Q: Can a line be deleted instead of terminated?**
A: Yes, Delete Line removes the line, but only on contracts that are still in the Entered status.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-contract-termination-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

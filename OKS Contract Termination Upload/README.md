---
layout: default
title: 'OKS Contract Termination Upload | Oracle EBS SQL Report'
description: 'Terminates service contracts (full termination), terminates individual contract lines and sublines (partial termination), and deletes lines from Entered…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, OKS, Contract, Termination, mtl_system_items_vl, csi_item_instances, csi_counters_tl'
permalink: /OKS%20Contract%20Termination%20Upload/
---

# OKS Contract Termination Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/oks-contract-termination-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Terminates service contracts (full termination), terminates individual contract lines and sublines (partial termination), and deletes lines from Entered contracts - the Terminate action of the Service Contracts Authoring form (okc_terminate_pub / okc_contract_pub).

Set Terminate Contract to Yes on any row of the contract for a full termination, Terminate Line to Yes to terminate that row's line or subline, or Delete Line to Yes to delete the line (Entered contracts only). Termination Date and Termination Reason are required for terminations.

A termination cannot be undone by this upload - statuses, credits, billing schedules and history are produced by the Oracle termination engine exactly as from the form.

## Report Parameters
Upload Mode, Operating Unit, Contract Number, Contract Status, Line Status

## Oracle EBS Tables Used
[mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [csi_item_instances](https://www.enginatics.com/library/?pg=1&find=csi_item_instances), [csi_counters_tl](https://www.enginatics.com/library/?pg=1&find=csi_counters_tl), [okc_k_items](https://www.enginatics.com/library/?pg=1&find=okc_k_items), [okc_k_headers_all_b](https://www.enginatics.com/library/?pg=1&find=okc_k_headers_all_b), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [okc_statuses_v](https://www.enginatics.com/library/?pg=1&find=okc_statuses_v), [okc_k_lines_b](https://www.enginatics.com/library/?pg=1&find=okc_k_lines_b), [okc_line_styles_tl](https://www.enginatics.com/library/?pg=1&find=okc_line_styles_tl), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[OKS Service Contract Line Upload](/OKS%20Service%20Contract%20Line%20Upload/ "OKS Service Contract Line Upload Oracle EBS SQL Report"), [OKL Termination Quotes](/OKL%20Termination%20Quotes/ "OKL Termination Quotes Oracle EBS SQL Report"), [OKS Service Contracts Billing Schedule](/OKS%20Service%20Contracts%20Billing%20Schedule/ "OKS Service Contracts Billing Schedule Oracle EBS SQL Report"), [OKS Service Contracts Billing History](/OKS%20Service%20Contracts%20Billing%20History/ "OKS Service Contracts Billing History Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/oks-contract-termination-upload/) |
| Blitz Report™ XML Import | [OKS_Contract_Termination_Upload.xml](https://www.enginatics.com/xml/oks-contract-termination-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/oks-contract-termination-upload/](https://www.enginatics.com/reports/oks-contract-termination-upload/) |



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

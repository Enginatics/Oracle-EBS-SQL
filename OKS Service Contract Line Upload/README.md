---
layout: default
title: 'OKS Service Contract Line Upload | Oracle EBS SQL Report'
description: 'This upload maintains the lines of existing Oracle Service Contracts through the standard Service Contracts public APIs: it updates header and line level…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, OKS, Service, Contract, Line, hz_cust_acct_sites_all, hz_cust_accounts, okc_k_party_roles_b'
permalink: /OKS%20Service%20Contract%20Line%20Upload/
---

# OKS Service Contract Line Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/oks-service-contract-line-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
This upload maintains the lines of existing Oracle Service Contracts through the standard Service Contracts public APIs: it updates header and line level values, adds new service and usage lines, and adds covered product or counter sublines.

Each row is one contract line or subline. Rows identified by the Line Number column update that line; sublines use the parent.child format, for example 1.2 for the second covered product of service line 1. Rows without a Line Number create a new line: leave Parent Line Number empty and enter Line Type, Item and the line dates for a top line, or enter a Parent Line Number, the Covered Product and the covered dates for a subline. A subline can reference a top line created by an earlier row of the same file. Header level values repeat on every row of a contract and are applied once.

Usage lines need a Usage Type, and a Usage Period for all types except Negotiated per Period. Actual per Period and Actual by Quantity lines are invoiced in arrears, which the upload sets automatically, and their sublines need a Default Quantity and a Base Reading.

Prices are written as entered. Changing the negotiated amount or unit price does not reprice the line through the price list and does not regenerate an existing billing schedule, and lines cannot be removed by this upload.

Updates are validated by the Service Contracts APIs, so changes not allowed for the current contract or line status are rejected with the corresponding API message.

## Report Parameters
Upload Mode, Operating Unit, Contract Number, Contract Status, Line Status

## Oracle EBS Tables Used
[hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [okc_k_party_roles_b](https://www.enginatics.com/library/?pg=1&find=okc_k_party_roles_b), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [okc_line_styles_v](https://www.enginatics.com/library/?pg=1&find=okc_line_styles_v), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [okc_k_items](https://www.enginatics.com/library/?pg=1&find=okc_k_items), [okc_k_lines_v](https://www.enginatics.com/library/?pg=1&find=okc_k_lines_v), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [csi_item_instances](https://www.enginatics.com/library/?pg=1&find=csi_item_instances), [csi_counters_vl](https://www.enginatics.com/library/?pg=1&find=csi_counters_vl), [okc_k_headers_all_b](https://www.enginatics.com/library/?pg=1&find=okc_k_headers_all_b), [okc_k_headers_tl](https://www.enginatics.com/library/?pg=1&find=okc_k_headers_tl), [oks_k_headers_b](https://www.enginatics.com/library/?pg=1&find=oks_k_headers_b), [oks_billing_profiles_v](https://www.enginatics.com/library/?pg=1&find=oks_billing_profiles_v), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [okc_statuses_v](https://www.enginatics.com/library/?pg=1&find=okc_statuses_v), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all), [okc_k_lines_b](https://www.enginatics.com/library/?pg=1&find=okc_k_lines_b), [oks_k_lines_b](https://www.enginatics.com/library/?pg=1&find=oks_k_lines_b), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[OKL Termination Quotes](/OKL%20Termination%20Quotes/ "OKL Termination Quotes Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [OKL Lease Contract Update Upload](/OKL%20Lease%20Contract%20Update%20Upload/ "OKL Lease Contract Update Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/oks-service-contract-line-upload/) |
| Blitz Report™ XML Import | [OKS_Service_Contract_Line_Upload.xml](https://www.enginatics.com/xml/oks-service-contract-line-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/oks-service-contract-line-upload/](https://www.enginatics.com/reports/oks-service-contract-line-upload/) |



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

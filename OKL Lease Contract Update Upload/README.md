---
layout: default
title: 'OKL Lease Contract Update Upload | Oracle EBS SQL Report'
description: 'Changes the bill to customer account and bill to site of Lease Management contracts through the Oracle public API oklcontractpub.updatecontractheader -…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, OKL, Lease, Contract, Update, okc_k_headers_all_b, okl_k_headers, hr_all_organization_units_vl'
permalink: /OKL%20Lease%20Contract%20Update%20Upload/
---

# OKL Lease Contract Update Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/okl-lease-contract-update-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Changes the bill to customer account and bill to site of Lease Management contracts through the Oracle public API okl_contract_pub.update_contract_header - the Bill To of the Lease Contract header.

One row per contract. Enter the Bill To Customer Account, the Bill To Site, or both; everything else on the row is context and is read only. A site that does not belong to the Bill To Customer Account on the row is rejected, so change both together when the account changes too.

A bill to change does not require a rebook: it was verified against Booked, Evergreen, Passed and Incomplete contracts. Rebook remains necessary for the financial terms this upload does not touch.

Run it under a Lease Management responsibility. Under an unrelated responsibility Oracle refuses the update with its own privilege message.

## Report Parameters
Upload Mode, Operating Unit, Contract Number, Contract Status, Deal Type, Bill To Customer Account

## Oracle EBS Tables Used
[okc_k_headers_all_b](https://www.enginatics.com/library/?pg=1&find=okc_k_headers_all_b), [okl_k_headers](https://www.enginatics.com/library/?pg=1&find=okl_k_headers), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [okc_statuses_v](https://www.enginatics.com/library/?pg=1&find=okc_statuses_v), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[OKL Termination Quotes](/OKL%20Termination%20Quotes/ "OKL Termination Quotes Oracle EBS SQL Report"), [OKS Service Contract Line Upload](/OKS%20Service%20Contract%20Line%20Upload/ "OKS Service Contract Line Upload Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/okl-lease-contract-update-upload/) |
| Blitz Report™ XML Import | [OKL_Lease_Contract_Update_Upload.xml](https://www.enginatics.com/xml/okl-lease-contract-update-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/okl-lease-contract-update-upload/](https://www.enginatics.com/reports/okl-lease-contract-update-upload/) |



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

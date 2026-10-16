---
layout: default
last_modified_at: 2026-10-16
title: 'OKL Lease Contract Update Upload | Oracle EBS SQL Report'
description: 'Changes the bill to customer account and bill to site of Lease Management contracts through the Oracle public API oklcontractpub.updatecontractheader …'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, OKL, Lease, Contract, Update, okc_k_headers_all_b, okl_k_headers, hr_all_organization_units_vl'
permalink: /OKL%20Lease%20Contract%20Update%20Upload/
report_name: 'OKL Lease Contract Update Upload'
report_web_name: okl-lease-contract-update-upload
---

# OKL Lease Contract Update Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/okl-lease-contract-update-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload).

## Overview
Changes the bill to customer account and bill to site of Lease Management contracts through the Oracle public API okl_contract_pub.update_contract_header - the Bill To of the Lease Contract header.

One row per contract. Enter the Bill To Customer Account, the Bill To Site, or both; everything else on the row is context and is read only. A site that does not belong to the Bill To Customer Account on the row is rejected, so change both together when the account changes too.

A bill to change does not require a rebook: it was verified against Booked, Evergreen, Passed and Incomplete contracts. Rebook remains necessary for the financial terms this upload does not touch.

Run it under a Lease Management responsibility. Under an unrelated responsibility Oracle refuses the update with its own privilege message.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Operating Unit, Contract Number, Contract Status, Deal Type, Bill To Customer Account

## Oracle EBS Tables Used
[okc_k_headers_all_b](https://www.enginatics.com/library/?pg=1&find=okc_k_headers_all_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload), [okl_k_headers](https://www.enginatics.com/library/?pg=1&find=okl_k_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload), [okc_statuses_v](https://www.enginatics.com/library/?pg=1&find=okc_statuses_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload)

## Related Reports
[OKL Termination Quotes](/OKL%20Termination%20Quotes/ "OKL Termination Quotes Oracle EBS SQL Report"), [OKS Service Contract Line Upload](/OKS%20Service%20Contract%20Line%20Upload/ "OKS Service Contract Line Upload Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AR Transactions and Lines 11i](/AR%20Transactions%20and%20Lines%2011i/ "AR Transactions and Lines 11i Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OKL%20Lease%20Contract%20Update%20Upload/OKL%20Lease%20Contract%20Update%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/okl-lease-contract-update-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload) |
| Blitz Report™ XML Import | [OKL_Lease_Contract_Update_Upload.xml](https://www.enginatics.com/xml/okl-lease-contract-update-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload) |
| SQL Source | [OKL Lease Contract Update Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OKL%20Lease%20Contract%20Update%20Upload/OKL%20Lease%20Contract%20Update%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/okl-lease-contract-update-upload/](https://www.enginatics.com/reports/okl-lease-contract-update-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload) |

## Case Study & Technical Analysis: OKL Lease Contract Update Upload

### Executive Summary
The OKL Lease Contract Update Upload changes the bill to customer account and bill to site on Oracle Lease Management contracts. It is written for lease administrators and receivables teams who must move billing for a portfolio of leases. The file holds one row per lease contract, and the user enters the new Bill To Customer Account, the Bill To Site, or both. The update is applied through the public contract API `OKLCONTRACTPUB.UPDATECONTRACTHEADER`, so the change follows Oracle's own rules. The report is R12 only and runs in the Lease Management area of Oracle EBS.

### Business Challenge
*   **Bulk billing changes:** When a lessee's billing arrangement changes, every affected lease header must be updated, and doing so one contract at a time in the form is slow.
*   **Keeping account and site consistent:** A bill to site belongs to one customer account, and a mismatched pair must be rejected rather than saved.
*   **Avoiding unnecessary rebooks:** A rebook is expensive, so the team needs to know whether a billing change requires one.
*   **Responsibility and privilege control:** Updates must run under the correct Lease Management responsibility, because the API enforces privileges.

### The Solution
*   **One row per contract:** Each row identifies a Lease Management contract by its number, operating unit and status, with its currency, start date and end date for context.
*   **Two editable fields:** The Bill To Customer Account and Bill To Site are the only fields the user changes, and all other columns are read only context.
*   **Consistency enforcement:** The API rejects a site that does not belong to the account on the row, so the two fields are changed together when the account changes.
*   **No rebook required:** The description states that this bill to change was verified against booked, evergreen, passed and incomplete contracts, so no rebook is needed for it.

### Technical Architecture (High Level)
#### Primary Tables
*   `OKC_K_HEADERS_ALL_B`: the contract header, including the lease scope code, authoring organisation, status code, customer account and bill to site use.
*   `OKL_K_HEADERS`: the Lease Management extension of the contract header, supplying the deal type.
*   `OKC_STATUSES_V`: the translated contract status.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit that authored the contract.
*   `HZ_CUST_ACCOUNTS` and `HZ_PARTIES`: the bill to customer account and its party name.
*   `HZ_CUST_SITE_USES_ALL`, `HZ_CUST_ACCT_SITES_ALL`, `HZ_PARTY_SITES` and `HZ_LOCATIONS`: the chain from the bill to site use to its address.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units accessible to the current user.

#### Logical Relationships
1. `OKC_K_HEADERS_ALL_B` joins to `OKL_K_HEADERS` on the contract identifier, which restricts the result to lease contracts.
2. The header joins to `HR_ALL_ORGANIZATION_UNITS_VL` on the authoring organisation and to `OKC_STATUSES_V` on the status code.
3. The header joins to `HZ_CUST_ACCOUNTS` on the customer account identifier, then to `HZ_PARTIES` on the party identifier.
4. The bill to site use joins to `HZ_CUST_SITE_USES_ALL`, then to `HZ_CUST_ACCT_SITES_ALL`, `HZ_PARTY_SITES` and `HZ_LOCATIONS` to give the address.
5. Contracts are limited to authoring organisations in `MO_GLOB_ORG_ACCESS_TMP`.

### Parameters & Filtering
*   **Upload Mode:** Determines whether the file is used to download the contracts or to upload changes.
*   **Operating Unit:** Restricts the contracts to one operating unit.
*   **Contract Number:** Shows one lease contract.
*   **Contract Status:** Filters on the translated status of the contract.
*   **Deal Type:** Filters on the deal type, translated through the book class lookup.
*   **Bill To Customer Account:** Restricts the contracts to those billed to one customer account.

### Performance & Optimization
*   **Lease scope first:** The query starts by restricting `OKC_K_HEADERS_ALL_B` to the LEASE scope code, so only lease contracts are read.
*   **Organisation access filter:** Authoring organisations are limited to those in the access table, which keeps the scan within the user's operating units.
*   **Outer joins for billing chain:** Customer, site and location tables are attached with outer joins, so contracts without a bill to party are still listed for correction.

### FAQ
**Q: How do I change the bill to customer on Oracle Lease Management contracts in bulk?**
A: Download the contracts with the upload, enter the new Bill To Customer Account and Bill To Site on the rows to change, and upload the file under a Lease Management responsibility.

**Q: Does changing the bill to require a rebook?**
A: No. The description states the bill to change does not require a rebook, and was verified against booked, evergreen, passed and incomplete contracts. Rebook is still needed for financial terms this upload does not touch.

**Q: Why does the update fail with a privilege message?**
A: The upload calls the public contract API, and Oracle refuses the update when it runs under a responsibility unrelated to Lease Management.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=okl-lease-contract-update-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

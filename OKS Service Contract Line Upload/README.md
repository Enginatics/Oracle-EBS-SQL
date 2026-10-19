---
layout: default
last_modified_at: 2026-10-19
title: 'OKS Service Contract Line Upload | Oracle EBS SQL Report'
description: 'This upload maintains the lines of existing Oracle Service Contracts through the standard Service Contracts public APIs: it updates header and line level…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, OKS, Service, Contract, Line, hz_cust_acct_sites_all, hz_cust_accounts, okc_k_party_roles_b'
permalink: /OKS%20Service%20Contract%20Line%20Upload/
report_name: 'OKS Service Contract Line Upload'
report_web_name: oks-service-contract-line-upload
---

# OKS Service Contract Line Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/oks-service-contract-line-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload).

## Overview
This upload maintains the lines of existing Oracle Service Contracts through the standard Service Contracts public APIs: it updates header and line level values, adds new service and usage lines, and adds covered product or counter sublines.

Each row is one contract line or subline. Rows identified by the Line Number column update that line; sublines use the parent.child format, for example 1.2 for the second covered product of service line 1. Rows without a Line Number create a new line: leave Parent Line Number empty and enter Line Type, Item and the line dates for a top line, or enter a Parent Line Number, the Covered Product and the covered dates for a subline. A subline can reference a top line created by an earlier row of the same file. Header level values repeat on every row of a contract and are applied once.

Usage lines need a Usage Type, and a Usage Period for all types except Negotiated per Period. Actual per Period and Actual by Quantity lines are invoiced in arrears, which the upload sets automatically, and their sublines need a Default Quantity and a Base Reading.

Prices are written as entered. Changing the negotiated amount or unit price does not reprice the line through the price list and does not regenerate an existing billing schedule, and lines cannot be removed by this upload.

Updates are validated by the Service Contracts APIs, so changes not allowed for the current contract or line status are rejected with the corresponding API message.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Operating Unit, Contract Number, Contract Status, Line Status

## Oracle EBS Tables Used
[hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload), [okc_k_party_roles_b](https://www.enginatics.com/library/?pg=1&find=okc_k_party_roles_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload), [okc_line_styles_v](https://www.enginatics.com/library/?pg=1&find=okc_line_styles_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload), [okc_k_items](https://www.enginatics.com/library/?pg=1&find=okc_k_items&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload), [okc_k_lines_v](https://www.enginatics.com/library/?pg=1&find=okc_k_lines_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload), [csi_item_instances](https://www.enginatics.com/library/?pg=1&find=csi_item_instances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload), [csi_counters_vl](https://www.enginatics.com/library/?pg=1&find=csi_counters_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload), [okc_k_headers_all_b](https://www.enginatics.com/library/?pg=1&find=okc_k_headers_all_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload), [okc_k_headers_tl](https://www.enginatics.com/library/?pg=1&find=okc_k_headers_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload), [oks_k_headers_b](https://www.enginatics.com/library/?pg=1&find=oks_k_headers_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload), [oks_billing_profiles_v](https://www.enginatics.com/library/?pg=1&find=oks_billing_profiles_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload), [okc_statuses_v](https://www.enginatics.com/library/?pg=1&find=okc_statuses_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload), [okc_k_lines_b](https://www.enginatics.com/library/?pg=1&find=okc_k_lines_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload), [oks_k_lines_b](https://www.enginatics.com/library/?pg=1&find=oks_k_lines_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload)

## Related Reports
[AR Transactions and Lines 11i](/AR%20Transactions%20and%20Lines%2011i/ "AR Transactions and Lines 11i Oracle EBS SQL Report"), [OKL Termination Quotes](/OKL%20Termination%20Quotes/ "OKL Termination Quotes Oracle EBS SQL Report"), [CSI Customer Products Summary](/CSI%20Customer%20Products%20Summary/ "CSI Customer Products Summary Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [CSI Counter Readings](/CSI%20Counter%20Readings/ "CSI Counter Readings Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OKS%20Service%20Contract%20Line%20Upload/OKS%20Service%20Contract%20Line%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/oks-service-contract-line-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload) |
| Blitz Report™ XML Import | [OKS_Service_Contract_Line_Upload.xml](https://www.enginatics.com/xml/oks-service-contract-line-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload) |
| SQL Source | [OKS Service Contract Line Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OKS%20Service%20Contract%20Line%20Upload/OKS%20Service%20Contract%20Line%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/oks-service-contract-line-upload/](https://www.enginatics.com/reports/oks-service-contract-line-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload) |

## Case Study & Technical Analysis: OKS Service Contract Line Upload

### Executive Summary
This upload maintains the lines of existing Oracle Service Contracts through the standard Service Contracts public APIs. It updates header and line values, adds service and usage lines, and adds covered product or counter sublines to a contract. Service contract administrators and service finance teams use it to extend or correct large contracts, for example when many covered products are added to a maintenance agreement or when usage lines are set up for counter-based billing. The template runs in Excel through Blitz Report.

### Business Challenge
*   **Contract maintenance volume:** Service contracts with many covered products need each product added as a subline, which is slow to do in the Contracts form.
*   **Usage and counter billing:** Usage lines for counter readings must carry a usage type, usage period and base reading that match the billing terms.
*   **Consistent header values:** Header details such as the bill-to and ship-to sites, billing profile and party roles repeat across every line and must agree.
*   **Status-based restrictions:** Changes that are not allowed for the current contract or line status must be rejected rather than forced through.

### The Solution
*   **Line or subline by number:** Rows with a line number update that line, and sublines use a parent.child format, so a second covered product of line 1 is written as 1.2.
*   **New lines by parent:** Rows without a line number create a new top line, or a subline when a parent line number is entered.
*   **Usage line rules:** Usage lines need a usage type, and a usage period except for negotiated per period lines. Actual per period and actual by quantity lines are invoiced in arrears, which the upload sets automatically.
*   **Header applied once:** Header values repeat on every row of a contract, and they are applied once.
*   **API validation:** Updates go through the Service Contracts APIs, so any rejected change returns the API message on the row.

### Technical Architecture (High Level)
#### Primary Tables
*   `OKC_K_HEADERS_ALL_B` and `OKC_K_HEADERS_TL`: the contract header and its translated description and comments.
*   `OKS_K_HEADERS_B` and `OKS_BILLING_PROFILES_V`: the service-specific header and the billing profile.
*   `OKC_K_LINES_B` and `OKS_K_LINES_B`: the contract lines and their service-specific attributes, such as usage period.
*   `OKC_K_ITEMS`: the item or covered product attached to each line.
*   `OKC_LINE_STYLES_V`: the line type name.
*   `OKC_STATUSES_V`: the contract and line status meanings.
*   `OKC_K_PARTY_ROLES_B`: the additional party roles of the contract.
*   `HZ_CUST_ACCOUNTS`, `HZ_CUST_ACCT_SITES_ALL` and `HZ_CUST_SITE_USES_ALL`: the header and line bill-to and ship-to accounts and locations.
*   `CSI_ITEM_INSTANCES` and `CSI_COUNTERS_VL`: the covered product instance or counter.
*   `MTL_SYSTEM_ITEMS_VL` and `MTL_UNITS_OF_MEASURE_VL`: the item and the unit of measure.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units the session can access.

#### Logical Relationships
1. `OKC_K_HEADERS_ALL_B` joins to `OKC_K_HEADERS_TL` on id, restricted to the session language, and to `OKS_K_HEADERS_B` on the chr id.
2. `OKC_K_HEADERS_ALL_B` joins to `OKC_K_LINES_B` on the dnz chr id, restricted to service line styles.
3. Each line joins to its parent line through the cle id, and to `OKS_K_LINES_B` for the usage period.
4. Each line joins to `OKC_K_ITEMS` for the covered product or counter, which resolves to `CSI_ITEM_INSTANCES` or `CSI_COUNTERS_VL` by the object type.
5. The bill-to and ship-to sites join to `HZ_CUST_SITE_USES_ALL`, and the account numbers come from `HZ_CUST_ACCOUNTS` on the header and line customer account ids, with a fallback through `HZ_CUST_ACCT_SITES_ALL` when the account is not set.

### Parameters & Filtering
*   **Upload Mode:** selects Create, or Create, Update to download existing contract lines.
*   **Operating Unit:** restricts the contracts to one operating unit.
*   **Contract Number:** restricts the contracts to one contract.
*   **Contract Status and Line Status:** restrict the contracts or lines to one status.

### Performance & Optimization
*   The service contract filter on the SCS code and the operating unit access list reduce the header scan before the line joins run.
*   Line style filtering restricts the lines to a fixed set of service and usage line style identifiers.
*   Site and account lookups are outer joins on site use id, so header and line detail is shown even when a site is missing.

### FAQ
**Q: How do I add a covered product to an existing service line?**
A: Enter a parent line number in the form parent.child, with the covered product and covered dates, and leave the line number empty.

**Q: Why is my usage line rejected?**
A: Usage lines need a usage type, and a usage period for every type except negotiated per period.

**Q: Can this upload remove a line?**
A: No. The upload does not remove lines.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contract-line-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

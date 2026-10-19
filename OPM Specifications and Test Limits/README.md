---
layout: default
last_modified_at: 2026-10-19
title: 'OPM Specifications and Test Limits | Oracle EBS SQL Report'
description: 'Oracle Process Manufacturing (OPM) Quality specifications and test limits: every GMD specification with its version and status, the item and grade it…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Process Manufacturing, Enginatics, R12 only, OPM, Specifications, Test, Limits, gmd_specifications_b, gmd_specifications_tl, gmd_spec_tests_vl'
permalink: /OPM%20Specifications%20and%20Test%20Limits/
report_name: 'OPM Specifications and Test Limits'
report_web_name: opm-specifications-and-test-limits
module: 'Process Manufacturing'
module_url: /modules/process-manufacturing/
---

# OPM Specifications and Test Limits – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/opm-specifications-and-test-limits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits).
**Oracle EBS module:** [Process Manufacturing](/modules/process-manufacturing/ "Oracle EBS Process Manufacturing reports") · [all Process Manufacturing reports](/modules/process-manufacturing/)  

## Overview
Oracle Process Manufacturing (OPM) Quality specifications and test limits: every GMD specification with its version and status, the item and grade it applies to, and each specification test's minimum, target and maximum limits, UOM, certificate-of-analysis print flag and report precision. The master reference for an organization's quality standards.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Item, Spec, Spec Status, Grade, Test

## Oracle EBS Tables Used
[gmd_specifications_b](https://www.enginatics.com/library/?pg=1&find=gmd_specifications_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits), [gmd_specifications_tl](https://www.enginatics.com/library/?pg=1&find=gmd_specifications_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits), [gmd_spec_tests_vl](https://www.enginatics.com/library/?pg=1&find=gmd_spec_tests_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits), [gmd_qc_tests_b](https://www.enginatics.com/library/?pg=1&find=gmd_qc_tests_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits), [gmd_qc_tests_tl](https://www.enginatics.com/library/?pg=1&find=gmd_qc_tests_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits), [gmd_status_vl](https://www.enginatics.com/library/?pg=1&find=gmd_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits)

## Related Reports
[OPM Item Location Test Results](/OPM%20Item%20Location%20Test%20Results/ "OPM Item Location Test Results Oracle EBS SQL Report"), [OPM Recipe Details](/OPM%20Recipe%20Details/ "OPM Recipe Details Oracle EBS SQL Report"), [CAC OPM Costed Formula](/CAC%20OPM%20Costed%20Formula/ "CAC OPM Costed Formula Oracle EBS SQL Report"), [OPM Recipe Upload](/OPM%20Recipe%20Upload/ "OPM Recipe Upload Oracle EBS SQL Report"), [CAC OPM Batch Material Summary](/CAC%20OPM%20Batch%20Material%20Summary/ "CAC OPM Batch Material Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OPM%20Specifications%20and%20Test%20Limits/OPM%20Specifications%20and%20Test%20Limits.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [OPM Specifications and Test Limits 05-Jun-2026 120009.xlsx](https://www.enginatics.com/example/opm-specifications-and-test-limits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits) |
| Blitz Report™ XML Import | [OPM_Specifications_and_Test_Limits.xml](https://www.enginatics.com/xml/opm-specifications-and-test-limits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits) |
| SQL Source | [OPM Specifications and Test Limits.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OPM%20Specifications%20and%20Test%20Limits/OPM%20Specifications%20and%20Test%20Limits.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/opm-specifications-and-test-limits/](https://www.enginatics.com/reports/opm-specifications-and-test-limits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits) |

## Case Study & Technical Analysis: OPM Specifications and Test Limits

### Executive Summary
This report is the master reference for quality standards in Oracle Process Manufacturing. It lists every GMD specification with its version and status, the item and grade it applies to, and each test in the specification with its minimum, target and maximum limits, unit of measure, certificate of analysis print flag and reporting precision. Quality managers, laboratory supervisors and regulatory teams use it to confirm the acceptance limits that finished and intermediate products must meet, and to compare them against the certificates of analysis issued. The report runs in Excel through Blitz Report.

### Business Challenge
*   **Limit governance:** Acceptance limits must be documented per item and grade, and any drift between the specification and the laboratory must be visible.
*   **Certificate of analysis accuracy:** Only tests flagged for print appear on the certificate, and the flag must be controlled.
*   **Version control:** Specifications have versions and statuses, and the active version must be identified.
*   **Audit readiness:** Auditors ask for the complete set of limits for a product, which is spread across several specification tables.

### The Solution
*   **Specification header:** Each specification is shown with its name, version, description and status name.
*   **Item and grade:** The item and its description are shown with the grade the specification applies to.
*   **Test limits:** The minimum, target and maximum values are returned for each test. Character limits are used where a numeric limit is not set.
*   **Print and precision:** The print flag shows whether a test appears on the certificate of analysis, and the report precision shows how results are rounded.
*   **Ordering:** Rows are ordered by organization, specification name, version and test code, so each specification reads as one block.

### Technical Architecture (High Level)
#### Primary Tables
*   `GMD_SPECIFICATIONS_B` and `GMD_SPECIFICATIONS_TL`: the specification header, with name, version, status, item and grade, and its translated description.
*   `GMD_SPEC_TESTS_VL`: the test limits of each specification, with minimum, target, maximum, unit and report precision.
*   `GMD_QC_TESTS_B` and `GMD_QC_TESTS_TL`: the quality control test definitions, with test code and description.
*   `MTL_SYSTEM_ITEMS_VL`: the item and its description.
*   `ORG_ORGANIZATION_DEFINITIONS`: the owner organization code.
*   `GMD_STATUS_VL`: the status name of the specification.
*   `ORG_ACCESS_VIEW`: the organizations the responsibility can access.

#### Logical Relationships
1. `GMD_SPECIFICATIONS_B` joins to `GMD_SPECIFICATIONS_TL` on specification id, restricted to the session language.
2. `GMD_SPECIFICATIONS_B` joins to `GMD_SPEC_TESTS_VL` on specification id, and each test joins to `GMD_QC_TESTS_B` on test id.
3. The test name joins to `GMD_QC_TESTS_TL` on test id, restricted to the session language.
4. The specification's item joins to `MTL_SYSTEM_ITEMS_VL` on inventory item id and owner organization id.
5. The specification status joins to `GMD_STATUS_VL` as an outer join on the status code.

### Parameters & Filtering
*   **Organization Code:** restricts the specifications to one owner organization.
*   **Item:** restricts the specifications to one item.
*   **Spec:** restricts the report to one specification name.
*   **Spec Status:** restricts the specifications to one status.
*   **Grade:** restricts the specifications to one grade.
*   **Test:** restricts the report to one quality test.

### Performance & Optimization
*   The owner organization filter uses the organization access view, so only specifications the responsibility can see are read.
*   The language filters on the translated tables keep the report to one row per specification and test.
*   Numeric and character limits are combined with NVL, so each row returns a single limit value without a second query.

### FAQ
**Q: Why does a test not appear on the certificate of analysis?**
A: The certificate includes only tests with the print flag set. The flag is shown on each row for checking.

**Q: How do I find the active version of a specification?**
A: Filter by Spec and Spec Status, and read the version column for the status you need.

**Q: Which limit is shown when a test has no numeric target?**
A: The character limit is shown in place of the numeric value for that limit.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-specifications-and-test-limits)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

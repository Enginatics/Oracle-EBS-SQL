---
layout: default
last_modified_at: 2026-10-26
title: 'OPM Item Location Test Results | Oracle EBS SQL Report'
description: 'Oracle Process Manufacturing (OPM) Quality item/location test results: the QC test results recorded against inventory item, lot and subinventory samples…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Process Manufacturing, Enginatics, R12 only, OPM, Item, Location, Test, gmd_results, gmd_samples, gmd_qc_tests_b'
permalink: /OPM%20Item%20Location%20Test%20Results/
report_name: 'OPM Item Location Test Results'
report_web_name: opm-item-location-test-results
module: 'Process Manufacturing'
module_url: /modules/process-manufacturing/
---

# OPM Item Location Test Results – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/opm-item-location-test-results/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results).
**Oracle EBS module:** [Process Manufacturing](/modules/process-manufacturing/ "Oracle EBS Process Manufacturing reports") · [all Process Manufacturing reports](/modules/process-manufacturing/)  

## Overview
Oracle Process Manufacturing (OPM) Quality item/location test results: the QC test results recorded against inventory item, lot and subinventory samples, with the result value, the applicable specification minimum/target/maximum limits, an in-specification indicator and the sample disposition. The governing specification is resolved from the inventory spec validity rule effective for each sample's item, organization and lot. Answers what the lab results were for a given item or lot and whether they were in specification.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Item, Lot Number like, Test, Sample Date From, Sample Date To

## Oracle EBS Tables Used
[gmd_results](https://www.enginatics.com/library/?pg=1&find=gmd_results&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results), [gmd_samples](https://www.enginatics.com/library/?pg=1&find=gmd_samples&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results), [gmd_qc_tests_b](https://www.enginatics.com/library/?pg=1&find=gmd_qc_tests_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results), [gmd_qc_tests_tl](https://www.enginatics.com/library/?pg=1&find=gmd_qc_tests_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results), [gmd_inventory_spec_vrs](https://www.enginatics.com/library/?pg=1&find=gmd_inventory_spec_vrs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results), [gmd_specifications_b](https://www.enginatics.com/library/?pg=1&find=gmd_specifications_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results), [gmd_spec_tests_vl](https://www.enginatics.com/library/?pg=1&find=gmd_spec_tests_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results)

## Related Reports
[OPM Specifications and Test Limits](/OPM%20Specifications%20and%20Test%20Limits/ "OPM Specifications and Test Limits Oracle EBS SQL Report"), [OPM Recipe Details](/OPM%20Recipe%20Details/ "OPM Recipe Details Oracle EBS SQL Report"), [CAC OPM Batch Material Summary](/CAC%20OPM%20Batch%20Material%20Summary/ "CAC OPM Batch Material Summary Oracle EBS SQL Report"), [CAC OPM Costed Formula](/CAC%20OPM%20Costed%20Formula/ "CAC OPM Costed Formula Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OPM%20Item%20Location%20Test%20Results/OPM%20Item%20Location%20Test%20Results.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [OPM Item Location Test Results 05-Jun-2026 120008.xlsx](https://www.enginatics.com/example/opm-item-location-test-results/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results) |
| Blitz Report™ XML Import | [OPM_Item_Location_Test_Results.xml](https://www.enginatics.com/xml/opm-item-location-test-results/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results) |
| SQL Source | [OPM Item Location Test Results.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OPM%20Item%20Location%20Test%20Results/OPM%20Item%20Location%20Test%20Results.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/opm-item-location-test-results/](https://www.enginatics.com/reports/opm-item-location-test-results/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results) |

## Case Study & Technical Analysis: OPM Item Location Test Results

### Executive Summary
This report lists the quality control test results recorded in Oracle Process Manufacturing (OPM) for item, lot and subinventory samples. For each result it shows the measured value, the specification minimum, target and maximum, an in-specification indicator and the sample disposition. Quality laboratory supervisors and quality assurance teams use it to answer what the lab found for a given item or lot and whether the result was within specification. It is an R12 report that runs in Excel through Blitz Report™.

### Business Challenge
*   **Release decisions:** Lots of process ingredients and finished products cannot be released until their test results are reviewed against the specification.
*   **Specification changes:** The applicable specification can change over time, so the limits that governed a sample must be identified by its date and lot.
*   **Traceability:** Quality investigations need every test result for an item or lot, with the sample it came from.
*   **Disposition evidence:** The sample disposition must be shown next to the results that justify it.

### The Solution
*   Returns one row for each test result, with the organization, item, lot, subinventory, sample number, test code and test description.
*   Shows the result as a value, using the numeric result where one exists and the character result otherwise.
*   Shows the specification minimum, target and maximum limits and the unit of measure that applies to the test.
*   Sets an in-specification indicator where the numeric result falls within the minimum and maximum limits, and shows the sample disposition and the sample and result dates.

### Technical Architecture (High Level)
#### Primary Tables
*   `GMD_RESULTS`: the test results, with the numeric or character result value and the result date.
*   `GMD_SAMPLES`: the samples, with item, organization, lot, subinventory, date drawn and disposition.
*   `GMD_QC_TESTS_B` and `GMD_QC_TESTS_TL`: the test codes and their descriptions.
*   `GMD_INVENTORY_SPEC_VRS`: the inventory specification validity rules, which link an item, organization, lot and date range to a specification.
*   `GMD_SPECIFICATIONS_B`: the specifications, each for one item.
*   `GMD_SPEC_TESTS_VL`: the limits of each test within a specification.
*   `MTL_SYSTEM_ITEMS_VL` and `ORG_ORGANIZATION_DEFINITIONS`: the item and the organization code.
*   `ORG_ACCESS_VIEW`: the organizations the current responsibility can access.

#### Logical Relationships
1.  Each result is joined to its sample, and the sample to its test, through the test language row for the session language.
2.  Each sample is joined to its item and organization for the item number, description and organization code.
3.  The governing specification for each sample is found in a derived table: the validity rule for the same item, organization and lot, or a rule with no lot, whose start and end dates include the date drawn.
4.  Where several validity rules apply, the rule with a matching lot number is preferred, and then the rule with the latest start date.
5.  The specification limits are joined from `GMD_SPEC_TESTS_VL` by the chosen specification and the result's test.
6.  Results are ordered by organization, item, lot, sample number and test code.

### Parameters & Filtering
*   **Organization Code:** limits the output to one organization.
*   **Item:** selects one item.
*   **Lot Number like:** matches lot numbers with a pattern.
*   **Test:** selects one quality test.
*   **Sample Date From** and **To:** restrict the samples by the date drawn.

### Performance & Optimization
*   The specification choice is an aggregate with a keep clause, which selects one specification per sample in a single pass rather than through a separate ranking query.
*   The validity rule join is restricted to rules for the sample's item and organization, which keeps the candidate specifications for each sample small.
*   The organization access restriction is applied to samples before the result joins.
*   The in-specification test is a simple range comparison on the numeric result, so it adds little cost to each row.

### FAQ
**Q: How is the governing specification of a sample determined?**
A: The report uses the specification whose inventory validity rule covers the item, organization and lot of the sample and whose start and end dates include the date drawn, preferring a rule for the exact lot.

**Q: When is a result shown as in specification?**
A: A numeric result is in specification where it lies between the specification minimum and maximum; results without numeric limits are not marked.

**Q: Where do the test names and codes come from?**
A: They come from the Quality test tables `GMD_QC_TESTS_B` and `GMD_QC_TESTS_TL`, with the description in the session language.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-item-location-test-results)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

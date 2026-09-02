---
layout: default
title: 'OPM Item Location Test Results | Oracle EBS SQL Report'
description: 'Oracle Process Manufacturing (OPM) Quality item/location test results: the QC test results recorded against inventory item, lot and subinventory samples…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, OPM, Item, Location, Test, gmd_results, gmd_samples, gmd_qc_tests_b'
permalink: /OPM%20Item%20Location%20Test%20Results/
---

# OPM Item Location Test Results – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/opm-item-location-test-results/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Oracle Process Manufacturing (OPM) Quality item/location test results: the QC test results recorded against inventory item, lot and subinventory samples, with the result value, the applicable specification minimum/target/maximum limits, an in-specification indicator and the sample disposition. The governing specification is resolved from the inventory spec validity rule effective for each sample's item, organization and lot. Answers what the lab results were for a given item or lot and whether they were in specification.

## Report Parameters
Organization Code, Item, Lot Number like, Test, Sample Date From, Sample Date To

## Oracle EBS Tables Used
[gmd_results](https://www.enginatics.com/library/?pg=1&find=gmd_results), [gmd_samples](https://www.enginatics.com/library/?pg=1&find=gmd_samples), [gmd_qc_tests_b](https://www.enginatics.com/library/?pg=1&find=gmd_qc_tests_b), [gmd_qc_tests_tl](https://www.enginatics.com/library/?pg=1&find=gmd_qc_tests_tl), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [gmd_inventory_spec_vrs](https://www.enginatics.com/library/?pg=1&find=gmd_inventory_spec_vrs), [gmd_specifications_b](https://www.enginatics.com/library/?pg=1&find=gmd_specifications_b), [gmd_spec_tests_vl](https://www.enginatics.com/library/?pg=1&find=gmd_spec_tests_vl), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[OPM Specifications and Test Limits](/OPM%20Specifications%20and%20Test%20Limits/ "OPM Specifications and Test Limits Oracle EBS SQL Report"), [OPM Recipe Details](/OPM%20Recipe%20Details/ "OPM Recipe Details Oracle EBS SQL Report"), [CAC OPM Costed Formula](/CAC%20OPM%20Costed%20Formula/ "CAC OPM Costed Formula Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [OPM Item Location Test Results 05-Jun-2026 120008.xlsx](https://www.enginatics.com/example/opm-item-location-test-results/) |
| Blitz Report™ XML Import | [OPM_Item_Location_Test_Results.xml](https://www.enginatics.com/xml/opm-item-location-test-results/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/opm-item-location-test-results/](https://www.enginatics.com/reports/opm-item-location-test-results/) |



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

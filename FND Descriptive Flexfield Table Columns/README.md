---
layout: default
title: 'FND Descriptive Flexfield Table Columns | Oracle EBS SQL Report'
description: 'Shows all active descriptive flexfield table columns. – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Descriptive, Flexfield, Table, fnd_application_vl, fnd_descriptive_flexs_vl, fnd_tables'
permalink: /FND%20Descriptive%20Flexfield%20Table%20Columns/
---

# FND Descriptive Flexfield Table Columns – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-descriptive-flexfield-table-columns/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Shows all active descriptive flexfield table columns.

## Report Parameters
Application, Name, Title, Table Name

## Oracle EBS Tables Used
[fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_descriptive_flexs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_descriptive_flexs_vl), [fnd_tables](https://www.enginatics.com/library/?pg=1&find=fnd_tables), [fnd_columns](https://www.enginatics.com/library/?pg=1&find=fnd_columns)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Flex Value Sets, Usages and Values](/FND%20Flex%20Value%20Sets-%20Usages%20and%20Values/ "FND Flex Value Sets, Usages and Values Oracle EBS SQL Report"), [FND Tables and Columns](/FND%20Tables%20and%20Columns/ "FND Tables and Columns Oracle EBS SQL Report"), [FND Descriptive Flexfields](/FND%20Descriptive%20Flexfields/ "FND Descriptive Flexfields Oracle EBS SQL Report"), [Blitz Report Parameter DFF Table Validation](/Blitz%20Report%20Parameter%20DFF%20Table%20Validation/ "Blitz Report Parameter DFF Table Validation Oracle EBS SQL Report"), [FND Key Flexfields](/FND%20Key%20Flexfields/ "FND Key Flexfields Oracle EBS SQL Report"), [CST Detailed Item Cost](/CST%20Detailed%20Item%20Cost/ "CST Detailed Item Cost Oracle EBS SQL Report"), [FND Flex Value Security Rules](/FND%20Flex%20Value%20Security%20Rules/ "FND Flex Value Security Rules Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Descriptive Flexfield Table Columns 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/fnd-descriptive-flexfield-table-columns/) |
| Blitz Report™ XML Import | [FND_Descriptive_Flexfield_Table_Columns.xml](https://www.enginatics.com/xml/fnd-descriptive-flexfield-table-columns/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-descriptive-flexfield-table-columns/](https://www.enginatics.com/reports/fnd-descriptive-flexfield-table-columns/) |

## Executive Summary
The **FND Descriptive Flexfield Table Columns** report provides a technical mapping of database columns to Descriptive Flexfields (DFFs). It identifies which columns in a table are enabled for flexfield usage.

## Business Challenge
*   **Customization Analysis:** Identifying which tables have available "Attribute" columns for storing custom data.
*   **Data Migration:** Mapping legacy data to specific DFF segments during a migration project.
*   **Cleanup:** Finding unused or disabled flexfield columns.

## The Solution
This Blitz Report lists the columns in `FND_TABLES` that are registered as part of a Descriptive Flexfield:
*   **Table Mapping:** Shows the database table name (e.g., `PO_HEADERS_ALL`).
*   **Column Usage:** Lists the specific column (e.g., `ATTRIBUTE1`) and its status.

## Technical Architecture
The report joins `FND_TABLES`, `FND_COLUMNS`, and `FND_DESCRIPTIVE_FLEXS` to show the relationship between the physical table structure and the logical flexfield definition.

## Parameters & Filtering
*   **Table Name:** Filter by the database table you are investigating.
*   **Application:** Filter by module (e.g., "Purchasing").

## Performance & Optimization
*   **Metadata Report:** Runs instantly against the data dictionary.

## FAQ
*   **Q: Does this show the values in the columns?**
    *   A: No, this report shows the *definition* of the columns. To see the data, you would need to query the table itself or use the "FND Descriptive Flexfields" report to see the configuration.


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

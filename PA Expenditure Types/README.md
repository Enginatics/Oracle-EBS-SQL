---
layout: default
last_modified_at: 2026-10-19
title: 'PA Expenditure Types | Oracle EBS SQL Report'
description: 'Listing of project expenditure types with their category, type class, unit of measure, and active dates.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Projects, Enginatics, Expenditure, Types, pa_system_linkages, pa_expenditure_types'
permalink: /PA%20Expenditure%20Types/
report_name: 'PA Expenditure Types'
report_web_name: pa-expenditure-types
module: 'Projects'
module_url: /modules/projects/
---

# PA Expenditure Types – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-expenditure-types/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-types) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-types).
**Oracle EBS module:** [Projects](/modules/projects/ "Oracle EBS Projects reports") · [all Projects reports](/modules/projects/)  

## Overview
Listing of project expenditure types with their category, type class, unit of measure, and active dates.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-types) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Expenditure Category, Expenditure Type Class

## Oracle EBS Tables Used
[pa_system_linkages](https://www.enginatics.com/library/?pg=1&find=pa_system_linkages&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-types), [pa_expenditure_types](https://www.enginatics.com/library/?pg=1&find=pa_expenditure_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-types)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-types)

## Related Reports
[PA Project Expenditure Items with WIP and INV Detail](/PA%20Project%20Expenditure%20Items%20with%20WIP%20and%20INV%20Detail/ "PA Project Expenditure Items with WIP and INV Detail Oracle EBS SQL Report"), [PA Transaction Sources](/PA%20Transaction%20Sources/ "PA Transaction Sources Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Expenditure%20Types/PA%20Expenditure%20Types.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-types) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PA Expenditure Types 22-Jan-2018 181945.xlsx](https://www.enginatics.com/example/pa-expenditure-types/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-types) |
| Blitz Report™ XML Import | [PA_Expenditure_Types.xml](https://www.enginatics.com/xml/pa-expenditure-types/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-types) |
| SQL Source | [PA Expenditure Types.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Expenditure%20Types/PA%20Expenditure%20Types.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/pa-expenditure-types/](https://www.enginatics.com/reports/pa-expenditure-types/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-types) |

## Case Study & Technical Analysis: PA Expenditure Types

### Executive Summary
The PA Expenditure Types report lists the project expenditure types defined in Oracle Projects, with their expenditure category, type class, unit of measure, cost rate flag and active dates. It is written for project accountants, project controllers and implementation consultants who must confirm how expenditure types are configured before costs are charged to projects. An expenditure type is the classification that a project cost carries, and its class determines how the cost is processed, so an accurate listing is needed for setup reviews and cost analysis. The report sits in the Projects module and returns the full set of types without parameters that restrict the query.

### Business Challenge
*   **Setup verification:** Project cost structures depend on expenditure types, and implementation teams need a complete list to confirm the setup before go-live.
*   **Understanding classes:** A type's class, such as labour, non-labour or usage, determines how costs are handled, and users need that class in plain words.
*   **Active and expired types:** Types have start and end dates, and costs charged to an expired type are a common source of errors.
*   **Change control:** Administrators need to see who created or last changed each type and when.

### The Solution
*   **Complete type listing:** The report returns every expenditure type with its description, category and unit of measure.
*   **Translated class:** The system linkage function of each type is translated into its class meaning, so the class is shown as text rather than as a code.
*   **Cost rate flag:** The cost rate indicator is translated to a yes or no value, showing whether the type carries a cost rate.
*   **Active dates:** The start and end dates show when each type can be used.
*   **Audit columns:** Created by, creation date, last updated by and last update date are returned for each type.

### Technical Architecture (High Level)
#### Primary Tables
*   `PA_EXPENDITURE_TYPES`: the expenditure type definitions, with category, unit of measure, revenue category, cost rate flag, active dates and audit columns.
*   `PA_SYSTEM_LINKAGES`: the system linkage functions, from which the translated class meaning is taken.

#### Logical Relationships
1. Each expenditure type carries a system linkage function code.
2. The class meaning is read from `PA_SYSTEM_LINKAGES` by matching the function code of the type, through a scalar subquery.
3. There is no other join, so the result is one row per expenditure type.
4. The result is ordered by expenditure type name.

### Parameters & Filtering
*   **Expenditure Category:** Intended to restrict the listing to one expenditure category.
*   **Expenditure Type Class:** Intended to restrict the listing to one class, such as labour or non-labour.

The SQL text in the library does not reference either parameter, so the query as written returns all expenditure types. Users who need one category or class should filter the output by the `expenditure_category` or `expenditure_type_class` column in Excel.

### Performance & Optimization
*   **Single-table read:** The main query reads only `PA_EXPENDITURE_TYPES`, so its cost is that of a single table scan with an order by.
*   **Scalar lookup for class:** The class is resolved by a scalar subquery on `PA_SYSTEM_LINKAGES`, which returns one value per type and avoids a join that could duplicate rows.
*   **Small reference set:** Expenditure types are a configuration list rather than transactional data, so the full listing is returned without performance concern.
*   **Name ordering:** The result is ordered by expenditure type, which gives a stable listing for comparison between instances.

### FAQ
**Q: How do I list all expenditure types and their classes in Oracle Projects?**
A: Run PA Expenditure Types. The expenditure_type_class column gives the class of each type, translated from its system linkage function.

**Q: How can I tell whether an expenditure type is still active?**
A: Read the start_date_active and end_date_active columns, which show the period during which the type can be used.

**Q: Which columns show who changed an expenditure type?**
A: The created_by, creation_date, last_updated_by and last_update_date columns show the audit trail of each type.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-types)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-types)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-types)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-types)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-types)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-types)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-expenditure-types)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

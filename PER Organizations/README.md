---
layout: default
title: 'PER Organizations | Oracle EBS SQL Report'
description: 'Master data report showing organizations, classifications, address details and additional information attributes.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, PER, Organizations, per_all_assignments_f, hr_all_organization_units_vl, hr_locations_all'
permalink: /PER%20Organizations/
---

# PER Organizations – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/per-organizations/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Master data report showing organizations, classifications, address details and additional information attributes.

## Report Parameters
Business Group, Organization Name, Country, Organization Type, Classification, Internal or External, Show Attributes, Information Type, Attribute Name, Show active only, Expand Classifications

## Oracle EBS Tables Used
[per_all_assignments_f](https://www.enginatics.com/library/?pg=1&find=per_all_assignments_f), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_org_info_types_by_class](https://www.enginatics.com/library/?pg=1&find=hr_org_info_types_by_class), [fnd_descr_flex_col_usage_vl](https://www.enginatics.com/library/?pg=1&find=fnd_descr_flex_col_usage_vl), [hr_org_information_types](https://www.enginatics.com/library/?pg=1&find=hr_org_information_types), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [CAC WIP Material Relief](/CAC%20WIP%20Material%20Relief/ "CAC WIP Material Relief Oracle EBS SQL Report"), [INV Movement Statistics](/INV%20Movement%20Statistics/ "INV Movement Statistics Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [CST AP and PO Accrual Reconciliation](/CST%20AP%20and%20PO%20Accrual%20Reconciliation/ "CST AP and PO Accrual Reconciliation Oracle EBS SQL Report"), [AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report"), [CAC OPM Costed Formula](/CAC%20OPM%20Costed%20Formula/ "CAC OPM Costed Formula Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PER Organizations 03-Jul-2020 135719.xlsx](https://www.enginatics.com/example/per-organizations/) |
| Blitz Report™ XML Import | [PER_Organizations.xml](https://www.enginatics.com/xml/per-organizations/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/per-organizations/](https://www.enginatics.com/reports/per-organizations/) |

## Case Study & Technical Analysis: PER Organizations Report

### Executive Summary

The PER Organizations report is a critical master data and configuration audit tool for Oracle Human Resources. It provides a comprehensive listing of all organizations defined within the system, along with their classifications, address details, and various additional information attributes. This report is indispensable for HR administrators, system configurators, and auditors to manage the foundational building blocks of an enterprise structure, ensuring accuracy, compliance, and consistency across all organizational entities.

### Business Challenge

Organizations are complex, with various departments, legal entities, business units, and inventory organizations all needing to be accurately represented in the HR system. Managing this diverse set of organizational data presents several challenges:

-   **Fragmented Information:** Details about an organization, such as its classification (e.g., HR Organization, Legal Employer, Inventory Organization), address, and specific attributes, are often scattered across multiple forms in Oracle EBS.
-   **Data Inconsistency:** Manual data entry and lack of a consolidated view can lead to inconsistencies in organizational data, causing issues in payroll, inventory management, financial reporting, and security configurations.
-   **Difficult Auditing:** Auditing organizational setups for compliance (e.g., ensuring all legal entities are correctly classified) or for system integrity (e.g., verifying address details for all operating units) is a time-consuming and complex manual process.
-   **Impact on Cross-Functional Processes:** Organizations are fundamental to how transactions flow through an ERP system. Errors in their setup can cascade into problems in purchasing, sales, manufacturing, and financial accounting.

### The Solution

This report offers a consolidated, detailed, and easily auditable view of all organizational setups, streamlining HR and system administration tasks.

-   **Comprehensive Organizational Data:** It brings together all relevant details for each organization—name, classification, address, and additional attributes—into a single, easy-to-read report, providing a holistic view.
-   **Simplified Configuration Audit:** HR system administrators and auditors can use this report to quickly review and verify organizational setups, ensuring correct classifications, valid addresses, and adherence to company standards.
-   **Enhanced Data Quality:** By providing a clear overview, the report helps in identifying and correcting data inconsistencies proactively, improving the overall quality and reliability of foundational organizational data.
-   **Supports Cross-Functional Alignment:** The report can be used by teams across HR, Finance, and Operations to ensure a shared understanding of organizational definitions and their impact on various business processes.

### Technical Architecture (High Level)

The report queries core Oracle HR tables that define organizations and their associated details.

-   **Primary Tables Involved:**
    -   `hr_all_organization_units_vl` (the central view for organization definitions, including names and internal IDs).
    -   `hr_organization_information` (stores various classifications and additional attribute details for each organization).
    -   `hr_locations_all` (for address details of organizations).
    -   `fnd_territories_vl` (for country names).
    -   `hr_org_information_types` and `hr_org_info_types_by_class` (for defining and linking various organizational information types).
-   **Logical Relationships:** The report starts with `hr_all_organization_units_vl` to list all organizations. It then performs joins to `hr_locations_all` to retrieve address information and to `hr_organization_information` to pull in detailed classifications and other descriptive attributes. The `Expand Classifications` parameter likely controls how these classifications are presented in the report output.

### Parameters & Filtering

The report offers a rich set of parameters for targeted organizational analysis:

-   **Business Group:** Filters the report to a specific legal entity or organizational grouping.
-   **Organization Identification:** `Organization Name` and `Organization Type` allow for filtering by specific entities or categories of organizations.
-   **Geographic Filter:** `Country` enables analysis of organizations in particular regions.
-   **Classification and Attributes:** `Classification`, `Information Type`, and `Attribute Name` allow for deep dives into specific organizational characteristics. `Show Attributes` and `Expand Classifications` are key for controlling the level of detail.
-   **Show active only:** Focuses the report on currently active organizations.

### Performance & Optimization

As a master data report, it is optimized for efficient retrieval of configuration data.

-   **Indexed Joins:** The queries leverage standard Oracle indexes on `organization_id`, `location_id`, and other primary keys for fast joins between the various HR setup tables.
-   **Parameter-Driven Scope:** The extensive filtering parameters are crucial for performance, allowing users to limit the data retrieved to only the organizations and attributes of interest, preventing the report from attempting to process an excessively broad dataset.

### FAQ

**1. What is an 'Organization Classification' and why is it important?**
   An 'Organization Classification' defines the role or type of an organization (e.g., 'HR Organization', 'Legal Employer', 'Inventory Organization', 'Operating Unit'). A single organization can have multiple classifications. These classifications are critical because they dictate how an organization behaves in different Oracle modules and which functionalities are enabled for it.

**2. How can I use this report to verify an organization's legal entity status?**
   You can filter the report by `Classification` = 'Legal Employer' (or similar, depending on configuration). This will show you all organizations that are defined as legal entities in your system, allowing you to verify their details and ensure compliance with legal and financial reporting requirements.

**3. What is the purpose of 'Show Attributes' and 'Information Type' parameters?**
   These parameters allow you to dynamically include or filter for specific Descriptive Flexfield (DFF) or Extra Information Type (EIT) attributes that are stored against an organization. This is crucial for reporting on client-specific data points that are not part of Oracle's standard organization fields.


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

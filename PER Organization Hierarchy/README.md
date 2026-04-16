---
layout: default
title: 'PER Organization Hierarchy | Oracle EBS SQL Report'
description: 'Master data report showing hierarchical list of human resource organization structures including subordinate orgs.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, PER, Organization, Hierarchy, hr_organization_information, per_organization_structures, per_org_structure_versions'
permalink: /PER%20Organization%20Hierarchy/
---

# PER Organization Hierarchy – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/per-organization-hierarchy/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Master data report showing hierarchical list of human resource organization structures including subordinate orgs.

## Report Parameters
Business Group, Hierarchy Name, Top Level Organization

## Oracle EBS Tables Used
[hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [per_organization_structures](https://www.enginatics.com/library/?pg=1&find=per_organization_structures), [per_org_structure_versions](https://www.enginatics.com/library/?pg=1&find=per_org_structure_versions), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [per_org_structure_elements](https://www.enginatics.com/library/?pg=1&find=per_org_structure_elements), [per_all_assignments_f](https://www.enginatics.com/library/?pg=1&find=per_all_assignments_f), [per_business_groups](https://www.enginatics.com/library/?pg=1&find=per_business_groups)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[PER Position Hierarchy](/PER%20Position%20Hierarchy/ "PER Position Hierarchy Oracle EBS SQL Report"), [FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PER Organization Hierarchy 29-Jan-2020 051446.xlsx](https://www.enginatics.com/example/per-organization-hierarchy/) |
| Blitz Report™ XML Import | [PER_Organization_Hierarchy.xml](https://www.enginatics.com/xml/per-organization-hierarchy/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/per-organization-hierarchy/](https://www.enginatics.com/reports/per-organization-hierarchy/) |

## Case Study & Technical Analysis: PER Organization Hierarchy Report

### Executive Summary

The PER Organization Hierarchy report is a critical Human Resources master data report that provides a detailed, hierarchical listing of an organization's structure within Oracle HR. It displays the reporting relationships between organizations, including subordinate entities, allowing HR professionals, managers, and executives to visualize and analyze the company's structural framework. This report is indispensable for understanding reporting lines, supporting organizational design initiatives, and ensuring accurate HR data management for various HR functions like payroll, benefits, and talent management.

### Business Challenge

Understanding and maintaining an accurate organizational hierarchy is fundamental for effective HR and business operations. Organizations often face significant challenges in managing this complex structure within Oracle EBS:

-   **Visualizing Complex Structures:** Large enterprises have intricate organizational structures that are difficult to visualize and comprehend using standard Oracle forms, which typically show one organization at a time.
-   **Maintaining Data Accuracy:** Organizational changes (mergers, new departments, restructuring) are frequent. Ensuring that the HR system accurately reflects the current and historical hierarchies is a continuous and often manual challenge.
-   **Impact on Downstream Processes:** The organizational hierarchy impacts numerous HR and financial processes, including security, approvals, reporting, and payroll. Inaccurate hierarchies can lead to incorrect data visibility, approval bottlenecks, or misallocated costs.
-   **Reporting and Analysis:** Generating reports based on organizational structure (e.g., headcount by department, cost by business unit) is a common requirement, but often requires specialized reporting tools or manual data manipulation.

### The Solution

This report provides a clear, hierarchical, and easily auditable view of the organizational structure, directly addressing the complexities of managing enterprise hierarchies.

-   **Hierarchical Visualization:** It presents the organizational structure in a clear, indented format, making it easy to understand reporting lines and the relationships between parent and child organizations.
-   **Accurate Structural Data:** By extracting data directly from Oracle HR's core organization setup tables, the report provides a reliable source of truth for the current and historical organizational structure.
-   **Supports Strategic HR:** HR managers and executives can use this report for workforce planning, reorganizational design, and analyzing the impact of structural changes on staffing and costs.
-   **Enhanced Compliance and Audit:** The report serves as vital documentation for internal and external audits, demonstrating how the organization is structured for various compliance and operational purposes.

### Technical Architecture (High Level)

The report queries core Oracle HR tables that define organizational structures and their hierarchical relationships.

-   **Primary Tables Involved:**
    -   `per_organization_structures` (defines the overall organizational structure).
    -   `per_org_structure_versions` (stores different versions of an organizational structure, allowing for historical views).
    -   `per_org_structure_elements` (the critical table that defines the parent-child relationships between organizations within a hierarchy).
    -   `hr_all_organization_units_vl` (for the names and details of individual organizations).
    -   `per_business_groups` (for overall business group context).
-   **Logical Relationships:** The report begins by identifying a specific `Hierarchy Name` and its active `Version`. It then traverses the `per_org_structure_elements` table, starting from a `Top Level Organization`, to recursively build the hierarchy. For each organization in the hierarchy, it retrieves its details from `hr_all_organization_units_vl`.

### Parameters & Filtering

The report offers flexible parameters for targeted analysis of the organizational hierarchy:

-   **Business Group:** Filters the report to a specific legal entity or organizational grouping.
-   **Hierarchy Name:** Allows users to select a specific organizational hierarchy (e.g., 'Departmental Hierarchy', 'Legal Entity Hierarchy') if multiple structures are defined.
-   **Top Level Organization:** A crucial parameter that allows users to view the hierarchy starting from a specific parent organization down, rather than the entire enterprise structure. This is vital for managers focused on their specific span of control.

### Performance & Optimization

As a master data report dealing with hierarchical structures, it is optimized by its ability to limit the scope of the query.

-   **Hierarchy-Driven Retrieval:** The parameters `Hierarchy Name` and `Top Level Organization` are crucial for performance. By specifying a subset of the hierarchy, the database can efficiently traverse the `per_org_structure_elements` table to build the requested structure.
-   **Indexed Relationships:** The underlying tables are typically indexed on parent-child relationships (e.g., `organization_id_parent`, `organization_id_child`), allowing for quick traversal of the hierarchy.

### FAQ

**1. What is the difference between an 'Organization' and an 'Organization Hierarchy'?**
   An 'Organization' (e.g., "Sales Department," "Manufacturing Plant") is a distinct entity within Oracle HR. An 'Organization Hierarchy' is a defined structure that links these individual organizations together in a parent-child relationship, showing reporting lines or functional groupings across the enterprise.

**2. Can this report show all employees within each organization in the hierarchy?**
   This report focuses on the organizational structure itself. While related to employee data, it does not typically show individual employees within each organization. A separate report, possibly joining `PER Employee Assignments` with this hierarchy, would be needed for that level of detail.

**3. Why would an organization have multiple hierarchies?**
   Organizations may have multiple hierarchies for different purposes. For example, a company might have a 'Line Management Hierarchy' for reporting lines, a 'Legal Entity Hierarchy' for financial consolidation, and a 'Cost Center Hierarchy' for expense allocation. This report allows you to view any of these defined structures.


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

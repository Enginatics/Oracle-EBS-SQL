---
layout: default
title: 'PER Security Profiles | Oracle EBS SQL Report'
description: 'Security profiles and operating units that they give access to. – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, PER, Security, Profiles, hr_all_organization_units_vl, per_security_profiles, per_organization_list'
permalink: /PER%20Security%20Profiles/
---

# PER Security Profiles – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/per-security-profiles/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Security profiles and operating units that they give access to.

## Report Parameters
Security Profile

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [per_security_profiles](https://www.enginatics.com/library/?pg=1&find=per_security_profiles), [per_organization_list](https://www.enginatics.com/library/?pg=1&find=per_organization_list), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [FND Responsibility Access 11i](/FND%20Responsibility%20Access%2011i/ "FND Responsibility Access 11i Oracle EBS SQL Report"), [FND Responsibilities](/FND%20Responsibilities/ "FND Responsibilities Oracle EBS SQL Report"), [FND User Login History](/FND%20User%20Login%20History/ "FND User Login History Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PER Security Profiles 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/per-security-profiles/) |
| Blitz Report™ XML Import | [PER_Security_Profiles.xml](https://www.enginatics.com/xml/per-security-profiles/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/per-security-profiles/](https://www.enginatics.com/reports/per-security-profiles/) |

## Case Study & Technical Analysis: PER Security Profiles Report

### Executive Summary

The PER Security Profiles report is a crucial HR security and audit tool within Oracle E-Business Suite. It provides a comprehensive listing of all defined security profiles and, critically, details which operating units and organizations these profiles grant access to. This report is indispensable for HR system administrators, security officers, and auditors to manage and verify access to employee records, ensure compliance with data privacy regulations, and maintain a robust and auditable HR security framework.

### Business Challenge

Controlling who can view and manage employee data is a fundamental requirement for HR and a major challenge in a complex ERP environment. Organizations often struggle with:

-   **Granular Access Control:** Oracle HR allows for highly granular security down to individual employees, but understanding the cumulative effect of these settings is complex.
-   **Ensuring Data Privacy:** Compliance with data privacy laws (e.g., GDPR, CCPA) requires clear visibility into what employee data users can access. Misconfigured security can lead to unauthorized data exposure.
-   **Auditing Security Settings:** Regularly auditing HR security profiles to ensure they align with job roles and responsibilities is a critical but often manual and complex task.
-   **Troubleshooting Access Issues:** When users report that they cannot see certain employees or organizations, diagnosing the underlying security profile configuration is a key troubleshooting step. A consolidated report accelerates this process.

### The Solution

This report offers a clear, consolidated, and auditable view of security profile configurations, transforming how HR manages and verifies data access.

-   **Centralized Security Overview:** It presents a detailed list of all security profiles, showing precisely which operating units and organizations each profile allows access to. This provides a holistic understanding of the data access landscape.
-   **Enhanced Compliance Audits:** Security officers can use this report to quickly verify that security profiles are correctly configured, ensuring that sensitive employee data is protected and access is aligned with regulatory requirements and internal policies.
-   **Streamlined Access Review:** The report facilitates regular reviews of HR security, allowing administrators to identify and rectify any inappropriate or excessive data access, thereby mitigating security risks and improving data governance.
-   **Accelerated Troubleshooting:** When an HR user encounters access issues, this report provides immediate insight into the security profile assigned to their responsibility, helping to quickly pinpoint and resolve the problem.

### Technical Architecture (High Level)

The report queries Oracle HR's security definition tables and links them to the organizational structure.

-   **Primary Tables Involved:**
    -   `per_security_profiles` (the central table defining each security profile).
    -   `per_organization_list` (a table that often stores the organizations included in a security profile).
    -   `hr_operating_units` (for details of the operating units).
    -   `hr_all_organization_units_vl` (for the names and details of organizations).
-   **Logical Relationships:** The report selects all security profiles from `per_security_profiles`. It then determines the operating units and organizations that each profile grants access to, typically by querying `per_organization_list` or by analyzing the security profile's definition, and then joins to `hr_all_organization_units_vl` to display the user-friendly names of these organizations.

### Parameters & Filtering

The report includes a straightforward parameter for targeted analysis of security profiles:

-   **Security Profile:** Allows users to select a specific security profile to view its detailed access configuration. This is particularly useful when investigating a single profile or preparing for changes.

### Performance & Optimization

As a report focused on setup data, it is designed for rapid performance.

-   **Low Data Volume:** The underlying security profile and organizational definition tables contain a manageable number of rows, ensuring the query executes quickly.
-   **Indexed Joins:** The queries leverage standard Oracle indexes on `security_profile_id` and `organization_id` for efficient joins between the security and organizational tables.

### FAQ

**1. What is a 'Security Profile' in Oracle HR?**
   A Security Profile is a mechanism in Oracle HR that defines the population of employees or organizations that a user can access. When a security profile is assigned to a responsibility, any user logging in with that responsibility will only be able to view and process data for the employees or organizations included in that profile.

**2. How does this report help with managing data access for different HR roles?**
   Different HR roles (e.g., Payroll Administrator, Benefits Specialist, HR Generalist) require different levels of access. This report helps HR system administrators design and audit security profiles for each role, ensuring that users only see the data relevant to their job functions.

**3. Can this report also show which users are assigned to each security profile?**
   This report primarily focuses on the *definition* of the security profile itself (what data it grants access to). To see which *users* are assigned to each security profile, you would typically need a separate report that queries `fnd_user` and `fnd_responsibility_vl` and then links to the security profile assignments.


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

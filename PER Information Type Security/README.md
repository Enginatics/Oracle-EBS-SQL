---
layout: default
title: 'PER Information Type Security | Oracle EBS SQL Report'
description: ' – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, PER, Information, Type, Security, fnd_application_vl, fnd_responsibility_vl, per_info_type_security_v'
permalink: /PER%20Information%20Type%20Security/
---

# PER Information Type Security – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/per-information-type-security/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
None

## Report Parameters


## Oracle EBS Tables Used
[fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl), [per_info_type_security_v](https://www.enginatics.com/library/?pg=1&find=per_info_type_security_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [CAC Items Without This Level Material Overhead](/CAC%20Items%20Without%20This%20Level%20Material%20Overhead/ "CAC Items Without This Level Material Overhead Oracle EBS SQL Report"), [CAC Open Purchase Orders](/CAC%20Open%20Purchase%20Orders/ "CAC Open Purchase Orders Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PER Information Type Security 15-Jul-2022 011850.xlsx](https://www.enginatics.com/example/per-information-type-security/) |
| Blitz Report™ XML Import | [PER_Information_Type_Security.xml](https://www.enginatics.com/xml/per-information-type-security/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/per-information-type-security/](https://www.enginatics.com/reports/per-information-type-security/) |

## Case Study & Technical Analysis: PER Information Type Security Report

### Executive Summary

The PER Information Type Security report is a crucial audit and configuration tool for managing access to sensitive employee data within Oracle Human Resources (HR). It provides a comprehensive listing of how different "Information Types" (e.g., Personal Information, Salary, Medical) are secured by responsibility. This report is indispensable for HR system administrators, security officers, and auditors to ensure compliance with data privacy regulations, enforce internal access policies, and maintain the integrity of confidential employee information.

### Business Challenge

Protecting sensitive employee data is paramount for any organization. Oracle HR provides robust security mechanisms, but understanding and auditing these configurations can be complex:

-   **Data Privacy Compliance:** Regulations like GDPR, CCPA, or HIPAA require strict controls over who can access what employee information. Ensuring compliance in a complex ERP environment is a continuous challenge.
-   **Complex Access Controls:** Oracle HR's "Information Type Security" allows granular control over access to specific segments of data. However, the interplay of these settings with responsibilities can be intricate, making it difficult to visualize the overall security landscape.
-   **Auditing Security Configuration:** Regularly auditing who has access to which sensitive data is essential. Manually reviewing security profiles and responsibility assignments for information types is a time-consuming and error-prone process.
-   **Troubleshooting Access Issues:** When users report unexpected access (or lack thereof) to certain employee data, diagnosing the issue often requires a deep dive into the security setup. A consolidated report accelerates this troubleshooting.

### The Solution

This report offers a clear, consolidated, and auditable view of Information Type Security setups, transforming how organizations manage and verify HR data access.

-   **Centralized Security View:** It presents a detailed list of how various information types are secured across different Oracle applications and responsibilities. This provides a holistic understanding of data access permissions.
-   **Enhanced Compliance Audits:** Security officers can use this report to quickly verify that access to sensitive information types (e.g., medical records, salary details) is restricted to authorized personnel only, supporting regulatory compliance efforts.
-   **Streamlined Access Review:** The report facilitates regular reviews of user access, allowing administrators to identify and rectify any inappropriate or excessive data access, thereby reducing security risks.
-   **Accelerated Troubleshooting:** When a user cannot view a specific piece of employee data, this report provides immediate insight into whether the restriction is due to Information Type Security, speeding up problem diagnosis and resolution.

### Technical Architecture (High Level)

The report queries Oracle HR's security definition tables and links them to FND responsibilities and applications.

-   **Primary Tables/Views Involved:**
    -   `per_info_type_security_v` (a key view that consolidates information about how specific HR information types are secured).
    -   `fnd_responsibility_vl` (for the names and details of Oracle responsibilities).
    -   `fnd_application_vl` (for application names, providing context).
    -   This view likely draws from `hr_security_profiles` and other underlying HR security setup tables.
-   **Logical Relationships:** The report links the `per_info_type_security_v` (which details security rules for specific information types) to Oracle's `fnd_responsibility_vl` and `fnd_application_vl` tables. This allows it to show which responsibilities in which applications have specific access (read, write, or restricted) to different categories of HR information.

### Parameters & Filtering

The `README.md` indicates no specific parameters, suggesting this report provides a comprehensive dump of the security setup, or potentially uses context-based filtering from the `Business Group` a user is in.

-   **No Explicit Parameters:** The absence of listed parameters suggests that this report, by design, provides a complete listing of all information type security rules across the system accessible to the user's current `Business Group` or security profile. This can be advantageous for a full audit without the need for filtering.

### Performance & Optimization

As a report focused on setup data, it is designed for rapid performance.

-   **Low Data Volume:** The underlying security configuration tables contain a relatively small number of rows compared to transactional tables, ensuring the query executes quickly.
-   **Direct View Access:** The report directly queries optimized views like `per_info_type_security_v`, which are designed for efficient retrieval of security definitions.

### FAQ

**1. What is an "Information Type" in Oracle HR security?**
   An Information Type is a categorization of specific HR data (e.g., "National Identifiers," "Medical Information," "Salary Basis"). Oracle HR's security model allows administrators to control access to these specific types of information independently, ensuring granular data privacy.

**2. How does this report help prevent unauthorized access to sensitive employee data?**
   By providing a clear audit of which responsibilities have access to which information types, HR security officers can use this report to proactively identify any broad or unintended access. For example, if a standard HR user accidentally has access to "Medical Information," this report would highlight that potential exposure.

**3. If there are no parameters, how do I narrow down the data?**
   While the report itself may not have explicit parameters, its output is inherently filtered by the security profile and `Business Group` associated with the responsibility from which it is run. Therefore, if you need to see security settings for a specific part of the organization, you would run the report from a responsibility that has access to only that data.


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

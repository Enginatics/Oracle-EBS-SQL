---
layout: default
title: 'FND User Login History | Oracle EBS SQL Report'
description: 'Audit history of application user logins. EBS user logon audit is controlled by profile ''Sign-On:Audit Level''. The most detailed audit level setting is…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, FND, User, Login, History, per_security_profiles, hr_operating_units, per_organization_list'
permalink: /FND%20User%20Login%20History/
---

# FND User Login History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-user-login-history/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Audit history of application user logins.

EBS user logon audit is controlled by profile 'Sign-On:Audit Level'.
The most detailed audit level setting is 'FORM'.
Unfortunately, this audit tracks access to individual forms only, but not to different JSPs (HTML / OAF / ADF Pages).
As a workaround, the report SQL also joins to icx_sessions, which contains a record for each login (in fact, it also stores a record for each access to the login page before login. These records are marked with guest='Y').
The function retrieved from icx_session however, just shows the latest OAF function accessed by the user, not all individual JSP functions accessed within that session.

## Report Parameters
Responsibility Name, Form Name, User Name, Logged in within Days, Date From, Date To, Restrict to incremental data, Incremental Alert Mode, Exclude User Name, Include Geolocation

## Oracle EBS Tables Used
[per_security_profiles](https://www.enginatics.com/library/?pg=1&find=per_security_profiles), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [per_organization_list](https://www.enginatics.com/library/?pg=1&find=per_organization_list), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [per_all_assignments_f](https://www.enginatics.com/library/?pg=1&find=per_all_assignments_f), [fnd_profile_option_values](https://www.enginatics.com/library/?pg=1&find=fnd_profile_option_values), [fnd_logins](https://www.enginatics.com/library/?pg=1&find=fnd_logins), [fnd_login_responsibilities](https://www.enginatics.com/library/?pg=1&find=fnd_login_responsibilities), [fnd_login_resp_forms](https://www.enginatics.com/library/?pg=1&find=fnd_login_resp_forms), [fnd_form_vl](https://www.enginatics.com/library/?pg=1&find=fnd_form_vl), [fnd_appl_sessions](https://www.enginatics.com/library/?pg=1&find=fnd_appl_sessions), [icx_sessions](https://www.enginatics.com/library/?pg=1&find=icx_sessions), [fnd_nodes](https://www.enginatics.com/library/?pg=1&find=fnd_nodes), [fnd_form_functions_vl](https://www.enginatics.com/library/?pg=1&find=fnd_form_functions_vl), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl), [prof](https://www.enginatics.com/library/?pg=1&find=prof), [gv$session](https://www.enginatics.com/library/?pg=1&find=gv$session)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [FND Responsibility Access 11i](/FND%20Responsibility%20Access%2011i/ "FND Responsibility Access 11i Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND Responsibilities](/FND%20Responsibilities/ "FND Responsibilities Oracle EBS SQL Report"), [CAC Open Purchase Orders](/CAC%20Open%20Purchase%20Orders/ "CAC Open Purchase Orders Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND User Login History 24-Jul-2021 233519.xlsx](https://www.enginatics.com/example/fnd-user-login-history/) |
| Blitz Report™ XML Import | [FND_User_Login_History.xml](https://www.enginatics.com/xml/fnd-user-login-history/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-user-login-history/](https://www.enginatics.com/reports/fnd-user-login-history/) |

## FND User Login History - Case Study

### Executive Summary
The **FND User Login History** report is an essential security and auditing tool for Oracle E-Business Suite. It provides a detailed historical record of user access to the system, including login times, logout times, and the specific responsibilities accessed. This report is vital for IT security teams, auditors, and system administrators to ensure compliance with regulatory standards (such as SOX or GDPR), monitor user adoption, and investigate potential security breaches.

### Business Challenge
Tracking "who did what and when" is a fundamental requirement for enterprise systems. However, Oracle EBS login data is often scattered across multiple tables depending on the access method (Forms vs. Self-Service Web Applications).
*   **Compliance Gaps:** Auditors require proof of access controls and review of user activity.
*   **Security Monitoring:** Detecting unauthorized access attempts or unusual login patterns (e.g., logins during non-business hours) is difficult without consolidated data.
*   **License Management:** Organizations need to know which users are active to optimize license usage.

### Solution
The **FND User Login History** report bridges the gap between Forms-based and Web-based login auditing. It consolidates data from the underlying FND (Foundation) and ICX (Inter-Cartridge Exchange) tables to provide a unified view of user sessions.

**Key Features:**
*   **Unified Audit Trail:** Combines data for both Forms (Java Applet) and OAF (HTML) sessions.
*   **Detailed Metrics:** Includes User Name, Responsibility, Login Time, Logout Time, and IP Address (if captured).
*   **Flexible Filtering:** Allows searching by User, Date Range, Responsibility, or specific time windows.
*   **Session Context:** Can identify if a session was terminated normally or timed out.

### Technical Architecture
The report's logic handles the complexity of Oracle's dual-layer architecture (Forms vs. Web).

**Primary Tables:**
*   `fnd_logins`: Stores information about Forms-based logins. Populated based on the "Sign-On:Audit Level" profile option.
*   `icx_sessions`: Stores information about web-based sessions (OAF, HTML).
*   `fnd_user`: Master table for user definitions.
*   `fnd_responsibility_vl`: Master table for responsibility definitions.
*   `fnd_login_responsibilities`: Links logins to the specific responsibilities accessed during that session.

**Key Logic:**
*   **Audit Levels:** The report output depends heavily on the `Sign-On:Audit Level` profile option.
    *   *NONE:* No auditing.
    *   *USER:* Tracks logins only.
    *   *RESPONSIBILITY:* Tracks logins and responsibility selection.
    *   *FORM:* Tracks logins, responsibilities, and forms opened.
*   **Join Logic:** The query attempts to correlate `icx_sessions` with `fnd_logins` to present a complete picture of the user's journey from the web login page to the Forms interface.

### Frequently Asked Questions

**Q: Why are some logout times missing?**
A: If a user closes their browser without clicking "Logout," or if the session crashes, the logout time may not be recorded properly. The system eventually marks these as timed out, but the timestamp might be null or delayed.

**Q: Does this report show which specific records a user modified?**
A: No. This report tracks *access* (logins and responsibilities). To track record-level changes (inserts, updates), you need to use **FND Audit Trail** or **Database Auditing** features.

**Q: Why do I see records for the 'GUEST' user?**
A: The 'GUEST' user is used internally by Oracle EBS for anonymous access (like the initial login page). The report typically filters these out or identifies them separately, but they are a normal part of `icx_sessions`.

**Q: How far back does the history go?**
A: It depends on your system's purge policies. The "Purge Signon Audit Data" concurrent program is usually scheduled to remove old records to save space. The report can only show data that hasn't been purged.


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

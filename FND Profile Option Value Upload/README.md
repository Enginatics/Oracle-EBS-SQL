---
layout: default
last_modified_at: 2026-10-19
title: 'FND Profile Option Value Upload | Oracle EBS SQL Report'
description: 'Upload to create, update and delete profile option values on site, application, responsibility, server, operating unit and user level, as in the System…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Profile, Option, Value, fnd_profile_options_vl, fnd_profile_option_values, fnd_application_vl'
permalink: /FND%20Profile%20Option%20Value%20Upload/
report_name: 'FND Profile Option Value Upload'
report_web_name: fnd-profile-option-value-upload
---

# FND Profile Option Value Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-profile-option-value-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-option-value-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-option-value-upload).

## Overview
Upload to create, update and delete profile option values on site, application, responsibility, server, operating unit and user level, as in the System Profile Values form. Levels that the profile option definition does not allow to update are not offered.

The Value column shows and accepts the visible value of profile options validated by a list of values, e.g. a responsibility name instead of its id. Its list of values is derived from each profile option's SQL validation. A stored value is accepted as well. A few validations cannot be evaluated outside the profile form, e.g. because they depend on the responsibility being updated. These offer no list, save the value as entered and say so in the row message.

Clearing the Value of an existing row deletes the profile option value on that level.

The Server column is used only for profile options with the server and responsibility hierarchy, to set a value for a responsibility on a specific server.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-option-value-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Profile Option, Profile Option Code, Application, Level, Level Value

## Oracle EBS Tables Used
[fnd_profile_options_vl](https://www.enginatics.com/library/?pg=1&find=fnd_profile_options_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-option-value-upload), [fnd_profile_option_values](https://www.enginatics.com/library/?pg=1&find=fnd_profile_option_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-option-value-upload), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-option-value-upload), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-option-value-upload), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-option-value-upload), [fnd_nodes](https://www.enginatics.com/library/?pg=1&find=fnd_nodes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-option-value-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-option-value-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-option-value-upload)

## Related Reports
[FND Profile Option Values](/FND%20Profile%20Option%20Values/ "FND Profile Option Values Oracle EBS SQL Report"), [FND Debug and Trace Settings](/FND%20Debug%20and%20Trace%20Settings/ "FND Debug and Trace Settings Oracle EBS SQL Report"), [FND User Login History](/FND%20User%20Login%20History/ "FND User Login History Oracle EBS SQL Report"), [FND Responsibilities](/FND%20Responsibilities/ "FND Responsibilities Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [CAC Inventory Accounts Setup](/CAC%20Inventory%20Accounts%20Setup/ "CAC Inventory Accounts Setup Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Profile%20Option%20Value%20Upload/FND%20Profile%20Option%20Value%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-option-value-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/fnd-profile-option-value-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-option-value-upload) |
| Blitz Report™ XML Import | [FND_Profile_Option_Value_Upload.xml](https://www.enginatics.com/xml/fnd-profile-option-value-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-option-value-upload) |
| SQL Source | [FND Profile Option Value Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Profile%20Option%20Value%20Upload/FND%20Profile%20Option%20Value%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-profile-option-value-upload/](https://www.enginatics.com/reports/fnd-profile-option-value-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-option-value-upload) |

## Case Study & Technical Analysis: FND Profile Option Value Upload

### Executive Summary
This upload creates, updates and deletes profile option values at every level that Oracle E-Business Suite supports: site, application, responsibility, user, server and operating unit. It matches the System Profile Values form, so the same levels and validations apply. System administrators and EBS technical consultants use it to set or align configuration across environments, for example when a set of profile options must be reproduced in a new instance or when many responsibilities need the same value. The template runs in Excel through Blitz Report.

### Business Challenge
*   **Configuration at scale:** Profile options that control reporting, security and processing must be set consistently for many users, responsibilities and operating units.
*   **Level precision:** The same option can be set at several levels, and a value on the wrong level silently overrides or is overridden by another.
*   **Validated values:** Profile options that point to a responsibility, application or user must be entered with the correct visible name, not an internal id.
*   **Environment copies:** Moving configuration from one instance to another needs a repeatable, reviewable file rather than manual form entry.

### The Solution
*   **All supported levels:** Site, Application, Responsibility, User, Server and Operating Unit values are returned, and only the levels the option definition allows are offered.
*   **Visible values:** The Value column shows the name of the responsibility, application, user or operating unit rather than its id, and a stored value is also accepted.
*   **Delete by clearing:** Clearing the value of an existing row deletes the profile option value at that level.
*   **Server-specific settings:** The Server column applies only to profile options with the server and responsibility hierarchy, to set a value for a responsibility on one server.
*   **Row messages:** Validations that depend on the responsibility being updated cannot be evaluated in the file, so the value is saved as entered and the row message says so.

### Technical Architecture (High Level)
#### Primary Tables
*   `FND_PROFILE_OPTIONS_VL`: the profile option definitions, with user name, internal name and active dates.
*   `FND_PROFILE_OPTION_VALUES`: the stored values, with level id, level value and profile option value.
*   `FND_APPLICATION_VL`: the application names for application-level values and for responsibility applications.
*   `FND_RESPONSIBILITY_VL`: the responsibility names for responsibility and server-responsibility values.
*   `FND_USER`: the user names for user-level values.
*   `FND_NODES`: the server names for server and server-responsibility values.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit names for operating unit values.

#### Logical Relationships
1. `FND_PROFILE_OPTIONS_VL` joins to `FND_PROFILE_OPTION_VALUES` on application id and profile option id.
2. The level value is resolved according to the level id, which is decoded to Site, Application, Responsibility, User, Server, Operating Unit or Server-Responsibility.
3. For application levels, the level value joins to `FND_APPLICATION_VL`. For responsibility levels, it joins to `FND_RESPONSIBILITY_VL` on responsibility id and application id.
4. For user levels, it joins to `FND_USER`. For server levels, it joins to `FND_NODES` on node id, and for operating unit levels, to `HR_ALL_ORGANIZATION_UNITS_VL`.
5. The stored value is passed through the display function, which renders it in its visible form.

### Parameters & Filtering
*   **Upload Mode:** selects Create, or Create, Update to download existing values.
*   **Profile Option:** restricts the download to one profile option by its user name.
*   **Profile Option Code:** restricts the download to one profile option by its internal name.
*   **Application:** restricts the download to profile options of one application.
*   **Level:** restricts the download to one level.
*   **Level Value:** restricts the download to one responsibility, user, application or operating unit.

### Performance & Optimization
*   Only active profile option definitions are returned, using the start and end active dates, so retired options do not appear.
*   Level values are joined with decoded keys, so each value is looked up in only the table that its level requires.
*   The display function resolves stored values on demand, so the list of values is built per option rather than for every row.

### FAQ
**Q: How do I delete a profile option value?**
A: Clear the Value column on the existing row. The value is removed at that level.

**Q: Why does my row say the value was saved without validation?**
A: Some validations depend on the responsibility being updated and cannot be evaluated in the file. The value is saved as entered, and the row message says so.

**Q: How do I set a value for one server?**
A: Use the Server column with a profile option that has the server and responsibility hierarchy, and a responsibility level.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-option-value-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-option-value-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-option-value-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-option-value-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-option-value-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-option-value-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-option-value-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

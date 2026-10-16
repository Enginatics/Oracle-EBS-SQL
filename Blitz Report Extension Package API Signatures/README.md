---
layout: default
last_modified_at: 2026-10-16
title: 'Blitz Report Extension Package API Signatures | Oracle EBS SQL Report'
description: 'Shows this instance''s signatures of the Oracle EBS APIs that Blitz Report''s extension packages call: every argument of every procedure, with its position…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, Extension, Package, user_source, user_arguments'
permalink: /Blitz%20Report%20Extension%20Package%20API%20Signatures/
report_name: 'Blitz Report Extension Package API Signatures'
report_web_name: blitz-report-extension-package-api-signatures
module: 'Blitz Report'
module_url: /modules/blitz-report/
---

# Blitz Report Extension Package API Signatures – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-extension-package-api-signatures/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-extension-package-api-signatures) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-extension-package-api-signatures).
**Oracle EBS module:** [Blitz Report](/modules/blitz-report/ "Oracle EBS Blitz Report reports") · [all Blitz Report reports](/modules/blitz-report/)  

## Overview
Shows this instance's signatures of the Oracle EBS APIs that Blitz Report's extension packages call: every argument of every procedure, with its position, data type, in/out mode, whether it is defaulted, and the fields of any record argument.

Its purpose is comparison. An extension package that calls an EBS API by named parameters fails to compile where a patch level does not have that parameter (PLS-00306) or that record field (PLS-00302), the installer then drops the package, and its reports and uploads fail with PLS-00201 at runtime. Running this report here and on a working instance and comparing the two shows exactly which argument or field is absent.

Left empty, it reports every EBS API called by the extension packages installed here, and Referenced By names the calling package. That list is derived from the installed package source, so an extension package that failed to compile is not in it - name its API in the API Package Name parameter instead, which reports that package's full signature whether or not anything here calls it.

Types and constants declared in a package specification are not arguments and so do not appear here. Use the DBA Text Search report on the specification for those.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-extension-package-api-signatures) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
API Package Name, API Procedure Name, Argument Name

## Oracle EBS Tables Used
[user_source](https://www.enginatics.com/library/?pg=1&find=user_source&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-extension-package-api-signatures), [user_arguments](https://www.enginatics.com/library/?pg=1&find=user_arguments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-extension-package-api-signatures)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-extension-package-api-signatures)

## Related Reports
[FND Forms Personalizations](/FND%20Forms%20Personalizations/ "FND Forms Personalizations Oracle EBS SQL Report"), [CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report"), [AP Posted Invoice Register](/AP%20Posted%20Invoice%20Register/ "AP Posted Invoice Register Oracle EBS SQL Report"), [AP Posted Payment Register](/AP%20Posted%20Payment%20Register/ "AP Posted Payment Register Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Extension%20Package%20API%20Signatures/Blitz%20Report%20Extension%20Package%20API%20Signatures.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-extension-package-api-signatures) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Report Extension Package API Signatures 26-Aug-2026 022325.xlsx](https://www.enginatics.com/example/blitz-report-extension-package-api-signatures/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-extension-package-api-signatures) |
| Blitz Report™ XML Import | [Blitz_Report_Extension_Package_API_Signatures.xml](https://www.enginatics.com/xml/blitz-report-extension-package-api-signatures/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-extension-package-api-signatures) |
| SQL Source | [Blitz Report Extension Package API Signatures.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Extension%20Package%20API%20Signatures/Blitz%20Report%20Extension%20Package%20API%20Signatures.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/blitz-report-extension-package-api-signatures/](https://www.enginatics.com/reports/blitz-report-extension-package-api-signatures/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-extension-package-api-signatures) |

## Case Study & Technical Analysis: Blitz Report Extension Package API Signatures

### Executive Summary
The Blitz Report Extension Package API Signatures report shows the signature of every Oracle EBS API that Blitz Report™ extension packages call on the current instance. It lists each procedure argument with its position, data type, in or out mode, defaulted flag and, for record arguments, the fields of the record. Its main use is comparison. Support engineers and DBAs run it on a failing instance and on a working one, then compare the two to find the argument or record field that a patch level does not provide. The report is aimed at DBAs and technical administrators who maintain Blitz Report on Oracle EBS.

### Business Challenge
*   **Silent package loss:** When an extension package calls an EBS API by named parameter and that parameter or field is missing, the package fails to compile and the installer drops it.
*   **Delayed failure:** The reports and uploads that depend on the dropped package then fail at runtime with PLS-00201, which points away from the real cause.
*   **Patch-level differences:** Two instances at different EBS patch levels can expose different API signatures, so a fix on one may not transfer to another.
*   **Unclear calling dependencies:** It is not obvious which EBS APIs the extension packages depend on, or which package calls each one.

### The Solution
*   **Signature listing:** Every argument of every procedure is listed with its position, data type, mode, defaulted flag and type name.
*   **Record field expansion:** Record type arguments are shown with their nested fields, so a missing field can be identified by name.
*   **Caller attribution:** For APIs discovered from the installed source, the referencing extension packages are listed beside each API.
*   **Targeted lookup:** Naming a specific API package reports its full signature whether or not any installed package calls it, which covers packages that failed to compile.

### Technical Architecture (High Level)
#### Primary Tables
*   `USER_SOURCE`: the source text of the installed packages. The report searches it for qualified package and procedure references.
*   `USER_ARGUMENTS`: the argument definitions of the packages, with position, data level, type, mode and default flag.

#### Logical Relationships
1.  A discovery branch reads the source text of the installed `XXEN` package bodies from `USER_SOURCE`, skipping wrapped packages.
2.  A row generator expands each body into one candidate reference per qualified name match, and the regular expression extracts the package and object name from each match.
3.  The candidates are grouped by package and object, with the calling package names combined into one Referenced By value.
4.  The grouped APIs are joined to `USER_ARGUMENTS` on package and object name, so every argument of each called API is returned.
5.  When an API package name is supplied, a second branch returns `USER_ARGUMENTS` directly for that package, without the source search.
6.  The two branches are unioned and ordered by package, procedure, overload and argument sequence.

### Parameters & Filtering
*   **API Package Name:** When set, reports that package's full signature, whether or not any installed package calls it. This is the route for packages that failed to compile.
*   **API Procedure Name:** Limits the output to one procedure within the package.
*   **Argument Name:** Finds one argument by name across the selected APIs, which is the quickest way to check whether a parameter exists.

### Performance & Optimization
*   **Discovery only when needed:** The source search branch runs only when no API package name is given, so a targeted lookup avoids scanning all extension package source.
*   **Wrapped source excluded:** Packages whose source is wrapped are skipped, since their text cannot be searched.
*   **Regular expression row generation:** The source text is expanded into candidate matches with a row generator, so each package body is parsed once per match position rather than with procedural code.
*   **Grouped reference list:** Referencing packages are aggregated with a single grouped pass, so each called API appears once with its callers.

### FAQ
**Q: How do I check whether an EBS API parameter is missing on my instance?**
A: Enter the API Package Name and, if needed, the API Procedure Name or Argument Name, then compare the output with the same report run on a working instance.

**Q: Why does an extension package not appear in the list when it fails to compile?**
A: The discovery search reads installed package source, and a package that failed to compile is not in that list, so name its API in the API Package Name parameter instead.

**Q: Does this report list types and constants from package specifications?**
A: No. Only procedure arguments and record fields appear, so use the DBA Text Search report on the package specification for types and constants.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-extension-package-api-signatures)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-extension-package-api-signatures)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-extension-package-api-signatures)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-extension-package-api-signatures)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-extension-package-api-signatures)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-extension-package-api-signatures)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-extension-package-api-signatures)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

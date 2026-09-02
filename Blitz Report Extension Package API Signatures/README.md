---
layout: default
title: 'Blitz Report Extension Package API Signatures | Oracle EBS SQL Report'
description: 'Shows this instance''s signatures of the Oracle EBS APIs that Blitz Report''s extension packages call: every argument of every procedure, with its position…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, Extension, Package, user_source, table, user_arguments'
permalink: /Blitz%20Report%20Extension%20Package%20API%20Signatures/
---

# Blitz Report Extension Package API Signatures – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-extension-package-api-signatures/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Shows this instance's signatures of the Oracle EBS APIs that Blitz Report's extension packages call: every argument of every procedure, with its position, data type, in/out mode, whether it is defaulted, and the fields of any record argument.

Its purpose is comparison. An extension package that calls an EBS API by named parameters fails to compile where a patch level does not have that parameter (PLS-00306) or that record field (PLS-00302), the installer then drops the package, and its reports and uploads fail with PLS-00201 at runtime. Running this report here and on a working instance and comparing the two shows exactly which argument or field is absent.

Left empty, it reports every EBS API called by the extension packages installed here, and Referenced By names the calling package. That list is derived from the installed package source, so an extension package that failed to compile is not in it - name its API in the API Package Name parameter instead, which reports that package's full signature whether or not anything here calls it.

Types and constants declared in a package specification are not arguments and so do not appear here. Use the DBA Text Search report on the specification for those.

## Report Parameters
API Package Name, API Procedure Name, Argument Name

## Oracle EBS Tables Used
[user_source](https://www.enginatics.com/library/?pg=1&find=user_source), [table](https://www.enginatics.com/library/?pg=1&find=table), [user_arguments](https://www.enginatics.com/library/?pg=1&find=user_arguments)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Forms Personalizations](/FND%20Forms%20Personalizations/ "FND Forms Personalizations Oracle EBS SQL Report"), [AP Posted Invoice Register](/AP%20Posted%20Invoice%20Register/ "AP Posted Invoice Register Oracle EBS SQL Report"), [AP Posted Payment Register](/AP%20Posted%20Payment%20Register/ "AP Posted Payment Register Oracle EBS SQL Report"), [AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Report Extension Package API Signatures 26-Aug-2026 022325.xlsx](https://www.enginatics.com/example/blitz-report-extension-package-api-signatures/) |
| Blitz Report™ XML Import | [Blitz_Report_Extension_Package_API_Signatures.xml](https://www.enginatics.com/xml/blitz-report-extension-package-api-signatures/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-report-extension-package-api-signatures/](https://www.enginatics.com/reports/blitz-report-extension-package-api-signatures/) |



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

---
layout: default
title: 'FND Lookup Upload | Oracle EBS SQL Report'
description: 'This upload allows the user to - download and update lookup codes against existing Lookup Types. - add new lookup codes to existing Lookup Types. - create…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, FND, Lookup, fnd_lookup_types_vl, fnd_lookup_values_vl, fnd_application_vl'
permalink: /FND%20Lookup%20Upload/
---

# FND Lookup Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-lookup-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
This upload allows the user to
- download and update lookup codes against existing Lookup Types.
- add new lookup codes to existing Lookup Types.
- create new Lookup Types and upload the lookup codes against these new Lookup Types. 

The upload of FND Lookup Types and Lookup Codes is in the users current language.

Only User and Extensible Lookup Types can be maintained by this upload.
For Extensible Lookup Types, seeded Lookup Codes canot be updated.

For Creating/Updating Lookup Codes only against an existing Lookup Type, use template: 
Lookup Codes - Create/Update Lookup Codes only

For Creating New Lookup Types and/or updating Lookup Type level information, as well as the Lookup Codes, use  template:
Lookup Types - Create/Update Lookup Types and Codes

## Report Parameters
Mode, View Application, Lookup Type, Lookup Type Like, Owning Application

## Oracle EBS Tables Used
[fnd_lookup_types_vl](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_types_vl), [fnd_lookup_values_vl](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values_vl), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[GL Balance by Account Hierarchy](/GL%20Balance%20by%20Account%20Hierarchy/ "GL Balance by Account Hierarchy Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/fnd-lookup-upload/) |
| Blitz Report™ XML Import | [FND_Lookup_Upload.xml](https://www.enginatics.com/xml/fnd-lookup-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-lookup-upload/](https://www.enginatics.com/reports/fnd-lookup-upload/) |

## Executive Summary
The **FND Lookup Upload** report is a dual-purpose tool: it reports on existing Lookups and provides an Excel template to upload changes back to Oracle.

## Business Challenge
*   **Mass Updates:** Adding dozens of new codes to a custom lookup type without manual data entry.
*   **Migration:** Moving lookup configurations from Development to Test.
*   **Translation:** Updating descriptions for multiple languages.

## The Solution
This Blitz Report extracts the lookup definition in a format ready for upload:
*   **Type Definition:** Application, Code, and Description.
*   **Values:** The list of codes, meanings, and descriptions.
*   **Effectivity:** Enabled flag and Start/End dates.

## Technical Architecture
The report queries `FND_LOOKUP_TYPES_VL` and `FND_LOOKUP_VALUES_VL`. It is designed to work with the Blitz Report Upload framework (using the `FNDLOAD` or API mechanism).

## Parameters & Filtering
*   **Lookup Type:** Filter for the specific type you want to edit.
*   **Mode:** "Create/Update" options.

## Performance & Optimization
*   **Upload:** This report is primarily used as a download template for the "FND Lookup Upload" integration.

## FAQ
*   **Q: Can I update System lookups?**
    *   A: Generally no, System lookups are protected by Oracle. You can usually only update User or Extensible lookups.


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

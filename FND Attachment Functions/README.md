---
layout: default
title: 'FND Attachment Functions | Oracle EBS SQL Report'
description: 'FND attachment functions, their category assignments, forms blocks and block entities'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Attachment, Functions, fnd_attachment_functions, fnd_form_functions_vl, fnd_form_vl'
permalink: /FND%20Attachment%20Functions/
---

# FND Attachment Functions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-attachment-functions/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
FND attachment functions, their category assignments, forms blocks and block entities

## Report Parameters
Name, Form Name, Level

## Oracle EBS Tables Used
[fnd_attachment_functions](https://www.enginatics.com/library/?pg=1&find=fnd_attachment_functions), [fnd_form_functions_vl](https://www.enginatics.com/library/?pg=1&find=fnd_form_functions_vl), [fnd_form_vl](https://www.enginatics.com/library/?pg=1&find=fnd_form_vl), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl), [fnd_doc_category_usages](https://www.enginatics.com/library/?pg=1&find=fnd_doc_category_usages), [fnd_document_categories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_document_categories_vl), [fnd_attachment_blocks](https://www.enginatics.com/library/?pg=1&find=fnd_attachment_blocks), [fnd_attachment_blk_entities_vl](https://www.enginatics.com/library/?pg=1&find=fnd_attachment_blk_entities_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report"), [GL Journals (Drilldown)](/GL%20Journals%20%28Drilldown%29/ "GL Journals (Drilldown) Oracle EBS SQL Report"), [GL Journals](/GL%20Journals/ "GL Journals Oracle EBS SQL Report"), [GL Journals (Drilldown) 11g](/GL%20Journals%20%28Drilldown%29%2011g/ "GL Journals (Drilldown) 11g Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Attachment Functions 10-Jul-2018 190034.xlsx](https://www.enginatics.com/example/fnd-attachment-functions/) |
| Blitz Report™ XML Import | [FND_Attachment_Functions.xml](https://www.enginatics.com/xml/fnd-attachment-functions/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-attachment-functions/](https://www.enginatics.com/reports/fnd-attachment-functions/) |

## Executive Summary
The **FND Attachment Functions** report documents the configuration of the attachment feature within EBS forms. It details which attachment categories are available in which forms and at what block level.

## Business Challenge
*   **Customization Management:** Tracking where custom attachment categories have been enabled.
*   **Troubleshooting:** Understanding why a user cannot see the "Paperclip" icon or a specific document category in a form.
*   **Security:** Verifying that sensitive document categories are only exposed in appropriate functions.

## The Solution
This Blitz Report provides a technical map of attachment setups:
*   **Function Mapping:** Shows the relationship between the Form Function and the Attachment Function.
*   **Block Level Detail:** Specifies which block in the form (e.g., `ORDER_HEADERS`) triggers the attachment capability.
*   **Category Usage:** Lists which document categories (e.g., "Misc", "Internal") are assigned to the function.

## Technical Architecture
The report queries `FND_ATTACHMENT_FUNCTIONS`, `FND_ATTACHMENT_BLOCKS`, and `FND_DOC_CATEGORY_USAGES`. It joins with `FND_FORM_FUNCTIONS` to provide the user-friendly function names.

## Parameters & Filtering
*   **Function/Form Name:** To check setup for a specific screen.
*   **Level:** Filter by Site, Application, or Responsibility level assignments.

## Performance & Optimization
*   **Low Impact:** This is a configuration report against small metadata tables; performance is generally instant.

## FAQ
*   **Q: How do I enable attachments on a new form?**
    *   A: You must define the Attachment Function and Block in the "Attachment Functions" setup form. This report validates that setup.
*   **Q: What is the "Primary Key" setup?**
    *   A: The report shows which fields (e.g., `HEADER_ID`) are used as the primary key to link the attachment to the record.


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

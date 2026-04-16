---
layout: default
title: 'QP Modifier Upload | Oracle EBS SQL Report'
description: 'This upload supports the creation and update of Modifiers in Oracle Advanced Pricing. The upload supports creation/update/deletion of the following…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Modifier, qp_secu_list_headers_vl, qp_qualifiers_v'
permalink: /QP%20Modifier%20Upload/
---

# QP Modifier Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qp-modifier-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
This upload supports the creation and update of Modifiers in Oracle Advanced Pricing.

The upload supports creation/update/deletion of the following entities within a Modifier List:

- Modifier List Qualifiers
- Modifier List Limits
- Modifier Lines
- Modifier Line Price Breaks. To enter the Modifier Price Breaks in the upload, repeat the Modifier Price Break Header Line and enter/adjust the Price Break Columns for each Price Break.
- Modifier Line Additional Buy Items.
- Modifier Line Get Items
- Modifier Line Pricing Attributes
- Modifier Line Qualifiers
- Modifier Line Limits

Notes:

When downloading existing Modifier data into the upload excel:
  - Modifier List level Qualifiers and Limits will be downloaded into separate rows in the excel
  - Modifier Line level Price Breaks, Additional Buy Items, Get Items, Pricing Attributes, Qualifiers, and Limits will be downloaded into separate rows in the excel

This is to minimize the duplication of data in the excel.  

However:
When entering List Header qualifiers and limits, these can be added in the same excel row.
When entering Modifier Lines for upload:  Price Breaks, Additional Buy Items, Get Items, Pricing Attributes, Line Qualifiers, and Limits can be added in the same excel row. 
i.e. You can upload an excel row containing a modifier line details with associated price break and pricing attribute and qualifier etc. 

Modifier Line Numbering
====================
The Modifier Numbering parameter determines if you want the system to automatically generate Modifier Numbers when creating new Modifiers or if the line number specified in the Line No column in the upload should be retained. If Automatic is specified, any Line Numbers specified in the upload excel for new modifier lines will be replaced by a system generated line number on upload.
The Line No column is required when entering modifier line details. The upload uses the combination of List Number, List Version, and Modifier Line No to identify the modifiers. If the combination already exists in Oracle the upload will update the existing modifier, otherwise it will create a new modifier.

Entering Qualifiers
===============
Qualifiers entered on a row with no modifier line details will be uploaded as a list level qualifier. 
Qualifiers entered on a row containing modifier line details will by default be uploaded as a modifier level qualifier. The Qualifier Assignment Level column can be used to override this default behaviour to assign the qualifier to the list header instead of the modifier. 
Qualifier Groups can be copied to the modifier by selecting the Qualifier Group and leaving all other qualifier columns blank. The upload will copy and attach all the qualifier group's qualifiers to the price list.
Alternatively, you can select specific qualifiers from a Qualifier Group by selecting the Qualifier Group and the Qualifier Group Qualifier ID. The upload excel will then default in the details of that qualifier into the excel. In this scenario you would enter each qualifier on a separate row in the excel. 

Entering Limits
===============
Limits entered on a row with no modifier line details will be uploaded as a list level limit. 
Limits entered on a row containing modifier line details will by default be uploaded as a line level limit. The Limit Assignment Level column can be used to override this default behaviour to assign the limit to the list header instead of the modifier Line. 
Limit No is required when entering limit details. The upload uses the combination of List Number, List Version, Modifier Line No (for modifier level limits), and the Limit No to identify the limit. If the combination already exists in Oracle the upload will update the existing limit, otherwise it will create a new modifier.



## Report Parameters
Upload Mode, End Date Matching Modifiers?, Modifier Numbering, List Type, List Number, List Number Like, List Name, List Name Like, Version Number, Global List, Operating Unit, Modifier Line Type, Product Attribute Context, Product Attribute, Product Value (Item/Item Cat), Product Value (Other), Item Category Set, Item Category, Effective Date, Download Modifier Lines, Download Price Breaks, Download Buy/Get Products, Download Pricing Attributes, Download Excluders, Download List Qualifiers, Download Line Qualifiers, Download List Limits, Download Line Limits

## Oracle EBS Tables Used
[qp_secu_list_headers_vl](https://www.enginatics.com/library/?pg=1&find=qp_secu_list_headers_vl), [qp_qualifiers_v](https://www.enginatics.com/library/?pg=1&find=qp_qualifiers_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/qp-modifier-upload/) |
| Blitz Report™ XML Import | [QP_Modifier_Upload.xml](https://www.enginatics.com/xml/qp-modifier-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/qp-modifier-upload/](https://www.enginatics.com/reports/qp-modifier-upload/) |

## Case Study & Technical Analysis: QP Modifier Upload Report

### Executive Summary

The QP Modifier Upload is a powerful data management tool designed to streamline the creation, update, and deletion of pricing modifiers within Oracle Advanced Pricing. This comprehensive utility supports the bulk management of modifier lists, their associated qualifiers, limits, lines, price breaks, additional buy/get items, and pricing attributes through a flexible Excel-based interface. It is essential for pricing analysts and system configurators to efficiently implement complex pricing strategies, ensure data accuracy and consistency, and rapidly adapt to market changes or new promotional campaigns, significantly reducing manual effort and potential errors.

### Business Challenge

Oracle Advanced Pricing modifiers are highly configurable, enabling sophisticated pricing strategies. However, the manual setup and maintenance of these complex rules can be a significant operational bottleneck:

-   **Time-Consuming Manual Setup:** Manually creating or updating numerous modifier lists, their lines, various qualifiers, price breaks, and limits through Oracle forms is a slow, repetitive, and resource-intensive process, especially for large-scale promotions or price changes.
-   **High Risk of Data Entry Errors:** The intricacy of modifier definitions makes manual entry highly susceptible to errors in conditions, amounts, or dates, leading to incorrect pricing on sales orders, margin erosion, and customer disputes.
-   **Complex Mass Updates:** Applying consistent changes across many modifiers (e.g., updating a discount percentage across a product range, modifying a qualifier for a customer segment) is extremely cumbersome without a mass-upload capability.
-   **Ensuring Pricing Consistency:** Maintaining consistent pricing rules and promotions across different product lines, customer segments, or sales channels is challenging without an efficient tool for bulk configuration management.

### The Solution

This comprehensive Excel-based upload tool transforms the management of pricing modifiers, making it efficient, accurate, and scalable.

-   **Bulk Creation, Update, and Deletion:** It enables the mass creation of new modifiers, efficient updates to existing rules, and targeted deletion of modifier components (qualifiers, limits, lines, etc.) in a single operation, directly from a spreadsheet.
-   **Integrated Modifier Management:** The upload supports all aspects of modifier definition: header-level qualifiers and limits, individual modifier lines, line-level qualifiers and limits, price breaks, additional buy items, get items, and pricing attributes, providing a holistic management solution.
-   **Flexible Data Entry Options:** The tool offers specific guidance for entering qualifiers and limits, allowing them to be assigned at either the list or line level, and even supports copying entire `Qualifier Groups`.
-   **Improved Data Accuracy and Efficiency:** By allowing data preparation in Excel, users can leverage spreadsheet validation features before uploading, drastically reducing data entry errors and accelerating modifier maintenance processes, crucial for rapid response to market conditions.

### Technical Architecture (High Level)

The upload process leverages Oracle Advanced Pricing's standard APIs for modifier management, ensuring robust data validation and integrity.

-   **Primary Tables/Views Involved:**
    -   `qp_secu_list_headers_vl` (the central view for pricing list headers, including modifiers).
    -   `qp_list_lines` (for individual lines within a modifier).
    -   `qp_qualifiers_v` (for qualifier definitions).
    -   `qp_modifier_summary_v` (a view often used for high-level modifier information).
    -   Underlying QP tables for price breaks, pricing attributes, and limits (`qp_price_breaks`, `qp_pricing_attributes`, `qp_limits`).
-   **Logical Relationships:** The tool takes an Excel file, validates the modifier data against relevant master data tables and existing QP configurations, and then utilizes Oracle APIs to perform the requested operations (insert, update, delete) on the `qp_list_headers`, `qp_list_lines`, and associated tables for qualifiers, limits, price breaks, and attributes. The `Upload Mode` dictates the type of operation, and the tool provides logic for automatic `Modifier Line Numbering` if chosen.

### Parameters & Filtering

The upload parameters provide granular control over the data operation:

-   **Upload Mode:** The key parameter determining the action: 'Create', 'Update', or 'Create and Update'.
-   **Modifier Numbering:** Controls whether the system automatically generates line numbers for new modifier lines or retains user-specified numbers.
-   **List Identification:** `List Type` (e.g., 'Discount', 'Promotion'), `List Number`, `List Name` (with 'Like' options), `Version Number`, `Global List`, `Operating Unit` allow for precise targeting of modifier lists for download and update.
-   **Modifier Line Filters:** `Modifier Line Type`, `Product Attribute Context`, `Product Attribute`, `Product Value`, `Item Category Set`, `Item Category`, `Effective Date` allow for filtering specific lines.
-   **Download Flags:** Numerous `Download` parameters (`Download Modifier Lines`, `Download Price Breaks`, etc.) are crucial for populating the Excel template with existing data before making updates.

### Performance & Optimization

Using an API-based upload for complex pricing modifier data is inherently more efficient than manual entry.

-   **Bulk Processing via APIs:** The tool processes modifier headers, lines, qualifiers, and other components in batches, leveraging Oracle's standard Advanced Pricing APIs which are designed for high-volume, efficient master data loading.
-   **API Validation and Specific Rules:** By utilizing Oracle's own APIs, the tool benefits from built-in, efficient validation logic that ensures data integrity. The `README.md` details specific rules for qualifier and limit entry (e.g., assignment levels, copying groups), which are handled by the underlying API logic.
-   **Efficient Download for Update:** The ability to download existing modifier data into the Excel template, with separate rows for different components, simplifies the update process by providing a clear and organized starting point for modifications.

### FAQ

**1. What is the benefit of uploading modifiers rather than creating them manually?**
   The primary benefit is speed and accuracy. For complex promotions involving many items, customer segments, or conditions, manual creation is extremely time-consuming and error-prone. The upload tool automates this, ensuring that large-scale pricing changes or new promotions can be rolled out quickly and correctly.

**2. How does the upload handle different levels of qualifiers (list vs. line)?**
   The tool allows qualifiers to be assigned at either the `Modifier List` (header) level or the `Modifier Line` level. Qualifiers at the list level apply to all lines within that modifier, while line-level qualifiers apply only to that specific line. The upload template provides fields to specify this `Qualifier Assignment Level`.

**3. Is it possible to use this tool to manage promotional pricing, like "Buy One Get One Free" offers?**
   Yes, the upload supports `Modifier Line Additional Buy Items` and `Modifier Line Get Items`, which are key components for configuring "Buy One Get X Free" or similar promotional offers. This makes the tool highly valuable for managing complex promotional pricing strategies in bulk.


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

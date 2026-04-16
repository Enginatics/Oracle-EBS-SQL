---
layout: default
title: 'QP Price List Upload | Oracle EBS SQL Report'
description: 'This upload supports the creation and update of Standard Price Lists in Oracle Advanced Pricing. The upload supports creation/update/deletion of the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Price, List, qp_currency_lists_vl, ra_terms_tl, qp_secu_list_headers_vl'
permalink: /QP%20Price%20List%20Upload/
---

# QP Price List Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qp-price-list-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
This upload supports the creation and update of Standard Price Lists in Oracle Advanced Pricing.

The upload supports creation/update/deletion of the following entities within the Price List:

- Price List Lines

'End Date Matching List Lines?'
When creating new Price List Lines, the upload can automatically end date any existing matching active price list line by setting the report parameter 'End Date Matching List Lines?' to Yes. 
Set this parameter to Yes to automatically end date any active matching price list line on upload. 
Any price list lines downloaded when this parameter is set to yes will have the Action field automatically set to ’Create’ to indicate a new Price List Line should be created instead off the existing price list line being updated. This allows the user to use the downloaded (current) price list lines as a basis for creating the new price list lines.  

- Price Breaks

To enter the Price Breaks in the upload, repeat the Price Break Header Line and enter/adjust the Price Break Columns for each Price Break.

- Price List Line Pricing Attributes

By default, the upload will treat all rows with the same Product, Unit of Measure, and Start Date as the same Price List Line.

If you have different Price List Lines that use the same Product, Unit of Measure and Start Date but which have different Pricing Attribute assignments, the use the ‘Line No’ column to distinguish the different Price List Lines. If not specified, then all rows with the same Product, Unit of Measure, and Start Date will be uploaded as a single Price List Line and any Pricing Attributes will be added to that Price List Line. 

The Line Number entered here is not uploaded to Oracle. It is only used by the upload to distinguish different lines with the same product, Unit of Measure, and Start date.

- Price Lists Qualifiers

Qualifier Groups can be copied to the Price List by selecting the Qualifier Group and leaving all other qualifier columns blank. The upload will copy and attach all the qualifier group's qualifiers to the price list.
Alternatively, you can select specific qualifiers from a Qualifier Group by selecting the Qualifier Group and the Qualifier Group Qualifier ID. The upload excel will then default in the details of that qualifier into the excel. In this scenario you would enter each qualifier on  a separate row in the excel. 

- Secondary Price Lists

Note:
When downloading existing Price List data into the upload excel:
  - Header level Qualifiers and Secondary Price Lists will be downloaded into separate rows in the excel
  - Line level Price Breaks and Pricing Attributes will be downloaded into separate rows in the excel

This is to minimize the duplication of data in the excel. However, when entering data for upload Qualifiers, Secondary Price Lists, Price Breaks, and Pricing Attributes can be added in the same excel row.
i.e. You can upload an excel row containing a header level qualifier, header level secondary price list, price list line details with associated price break and pricing attribute. 





## Report Parameters
Upload Mode, End Date Matching List Lines?, Price List, Price List Like, Product Attribute, Product Value (Item/Item Cat), Product Value (Other), Item Category Set, Item Category, Effective Date, Effective Date From, Effective Date To, Download Price List Lines, Line Type, Download Pricing Attributes, Download Qualifiers, Download Secondary Price Lists

## Oracle EBS Tables Used
[qp_currency_lists_vl](https://www.enginatics.com/library/?pg=1&find=qp_currency_lists_vl), [ra_terms_tl](https://www.enginatics.com/library/?pg=1&find=ra_terms_tl), [qp_secu_list_headers_vl](https://www.enginatics.com/library/?pg=1&find=qp_secu_list_headers_vl), [qp_qualifiers_v](https://www.enginatics.com/library/?pg=1&find=qp_qualifiers_v), [qp_list_lines_v](https://www.enginatics.com/library/?pg=1&find=qp_list_lines_v), [mtl_system_items](https://www.enginatics.com/library/?pg=1&find=mtl_system_items)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/qp-price-list-upload/) |
| Blitz Report™ XML Import | [QP_Price_List_Upload.xml](https://www.enginatics.com/xml/qp-price-list-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/qp-price-list-upload/](https://www.enginatics.com/reports/qp-price-list-upload/) |

## Case Study & Technical Analysis: QP Price List Upload Report

### Executive Summary

The QP Price List Upload is a powerful data management tool designed to streamline the creation and update of standard price lists within Oracle Advanced Pricing. This comprehensive utility supports the bulk management of price list lines, their associated price breaks, pricing attributes, qualifiers, and secondary price lists through a flexible Excel-based interface. It is essential for pricing analysts and system configurators to efficiently implement complex pricing strategies, ensure data accuracy and consistency across products and services, and rapidly adapt to market changes, significantly reducing manual effort and potential pricing errors.

### Business Challenge

Oracle Advanced Pricing enables organizations to define intricate pricing structures, but the manual setup and maintenance of these price lists can be a significant operational bottleneck:

-   **Time-Consuming Manual Setup:** Manually creating or updating numerous price list lines, their quantities (price breaks), and various pricing attributes through Oracle forms is a slow, repetitive, and resource-intensive process, especially for large product catalogs or seasonal price changes.
-   **High Risk of Pricing Errors:** The complexity of price list definitions makes manual entry highly susceptible to errors in unit prices, dates, or item assignments, leading to incorrect invoicing, margin erosion, and customer dissatisfaction.
-   **Inefficient Mass Updates:** Applying consistent changes across many price list lines (e.g., updating prices for a product category, adjusting price breaks) is extremely cumbersome without a mass-upload capability.
-   **Ensuring Pricing Consistency:** Maintaining consistent and accurate pricing across different products, customer segments, or sales channels is challenging without an efficient tool for bulk configuration management.
-   **Managing Date-Effective Pricing:** Price lists and their lines are often date-effective. Manually managing effective start and end dates, especially for new prices that supersede old ones, is prone to error and can lead to pricing discrepancies.

### The Solution

This comprehensive Excel-based upload tool transforms the management of pricing price lists, making it efficient, accurate, and scalable.

-   **Bulk Creation and Update:** It enables the mass creation of new price list lines, efficient updates to existing prices (including price breaks and attributes), and even the automatic end-dating of old lines in a single operation, directly from a spreadsheet.
-   **Integrated Price List Management:** The upload supports all key aspects of price list definition: core price list lines, price breaks (quantity-based pricing), pricing attributes, qualifiers, and secondary price list assignments, providing a holistic management solution.
-   **Automated Date-Effective Management:** The `End Date Matching List Lines?` parameter is a critical feature that automatically end-dates existing active price list lines when a new matching line is uploaded, ensuring smooth transitions between prices without manual intervention.
-   **Flexible Data Entry Options:** The tool offers specific guidance for entering price breaks and qualifiers, allowing them to be assigned at the list or line level, and even supports copying entire `Qualifier Groups`.
-   **Improved Data Accuracy and Efficiency:** By allowing data preparation in Excel, users can leverage spreadsheet validation features before uploading, drastically reducing data entry errors and accelerating price list maintenance processes, crucial for rapid response to market conditions.

### Technical Architecture (High Level)

The upload process leverages Oracle Advanced Pricing's standard APIs for price list management, ensuring robust data validation and integrity.

-   **Primary Tables/Views Involved:**
    -   `qp_secu_list_headers_vl` (the central view for pricing list headers, including price lists).
    -   `qp_list_lines_v` (for individual lines within a price list, defining the item and its base price).
    -   `mtl_system_items` (for item master details).
    -   `qp_currency_lists_vl` (for currency-specific price list setups).
    -   `qp_qualifiers_v` (for qualifier definitions).
    -   Underlying QP tables for price breaks (`qp_price_breaks`) and pricing attributes (`qp_pricing_attributes`).
-   **Logical Relationships:** The tool takes an Excel file, validates the price list data against relevant master data tables and existing QP configurations, and then utilizes Oracle APIs to perform the requested operations (insert, update) on the `qp_list_headers`, `qp_list_lines`, and associated tables for price breaks, pricing attributes, qualifiers, and secondary price lists. The `Upload Mode` dictates the type of operation, and the `End Date Matching List Lines?` parameter enables automatic date-effective management.

### Parameters & Filtering

The upload parameters provide granular control over the data operation:

-   **Upload Mode:** The key parameter determining the action: 'Create' or 'Update'.
-   **End Date Matching List Lines?:** A critical parameter for managing date-effective pricing by automatically expiring old price list lines.
-   **Price List Identification:** `Price List`, `Price List Like`, `Product Attribute Context`, `Product Attribute`, `Product Value`, `Item Category Set`, `Item Category` allow for precise targeting of price lists and lines for download and update.
-   **Effective Date Filters:** `Effective Date`, `Effective Date From`, `Effective Date To` are crucial for managing date-effective pricing data.
-   **Download Flags:** Numerous `Download` parameters (`Download Price List Lines`, `Download Pricing Attributes`, `Download Qualifiers`, `Download Secondary Price Lists`) are essential for populating the Excel template with existing data before making updates.

### Performance & Optimization

Using an API-based upload for complex pricing list data is inherently more efficient than manual entry.

-   **Bulk Processing via APIs:** The tool processes price list headers, lines, price breaks, and other components in batches, leveraging Oracle's standard Advanced Pricing APIs which are designed for high-volume, efficient master data loading.
-   **API Validation and Date-Effective Logic:** By utilizing Oracle's own APIs, the tool benefits from built-in, efficient validation logic and date-effective processing, ensuring data integrity and correct pricing transitions.
-   **Efficient Download for Update:** The ability to download existing price list data into the Excel template, with separate rows for different components, simplifies the update process by providing a clear and organized starting point for modifications.

### FAQ

**1. What is the benefit of using the 'End Date Matching List Lines?' parameter?**
   This parameter is crucial for managing date-effective price changes. When a new price for an item is uploaded with a new effective start date, setting this parameter to 'Yes' ensures that the previously active price for that item is automatically end-dated, preventing overlapping prices and ensuring that only the correct, current price is active at any given time.

**2. How does the upload handle items with the same product, UOM, and start date but different pricing attributes?**
   As noted in the `README.md`, if you have such scenarios, you must use the `Line No` column in the Excel template to explicitly distinguish between these different price list lines. If `Line No` is not specified, the upload will treat them as the same line and consolidate their pricing attributes.

**3. Can this tool be used to manage promotional pricing (e.g., discounts, surcharges)?**
   This specific tool focuses on standard price lists. While price lists are foundational for pricing, promotional pricing (discounts, surcharges, buy/get offers) is typically managed through 'Modifiers' in Oracle Advanced Pricing. A separate upload tool (like the `QP Modifier Upload` report) would be used for those specific configurations.


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

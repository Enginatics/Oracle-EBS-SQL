---
layout: default
title: 'AP Supplier Upload | Oracle EBS SQL Report'
description: 'This upload can be used to create and/or update Suppliers, Supplier Sites, Supplier Bank Accounts, and Supplier Contacts'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Supplier, per_employees_x, per_business_groups_perf, fnd_territories_vl'
permalink: /AP%20Supplier%20Upload/
---

# AP Supplier Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-supplier-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
This upload can be used to create and/or update Suppliers, Supplier Sites, Supplier Bank Accounts, and Supplier Contacts

## Report Parameters
Upload Mode, Supplier Type, Exclude Employee Suppliers, Supplier Name, Supplier Name From, Supplier Name To, Supplier Number, Supplier Number From, Supplier Number To, Payment Method, Tax Registration Number, Supplier Site, Supplier/Site Status, Bank Account Status, Contact Status, Update Supplier Bank Accounts, Update Supplier Sites, Update Site Bank Accounts, Update Site Contacts, Default Site Bank Acct Assign Lvl, Default Tax Rounding Rule, Default Inclusive Tax, Default Allow Offset Taxes, Default Pay Each Document Alone

## Oracle EBS Tables Used
[per_employees_x](https://www.enginatics.com/library/?pg=1&find=per_employees_x), [per_business_groups_perf](https://www.enginatics.com/library/?pg=1&find=per_business_groups_perf), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl), [rcv_routing_headers](https://www.enginatics.com/library/?pg=1&find=rcv_routing_headers), [ap_terms_vl](https://www.enginatics.com/library/?pg=1&find=ap_terms_vl), [ap_awt_groups](https://www.enginatics.com/library/?pg=1&find=ap_awt_groups), [iby_ext_party_pmt_mthds](https://www.enginatics.com/library/?pg=1&find=iby_ext_party_pmt_mthds), [iby_payment_methods_vl](https://www.enginatics.com/library/?pg=1&find=iby_payment_methods_vl), [iby_payment_reasons_vl](https://www.enginatics.com/library/?pg=1&find=iby_payment_reasons_vl), [iby_formats_vl](https://www.enginatics.com/library/?pg=1&find=iby_formats_vl), [iby_delivery_channels_vl](https://www.enginatics.com/library/?pg=1&find=iby_delivery_channels_vl), [iby_bank_instructions_vl](https://www.enginatics.com/library/?pg=1&find=iby_bank_instructions_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ap-supplier-upload/) |
| Blitz Report™ XML Import | [AP_Supplier_Upload.xml](https://www.enginatics.com/xml/ap-supplier-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ap-supplier-upload/](https://www.enginatics.com/reports/ap-supplier-upload/) |

## Case Study & Technical Analysis: AP Supplier Upload

### Executive Summary
The **AP Supplier Upload** is a powerful data management utility designed to streamline the maintenance of the Supplier Master in Oracle Payables. It facilitates the bulk creation and update of Suppliers, Supplier Sites, Contacts, and Bank Accounts. By automating these tasks, organizations can significantly reduce the administrative burden of vendor management, ensure data consistency across operating units, and accelerate supplier onboarding processes.

### Business Challenge
Managing a large vendor base presents several operational hurdles:
*   **Manual Data Entry:** Creating suppliers one by one is slow and prone to typographical errors (e.g., wrong tax IDs, misspelled names).
*   **Mass Updates:** Updating payment terms or bank accounts for thousands of suppliers due to a policy change or bank merger is manually infeasible.
*   **Data Integrity:** Inconsistent data entry standards across different users can lead to duplicate suppliers and reporting errors.
*   **Migration & Integration:** Loading legacy supplier data during system implementations or acquisitions requires a robust, repeatable tool.

### The Solution: Operational View
The **AP Supplier Upload** serves as a bridge between external data sources (like Excel spreadsheets) and the Oracle EBS Supplier Master.
*   **Bulk Processing:** Enables the upload of thousands of supplier records in a single run, saving days of manual work.
*   **Comprehensive Scope:** Handles the full hierarchy of supplier data: Header (Supplier), Sites (Address & Operating Unit specific), Contacts, and Banking details.
*   **Validation:** Ensures that uploaded data adheres to Oracle's strict validation rules (e.g., unique Tax Registration Numbers, valid Payment Methods) before committing changes.
*   **Update Capability:** Unlike standard interface programs that often only support creation, this tool allows for the *update* of existing records, making it ideal for data cleansing initiatives.

### Technical Architecture (High Level)
The solution utilizes Oracle's public APIs and interface tables to ensure data integrity and validation.

*   **Primary Tables:**
    *   `AP_SUPPLIERS` (formerly `PO_VENDORS`): Stores the supplier header information.
    *   `AP_SUPPLIER_SITES_ALL` (formerly `PO_VENDOR_SITES_ALL`): Stores address and operating unit-specific site details.
    *   `IBY_EXT_BANK_ACCOUNTS`: Stores external bank account information (R12 Payments model).
    *   `IBY_PMT_INSTR_USES_ALL`: Links bank accounts to suppliers or sites.
    *   `AP_SUPPLIER_CONTACTS`: Stores contact information.

*   **Logical Relationships:**
    *   The tool typically accepts a flat file or Excel input which maps to the supplier hierarchy.
    *   It first checks for the existence of the **Supplier**. If not found, it creates it.
    *   It then processes **Supplier Sites**, linking them to the parent Supplier and the specified **Operating Unit**.
    *   **Bank Accounts** are created in the Payments (IBY) module and assigned to the Supplier or Site level based on the parameters.
    *   **Contacts** are linked to the specific Supplier Site.

### Parameters & Filtering
The tool offers flexible parameters to control the scope of the upload and update:
*   **Upload Mode:** Determines if the run is for creating new records, updating existing ones, or both.
*   **Operating Unit:** Specifies the target OU for Supplier Sites.
*   **Update Flags (Update Supplier Bank Accounts, Update Supplier Sites, etc.):** Boolean flags that give granular control over which parts of the supplier record should be modified, preventing unintended overwrites.
*   **Supplier Name/Number From/To:** Allows for processing a specific subset of suppliers if running an update on existing data.
*   **Default Values:** Parameters like "Default Tax Rounding Rule" or "Default Payment Method" allow for setting standard values for new records without populating every field in the source file.

### Performance & Optimization
*   **API-Based Processing:** Uses Oracle's standard APIs (e.g., `AP_VENDOR_PUB_PKG`, `IBY_DISBURSEMENT_SETUP_PUB`) to ensure all business logic and validations are triggered, preventing data corruption.
*   **Batch Processing:** Can handle large datasets by processing records in loops, often with commit intervals to manage rollback segments.
*   **Error Handling:** Provides detailed error messages for rejected records, allowing users to correct and re-upload only the failed lines.

### FAQ
**Q: Can I use this tool to update the Tax Registration Number for existing suppliers?**
A: Yes, by using the "Update" mode and mapping the new Tax Registration Number in the upload file, the tool can update this field for existing suppliers identified by their Supplier Number or Name.

**Q: Does this tool support creating bank accounts for multiple operating units?**
A: Yes, bank accounts in R12 are defined at a central level (Trading Community Architecture). This tool can assign a bank account to a Supplier Site, which is specific to an Operating Unit. You can assign the same bank account to multiple sites if needed.

**Q: What happens if a supplier in the upload file already exists?**
A: If the tool is in "Create" mode, it may error out or skip the record depending on the configuration. If in "Update" or "Merge" mode, it will attempt to update the existing supplier with the new details provided in the file.


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

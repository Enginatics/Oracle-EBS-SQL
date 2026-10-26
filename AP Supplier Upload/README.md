---
layout: default
last_modified_at: 2026-10-26
title: 'AP Supplier Upload | Oracle EBS SQL Report'
description: 'This upload can be used to create and/or update Suppliers, Supplier Sites, Supplier Bank Accounts, and Supplier Contacts Upload Mode Update only allows…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Supplier, per_employees_x, per_business_groups_perf, fnd_territories_vl'
permalink: /AP%20Supplier%20Upload/
report_name: 'AP Supplier Upload'
report_web_name: ap-supplier-upload
---

# AP Supplier Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-supplier-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload).

## Overview
This upload can be used to create and/or update Suppliers, Supplier Sites, Supplier Bank Accounts, and Supplier Contacts

Upload Mode Update only allows changes to existing Suppliers, Sites, Contacts and Bank Accounts. A row that would create any of them is rejected, including a bank or bank branch.

Add Existing Bank Acct assigns a bank account the supplier already owns to another level, as the Add button on the supplier Banking Details page does. The account is assigned exactly as it stands, so the bank, branch and bank account columns are left blank on that row.

The bank and branch columns are enterable. On a row that already has a bank account assignment they move the account to the bank and branch named, creating them if they do not exist; they no longer rename the bank or branch, which would have changed it for every supplier using it. Bank and branch names are maintained in the CE Bank and Branch Upload.

Bank Acct Name and Bank Acct Currency are no longer mandatory, matching Oracle, which allows a bank account without them.

Set Update Unpaid Invoices to Yes on a bank account row whose assignment end date has been reached to move the supplier's unpaid invoices to the next bank account that applies to them, ordered by assignment level and priority. This is what the Supplier page offers when a bank account assignment is end dated.

Invoices already selected for payment keep the end dated bank account. An invoice for which no other bank account applies is left without one, and its remit-to bank account has to be entered manually.

Tax registrations are maintained one per row in the Vend Tax Reg columns for the supplier and the Site Tax Reg columns for the supplier site, and a new one can be entered on a downloaded row that has none. A site registration belongs to the address, so it is shared by every supplier site on that address. A registration is ended with Effective To; its Tax Regime Code, Type and Number cannot be changed.

The default registration becomes the reporting registration number and type of the tax profile, and for the supplier also the Tax Registration Number, taking priority over the Tax Registration Number columns. The Site Tax Registration Number of the supplier site is not changed by it.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Allow Update on Create, Operating Unit, Supplier Type, Exclude Employee Suppliers, Supplier Name, Supplier Name From, Supplier Name To, Supplier Number, Supplier Number From, Supplier Number To, Payment Method, Tax Registration Number, Supplier Site, Supplier/Site Status, Bank Account Status, Contact Status, Tax Registration Status, Update Supplier Bank Accounts, Update Supplier Sites, Update Site Bank Accounts, Update Site Contacts, Update Supplier Tax Registrations, Update Site Tax Registrations, Default Site Bank Acct Assign Lvl, Default Tax Rounding Rule, Default Inclusive Tax, Default Allow Offset Taxes, Default Pay Each Document Alone

## Oracle EBS Tables Used
[per_employees_x](https://www.enginatics.com/library/?pg=1&find=per_employees_x&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [per_business_groups_perf](https://www.enginatics.com/library/?pg=1&find=per_business_groups_perf&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [rcv_routing_headers](https://www.enginatics.com/library/?pg=1&find=rcv_routing_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [ap_terms_vl](https://www.enginatics.com/library/?pg=1&find=ap_terms_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [ap_awt_groups](https://www.enginatics.com/library/?pg=1&find=ap_awt_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [hr_locations](https://www.enginatics.com/library/?pg=1&find=hr_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [zx_party_tax_profile](https://www.enginatics.com/library/?pg=1&find=zx_party_tax_profile&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [iby_ext_party_pmt_mthds](https://www.enginatics.com/library/?pg=1&find=iby_ext_party_pmt_mthds&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [iby_payment_methods_vl](https://www.enginatics.com/library/?pg=1&find=iby_payment_methods_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [iby_payment_reasons_vl](https://www.enginatics.com/library/?pg=1&find=iby_payment_reasons_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [iby_formats_vl](https://www.enginatics.com/library/?pg=1&find=iby_formats_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [iby_delivery_channels_vl](https://www.enginatics.com/library/?pg=1&find=iby_delivery_channels_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [iby_bank_instructions_vl](https://www.enginatics.com/library/?pg=1&find=iby_bank_instructions_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [hz_party_site_uses](https://www.enginatics.com/library/?pg=1&find=hz_party_site_uses&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [zx_registrations](https://www.enginatics.com/library/?pg=1&find=zx_registrations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [ap_tolerance_templates](https://www.enginatics.com/library/?pg=1&find=ap_tolerance_templates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [ap_distribution_sets_all](https://www.enginatics.com/library/?pg=1&find=ap_distribution_sets_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [hz_org_contacts](https://www.enginatics.com/library/?pg=1&find=hz_org_contacts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [hz_contact_points](https://www.enginatics.com/library/?pg=1&find=hz_contact_points&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [hz_relationships](https://www.enginatics.com/library/?pg=1&find=hz_relationships&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [ap_supplier_contacts](https://www.enginatics.com/library/?pg=1&find=ap_supplier_contacts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [ap_system_parameters_all](https://www.enginatics.com/library/?pg=1&find=ap_system_parameters_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [fnd_languages](https://www.enginatics.com/library/?pg=1&find=fnd_languages&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [iby_external_payees_all](https://www.enginatics.com/library/?pg=1&find=iby_external_payees_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [iby_pmt_instr_uses_all](https://www.enginatics.com/library/?pg=1&find=iby_pmt_instr_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [iby_ext_bank_accounts](https://www.enginatics.com/library/?pg=1&find=iby_ext_bank_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [ce_bank_branches_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_branches_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload)

## Related Reports
[AP Suppliers](/AP%20Suppliers/ "AP Suppliers Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report"), [AP Accounted Invoice Aging](/AP%20Accounted%20Invoice%20Aging/ "AP Accounted Invoice Aging Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [INV Movement Statistics](/INV%20Movement%20Statistics/ "INV Movement Statistics Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Supplier%20Upload/AP%20Supplier%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ap-supplier-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload) |
| Blitz Report™ XML Import | [AP_Supplier_Upload.xml](https://www.enginatics.com/xml/ap-supplier-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload) |
| SQL Source | [AP Supplier Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Supplier%20Upload/AP%20Supplier%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ap-supplier-upload/](https://www.enginatics.com/reports/ap-supplier-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

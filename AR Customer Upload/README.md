---
layout: default
last_modified_at: 2026-10-16
title: 'AR Customer Upload | Oracle EBS SQL Report'
description: 'AR Customer Upload This upload can be used to create and/or update Customer Accounts, Customer Sites and/or Customer Site Uses. Additionally, the upload…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Customer, hz_parties, hz_contact_points, hz_party_sites'
permalink: /AR%20Customer%20Upload/
report_name: 'AR Customer Upload'
report_web_name: ar-customer-upload
---

# AR Customer Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-customer-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload).

## Overview
AR Customer Upload
This upload can be used to create and/or update Customer Accounts, Customer Sites and/or Customer Site Uses.
Additionally, the upload supports:
- the creation/update of the Customer Profiles and Customer Profile Amounts at Customer and Customer Site Level
- the creation/update of bank Accounts at the Customer and Customer Site Level
- the creation/update of Contact information at the Customer and Customer Site level

The following parameters determine the behaviour of the upload.

Upload Mode
===========
Create – In this mode the user starts with a blank Excel. Use this mode to create new customers.
Create, Update – In this mode the existing customer information is first downloaded into the excel based on the other parameters specified. Use this mode to update existing customer information, or to add/update additional supplementary information to the Customers and or Customer Sites (like customer profile information, customer profile amounts, bank accounts, contacts). This mode can also be used to create new Customers.

Update Level
===========
This parameter determines if you want to download the Customer Profiles, Bank Accounts, and Contacts at the Customer Level, Customer Site Level or Both  
Account – only Customer Level information is downloaded to excel.
Site – only Customer Site level information is downloaded to the excel
Account & Site – Customer and Customer Site level information is downloaded to the Excel.
In the excel you can create/update the customer profiles, bank accounts, and/or contacts at the customer level by leaving the Site Level columns null.

Update Profile Amounts
===================
Set to Yes to download the Customer Profile Amounts assigned to the Customer and/or Customer Site profiles.

Update Bank Accounts
================
Set to Yes to download the Bank Accounts assigned to the Customers and/or Customer Sites

Update Contacts
==============
Set to Yes to download the Contacts assigned to the Customers and/or Customer Sites

Contact Status
============
Determines the status of the contacts to be downloaded. By default, only active contacts will be downloaded. But his can be changed to download all contacts, or inactive contacts only.

Default Operating Unit and Default Profile Class
======================================
For creation of new Customers/Customer Sites, the Operating Unit and Profile Class to be used can be defaulted automatically if specified by these parameters

Default <entity> Assign. Level
========================
For the creation of new Customers/Customer Sites, these parameters can be used to explicitly specify the level (Account or Site) to which the Profile Class, Tax Registration, Bank Accounts, Contacts, and Attachments should be assigned to respectively.
Normally the upload will determine the level based on the existence of site level identifying data in the excel row being uploaded. If no site level identifying data is present, then it will be associated the entity with the Account, otherwise the entity will be associated with the site.
This would require a separate excel row to be specified for the customer account and a separate row for the customer site if some entities are to be associated with the customer account and some with the customer site.
These parameters allow you to create the customer account and customer site in a single excel row and explicitly specify for each entity at what level the entity should be associated with.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Update Level, Allow Update on Create, Party Type, Operating Unit, Customer Name, Customer Name From, Customer Name To, Registry ID, Registry ID From, Registry ID To, Account Number, Account Number From, Account Number To, Customer Type, Customer Classification, Customer Sales Channel, Customer Created From, Customer Created To, Primary Salesperson, Country, Party Site Number, Party Site Name, Site Use Purpose, Site Use Location, Account Status, Site Status, Profile Class, Collector, Credit Analyst, Update Child Data must exist?, Update Site Uses, Update Profiles, Update Profile Amounts, Update Receipt Methods, Receipt Method Status, Update Tax Registrations, Tax Registration Status, Update Bank Accounts, Bank Account Status, Update Contact Points, Contact Point Status, Update Contacts, Contact Status, Update Party Relationships, Party Relationship Party Type, Party Relationship Status, Update Account Relationships, Account Relationship Status, Update Attachments, Default Profile Assign. Level, Default Receipt Mthd Assign. Level, Default Tax Reg. Assign. Level, Default Bank Acct Assign. Level, Default Contact Point Assign. Level, Default Contact Assign. Level, Default Attachment Assign. Level

## Oracle EBS Tables Used
[hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [hz_contact_points](https://www.enginatics.com/library/?pg=1&find=hz_contact_points&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [hz_role_responsibility](https://www.enginatics.com/library/?pg=1&find=hz_role_responsibility&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [hz_cust_account_roles](https://www.enginatics.com/library/?pg=1&find=hz_cust_account_roles&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [hz_relationships](https://www.enginatics.com/library/?pg=1&find=hz_relationships&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [hz_org_contacts](https://www.enginatics.com/library/?pg=1&find=hz_org_contacts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [iby_external_payers_all](https://www.enginatics.com/library/?pg=1&find=iby_external_payers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [iby_pmt_instr_uses_all](https://www.enginatics.com/library/?pg=1&find=iby_pmt_instr_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [iby_ext_bank_accounts](https://www.enginatics.com/library/?pg=1&find=iby_ext_bank_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [ce_bank_branches_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_branches_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [hz_relationship_types](https://www.enginatics.com/library/?pg=1&find=hz_relationship_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [hz_cust_acct_relate_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_relate_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [fnd_documents_short_text](https://www.enginatics.com/library/?pg=1&find=fnd_documents_short_text&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [fnd_lobs](https://www.enginatics.com/library/?pg=1&find=fnd_lobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [fnd_attached_documents](https://www.enginatics.com/library/?pg=1&find=fnd_attached_documents&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [fnd_documents](https://www.enginatics.com/library/?pg=1&find=fnd_documents&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [fnd_documents_tl](https://www.enginatics.com/library/?pg=1&find=fnd_documents_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [fnd_document_datatypes](https://www.enginatics.com/library/?pg=1&find=fnd_document_datatypes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [fnd_document_categories_tl](https://www.enginatics.com/library/?pg=1&find=fnd_document_categories_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [hz_organization_profiles](https://www.enginatics.com/library/?pg=1&find=hz_organization_profiles&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [qp_secu_list_headers_v](https://www.enginatics.com/library/?pg=1&find=qp_secu_list_headers_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [oe_ship_methods_v](https://www.enginatics.com/library/?pg=1&find=oe_ship_methods_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [hz_cust_profile_classes](https://www.enginatics.com/library/?pg=1&find=hz_cust_profile_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [ar_collectors](https://www.enginatics.com/library/?pg=1&find=ar_collectors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [jtf_rs_resource_extns_vl](https://www.enginatics.com/library/?pg=1&find=jtf_rs_resource_extns_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [ra_terms_vl](https://www.enginatics.com/library/?pg=1&find=ra_terms_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [ar_autocash_hierarchies](https://www.enginatics.com/library/?pg=1&find=ar_autocash_hierarchies&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [ar_cash_auto_rule_sets_vl](https://www.enginatics.com/library/?pg=1&find=ar_cash_auto_rule_sets_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [ar_statement_cycles](https://www.enginatics.com/library/?pg=1&find=ar_statement_cycles&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [ar_dunning_letter_sets](https://www.enginatics.com/library/?pg=1&find=ar_dunning_letter_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [ra_grouping_rules](https://www.enginatics.com/library/?pg=1&find=ra_grouping_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [hr_locations](https://www.enginatics.com/library/?pg=1&find=hr_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [zx_party_tax_profile](https://www.enginatics.com/library/?pg=1&find=zx_party_tax_profile&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [hz_person_profiles](https://www.enginatics.com/library/?pg=1&find=hz_person_profiles&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [hz_customer_profiles](https://www.enginatics.com/library/?pg=1&find=hz_customer_profiles&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [hz_cust_profile_amts](https://www.enginatics.com/library/?pg=1&find=hz_cust_profile_amts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [ra_cust_receipt_methods](https://www.enginatics.com/library/?pg=1&find=ra_cust_receipt_methods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [ar_receipt_methods](https://www.enginatics.com/library/?pg=1&find=ar_receipt_methods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [zx_registrations](https://www.enginatics.com/library/?pg=1&find=zx_registrations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [fnd_languages_vl](https://www.enginatics.com/library/?pg=1&find=fnd_languages_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [ra_territories](https://www.enginatics.com/library/?pg=1&find=ra_territories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [ar_receivables_trx_all](https://www.enginatics.com/library/?pg=1&find=ar_receivables_trx_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [ra_territories_kfv](https://www.enginatics.com/library/?pg=1&find=ra_territories_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [jtf_rs_salesreps](https://www.enginatics.com/library/?pg=1&find=jtf_rs_salesreps&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [jtf_rs_resource_extns_tl](https://www.enginatics.com/library/?pg=1&find=jtf_rs_resource_extns_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [ar_contacts_v](https://www.enginatics.com/library/?pg=1&find=ar_contacts_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [po_location_associations_all](https://www.enginatics.com/library/?pg=1&find=po_location_associations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [zx_output_classifications_v](https://www.enginatics.com/library/?pg=1&find=zx_output_classifications_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload)

## Related Reports
[AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report"), [WSH Commercial Invoice](/WSH%20Commercial%20Invoice/ "WSH Commercial Invoice Oracle EBS SQL Report"), [AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Customer%20Upload/AR%20Customer%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ar-customer-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload) |
| Blitz Report™ XML Import | [AR_Customer_Upload.xml](https://www.enginatics.com/xml/ar-customer-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload) |
| SQL Source | [AR Customer Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Customer%20Upload/AR%20Customer%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ar-customer-upload/](https://www.enginatics.com/reports/ar-customer-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload) |

## AR Customer Upload - Case Study & Technical Analysis

### Executive Summary

The **AR Customer Upload** is a comprehensive data management tool designed to streamline the creation and maintenance of customer master data within Oracle Receivables. By leveraging an Excel-based interface, it allows users to perform bulk uploads for Customer Accounts, Sites, Site Uses, Profiles, Bank Accounts, and Contacts. This tool significantly reduces the time and effort required for data entry, ensures data consistency, and simplifies the complex process of managing customer hierarchies.

### Business Challenge

Managing customer master data in Oracle E-Business Suite is often a multi-step, labor-intensive process. Challenges include:

*   **Complex Navigation:** Creating a single customer requires navigating through multiple forms and tabs to set up accounts, sites, contacts, and payment details.
*   **Data Volume:** During implementations or acquisitions, organizations need to migrate thousands of customer records, which is impractical to do manually.
*   **Data Integrity:** Manual entry increases the risk of errors, such as inconsistent address formats or missing profile classes.
*   **Maintenance Overhead:** Updating existing customers (e.g., changing collectors, updating credit limits) one by one is inefficient.

### Solution

The **AR Customer Upload** tool addresses these challenges by providing a unified, user-friendly interface for mass data processing. Key capabilities include:

*   **Bulk Creation & Updates:** Supports both the creation of new customers and the update of existing records in a single operation.
*   **Comprehensive Scope:** Handles not just basic customer details but also related entities like Customer Profiles, Bank Accounts, Contacts, and Attachments.
*   **Flexible Modes:** Offers distinct modes for "Create" (starting with a blank template) and "Create, Update" (downloading existing data for modification).
*   **Granular Control:** Parameters allow users to specify whether to update data at the Customer level, Site level, or both.

### Technical Architecture

The tool is built upon the Oracle Trading Community Architecture (TCA) and Receivables APIs to ensure strict data validation and integrity.

#### Key Tables Involved

*   `HZ_PARTIES`: Stores the master party records.
*   `HZ_CUST_ACCOUNTS`: Manages the customer account relationship.
*   `HZ_PARTY_SITES` & `HZ_LOCATIONS`: Handles address and site information.
*   `HZ_CUST_ACCT_SITES_ALL` & `HZ_CUST_SITE_USES_ALL`: Defines the specific business purposes (Bill-To, Ship-To) for sites.
*   `HZ_CUSTOMER_PROFILES` & `HZ_CUST_PROFILE_AMTS`: Stores credit and collection profile settings.
*   `IBY_EXTERNAL_PAYERS_ALL` & `IBY_EXT_BANK_ACCOUNTS`: Manages banking and payment details.
*   `HZ_ORG_CONTACTS` & `HZ_CONTACT_POINTS`: Stores contact person details and communication methods.

#### Data Logic

The upload process follows a structured logic:
1.  **Data Preparation:** The user selects the "Upload Mode" and other parameters to generate the Excel template.
2.  **Data Entry/Modification:** Users enter or modify data in the Excel sheet.
3.  **Validation:** Upon upload, the tool validates the data against Oracle's business rules (e.g., checking for duplicate sites, validating value sets).
4.  **API Execution:** Validated data is processed using standard Oracle APIs to insert or update records in the database.

### Parameters

The tool offers extensive parameters to control the upload behavior:

*   **Upload Mode:**
    *   *Create:* Generates a blank template for new records.
    *   *Create, Update:* Downloads existing data based on filters for editing.
*   **Update Level:** Determines if the download/update applies to the Customer level, Site level, or both.
*   **Update Profile Amounts / Bank Accounts / Contacts:** Flags to include or exclude these child entities in the process.
*   **Default Operating Unit / Profile Class:** Sets default values for new records to minimize data entry.
*   **Default Assign. Level:** Specifies whether new child entities (like contacts) should be assigned at the Account or Site level if not explicitly defined.

### Performance

The tool is optimized for bulk processing. However, for very large datasets (e.g., > 10,000 records), it is recommended to:
*   Split the upload into smaller batches to avoid timeouts.
*   Ensure that the underlying APIs are performant by gathering statistics on TCA tables.

### FAQ

**Q: Can I use this tool to update just the credit limits for existing customers?**
A: Yes. Select "Create, Update" mode, set "Update Profile Amounts" to Yes, and filter for the specific customers. You can then modify the credit limit columns and upload.

**Q: What happens if I leave the Site columns blank?**
A: If the "Update Level" allows it, leaving Site columns blank typically implies that the changes apply to the Customer Account level (e.g., updating the account-level profile).

**Q: Does it support multiple contacts per customer?**
A: Yes, the tool supports creating and updating multiple contacts. In the Excel template, this is usually handled by having multiple rows for the same customer, each with different contact details.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customer-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

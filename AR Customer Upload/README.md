---
layout: default
title: 'AR Customer Upload | Oracle EBS SQL Report'
description: 'AR Customer Upload This upload can be used to create and/or update Customer Accounts, Customer Sites and/or Customer Site Uses. Additionally, the upload…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Customer, hz_role_responsibility, fnd_territories_vl, hz_cust_account_roles'
permalink: /AR%20Customer%20Upload/
---

# AR Customer Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-customer-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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
Customer – only Customer Level information is downloaded to excel.
Site – only Customer Site level information is downloaded to the excel
Blank – Customer and Customer Site level information is downloaded to the Excel.
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


## Report Parameters
Upload Mode, Update Level, Party Type, Operating Unit, Customer Name, Customer Name From, Customer Name To, Registry ID, Registry ID From, Registry ID To, Account Number, Account Number From, Account Number To, Customer Type, Customer Classification, Customer Sales Channel, Customer Created From, Customer Created To, Primary Salesperson, Country, Site Use Purpose, Site Use Location, Account Status, Site Status, Profile Class, Collector, Credit Analyst, Update Site Uses, Update Profile Amounts, Update Tax Registrations, Tax Registration Status, Update Bank Accounts, Bank Account Status, Update Contacts, Contact Status, Update Attachments, Default Profile Assign. Level, Default Tax Reg. Assign. Level, Default Bank Acct Assign. Level, Default Contact Assign. Level, Default Attachment Assign. Level

## Oracle EBS Tables Used
[hz_role_responsibility](https://www.enginatics.com/library/?pg=1&find=hz_role_responsibility), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl), [hz_cust_account_roles](https://www.enginatics.com/library/?pg=1&find=hz_cust_account_roles), [hz_relationships](https://www.enginatics.com/library/?pg=1&find=hz_relationships), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hz_org_contacts](https://www.enginatics.com/library/?pg=1&find=hz_org_contacts), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations), [hz_contact_points](https://www.enginatics.com/library/?pg=1&find=hz_contact_points), [iby_external_payers_all](https://www.enginatics.com/library/?pg=1&find=iby_external_payers_all), [iby_pmt_instr_uses_all](https://www.enginatics.com/library/?pg=1&find=iby_pmt_instr_uses_all), [iby_ext_bank_accounts](https://www.enginatics.com/library/?pg=1&find=iby_ext_bank_accounts), [ce_bank_branches_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_branches_v), [fnd_documents_short_text](https://www.enginatics.com/library/?pg=1&find=fnd_documents_short_text), [fnd_lobs](https://www.enginatics.com/library/?pg=1&find=fnd_lobs), [fnd_attached_documents](https://www.enginatics.com/library/?pg=1&find=fnd_attached_documents), [fnd_documents](https://www.enginatics.com/library/?pg=1&find=fnd_documents), [fnd_documents_tl](https://www.enginatics.com/library/?pg=1&find=fnd_documents_tl), [fnd_document_datatypes](https://www.enginatics.com/library/?pg=1&find=fnd_document_datatypes), [fnd_document_categories_tl](https://www.enginatics.com/library/?pg=1&find=fnd_document_categories_tl), [hz_organization_profiles](https://www.enginatics.com/library/?pg=1&find=hz_organization_profiles)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ar-customer-upload/) |
| Blitz Report™ XML Import | [AR_Customer_Upload.xml](https://www.enginatics.com/xml/ar-customer-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-customer-upload/](https://www.enginatics.com/reports/ar-customer-upload/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics

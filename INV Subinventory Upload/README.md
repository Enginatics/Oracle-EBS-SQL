---
layout: default
last_modified_at: 2026-10-16
title: 'INV Subinventory Upload | Oracle EBS SQL Report'
description: 'Create and update Subinventories across accessible inventory organizations. Accounts and Default Cost Group are tightly linked; the behavior depends on…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, INV, Subinventory, mtl_secondary_inventories, mtl_parameters, mtl_material_statuses_vl'
permalink: /INV%20Subinventory%20Upload/
report_name: 'INV Subinventory Upload'
report_web_name: inv-subinventory-upload
---

# INV Subinventory Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-subinventory-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload).

## Overview
Create and update Subinventories across accessible inventory organizations.

Accounts and Default Cost Group are tightly linked; the behavior depends on the organization's configuration:

- WMS=No + Standard cost method (with no on-hand or transaction history): the accounts drive the Cost Group. Enter any valid GL detail accounts and the upload auto-resolves the Cost Group — switching to an existing Cost Group whose 7 accounts match, or creating a new one when none matches. The Cost Group action taken is reported in the success message.

- WMS=Yes (any cost method): the Cost Group drives the accounts. Selecting a Cost Group sets all 7 accounts (Material, Outside Processing, Material Overhead, Overhead, Resource, Expense, Encumbrance) to its assigned values. Changing the Cost Group on an existing Subinventory automatically switches all 7 accounts, including clearing accounts that are NULL on the new Cost Group.

- WMS=No + (non-Standard cost method OR the subinventory has on-hand/transaction history): the Cost Group is fixed (existing value on Update, organization default on Create) and the accounts follow it.

All account LOVs restrict to enabled detail (non-summary) GL accounts in the organization's chart of accounts. The Cost Group LOV likewise restricts to selectable Cost Groups per the rules above.

Material Status changes require Oracle's electronic signature workflow when ERES is enabled — those changes must be made via the Subinventories form to preserve the e-signature audit trail.

There is no Delete option — Subinventories can only be inactivated (set Inactive On to a past date).

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Organization Code, Subinventory, Status, Default Cost Group, Type, Include in ATP, Allow Reservation, Nettable, Quantity Tracked, Asset Subinventory, Locator Control

## Oracle EBS Tables Used
[mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload), [mtl_material_statuses_vl](https://www.enginatics.com/library/?pg=1&find=mtl_material_statuses_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload), [eng_ecn_approval_lists](https://www.enginatics.com/library/?pg=1&find=eng_ecn_approval_lists&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload), [hr_locations](https://www.enginatics.com/library/?pg=1&find=hr_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload), [mtl_cycle_count_headers](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload)

## Related Reports
[INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [INV Material Transactions](/INV%20Material%20Transactions/ "INV Material Transactions Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [INV Transaction Register](/INV%20Transaction%20Register/ "INV Transaction Register Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Subinventory%20Upload/INV%20Subinventory%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/inv-subinventory-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload) |
| Blitz Report™ XML Import | [INV_Subinventory_Upload.xml](https://www.enginatics.com/xml/inv-subinventory-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload) |
| SQL Source | [INV Subinventory Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Subinventory%20Upload/INV%20Subinventory%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-subinventory-upload/](https://www.enginatics.com/reports/inv-subinventory-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload) |

## Case Study & Technical Analysis: INV Subinventory Upload

### Executive Summary
This upload creates and updates Oracle Inventory subinventories across the inventory organizations a user can access. A subinventory carries its status, type, planning and availability flags, locator control, picking and source rules, lead times, and the seven GL accounts that drive costing, together with the cost group that links them. Inventory administrators and implementation teams use it to set up storage locations in bulk for a new warehouse or plant, and to change their status or accounts without opening the Subinventories form one at a time. The template runs in Excel through Blitz Report.

### Business Challenge
*   **Warehouse set-up at scale:** A new plant or warehouse needs many subinventories with consistent flags, locators and accounts.
*   **Cost group and account linkage:** The accounts and the default cost group are tightly connected, and changing one can silently change the other.
*   **Controlled status changes:** Material status changes may need electronic signature, so they must be made through a controlled route.
*   **No deletion path:** Subinventories cannot be deleted, so retirement must be managed through an inactive date.

### The Solution
*   **Three account modes:** The upload follows the organization's configuration. With WMS not enabled and Standard costing, the accounts drive the cost group. With WMS enabled, the cost group drives the accounts. In other cases the cost group is fixed and the accounts follow it.
*   **Cost group resolution:** When the accounts match an existing cost group, that group is used. Otherwise a new cost group is created, and the action taken is reported in the success message.
*   **Account lists of values:** All account choices are limited to enabled detail accounts in the organization's chart of accounts.
*   **Retirement by date:** A subinventory is inactivated by setting its Inactive On date to a past date.
*   **Full attribute set:** Type, ATP and reservation flags, locator control, picking order, source organization and lead times are returned for each subinventory.

### Technical Architecture (High Level)
#### Primary Tables
*   `MTL_SECONDARY_INVENTORIES`: the subinventory record, with its flags, type, locator control, dates and account references.
*   `MTL_PARAMETERS`: the owning inventory organization and the source organization.
*   `MTL_MATERIAL_STATUSES_VL`: the subinventory material status and the default locator status.
*   `CST_COST_GROUPS`: the default cost group.
*   `GL_CODE_COMBINATIONS_KFV`: the seven accounts, for material, outside processing, material overhead, overhead, resource, expense and encumbrance.
*   `ENG_ECN_APPROVAL_LISTS`: the notification list.
*   `HR_LOCATIONS`: the subinventory location.
*   `MTL_CYCLE_COUNT_HEADERS`: the opportunistic cycle count header.
*   `ORG_ACCESS_VIEW`: the organizations the responsibility can access.

#### Logical Relationships
1. `MTL_SECONDARY_INVENTORIES` joins to `MTL_PARAMETERS` on organization id, and the organization is limited through the access view.
2. The status, cost group, notification list, location and cycle count header are outer joins on their identifiers.
3. Each of the seven accounts joins to `GL_CODE_COMBINATIONS_KFV` on its code combination id, as a separate outer join.
4. The source organization joins to `MTL_PARAMETERS` a second time, so the source organization code is returned alongside the subinventory.
5. Subinventories named AX_INTRANS are excluded from the result.

### Parameters & Filtering
*   **Upload Mode:** selects Create, or Create, Update to download existing subinventories.
*   **Organization Code:** restricts the subinventories to one organization.
*   **Subinventory:** restricts the download to one subinventory name.
*   **Status:** restricts the subinventories to one material status.
*   **Default Cost Group:** restricts the subinventories to one cost group.
*   **Type, Include in ATP, Allow Reservation, Nettable and Quantity Tracked:** restrict the subinventories to one value of each flag.
*   **Asset Subinventory and Locator Control:** restrict the subinventories to one asset setting or locator control.

### Performance & Optimization
*   The organization filter uses the access view, so the main scan covers only the organizations the responsibility can use.
*   The seven account joins are outer joins on code combination id, which keeps subinventories with no account for a given type in the download.
*   Flag values are decoded with lookup meanings in the query, so the workbook shows Yes and No rather than codes.

### FAQ
**Q: Why does changing the cost group also change the accounts?**
A: In a WMS organization the cost group drives the accounts. Changing it on an existing subinventory switches all seven accounts to those assigned to the new cost group.

**Q: How do I delete a subinventory?**
A: The upload has no delete option. Set Inactive On to a past date to inactivate the subinventory.

**Q: Why can I not change the material status in the upload?**
A: When electronic records and signatures are enabled, status changes must be made in the Subinventories form to keep the signature audit trail.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-subinventory-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

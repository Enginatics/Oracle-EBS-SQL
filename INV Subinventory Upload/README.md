---
layout: default
title: 'INV Subinventory Upload | Oracle EBS SQL Report'
description: 'Create and update Subinventories across accessible inventory organizations. Accounts and Default Cost Group are tightly linked; the behavior depends on…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, INV, Subinventory, mtl_secondary_inventories, mtl_parameters, mtl_material_statuses_vl'
permalink: /INV%20Subinventory%20Upload/
---

# INV Subinventory Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-subinventory-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Create and update Subinventories across accessible inventory organizations.

Accounts and Default Cost Group are tightly linked; the behavior depends on the organization's configuration:

- WMS=No + Standard cost method (with no on-hand or transaction history): the accounts drive the Cost Group. Enter any valid GL detail accounts and the upload auto-resolves the Cost Group — switching to an existing Cost Group whose 7 accounts match, or creating a new one when none matches. The Cost Group action taken is reported in the success message.

- WMS=Yes (any cost method): the Cost Group drives the accounts. Selecting a Cost Group sets all 7 accounts (Material, Outside Processing, Material Overhead, Overhead, Resource, Expense, Encumbrance) to its assigned values. Changing the Cost Group on an existing Subinventory automatically switches all 7 accounts, including clearing accounts that are NULL on the new Cost Group.

- WMS=No + (non-Standard cost method OR the subinventory has on-hand/transaction history): the Cost Group is fixed (existing value on Update, organization default on Create) and the accounts follow it.

All account LOVs restrict to enabled detail (non-summary) GL accounts in the organization's chart of accounts. The Cost Group LOV likewise restricts to selectable Cost Groups per the rules above.

Material Status changes require Oracle's electronic signature workflow when ERES is enabled — those changes must be made via the Subinventories form to preserve the e-signature audit trail.

There is no Delete option — Subinventories can only be inactivated (set Inactive On to a past date).

## Report Parameters
Upload Mode, Organization Code, Subinventory, Status, Default Cost Group, Type, Include in ATP, Allow Reservation, Nettable, Quantity Tracked, Asset Subinventory, Locator Control

## Oracle EBS Tables Used
[mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_material_statuses_vl](https://www.enginatics.com/library/?pg=1&find=mtl_material_statuses_vl), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups), [eng_ecn_approval_lists](https://www.enginatics.com/library/?pg=1&find=eng_ecn_approval_lists), [hr_locations](https://www.enginatics.com/library/?pg=1&find=hr_locations), [mtl_cycle_count_headers](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_headers), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Material Transactions](/INV%20Material%20Transactions/ "INV Material Transactions Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [INV Transaction Register](/INV%20Transaction%20Register/ "INV Transaction Register Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/inv-subinventory-upload/) |
| Blitz Report™ XML Import | [INV_Subinventory_Upload.xml](https://www.enginatics.com/xml/inv-subinventory-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-subinventory-upload/](https://www.enginatics.com/reports/inv-subinventory-upload/) |



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

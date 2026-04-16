---
layout: default
title: 'CST Cost Groups | Oracle EBS SQL Report'
description: 'Master data report that lists all item cost groups along with their corresponding GL posting codes and descriptions.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CST, Cost, Groups, cst_cost_groups, &xle_table, cst_cost_group_accounts'
permalink: /CST%20Cost%20Groups/
---

# CST Cost Groups – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-cost-groups/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Master data report that lists all item cost groups along with their corresponding GL posting codes and descriptions.

## Report Parameters


## Oracle EBS Tables Used
[cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups), [&xle_table](https://www.enginatics.com/library/?pg=1&find=&xle_table), [cst_cost_group_accounts](https://www.enginatics.com/library/?pg=1&find=cst_cost_group_accounts)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CST Inventory Value - Multi-Organization (Element Costs) 11i](/CST%20Inventory%20Value%20-%20Multi-Organization%20%28Element%20Costs%29%2011i/ "CST Inventory Value - Multi-Organization (Element Costs) 11i Oracle EBS SQL Report"), [CAC Onhand Lot Value (Real-Time)](/CAC%20Onhand%20Lot%20Value%20%28Real-Time%29/ "CAC Onhand Lot Value (Real-Time) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CST Cost Groups 27-Jul-2018 134345.xlsx](https://www.enginatics.com/example/cst-cost-groups/) |
| Blitz Report™ XML Import | [CST_Cost_Groups.xml](https://www.enginatics.com/xml/cst-cost-groups/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cst-cost-groups/](https://www.enginatics.com/reports/cst-cost-groups/) |

## Executive Summary
The **CST Cost Groups** report is a master data configuration report that details the setup of Cost Groups within the organization. In Project Manufacturing or Weighted Average Costing environments, Cost Groups are used to segregate inventory costs for different projects or purposes within the same inventory organization. This report provides a clear view of the account mappings associated with each group.

## Business Challenge
Cost Groups allow for the same item to have different costs depending on who owns it (e.g., Project A vs. Project B).
*   **Account Mapping**: Each Cost Group has its own set of valuation accounts (Material, Material Overhead, WIP, etc.). Incorrect mapping leads to financial misstatements.
*   **Complexity Management**: As the number of projects or cost groups grows, maintaining visibility into the underlying account structure becomes difficult.
*   **Audit**: Verifying that specific projects are pointing to the correct GL accounts.

## Solution
This report lists all defined Cost Groups and their associated General Ledger accounts.

**Key Features:**
*   **Account Detail**: Shows the full GL account string for each cost element (Material, Resource, Overhead, etc.).
*   **Description**: Includes the description of the Cost Group for context.

## Architecture
The report queries `CST_COST_GROUPS` and `CST_COST_GROUP_ACCOUNTS`.

**Key Tables:**
*   `CST_COST_GROUPS`: Defines the cost group name and type.
*   `CST_COST_GROUP_ACCOUNTS`: Stores the GL account assignments for the group.

## Impact
*   **Configuration Validation**: Ensures that new Cost Groups are set up with the correct accounting rules.
*   **Troubleshooting**: Helps explain why inventory transactions for a specific project are hitting unexpected GL accounts.
*   **System Documentation**: Provides a reference for the financial structure of the manufacturing organization.


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

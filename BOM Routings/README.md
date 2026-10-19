---
layout: default
last_modified_at: 2026-10-19
title: 'BOM Routings | Oracle EBS SQL Report'
description: 'Master data report showing bill of material routings with item codes and sequences. The report optionally shows the full routing detail matching the BOM…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Bills of Material, Enginatics, BOM, Routings, mtl_item_status_vl, mtl_item_locations_kfv, mtl_system_items_vl'
permalink: /BOM%20Routings/
report_name: 'BOM Routings'
report_web_name: bom-routings
module: 'Bills of Material'
module_url: /modules/bills-of-material/
---

# BOM Routings – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/bom-routings/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings).
**Oracle EBS module:** [Bills of Material](/modules/bills-of-material/ "Oracle EBS Bills of Material reports") · [all Bills of Material reports](/modules/bills-of-material/)  

## Overview
Master data report showing bill of material routings with item codes and sequences.

The report optionally shows the full routing detail matching the BOM Routing Upload: routing header attributes and revision, operation scheduling details, operation resources, substitute resources and flow routing operation networks. The detail levels are controlled by the Show Operations, Show Resources, Show Substitute Resources and Show Networks parameters, and the Record Type column identifies each row.

Descriptive flexfield attributes of the routing, routing revision and operation are shown as dynamic columns via the Show BOM DFF Attributes parameter.

Selecting a Resource, without an item, lists where that resource is used across all routings of the organization.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Item, Item Description, Excluded Item Statuses, Assembly Type, Routing Type, Alternate, Resource, Operation Sequence, Display, Effective Date, Implemented Only, Common Routing Assignments, Show Operations, Show Resources, Show Substitute Resources, Routings with Substitutes Only, Show Networks, Routings with Networks Only, Show BOM DFF Attributes

## Oracle EBS Tables Used
[mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings), [bom_department_resources](https://www.enginatics.com/library/?pg=1&find=bom_department_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings), [bom_setup_types](https://www.enginatics.com/library/?pg=1&find=bom_setup_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings), [cst_activities_val_v](https://www.enginatics.com/library/?pg=1&find=cst_activities_val_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings), [bom_operational_routings](https://www.enginatics.com/library/?pg=1&find=bom_operational_routings&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings), [mtl_rtg_item_revisions](https://www.enginatics.com/library/?pg=1&find=mtl_rtg_item_revisions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings), [wip_lines](https://www.enginatics.com/library/?pg=1&find=wip_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings), [bom_operation_sequences](https://www.enginatics.com/library/?pg=1&find=bom_operation_sequences&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings), [bom_standard_operations](https://www.enginatics.com/library/?pg=1&find=bom_standard_operations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings), [bom_operation_resources](https://www.enginatics.com/library/?pg=1&find=bom_operation_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings), [bom_sub_operation_resources](https://www.enginatics.com/library/?pg=1&find=bom_sub_operation_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings), [bom_operation_networks](https://www.enginatics.com/library/?pg=1&find=bom_operation_networks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings)

## Related Reports
[BOM Routing Upload](/BOM%20Routing%20Upload/ "BOM Routing Upload Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC Item Cost & Routing](/CAC%20Item%20Cost%20-%20Routing/ "CAC Item Cost & Routing Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [WIP Job Upload](/WIP%20Job%20Upload/ "WIP Job Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/BOM%20Routings/BOM%20Routings.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [BOM Routings 02-Oct-2020 090608.xlsx](https://www.enginatics.com/example/bom-routings/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings) |
| Blitz Report™ XML Import | [BOM_Routings.xml](https://www.enginatics.com/xml/bom-routings/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings) |
| SQL Source | [BOM Routings.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/BOM%20Routings/BOM%20Routings.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/bom-routings/](https://www.enginatics.com/reports/bom-routings/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings) |

## BOM Routings Report

### Executive Summary
The BOM Routings report provides a detailed overview of the manufacturing routings for assemblies and subassemblies. This report is an essential tool for production planners, manufacturing engineers, and cost accountants, offering a clear view of the operations, resources, and lead times required to produce an item. By providing a comprehensive view of routings, the report helps to ensure that production is planned and executed efficiently, and that costs are accurately calculated.

### Business Challenge
Manufacturing routings are the backbone of the production process. However, managing and maintaining accurate routing information can be a complex and challenging task. Without a clear and comprehensive report, organizations may face:
- **Inaccurate Production Schedules:** If routings are not accurate, production schedules may be unrealistic, leading to delays and disruptions in the manufacturing process.
- **Incorrect Costing:** Inaccurate routings can lead to incorrect product costing, which can have a significant impact on profitability.
- **Inefficient Resource Utilization:** Without a clear understanding of the resources required for each operation, it is difficult to optimize resource utilization and minimize production costs.
- **Lack of Visibility:** Difficulty in getting a clear and up-to-date view of all routings, which can make it difficult to identify and address inefficiencies in the manufacturing process.

### The Solution
The BOM Routings report provides a clear and detailed view of all manufacturing routings, helping organizations to:
- **Improve Production Planning:** By providing a clear and accurate view of the operations, resources, and lead times required for each item, the report helps to ensure that production schedules are accurate and achievable.
- **Enhance Costing Accuracy:** The report provides the basis for accurate product costing, which is essential for making informed decisions about pricing, profitability, and product mix.
- **Optimize Resource Utilization:** By providing a detailed breakdown of the resources required for each operation, the report helps to identify opportunities to improve resource utilization and reduce production costs.
- **Increase Visibility:** The report provides a centralized and easy-to-read view of all routings, making it easier to identify and address inefficiencies in the manufacturing process.

### Technical Architecture (High Level)
The report is based on a query of several key tables in the Oracle Bills of Material and Work in Process modules. The primary tables used include:
- **bom_operational_routings:** This table stores the main information about each routing, including the assembly item, the routing sequence, and the completion subinventory.
- **bom_operation_sequences:** This table stores the sequence of operations for each routing.
- **bom_standard_operations:** This table provides information about the standard operations that are used in the routings.
- **bom_departments:** This table contains information about the departments where the operations are performed.

### Parameters & Filtering
The report includes four parameters that allow you to filter the output by organization, item, item description, and item status.

- **Organization Code:** This parameter allows you to filter the report by a specific organization.
- **Item:** This parameter allows you to select a specific item to view.
- **Item Description:** This parameter allows you to filter the report by the description of the item.
- **Excluded Item Statuses:** This parameter allows you to exclude items with a specific status from the report.

### Performance & Optimization
The BOM Routings report is designed to be efficient and fast. It uses direct table access to retrieve the data, which is much faster than relying on intermediate views or APIs. The report is also designed to minimize the use of complex joins and subqueries, which helps to ensure that it runs quickly and efficiently.

### FAQ
**Q: What is a routing?**
A: A routing is a sequence of operations that are performed to manufacture a product. It specifies the resources, materials, and time required for each operation.

**Q: Why is it important to have accurate routings?**
A: Accurate routings are essential for ensuring the accuracy of your production schedules and product costs. They can also help you to optimize resource utilization and improve the overall efficiency of your manufacturing operations.

**Q: Can I use this report to see the resources that are required for each operation?**
A: Yes, the report provides a detailed breakdown of each operation, including the resources that are required and the usage rate for each resource.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=bom-routings)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

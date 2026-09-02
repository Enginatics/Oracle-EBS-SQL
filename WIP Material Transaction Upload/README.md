---
layout: default
title: 'WIP Material Transaction Upload | Oracle EBS SQL Report'
description: 'Issues components to, and returns components from, WIP work orders. The download returns one row per component requirement of the selected work orders…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, WIP, Material, Transaction, mtl_units_of_measure_vl, org_organization_definitions, wip_entities'
permalink: /WIP%20Material%20Transaction%20Upload/
---

# WIP Material Transaction Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/wip-material-transaction-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Issues components to, and returns components from, WIP work orders.

The download returns one row per component requirement of the selected work orders, with the operation, department, supply subinventory and locator already filled in, and the required, issued and still open quantities shown. Enter a Transaction Type and a Quantity on the rows you want to transact and leave the rest blank.

Quantity is always entered as a positive number; the Transaction Type decides the direction.

Discrete jobs, lot based jobs and maintenance work orders are supported. Repetitive schedules are not.

Rows are staged in the inventory transaction interface and processed by the inventory transaction manager, so the resulting transactions are identical to those the WIP Material Transactions form creates and relieve the work order requirement in the same way.

## Report Parameters
Upload Mode, Organization Code, Job, Job Status, Assembly, Component, Department, Date Required From, Date Required To, Open Requirements Only

## Oracle EBS Tables Used
[mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs), [wip_requirement_operations](https://www.enginatics.com/library/?pg=1&find=wip_requirement_operations), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[WIP Required Components](/WIP%20Required%20Components/ "WIP Required Components Oracle EBS SQL Report"), [CRP Resource Plan](/CRP%20Resource%20Plan/ "CRP Resource Plan Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [WIP Job Upload](/WIP%20Job%20Upload/ "WIP Job Upload Oracle EBS SQL Report"), [WIP Value Summary](/WIP%20Value%20Summary/ "WIP Value Summary Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC WIP Material Usage Variance](/CAC%20WIP%20Material%20Usage%20Variance/ "CAC WIP Material Usage Variance Oracle EBS SQL Report"), [MRP Pegging](/MRP%20Pegging/ "MRP Pegging Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/wip-material-transaction-upload/) |
| Blitz Report™ XML Import | [WIP_Material_Transaction_Upload.xml](https://www.enginatics.com/xml/wip-material-transaction-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/wip-material-transaction-upload/](https://www.enginatics.com/reports/wip-material-transaction-upload/) |



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

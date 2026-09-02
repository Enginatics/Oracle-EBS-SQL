---
layout: default
title: 'MRP Master Schedule Upload | Oracle EBS SQL Report'
description: 'MRP Master Schedule Upload ========================== - Create new MDS/MPS schedule entries. - Create and Update existing schedule entries. Each row…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, MRP, Master, Schedule, mtl_parameters, mrp_schedule_designators, mrp_schedule_dates'
permalink: /MRP%20Master%20Schedule%20Upload/
---

# MRP Master Schedule Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/mrp-master-schedule-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
MRP Master Schedule Upload
==========================
- Create new MDS/MPS schedule entries.
- Create and Update existing schedule entries.

Each row stages one schedule entry into the MRP schedule interface (mrp_schedule_interface, process_status=2) for an existing schedule designator (MDS or MPS). The staged entries are loaded into the master schedule (mrp_schedule_dates) asynchronously by the customer's MRP Planning Manager.

Upload Modes
============
Create - opens an empty spreadsheet to enter new schedule entries against any accessible schedule designator.
Create and Update - downloads existing schedule entries for the selected schedule designators and lets the user add new entries and re-stage modifications. Existing entries are matched on the hidden Transaction Id.

Prerequisites
=============
- Schedule designators (Master Demand Schedule / Master Production Schedule) must be defined.


## Report Parameters
Upload Mode, Default Workday Control, Organization Code, Schedule Type, Schedule Name, Planner, Item, Schedule Date From, Schedule Date To

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mrp_schedule_designators](https://www.enginatics.com/library/?pg=1&find=mrp_schedule_designators), [mrp_schedule_dates](https://www.enginatics.com/library/?pg=1&find=mrp_schedule_dates), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[MRP Pegging](/MRP%20Pegging/ "MRP Pegging Oracle EBS SQL Report"), [MRP Item Forecast Upload](/MRP%20Item%20Forecast%20Upload/ "MRP Item Forecast Upload Oracle EBS SQL Report"), [INV Item Supply/Demand](/INV%20Item%20Supply-Demand/ "INV Item Supply/Demand Oracle EBS SQL Report"), [MRP Item Forecast](/MRP%20Item%20Forecast/ "MRP Item Forecast Oracle EBS SQL Report"), [WIP Entities](/WIP%20Entities/ "WIP Entities Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/mrp-master-schedule-upload/) |
| Blitz Report™ XML Import | [MRP_Master_Schedule_Upload.xml](https://www.enginatics.com/xml/mrp-master-schedule-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/mrp-master-schedule-upload/](https://www.enginatics.com/reports/mrp-master-schedule-upload/) |



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

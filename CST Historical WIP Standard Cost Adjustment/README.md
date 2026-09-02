---
layout: default
title: 'CST Historical WIP Standard Cost Adjustment | Oracle EBS SQL Report'
description: 'WIP standard cost adjustment details recorded by a completed standard cost update, based on Oracle''s Historical WIP Standard Cost Adjustment Report…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CST, Historical, WIP, Standard, gl_code_combinations_kfv, cst_cost_updates, cst_cost_types'
permalink: /CST%20Historical%20WIP%20Standard%20Cost%20Adjustment/
---

# CST Historical WIP Standard Cost Adjustment – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-historical-wip-standard-cost-adjustment/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
WIP standard cost adjustment details recorded by a completed standard cost update, based on Oracle's Historical WIP Standard Cost Adjustment Report (CSTCUSJA).

The report shows one line per WIP discrete job, transaction type, item or resource operation and cost element, with the old and new unit costs, adjustment quantity and adjustment value, and the WIP job's valuation and standard cost adjustment accounts.

The Cost Update parameter offers the completed standard cost updates of the selected organization that saved their adjustment details, matching Oracle's View Cost Update History form. Oracle's Delete Snapshot option is deliberately not included, so the stored adjustment details are never removed by this report.

## Report Parameters
Organization Code, Cost Update

## Oracle EBS Tables Used
[gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [cst_cost_updates](https://www.enginatics.com/library/?pg=1&find=cst_cost_updates), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies), [cst_std_cost_adj_values](https://www.enginatics.com/library/?pg=1&find=cst_std_cost_adj_values), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [cst_cost_elements](https://www.enginatics.com/library/?pg=1&find=cst_cost_elements)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FA Asset Impairments](/FA%20Asset%20Impairments/ "FA Asset Impairments Oracle EBS SQL Report"), [FSG Drilldown Diagnostic](/FSG%20Drilldown%20Diagnostic/ "FSG Drilldown Diagnostic Oracle EBS SQL Report"), [GL Code Combinations](/GL%20Code%20Combinations/ "GL Code Combinations Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [GL Journals (Drilldown)](/GL%20Journals%20%28Drilldown%29/ "GL Journals (Drilldown) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CST Historical WIP Standard Cost Adjustment 05-Aug-2026 123629.xlsx](https://www.enginatics.com/example/cst-historical-wip-standard-cost-adjustment/) |
| Blitz Report™ XML Import | [CST_Historical_WIP_Standard_Cost_Adjustment.xml](https://www.enginatics.com/xml/cst-historical-wip-standard-cost-adjustment/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cst-historical-wip-standard-cost-adjustment/](https://www.enginatics.com/reports/cst-historical-wip-standard-cost-adjustment/) |



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

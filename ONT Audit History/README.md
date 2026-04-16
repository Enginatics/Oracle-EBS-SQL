---
layout: default
title: 'ONT Audit History | Oracle EBS SQL Report'
description: 'Order Management audit history report showing changes to order headers, lines, sales credits, and price adjustments with old/new values, change reasons…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, ONT, Audit, History, oe_order_lines_all, oe_sales_credits, oe_price_adjustments'
permalink: /ONT%20Audit%20History/
---

# ONT Audit History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ont-audit-history/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Order Management audit history report showing changes to order headers, lines, sales credits, and price adjustments with old/new values, change reasons, and the user who made the change.
Based on Oracle standard report OEXAUDHR_XML (Audit History Report).

## Report Parameters
Operating Unit, History Date From, History Date To, Entity, Attribute, Order Number From, Order Number To, User Name, Responsibility

## Oracle EBS Tables Used
[oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all), [oe_sales_credits](https://www.enginatics.com/library/?pg=1&find=oe_sales_credits), [oe_price_adjustments](https://www.enginatics.com/library/?pg=1&find=oe_price_adjustments), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [oe_audit_attr_desc_v](https://www.enginatics.com/library/?pg=1&find=oe_audit_attr_desc_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[QP Customer Pricing Engine Request](/QP%20Customer%20Pricing%20Engine%20Request/ "QP Customer Pricing Engine Request Oracle EBS SQL Report"), [AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report"), [ONT Orders and Lines](/ONT%20Orders%20and%20Lines/ "ONT Orders and Lines Oracle EBS SQL Report"), [CAC AP Accrual IR ISO Match Analysis](/CAC%20AP%20Accrual%20IR%20ISO%20Match%20Analysis/ "CAC AP Accrual IR ISO Match Analysis Oracle EBS SQL Report"), [INV Intercompany Invoice Reconciliation](/INV%20Intercompany%20Invoice%20Reconciliation/ "INV Intercompany Invoice Reconciliation Oracle EBS SQL Report"), [AR Customer Credit Limits](/AR%20Customer%20Credit%20Limits/ "AR Customer Credit Limits Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ont-audit-history/) |
| Blitz Report™ XML Import | [ONT_Audit_History.xml](https://www.enginatics.com/xml/ont-audit-history/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ont-audit-history/](https://www.enginatics.com/reports/ont-audit-history/) |



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

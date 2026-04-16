---
layout: default
title: 'PA Transaction Upload | Oracle EBS SQL Report'
description: 'PA Transaction Upload =================== This upload can be used to upload transactions from external cost collection systems into Oracle Projects…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Transaction, pa_transaction_sources, gl_code_combinations_kfv, pa_transaction_interface_all'
permalink: /PA%20Transaction%20Upload/
---

# PA Transaction Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-transaction-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
PA Transaction Upload
===================
This upload can be used to upload transactions from external cost collection systems into Oracle Projects. 
Transaction Import creates pre-approved expenditure items from transaction data entered in external cost collection systems.

If the 'Operating Unit' and/or 'Transaction Source' parameters are specified, then the upload excel will be restricted to the specified Operating Unit and/or Transaction Source.

If the 'Batch Name' parameter is specified, this will default as the Batch Name in the upload Excel.

If the 'All Negative Expend Unmatched' parameter is set to Yes, then all negative transations then the 'Unmatched Negative Txn Flag' column will automatically default to Yes against any negative transactions entered into upload Excel.

If the 'Reverse in Future Period' parameter is set to Yes, then the 'Accrual Flag' column will default to Yes against every transaction entered in the upload Excel  


## Report Parameters
Operating Unit, Transaction Source, Batch Name, Expenditure Ending Date, All Negative Expend Unmatched, Reverse in Future Period, Import Transactions

## Oracle EBS Tables Used
[pa_transaction_sources](https://www.enginatics.com/library/?pg=1&find=pa_transaction_sources), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [pa_transaction_interface_all](https://www.enginatics.com/library/?pg=1&find=pa_transaction_interface_all), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/pa-transaction-upload/) |
| Blitz Report™ XML Import | [PA_Transaction_Upload.xml](https://www.enginatics.com/xml/pa-transaction-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/pa-transaction-upload/](https://www.enginatics.com/reports/pa-transaction-upload/) |



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

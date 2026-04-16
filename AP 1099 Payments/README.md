---
layout: default
title: 'AP 1099 Payments | Oracle EBS SQL Report'
description: '1099 Payments report showing payments made to 1099 reportable suppliers. This is the Blitz Report equivalent of the Oracle standard 1099 Payments Report…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, 1099, Payments, ap_invoice_payments_all, ap_reporting_entities_all, ap_reporting_entity_lines_all'
permalink: /AP%201099%20Payments/
---

# AP 1099 Payments – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-1099-payments/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
1099 Payments report showing payments made to 1099 reportable suppliers.
This is the Blitz Report equivalent of the Oracle standard 1099 Payments Report (APXTRRVT).

The report lists suppliers from the 1099 tape data (vendors processed for 1099 reporting) along with their payment totals within the specified date range.

Key features:
- Uses ap_1099_tape_data to filter vendors processed for 1099 reporting
- Validates against Tax Reporting Entity and balancing segments
- Calculates payment amounts using Oracle AP_UTILITIES_PKG.Net_Invoice_Amount
- Determines tax reporting site (site with tax_reporting_site_flag=Y or first alphabetical site)
- Handles void checks by excluding payments voided within the date range
- Supports Summary (totals by supplier/type) and Detail (individual checks/invoices) modes
- MISC4 (Backup Withholding) amounts tracked separately as Withheld Amount
- Distribution Total shows gross amounts before withholding adjustments
- Payment Amount shows net reportable amounts (with MISC4 as negative)
- Query Driver parameter controls balancing segment matching (INV=invoice distribution, PAY=bank cash account)
- Employee vendors use national_identifier from per_all_people_f for tax ID
- Tax ID cleanup removes dashes, spaces, and treats 000000000 as blank

## Report Parameters
Reporting Option, From Payment Date, To Payment Date, Tax Reporting Entity, Supplier Name, Income Tax Region, Federal Reportable Only, Query Driver

## Oracle EBS Tables Used
[ap_invoice_payments_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_payments_all), [ap_reporting_entities_all](https://www.enginatics.com/library/?pg=1&find=ap_reporting_entities_all), [ap_reporting_entity_lines_all](https://www.enginatics.com/library/?pg=1&find=ap_reporting_entity_lines_all), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all), [ap_invoice_distributions_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_distributions_all), [ap_checks_all](https://www.enginatics.com/library/?pg=1&find=ap_checks_all), [ce_bank_acct_uses_all](https://www.enginatics.com/library/?pg=1&find=ce_bank_acct_uses_all), [ce_bank_accounts](https://www.enginatics.com/library/?pg=1&find=ce_bank_accounts), [ap_1099_tape_data](https://www.enginatics.com/library/?pg=1&find=ap_1099_tape_data)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AP 1099 Payments 28-Dec-2025 142614.xlsx](https://www.enginatics.com/example/ap-1099-payments/) |
| Blitz Report™ XML Import | [AP_1099_Payments.xml](https://www.enginatics.com/xml/ap-1099-payments/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ap-1099-payments/](https://www.enginatics.com/reports/ap-1099-payments/) |



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

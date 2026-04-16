---
layout: default
title: 'CSI Installed Base Summary by Organization | Oracle EBS SQL Report'
description: 'Count of installed base products by hierarchy type (parent / child), instance usage and related organizations, such as sold from and owner operating unit…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CSI, Installed, Base, Summary, hz_cust_accounts, hz_cust_acct_sites_all, hz_cust_site_uses_all'
permalink: /CSI%20Installed%20Base%20Summary%20by%20Organization/
---

# CSI Installed Base Summary by Organization – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/csi-installed-base-summary-by-organization/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Count of installed base products by hierarchy type (parent / child), instance usage and related organizations, such as sold from and owner operating unit, last validation and master inventory organization

## Report Parameters
Show Status

## Oracle EBS Tables Used
[hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [csi_item_instances](https://www.enginatics.com/library/?pg=1&find=csi_item_instances), [csi_ii_relationships](https://www.enginatics.com/library/?pg=1&find=csi_ii_relationships), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [csi_i_org_assignments](https://www.enginatics.com/library/?pg=1&find=csi_i_org_assignments), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [csi_instance_statuses](https://www.enginatics.com/library/?pg=1&find=csi_instance_statuses)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[OKL Termination Quotes](/OKL%20Termination%20Quotes/ "OKL Termination Quotes Oracle EBS SQL Report"), [AR Transactions and Lines 11i](/AR%20Transactions%20and%20Lines%2011i/ "AR Transactions and Lines 11i Oracle EBS SQL Report"), [CSI Customer Products Summary](/CSI%20Customer%20Products%20Summary/ "CSI Customer Products Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CSI Installed Base Summary by Organization 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/csi-installed-base-summary-by-organization/) |
| Blitz Report™ XML Import | [CSI_Installed_Base_Summary_by_Organization.xml](https://www.enginatics.com/xml/csi-installed-base-summary-by-organization/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/csi-installed-base-summary-by-organization/](https://www.enginatics.com/reports/csi-installed-base-summary-by-organization/) |

## Executive Summary
The **CSI Installed Base Summary by Organization** report provides a statistical overview of the Installed Base, aggregated by organization and hierarchy. It counts the number of item instances based on their usage (e.g., "Sold To," "Ship To") and their relationship within the system (Parent/Child). This high-level view is useful for operational reporting and validating data migration or synchronization processes.

## Business Challenge
Managing millions of installed base records requires high-level metrics to ensure data health.
*   **Volume Analysis**: "How many active instances do we have in the US vs. Europe?"
*   **Data Integrity**: "Do we have instances that are owned by an inactive organization?"
*   **Hierarchy Validation**: Ensuring that the parent-child relationships (e.g., System -> Component) are being maintained.

## Solution
This report aggregates instance counts by various organizational dimensions.

**Key Features:**
*   **Hierarchy Analysis**: Counts instances by their parent/child relationship type.
*   **Usage Breakdown**: Segments the base by "Instance Usage" (e.g., External, Internal, In-Transit).
*   **Organizational Context**: Shows the "Sold From" and "Owner" operating units.

## Architecture
The report aggregates data from `CSI_ITEM_INSTANCES` and `CSI_II_RELATIONSHIPS`.

**Key Tables:**
*   `CSI_ITEM_INSTANCES`: The core instance data.
*   `CSI_II_RELATIONSHIPS`: Defines the structure (parent/child) between instances.
*   `CSI_I_ORG_ASSIGNMENTS`: Links instances to specific organizations.
*   `HR_ALL_ORGANIZATION_UNITS`: Organization details.

## Impact
*   **Operational Monitoring**: Tracks the growth of the installed base over time.
*   **Data Quality**: Helps identify "orphan" records or instances with invalid organizational assignments.
*   **Strategic Planning**: Provides the volume data needed to plan for storage or service capacity.


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

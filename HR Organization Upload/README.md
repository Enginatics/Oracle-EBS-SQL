---
layout: default
title: 'HR Organization Upload | Oracle EBS SQL Report'
description: 'Upload to create and update organizations, organization classifications, and organization information types within Oracle HRMS. Scope: - Create new…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Organization, hr_all_organization_units, hr_all_organization_units_tl, per_business_groups'
permalink: /HR%20Organization%20Upload/
---

# HR Organization Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/hr-organization-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Upload to create and update organizations, organization classifications, and organization information types within Oracle HRMS.

Scope:
- Create new organizations, assign classifications and information types, and specify the information type attributes
- Update existing organization data, classifications (enable/disable), and the information type attributes
- Supports all organization classification types: Business Groups (excluding creation of new Business Groups), HR Organization, Operating Unit, GRE/Legal Entity, Company Cost Center, Inventory Organization, etc.
- Supports creation/update of single-row (GS) and multi-row (GM) organization information types and their attributes (org_information1..20) with dynamic LOVs and segment labels
- Supports creation/update of the Cost Allocation Key Flexfield segments against the HR Organization Classification (ORGANIZATION qualified segments only)


Constraints:
- Organizations can only be created/updated within the Business Group associated with the current responsibility
- Business Group creation is not supported - use the Define Organizations form
- The following organization information types cannot be updated via the API once created: Business Group Information, Canada Employer Identification. These can be created but not subsequently modified by this upload
- Only supports the creation and update of the single-row DFF and multi-row DFF information types. 
- Organization information segments that reference self-referencing data may require a two-step upload: first create the info type, then update the self-referencing attribute in a second pass

## Report Parameters
Upload Mode, Business Group, Organization Type, Organization Name, Location, Organization Status, Classification, Classification Status, Information Type

## Oracle EBS Tables Used
[hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units), [hr_all_organization_units_tl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_tl), [per_business_groups](https://www.enginatics.com/library/?pg=1&find=per_business_groups), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all), [pay_cost_allocation_keyflex](https://www.enginatics.com/library/?pg=1&find=pay_cost_allocation_keyflex), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_org_info_types_by_class](https://www.enginatics.com/library/?pg=1&find=hr_org_info_types_by_class), [hr_org_information_types](https://www.enginatics.com/library/?pg=1&find=hr_org_information_types), [hr_org_information_types_tl](https://www.enginatics.com/library/?pg=1&find=hr_org_information_types_tl), [fnd_descr_flex_contexts](https://www.enginatics.com/library/?pg=1&find=fnd_descr_flex_contexts)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/hr-organization-upload/) |
| Blitz Report™ XML Import | [HR_Organization_Upload.xml](https://www.enginatics.com/xml/hr-organization-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/hr-organization-upload/](https://www.enginatics.com/reports/hr-organization-upload/) |



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

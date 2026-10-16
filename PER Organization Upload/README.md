---
layout: default
last_modified_at: 2026-10-16
title: 'PER Organization Upload | Oracle EBS SQL Report'
description: 'Upload to create and update organizations, organization classifications, and organization information types within Oracle HRMS. Scope: - Create new…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, PER, Organization, hr_all_organization_units, hr_all_organization_units_tl, per_business_groups'
permalink: /PER%20Organization%20Upload/
report_name: 'PER Organization Upload'
report_web_name: per-organization-upload
---

# PER Organization Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/per-organization-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload).

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Business Group, Organization Type, Organization Name, Location, Organization Status, Classification, Classification Status, Information Type

## Oracle EBS Tables Used
[hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload), [hr_all_organization_units_tl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload), [per_business_groups](https://www.enginatics.com/library/?pg=1&find=per_business_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload), [pay_cost_allocation_keyflex](https://www.enginatics.com/library/?pg=1&find=pay_cost_allocation_keyflex&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload), [hr_org_info_types_by_class](https://www.enginatics.com/library/?pg=1&find=hr_org_info_types_by_class&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload), [hr_org_information_types](https://www.enginatics.com/library/?pg=1&find=hr_org_information_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload), [hr_org_information_types_tl](https://www.enginatics.com/library/?pg=1&find=hr_org_information_types_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload), [fnd_descr_flex_contexts](https://www.enginatics.com/library/?pg=1&find=fnd_descr_flex_contexts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload)

## Related Reports
[PER Organizations](/PER%20Organizations/ "PER Organizations Oracle EBS SQL Report"), [PAY Hire to Retire Tracker](/PAY%20Hire%20to%20Retire%20Tracker/ "PAY Hire to Retire Tracker Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC Inventory to G/L Reconciliation (Restricted by Org Access)](/CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Restricted%20by%20Org%20Access%29/ "CAC Inventory to G/L Reconciliation (Restricted by Org Access) Oracle EBS SQL Report"), [INV Movement Statistics](/INV%20Movement%20Statistics/ "INV Movement Statistics Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Organization%20Upload/PER%20Organization%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/per-organization-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload) |
| Blitz Report™ XML Import | [PER_Organization_Upload.xml](https://www.enginatics.com/xml/per-organization-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload) |
| SQL Source | [PER Organization Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Organization%20Upload/PER%20Organization%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/per-organization-upload/](https://www.enginatics.com/reports/per-organization-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload) |

## Case Study & Technical Analysis: PER Organization Upload

### Executive Summary
The PER Organization Upload creates and updates organisations in Oracle HRMS, together with their classifications, their organisation information types and the cost allocation key flexfield segments that go with them. It is written for HR system administrators and implementation teams who build the organisation structure of an Oracle EBS enterprise, including business units, legal entities, inventory organisations and cost centres. The upload works within the business group of the current responsibility, and it does not create business groups.
### Business Challenge
*   **Structure set-up at scale:** A new enterprise structure can need dozens of organisations, each with classifications, locations and information types, and entering them one at a time is slow.
*   **Consistent classifications:** Each organisation needs the right classification, such as HR organisation, operating unit or legal entity, with the mandatory information types for that classification.
*   **Maintaining information types:** Organisation information types carry dozens of segments with labels that depend on the classification and the legislation, which are hard to keep consistent by hand.

### The Solution
*   **Organisation header in one row:** Each row carries the organisation name, type, dates, location, internal or external flag and internal address.
*   **Classification and enablement:** The classification, its enabled status and whether it has mandatory information types are shown on the row.
*   **Information type values with labels:** For each organisation information type, the segment labels and values are returned, with dynamic labels that follow the classification and legislation.
*   **Cost allocation segments:** For HR organisations, the cost allocation key flexfield segments are returned as thirty separate columns.

### Technical Architecture (High Level)
#### Primary Tables
*   `HR_ALL_ORGANIZATION_UNITS`: the organisation record, with type, dates, location and business group.
*   `HR_ALL_ORGANIZATION_UNITS_TL`: the translated organisation name.
*   `PER_BUSINESS_GROUPS`: the business group that owns the organisation, and its legislation code.
*   `HR_LOCATIONS_ALL`: the organisation location.
*   `PAY_COST_ALLOCATION_KEYFLEX`: the cost allocation key flexfield segments for HR organisations.
*   `HR_ORGANIZATION_INFORMATION`: the organisation information records, including the classification records with the context CLASS.
*   `HR_ORG_INFO_TYPES_BY_CLASS`: the information types that each classification carries, with their mandatory and enabled flags.
*   `HR_ORG_INFORMATION_TYPES` and `HR_ORG_INFORMATION_TYPES_TL`: the information type definitions and their translated names.

#### Logical Relationships
1. `HR_ALL_ORGANIZATION_UNITS` joins to `HR_ALL_ORGANIZATION_UNITS_TL` on the organisation identifier, filtered to the session language.
2. The organisation joins to `PER_BUSINESS_GROUPS` on the business group identifier, and that link carries the legislation code used for labels.
3. The organisation joins to `HR_LOCATIONS_ALL` on the location identifier, as an outer join.
4. The classification record is found in `HR_ORGANIZATION_INFORMATION` with the context CLASS.
5. The information records are matched to the classification through `HR_ORG_INFO_TYPES_BY_CLASS` and to their definitions through `HR_ORG_INFORMATION_TYPES`.
6. The cost allocation keyflex is joined only when the classification is HR organisation.

### Parameters & Filtering
*   **Upload Mode:** Chooses between create and update. Organisation information is returned only when the mode includes update.
*   **Business Group:** Restricts the organisations to the business group selected, which must be the one of the current responsibility.
*   **Organization Type and Organization Name:** Restrict the organisations by type and name.
*   **Location:** Restricts the organisations to one location.
*   **Organization Status:** Filters on whether the organisation is active on the current date.
*   **Classification and Classification Status:** Restrict the rows to one classification and to enabled or disabled classifications.
*   **Information Type:** Restricts the rows to one organisation information type.

### Performance & Optimization
*   **Business group driver:** The query is restricted to one business group, which narrows the organisations before the information joins.
*   **Pre-filtered information set:** Organisation information is pre-filtered to the general and multi-row navigation methods and to enabled information types with a matching flexfield context, which keeps the join small.
*   **Two-step upload guidance:** The description notes that self-referencing segments may need a second pass, so the first pass should create the information type and the second should update the self-referencing attribute.

### FAQ
**Q: How do I create an HR organisation with a classification in Oracle HRMS using a spreadsheet?**
A: Download the organisations for the business group, add a row with the name, type and classification, and upload the file. The Classification column controls which information types are available.

**Q: Can this upload create a new business group?**
A: No. The description states that business group creation is not supported, and the Define Organizations form must be used for that.

**Q: Which organisation information types cannot be updated after creation?**
A: The description names Business Group Information and Canada Employer Identification. These can be created but not modified by this upload.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-organization-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

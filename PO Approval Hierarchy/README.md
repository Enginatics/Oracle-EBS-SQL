---
layout: default
last_modified_at: 2026-11-09
title: 'PO Approval Hierarchy | Oracle EBS SQL Report'
description: 'Purchasing approval hierarchy: for each employee, the approvers above them level by level, with each approver''s approval groups and document total limit…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Purchasing, Enginatics, Approval, Hierarchy, hr_operating_units, financials_system_params_all, po_document_types_all_vl'
permalink: /PO%20Approval%20Hierarchy/
report_name: 'PO Approval Hierarchy'
report_web_name: po-approval-hierarchy
module: 'Purchasing'
module_url: /modules/purchasing/
---

# PO Approval Hierarchy – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/po-approval-hierarchy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy).
**Oracle EBS module:** [Purchasing](/modules/purchasing/ "Oracle EBS Purchasing reports") · [all Purchasing reports](/modules/purchasing/)  

## Overview
Purchasing approval hierarchy: for each employee, the approvers above them level by level, with each approver's approval groups and document total limit for the selected document type.

The operating unit's Use Approval Hierarchies option (Financials Options) decides the hierarchy: the position hierarchy, which defaults to the document type's default approval hierarchy, or else the supervisor chain of the primary assignments. Both are read as of the As of Date. The approval workflow reads the position hierarchy from the copy built by the Fill Employee Hierarchy program, so run that program when routing differs from this report.

One row per employee, level, approver and approval group. Level 0 is the employee's own approval authority. A position held by several people shows one row per holder, a vacant position shows the position without an approver. Employees at the top of the hierarchy appear only as approvers.

Approval Amount From is the highest document total limit below that level in the employee's chain, so each approver row shows the amount band it approves. Template By Position shows the approval chain per initiator position instead of per employee.

Approval groups are those assigned to the approver's position (position hierarchy) or job (supervisor hierarchy) for the document type in Approval Assignments. Document Total Limit is the amount limit of the group's Document Total rule; account, item and location rules are listed by PO Approval Assignments with Show Approval Group Amounts.

Use the Approver parameter to list everyone a person approves for. HR Organization includes the organizations below it in the Organization Hierarchy, which defaults to the business group's primary reporting hierarchy; leave Organization Hierarchy blank to select the HR Organization alone.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Document Type, Hierarchy, HR Organization, Organization Hierarchy, Employee, Employee Position like, Approver, As of Date, Maximum Levels

## Oracle EBS Tables Used
[hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy), [financials_system_params_all](https://www.enginatics.com/library/?pg=1&find=financials_system_params_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy), [po_document_types_all_vl](https://www.enginatics.com/library/?pg=1&find=po_document_types_all_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy), [per_position_structures](https://www.enginatics.com/library/?pg=1&find=per_position_structures&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy), [per_pos_structure_versions](https://www.enginatics.com/library/?pg=1&find=per_pos_structure_versions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy), [per_pos_structure_elements](https://www.enginatics.com/library/?pg=1&find=per_pos_structure_elements&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy), [per_all_assignments_f](https://www.enginatics.com/library/?pg=1&find=per_all_assignments_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy), [po_control_rules](https://www.enginatics.com/library/?pg=1&find=po_control_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy), [po_control_functions](https://www.enginatics.com/library/?pg=1&find=po_control_functions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy), [po_position_controls_all](https://www.enginatics.com/library/?pg=1&find=po_position_controls_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy), [po_control_groups_all](https://www.enginatics.com/library/?pg=1&find=po_control_groups_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy), [per_positions](https://www.enginatics.com/library/?pg=1&find=per_positions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy), [per_jobs_vl](https://www.enginatics.com/library/?pg=1&find=per_jobs_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy)

## Related Reports
[PO Approval Assignments](/PO%20Approval%20Assignments/ "PO Approval Assignments Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [PO Approval History](/PO%20Approval%20History/ "PO Approval History Oracle EBS SQL Report"), [PER Position Hierarchy](/PER%20Position%20Hierarchy/ "PER Position Hierarchy Oracle EBS SQL Report"), [PO Approval Groups Upload](/PO%20Approval%20Groups%20Upload/ "PO Approval Groups Upload Oracle EBS SQL Report"), [FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report"), [AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Approval%20Hierarchy/PO%20Approval%20Hierarchy.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PO Approval Hierarchy 02-Nov-2026 020116.xlsx](https://www.enginatics.com/example/po-approval-hierarchy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy) |
| Blitz Report™ XML Import | [PO_Approval_Hierarchy.xml](https://www.enginatics.com/xml/po-approval-hierarchy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy) |
| SQL Source | [PO Approval Hierarchy.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Approval%20Hierarchy/PO%20Approval%20Hierarchy.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/po-approval-hierarchy/](https://www.enginatics.com/reports/po-approval-hierarchy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-hierarchy)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

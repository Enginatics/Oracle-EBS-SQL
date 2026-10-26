---
layout: default
last_modified_at: 2026-10-26
title: 'PO Approval History | Oracle EBS SQL Report'
description: 'Approval and action history of purchase orders, releases, agreements and requisitions: one row per entry of the document''s action history (submit…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Purchasing, Enginatics, Approval, History, po_document_types_all_vl, ap_suppliers, per_all_people_f'
permalink: /PO%20Approval%20History/
report_name: 'PO Approval History'
report_web_name: po-approval-history
module: 'Purchasing'
module_url: /modules/purchasing/
---

# PO Approval History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/po-approval-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history).
**Oracle EBS module:** [Purchasing](/modules/purchasing/ "Oracle EBS Purchasing reports") · [all Purchasing reports](/modules/purchasing/)  

## Overview
Approval and action history of purchase orders, releases, agreements and requisitions: one row per entry of the document's action history (submit, forward, approve, reject, return, reserve, cancel, close, hold), in sequence.

The pending step of a document awaiting approval is shown with action Pending and the current approver as performer. Days Since Previous Action is measured from the previous history entry, for a pending step until today. Submitted Date is the latest submission up to that step.

For a release, Document Number is the number of its blanket agreement.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Document Type, Document Number, Supplier, Performer, Action, Action Date From, Action Date To, Pending Only

## Oracle EBS Tables Used
[po_document_types_all_vl](https://www.enginatics.com/library/?pg=1&find=po_document_types_all_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history), [per_position_structures](https://www.enginatics.com/library/?pg=1&find=per_position_structures&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history), [po_action_history](https://www.enginatics.com/library/?pg=1&find=po_action_history&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history)

## Related Reports
[PO Procure to Pay Tracker](/PO%20Procure%20to%20Pay%20Tracker/ "PO Procure to Pay Tracker Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [PO Cancelled Purchase Orders](/PO%20Cancelled%20Purchase%20Orders/ "PO Cancelled Purchase Orders Oracle EBS SQL Report"), [PO Cancelled Requisitions](/PO%20Cancelled%20Requisitions/ "PO Cancelled Requisitions Oracle EBS SQL Report"), [PO Vendor Service Performance Analysis](/PO%20Vendor%20Service%20Performance%20Analysis/ "PO Vendor Service Performance Analysis Oracle EBS SQL Report"), [PO Purchase Requisitions with PO Details](/PO%20Purchase%20Requisitions%20with%20PO%20Details/ "PO Purchase Requisitions with PO Details Oracle EBS SQL Report"), [PO Requisition Template Upload](/PO%20Requisition%20Template%20Upload/ "PO Requisition Template Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Approval%20History/PO%20Approval%20History.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PO Approval History 15-Oct-2026 022546.xlsx](https://www.enginatics.com/example/po-approval-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history) |
| Blitz Report™ XML Import | [PO_Approval_History.xml](https://www.enginatics.com/xml/po-approval-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history) |
| SQL Source | [PO Approval History.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Approval%20History/PO%20Approval%20History.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/po-approval-history/](https://www.enginatics.com/reports/po-approval-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history) |

## Case Study & Technical Analysis: PO Approval History

### Executive Summary
PO Approval History lists the approval and action history of Oracle Purchasing documents: purchase orders, blanket and contract agreements, releases and requisitions. It returns one row for each entry of a document's action history, in sequence, from submission through forwarding, approval, rejection, return, reservation, cancellation, closure and hold. Procurement managers, internal audit and purchasing supervisors use it to see who approved a document, how long each approval step took, and which documents are waiting for an approver today.

### Business Challenge
*   **Approval Bottlenecks:** Purchase orders that sit in an approval queue delay supplier commitments, and the approver responsible must be identified.
*   **Control Evidence:** Auditors need a dated record of every approval, rejection and return for a sample of documents.
*   **Cycle Time:** Procurement leaders want to measure the number of days between approval steps to shorten the purchase-to-approval cycle.
*   **Pending Work:** Approvers and buyers need a list of documents currently awaiting action, with the current approver shown.

### The Solution
*   **Full Action Trail:** Each action in the history is a row, with its sequence, action, performer, action date and note.
*   **Pending Step Display:** A document awaiting approval shows a Pending action with the current approver as performer.
*   **Elapsed Time:** Days since the previous action are calculated from the previous history entry, and for a pending step they are measured to today.
*   **Document Context:** The document type, number, release, revision, supplier, status, approval path, buyer or preparer and creator are shown on each row.

### Technical Architecture (High Level)
#### Primary Tables
*   `PO_ACTION_HISTORY`: the action history of each document, with the object type, object identifier, sequence, action code, performer, date and note.
*   `PO_HEADERS_ALL`: purchase orders and agreements, with the document number, status, supplier, buyer and creation details.
*   `PO_RELEASES_ALL`: releases against blanket agreements, with the release number and the agreement reference.
*   `PO_REQUISITION_HEADERS_ALL`: requisitions, with their number, description and preparer.
*   `PO_DOCUMENT_TYPES_ALL_VL`: the document type names for each object type and subtype.
*   `AP_SUPPLIERS`: the supplier names.
*   `PER_ALL_PEOPLE_F`: the names of the performer, the buyer and the preparer.
*   `PER_POSITION_STRUCTURES`: the approval path names.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit names.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units the user can access.

#### Logical Relationships
1.  Each row of `PO_ACTION_HISTORY` is restricted to the purchase order, agreement, release and requisition object types.
2.  Purchase orders and agreements are outer joined to `PO_HEADERS_ALL` on the object identifier.
3.  Releases are outer joined to `PO_RELEASES_ALL`, and the release's blanket agreement is outer joined to `PO_HEADERS_ALL` for the agreement number.
4.  Requisitions are outer joined to `PO_REQUISITION_HEADERS_ALL` on the object identifier.
5.  The operating unit is taken from whichever document header is present and joined to `HR_ALL_ORGANIZATION_UNITS_VL`.
6.  Window functions over each document's history supply the previous action date and the latest submission date.

### Parameters & Filtering
*   **Operating Unit:** Restricts the documents to one operating unit.
*   **Document Type:** Restricts the output to one document type.
*   **Document Number:** Selects one document by its number.
*   **Supplier:** Restricts the documents to one supplier.
*   **Performer:** Restricts the history to actions performed by one person.
*   **Action:** Restricts the output to one action.
*   **Action Date From and Action Date To:** Limit the actions to a date range.
*   **Pending Only:** Returns only the documents with a step awaiting action.

### Performance & Optimization
*   **Object Type Restriction:** The history is limited to four object types at the start, so unrelated history rows are not read.
*   **Operating Unit Security:** Documents are restricted through the multi-org access table, which limits the scan to permitted operating units.
*   **Single Pass Window Logic:** The previous action date and the latest submission date are calculated with analytic functions over each document, which avoids self joins to the history.
*   **Correlated Name Lookups:** Names of people, suppliers and approval paths are fetched through correlated subqueries that return one value each.

### FAQ
**Q: How do I find the approver of a purchase order that is still pending?**
A: Set Pending Only to Yes and enter the document number. The row with the Pending action shows the current approver as the performer.

**Q: How is Days Since Previous Action calculated?**
A: It is the number of days between the action and the previous history entry of the same document. For a pending step it is measured to today.

**Q: What does the Submitted Date column show?**
A: It shows the date of the latest submission on or before that history step.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-approval-history)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

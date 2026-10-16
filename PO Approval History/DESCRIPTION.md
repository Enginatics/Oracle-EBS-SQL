# Case Study & Technical Analysis: PO Approval History

## Executive Summary
PO Approval History lists the approval and action history of Oracle Purchasing documents: purchase orders, blanket and contract agreements, releases and requisitions. It returns one row for each entry of a document's action history, in sequence, from submission through forwarding, approval, rejection, return, reservation, cancellation, closure and hold. Procurement managers, internal audit and purchasing supervisors use it to see who approved a document, how long each approval step took, and which documents are waiting for an approver today.

## Business Challenge
*   **Approval Bottlenecks:** Purchase orders that sit in an approval queue delay supplier commitments, and the approver responsible must be identified.
*   **Control Evidence:** Auditors need a dated record of every approval, rejection and return for a sample of documents.
*   **Cycle Time:** Procurement leaders want to measure the number of days between approval steps to shorten the purchase-to-approval cycle.
*   **Pending Work:** Approvers and buyers need a list of documents currently awaiting action, with the current approver shown.

## The Solution
*   **Full Action Trail:** Each action in the history is a row, with its sequence, action, performer, action date and note.
*   **Pending Step Display:** A document awaiting approval shows a Pending action with the current approver as performer.
*   **Elapsed Time:** Days since the previous action are calculated from the previous history entry, and for a pending step they are measured to today.
*   **Document Context:** The document type, number, release, revision, supplier, status, approval path, buyer or preparer and creator are shown on each row.

## Technical Architecture (High Level)
### Primary Tables
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

### Logical Relationships
1.  Each row of `PO_ACTION_HISTORY` is restricted to the purchase order, agreement, release and requisition object types.
2.  Purchase orders and agreements are outer joined to `PO_HEADERS_ALL` on the object identifier.
3.  Releases are outer joined to `PO_RELEASES_ALL`, and the release's blanket agreement is outer joined to `PO_HEADERS_ALL` for the agreement number.
4.  Requisitions are outer joined to `PO_REQUISITION_HEADERS_ALL` on the object identifier.
5.  The operating unit is taken from whichever document header is present and joined to `HR_ALL_ORGANIZATION_UNITS_VL`.
6.  Window functions over each document's history supply the previous action date and the latest submission date.

## Parameters & Filtering
*   **Operating Unit:** Restricts the documents to one operating unit.
*   **Document Type:** Restricts the output to one document type.
*   **Document Number:** Selects one document by its number.
*   **Supplier:** Restricts the documents to one supplier.
*   **Performer:** Restricts the history to actions performed by one person.
*   **Action:** Restricts the output to one action.
*   **Action Date From and Action Date To:** Limit the actions to a date range.
*   **Pending Only:** Returns only the documents with a step awaiting action.

## Performance & Optimization
*   **Object Type Restriction:** The history is limited to four object types at the start, so unrelated history rows are not read.
*   **Operating Unit Security:** Documents are restricted through the multi-org access table, which limits the scan to permitted operating units.
*   **Single Pass Window Logic:** The previous action date and the latest submission date are calculated with analytic functions over each document, which avoids self joins to the history.
*   **Correlated Name Lookups:** Names of people, suppliers and approval paths are fetched through correlated subqueries that return one value each.

## FAQ
**Q: How do I find the approver of a purchase order that is still pending?**
A: Set Pending Only to Yes and enter the document number. The row with the Pending action shows the current approver as the performer.

**Q: How is Days Since Previous Action calculated?**
A: It is the number of days between the action and the previous history entry of the same document. For a pending step it is measured to today.

**Q: What does the Submitted Date column show?**
A: It shows the date of the latest submission on or before that history step.

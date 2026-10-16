# Case Study & Technical Analysis: PO Requisition Upload 11i

## Executive Summary
The PO Requisition Upload 11i creates and updates purchase requisitions in Oracle Purchasing. It is written for buyers, requisitioners and procurement administrators who must raise or revise requisitions in bulk. For an existing requisition the user can amend header description, quantity, price, need-by date, buyer, currency and conversion terms, and new requisitions are created by entering the line type, source, item, category, quantity, destination and delivery details. The report is an upload in the Purchasing area, and it is the 11i version of the requisition upload.

## Business Challenge
*   **Bulk requisition entry:** Requisitions for a large project or programme can run to hundreds of lines, and keying each line in the form is slow and error prone.
*   **Correcting open requisitions:** Need-by dates, quantities, prices and buyers change after a requisition is raised, and each change must be made without re-entering the whole requisition.
*   **Accurate currency and rate:** Foreign currency requisitions need the currency, conversion type, rate and date recorded correctly for the purchase order that follows.

## The Solution
*   **Header and line in one file:** The report returns the requisition header with its preparer, note and flexfield values, and each line with its item, category, quantity and price.
*   **Editable fields for existing requisitions:** The user can change header description, quantity, unit price, need-by date, reference number, supplier item, buyer, note to buyer, currency and conversion details.
*   **Distribution detail:** Each line's distributions show the charge account segments, project, task, expenditure type and expenditure organisation, so the accounting of the requisition is visible.
*   **Creation of new requisitions:** A new requisition is created by entering the required fields listed in the description, including line type, source type, item, category, unit of measure and destination.

## Technical Architecture (High Level)
### Primary Tables
*   `PO_REQUISITION_HEADERS_ALL`: the requisition header, with its number, preparer, type, description and authorisation status.
*   `PO_REQUISITION_LINES_ALL`: the requisition lines, with item, quantity, price, need-by date, destination and source details.
*   `PO_REQ_DISTRIBUTIONS_ALL`: the requisition distributions, which carry the charge account, project and task.
*   `GL_CODE_COMBINATIONS`: the charge account segments.
*   `PA_PROJECTS_ALL` and `PA_TASKS_V`: the projects and tasks of the distributions.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit and the expenditure organisation.
*   `MTL_SYSTEM_ITEMS_VL` and `MTL_CATEGORIES_V`: the item and category.
*   `PER_ALL_PEOPLE_F`: the preparer, requestor and buyer, each checked against the current date.
*   `PO_DOCUMENT_TYPES_ALL_B` and `PO_DOCUMENT_TYPES_ALL_TL`: the requisition document type.
*   `PO_DISTRIBUTIONS_ALL`: used to exclude requisition lines that already have purchase order distributions.

### Logical Relationships
1. `PO_REQUISITION_HEADERS_ALL` joins to `PO_REQUISITION_LINES_ALL` on the requisition header identifier, and the lines join to `PO_REQ_DISTRIBUTIONS_ALL` on the requisition line identifier.
2. Each distribution joins to `GL_CODE_COMBINATIONS` on the code combination identifier and to `PA_PROJECTS_ALL` and `PA_TASKS_V` for project and task.
3. Each line joins to `MTL_SYSTEM_ITEMS_VL` on the item and the inventory organisation returned by the org lookup function, and to `MTL_CATEGORIES_V` on the category identifier.
4. The preparer, requestor and buyer are resolved from `PER_ALL_PEOPLE_F` on their identifiers, each within its effective dates.
5. Requisition lines with any purchase order distribution are excluded by a `not exists` condition.

## Parameters & Filtering
*   **Operating Unit:** Restricts the requisitions to one operating unit.
*   **Upload Mode:** Chooses whether the file is used to create or update requisitions.
*   **Initiate Approval on Import:** Controls whether imported requisitions start the approval process.
*   **Need By Date From and To:** Bound the need-by dates of the lines.
*   **Requestor Name and Buyer Name:** Restrict the requisitions by requestor or buyer.
*   **Authorization Status:** Filters on the approval status of the requisition.

## Performance & Optimization
*   **Authorisation status exclusion:** Requisitions that are cancelled, pre-approved, in process or system saved are excluded before the detail joins, which keeps the working set to editable requisitions.
*   **Lines without purchase orders:** The `not exists` check removes lines that already have purchase order distributions, so only open requisition lines are returned.
*   **Outer joins for optional references:** Project, task, category, location and expenditure organisation references are attached with outer joins, so lines without those references are kept.

## FAQ
**Q: How do I change the need-by date on many open requisitions in Oracle Purchasing?**
A: Download the requisitions with the Need By Date parameters, amend the need-by date column on the rows to change, and upload the file in update mode.

**Q: Which requisition fields can be changed on an existing requisition?**
A: The description lists header description, quantity, unit price, need-by date, reference number, supplier item, buyer, note to buyer, currency, conversion type, conversion rate and conversion date.

**Q: Why are requisitions with purchase orders missing from the download?**
A: Requisition lines that already have a purchase order distribution are excluded by the query, so only open lines are returned.

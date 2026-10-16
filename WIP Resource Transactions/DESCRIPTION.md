# Case Study & Technical Analysis: WIP Resource Transactions

## Executive Summary
WIP Resource Transactions lists the Work in Process resource, overhead and outside processing transactions, one row for each transaction, as shown in the View Resource Transactions form. It gives the job, line, assembly, operation, department, resource, employee, activity, quantity, rate and amount of each charge posted to production. Cost accountants, production controllers and plant managers use it to review labour and machine time booked against jobs, to check standard versus actual rates, and to confirm which charges were transferred to projects.

## Business Challenge
*   **Labor and Machine Costing:** Production costs depend on the time booked against each resource, and cost accountants need the detail behind the totals.
*   **Standard Versus Actual:** Variances between standard and actual resource rates must be identified to explain cost movements.
*   **Outside Processing:** Work sent to suppliers must be traced to the purchase order that paid for it.
*   **Project Billing:** Charges on project-based jobs must be transferred to projects, and the transfer status must be visible.

## The Solution
*   **Transaction Detail:** Each transaction is listed with its type, job, line, assembly, operation, department, resource and charge basis.
*   **Quantity and Rate:** Transaction quantity, primary quantity, usage rate, actual rate and standard rate are shown together, so variances are visible.
*   **Employee and Activity:** The employee number and name, the activity, and the reason are returned for each transaction.
*   **Project Transfer Status:** The transferred to projects value shows whether a charge was transferred, not transferred or not applicable.

## Technical Architecture (High Level)
### Primary Tables
*   `WIP_TRANSACTIONS`: the resource, overhead and outside processing transactions, with quantities, rates, dates and source references.
*   `WIP_ENTITIES`: the jobs and schedules, with their names and entity types.
*   `WIP_LINES`: the production lines.
*   `MTL_SYSTEM_ITEMS_VL`: the assembly items.
*   `BOM_DEPARTMENTS`: the departments.
*   `BOM_RESOURCES`: the resources, with their codes, descriptions and types.
*   `CST_ACTIVITIES`: the cost activities.
*   `PER_ALL_PEOPLE_F`: the employees, effective on the transaction date.
*   `MTL_TRANSACTION_REASONS`: the transaction reasons.
*   `PO_HEADERS_ALL`: the purchase orders for outside processing.
*   `PA_PROJECTS_ALL` and `PA_TASKS`: the projects and tasks for project-related charges.
*   `MTL_PARAMETERS`: the organizations.
*   `ORG_ACCESS_VIEW`: the organizations the user can access.

### Logical Relationships
1.  Each transaction in `WIP_TRANSACTIONS` is joined to its organization in `MTL_PARAMETERS`, restricted to organizations the user can access.
2.  Transactions are joined to their job in `WIP_ENTITIES`, and outer joined to their line in `WIP_LINES`.
3.  The assembly is outer joined to `MTL_SYSTEM_ITEMS_VL` on the organization and inventory item.
4.  The department is outer joined to `BOM_DEPARTMENTS` using the charge department when present, otherwise the department.
5.  The resource, activity, reason, purchase order, project and task are outer joined to their definition tables.
6.  The employee is outer joined to `PER_ALL_PEOPLE_F` on the employee identifier, with the transaction date falling in the person's effective period.

## Parameters & Filtering
*   **Organization Code:** Restricts the transactions to one organization.
*   **Date From and Date To:** Limit the transactions to a transaction date window.
*   **Job, Line and Assembly:** Select transactions for one job, production line or assembly.
*   **Department and Resource and Resource Type:** Select transactions for one department, resource or resource type.
*   **Employee Number:** Restricts the output to one employee.
*   **Activity and Reason:** Restrict the output to one cost activity or one transaction reason.
*   **PO Number:** Restricts the output to outside processing charges on one purchase order.
*   **Transferred to Projects:** Filters the transactions by their project transfer status.
*   **Transaction Type:** Restricts the output to one transaction type.
*   **Include Variance Transactions:** Controls whether variance transactions are included.

## Performance & Optimization
*   **Organization Access First:** The organization restriction is applied before the transaction join, so only permitted organizations are scanned.
*   **Transaction Type List:** Only the resource, overhead and outside processing transaction types are read, which limits the transaction table scan.
*   **Date Driven Employee Join:** The employee join is limited to the person's effective period, so each transaction matches one employee record.
*   **Outer Joins for Optional Sources:** Purchase order, project and task joins are optional, so transactions without them still appear.

## FAQ
**Q: What is the difference between Quantity and Primary Quantity?**
A: Quantity is in the unit of measure the transaction was entered in. Primary Quantity is in the resource's unit of measure.

**Q: Why are some pending transactions missing?**
A: Transactions still pending in the resource transaction interface are not included in the report.

**Q: How do I check outside processing charges for one purchase order?**
A: Enter the purchase order number in the PO Number parameter. The transactions for that order are returned with their quantities and amounts.

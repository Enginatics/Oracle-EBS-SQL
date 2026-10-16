# Case Study & Technical Analysis: QA Collection Plan Transactions

## Executive Summary
The QA Collection Plan Transactions report shows every transaction that an Oracle Quality collection plan is attached to, together with the trigger conditions that decide whether collection fires. It is written for quality engineers and Oracle Quality administrators who need to know when a collection plan actually collects results, for example on receiving or completion transactions. A plan attached to a transaction is only a definition until the attachment exists, and each trigger narrows the collection further, so the report shows both layers. For each attachment it returns the mandatory, background and enabled flags, and for each trigger the field, database column, datatype, operator and values. It sits in the Quality module.

## Business Challenge
*   **Knowing when collection happens:** A collection plan can be defined correctly and still never collect, because it has not been attached to a transaction or because its triggers do not match the transactions being processed.
*   **Mandatory collection risk:** A mandatory collection blocks saving the transaction without quality results, so administrators must know which transactions carry this requirement.
*   **Background collection:** Results collected without prompting the operator change the operator's workload and the completeness of the data.
*   **Tracing triggers to data:** A trigger shown to an implementer as a form prompt must be linked to the database column that a data load has to supply.

## The Solution
*   **Attachments by transaction:** Each row shows a plan attached to a transaction, with its mandatory, background and enabled flags.
*   **Attachment count:** The number of attachments of a plan to a transaction is shown, so several attachments with different triggers are distinguished from one.
*   **Trigger detail:** Each trigger shows its collection element, the form prompt and the database field from the transaction's trigger list, its datatype, operator and low and high values.
*   **Unconditional attachments:** Attachments with no trigger are listed with a blank trigger, so unconditional collection is visible.

## Technical Architecture (High Level)
### Primary Tables
*   `QA_PLAN_TRANSACTIONS`: the attachment of a plan to a transaction, with mandatory, background and enabled flags.
*   `QA_TXN_COLLECTION_TRIGGERS`: the list of triggers available for each transaction, with the form description and database field.
*   `QA_PLANS`: the collection plans.
*   `MTL_PARAMETERS`: the inventory organisation of each plan.
*   `QA_PLAN_COLLECTION_TRIGGERS`: the trigger conditions attached to each plan attachment, with operator and values.
*   `QA_CHARS`: the collection element that each trigger tests.
*   `ORG_ACCESS_VIEW`: the organisations accessible to the current responsibility.

### Logical Relationships
1. `QA_PLANS` joins to `MTL_PARAMETERS` as an outer join on the organisation identifier.
2. `QA_PLANS` joins to `QA_PLAN_TRANSACTIONS` on the plan identifier.
3. Each attachment joins to `QA_PLAN_COLLECTION_TRIGGERS` as an outer join on the plan transaction identifier, so unconditional attachments are kept.
4. Each trigger joins to `QA_CHARS` as an outer join on the trigger identifier, to give the element name and datatype.
5. The trigger's form description and database field are read from `QA_TXN_COLLECTION_TRIGGERS` by transaction number and trigger identifier, through scalar subqueries.
6. Results are ordered by organisation, plan name, transaction name, attachment identifier and element name.

## Parameters & Filtering
*   **Organization:** Restricts the plans to one inventory organisation.
*   **Collection Plan and Plan Type:** Restrict the output to one plan or plan type.
*   **Transaction:** Restricts the attachments to one transaction, such as receiving or completion transactions.
*   **Collection Trigger:** Restricts the output to attachments that test one trigger element.
*   **Mandatory Collection Only:** When set, restricts the output to attachments with the mandatory flag.
*   **Enabled Transactions Only:** When set, restricts the output to enabled attachments.

## Performance & Optimization
*   **Organisation access filter:** Plans are limited to the access view for the current responsibility and to organisation zero, which holds the template plans.
*   **Outer joins to keep unconditional attachments:** Trigger conditions are joined with outer joins, so an attachment without triggers returns one row with blank trigger columns.
*   **Scalar subqueries for trigger text:** Form description and database field are read from the transaction trigger list in correlated subqueries, which resolve one row per trigger.

## FAQ
**Q: Why does my collection plan not collect results for a transaction?**
A: The plan must be attached to the transaction, and its trigger conditions must match the transaction. The report shows both the attachment and the trigger conditions.

**Q: What does Mandatory Collection mean for an operator?**
A: The description states that the transaction cannot be saved without quality results when Mandatory Collection is set.

**Q: How do I trace a trigger condition to the column a data load must supply?**
A: Read the Trigger Field, which is the form prompt, and the Trigger Database Field, which is the column behind it, on the same row.

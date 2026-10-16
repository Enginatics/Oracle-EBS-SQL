# Case Study & Technical Analysis: QA Plan Relationship Upload

## Executive Summary
The QA Plan Relationship Upload creates, updates and deletes parent and child relationships between Oracle Quality collection plans. It is written for quality administrators who set up linked collection plans, where results captured on a parent plan automatically or manually lead to child plan records. The upload maintains three things through the standard Oracle API for quality parent-child packages: the plan relationship, the element relationships between the parent and child plans, and the criteria that decide when child records are created automatically. It sits in the Quality module and is shown in Excel through Blitz Report.

## Business Challenge
*   **Linked inspection plans:** Some inspections need a child plan to record detail results once a parent plan has been completed, and each link must be defined for every parent plan.
*   **Choosing the entry mode:** The team must decide whether child data is entered immediately, later by hand, created automatically when the parent matches criteria, or created whenever the parent changes.
*   **Mapping elements between plans:** Parent and child plans need elements mapped to each other, so that values flow correctly between them.
*   **Setting up criteria:** Automatic child creation depends on criteria tests against parent elements, and these must be maintained consistently across many relationships.

## The Solution
*   **Relationship in one row:** Each row shows the organisation, parent plan, child plan, entry mode, layout mode, auto row count and default parent specification.
*   **Element mapping:** The parent element, child element and relationship type of each element pair are shown, with the link flag.
*   **Criteria detail:** Each criteria test shows the element it tests, its operator and the from and to values.
*   **Identifiers for maintenance:** The plan relationship, element relationship and criteria identifiers are returned, so an update or deletion targets the right record.
*   **Delete marker:** A delete record column allows a row to be flagged for removal through the API.

## Technical Architecture (High Level)
### Primary Tables
*   `QA_PC_PLAN_RELATIONSHIP`: the relationship between a parent plan and a child plan, with entry mode, layout mode and automatic row count.
*   `QA_PC_ELEMENT_RELATIONSHIP`: the mapping of elements between a parent and a child plan.
*   `QA_PC_CRITERIA`: the criteria that decide automatic child record creation.
*   `QA_PLANS`: the parent and child collection plans.
*   `QA_CHARS`: the collection elements of the parent, child and criteria columns.
*   `MTL_PARAMETERS`: the inventory organisation that owns the parent plan.

### Logical Relationships
1. `MTL_PARAMETERS` joins to the parent plan in `QA_PLANS` on the organisation identifier.
2. The parent plan joins to `QA_PC_PLAN_RELATIONSHIP` on the parent plan identifier, and the child plan joins to the relationship on the child plan identifier.
3. Element relationships join to the plan relationship as an outer join, so a relationship without element mappings is still listed.
4. The parent and child elements join to `QA_CHARS` as outer joins through the element relationship.
5. Criteria join to the plan relationship as an outer join, and the criteria element joins to `QA_CHARS` as an outer join.

## Parameters & Filtering
*   **Upload Mode:** Chooses between create, update and delete operations, which determines the use of the delete record column.
*   **Organization:** Restricts the relationships to parent plans in one inventory organisation.
*   **Parent Plan:** Restricts the output to relationships from one parent plan.
*   **Child Plan:** Restricts the output to relationships to one child plan.

## Performance & Optimization
*   **Parent-driven query:** The query starts from the parent plans of the selected organisation, so the relationship table is read only for those plans.
*   **Outer joins for dependent records:** Element relationships and criteria are attached with outer joins, so a plan relationship without elements or criteria still appears for maintenance.
*   **Small configuration set:** Plan relationships are configuration records, so the output is typically small, and the main cost is the join chain across the plan and element tables.

## FAQ
**Q: How do I set up a child plan that is created automatically from a parent plan?**
A: Set the entry mode to automatic in the file, specify the criteria for the child creation, and upload the file. The description lists Automatic as the mode where child records are created when the parent matches the criteria.

**Q: What is the difference between Immediate and Delayed entry modes?**
A: Immediate means the child data is entered straight after the parent record, while Delayed means the child records are entered manually later.

**Q: Can this upload remove a parent-child relationship?**
A: Yes. The delete record column allows a relationship row to be deleted through the standard API, as the description states for the create, update and delete operations.

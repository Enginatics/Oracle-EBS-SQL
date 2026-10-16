# Case Study & Technical Analysis: QA Collection Plan Elements

## Executive Summary
The QA Collection Plan Elements report lists every collection element assigned to an Oracle Quality collection plan, with its prompt and sequence on the plan, its element type, datatype, display length, decimal precision and unit of measure. It also shows the plan level and element level default values, the Mandatory, Enabled, Displayed, Read Only, Information and Poplist flags, and the validation sources of each element. Quality engineers use it to document or audit a quality setup, and integration developers use it as the specification for an interface or an upload that writes collection results. It runs in Excel through Blitz Report.

## Business Challenge
*   **Setup documentation:** A collection plan can contain many elements, and the audit of a plan requires each element's type, flags and defaults in one list.
*   **Generic result storage:** Oracle Quality stores every collection result in one generic table, so the meaning of each result column must be known before results can be read or loaded.
*   **Validation review:** An element can be validated by a table, by a SQL string or by plan level values, and each source must be checked during a Quality audit.
*   **Interface design:** A system that loads collection results needs the exact column mapping for each plan.

## The Solution
*   Lists each plan with its organization, plan type and effective dates, and each element assigned to it in the prompt sequence of the plan.
*   Shows the Result Column of each element, which is the name of the column in the plan's results view, next to the element's hardcoded column, so a difference between them is visible.
*   Shows whether the element is a Context Element, a characteristic that the operator enters, or a predefined reference captured from the transaction.
*   Shows the validation table and where clause, the SQL validation string and the number of plan level values offered by the element.

## Technical Architecture (High Level)
### Primary Tables
*   `QA_PLANS`: the collection plan, with its name, description, type, effective dates and organization.
*   `QA_PLAN_CHARS`: the elements assigned to each plan, with the prompt, sequence, flags, defaults, result column name and value flags.
*   `QA_CHARS`: the element definition, with the name, element type, datatype, display length, validation and specification settings.
*   `QA_PLAN_CHAR_VALUE_LOOKUPS`: the plan level values of an element, counted for each plan element.
*   `MTL_PARAMETERS`: the organization code of the plan.
*   `MTL_UNITS_OF_MEASURE_VL`: the unit of measure names.
*   `ORG_ACCESS_VIEW`: the organizations that the responsibility can access.

### Logical Relationships
1.  `QA_PLANS` is outer joined to `MTL_PARAMETERS` on the organization id, which gives the organization code of each plan.
2.  `QA_PLANS` is outer joined to `QA_PLAN_CHARS` on the plan id, so a plan with no elements is still listed.
3.  `QA_PLAN_CHARS` is outer joined to `QA_CHARS` on the character id, which supplies the element definition.
4.  The number of plan level values is a count from `QA_PLAN_CHAR_VALUE_LOOKUPS` on the plan id and character id.
5.  The organization restriction includes plans whose organization id is 0, the seeded template plans, and plans whose organization the responsibility can access.

## Parameters & Filtering
*   **Organization:** limits the plans to one inventory organization.
*   **Collection Plan:** selects one plan by name.
*   **Plan Type:** selects plans of one type.
*   **Collection Element:** selects one element by name.
*   **Element Type:** selects elements of one element type.
*   **Enabled Elements Only:** when set to Yes, hides elements that are disabled on the plan.

## Performance & Optimization
*   The organization access check is a subquery on `ORG_ACCESS_VIEW`, which restricts the plans read to the responsibility's organizations.
*   The value count is a correlated subquery that runs once per plan element, and it reads only the value lookups of that element.
*   Filtering by Collection Plan or Collection Element reduces the plan element rows before the lookups to units of measure and validation fields.
*   The unit of measure lookup uses the view with translated names, and it is an outer join on the unit code, so it adds no rows.

## FAQ
**Q: What does the Result Column show?**
A: It is the name of the column in the plan's dynamically generated results view that stores this element, as held in QA_PLAN_CHARS.RESULTCOLUMNNAME.

**Q: Why are plans with no elements listed?**
A: The plans are outer joined to their elements, so a plan without any elements appears with blank element columns.

**Q: How do I see which plans use a validation table?**
A: The Validation Table and Validation Where Clause columns show the table and its additional where clause for each element. Filter the output on those columns to find the plans.

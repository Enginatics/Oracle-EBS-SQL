# Case Study & Technical Analysis: QA Collection Plan Element Values

## Executive Summary
The QA Collection Plan Element Values report lists the allowed values behind every list-validated Oracle Quality collection element. These are the entries an operator can pick when recording quality results, and the master values each collection plan was seeded from. It is written for quality engineers, Oracle Quality administrators and implementation consultants who must confirm which codes a plan will accept before results are entered or loaded. The report separates the two places where Oracle Quality keeps these values, the plan's own value list and the collection element master, so that differences between them are visible.
## Business Challenge
*   **Validating result entry:** Quality results entered against a plan must use codes the plan offers, and an implementer needs to see that list before operators use it.
*   **Plan drift from the master:** A plan is seeded from the element master but is not tied to it afterwards, so codes can be added to a plan that are absent from the master, or descriptions can differ.
*   **Interpreting stored results:** Collection results are stored generically, so a short code must be traced to the result column that holds it in order to be given a business meaning.

## The Solution
*   **Two value levels, one list:** Each row is marked as either Plan, meaning the value is offered on the plan, or Element, meaning it exists on the master but was not carried into the plan.
*   **Master comparison:** For plan values, the element master's description for the same short code is shown, along with whether the code exists in the master at all.
*   **Override detection:** Rows where the plan's wording differs from the master's are flagged as overridden.
*   **Result column mapping:** The result column in which each element's value is stored is returned, linking a short code to its storage location.

## Technical Architecture (High Level)
### Primary Tables
*   `QA_PLANS`: the collection plans, with name, description and plan type.
*   `QA_PLAN_CHARS`: the elements attached to each plan, with prompt, sequence, result column and enabled and mandatory flags.
*   `QA_CHARS`: the collection element master, with its name, type, datatype and context.
*   `QA_PLAN_CHAR_VALUE_LOOKUPS`: the value list carried by each plan for each element.
*   `QA_CHAR_VALUE_LOOKUPS`: the master value list for each element.
*   `MTL_PARAMETERS`: the inventory organisation of each plan.

### Logical Relationships
1. `QA_PLANS` joins to `MTL_PARAMETERS` as an outer join on the organisation identifier, so plans without an organisation, such as templates, are still listed.
2. Plan elements join to `QA_PLANS` on the plan identifier and to `QA_CHARS` on the element identifier.
3. Plan value lists join to the plan elements on the plan and element identifiers, and to the master value list on the element and short code, as an outer join.
4. The Element branch selects master values that have no matching plan value, using a `not exists` condition on the plan value list.
5. The two branches are combined with `union all` and ordered by organisation, plan name, prompt sequence, element name and short code.

## Parameters & Filtering
*   **Organization:** Restricts the plans to one inventory organisation.
*   **Collection Plan:** Restricts the output to one plan.
*   **Plan Type:** Restricts the plans to one plan type.
*   **Collection Element:** Restricts the output to one element.
*   **Enabled Elements Only:** Restricts the output to elements that are enabled on the plan.
*   **Value Level:** Isolates the Plan or Element level.
*   **Short Code:** Finds one code across all plans and elements.

## Performance & Optimization
*   **Access-controlled plans:** Plans are limited to organisations in the access view for the current responsibility, or to organisation zero, which holds the template plans.
*   **Two-branch design:** The plan level and element level are separate branches, each with its own driving set, so the anti-join for element-only values is evaluated only in the second branch.
*   **Outer joins for master values:** Master descriptions are attached with outer joins, so plan values that are not in the master remain in the output.

## FAQ
**Q: Which values can an operator pick when entering quality results on a collection plan?**
A: Rows with the Plan value level are the values offered on that plan, and they are what quality results entry must validate against.

**Q: What does it mean when a value is listed as Element?**
A: The value is defined on the collection element master but was not carried into the plan, so it is not offered on that plan.

**Q: How do I see which plan values have different wording from the master?**
A: Read the Description Overridden column, which is set where the plan's description differs from the element master's description for the same short code.

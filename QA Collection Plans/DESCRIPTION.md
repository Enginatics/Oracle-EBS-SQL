# Case Study & Technical Analysis: QA Collection Plans

## Executive Summary
The QA Collection Plans report lists one row per Oracle Quality collection plan, with its type, effective dates, instructions, specification type, electronic signature mode and template plan. Each row also names the plan's generated results view and import view, shows whether those views exist in the database, and counts the elements, element values, transactions, triggers, action rules, actions, and parent and child plans attached to it. Quality engineers and Quality administrators use it as a one-page map of a Quality setup. It is the quickest way to find a plan whose generated view was never built or was dropped, because such a plan cannot be queried or imported through that view. The report runs in Excel via Blitz Report.

## Business Challenge
*   **Broken collection plans:** A plan whose generated results or import view is missing cannot be queried or imported, and its failure is not visible in the plan list.
*   **Unused elements:** Plans that carry elements which are not enabled, or elements that collect nothing, make the setup hard to maintain.
*   **Action firing on entry:** Plans with action rules fire actions on data entry, and administrators must know which plans do this.
*   **Nested plans:** Parent and child plan structures must be understood before a change to one plan affects another.

## The Solution
*   **View existence check:** The results view and import view names are shown with a Yes or No flag for whether the view exists.
*   **Setup counts:** Element, enabled element, element value, transaction, transaction trigger, action rule, action, child plan and parent plan counts are returned for each plan.
*   **Effective status:** Active is Yes when the current date falls within the plan's effective dates, and a plan with no effective dates is always active.
*   **Specification type:** The specification the plan matches against at collection time is named as item, supplier, customer, or none.
*   **Template plans:** The seeded template plans are included, and they show a blank organization code because they are not owned by an inventory organization.

## Technical Architecture (High Level)
### Primary Tables
*   `QA_PLANS`: the collection plan header, with name, description, type, effective dates, specification type, signature mode, and the results and import view names.
*   `QA_PLAN_CHARS`: the plan elements, with an enabled flag for each.
*   `QA_PLAN_CHAR_VALUE_LOOKUPS`: the element values for lookup-based elements.
*   `QA_PLAN_TRANSACTIONS`: the transactions defined for the plan.
*   `QA_PLAN_COLLECTION_TRIGGERS`: the collection triggers attached to plan transactions.
*   `QA_PLAN_CHAR_ACTION_TRIGGERS`: the action rules on elements.
*   `QA_PLAN_CHAR_ACTIONS`: the actions that each action rule runs.
*   `QA_PC_PLAN_RELATIONSHIP`: the parent and child plan links.
*   `USER_VIEWS`: the database views, used to test whether the generated views exist.
*   `MTL_PARAMETERS`: the inventory organization code.
*   `ORG_ACCESS_VIEW`: the organizations accessible to the current responsibility.

### Logical Relationships
1. `QA_PLANS` is outer joined to `MTL_PARAMETERS` on organization identifier.
2. The results view and import view names of `QA_PLANS` are outer joined to `USER_VIEWS`, so a missing view returns a blank match.
3. Each count is a correlated subquery on the plan identifier, with the chain of transactions, triggers, action rules and actions joined inside the subquery.
4. The template plan name is a scalar lookup on the template plan identifier.
5. Parent and child counts are subqueries on `QA_PC_PLAN_RELATIONSHIP` in each direction.

## Parameters & Filtering
*   **Organization:** Restricts the plans to one inventory organization. When blank, all plans the responsibility can access are returned, together with the template plans.
*   **Collection Plan:** Restricts the output to one plan name.
*   **Plan Type:** Restricts the output to one plan type.
*   **Collection Element:** Restricts the output to plans that use the element.
*   **Active Plans Only:** When Yes, only plans in effect today are returned.
*   **Template Plans Only:** When Yes, only the seeded template plans are returned.

## Performance & Optimization
*   Organization access is applied as an `OR` with the template organization identifier zero, so template plans are always reachable without a separate query.
*   The view existence checks are outer joins to `USER_VIEWS` on the view name, so they add one lookup per plan.
*   Element, transaction, trigger, action and relationship counts are correlated subqueries, so their cost grows with the number of plans returned.
*   The query has no analytic functions. The result is ordered by organization code and plan name.

## FAQ
**Q: How do I find a collection plan whose results view was never built?**
A: Look for plans where the Results View Exists column shows No; such a plan cannot be queried through its results view.

**Q: What does Enabled Elements show compared with Elements?**
A: Elements counts all elements on the plan, and Enabled Elements counts only the elements enabled on the plan, so a difference shows elements the operator never sees.

**Q: Which plans are template plans?**
A: The template plans are the seeded plans, which have a blank Organization Code. Setting Template Plans Only to Yes returns exactly those plans.

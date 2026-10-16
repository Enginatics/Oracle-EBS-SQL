# Case Study & Technical Analysis: QA Collection Plan Actions

## Executive Summary
This report lists every action rule defined for an Oracle Quality collection plan. A rule is a trigger condition on one collection element, such as the element being entered, equalling a value, or falling outside its specification limits, paired with one or more actions. The report shows the rules attached to the collection plan itself and the rules defined on the collection element master, distinguished by an Action Level column. Quality engineers, quality managers and EBS functional consultants use it to review how results entry behaves for a plan, to find the inline actions that can reject or change data during a results load, and to confirm which alerts, workflows and holds will fire after results are collected.

## Business Challenge
*   **Hidden rules:** Action rules are stored in two places, on the plan and on the element master, and a reviewer who looks at only one of them misses part of the behaviour.
*   **Inline actions change data:** Some actions run while results are entered and can refuse input or assign values, and these must be known before a results load.
*   **Deferred actions notify people:** Alerts, workflows and holds run in background processing, and their owners need to know which plans can trigger them.

## The Solution
*   Lists each trigger and action for a plan, labelled Plan or Element, with the trigger sequence, operator and trigger low and high values.
*   Shows the action name, whether it is an online action evaluated during results entry, and the status code it assigns to the result.
*   Shows the assigned element and assign type, where the action assigns a value to another element, and the alert action set and alert action.
*   Shows whether the element and the action are enabled, and who created and last updated each rule.

## Technical Architecture (High Level)
### Primary Tables
*   `QA_PLANS`: the collection plan, with its name, description, type and organization.
*   `MTL_PARAMETERS`: the inventory organization of the plan.
*   `QA_CHARS`: the collection elements.
*   `QA_PLAN_CHARS`: the elements as used on a plan, with prompt and enabled flag.
*   `QA_PLAN_CHAR_ACTION_TRIGGERS` and `QA_PLAN_CHAR_ACTIONS`: the plan-level trigger conditions and their actions.
*   `QA_PLAN_CHAR_ACTION_OUTPUTS`: the tokens bound into a plan-level action message.
*   `QA_CHAR_ACTION_TRIGGERS` and `QA_CHAR_ACTIONS`: the element-level trigger conditions and their actions.
*   `QA_CHAR_ACTION_OUTPUTS`: the tokens bound into an element-level action message.
*   `QA_ACTIONS`: the action definition, with its online flag and enabled flag.
*   `ALR_ACTION_SETS` and `ALR_ACTIONS`: the alert action set and alert action.
*   `ORG_ACCESS_VIEW`: the organizations the responsibility can access.

### Logical Relationships
1. The plan-level branch joins `QA_PLANS` to the plan trigger rows, to the element, to the plan element record, and to the action and alert.
2. The element-level branch joins the plan element record to the element's trigger rows, and to the element-level actions, which are shown against every plan that uses the element.
3. Each action's output tokens are listed with `LISTAGG` and the elements they read are resolved from `QA_CHARS`.
4. The assigned element is joined as a second instance of `QA_CHARS`, used only when the action assigns a value.
5. The two branches are combined with UNION ALL and filtered by the organization access list, with the seeded template plans included.

## Parameters & Filtering
*   **Organization** and **Collection Plan:** limit the rules to an organization and a plan.
*   **Plan Type:** selects the type of collection plan.
*   **Collection Element** and **Action:** select a collection element or an action.
*   **Online Actions Only:** restricts the output to the actions evaluated inline during results entry.
*   **Enabled Elements Only:** restricts the output to elements that are still enabled on the plan.
*   **Action Level:** shows plan-level rules, element-level rules, or both.

## Performance & Optimization
*   The organization access list is applied to the plan's organization, so rules of plans outside the user's access are not read.
*   The output tokens are aggregated with LISTAGG in correlated subqueries that run per action, which keeps one row for each trigger and action.
*   Element-level rules are reached only through the plans that carry the element, so an element used by no plan produces no rows.

## FAQ
**Q: Why does an element-level rule appear against several plans?**
A: Element master rules apply to every collection plan that uses the element, so each plan that carries the element shows the rule.

**Q: Which actions can change data during results entry?**
A: Filter with Online Actions Only set to Yes. These are the inline actions, such as displaying a message, rejecting the input or assigning a value to another element.


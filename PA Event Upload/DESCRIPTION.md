# Case Study & Technical Analysis: PA Event Upload

## Executive Summary
This upload creates new Project Billing and Revenue Events against the projects of the operating units that the current responsibility can access. Project accountants and billing teams use it to load milestone, billing and revenue events in bulk, so that the events carry the billing amounts, currencies, exchange rates, holds and references that drive project billing and revenue recognition. The download shows existing events, and the file is worked in Excel through Blitz Report™.

## Business Challenge
*   **Event volume:** Contract billing and revenue events are generated per milestone or per deliverable, and keying them one by one is slow for large projects.
*   **Multi-currency billing:** An event carries amounts in the transaction, project and functional currencies, each with its own rate type and rate date, which must be entered consistently.
*   **Holds and references:** Events can be held from billing or revenue, and they carry references that link them to the source system.
*   **Scope control:** A user must only load events against projects in the operating units they are responsible for.

## The Solution
*   Downloads existing events for the selected product source, showing the project, task, agreement, customer, event type, dates, amounts and rates of each event.
*   Creates new events against projects in the accessible operating units, with the event type, completion date, billing and revenue amounts and the currency and rate details.
*   Carries the billing and revenue holds, the bill group, the event references and the descriptive flexfield values of each event.
*   Restricts the projects offered to the operating units chosen in the parameters, and to the units the responsibility can access.

## Technical Architecture (High Level)
### Primary Tables
*   `PA_EVENTS`: the billing and revenue events, with the event number, type, completion date, amounts, rates, holds, quantities and references.
*   `PA_PROJECTS`, `PA_TASKS` and `PA_PROJ_ELEMENTS`: the project, task, and the deliverable and action names of each event.
*   `PA_EVENT_TYPES`: the event type and its classification.
*   `PA_AGREEMENTS` and `PA_CUSTOMERS_V`: the agreement and the customer on the event's project.
*   `PA_CONVERSION_TYPES_V`: the rate types for the functional, project and funding rates.
*   `PA_ALL_ORGANIZATIONS`, `HR_ALL_ORGANIZATION_UNITS_VL` and `MTL_PARAMETERS`: the operating unit and the expenditure organization of the event.
*   `MTL_SYSTEM_ITEMS_VL`: the inventory item and its organization, when the event is for an inventory item.
*   `MO_GLOB_ORG_ACCESS_TMP` and `DUAL`: the operating units accessible to the user.

### Logical Relationships
1.  Each event is joined to its project, and the project's operating unit is checked against the accessible operating units.
2.  The event's task is outer-joined, because an event can be recorded at project level.
3.  The expenditure organization of the event is matched to an expenditure organization in the operating unit, and its name is taken from the organization view.
4.  The agreement and customer are outer-joined, so events without an agreement are still listed.
5.  The projected, project and funding rate types are outer-joined to the conversion types to give readable names.
6.  Deliverable and action names are read from the project element table with the object type of each.

## Parameters & Filtering
*   **Product Source:** selects the source system of the events, such as the Oracle Projects product code of the events.
*   **Operating Unit:** restricts the projects to one operating unit, and otherwise all accessible units are included.
*   **Default Event Date:** the date parameter offered to the upload for new events.
*   **Validate DFF Attributes:** controls whether the event descriptive flexfield values are validated on upload.

## Performance & Optimization
*   The accessible operating units are read once from `MO_GLOB_ORG_ACCESS_TMP`, so each event is tested against a short list.
*   The reference lookups for event types, agreements, customers and conversion types are outer joins to views, one match per event.
*   The deliverable and action names are scalar subqueries on the project element table, evaluated once per event.
*   Filtering by product source and operating unit narrows the event set before the reference lookups are applied.

## FAQ
**Q: Which projects can receive events in this upload?**
A: Only projects in the operating units that the current responsibility can access, and, when the Operating Unit parameter is entered, only projects in that unit.

**Q: Can an event be created without a task?**
A: Yes, the task join is an outer join, so an event can be recorded against the project alone.

**Q: Which currencies and rates does an event carry?**
A: An event carries the transaction currency and bill and revenue amounts, and the functional, project and funding currency rates with their rate types and rate dates.

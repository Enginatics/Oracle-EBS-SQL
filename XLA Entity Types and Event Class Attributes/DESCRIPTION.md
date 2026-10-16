# Case Study & Technical Analysis: XLA Entity Types and Event Class Attributes

## Executive Summary
This report lists the Subledger Accounting (SLA) entity types of each Oracle E-Business Suite application, together with the event classes defined under each entity and the attributes of those event classes. It shows, for each event class, its journal category, its reporting view name, and whether it allows actuals, budgets or encumbrance accounting. Finance systems analysts, accounting configuration specialists and EBS consultants use it to document the subledger events that generate journal entries, to confirm which event classes allow budgetary and encumbrance accounting, and to find the reporting view that a subledger event class uses. It is a configuration reference, so it runs with no parameters and returns the full list for the database.

## Business Challenge
*   **Understanding subledger accounting events:** Each subledger application creates accounting through entity types and event classes, and the mapping must be understood before accounting rules are designed.
*   **Journal categories:** Each event class posts to a journal category, and finance teams need to know which category a subledger transaction uses.
*   **Budgetary and encumbrance control:** Only some event classes allow actuals, budgets or encumbrance accounting, and that restriction must be known before configuring the ledger.
*   **Reporting on subledger data:** Reporting developers need the reporting view of each event class to build queries on subledger data.

## The Solution
*   Lists each application by its short name and its name, so every entity type is tied to the product that owns it.
*   Shows each entity type's name, description and entity code.
*   Shows, for each event class under the entity, the journal category name, the event class code and the reporting view name.
*   Shows the allow flags for actuals, budgets and encumbrance, displayed as Yes or No.
*   Orders the output by application name, entity code and event class code, so the event classes of each entity are grouped together.

## Technical Architecture (High Level)
### Primary Tables
*   `FND_APPLICATION_VL`: the application short name and name.
*   `XLA_ENTITY_TYPES_VL`: the entity types of each application, with name, description and entity code.
*   `XLA_EVENT_CLASS_ATTRS`: the event class attributes of each entity, with journal category, event class code, reporting view and the allow flags.

### Logical Relationships
1. `FND_APPLICATION_VL` is joined to `XLA_ENTITY_TYPES_VL` on the application identifier, so each entity type carries its product.
2. `XLA_ENTITY_TYPES_VL` is outer joined to `XLA_EVENT_CLASS_ATTRS` on both the entity code and the application identifier.
3. Entity types with no event class are still listed, with the event class columns blank.
4. The result is ordered by application name, entity code and event class code.

## Parameters & Filtering
This report has no parameters. Every application, entity type and event class attribute in the database is returned, so filters are applied after the download, for example in Excel.

## Performance & Optimization
*   The report reads three configuration views with two joins, so the number of rows is the number of event classes in the database, which is small.
*   The entity-to-event-class join uses both the entity code and the application identifier, so it does not match entities of other products that share a code.
*   The outer join keeps entity types without event classes in the output, which shows the complete entity list.
*   Because the output is a reference list, it can be downloaded once and filtered locally without repeated database runs.

## FAQ
**Q: Which event classes allow encumbrance accounting?**
A: Filter the Allow Encumbrance column to Yes. The rows show the application, entity type and event class of each one.

**Q: How do I find the journal category of a subledger event class?**
A: Read the JE Category Name column for the event class. It is the journal category used when the event class posts accounting.

**Q: What is the reporting view for an event class?**
A: The Reporting View Name column gives the view that holds the accounting data of that event class, when one is defined.

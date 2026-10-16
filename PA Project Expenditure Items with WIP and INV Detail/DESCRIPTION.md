# Case Study & Technical Analysis: PA Project Expenditure Items with WIP and INV Detail

## Executive Summary
This report lists Oracle Projects expenditure items together with the manufacturing transaction behind each item where one exists. For an item raised from Work in Process it shows the WIP transaction, job, assembly, department and resource, and for an item raised from Inventory it shows the material transaction, its type, item and quantity. Project controllers use it to trace project costs back to the shop floor job or inventory movement behind them. It is an R12 report that runs in Excel through Blitz Report™.

## Business Challenge
*   **Cost traceability:** Project costs that come from manufacturing must be traced to the job, assembly and resource that incurred them, which the project ledger alone does not show.
*   **Inventory-driven costs:** Inventory material issued to a project must match the underlying inventory transaction.
*   **Reconciliation:** Project cost reports and manufacturing reports must agree, and differences need a common key to investigate.
*   **Project costing detail:** Labor and resource costs of a project need the department and resource that performed the work.

## The Solution
*   Shows each expenditure item with its operating unit, project number, name, status and type, task, expenditure type and class, and transaction source.
*   Attaches the WIP transaction for WIP-linked items, with its type, date, operation, department and resource.
*   Attaches the inventory material transaction for items whose linkage is WIP or INV from inventory, with its transaction type, date, item, quantity and unit of measure.
*   Shows the job, job type, assembly and accounting class, with quantity, currency, raw and burdened costs.

## Technical Architecture (High Level)
### Primary Tables
*   `PA_EXPENDITURE_ITEMS_ALL`: the expenditure items, with quantity, cost, currency, date, type and the original transaction reference.
*   `PA_EXPENDITURES_ALL`: the expenditure header, supplying the expenditure group and the person who incurred it.
*   `PA_EXPENDITURE_TYPES`: the expenditure type and its category.
*   `PA_PROJECTS_ALL`, `PA_PROJECT_STATUSES` and `PA_TASKS`: the project, its status and its tasks.
*   `PA_SYSTEM_LINKAGES` and `PA_TRANSACTION_SOURCES`: the linkage function and the transaction source descriptions.
*   `PER_PEOPLE_X`: the employee who incurred the expenditure.
*   `WIP_TRANSACTIONS`, `WIP_ENTITIES`, `WIP_DISCRETE_JOBS` and `WIP_REPETITIVE_ITEMS`: the WIP transaction, the job or schedule, and its accounting class.
*   `BOM_DEPARTMENTS` and `BOM_RESOURCES`: the department and resource of a WIP transaction.
*   `MTL_MATERIAL_TRANSACTIONS` and `MTL_TRANSACTION_TYPES`: the inventory material transaction and its type.
*   `MTL_SYSTEM_ITEMS_VL`: the assembly of the job and the inventory item of the material transaction.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit.
*   `MO_GLOB_ORG_ACCESS_TMP` and `DUAL`: the operating units accessible to the user.

### Logical Relationships
1.  Each expenditure item joins to its header, expenditure type, project, task and accessible operating unit.
2.  The WIP transaction is found by converting the original transaction reference to a number, and only for items whose linkage function is WIP and whose transaction source is Work In Process.
3.  The WIP entity of the transaction or material transaction identifies the job, and its primary item gives the assembly.
4.  The inventory material transaction is found by the same conversion, for WIP or INV linkages whose source is not Work In Process.
5.  Department and resource are joined to the WIP transaction and to the expenditure item's WIP resource.
6.  The results are ordered by operating unit, project number, task number and expenditure item date.

## Parameters & Filtering
*   **Operating Unit**, **Project** and **Task:** restrict the items to one unit, project or task.
*   **Date From** and **Date To:** bound the expenditure item dates.
*   **Expenditure Type** and **Expenditure Type Class:** restrict the items by type and by the system linkage class.
*   **Job** and **Employee:** restrict the items to one WIP job or to one employee.

## Performance & Optimization
*   The WIP and inventory links compare a converted number from the original transaction reference with a transaction identifier, so each item is matched on a key.
*   The operating unit restriction through `MO_GLOB_ORG_ACCESS_TMP` limits the items to the units the user can access.
*   The manufacturing joins are outer joins on identifiers, so items with no WIP or inventory transaction are still listed.
*   The project, task and date parameters are the main levers on run time, because they limit the expenditure items that are matched.

## FAQ
**Q: How is a project expenditure item matched to its WIP transaction?**
A: The report converts the original transaction reference of the expenditure item to a number and matches it to the WIP transaction identifier, for items whose linkage function is WIP and whose source is Work In Process.

**Q: Which items show an inventory transaction?**
A: Items whose linkage function is WIP or INV, and whose transaction source is not Work In Process, show the matching material transaction, its type, date, item and quantity.

**Q: Can an item be listed without a manufacturing transaction?**
A: Yes, the manufacturing joins are outer joins, so items that have no WIP or inventory transaction are still listed with blank manufacturing columns.

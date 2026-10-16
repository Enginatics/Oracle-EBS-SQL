# Case Study & Technical Analysis: CST Historical WIP Standard Cost Adjustment

## Executive Summary
This report shows the work in process standard cost adjustments recorded by a completed standard cost update. For each WIP discrete job, transaction type, item or resource operation and cost element, it gives the old and new unit cost, the adjustment quantity and the adjustment value, together with the valuation accounts of the job. It is written for cost accountants and manufacturing finance teams who must explain how open WIP values moved when a standard cost update was run, and who need the detail for period close review and audit. It follows Oracle's Historical WIP Standard Cost Adjustment Report (CSTCUSJA), with the stored adjustment details left untouched.

## Business Challenge
*   **Explaining WIP value movement:** A standard cost update changes the value of open jobs, and finance must explain each adjustment by job, operation and cost element.
*   **Tracing the accounts:** Each adjustment must be posted to the job's material, resource, overhead and standard cost adjustment accounts, which must be visible for review.
*   **Audit evidence:** The adjustment detail has to be kept for audit, so it must be viewed without being deleted.
*   **Choosing the right update:** An organization may run several cost updates for different cost types, so the report must target a specific completed update.

## The Solution
*   Reads the adjustment values saved by one completed standard cost update, and lists them by job, transaction type, operation, resource and cost element.
*   Shows the old and new unit cost for each line, rounded to the precision of the ledger currency, and the adjustment quantity and value.
*   Resolves the material, material overhead, resource, outside processing, overhead and standard cost adjustment accounts of each job into concatenated account segments.
*   Matches Oracle's View Cost Update History form by offering only completed cost updates that saved their adjustment details, and it does not offer the Delete Snapshot option.

## Technical Architecture (High Level)
### Primary Tables
*   `CST_COST_UPDATES`: the standard cost update, with its status, range option, description and date.
*   `CST_COST_TYPES`: the cost type of the update.
*   `CST_STD_COST_ADJ_VALUES`: the stored adjustment values, by job, operation, resource, cost element and transaction type.
*   `WIP_ENTITIES` and `WIP_DISCRETE_JOBS`: the job name, class, assembly and accounts.
*   `MTL_SYSTEM_ITEMS_VL`: the item and the assembly of the job.
*   `BOM_RESOURCES` and `CST_COST_ELEMENTS`: the resource code and the cost element name.
*   `ORG_ORGANIZATION_DEFINITIONS`, `GL_LEDGERS` and `FND_CURRENCIES`: the organization, the ledger and the currency precision used for rounding.
*   `GL_CODE_COMBINATIONS_KFV`: the account descriptions.

### Logical Relationships
1. `CST_COST_UPDATES` is restricted to completed updates, and joined to the cost type and to the organization.
2. The organization's ledger supplies the currency, and the currency precision controls rounding.
3. `CST_STD_COST_ADJ_VALUES` is joined to the update, and filtered to the job-level transaction types that changed cost.
4. The job is joined through the organization and WIP entity to `WIP_ENTITIES` and `WIP_DISCRETE_JOBS`, and the assembly through the primary item.
5. Resource and cost element details are joined through the resource and cost element identifiers.
6. An inner query computes the adjustment values per line. An outer query groups them and computes the unit costs and the accounts.

## Parameters & Filtering
*   **Organization Code:** selects the inventory organization whose WIP jobs were adjusted.
*   **Cost Update:** selects one completed standard cost update of that organization that saved its adjustment details.

## Performance & Optimization
*   The adjustment rows are restricted to the selected cost update and to jobs that have at least one changed unit cost, through a correlated IN subquery, so unchanged jobs are not listed.
*   For some transaction types the adjustment quantity is multiplied by a factor of one half, and the report divides the quantity by two for the operation rows that are counted twice, so the quantity is not overstated.
*   Rounding uses the extended or standard precision of the ledger currency, so the values follow the rounding of the currency.
*   Account names are resolved through scalar subqueries on the code combination identifier for each output row.

## FAQ
**Q: Which cost update should I choose?**
A: Choose the completed cost update for the cost type and date you are reviewing. Only updates that saved their adjustment details are offered.

**Q: Why does the report show the old and new unit cost for an operation?**
A: Each line shows the unit cost of the cost element for the operation or resource, rounded to the ledger's precision. Quantity and value are shown with the adjustment.

**Q: Does this report delete the adjustment history?**
A: No. Oracle's Delete Snapshot option is deliberately not included, so the stored adjustment details are never removed by this report.

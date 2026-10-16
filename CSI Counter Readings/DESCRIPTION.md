# Case Study & Technical Analysis: CSI Counter Readings

## Executive Summary
This report lists counter and meter readings held in Oracle Install Base, one row per reading, with the item instance or maintainable asset the counter belongs to and the service contract it is linked to. It is used by maintenance planners, service contract administrators and asset managers who need to see how far equipment has been used since the last reading, so that usage-based preventive maintenance and contract billing are based on the recorded values. The Reading Change column gives the usage between consecutive readings, and it is calculated across resets and adjustments.

## Business Challenge
*   **Usage-based maintenance:** Preventive maintenance triggered by meter values depends on accurate readings, and planners need to see the latest and historical values per counter.
*   **Resets and adjustments:** Counters are reset or corrected over their life, so a raw reading difference does not show the true usage.
*   **Linking readings to work:** A reading recorded on completion of a maintenance work order must be traceable to that work order.
*   **Contract usage:** Usage-based service contracts need the readings of the counters covered by each contract line.

## The Solution
*   Lists each reading with its counter name, type, unit of measure, reading type, reading value, life-to-date value and net reading.
*   Calculates Reading Change as the net reading minus the net reading of the counter's previous enabled reading, so the usage since the last reading is shown.
*   Shows the reset mode, the reset reason, the adjustment type and adjustment reading, and whether the reading is disabled.
*   Finds the maintenance work order on whose completion the reading was recorded, and the contract number of the counter's contract line or of the usage contracts that cover it.

## Technical Architecture (High Level)
### Primary Tables
*   `CSI_COUNTER_READINGS`: the counter reading values, with timestamps, net readings, reset and adjustment information.
*   `CSI_COUNTERS_VL`: the counter definition, including name, type, unit of measure and reading type.
*   `CSI_ITEM_INSTANCES`: the item instance that carries the counter, with its serial number and owner party.
*   `CSI_COUNTER_ASSOCIATIONS`: links a counter to its instance and to its contract line.
*   `CSI_TRANSACTIONS` and `CSI_TXN_TYPES`: the transaction that created the reading and its source transaction type.
*   `WIP_ENTITIES` and `EAM_METER_READINGS`: the maintenance work order associated with a reading.
*   `OKC_K_HEADERS_ALL_B`, `OKC_K_LINES_B` and `OKC_K_ITEMS`: the contract header, contract line and the contract items that reference counters.
*   `MTL_SYSTEM_ITEMS_VL`, `MTL_PARAMETERS`, `HZ_PARTIES` and `ORG_ACCESS_VIEW`: the item, organization, owner and access control.

### Logical Relationships
1. The reading table is first extended with the instance and contract line identifiers, taken from the latest counter association of each type.
2. `CSI_COUNTERS_VL` gives the counter attributes, and `CSI_ITEM_INSTANCES` is outer joined on the instance.
3. The instance item and organization are joined to `MTL_SYSTEM_ITEMS_VL` and `MTL_PARAMETERS`.
4. The contract line is joined to its header through the line's contract identifier.
5. The transaction and transaction type identify the source, and the work order is found either from the transaction or from the meter reading record.
6. Reading Change is a correlated subquery that takes the net reading of the previous enabled reading of the same counter.

## Parameters & Filtering
*   **Counter Usage**, **Counter** and **Instance Number:** select the counters and their item instances.
*   **Reading Date From** and **Reading Date To:** bound the reading timestamp.
*   **Organization Code** and **Item:** limit the instances to an organization and an item.
*   **Contract Number:** finds readings for counters linked to one contract.
*   **Exclude Disabled:** removes readings that have been disabled.

## Performance & Optimization
*   The instance association and contract line association are resolved with a KEEP DENSE_RANK on the latest start date, so each reading receives one identifier rather than several.
*   Reading Change uses a keep-last aggregate ordered by timestamp and counter value identifier, so the previous reading is found in the same counter.
*   The contract numbers of usage contracts are aggregated with LISTAGG only when the reading has no direct contract line.
*   The organization restriction is applied through `ORG_ACCESS_VIEW` for the responsibility, which limits the instances read to the organizations the user can access.

## FAQ
**Q: How do I see the usage since the last reading of a meter?**
A: Read the Reading Change column. It is the net reading minus the net reading of the previous enabled reading of the same counter, and it is blank for the first reading.

**Q: How can I find the work order that recorded a reading?**
A: The Work Order column shows the maintenance work order on whose completion the reading was recorded.

**Q: Why is a reading contract number sometimes a list?**
A: When a counter is not attached to a contract line, the report lists all contracts whose usage lines cover that counter, separated by commas.

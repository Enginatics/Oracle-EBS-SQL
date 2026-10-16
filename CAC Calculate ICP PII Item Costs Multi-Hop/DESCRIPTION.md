# Case Study & Technical Analysis: CAC Calculate ICP PII Item Costs Multi-Hop

## Executive Summary
The CAC Calculate ICP PII Item Costs Multi-Hop report calculates intercompany profit in inventory (PII, or ICP) for each item and receiving organization in Oracle Cost Management. It follows the full sourcing chain from the origin organization to the receiving organization, across any number of inter-organization transfers, and accumulates the profit of each hop. Cost accountants and intercompany reconciliation teams use it to compare the calculated PII with the PII stored in the receiving organization. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Multi-level intercompany profit:** When an item moves through several organizations, the profit in inventory must be eliminated across the whole chain, not only on the last transfer.
*   **Stored PII accuracy:** The PII stored in each receiving organization must agree with the sourcing chain and the costs of the organizations that supply it.
*   **Multi-currency transfers:** Each hop crosses a currency boundary, so costs must be converted on the conversion date.
*   **Multiple sources:** An organization can receive an item from several sources, and each path needs its own result.

## The Solution
*   **Hop profit:** For each transfer, the profit is the receiving organization's item cost without its material overhead, resource, outside processing and overhead costs, less the source organization's converted item cost.
*   **Recursive path accumulation:** A recursive `WITH` query adds each hop's profit to the PII of the previous hop, starting at the origin organization, and records the path such as origin to intermediate to receiving organization.
*   **Stored comparison:** The calculated PII is compared with the stored PII of the receiving organization, giving PII Cost Difference.
*   **Cycle handling:** Organizations reached only through a sourcing loop are flagged as Circular Sourcing and calculated for one hop from the source's stored PII.

## Technical Architecture (High Level)
### Primary Tables
*   `CST_ITEM_COSTS`: the item cost of each organization and cost type, with the material overhead, resource, outside processing and overhead components.
*   `CST_ITEM_COST_DETAILS`: the cost detail rows used to take the PII sub-element.
*   `CST_COST_TYPES`: the cost type of the calculation and the PII cost type.
*   `MTL_PARAMETERS`: the organization parameters, including the primary cost method and the master organization.
*   `MRP_ASSIGNMENT_SETS` and `MRP_ITEM_SOURCING_LEVELS_V`: the assignment set and the sourcing hierarchy used to find each item's source.
*   `GL_DAILY_CONVERSION_TYPES` and `GL_DAILY_RATES`: the conversion type and the rates on the conversion date.
*   `MTL_SYSTEM_ITEMS_VL` and `MTL_ITEM_STATUS_VL`: item description, type, make-buy code and status.
*   `ORG_ORGANIZATION_DEFINITIONS` and `GL_LEDGERS`: organization codes, currencies and ledgers.
*   `ORG_ACCESS_VIEW`: the organizations the current responsibility can see.
*   `BOM_RESOURCES`: the resource codes used to identify the PII sub-element.

### Logical Relationships
1.  The `C` step reads each item's cost in each organization and computes the net cost and the PII cost of the sub-element.
2.  The `E` step takes the most specific sourcing level for each item and organization, joins source and receiving organizations and their currencies, and attaches the daily rate.
3.  The hop profit is the receiving net cost less the converted source item cost, signed by the Numeric Sign for PII parameter.
4.  The recursive `H` step starts from edges whose source is not itself a receiving organization, and repeatedly joins an edge whose source is the previous receiving organization.
5.  The final select joins the paths to their edges and to the organizations the responsibility can access.

## Parameters & Filtering
*   **Assignment Set:** names the sourcing assignment set that defines each item's source.
*   **Cost Type** and **PII Cost Type:** the cost type whose item costs are used and the cost type holding the stored PII.
*   **PII Sub-Element:** the resource code that identifies the PII cost inside the cost details.
*   **Currency Conversion Date** and **Currency Conversion Type:** the date and rate type used to convert each source cost.
*   **From Organization** and **To Organization:** limit the source and receiving organizations.
*   **Item Number** and **Category Set 1** to **Category Set 3:** restrict the items reported and add category columns.

## Performance & Optimization
*   The `C` and `E` steps are materialized, so the item cost and sourcing joins run once before the recursive path query.
*   The recursive `H` step uses a `CYCLE` clause, so a sourcing loop stops at the repeated organization rather than running indefinitely.
*   Sourcing rows are filtered to the most specific sourcing level by an analytic minimum, which removes lower-priority assignments before the joins.
*   The output is limited to organizations visible to the current responsibility through `ORG_ACCESS_VIEW`.

## FAQ
**Q: How is PII calculated for an item moved through several organizations?**
A: Each hop adds its converted profit to the PII of the previous hop, starting from the origin organization's stored PII, and the recursive query accumulates the result for every sourcing path.

**Q: What does Circular Sourcing mean in this report?**
A: It marks an organization reached only through a sourcing loop without an origin. Those rows are calculated for one hop from the source organization's stored PII.

**Q: Why are some calculated PII columns blank?**
A: A missing exchange rate leaves the calculated columns blank, and inactive items and items without costs in the source or receiving organization are not reported.

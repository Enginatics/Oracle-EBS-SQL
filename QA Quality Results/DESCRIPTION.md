# Case Study & Technical Analysis: QA Quality Results

## Executive Summary
QA Quality Results gives one row for each collected result and characteristic in Oracle Quality, so that results from any number of collection plans can be analysed together in Excel. Oracle Quality stores each element value in a generic column of the results table, and the plan's element definition decides which column holds which characteristic. This report reads those columns and returns them as one stacked list. Quality engineers, supplier quality managers and production supervisors use it to trend inspection results, compare defect rates across items and suppliers, and investigate a family of related plans.

## Business Challenge
*   **Scattered Results:** Each plan stores its results in generic columns, so a standard extract shows a different column meaning for each plan.
*   **Trend Analysis:** Quality managers need numeric results over time to chart and average, which requires converting text values.
*   **Plan Families:** Organizations often run many similar plans, such as one per incoming material family, and need them summarized together.
*   **Context Fields:** Item, lot, serial, supplier and purchase order details must be filterable with the results they describe.

## The Solution
*   **Stacked Result Rows:** Each characteristic that a user filled in becomes one row, so plans with different elements share a single layout.
*   **Typed Result Values:** The result is returned as text, and the numeric result column converts number elements for charting and averaging.
*   **Context On Every Row:** Organization, item, revision, lot, serial, subinventory, quantity, job, purchase order, supplier and customer appear as columns.
*   **Plan Pattern Search:** The collection plan like parameter returns every plan matching a pattern.

## Technical Architecture (High Level)
### Primary Tables
*   `QA_RESULTS`: the result records, with the context columns and the generic character, comment and sequence columns that hold the element values.
*   `QA_PLANS`: the collection plans, with their names and descriptions.
*   `QA_PLAN_CHARS`: the elements enabled on each plan, with their prompts, unit of measure and result column names.
*   `QA_CHARS`: the element definitions, with their names and data types.
*   `MTL_PARAMETERS`: the organizations.
*   `MTL_SYSTEM_ITEMS_VL`: the items with their concatenated segments.
*   `WIP_ENTITIES`: the jobs referenced by the results.
*   `PO_HEADERS_ALL`: the purchase orders referenced by the results.
*   `PO_VENDORS`: the suppliers.
*   `HZ_CUST_ACCOUNTS` and `HZ_PARTIES`: the customers.
*   `ORG_ACCESS_VIEW`: the organizations the user can access.

### Logical Relationships
1.  Each result in `QA_RESULTS` is joined to its plan in `QA_PLANS` and to the enabled elements of that plan in `QA_PLAN_CHARS`.
2.  Each plan element is joined to its definition in `QA_CHARS`.
3.  The result column named by each plan element decides which generic column supplies the value, and a decode expression returns the matching column.
4.  Items are outer joined to `MTL_SYSTEM_ITEMS_VL`, and organizations to `MTL_PARAMETERS`.
5.  Jobs, purchase orders, suppliers and customers are returned through correlated subqueries.
6.  Only the character, comment and sequence element columns are read, and the outer query orders the stacked rows by plan and collection.

## Parameters & Filtering
*   **Organization:** Restricts the results to one organization.
*   **Collection Plan and Collection Plan like:** Select one plan or a pattern of plans.
*   **Result Date From and Result Date To:** Limit the results to the date they were recorded.
*   **Collection Element:** Restricts the output to one characteristic.
*   **Item and Lot Number:** Select the results for one item or one lot.
*   **Exclude Empty Results:** Yes by default, so blank elements are not listed. Clearing it includes enabled elements that were left blank.

## Performance & Optimization
*   **Organization Access First:** Results are limited to permitted organizations before the element decoding is evaluated.
*   **Enabled Elements Only:** The plan element join keeps only enabled elements and only those stored in the character, comment and sequence columns.
*   **Decode Per Column:** Each element picks its value with a decode on the column number, so no extra join to the results is needed.
*   **Correlated Context Lookups:** Job, purchase order, supplier and customer names are read through correlated subqueries that return one value each.

## FAQ
**Q: How do I get numeric results that I can average?**
A: Use the Result Number column. It is populated for number elements whose result is a valid number, and the text Result column keeps the original value.

**Q: Why does a plan element not appear for a result?**
A: Only elements that an operator filled in are listed. Clear the Exclude Empty Results parameter to include enabled elements that were left blank.

**Q: How do I pull every result for a family of plans?**
A: Enter a pattern such as INCMRC% in the Collection Plan like parameter.

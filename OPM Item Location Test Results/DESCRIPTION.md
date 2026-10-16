# Case Study & Technical Analysis: OPM Item Location Test Results

## Executive Summary
This report lists the quality control test results recorded in Oracle Process Manufacturing (OPM) for item, lot and subinventory samples. For each result it shows the measured value, the specification minimum, target and maximum, an in-specification indicator and the sample disposition. Quality laboratory supervisors and quality assurance teams use it to answer what the lab found for a given item or lot and whether the result was within specification. It is an R12 report that runs in Excel through Blitz Report™.

## Business Challenge
*   **Release decisions:** Lots of process ingredients and finished products cannot be released until their test results are reviewed against the specification.
*   **Specification changes:** The applicable specification can change over time, so the limits that governed a sample must be identified by its date and lot.
*   **Traceability:** Quality investigations need every test result for an item or lot, with the sample it came from.
*   **Disposition evidence:** The sample disposition must be shown next to the results that justify it.

## The Solution
*   Returns one row for each test result, with the organization, item, lot, subinventory, sample number, test code and test description.
*   Shows the result as a value, using the numeric result where one exists and the character result otherwise.
*   Shows the specification minimum, target and maximum limits and the unit of measure that applies to the test.
*   Sets an in-specification indicator where the numeric result falls within the minimum and maximum limits, and shows the sample disposition and the sample and result dates.

## Technical Architecture (High Level)
### Primary Tables
*   `GMD_RESULTS`: the test results, with the numeric or character result value and the result date.
*   `GMD_SAMPLES`: the samples, with item, organization, lot, subinventory, date drawn and disposition.
*   `GMD_QC_TESTS_B` and `GMD_QC_TESTS_TL`: the test codes and their descriptions.
*   `GMD_INVENTORY_SPEC_VRS`: the inventory specification validity rules, which link an item, organization, lot and date range to a specification.
*   `GMD_SPECIFICATIONS_B`: the specifications, each for one item.
*   `GMD_SPEC_TESTS_VL`: the limits of each test within a specification.
*   `MTL_SYSTEM_ITEMS_VL` and `ORG_ORGANIZATION_DEFINITIONS`: the item and the organization code.
*   `ORG_ACCESS_VIEW`: the organizations the current responsibility can access.

### Logical Relationships
1.  Each result is joined to its sample, and the sample to its test, through the test language row for the session language.
2.  Each sample is joined to its item and organization for the item number, description and organization code.
3.  The governing specification for each sample is found in a derived table: the validity rule for the same item, organization and lot, or a rule with no lot, whose start and end dates include the date drawn.
4.  Where several validity rules apply, the rule with a matching lot number is preferred, and then the rule with the latest start date.
5.  The specification limits are joined from `GMD_SPEC_TESTS_VL` by the chosen specification and the result's test.
6.  Results are ordered by organization, item, lot, sample number and test code.

## Parameters & Filtering
*   **Organization Code:** limits the output to one organization.
*   **Item:** selects one item.
*   **Lot Number like:** matches lot numbers with a pattern.
*   **Test:** selects one quality test.
*   **Sample Date From** and **To:** restrict the samples by the date drawn.

## Performance & Optimization
*   The specification choice is an aggregate with a keep clause, which selects one specification per sample in a single pass rather than through a separate ranking query.
*   The validity rule join is restricted to rules for the sample's item and organization, which keeps the candidate specifications for each sample small.
*   The organization access restriction is applied to samples before the result joins.
*   The in-specification test is a simple range comparison on the numeric result, so it adds little cost to each row.

## FAQ
**Q: How is the governing specification of a sample determined?**
A: The report uses the specification whose inventory validity rule covers the item, organization and lot of the sample and whose start and end dates include the date drawn, preferring a rule for the exact lot.

**Q: When is a result shown as in specification?**
A: A numeric result is in specification where it lies between the specification minimum and maximum; results without numeric limits are not marked.

**Q: Where do the test names and codes come from?**
A: They come from the Quality test tables `GMD_QC_TESTS_B` and `GMD_QC_TESTS_TL`, with the description in the session language.

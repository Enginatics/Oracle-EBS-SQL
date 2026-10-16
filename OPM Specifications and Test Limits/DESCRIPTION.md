# Case Study & Technical Analysis: OPM Specifications and Test Limits

## Executive Summary
This report is the master reference for quality standards in Oracle Process Manufacturing. It lists every GMD specification with its version and status, the item and grade it applies to, and each test in the specification with its minimum, target and maximum limits, unit of measure, certificate of analysis print flag and reporting precision. Quality managers, laboratory supervisors and regulatory teams use it to confirm the acceptance limits that finished and intermediate products must meet, and to compare them against the certificates of analysis issued. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Limit governance:** Acceptance limits must be documented per item and grade, and any drift between the specification and the laboratory must be visible.
*   **Certificate of analysis accuracy:** Only tests flagged for print appear on the certificate, and the flag must be controlled.
*   **Version control:** Specifications have versions and statuses, and the active version must be identified.
*   **Audit readiness:** Auditors ask for the complete set of limits for a product, which is spread across several specification tables.

## The Solution
*   **Specification header:** Each specification is shown with its name, version, description and status name.
*   **Item and grade:** The item and its description are shown with the grade the specification applies to.
*   **Test limits:** The minimum, target and maximum values are returned for each test. Character limits are used where a numeric limit is not set.
*   **Print and precision:** The print flag shows whether a test appears on the certificate of analysis, and the report precision shows how results are rounded.
*   **Ordering:** Rows are ordered by organization, specification name, version and test code, so each specification reads as one block.

## Technical Architecture (High Level)
### Primary Tables
*   `GMD_SPECIFICATIONS_B` and `GMD_SPECIFICATIONS_TL`: the specification header, with name, version, status, item and grade, and its translated description.
*   `GMD_SPEC_TESTS_VL`: the test limits of each specification, with minimum, target, maximum, unit and report precision.
*   `GMD_QC_TESTS_B` and `GMD_QC_TESTS_TL`: the quality control test definitions, with test code and description.
*   `MTL_SYSTEM_ITEMS_VL`: the item and its description.
*   `ORG_ORGANIZATION_DEFINITIONS`: the owner organization code.
*   `GMD_STATUS_VL`: the status name of the specification.
*   `ORG_ACCESS_VIEW`: the organizations the responsibility can access.

### Logical Relationships
1. `GMD_SPECIFICATIONS_B` joins to `GMD_SPECIFICATIONS_TL` on specification id, restricted to the session language.
2. `GMD_SPECIFICATIONS_B` joins to `GMD_SPEC_TESTS_VL` on specification id, and each test joins to `GMD_QC_TESTS_B` on test id.
3. The test name joins to `GMD_QC_TESTS_TL` on test id, restricted to the session language.
4. The specification's item joins to `MTL_SYSTEM_ITEMS_VL` on inventory item id and owner organization id.
5. The specification status joins to `GMD_STATUS_VL` as an outer join on the status code.

## Parameters & Filtering
*   **Organization Code:** restricts the specifications to one owner organization.
*   **Item:** restricts the specifications to one item.
*   **Spec:** restricts the report to one specification name.
*   **Spec Status:** restricts the specifications to one status.
*   **Grade:** restricts the specifications to one grade.
*   **Test:** restricts the report to one quality test.

## Performance & Optimization
*   The owner organization filter uses the organization access view, so only specifications the responsibility can see are read.
*   The language filters on the translated tables keep the report to one row per specification and test.
*   Numeric and character limits are combined with NVL, so each row returns a single limit value without a second query.

## FAQ
**Q: Why does a test not appear on the certificate of analysis?**
A: The certificate includes only tests with the print flag set. The flag is shown on each row for checking.

**Q: How do I find the active version of a specification?**
A: Filter by Spec and Spec Status, and read the version column for the status you need.

**Q: Which limit is shown when a test has no numeric target?**
A: The character limit is shown in place of the numeric value for that limit.

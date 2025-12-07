# Case Study & Technical Analysis: CAC Department Overhead Setup Errors

## Executive Summary
The **CAC Department Overhead Setup Errors** report is a critical diagnostic tool for Oracle EBS Cost Management. It identifies "broken links" in the overhead configuration chain that result in under-absorption of costs. Specifically, it detects scenarios where the necessary relationships between Departments, Resources, and Overheads are partially defined but incomplete, causing the overhead calculation engine to silently fail (i.e., calculate $0 overhead) during cost rollups or WIP transactions.

## Business Challenge
Departmental overheads rely on a triangular relationship:
1.  **Department ↔ Resource:** The resource (e.g., Labor) must exist in the department.
2.  **Department ↔ Overhead:** The overhead (e.g., Factory Burden) must have a rate in that department.
3.  **Resource ↔ Overhead:** The resource must be linked to the overhead to "earn" it.

If any leg of this triangle is missing, the overhead is not applied. These errors are often invisible until month-end analysis reveals low absorption rates. Common scenarios include:
*   **Scenario A (Rate Missing):** A resource is set up to earn an overhead, but the overhead has no rate defined for the specific department where the resource is used.
*   **Scenario B (Link Missing):** A department has both resources and overhead rates defined, but the specific resource hasn't been told to trigger that overhead.

## The Solution
This report proactively scans for these inconsistencies using a two-pronged approach:
*   **"Overhead Rates Not In Department":** Identifies cases where the Resource-Overhead link exists, but the Department-Overhead rate is missing.
*   **"Overheads Not Set Up with Resources":** Identifies cases where the Department-Overhead rate exists and the Resource is present, but the Resource-Overhead link is missing.

## Technical Architecture (High Level)
The query uses a `UNION ALL` structure to combine two distinct validation logic blocks.
*   **Block 1: Missing Rates**
    *   Drivers: `CST_RESOURCE_OVERHEADS` (CRO) and `BOM_DEPARTMENT_RESOURCES` (BDR).
    *   Validation: `NOT EXISTS` in `CST_DEPARTMENT_OVERHEADS` (CDO).
    *   Logic: If a resource in a department is linked to an overhead, that overhead *must* have a rate in that department.
*   **Block 2: Missing Links** (Inferred from standard pattern)
    *   Drivers: `CST_DEPARTMENT_OVERHEADS` (CDO) and `BOM_DEPARTMENT_RESOURCES` (BDR).
    *   Validation: `NOT EXISTS` in `CST_RESOURCE_OVERHEADS` (CRO).
    *   Logic: If a department has an overhead rate and a resource, they should likely be linked (though this can sometimes be intentional, the report highlights it for review).

## Parameters & Filtering
*   **Cost Type:** The specific cost scenario being validated (e.g., "Frozen").
*   **Exclude Outside Processing:** Option to ignore OSP resources, which often have different overhead rules.
*   **Organization Code:** Filter by specific factory.

## Performance & Optimization
*   **Negative Logic:** The use of `NOT EXISTS` is the most efficient way to find "missing" records in large datasets compared to `MINUS` or `NOT IN`.
*   **Indexed Access:** Relies on standard foreign keys (`DEPARTMENT_ID`, `RESOURCE_ID`, `OVERHEAD_ID`).

## FAQ
**Q: If I see an error here, does it mean my General Ledger is wrong?**
A: It means your WIP absorption is likely lower than intended. If you have already processed transactions, you may have under-absorbed overheads, which will manifest as a variance or lower inventory value.

**Q: Is "Overheads Not Set Up with Resources" always an error?**
A: Not necessarily. You might have a department with two resources (Labor and Machine) and an overhead that applies *only* to Machine. In that case, the Labor resource *should not* be linked to the overhead. However, this report flags it so you can confirm the omission is intentional.

**Q: How do I fix "Overhead Rates Not In Department"?**
A: Go to the **Department** form, click **Rates**, and add the missing overhead code and rate for that department.

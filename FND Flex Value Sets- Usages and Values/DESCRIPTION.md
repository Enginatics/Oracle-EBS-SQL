# Executive Summary
The **FND Flex Value Sets, Usages and Values** report is a comprehensive dictionary of all value sets in the system. It documents not just the list of values, but where the value set is used (DFFs, Key Flexfields, Concurrent Programs).

# Business Challenge
*   **Impact Analysis:** Before changing a value set (e.g., adding a value or changing validation), knowing every report and screen that uses it.
*   **Cleanup:** Identifying unused value sets.
*   **Standardization:** Finding duplicate value sets that could be consolidated.

# The Solution
This Blitz Report provides a 360-degree view:
*   **Definition:** Validation type (Independent, Table, None), Format, and Maximum Size.
*   **Content:** Can list the actual values contained in the set.
*   **Usage:** Lists every DFF Segment, Key Flexfield Segment, and Concurrent Program Parameter that references this value set.

# Technical Architecture
The report joins `FND_FLEX_VALUE_SETS` with `FND_DESCR_FLEX_COL_USAGE`, `FND_ID_FLEX_SEGMENTS`, and `FND_CONCURRENT_PROGRAMS`.

# Parameters & Filtering
*   **Flex Value Set Name:** Search for a specific set.
*   **Show Usages:** Toggle to see the "Where Used" analysis.
*   **Show Values:** Toggle to see the list of values (careful with large sets like GL Accounts).

# Performance & Optimization
*   **Large Sets:** Do not use "Show Values" for large table-validated sets (like Suppliers or Customers) as it will try to dump the entire table.

# FAQ
*   **Q: Can I see the SQL for table-validated sets?**
    *   A: Yes, enable "Show LOV Query" to see the exact SQL used to populate the list.

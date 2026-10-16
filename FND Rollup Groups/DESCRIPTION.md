# Executive Summary
The **FND Rollup Groups** report lists Flex Value Sets that utilize rollup groups, which are used to define summary relationships (hierarchies) for segment values. This is essential for financial reporting and other processes that rely on parent-child relationships within chart of accounts or other flexfields.

# Business Challenge
In General Ledger and other modules, "Parent" values are used to sum up "Child" values for reporting (e.g., a "Total Assets" parent account summing up individual asset accounts). These relationships are defined using Rollup Groups and Hierarchies. Verifying that these groups are defined correctly and assigned to the right value sets is crucial for accurate financial consolidation and reporting.

# The Solution
This report provides a configuration audit of Rollup Groups. It allows administrators to:
- Identify which value sets have hierarchy structures enabled.
- Verify the names and codes of defined rollup groups.
- Ensure consistency in hierarchy definitions across different value sets.

# Technical Architecture
The report joins `fnd_flex_value_sets` with `fnd_flex_hierarchies_vl` and `fnd_flex_values` to display the configuration of rollup groups.

# Parameters & Filtering
- **Flex Value Set:** Filter by the specific value set (e.g., 'Operations Account').
- **Rollup Group:** Filter by a specific rollup group name.

# Performance & Optimization
This is a lightweight configuration report and typically runs very quickly.

# FAQ
**Q: What is a Rollup Group?**
A: A Rollup Group is a tag used to identify a group of parent values in a value set. It allows you to perform summary reporting based on that level of the hierarchy.

**Q: Does this report show the parent-child value assignments?**
A: No, this report shows the definition of the groups themselves. To see the actual hierarchy of values (which child belongs to which parent), use the **FND Flex Value Hierarchy** report.

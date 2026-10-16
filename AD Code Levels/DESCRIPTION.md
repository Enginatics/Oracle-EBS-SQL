# Case Study & Technical Analysis: AD Code Levels

## Executive Summary
The AD Code Levels report lists the code level and baseline of every Oracle E-Business Suite product and product family as recorded by the patching utilities in `AD_TRACKABLE_ENTITIES`. It is written for Applications DBAs who must confirm which AD code level an R12 instance is actually running before a patch is applied, and for upgrade and audit teams who need a dated, reproducible record of the installed patch baseline. Patch readme files and My Oracle Support notes express prerequisites as code levels, for example R12.AD.C.Delta.15 for AD code level C.15, so the report turns a written prerequisite into a direct comparison against the database.

## Business Challenge
*   **Patch prerequisite verification:** Patch readmes state required code levels, and the DBA needs to confirm each one before the patch run rather than discovering a mismatch part way through.
*   **Inconsistent notation across products:** Code levels are written in a release-product-letter-delta form, which is easy to misread when checked by hand against several products.
*   **Baseline evidence for upgrades:** Cutover and upgrade projects need a reproducible listing of each product's code level and baseline at a point in time.
*   **Support escalation:** When Oracle Support asks which AD level is installed, the answer should come from the instance itself rather than from memory of the last patch session.

## The Solution
*   **Single register read:** The report reads one table, `AD_TRACKABLE_ENTITIES`, which is the register the patching utilities maintain for each trackable entity.
*   **Clear identification:** Each row returns the entity abbreviation, its full name and its type, so a product family can be identified without knowing internal identifiers.
*   **Code level as stored:** The `codelevel` value is returned as `code_level`, so it can be compared directly with the text of a patch prerequisite.
*   **Baseline flag included:** The `baseline` column is returned alongside the code level, so the listing shows both the current level and the baseline reference for each entity.
*   **Spreadsheet comparison:** Running the report in Excel through Blitz Report lets the DBA filter by type or abbreviation and compare several environments in one workbook.

## Technical Architecture (High Level)
### Primary Tables
*   `AD_TRACKABLE_ENTITIES`: the patching register of trackable products and product families, holding the abbreviation, name, type, code level and baseline of each entity.

### Logical Relationships
1. The report selects directly from `AD_TRACKABLE_ENTITIES` under an alias `ate`, with no join to any other table.
2. The `where 1=1` clause is a placeholder, so the SQL text applies no row restriction of its own.
3. The result is ordered by `type` and then by `abbreviation`, which gives a stable order for comparison across instances.

## Parameters & Filtering
*   **Entity Type:** Intended to restrict the listing to one class of trackable entity, such as products or product families. The SQL text in the library does not reference this parameter, so it is not coded as a predicate in the query shown.
*   **Abbreviation:** Intended to narrow the output to one entity, for example the single row for the Applications DBA code level. Like Entity Type, the parameter does not appear in the query text.

Because neither parameter is bound in the SQL, the report as written returns the complete register of trackable entities. Users who need a single product should filter the output in Excel by the `abbreviation` column.

## Performance & Optimization
*   **Single-table access:** The query touches one table with no joins, subqueries or analytic functions, so its cost is one table read followed by a sort.
*   **Register-sized data:** `AD_TRACKABLE_ENTITIES` holds the patching utilities' register of entities rather than transactional history, so the full listing is compact.
*   **Ordering only:** The only non-trivial work is the `order by` on `type` and `abbreviation`, which is applied to the complete result set.

## FAQ
**Q: How do I find the AD code level of my Oracle EBS instance?**
A: Run AD Code Levels and read the `code_level` value on the row whose abbreviation identifies the product, such as the Applications DBA entry.

**Q: How should a code level such as R12.AD.C.Delta.15 be read?**
A: The Oracle EBS documentation uses this notation for prerequisites, and the code level for that entry is AD code level C.15, as stated in the report description. The report returns the value exactly as it is stored.

**Q: Can this report confirm that a patch prerequisite is met?**
A: The report lists the stored values for each entity, and the comparison with the prerequisite in a patch readme is made by the user against the returned `code_level` column.

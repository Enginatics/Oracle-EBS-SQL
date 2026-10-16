# Case Study & Technical Analysis: DIS Converter Diagnostic Dump

## Executive Summary
The DIS Converter Diagnostic Dump is a diagnostic extract for the Oracle Discoverer module. It returns, in one result set, the Discoverer End User Layer (EUL) metadata and the staged workbook data needed to reproduce offline the logic that converts Discoverer workbooks into Blitz templates. Each row carries a data type that identifies what it represents, and only the columns relevant to that type are populated. Conversion engineers and DBAs use it to find out why a workbook or worksheet in a Discoverer export is not converted into a Blitz template or report. The dump is consumed by a Python parser.

## Business Challenge
*   **Silent conversion gaps:** A Discoverer workbook can fail to convert without an obvious error, so the cause must be traced through the metadata that defines its folders, joins and expressions.
*   **Scattered metadata:** The definition of a single Discoverer report is spread across the EUL object, query, key and expression tables and the staging tables, which is hard to inspect in the database.
*   **Reproducibility offline:** Conversion logic must be reproduced without access to the live Discoverer environment, which requires a complete snapshot of the relevant rows.
*   **Existing imports:** Users need to see whether an object use key was already imported.

## The Solution
*   **Scoped snapshot:** Only the End User Layer and optional object use keys are included.
*   **Latest query statistics:** For each document, sheet and owner, the most recent query statistics row is selected, so the dump reflects the current definition.
*   **Import status:** Each object use key is compared with existing Blitz reports whose description carries its object IDs and EUL name, and is marked IMPORTED or NEW.
*   **Typed output:** Metadata, staging and generated SQL fragments are emitted as typed rows, so one parser can process the whole dump.

## Technical Architecture (High Level)
### Primary Tables
*   `EUL5_QPP_STATS`: query statistics for each Discoverer worksheet query, including the join key identifiers.
*   `EUL5_DOCUMENTS`: Discoverer documents, used to map a document name and owner to a document identifier.
*   `XXEN_DISCOVERER_WORKBOOK_XMLS`: the stored workbook XML for each document in the EUL.
*   `XXEN_DISCOVERER_WORKBOOKS` and `XXEN_DISCOVERER_WORKBOOKS_V`: the staged workbook items and their derived SQL and expression text.
*   `XXEN_DISCOVERER_SHEETS`: the staged worksheet definitions, including display sequence and sort order.
*   `XXEN_DISCOVERER_PIVOT_FIELDS`: the staged pivot field definitions for each sheet.
*   `EUL5_OBJS`: EUL object definitions, such as folders, items and their external tables.
*   `EUL5_KEY_CONS`: key constraints that define joins between objects.
*   `EUL5_EXPRESSIONS`: calculated expressions and join predicates, with their formula text.
*   `XXEN_REPORTS_V`: existing Blitz reports, matched by their description to detect prior imports.

### Logical Relationships
1. The `SCOPE` block selects the latest query statistics row for each document name, sheet and owner, and joins it to `EUL5_DOCUMENTS` and to `XXEN_DISCOVERER_WORKBOOK_XMLS`.
2. Object use keys are split into object IDs, and join key IDs are read from the query statistics and then resolved through `EUL5_KEY_CONS` to the objects at each end of the join.
3. Referenced objects are added from the staged workbook and sheet reference keys, and all object IDs are combined into one set.
4. `EUL5_OBJS` returns the object definitions for that set, and `EUL5_EXPRESSIONS` returns the expressions linked to the join keys or to the objects.
5. The final `UNION ALL` emits OBJECT_USE_KEY, WORKBOOK_LINK, EUL_OBJ, QPP_STAT, KEY_CONS, EXPRESSION, STAGING_WORKBOOK, STAGING_SHEET, STAGING_PIVOT, ITEM_SQL, JOIN_PREDICATE and FROM_FRAGMENT rows, ordered by data type and identifiers.

## Parameters & Filtering
*   **End User Layer:** The required EUL owner. It is substituted into every EUL table reference and into the workbook filters.
*   **Object Use Key:** Optionally restricts the dump to specific object use keys. When empty, all keys in the EUL are in scope.
*   **Include Imported:** When Yes, object use keys that already have a Blitz report are included, with the status IMPORTED and the report identifier and name. When No, they are excluded from the scope.

## Performance & Optimization
*   The scope subquery is materialized with the `materialize` hint, because it is referenced by many of the later blocks.
*   The latest-statistics selection uses analytic `max` and `keep (dense_rank last)` expressions over partitions by document, sheet and owner, which avoids a separate self-join.
*   Comma-separated lists are split with `regexp_substr` against a row generator table function.

## FAQ
**Q: Why is my Discoverer workbook not converted into a Blitz report?**
A: Run the dump for the End User Layer and object use key of the workbook, then review the WORKBOOK_LINK, STAGING_SHEET and EXPRESSION rows to see which definitions are present.

**Q: How do I check whether a Discoverer object use key is already imported?**
A: Each OBJECT_USE_KEY row shows the status IMPORTED or NEW, with the Blitz report identifier and name when a matching report exists.

**Q: Which tables does the dump read to reproduce the join SQL?**
A: It reads `EUL5_QPP_STATS`, `EUL5_KEY_CONS` and `EUL5_EXPRESSIONS`, and emits the predicates as JOIN_PREDICATE rows.

# Executive Summary
The **DBA Index Columns** report provides a detailed view of database indexes, specifically focusing on the column order. The order of columns in a composite index is critical for performance: an index on `(A, B)` is very different from an index on `(B, A)`. This report helps DBAs and developers verify that indexes support their query patterns.

# Business Challenge
*   **Query Tuning**: "I have an index on `(STATUS, CREATION_DATE)`, but the query on `CREATION_DATE` is still doing a full table scan. Why?" (Because `STATUS` is the leading column).
*   **Redundancy Check**: "Do we have duplicate indexes? (e.g., one on `A` and another on `(A, B)`)".
*   **Design Verification**: "Did the migration tool preserve the correct column ordering?"

# Solution
This report joins `DBA_INDEXES` with `DBA_IND_COLUMNS`.

**Key Features:**
*   **Column Position**: Shows the exact order of columns (1, 2, 3...).
*   **Uniqueness**: Indicates if the index enforces a unique constraint.
*   **Function-Based Indexes**: Shows the expression used (e.g., `UPPER(USER_NAME)`).

# Architecture
The report queries `DBA_INDEXES` and `DBA_IND_COLUMNS`.

**Key Tables:**
*   `DBA_INDEXES`: Index header information.
*   `DBA_IND_COLUMNS`: Column details.

# Impact
*   **Performance Optimization**: Ensuring the "leading column" matches the query predicates is the #1 rule of indexing.
*   **Storage Savings**: Identifying and dropping redundant indexes saves disk space and reduces overhead on INSERT/UPDATE.
*   **Schema Integrity**: Verifies that unique constraints are properly backed by indexes.

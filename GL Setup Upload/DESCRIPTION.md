# Case Study & Technical Analysis: GL Setup Upload

## Executive Summary
The GL Setup Upload report creates and updates the General Ledger setup entities that the GL Setup menu maintains, in a single Excel file. It covers calendars and their periods, period types, journal sources and categories, encumbrance types, statistical units of measure, ledger sets, data access sets, AutoReverse criteria and AutoPost criteria, together with the options of existing ledgers. Each row belongs to one of fifteen entity types, chosen in the Row Type column, and a template is supplied for each entity. Implementation teams and GL administrators use it to build or change the accounting setup for a new instance, or to copy setup changes between environments.

## Business Challenge
*   **Large setup footprint:** A new GL configuration involves many forms across calendars, sources, categories and criteria sets, and each one is slow to key in by hand.
*   **Setup consistency:** Calendar periods, journal sources and categories must agree with each other and with the ledgers that use them, and mismatches cause posting and close problems.
*   **Controlled change:** Some attributes, such as a period type's periods per year or a ledger set's chart of accounts, cannot be changed once set, so teams need to see the existing values before making changes.

## The Solution
*   **One file, fifteen entity types:** Each row carries a Row Type, and only the columns for that entity are read, so one workbook can hold the whole setup.
*   **Create or update by identity:** Each entity is created when it does not exist and updated otherwise, and rows that change nothing are reported as No change and are not written.
*   **Calendar gap checks:** After a Calendar Period upload the calendar is checked for gaps and overlaps, and any problem is reported as a warning.
*   **Staged assignments:** Ledger set and data access set assignments are staged, and the General Ledger Accounting Setup Program is submitted automatically, once per chart of accounts, with its request ID shown in the row message.

## Technical Architecture (High Level)
### Primary Tables
*   `GL_PERIOD_TYPES`: the period types, with periods per fiscal year and year type in the name.
*   `GL_PERIOD_SETS` and `GL_PERIODS`: the calendars and their periods, with start and end dates, quarter, period number and adjustment flag.
*   `GL_JE_SOURCES_VL` and `GL_JE_CATEGORIES_VL`: the journal sources and categories.
*   `GL_ENCUMBRANCE_TYPES`: the encumbrance types.
*   `GL_STAT_ACCOUNT_UOM`: the statistical unit of measure assigned to an account segment value.
*   `GL_LEDGERS`: the ledgers, used for ledger options, ledger sets and assignments.
*   `GL_LEDGER_SET_NORM_ASSIGN` and `GL_ACCESS_SET_NORM_ASSIGN`: the member ledgers of ledger sets and data access sets.
*   `GL_ACCESS_SETS`: the ledger sets and data access sets.
*   `GL_AUTOREV_CRITERIA_SETS` and `GL_AUTOREVERSE_OPTIONS`: the AutoReverse criteria sets and their category options.
*   `GL_AUTOMATIC_POSTING_SETS` and `GL_AUTOMATIC_POSTING_OPTIONS`: the AutoPost sets and their priorities.
*   `FND_ID_FLEX_STRUCTURES_VL`: the accounting flexfield structure for each chart of accounts.
*   `GL_CODE_COMBINATIONS_KFV`: the accounts used for ledger options such as retained earnings, rounding, CTA and net income.

### Logical Relationships
1.  Each of the fifteen entity types is built as its own branch, and the branches are combined with UNION ALL. A row number orders the result by row type and the entity's key columns.
2.  Each branch joins its entity table to its period type, chart of accounts or flexfield structure, so that the chart of accounts ID and application 101 are matched on the accounting flexfield code.
3.  Calendar Period joins `GL_PERIOD_SETS` to `GL_PERIODS` and then to `GL_PERIOD_TYPES`.
4.  Ledger Set and Data Access Set Assignment branches join the member assignment tables to the set and to the ledger, excluding deleted assignments.

## Parameters & Filtering
*   **Upload Mode:** Decides whether existing records are downloaded for review. Creation and update are decided by the entity keys, not by this parameter.
*   **Row Type:** Limits the download to one of the fifteen entity types.
*   **Calendar:** Selects the calendar for Calendar Period rows.
*   **Period Type:** Selects the period type for period type rows.
*   **Chart of Accounts:** Selects the chart of accounts for Statistical Unit of Measure and for the related set and criteria rows.

## Performance & Optimization
*   **Branch-per-entity design:** Each entity is read by its own branch with its own key filters, so a download with one row type reads only the tables for that entity.
*   **Outer joins for optional accounts:** Ledger option accounts are outer joined, so a ledger with some accounts unset is still returned.

## FAQ
**Q: Why can I not change the periods per year of an existing period type?**
A: The description states that Periods Per Year and Year Type In Name are required to create a period type and cannot be changed afterwards.
**Q: Can this upload create a ledger?**
A: No. Ledgers cannot be created here, because only the Accounting Setup Manager can create the accounting setup around one. The upload updates the options of an existing ledger.
**Q: Does a calendar period upload check the calendar?**
A: Yes. After the upload the calendar is checked for gaps and overlaps between its periods, and any issue is reported as a warning. The Calendar Validation Report gives the full detail.

# Case Study & Technical Analysis: Blitz Report Parameter Default Value Validation

## Executive Summary
This report lists the parameters of Blitz Report definitions whose list of values returns an identifier that differs from the displayed value, and shows whether each stored default value is held as that identifier or as display text. Administrators maintaining a Blitz Report library use it to find defaults that will not resolve cleanly when a report opens. It is run in Excel through Blitz Report™, with the Category and Report Name parameters limiting the scope.

## Business Challenge
*   **Silent default failures:** A report default that does not resolve to the identifier the list of values expects can leave a parameter blank or wrong when the run screen opens.
*   **Hidden cost:** A default given as display text needs a fallback validation, which adds an extra list of values execution each time the run screen opens.
*   **Ambiguous text:** The same display text can exist as an identifier elsewhere, so a text default can resolve to the wrong value.
*   **Scale:** A library with many reports and parameters cannot be checked by opening each parameter by hand.

## The Solution
*   Compares the stored default with the identifier that the list of values resolves it to, and shows both, so that differences are visible on one row.
*   Filters to non-matching defaults only when Show non matching defaults only is requested, which isolates the cases that need correction.
*   Flags whether each default is a function, such as a profile lookup, or a select statement, so the two forms can be reviewed separately.
*   Counts how many listed parameters share the identical default expression, which shows where one default is repeated across reports.

## Technical Architecture (High Level)
### Primary Tables
*   `XXEN_REPORT_PARAMETERS_V`: the parameter definitions of every Blitz Report, with the parameter name, type, list of values, default value, display sequence and last update details.

### Logical Relationships
1.  The parameter view is restricted to rows that have a display sequence and a stored default value.
2.  Parameters whose list of values already returns the identifier are excluded by a test on whether the list of values equals its identifier.
3.  The remaining rows are classified with the function and select tests from the Blitz Report framework, and the default is resolved to an identifier with the value-to-identifier function.
4.  An analytic count over the default value gives the number of parameters that share the same default expression.
5.  The outer query applies the optional filters for functions and selects and sorts by report, category and display sequence.

## Parameters & Filtering
*   **Category** and **Report Name:** limit the scope to one category or one report.
*   **Show non matching defaults only:** lists only the parameters where the default is not the identifier the list of values returns.
*   **Show functions ony:** restricts the list to defaults expressed as a function, such as a profile value lookup.
*   **Show selects only:** restricts the list to defaults expressed as a select statement.

## Performance & Optimization
*   Each row calls the list of values framework once to test whether the list returns identifiers, so the report's run time grows with the number of parameters that have defaults.
*   The analytic count over the default value is computed in the same pass as the rest of the row, avoiding a second query for the duplicate count.
*   The filters on Category and Report Name reduce the parameter set before the identifier resolution is run for each row.
*   The row set is read from the parameter view alone, so the cost is set by the number of parameters in the library.

## FAQ
**Q: Why does a report default need to be stored as an identifier rather than as display text?**
A: A default stored as an identifier resolves directly when the run screen opens, whereas a default stored as display text needs an extra list of values execution and can be ambiguous.

**Q: How do I list only the defaults that need correcting?**
A: Set Show non matching defaults only to Yes, optionally with Category or Report Name, and the report returns the parameters whose default differs from the identifier the list of values resolves.

**Q: What does Dupl Count show?**
A: Dupl Count gives the number of listed parameters that share the identical default expression, which helps find one default repeated across several reports.

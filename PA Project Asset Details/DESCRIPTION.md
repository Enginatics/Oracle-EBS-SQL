# Case Study & Technical Analysis: PA Project Asset Details

## Executive Summary
The PA Project Asset Details report lists the capital project assets of Oracle Projects. For each project asset it shows the CIP cost, the capitalized amounts, the Oracle Assets asset number, the estimated and actual in-service dates and the transfer status of each asset line. Capital project accountants and project controllers use it to follow construction in progress through to capitalization, to find assets that have not yet been transferred to Oracle Assets and to check the in-service dates of completed projects. It runs in Excel through Blitz Report, which allows the cost columns to be summed by project and operating unit.

## Business Challenge
*   **Construction in progress tracking:** Capital projects accumulate cost over several periods, and the controller needs the current and original cost of each asset.
*   **Capitalization timing:** An asset is capitalized when it is placed in service, and the estimated and actual in-service dates determine when depreciation starts.
*   **Asset register link:** Each project asset must be linked to its Oracle Assets asset number, so that the register and the project agree.
*   **Transfer control:** Asset lines that are not transferred to Oracle Assets leave cost outside the fixed asset register, and must be cleared before close.

## The Solution
*   Lists each project asset with its name, description, type, estimated cost and the estimated and actual in-service dates.
*   Shows the original and current asset cost, the capital event that created the cost, and the period and GL date of each asset line.
*   Shows the Oracle Assets asset number of each asset, the book, the asset units and whether the asset is capitalized, with its capitalized date.
*   Shows the transfer status of each asset line, the manufacturer, model, serial and tag details, and the reverse and capital hold flags.

## Technical Architecture (High Level)
### Primary Tables
*   `PA_PROJECT_ASSETS_ALL`: the project asset, with its name, type, estimated cost and in-service dates, and its Oracle Assets link.
*   `PA_PROJECT_ASSET_LINES_ALL`: the cost lines of each project asset, with the original and current cost, GL date, period and transfer status.
*   `PA_PROJECTS_ALL`: the project, with its number, name, type and status code.
*   `PA_PROJECT_STATUSES`: the names of the project status codes.
*   `PA_CAPITAL_EVENTS`: the capital event number of each asset line.
*   `FA_ADDITIONS_B`: the Oracle Assets asset master, which supplies the asset number.
*   `HR_ALL_ORGANIZATION_UNITS_VL`, `MO_GLOB_ORG_ACCESS_TMP` and `DUAL`: the operating unit and the organization access.

### Logical Relationships
1.  `PA_PROJECT_ASSETS_ALL` is joined to `PA_PROJECTS_ALL` on the project id, which gives the project number and name.
2.  `PA_PROJECT_ASSET_LINES_ALL` is outer joined to the project asset on the project asset id, so an asset with no cost lines still appears.
3.  The Oracle Assets asset number is a scalar lookup on `FA_ADDITIONS_B` through the FA asset id of the project asset.
4.  The capital event number comes from `PA_CAPITAL_EVENTS` on the capital event id of the asset line.
5.  The operating unit is joined from the project's organization id to `HR_ALL_ORGANIZATION_UNITS_VL`, and restricted to the organizations of `MO_GLOB_ORG_ACCESS_TMP`.

## Parameters & Filtering
*   **Operating Unit:** restricts the assets to one operating unit.
*   **Project:** restricts the assets to one project. The parameter is applied through the project joins of the query.

## Performance & Optimization
*   The organization restriction uses `MO_GLOB_ORG_ACCESS_TMP`, which keeps the project asset read limited to the responsibility's operating units.
*   The asset line join is an outer join on the project asset id, so each asset returns its lines in a single pass.
*   The Oracle Assets asset number and the project status name are scalar subqueries on primary keys, so each row adds one lookup each.
*   Filtering by Operating Unit or Project reduces the project asset rows before the line join, which is the main cost of the query.

## FAQ
**Q: How do I find project assets that are not yet transferred to Oracle Assets?**
A: Run the report and look at the Asset Line Transfer Status column. Lines that are not yet transferred show a status other than transferred, and the FA Asset Number is blank until the asset exists in Oracle Assets.

**Q: Which cost is shown for a project asset?**
A: The report shows the original asset cost and the current asset cost of each asset line, with the capital event number that created the cost.

**Q: How do I see when a project asset was placed in service?**
A: The Estimated In-Service Date and Date Placed In Service columns show the planned and the actual date, and the Capitalized Date shows when the asset was capitalized.

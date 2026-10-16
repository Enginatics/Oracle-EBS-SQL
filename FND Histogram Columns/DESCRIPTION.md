# Case Study & Technical Analysis: FND Histogram Columns

## Executive Summary
This report lists the table columns registered in the Oracle Application Object Library table `FND_HISTOGRAM_COLS`. These are the columns that Oracle expects to hold highly skewed data, such as a status column with many closed rows and only a few open ones. For each registration it shows the application, the schema owner, the table and column, the histogram size and the audit details. It is used by DBAs and EBS technical teams who tune the statistics gathered on the database, and who need to check which columns already receive histogram statistics before adding new ones.

## Business Challenge
*   **Skewed columns and poor plans:** When a column has a few rare values among many common ones, the optimizer can choose a poor plan unless it knows the value distribution.
*   **Statistics gathering across an EBS schema:** Gather Schema and Gather Table Statistics must know which columns need extra histograms, and that list must be correct for each application.
*   **Changing the list safely:** Columns are added to the list through an API, and the team needs to see the result of each change.
*   **Documentation for support:** Support teams need a current record of which columns were registered, by whom and when.

## The Solution
*   Reads every registration in `FND_HISTOGRAM_COLS` and shows the table name, the column name and the histogram size.
*   Resolves the application name and the Oracle schema owner of each registration, so the owner of the table is shown with the product.
*   Shows who created and last updated each registration, and when, using the user name and client time.
*   Sorts the output by application, table and column, so the registrations of one product are easy to compare.

## Technical Architecture (High Level)
### Primary Tables
*   `FND_HISTOGRAM_COLS`: the registered histogram columns, with the table name, column name, histogram size, application identifier and audit columns.
*   `FND_APPLICATION_VL`: the application name and short name for each application identifier.
*   `FND_PRODUCT_INSTALLATIONS`: the installed products, linking each application identifier to an Oracle user identifier.
*   `FND_ORACLE_USERID`: the Oracle schema user name of each installed product.

### Logical Relationships
1. `FND_HISTOGRAM_COLS` is joined to `FND_APPLICATION_VL` on application identifier, which gives the application name.
2. The same application identifier is joined to `FND_PRODUCT_INSTALLATIONS`.
3. The Oracle user identifier from the installation record is joined to `FND_ORACLE_USERID`, which gives the schema owner.
4. The result is ordered by application name, table name and column name.

## Parameters & Filtering
*   **Application:** limits the registrations to one EBS application.
*   **Table Name:** limits the registrations to one table.

## Performance & Optimization
*   The report reads a small registration table, so the joins to the application and installation data are inexpensive.
*   The application join is on the application identifier stored in the registration table, so the application name is taken from the same key that the registration uses.
*   The installation join returns the Oracle user of each product, which is needed for the owner column.
*   Because the output is sorted only on application, table and column, it is quick to review even when many products are installed.

## FAQ
**Q: How do I find out which columns already have histogram statistics defined?**
A: Run the report without parameters. Each row is a column registered in FND_HISTOGRAM_COLS, with its table, column and histogram size.

**Q: How do I see the histogram columns of one EBS product?**
A: Choose the product in the Application parameter. The owner column shows the Oracle schema of that product.

**Q: How do I add a column to this list?**
A: Columns are added through the FND_STATS loadhistogramcols API with the INSERT action, which takes the application identifier of the product that owns the table, the table name and the column name. The report then shows the new row.

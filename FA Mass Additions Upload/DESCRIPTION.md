# Case Study & Technical Analysis: FA Mass Additions Upload

## Executive Summary
This upload maintains the Oracle Assets Prepare Mass Additions queue, the staging lines from which Oracle Assets creates new asset records. Fixed asset accountants use it to correct, group, split, post or hold many mass addition lines in one spreadsheet before the standard Post Mass Additions program creates the assets. The file is worked in Excel through Blitz Report™, and the source of each line is shown read-only.

## Business Challenge
*   **Queue clean-up:** Invoice lines that flow into the mass additions queue often need the category, location, asset number, tag or depreciation settings corrected before they become assets.
*   **Grouping of cost:** Several invoice lines that belong to one physical asset must be merged into one asset line, and their cost and units combined.
*   **Splitting cost:** A single invoice line sometimes has to be split into several assets, and the operations must be recorded consistently.
*   **Posting control:** Lines must be placed on hold, released for posting or deleted in bulk, so that only reviewed lines create assets.

## The Solution
*   Downloads the queue lines of a book that are not yet posted, merged or split, with their operation, queue status, cost, units, category and location.
*   Lets each row perform one operation: Update, Create, Merge, Split, Unsplit, Add to Asset or Undo Add to Asset.
*   Combines the lines that share a Merge Group label into the one row marked Primary Line, which carries the accumulated cost and, when Sum Units is Yes, the accumulated units, and is set to On Hold.
*   Uses the asset descriptive flexfield with the context of the asset category, so only the attributes of that category can be entered.

## Technical Architecture (High Level)
### Primary Tables
*   `FA_MASS_ADDITIONS`: the mass addition queue lines, with book, invoice, distribution and invoice line references, cost, units, posting status and the descriptive flexfield columns.
*   `FA_CATEGORIES_B_KFV`: the asset categories and their concatenated segments.
*   `FA_LOCATIONS_KFV`: the asset locations.
*   `GL_CODE_COMBINATIONS_KFV`: the expense account of each line.
*   `FA_ADDITIONS_B`: the existing asset that a line is added to.
*   `FA_LOOKUPS`: the queue name, asset type and Yes/No meanings.
*   `FND_DESCR_FLEX_CONTEXTS_VL`: the asset descriptive flexfield contexts, used when the category context is missing.
*   `PER_ALL_PEOPLE_F`: the employee to whom the asset is assigned.
*   `AP_SUPPLIERS`, `PA_PROJECTS_ALL` and `PA_TASKS`: the supplier, project and task that are shown as the source of each line.

### Logical Relationships
1.  The base set is `FA_MASS_ADDITIONS` lines whose posting status is not POSTED, MERGED or SPLIT.
2.  Category, location, expense account and assigned employee are each resolved by a lookup on their identifier, the employee only where the person is effective on the current date.
3.  The queue and asset type meanings come from `FA_LOOKUPS`.
4.  The supplier is found from the purchase order vendor identifier, and the project and task from their identifiers on the line.
5.  Each attribute column is resolved with the flexfield value display function under the asset descriptive flexfield, identified by application 140.
6.  Lines are identified for upload by book, invoice number, distribution line and invoice line, which are the keys the upload matches on.

## Parameters & Filtering
*   **Upload Mode:** selects whether the file is used to update existing lines or to create new ones.
*   **Book:** the asset book whose queue is maintained.
*   **Queue:** the queue action (Post, On Hold, Delete or On-Review) that is set on the lines when an Update is uploaded.
*   **Invoice Date From** and **Invoice Date To:** restrict the lines by invoice date.
*   **Creation Date From** and **Creation Date To:** restrict the lines by the date they were created in the queue.
*   **Supplier:** limits the lines to those from one supplier.

## Performance & Optimization
*   The base filter on posting status keeps posted, merged and split lines out of the queue before any lookups are performed.
*   Category, expense account, location and employee are resolved by scalar subqueries, one lookup per line for each of them.
*   Attribute value display is performed per attribute column, so limiting the selection to one book and one queue keeps the number of flexfield resolutions small.
*   Merge, split and add-to-asset are applied when the file is uploaded, not when it is downloaded.

## FAQ
**Q: What happens after the mass additions are uploaded?**
A: Run the standard Post Mass Additions program as before, which creates the assets from the lines that are in the queue for posting.

**Q: How are lines merged into one asset?**
A: Lines that share a Merge Group label are combined into the row marked Primary Line = Yes, which keeps the asset, accumulates the cost of the other lines and is set to On Hold.

**Q: Are supplier and purchase order details uploaded?**
A: No, Supplier, PO Number, Project, Task, Creation Date and Created By show the source of each line and are not uploaded.

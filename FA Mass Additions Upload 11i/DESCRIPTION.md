# Case Study & Technical Analysis: FA Mass Additions Upload 11i

## Executive Summary
The FA Mass Additions Upload 11i is an Excel upload that maintains the Oracle Assets Prepare Mass Additions queue. It lets an accountant update, create, merge, split, add to an existing asset or undo an add to asset for each queued line, and set the posting status of the line. Asset accountants use it to correct the cost, location, category or descriptive flexfield of invoice-based additions before they are posted, and to combine several invoice lines into one asset. After the upload, the standard Post Mass Additions program creates the assets as before. Blitz Report downloads the queue lines of the selected book, and the upload writes the changes back to the mass additions table.

## Business Challenge
*   **Queue correction:** Invoice lines that reach the mass additions queue often carry the wrong category, location, employee or cost, and correcting them one at a time is slow.
*   **Asset consolidation:** Several invoice lines for one physical asset must be merged into a single asset with the cost accumulated, and the merged lines held so they are not posted twice.
*   **Descriptive data:** Asset attributes must be entered in the context of the asset category, so each category needs its own set of values.
*   **Traceability:** Each queue line must stay linked to its invoice, distribution and supplier.

## The Solution
*   Downloads the queued mass additions for the selected book, with invoice number, distribution line, queue, cost, units, category, location and employee.
*   Uses an Operation column so each row can update, create, merge, split, unsplit, add to asset or undo an add to asset.
*   Merges the lines that share a Merge Group label into the row marked Primary Line = Yes, which accumulates the cost and is set to On Hold.
*   Sets the Queue column to Post, On Hold, Delete or On-Review on an update, and shows the asset descriptive flexfield values in the context of the category.

## Technical Architecture (High Level)
### Primary Tables
*   `FA_MASS_ADDITIONS`: the queue lines, with the book, invoice data, posting status and asset values.
*   `FA_ADDITIONS_B`: the asset master, used to find the asset number of an asset that a line is added to.
*   `FA_CATEGORIES_B_KFV` and `FND_DESCR_FLEX_CONTEXTS_VL`: the asset category and the descriptive flexfield context that the category defines.
*   `GL_CODE_COMBINATIONS_KFV`, `FA_LOCATIONS_KFV` and `PER_ALL_PEOPLE_F`: the expense account, location and assigned employee.
*   `PO_VENDORS`, `PA_PROJECTS_ALL` and `PA_TASKS`: the source supplier, project and task, which are shown and not uploaded.
*   `FA_LOOKUPS`: the queue, asset type and yes/no labels.

### Logical Relationships
1.  Each line is read from `FA_MASS_ADDITIONS` and filtered to posting statuses other than POSTED, MERGED and SPLIT.
2.  The category joins to the descriptive flexfield context, and the attribute columns are decoded through the flexfield value function using the category as context.
3.  The expense account, location and employee are scalar lookups on their code combination, location and person ids, with the employee valid on the current date.
4.  The supplier comes from `PO_VENDORS`, and the project and task from `PA_PROJECTS_ALL` and `PA_TASKS`, on their ids.
5.  The add to asset number is a lookup of `FA_ADDITIONS_B` on the asset id the line references.

## Parameters & Filtering
*   **Upload Mode:** selects the rows to download for update, create or both.
*   **Book** and **Queue:** select the asset book and the queue status of the lines.
*   **Invoice Date From** and **Invoice Date To:** bound the invoice dates of the lines.
*   **Creation Date From** and **Creation Date To:** bound the dates on which the lines were created.
*   **Supplier:** limits the lines to one supplier.

## Performance & Optimization
*   Every lookup in the select list is a scalar subquery on a primary key, so each mass addition line reads one row per lookup.
*   The posting status filter removes lines already posted, merged or split before any lookup runs.
*   The employee subquery is limited to the current date through the effective dates, so each assignment resolves to one person row.
*   Restricting Book and Queue keeps the number of lines small, since the attribute decoding runs for every row.

## FAQ
**Q: How do I merge two mass addition lines into one asset?**
A: Give both lines the same Merge Group label, mark one of them Primary Line = Yes, and upload. The primary line accumulates the cost of the others and is set to On Hold.

**Q: Do I need to run a standard program after the upload?**
A: Yes. Run the standard Post Mass Additions program to create the assets, as before.

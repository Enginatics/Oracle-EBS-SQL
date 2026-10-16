# Case Study & Technical Analysis: OKS Contract Termination Upload

## Executive Summary
The OKS Contract Termination Upload is a Blitz Report upload for terminating Oracle Service Contracts. It performs a full termination of a service contract, terminates an individual contract line or subline, or deletes a line from a contract that is still in the Entered status. The upload follows the Terminate action of the Service Contracts Authoring form, so the termination is processed by the same Oracle termination engine. Service contract administrators and renewals teams use it to close out many contracts or lines at the end of an agreement, after a customer cancels coverage, or when an installed base item is withdrawn. The workflow runs in Excel through Blitz Report.

## Business Challenge
*   **Contract close-out at scale:** Expired or cancelled service agreements must be terminated in bulk, and each termination must carry a date and a reason for audit.
*   **Partial terminations:** When one covered product is withdrawn, only its line or subline must be terminated, leaving the rest of the contract active.
*   **Irreversible actions:** A termination cannot be undone by the upload, so the rows must be reviewed carefully before they are applied.
*   **Consistency with the form:** Credits, billing schedules and statuses must be produced as they would be by the authoring form, not by direct table updates.

## The Solution
*   **Row-level actions:** Each row can request a full contract termination, a line or subline termination, or the deletion of a line on an Entered contract.
*   **Required termination data:** Termination date and termination reason are required for any termination.
*   **Engine-based processing:** The upload calls the Oracle service contract termination and contract publication APIs, so statuses, credits, billing schedules and history are produced by the engine.
*   **Scope control:** Only service contracts authored in the accessible operating units are listed, and only line styles that can be terminated or deleted are included.

## Technical Architecture (High Level)
### Primary Tables
*   `OKC_K_HEADERS_ALL_B`: the contract header, with the contract number, modifier, status, start and end dates and the authoring organization.
*   `OKC_K_LINES_B`: the contract lines and sublines, with their line style, status, dates and negotiated amount.
*   `OKC_LINE_STYLES_TL`: the line type name for each line style.
*   `OKC_STATUSES_V`: the contract and line status meanings.
*   `OKC_K_ITEMS`: the item or object that each line covers.
*   `MTL_SYSTEM_ITEMS_VL`: the inventory item of a service or usage line.
*   `CSI_ITEM_INSTANCES`: the installed base instance of a customer product line.
*   `CSI_COUNTERS_TL`: the counter name of a counter line.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit of the contract.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units accessible to the current user.

### Logical Relationships
1.  `OKC_K_HEADERS_ALL_B` is filtered to service contracts (the SCS code SERVICE) in the accessible authoring organizations, and joins to its operating unit and status.
2.  The header joins to `OKC_K_LINES_B` on the contract ID, restricted to the line styles that the termination can act on.
3.  Each line joins to its parent line through an outer join, so sublines show the parent line number.
4.  Each line joins to `OKC_LINE_STYLES_TL` for the line type name, and to `OKC_STATUSES_V` for the line status.
5.  The object of the line is resolved from `OKC_K_ITEMS` and, depending on its object type, from the inventory item, the installed base instance or the counter.

## Parameters & Filtering
*   **Upload Mode:** sets the download or the upload action.
*   **Operating Unit:** limits the contracts to one authoring organization.
*   **Contract Number:** selects one contract.
*   **Contract Status:** filters by the status of the contract header.
*   **Line Status:** filters by the status of the contract line.

## Performance & Optimization
*   The operating unit restriction is an `IN` subquery on `MO_GLOB_ORG_ACCESS_TMP`, which keeps the header read to the accessible organizations.
*   The item lookup is a correlated subquery that returns one object name per line using `ROWNUM`, so each line produces one row.
*   The parent line join is an outer join on the parent line ID, so top-level lines and sublines are read in one pass.
*   Only the line styles in the termination set are read, which limits the lines returned to those that the upload can act on.

## FAQ
**Q: Can a termination be reversed through this upload?**
A: No. The description states that a termination cannot be undone by this upload, and that statuses, credits and billing schedules are produced by the Oracle termination engine.

**Q: Which fields are needed to terminate a contract?**
A: The termination date and the termination reason are required for any termination.

**Q: Can a line be deleted instead of terminated?**
A: Yes, Delete Line removes the line, but only on contracts that are still in the Entered status.

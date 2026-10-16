# Case Study & Technical Analysis: FND Attached Documents (Operating Unit Secured)

## Executive Summary
The FND Attached Documents (Operating Unit Secured) report lists the attachments held on operating unit striped documents, such as sales orders, purchase orders, requisitions, AP invoices, AR transactions, projects and delivery details. Each row shows the document the attachment belongs to, its category, title, file name and, for file attachments, a clickable download link. Short text, long text and URL attachments are shown inline. Procurement, order management and receivables users use it to locate supporting documents for their transactions. The report runs in Excel via Blitz Report.

## Business Challenge
*   **Locating supporting evidence:** Approvals, contracts, invoices and delivery proofs are attached to transactions in Oracle EBS, and finding them one document at a time is slow.
*   **Cross-organization exposure:** Attachments often contain commercial or customer information, so they must only be visible for the operating units the user can access.
*   **Mixed attachment types:** Files, URLs and text notes are stored in different structures, which makes a single view difficult to build in the forms.

## The Solution
*   **Operating unit security:** Only documents of the operating units accessible to the running responsibility are returned, using the MO security profile or operating unit profile.
*   **Entity-based reference:** Each attachment is linked to a readable reference, such as a purchase order number with its release, a requisition line, a sales order line or an invoice number.
*   **Typed content:** Short text and long text are read from their own tables, URLs become hyperlinks, and files get a secure download link.
*   **Document filters:** Parameters for document entity, category, datatype, file name, text content, creation date and creator narrow the list.

## Technical Architecture (High Level)
### Primary Tables
*   `FND_ATTACHED_DOCUMENTS`: links each document to its entity and primary key values, with the sequence number.
*   `FND_DOCUMENTS`: the document header, with datatype, category, usage, security and creation details.
*   `FND_DOCUMENTS_TL`: the translated title and description of each document.
*   `FND_DOCUMENT_DATATYPES_VL`, `FND_DOCUMENT_CATEGORIES_VL`, `FND_DOCUMENT_ENTITIES_VL`: datatype, category and entity names.
*   `FND_LOBS`: the stored file content and file name for file attachments.
*   `FND_DOCUMENTS_SHORT_TEXT`, `FND_DOCUMENTS_LONG_TEXT`: the inline text of short and long text attachments.
*   `FND_DM_NODES`: the document management node for the storage location.
*   `PO_HEADERS_ALL`, `PO_RELEASES_ALL`, `PO_LINES_ALL`, `PO_LINE_LOCATIONS_ALL`, `PO_REQUISITION_HEADERS_ALL`, `PO_REQUISITION_LINES_ALL`: purchasing entities.
*   `OE_ORDER_HEADERS_ALL`, `OE_ORDER_LINES_ALL`, `WSH_DELIVERY_DETAILS`: order management and shipping entities.
*   `AP_INVOICES_ALL`, `RA_CUSTOMER_TRX_ALL`, `RA_CUSTOMER_TRX_LINES_ALL`, `PA_PROJECTS_ALL`: payables, receivables and projects entities.
*   `HR_ALL_ORGANIZATION_UNITS_VL`, `GL_LEDGERS`, `MO_GLOB_ORG_ACCESS_TMP`: operating unit and ledger names, and the security list.

### Logical Relationships
1. `FND_DOCUMENTS` is joined to `FND_DOCUMENTS_TL` on document identifier, filtered to the session language.
2. `FND_ATTACHED_DOCUMENTS` is joined to `FND_DOCUMENTS` on document identifier, and limited to the fifteen supported entity names.
3. A `CASE` expression on the entity name returns the operating unit of the attached record, and the result is joined to `HR_ALL_ORGANIZATION_UNITS_VL`.
4. The operating unit is checked against `MO_GLOB_ORG_ACCESS_TMP`, so only permitted units are returned.
5. The entity name is matched to `FND_DOCUMENT_ENTITIES_VL`, and the datatype selects short text, long text, file or URL content.

## Parameters & Filtering
*   **Operating Unit:** Restricts the output to one operating unit within the accessible set.
*   **Sales Order Number, PO Number, Requisition Number:** Return the header and line attachments of one document. Their lists show only documents that have attachments the report can return.
*   **Document Entity, Category, Datatype:** Filter on the entity the attachment belongs to, its category and its type of content.
*   **File Name contains, Short Text contains, Text contains:** Search the file name and the inline text.
*   **Creation Date from/to, Created within days, Created By:** Filter on when and by whom the attachment was created.

## Performance & Optimization
*   Operating unit security is applied as an `IN` subquery on `MO_GLOB_ORG_ACCESS_TMP`, so the report reads only the units the responsibility can access.
*   The attachment list is restricted to the fifteen supported entity names before the operating unit lookups, which keeps the per-entity subqueries small.
*   Download links are generated per row, and they expire after the time set in the FND: Security File Download Time Limit profile option, so the report must be re-run to refresh them.

## FAQ
**Q: Why are items, work orders or journals missing from this report?**
A: The report covers operating unit striped entities only. The description directs users to the FND Attached Documents report for attachments on entities such as items and journals.

**Q: Why does a download link stop working?**
A: The secure file download link expires after the number of minutes set in the FND: Security File Download Time Limit profile option; re-running the report creates fresh links.

**Q: Which purchasing documents can carry attachments in this report?**
A: Purchase order headers, releases, lines and shipments, and requisition headers and lines are all supported, with the purchase order number, release and line shown in the reference column.

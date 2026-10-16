# Executive Summary
The **FND Attached Documents** report is a powerful tool for extracting and analyzing attachments across the entire EBS system. It links generic attachment data (stored in `FND_LOBS`) back to the specific business objects (like POs, Invoices, or Journals) they belong to.

# Business Challenge
*   **Data Governance:** Identifying large or inappropriate files attached to transactions.
*   **Audit Support:** Retrieving all supporting documents (e.g., scanned invoices) for a sample of transactions.
*   **Storage Management:** Analyzing which modules or users are consuming the most database storage with attachments.

# The Solution
This Blitz Report bridges the gap between technical storage and business context:
*   **Entity Mapping:** Dynamically links attachments to their parent entity (e.g., linking a file to `PO_HEADERS_ALL` via `pk1_value`).
*   **Content Search:** Allows searching within Short Text and Long Text attachments.
*   **Metadata Analysis:** Reports on file size, type, creation date, and author.

# Technical Architecture
The report queries `FND_ATTACHED_DOCUMENTS`, `FND_DOCUMENTS`, and `FND_LOBS`. It uses complex dynamic SQL or extensive `LEFT JOINS` to resolve the `pk1_value`, `pk2_value`, etc., into meaningful business keys (like Order Number or Invoice Number) based on the `entity_name`.

# Parameters & Filtering
*   **Entity/Category:** Filter by "Requisition Headers", "AP Invoices", etc.
*   **Date Range:** When the attachment was created.
*   **File Content:** Search for keywords in text attachments.

# Performance & Optimization
*   **Entity Filter:** Always filter by `Document Entity` or `Attached to Application` to avoid scanning the entire attachment repository, which can be massive.
*   **LOB Access:** The report typically lists metadata. Downloading the actual BLOB content for thousands of rows would be very slow.

# FAQ
*   **Q: Can I download the files?**
    *   A: The report lists the files. Blitz Report has features to download attachments if configured, or you can use the URL links if generated.
*   **Q: Why do I see "pk1_value" instead of "Invoice Number"?**
    *   A: If the specific entity mapping isn't defined in the report's logic, it falls back to the raw primary key. The report covers most standard entities (PO, AP, OM, GL, WIP).

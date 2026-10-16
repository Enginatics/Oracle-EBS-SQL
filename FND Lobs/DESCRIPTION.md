# Executive Summary
The **FND Lobs** report allows you to search and extract files stored in the database as Large Objects (LOBs). This includes attachments, help files, and Blitz Report templates.

# Business Challenge
*   **Attachment Search:** Finding a specific document attached to a transaction when you only know the filename.
*   **Space Management:** Identifying large files that are consuming database storage.
*   **Data Extraction:** Downloading binary files (PDFs, Images) directly from the database for archiving.

# The Solution
This Blitz Report queries the `FND_LOBS` table:
*   **Metadata:** File Name, Content Type (MIME), and Upload Date.
*   **Program:** The program or entity that owns the file.
*   **Content:** Can optionally extract the binary data (BLOB).

# Technical Architecture
The report queries `FND_LOBS`.

# Parameters & Filtering
*   **File Name like:** Search by partial filename.
*   **Include File Data:** Toggle to include the actual file content.
*   **Uploaded within x days:** Filter for recent uploads.

# Performance & Optimization
*   **Caution:** Do not run with "Include File Data" without filters, as extracting gigabytes of BLOB data will impact performance.

# FAQ
*   **Q: Can I delete files from here?**
    *   A: No, this is a read-only report. To delete files, you should use the "Purge Obsolete Generic File Manager Data" concurrent program.

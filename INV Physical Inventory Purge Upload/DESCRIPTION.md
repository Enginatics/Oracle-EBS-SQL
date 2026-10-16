# INV Physical Inventory Purge Upload - Case Study & Technical Analysis

## Executive Summary
The **INV Physical Inventory Purge Upload** is a utility tool designed to clean up historical physical inventory data. Over time, the `MTL_PHYSICAL_INVENTORIES` and related tag tables can grow significantly, cluttering the system and slowing down performance. This tool allows for the bulk purging of old inventory counts.

## Business Challenge
Oracle Inventory retains physical inventory history indefinitely unless explicitly purged.
-   **Data Clutter:** Users see a list of 50 old physical inventories when they open the form, making it hard to find the current one.
-   **Performance:** Large volumes of historical tag data can slow down the generation of new tags.
-   **Compliance:** Data retention policies may dictate that data older than 7 years should be removed.

## Solution
The **INV Physical Inventory Purge Upload** provides an Excel-based interface to manage the purging process. Instead of running the purge program manually for each inventory, users can list them in Excel and upload the request.

**Key Features:**
-   **Bulk Processing:** Purge multiple physical inventories in one go.
-   **Selective Purge:** Option to purge "Tags Only" (keeping the header) or the "Full Physical Inventory".
-   **Safety Checks:** Validates that the inventory is closed before allowing a purge.

## Technical Architecture
This is a WebADI or Blitz Report Upload style tool that interfaces with the standard Oracle concurrent programs.

### Key Tables and Views
-   **`MTL_PHYSICAL_INVENTORIES_V`**: View used to select inventories eligible for purge.
-   **`MTL_PARAMETERS`**: Organization validation.

### Core Logic
1.  **Upload:** Reads the list of Physical Inventory Names and Organization Codes from Excel.
2.  **Validation:** Checks if the inventory exists and is in a state that allows purging.
3.  **Execution:** Submits the standard "Purge Physical Inventory" concurrent request for each valid row.

## Business Impact
-   **System Hygiene:** Keeps the database clean and the user interface uncluttered.
-   **Performance:** Improves the speed of future physical inventory setups.
-   **Efficiency:** Reduces the administrative burden of database maintenance.

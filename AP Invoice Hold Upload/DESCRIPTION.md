# Case Study & Technical Analysis: AP Invoice Hold Upload

## Executive Summary
The AP Invoice Hold Upload is a bulk maintenance tool for Oracle Payables invoice holds, the Excel equivalent of the Holds tab in the Invoice Workbench. It is written for accounts payable supervisors and invoice processing teams who must release large numbers of holds after a supplier or matching issue is cleared, or place manual holds on a list of invoices. The download shows the open holds that match the selection parameters, and the user marks the rows to release or adds rows to place new holds, then uploads the file. The report is an R12-only upload in the Payables area of Oracle EBS.

## Business Challenge
*   **Hold backlog:** Invoices held for matching, receipt or manual reasons can accumulate across many suppliers, and releasing them one at a time in the Workbench is slow.
*   **Identifying the right hold:** An invoice can carry several holds of the same name, for example matching holds on different purchase order shipments, so a bulk action must target the exact hold.
*   **Controlled release:** Holds must be released with a recorded release name and reason, and system holds must not be released by hand when they can only be cleared by correcting the invoice.

## The Solution
*   **Open hold extraction:** The report returns open holds, meaning rows in `AP_HOLDS_ALL` with no release lookup code, with the invoice, supplier, site, hold name, reason and hold details.
*   **Precise hold identification:** The PO number, PO line, PO shipment and invoice line columns identify the exact hold when several share a name.
*   **Release and placement in one file:** A Release Name column marks holds for release, and a new row with a Hold Name and no Release Name places a manual hold.

## Technical Architecture (High Level)
### Primary Tables
*   `AP_HOLDS_ALL`: one row per hold placed on an invoice line, including the release lookup code that identifies open holds.
*   `AP_INVOICES_ALL`: the invoice header, including invoice number, date, amount and currency.
*   `AP_SUPPLIERS`: the supplier name and number.
*   `AP_SUPPLIER_SITES_ALL`: the supplier site for each invoice.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit of the invoice.
*   `AP_HOLD_CODES`: the hold code definitions, including their status and releasability.
*   `AP_LOOKUP_CODES`: the translated hold name and the system user label.
*   `PO_LINE_LOCATIONS_ALL`, `PO_LINES_ALL` and `PO_HEADERS_ALL`: the purchase order references behind matching holds.

### Logical Relationships
1. `AP_HOLDS_ALL` joins to `AP_INVOICES_ALL` on the invoice identifier, which provides the invoice header for each hold.
2. Invoices join to `AP_SUPPLIERS` and `AP_SUPPLIER_SITES_ALL` through the vendor and vendor site identifiers, using outer joins.
3. Invoices join to `HR_ALL_ORGANIZATION_UNITS_VL` on the organisation identifier to give the operating unit name.
4. Holds join to `AP_HOLD_CODES` and to `AP_LOOKUP_CODES` through the hold lookup code, to give the hold name.
5. Holds join to `PO_LINE_LOCATIONS_ALL`, then to `PO_LINES_ALL` and `PO_HEADERS_ALL`, to give the PO number, line and shipment.
6. Access is restricted to operating units listed in `MO_GLOB_ORG_ACCESS_TMP`.

## Parameters & Filtering
*   **Upload Mode:** Determines whether the file is used to create or update holds.
*   **Operating Unit, Supplier and Invoice Number:** Narrow the download to the invoices of one operating unit, supplier or invoice.
*   **Invoice Date From and Invoice Date To:** Bound the invoice dates of the holds returned.
*   **Hold Date From and Hold Date To:** Bound the date on which each hold was placed.
*   **PO Number:** Limits holds to invoices matched to one purchase order.
*   **User Releasable Only:** When set to Yes, the default, excludes system holds from the download. Setting it to No allows the user to review system holds.

## Performance & Optimization
*   **Open-hold driver:** The first predicate restricts `AP_HOLDS_ALL` to rows with no release lookup code, so the query starts from the open holds rather than from all invoices.
*   **Outer joins for purchase order references:** Purchase order tables are joined with outer joins, so holds that are not matched to a purchase order are still returned.

## FAQ
**Q: How do I release several AP invoice holds at once in Oracle EBS?**
A: Download the holds with AP Invoice Hold Upload, enter a Release Name on the rows to release, and upload the file.

**Q: Why does the download not show all holds on an invoice?**
A: By default only user releasable holds are returned. Set User Releasable Only to No to include system holds such as line variance.

**Q: Does releasing holds through the upload revalidate the invoice?**
A: The description states that releasing holds does not submit Invoice Validation. The invoice status is derived by Oracle and updates automatically, as it does after releasing holds in the form.

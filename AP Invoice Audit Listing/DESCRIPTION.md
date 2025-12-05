# Case Study & Technical Analysis: AP Invoice Audit Listing

## 1. Executive Summary

### Business Problem
Maintaining the integrity of the Accounts Payable process is crucial for preventing fraud, duplicate payments, and data entry errors. Organizations often struggle with:
- **Duplicate Invoices:** Risk of paying the same invoice twice due to data entry variations.
- **Incomplete Data:** Invoices entered without proper validation or missing critical fields.
- **Audit Compliance:** Difficulty in producing a clean, comprehensive list of invoices for external auditors.
- **Process Gaps:** Lack of visibility into invoices that bypass standard validation rules.

### Solution Overview
The **AP Invoice Audit Listing** is a direct import of the standard Oracle "Invoice Audit Listing" report. It provides a detailed register of invoices entered within a specific period, highlighting potential issues and serving as a primary source for AP auditing.

### Key Benefits
- **Fraud Prevention:** Helps identify irregularities in invoice entry, such as duplicate numbers or suspicious amounts.
- **Data Quality:** Highlights invoices with missing or inconsistent data.
- **Audit Trail:** Serves as a fundamental document for internal and external financial audits.
- **Operational Control:** Allows AP managers to review the volume and quality of invoice entry by the team.

---

## 2. Functional Analysis

### Report Purpose
This report lists invoices entered in the system, providing a snapshot of the AP liability. It is often used to verify that all physical invoices received have been correctly entered into Oracle Payables.

### Key Metrics & Data Points
- **Invoice Header:** Invoice Number, Date, Amount, Currency, Type (Standard, Credit Memo, etc.).
- **Supplier Details:** Supplier Name and Site.
- **Entry Details:** Who entered the invoice and when.
- **Status:** Validation status (Validated, Needs Revalidation, etc.).

### Intended Audience
- **AP Managers:** To review daily or weekly invoice entry volume and accuracy.
- **Internal Auditors:** To sample invoices for compliance testing.
- **External Auditors:** To verify the completeness of the AP subledger.

---

## 3. Technical Analysis

### Source Tables
The report is based on the standard Oracle report `APXINLST` and queries the core AP tables:
- `AP_INVOICES_ALL`: The primary source of invoice header data.
- `AP_SUPPLIERS`: Supplier master data.
- `HZ_PARTIES`: Party information linked to suppliers.
- `HR_ALL_ORGANIZATION_UNITS_VL`: Operating unit definitions.

### Critical Logic
- **Standard Oracle Logic:** As an imported standard report, it follows the exact logic of the Oracle `APXINLST` concurrent program.
- **Filtering:** It filters primarily by `Operating Unit`, `Invoice Date`, and `Invoice Amount`.
- **Sorting:** The output is typically sorted by Supplier and then Invoice Number to facilitate manual checking.

### Performance Considerations
- **Date Range:** The report is optimized for date-based queries. Running it for a very wide date range without other filters may impact performance.
- **Indexing:** Standard indexes on `AP_INVOICES_ALL` (like `INVOICE_DATE`, `VENDOR_ID`) support this report's query path.

---

## 4. Implementation Guide

### Setup Instructions
1. **Deploy SQL:** Use the provided SQL to create the report in Blitz Report.
2. **Parameters:**
   - `Operating Unit`: Mandatory for multi-org environments.
   - `Begin Invoice Date`: To define the audit period.
   - `Minimum Invoice Amount`: Optional filter to focus on high-value transactions.
   - `Invoice Type`: To filter for specific types like 'Standard' or 'Credit Memo'.

### Usage Scenarios
- **Weekly Audit:** Run every Friday to review the week's invoice entries.
- **High-Value Check:** Run with a minimum amount filter (e.g., > $10,000) to scrutinize large liabilities.
- **Duplicate Check:** Export to Excel and use conditional formatting to highlight potential duplicate invoice numbers or amounts.

---

## 5. Frequently Asked Questions (FAQ)

### Q: Is this different from the "Invoice Register"?
**A:** Yes, the Invoice Register is typically more detailed, showing line items and distributions. The Audit Listing is often more focused on the header level for a quick scan of entered invoices.

### Q: Can I see who approved the invoice?
**A:** This specific report focuses on *entry* and *audit* details. For approval history, the "AP Invoice Approval Status" report is more appropriate.

### Q: Does it show cancelled invoices?
**A:** It depends on the parameters and the specific SQL implementation, but standard audit listings often include all invoices to ensure a complete sequence check.

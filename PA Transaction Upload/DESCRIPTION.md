# Case Study & Technical Analysis: PA Transaction Upload

## Executive Summary
The PA Transaction Upload is an Excel upload that loads transactions from external cost collection systems into Oracle Projects. Transaction Import then creates pre-approved expenditure items from the rows, which are entered in the transaction interface table. Project accounting teams use the upload for costs that originate outside Oracle Projects, such as timesheets, usages, miscellaneous costs and supplier invoices from other systems, and for reversals and accruals of those costs. The Blitz Report download shows the interface rows already staged, so that they can be corrected before the Import Transactions step runs.

## Business Challenge
*   **External cost capture:** Project costs recorded in time, expense or procurement systems outside Oracle Projects must be brought into the projects with the right project, task and expenditure type.
*   **Accuracy before import:** Once transactions are imported, correcting them takes more work, so the team needs to check them in Excel before they are loaded.
*   **Accrual and reversal:** Costs that are reversed or accrued in a future period require flags on each transaction, and negative transactions need to be matched to their originals.
*   **Batch control:** Transactions are grouped into batches, and the batch name, transaction source and expenditure ending date must be consistent across a load.

## The Solution
*   Lists each interface row with its operating unit, transaction source, expenditure type class, expenditure ending date and batch name.
*   Shows the organization, employee, business group, project, task, expenditure type and the cost in the transaction currency and the accounting currency.
*   Shows the exchange rate type, date and rate for the accounting, receipt and project currencies, so that the conversion is visible before import.
*   Shows the debit and credit accounts, the GL date, the vendor and purchase order references, the accrual and billable flags, and the attribute columns.

## Technical Architecture (High Level)
### Primary Tables
*   `PA_TRANSACTION_INTERFACE_ALL`: the transactions staged for Transaction Import, with the project, task, expenditure, cost, rate and account fields.
*   `PA_TRANSACTION_SOURCES`: the user name of each transaction source.
*   `GL_CODE_COMBINATIONS_KFV`: the debit and credit accounts of each transaction.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit of each transaction.

### Logical Relationships
1.  `PA_TRANSACTION_INTERFACE_ALL` is joined to `HR_ALL_ORGANIZATION_UNITS_VL` on the organization id, which supplies the operating unit name.
2.  The transaction source name is a scalar lookup on `PA_TRANSACTION_SOURCES` through the transaction source code of the row.
3.  The debit and credit accounts are scalar lookups on `GL_CODE_COMBINATIONS_KFV` through the debit and credit code combination ids.
4.  The report applies the parameter values as filters on the interface row fields, so each interface row is returned with its own batch and source.

## Parameters & Filtering
*   **Operating Unit:** restricts the rows to one operating unit.
*   **Transaction Source:** restricts the rows to one transaction source.
*   **Batch Name:** restricts the rows to one batch, which is also the default batch name in the upload file.
*   **Expenditure Ending Date:** the expenditure ending date applied to the rows.
*   **All Negative Expend Unmatched:** when set to Yes, the Negative Txn Flag defaults to Yes for negative transactions.
*   **Reverse in Future Period:** when set to Yes, the Accrual Flag defaults to Yes for every row.
*   **Import Transactions:** shows whether the rows are to be submitted to Transaction Import.

## Performance & Optimization
*   The rows are read from a single interface table, so the query has one large source and small lookups for the operating unit, the sources and the accounts.
*   The account and source lookups are scalar subqueries on primary keys, which return one value for each row.
*   Filtering by Operating Unit, Transaction Source and Batch Name reduces the interface rows before the lookups run.
*   Restricting the download to one batch with the Batch Name parameter gives the user a smaller set of rows to check before Transaction Import is submitted.

## FAQ
**Q: How do I load timesheet or usage costs from an external system into Oracle Projects?**
A: Enter the transactions in the upload with their project, task, expenditure type and cost, and select the transaction source and batch name. Then run Transaction Import, which creates pre-approved expenditure items.

**Q: How do I flag negative transactions as unmatched?**
A: Set the All Negative Expend Unmatched parameter to Yes. Negative transactions then default to an Unmatched Negative Txn Flag of Yes in the upload.

**Q: What does the Reverse in Future Period parameter do?**
A: When set to Yes, it sets the Accrual Flag to Yes for every transaction entered in the upload, so the costs are reversed in the future period.

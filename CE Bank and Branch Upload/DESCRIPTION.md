# Case Study & Technical Analysis: CE Bank and Branch Upload

## Executive Summary
The CE Bank and Branch Upload is a spreadsheet-driven maintenance tool for banks and bank branches in Oracle Cash Management. It is written for treasury administrators and implementation teams who must set up or correct the bank master data behind bank accounts, payments and reconciliation. Each row represents one bank branch, and the upload creates a bank automatically when it does not exist. It creates or updates the branch within that bank through the Cash Management bank public API, which is TCA based. The report runs in the Cash Management module and is restricted to R12.

## Business Challenge
*   **Bulk bank setup:** Implementations often need hundreds of banks and branches loaded, and entering them through the form one at a time is slow and error prone.
*   **Consistent identification:** Banks and branches must be recognised consistently across uploads, so that re-running a file updates rows rather than creating duplicates.
*   **Routing and identifier data:** Routing numbers, BIC or SWIFT codes, EFT numbers and branch types must be captured correctly for payments and electronic transfers.
*   **Extended bank attributes:** Descriptive flexfield values on the bank and branch parties must be loaded alongside the core data.

## The Solution
*   **Create or update in one file:** Create mode opens an empty spreadsheet for new entries, and Create, Update mode returns the existing bank branches for editing and re-upload.
*   **Matching rules:** A bank is matched by country and bank name, with the bank number used where it is provided. A branch is matched by bank and branch name within that bank.
*   **Creation on demand:** If no matching bank is found, the bank is created, and the branch is then created within it.
*   **Bank fields applied once:** Short and alternate bank names are applied only on bank creation, so later uploads do not overwrite them.
*   **Flexfield columns:** The branch and bank party descriptive flexfield attributes are included as separate columns, so they are downloaded and uploaded with the rest of the row.

## Technical Architecture (High Level)
### Primary Tables
*   `CE_BANK_BRANCHES_V`: the view of banks and their branches, supplying the bank name, number, branch name, branch type, BIC or SWIFT code, EFT number and descriptions.
*   `HZ_PARTIES`: the party records for the branch and for the bank. The report joins it twice, once for each party.
*   `FND_TERRITORIES_VL`: the territory names used to translate the bank home country code into a country name.

### Logical Relationships
1. `CE_BANK_BRANCHES_V` joins to `HZ_PARTIES` on the branch party identifier, which provides the branch descriptive flexfield attributes.
2. `CE_BANK_BRANCHES_V` joins to `HZ_PARTIES` again on the bank party identifier, which provides the bank descriptive flexfield attributes under bank-prefixed column names.
3. The country name is derived by a scalar subquery on `FND_TERRITORIES_VL` using the bank home country code.
4. The result has one row per branch, so the bank's descriptive fields appear on each branch row.

## Parameters & Filtering
*   **Upload Mode:** Chooses between Create, which returns an empty template for new entries, and Create, Update, which returns the existing bank branches for amendment. The SQL retrieves all branches in both cases, so the mode governs the purpose of the file rather than a predicate in the query.

The report has no other user parameter. Narrowing the existing data is therefore done in the spreadsheet, and the bank and branch identifiers are the keys used when the file is uploaded.

## Performance & Optimization
*   **Branch-driven query:** The query starts from `CE_BANK_BRANCHES_V`, so the number of rows returned equals the number of bank branches in the instance.
*   **Two party joins:** Bank and branch party records are joined on their identifiers, which avoids any correlated lookup for the descriptive flexfield values.
*   **Upload-side validation:** The description notes that country-specific routing number format validation is bypassed to allow loading data across all countries. This is a behaviour of the upload API, not of the query.

## FAQ
**Q: How do I add a new bank and branch to Oracle Cash Management in bulk?**
A: Run CE Bank and Branch Upload in Create mode, enter the country, bank name and branch name for each row, and upload the file.

**Q: What happens if a bank already exists when I upload a branch for it?**
A: The bank is matched by country and bank name, with the bank number used where supplied. The branch is then created or updated within the existing bank.

**Q: Are the short bank name and alternate bank name updated on later uploads?**
A: No. The description states that these bank fields are applied only when the bank is created, not when it is updated.

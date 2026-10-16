# Case Study & Technical Analysis: OKL Lease Contract Update Upload

## Executive Summary
The OKL Lease Contract Update Upload changes the bill to customer account and bill to site on Oracle Lease Management contracts. It is written for lease administrators and receivables teams who must move billing for a portfolio of leases. The file holds one row per lease contract, and the user enters the new Bill To Customer Account, the Bill To Site, or both. The update is applied through the public contract API `OKLCONTRACTPUB.UPDATECONTRACTHEADER`, so the change follows Oracle's own rules. The report is R12 only and runs in the Lease Management area of Oracle EBS.

## Business Challenge
*   **Bulk billing changes:** When a lessee's billing arrangement changes, every affected lease header must be updated, and doing so one contract at a time in the form is slow.
*   **Keeping account and site consistent:** A bill to site belongs to one customer account, and a mismatched pair must be rejected rather than saved.
*   **Avoiding unnecessary rebooks:** A rebook is expensive, so the team needs to know whether a billing change requires one.
*   **Responsibility and privilege control:** Updates must run under the correct Lease Management responsibility, because the API enforces privileges.

## The Solution
*   **One row per contract:** Each row identifies a Lease Management contract by its number, operating unit and status, with its currency, start date and end date for context.
*   **Two editable fields:** The Bill To Customer Account and Bill To Site are the only fields the user changes, and all other columns are read only context.
*   **Consistency enforcement:** The API rejects a site that does not belong to the account on the row, so the two fields are changed together when the account changes.
*   **No rebook required:** The description states that this bill to change was verified against booked, evergreen, passed and incomplete contracts, so no rebook is needed for it.

## Technical Architecture (High Level)
### Primary Tables
*   `OKC_K_HEADERS_ALL_B`: the contract header, including the lease scope code, authoring organisation, status code, customer account and bill to site use.
*   `OKL_K_HEADERS`: the Lease Management extension of the contract header, supplying the deal type.
*   `OKC_STATUSES_V`: the translated contract status.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit that authored the contract.
*   `HZ_CUST_ACCOUNTS` and `HZ_PARTIES`: the bill to customer account and its party name.
*   `HZ_CUST_SITE_USES_ALL`, `HZ_CUST_ACCT_SITES_ALL`, `HZ_PARTY_SITES` and `HZ_LOCATIONS`: the chain from the bill to site use to its address.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units accessible to the current user.

### Logical Relationships
1. `OKC_K_HEADERS_ALL_B` joins to `OKL_K_HEADERS` on the contract identifier, which restricts the result to lease contracts.
2. The header joins to `HR_ALL_ORGANIZATION_UNITS_VL` on the authoring organisation and to `OKC_STATUSES_V` on the status code.
3. The header joins to `HZ_CUST_ACCOUNTS` on the customer account identifier, then to `HZ_PARTIES` on the party identifier.
4. The bill to site use joins to `HZ_CUST_SITE_USES_ALL`, then to `HZ_CUST_ACCT_SITES_ALL`, `HZ_PARTY_SITES` and `HZ_LOCATIONS` to give the address.
5. Contracts are limited to authoring organisations in `MO_GLOB_ORG_ACCESS_TMP`.

## Parameters & Filtering
*   **Upload Mode:** Determines whether the file is used to download the contracts or to upload changes.
*   **Operating Unit:** Restricts the contracts to one operating unit.
*   **Contract Number:** Shows one lease contract.
*   **Contract Status:** Filters on the translated status of the contract.
*   **Deal Type:** Filters on the deal type, translated through the book class lookup.
*   **Bill To Customer Account:** Restricts the contracts to those billed to one customer account.

## Performance & Optimization
*   **Lease scope first:** The query starts by restricting `OKC_K_HEADERS_ALL_B` to the LEASE scope code, so only lease contracts are read.
*   **Organisation access filter:** Authoring organisations are limited to those in the access table, which keeps the scan within the user's operating units.
*   **Outer joins for billing chain:** Customer, site and location tables are attached with outer joins, so contracts without a bill to party are still listed for correction.

## FAQ
**Q: How do I change the bill to customer on Oracle Lease Management contracts in bulk?**
A: Download the contracts with the upload, enter the new Bill To Customer Account and Bill To Site on the rows to change, and upload the file under a Lease Management responsibility.

**Q: Does changing the bill to require a rebook?**
A: No. The description states the bill to change does not require a rebook, and was verified against booked, evergreen, passed and incomplete contracts. Rebook is still needed for financial terms this upload does not touch.

**Q: Why does the update fail with a privilege message?**
A: The upload calls the public contract API, and Oracle refuses the update when it runs under a responsibility unrelated to Lease Management.

# Case Study & Technical Analysis: OKS Service Contract Line Upload

## Executive Summary
This upload maintains the lines of existing Oracle Service Contracts through the standard Service Contracts public APIs. It updates header and line values, adds service and usage lines, and adds covered product or counter sublines to a contract. Service contract administrators and service finance teams use it to extend or correct large contracts, for example when many covered products are added to a maintenance agreement or when usage lines are set up for counter-based billing. The template runs in Excel through Blitz Report.

## Business Challenge
*   **Contract maintenance volume:** Service contracts with many covered products need each product added as a subline, which is slow to do in the Contracts form.
*   **Usage and counter billing:** Usage lines for counter readings must carry a usage type, usage period and base reading that match the billing terms.
*   **Consistent header values:** Header details such as the bill-to and ship-to sites, billing profile and party roles repeat across every line and must agree.
*   **Status-based restrictions:** Changes that are not allowed for the current contract or line status must be rejected rather than forced through.

## The Solution
*   **Line or subline by number:** Rows with a line number update that line, and sublines use a parent.child format, so a second covered product of line 1 is written as 1.2.
*   **New lines by parent:** Rows without a line number create a new top line, or a subline when a parent line number is entered.
*   **Usage line rules:** Usage lines need a usage type, and a usage period except for negotiated per period lines. Actual per period and actual by quantity lines are invoiced in arrears, which the upload sets automatically.
*   **Header applied once:** Header values repeat on every row of a contract, and they are applied once.
*   **API validation:** Updates go through the Service Contracts APIs, so any rejected change returns the API message on the row.

## Technical Architecture (High Level)
### Primary Tables
*   `OKC_K_HEADERS_ALL_B` and `OKC_K_HEADERS_TL`: the contract header and its translated description and comments.
*   `OKS_K_HEADERS_B` and `OKS_BILLING_PROFILES_V`: the service-specific header and the billing profile.
*   `OKC_K_LINES_B` and `OKS_K_LINES_B`: the contract lines and their service-specific attributes, such as usage period.
*   `OKC_K_ITEMS`: the item or covered product attached to each line.
*   `OKC_LINE_STYLES_V`: the line type name.
*   `OKC_STATUSES_V`: the contract and line status meanings.
*   `OKC_K_PARTY_ROLES_B`: the additional party roles of the contract.
*   `HZ_CUST_ACCOUNTS`, `HZ_CUST_ACCT_SITES_ALL` and `HZ_CUST_SITE_USES_ALL`: the header and line bill-to and ship-to accounts and locations.
*   `CSI_ITEM_INSTANCES` and `CSI_COUNTERS_VL`: the covered product instance or counter.
*   `MTL_SYSTEM_ITEMS_VL` and `MTL_UNITS_OF_MEASURE_VL`: the item and the unit of measure.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units the session can access.

### Logical Relationships
1. `OKC_K_HEADERS_ALL_B` joins to `OKC_K_HEADERS_TL` on id, restricted to the session language, and to `OKS_K_HEADERS_B` on the chr id.
2. `OKC_K_HEADERS_ALL_B` joins to `OKC_K_LINES_B` on the dnz chr id, restricted to service line styles.
3. Each line joins to its parent line through the cle id, and to `OKS_K_LINES_B` for the usage period.
4. Each line joins to `OKC_K_ITEMS` for the covered product or counter, which resolves to `CSI_ITEM_INSTANCES` or `CSI_COUNTERS_VL` by the object type.
5. The bill-to and ship-to sites join to `HZ_CUST_SITE_USES_ALL`, and the account numbers come from `HZ_CUST_ACCOUNTS` on the header and line customer account ids, with a fallback through `HZ_CUST_ACCT_SITES_ALL` when the account is not set.

## Parameters & Filtering
*   **Upload Mode:** selects Create, or Create, Update to download existing contract lines.
*   **Operating Unit:** restricts the contracts to one operating unit.
*   **Contract Number:** restricts the contracts to one contract.
*   **Contract Status and Line Status:** restrict the contracts or lines to one status.

## Performance & Optimization
*   The service contract filter on the SCS code and the operating unit access list reduce the header scan before the line joins run.
*   Line style filtering restricts the lines to a fixed set of service and usage line style identifiers.
*   Site and account lookups are outer joins on site use id, so header and line detail is shown even when a site is missing.

## FAQ
**Q: How do I add a covered product to an existing service line?**
A: Enter a parent line number in the form parent.child, with the covered product and covered dates, and leave the line number empty.

**Q: Why is my usage line rejected?**
A: Usage lines need a usage type, and a usage period for every type except negotiated per period.

**Q: Can this upload remove a line?**
A: No. The upload does not remove lines.

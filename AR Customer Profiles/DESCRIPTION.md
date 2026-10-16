# Case Study & Technical Analysis: AR Customer Profiles

## Executive Summary
The AR Customer Profiles report lists the customer account and site-level profile settings held in Oracle Receivables. It covers profile class, payment terms, statement and dunning setup, collector assignment, credit settings and the profile amount limits for each currency. Credit, collections and order-to-cash teams use it to audit how customers are configured, confirm that accounts follow the intended profile class, and check credit hold and limit settings before a review or migration.

## Business Challenge
*   **Inconsistent account setup:** Customers with the same commercial terms can carry different payment terms, statement cycles or dunning sets, and these differences are hard to see account by account in the forms.
*   **Credit exposure control:** Overall credit limits, order credit limits and credit hold flags need to be reviewed together to know what each customer can buy.
*   **Collections ownership:** Each account needs a collector and a dunning or autocash rule set, and gaps show up as collections risk.
*   **Multi-currency limits:** Profile amounts such as minimum finance charges and credit limits can differ by currency, so each currency needs its own view.

## The Solution
*   **Account and site level detail:** The report joins the customer account, party, profile, and site uses so that each row describes one customer profile at one site use.
*   **Decoded settings:** Status, credit rating, risk code, tax printing option and balance forward bill type are translated to their meanings, and Yes/No flags are displayed as text.
*   **Per-currency amounts:** Profile amount rows are returned for each currency code, showing finance charge, statement, receipt, dunning and credit limit values side by side.
*   **Address and country:** The site address is formatted with the standard address formatting function and the country name is resolved from the territory code.

## Technical Architecture (High Level)
### Primary Tables
*   `HZ_CUST_ACCOUNTS`: the customer account, with the account number.
*   `HZ_PARTIES`: the party that owns the account, which supplies the customer name.
*   `HZ_CUSTOMER_PROFILES`: the account-level and site-level profile record that holds the payment, statement, dunning, collector and credit settings.
*   `HZ_CUST_PROFILE_CLASSES`: the profile class and its description.
*   `HZ_CUST_PROFILE_AMTS`: the profile amounts for each currency.
*   `HZ_CUST_SITE_USES_ALL`, `HZ_CUST_ACCT_SITES_ALL` and `HZ_PARTY_SITES`: the customer site uses, account sites and party sites.
*   `HZ_LOCATIONS` and `FND_TERRITORIES_VL`: the address and the country name.
*   `AR_COLLECTORS`, `RA_TERMS_VL`, `AR_STATEMENT_CYCLES`, `AR_DUNNING_LETTER_SETS`, `AR_AUTOCASH_HIERARCHIES` and `RA_GROUPING_RULES`: the collector, payment terms, statement cycle, dunning set, autocash rule set and grouping rule referenced by the profile.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit of the site use.
*   `MO_GLOB_ORG_ACCESS_TMP` and `DUAL`: the operating units the user can access, and a dual-based check on the Oracle release.

### Logical Relationships
1.  `HZ_CUST_ACCOUNTS` is joined to `HZ_PARTIES` on party ID and to `HZ_CUSTOMER_PROFILES` on the customer account ID.
2.  The profile is outer joined to its profile class, statement cycle, dunning letter set, autocash hierarchy, grouping rule and standard terms.
3.  The profile's site use is outer joined to `HZ_CUST_SITE_USES_ALL`, then to `HZ_CUST_ACCT_SITES_ALL`, `HZ_PARTY_SITES` and `HZ_LOCATIONS` to reach the address and country.
4.  `HZ_CUSTOMER_PROFILES` is outer joined to `HZ_CUST_PROFILE_AMTS` on the account profile ID, which adds one row per currency.
5.  The collector is joined directly, since every profile carries one.

## Parameters & Filtering
*   **Operating Unit:** Limits site-level profiles to the chosen operating unit.
*   **Customer Name, Account Number, Account Number From and Account Number To:** Select customers by name or by an account number or range.
*   **Profile Class:** Limits the report to customers in one profile class.
*   **Collector:** Shows only the accounts assigned to a named collector.
*   **Credit Hold:** Filters accounts by whether the credit hold flag is set.

## Performance & Optimization
*   **Security-restricted site filter:** Site-level profiles are kept only when the site use belongs to an operating unit in `MO_GLOB_ORG_ACCESS_TMP`, so the extract respects the user's org access.
*   **Account-level profiles retained:** Profiles with no site use are kept through the null site use test, so account-level settings are not lost by the site join.
*   **Outer joins to optional references:** Classes, terms, statement cycles, dunning sets and address data are outer joined, so a profile with a missing optional setting still appears.
*   **Per-currency expansion:** Profile amounts add one row per currency, so row counts grow with the number of currencies configured on each profile.

## FAQ
**Q: Which customer profile settings does this report show?**
A: It shows the profile class, payment terms, statement cycle and statement options, dunning letter set, autocash rule set, collector, credit rating, risk code, credit hold, credit check, and the overall and order credit limits.

**Q: Why does a customer appear on several rows?**
A: A customer appears once for each currency that has profile amounts, and once for each site use that carries a profile.

**Q: How do I find customers on credit hold for one collector?**
A: Enter the Collector parameter together with Credit Hold set to Yes, which restricts the rows to accounts that match both conditions.

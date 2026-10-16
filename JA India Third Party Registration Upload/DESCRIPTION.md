# Case Study & Technical Analysis: JA India Third Party Registration Upload

## Executive Summary
This upload creates and updates India localization third party registrations for customers and suppliers in Oracle E-Business Suite. It maintains the tax and registration identifiers that Indian compliance requires, such as PAN, TAN, TIN, GST and service tax numbers, together with the TDS section and assessable price list where the regime calls for them, and the reporting codes linked to each registration. Indian finance and tax compliance teams use it to load registrations for a large supplier and customer base, and to keep the registration dates correct for each operating unit. The template runs in Excel through Blitz Report.

## Business Challenge
*   **Statutory identifiers:** Every Indian supplier and customer that is taxed or reported must carry the correct registration numbers for its regime.
*   **Large party base:** Registrations must be entered for each party and each party site, which is slow to do in the forms.
*   **Regime-specific fields:** TDS and non-TDS regimes need different fields, and the wrong one invalidates the registration.
*   **Ordering of records:** Reporting codes depend on the registration they belong to, so registrations must exist before their codes are loaded.

## The Solution
*   **Two record types:** A Registration row creates or updates a party registration. A Reporting Code row creates or updates a reporting code linked to a registration.
*   **Party and site selection:** The operating unit determines which party sites are offered. Leaving the site blank creates a registration without a site.
*   **Regime-driven fields:** An assessable price list is used for non-TDS regimes, and a default TDS section for TDS regimes.
*   **Effective dates:** Registration and reporting code start and end dates are set per row, with the start date defaulting to 1 July 2017, the India GST implementation date.
*   **Load order:** The file processes registrations first and reporting codes second, which matches the dependency between them.

## Technical Architecture (High Level)
### Primary Tables
*   `JAI_PARTY_REGS_V`: the third party registration header, with party class, party number, name and operating unit.
*   `JAI_PARTY_REG_LINES_V`: the registration lines, with regime, registration type, registration number, secondary registration, price list, TDS section and effective dates.
*   `JAI_REPORTING_ASSOCIATIONS_V`: the reporting codes associated with a third party registration.

### Logical Relationships
1. `JAI_PARTY_REGS_V` joins to `JAI_PARTY_REG_LINES_V` on the party registration id, for Registration rows.
2. `JAI_PARTY_REGS_V` joins to `JAI_REPORTING_ASSOCIATIONS_V` on the party registration id, with the entity code restricted to third party, for Reporting Code rows.
3. Both row sets are limited to registrations whose registration class is third party.
4. The two row sets are combined with UNION ALL and ordered by party type, party number, record type and registration identifiers.

## Parameters & Filtering
*   **Operating Unit:** restricts the registrations to one operating unit, and determines the party sites offered.
*   **Party Type:** restricts the registrations to suppliers or customers.
*   **Party Name and Party Number:** select one supplier or customer.
*   **Party Site Name:** restricts the registrations to one party site.
*   **Regime Code:** restricts the registrations to one regime.
*   **Registration Number:** finds one registration by its number.

## Performance & Optimization
*   The third party class filter is applied to both halves of the UNION ALL, so no other registration class is read.
*   The registration view is joined to the line and association views on identifiers, so each registration is read once per line or code.
*   Ordering uses the party keys and nulls last on line identifiers, so reporting code rows sit beneath their registration.

## FAQ
**Q: Why is my reporting code rejected on upload?**
A: The registration it belongs to must exist first. Upload the Registration rows in the file, and then upload the Reporting Code rows.

**Q: Which fields apply to a TDS regime?**
A: The Default TDS Section applies to a TDS regime. The Assessable Price List applies to a non-TDS regime.

**Q: What is the default start date for a registration?**
A: The Registration Start Date defaults to 1 July 2017, the India GST implementation date, and can be changed for each row.

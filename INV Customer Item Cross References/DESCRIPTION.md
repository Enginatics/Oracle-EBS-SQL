# Case Study & Technical Analysis: INV Customer Item Cross References

## Executive Summary
This report lists customer item cross references, which link the part numbers a customer uses to the item numbers of the item master. It shows one row per cross reference, with the customer, the customer item, the internal item, the preference rank and the planning and container settings of the customer item. Order management, sales and inventory staff use it to translate customer part numbers into internal items when orders and demands are entered. It runs in Excel through Blitz Report™.

## Business Challenge
*   **Customer part numbers:** Customers order using their own part numbers, which must be matched to the correct internal item before an order can be entered or a demand loaded.
*   **Multiple matches:** One customer item can be cross-referenced to more than one internal item, and the preferred item must be identifiable.
*   **Site-level definitions:** A customer item can be defined for the whole customer, for an address category or for a single ship-to address, and each level needs to be visible.
*   **Planning settings:** Minimum fill, demand tolerance and dependent planning settings on the customer item affect how demand is planned.

## The Solution
*   Shows each cross reference with the customer name and number, the customer item and its description, and the internal item and description it links to.
*   Displays the definition level of each customer item, and the address category and site number and address where the definition applies to one.
*   Lists the preference rank and the active status of each cross reference, so that the preferred internal item for a customer item is clear.
*   Shows the commodity code, the master and detail container items, the minimum fill percentage, the demand tolerances and the planning flags of each customer item.

## Technical Architecture (High Level)
### Primary Tables
*   `MTL_CUSTOMER_ITEMS`: the customer items, with the customer, address, definition level, containers, planning and tolerance settings.
*   `MTL_CUSTOMER_ITEM_XREFS`: the cross references from each customer item to an internal item, with the preference number and active flag.
*   `HZ_CUST_ACCOUNTS` and `HZ_PARTIES`: the customer account number and the customer name.
*   `HZ_CUST_ACCT_SITES_ALL` and `HZ_PARTY_SITES`: the address of a customer item defined at address level.
*   `MTL_COMMODITY_CODES`: the commodity code of the customer item.
*   `MTL_SYSTEM_ITEMS_VL`: the internal item, the master container and the detail container.
*   `MTL_PARAMETERS`: the master organization of the cross reference.

### Logical Relationships
1.  Each customer item is joined to its customer account and then to the party, which supplies the customer name.
2.  The address of a customer item is joined through the customer account site to the party site, using outer joins because the address is optional.
3.  Each customer item is joined to its model customer item, master container and detail container, with the container items matched by item and organization.
4.  Each customer item is outer-joined to its cross references, and each cross reference to its master organization and internal item.
5.  Blank cross reference columns are retained, so a customer item without a cross reference is still listed.
6.  The output is ordered by customer name, definition level, customer item and preference number.

## Parameters & Filtering
*   **Customer Name:** restricts the output to one customer.
*   **Customer Item:** restricts it to one customer item number.
*   **Item:** restricts it to cross references to one internal item.
*   **Definition Level:** restricts it to customer items defined at one level, such as customer, address category or address.

## Performance & Optimization
*   Every join to a customer, address or item table is an outer join on an identifier, so the cost is one keyed lookup per row for each join.
*   The cross reference table is the largest driver, so a customer or customer item filter keeps the result small.
*   The address formatting function is called only for customer items that have an address, which limits the number of formatted addresses produced.
*   Item descriptions and container names come from the item view and are read once per row, without repeating the customer joins.

## FAQ
**Q: What does the preference rank on a customer item cross reference mean?**
A: The rank is the preference number of the cross reference, so the lowest number identifies the internal item preferred for that customer item.

**Q: How are customer items defined at address level shown?**
A: Customer items defined at address category or address level show the address category and the site number and address of the customer site.

**Q: What happens when a customer item has no cross reference?**
A: It is still listed, with blank internal item columns, so unlinked customer items can be found.

# Case Study & Technical Analysis: IEX Dunning History

## Executive Summary
The IEX Dunning History report lists the dunning letters that Oracle Advanced Collections sent to customers, one row per dunning. Each row shows the customer, account and bill-to site that was dunned, the dunning plan and letter template, the delivery method, the status of the dunning and the amount due when the letter was issued. Collections managers and credit controllers use it to confirm which customers were contacted, by what route and at what level, and to evidence the collection effort on overdue accounts. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Collection effort evidence:** Credit teams must show which dunning letters were sent, when, and for what amount, to support escalation and write-off decisions.
*   **Dunning level clarity:** Customer, account, bill-to and delinquency level dunnings target different objects, and the target of each letter must be identified correctly.
*   **Delivery and status tracking:** Delivery method, delivery status and confirmation mode must be checked when a letter is disputed or returned.
*   **Collector accountability:** Each dunning must be attributed to the collector responsible for the customer.

## The Solution
*   **Dunning object resolution:** The report derives the party, account and bill-to site from the dunning level, so a customer level dunning has no account and a delinquency level dunning is linked to its delinquent transaction.
*   **Delinquency detail:** For delinquency level dunnings, the due date of the delinquent transaction and the days past due on the dunning date are shown.
*   **Collector fallback:** The collector is taken from the bill-to site profile, then from the account profile, then from the party profile.
*   **Letter and delivery details:** The template name, letter name, delivery method, contact and status are resolved to readable values.

## Technical Architecture (High Level)
### Primary Tables
*   `IEX_DUNNINGS`: one row per dunning, with its level, plan, template, method, status, amount and dates.
*   `IEX_DELINQUENCIES_ALL`: the delinquency record that links a delinquency level dunning to its payment schedule and customer site.
*   `IEX_DUNNING_PLANS_VL`: the dunning plan name.
*   `XDO_TEMPLATES_VL` and `JTF_FM_TEMPLATE_ALL`: the letter templates, from the XML publisher and the fulfillment template sources.
*   `AR_PAYMENT_SCHEDULES_ALL`: the delinquent transaction, its due date and amount due.
*   `HZ_CUST_ACCOUNTS`, `HZ_PARTIES`, `HZ_CUST_SITE_USES_ALL` and `HZ_CUST_ACCT_SITES_ALL`: the customer, account and bill-to site.
*   `HZ_CUSTOMER_PROFILES` and `AR_COLLECTORS`: the collector profile and collector name.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit name.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units accessible to the user.

### Logical Relationships
1.  The inner query reads `IEX_DUNNINGS` and outer joins `IEX_DELINQUENCIES_ALL` on the delinquency ID, limited to the accessible operating units.
2.  The derived party, account and site values are set by a `DECODE` on the dunning level, which uses the dunning object ID or the delinquency record.
3.  The cust account is filled from the site use when the account is not directly known, through `HZ_CUST_SITE_USES_ALL` and `HZ_CUST_ACCT_SITES_ALL`.
4.  The outer query joins the account, party and site, and the payment schedule of the delinquent transaction in `AR_PAYMENT_SCHEDULES_ALL`.
5.  The collector, plan and template are resolved by correlated subqueries, and results are ordered by party name, account number, creation date and dunning ID.

## Parameters & Filtering
*   **Operating Unit:** limits the dunnings to one organization within the accessible set.
*   **Dunning Date From** and **Dunning Date To:** bound the date the dunning was created.
*   **Customer Name** and **Account Number:** identify the customer or account dunned.
*   **Dunning Level:** filters by the level of the dunning, such as customer, account, bill-to or delinquency.
*   **Dunning Plan:** limits the output to dunnings issued under one plan.
*   **Delivery Method:** limits the output to one method of sending the letter.

## Performance & Optimization
*   The organization restriction uses an `IN` subquery on `MO_GLOB_ORG_ACCESS_TMP`, so the report reads only dunnings for accessible operating units.
*   The delinquency link is an outer join, so customer level and account level dunnings are kept even without a delinquency record.
*   Collector, plan and template names are fetched by correlated subqueries on primary keys, which keeps each dunning to one row.
*   The site-to-account lookup is used only when the account is not already present on the dunning, which limits the number of joins that are evaluated.

## FAQ
**Q: How is the dunned customer identified for a customer level dunning?**
A: The customer is taken from the dunning object itself, and the account and bill-to site are left blank because the dunning is not tied to them.

**Q: Who is shown as the collector for a dunning?**
A: The collector of the bill-to site profile, or if none, the collector of the account profile, or if none, the collector of the party profile.

**Q: How do I see how many days a delinquent invoice was overdue when the letter was sent?**
A: Use the days past due column for a delinquency level dunning, which is the dunning date minus the due date of the delinquent transaction.

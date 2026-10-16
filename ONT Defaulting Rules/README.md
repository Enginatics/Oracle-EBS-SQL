---
layout: default
last_modified_at: 2026-10-16
title: 'ONT Defaulting Rules | Oracle EBS SQL Report'
description: 'Shows the complete Order Management defaulting rules setup – Oracle EBS Order Management SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Order Management, Enginatics, ONT, Defaulting, Rules, oe_def_condn_elems_v, oe_def_ak_attr_ext_v, oe_def_ak_obj_ext_v'
permalink: /ONT%20Defaulting%20Rules/
report_name: 'ONT Defaulting Rules'
report_web_name: ont-defaulting-rules
module: 'Order Management'
module_url: /modules/order-management/
---

# ONT Defaulting Rules – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ont-defaulting-rules/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-defaulting-rules) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-defaulting-rules).
**Oracle EBS module:** [Order Management](/modules/order-management/ "Oracle EBS Order Management reports") · [all Order Management reports](/modules/order-management/)  

## Overview
Shows the complete Order Management defaulting rules setup

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-defaulting-rules) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Application, Entity, Attribute, Condition, Enabled, Seeded, Source Type

## Oracle EBS Tables Used
[oe_def_condn_elems_v](https://www.enginatics.com/library/?pg=1&find=oe_def_condn_elems_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-defaulting-rules), [oe_def_ak_attr_ext_v](https://www.enginatics.com/library/?pg=1&find=oe_def_ak_attr_ext_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-defaulting-rules), [oe_def_ak_obj_ext_v](https://www.enginatics.com/library/?pg=1&find=oe_def_ak_obj_ext_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-defaulting-rules), [oe_def_attr_condns_v](https://www.enginatics.com/library/?pg=1&find=oe_def_attr_condns_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-defaulting-rules), [oe_def_attr_def_rules](https://www.enginatics.com/library/?pg=1&find=oe_def_attr_def_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-defaulting-rules)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-defaulting-rules)

## Related Reports
[CST COGS Revenue Matching](/CST%20COGS%20Revenue%20Matching/ "CST COGS Revenue Matching Oracle EBS SQL Report"), [ONT System Parameters](/ONT%20System%20Parameters/ "ONT System Parameters Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ONT%20Defaulting%20Rules/ONT%20Defaulting%20Rules.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-defaulting-rules) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [ONT Defaulting Rules 04-Jan-2026 193839.xlsx](https://www.enginatics.com/example/ont-defaulting-rules/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-defaulting-rules) |
| Blitz Report™ XML Import | [ONT_Defaulting_Rules.xml](https://www.enginatics.com/xml/ont-defaulting-rules/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-defaulting-rules) |
| SQL Source | [ONT Defaulting Rules.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ONT%20Defaulting%20Rules/ONT%20Defaulting%20Rules.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ont-defaulting-rules/](https://www.enginatics.com/reports/ont-defaulting-rules/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-defaulting-rules) |

## Case Study & Technical Analysis: ONT Defaulting Rules

### Executive Summary
ONT Defaulting Rules lists the complete Order Management defaulting setup: the attributes of each entity that Oracle defaults during order entry, the conditions that select a defaulting rule, and the source each rule uses to supply the value. It is aimed at Order Management functional consultants and order-to-cash analysts who need to explain why an order line received a particular value, or who are reviewing defaulting logic before a change. The report gives a single, readable view of rules that are otherwise spread across several dictionary views in the defaulting framework.

### Business Challenge
*   **Unexpected Defaults:** Users see order values such as warehouse, price list, payment term or salesperson that they did not enter, and the cause is buried in the setup.
*   **Rule Precedence:** Several conditions can apply to one attribute, and their precedence decides which rule wins.
*   **Change Control:** Before modifying defaulting, the team needs a complete inventory of seeded and custom rules.
*   **Knowledge Transfer:** Defaulting logic is hard to explain to new consultants when it is documented only in the setup screens.

### The Solution
*   **Attribute Hierarchy:** Each entity and attribute is listed in defaulting sequence, so the order of evaluation is visible.
*   **Condition Logic:** The validation rule of each condition is built from its element names, operators and values, and shown on one line.
*   **Source Resolution:** Each rule's source is shown as text, for example a constant, a profile option, an API, a system variable or a related record attribute.
*   **Audit Columns:** The creator and last updater of each condition and rule are shown with their dates.

### Technical Architecture (High Level)
#### Primary Tables
*   `OE_DEF_AK_OBJ_EXT_V`: the defaulting entities, with their application and name.
*   `OE_DEF_AK_ATTR_EXT_V`: the attributes of each entity, with their defaulting sequence and enabled flag.
*   `OE_DEF_ATTR_CONDNS_V`: the conditions that select a defaulting rule for an attribute, with their precedence and enabled flag.
*   `OE_DEF_CONDN_ELEMS_V`: the elements that make up each condition.
*   `OE_DEF_ATTR_DEF_RULES`: the defaulting rules, with their source type, sequence and source values.

#### Logical Relationships
1.  Each entity in `OE_DEF_AK_OBJ_EXT_V` is joined to its attributes in `OE_DEF_AK_ATTR_EXT_V` on the database object name, and restricted to attributes with defaulting enabled.
2.  Each attribute is outer joined to its conditions in `OE_DEF_ATTR_CONDNS_V` on database object and attribute code.
3.  Each condition is outer joined to its rules in `OE_DEF_ATTR_DEF_RULES` on the attribute condition identifier.
4.  The first element of each condition is read by a correlated subquery against `OE_DEF_CONDN_ELEMS_V` to build the validation rule text.
5.  For related record and same record sources, a correlated subquery against `OE_DEF_AK_ATTR_EXT_V` returns the name of the source attribute.

### Parameters & Filtering
*   **Application:** Restricts the entities to one application.
*   **Entity:** Restricts the output to one defaulted entity, such as order header or order line.
*   **Attribute:** Restricts the output to one attribute.
*   **Condition:** Matches the condition display name.
*   **Enabled:** Limits the rows to enabled or disabled conditions.
*   **Seeded:** Separates seeded Oracle rules from rules created by the customer.
*   **Source Type:** Restricts the rules to one source type, such as constant, profile option or API.

### Performance & Optimization
*   **Defaulting Enabled Filter:** Only attributes with defaulting enabled are read, which excludes attributes that are never defaulted.
*   **Outer Join Chain:** The attribute, condition and rule views are joined as outer joins, so attributes without conditions still appear.
*   **Correlated Lookups:** Element and related attribute names are fetched by correlated subqueries, which return one value each.
*   **Size of the Result:** The setup is finite but detailed, so the report returns one row per rule, and filters on entity and attribute keep the output usable.

### FAQ
**Q: How do I find the rule that defaults the warehouse on an order line?**
A: Set the Entity to order line and the Attribute to ship from warehouse. The rules are listed in precedence and sequence order.

**Q: Can I see whether a defaulting rule is seeded by Oracle?**
A: Yes. The Seeded column shows whether the condition is a seeded Oracle condition or a customer-defined one.

**Q: What does the Source Value column show for a profile option rule?**
A: It shows the profile option name that supplies the value. For constants it shows the constant value.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-defaulting-rules)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-defaulting-rules)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-defaulting-rules)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-defaulting-rules)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-defaulting-rules)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-defaulting-rules)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-defaulting-rules)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

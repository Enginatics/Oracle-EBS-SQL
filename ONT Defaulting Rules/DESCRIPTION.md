# Case Study & Technical Analysis: ONT Defaulting Rules

## Executive Summary
ONT Defaulting Rules lists the complete Order Management defaulting setup: the attributes of each entity that Oracle defaults during order entry, the conditions that select a defaulting rule, and the source each rule uses to supply the value. It is aimed at Order Management functional consultants and order-to-cash analysts who need to explain why an order line received a particular value, or who are reviewing defaulting logic before a change. The report gives a single, readable view of rules that are otherwise spread across several dictionary views in the defaulting framework.

## Business Challenge
*   **Unexpected Defaults:** Users see order values such as warehouse, price list, payment term or salesperson that they did not enter, and the cause is buried in the setup.
*   **Rule Precedence:** Several conditions can apply to one attribute, and their precedence decides which rule wins.
*   **Change Control:** Before modifying defaulting, the team needs a complete inventory of seeded and custom rules.
*   **Knowledge Transfer:** Defaulting logic is hard to explain to new consultants when it is documented only in the setup screens.

## The Solution
*   **Attribute Hierarchy:** Each entity and attribute is listed in defaulting sequence, so the order of evaluation is visible.
*   **Condition Logic:** The validation rule of each condition is built from its element names, operators and values, and shown on one line.
*   **Source Resolution:** Each rule's source is shown as text, for example a constant, a profile option, an API, a system variable or a related record attribute.
*   **Audit Columns:** The creator and last updater of each condition and rule are shown with their dates.

## Technical Architecture (High Level)
### Primary Tables
*   `OE_DEF_AK_OBJ_EXT_V`: the defaulting entities, with their application and name.
*   `OE_DEF_AK_ATTR_EXT_V`: the attributes of each entity, with their defaulting sequence and enabled flag.
*   `OE_DEF_ATTR_CONDNS_V`: the conditions that select a defaulting rule for an attribute, with their precedence and enabled flag.
*   `OE_DEF_CONDN_ELEMS_V`: the elements that make up each condition.
*   `OE_DEF_ATTR_DEF_RULES`: the defaulting rules, with their source type, sequence and source values.

### Logical Relationships
1.  Each entity in `OE_DEF_AK_OBJ_EXT_V` is joined to its attributes in `OE_DEF_AK_ATTR_EXT_V` on the database object name, and restricted to attributes with defaulting enabled.
2.  Each attribute is outer joined to its conditions in `OE_DEF_ATTR_CONDNS_V` on database object and attribute code.
3.  Each condition is outer joined to its rules in `OE_DEF_ATTR_DEF_RULES` on the attribute condition identifier.
4.  The first element of each condition is read by a correlated subquery against `OE_DEF_CONDN_ELEMS_V` to build the validation rule text.
5.  For related record and same record sources, a correlated subquery against `OE_DEF_AK_ATTR_EXT_V` returns the name of the source attribute.

## Parameters & Filtering
*   **Application:** Restricts the entities to one application.
*   **Entity:** Restricts the output to one defaulted entity, such as order header or order line.
*   **Attribute:** Restricts the output to one attribute.
*   **Condition:** Matches the condition display name.
*   **Enabled:** Limits the rows to enabled or disabled conditions.
*   **Seeded:** Separates seeded Oracle rules from rules created by the customer.
*   **Source Type:** Restricts the rules to one source type, such as constant, profile option or API.

## Performance & Optimization
*   **Defaulting Enabled Filter:** Only attributes with defaulting enabled are read, which excludes attributes that are never defaulted.
*   **Outer Join Chain:** The attribute, condition and rule views are joined as outer joins, so attributes without conditions still appear.
*   **Correlated Lookups:** Element and related attribute names are fetched by correlated subqueries, which return one value each.
*   **Size of the Result:** The setup is finite but detailed, so the report returns one row per rule, and filters on entity and attribute keep the output usable.

## FAQ
**Q: How do I find the rule that defaults the warehouse on an order line?**
A: Set the Entity to order line and the Attribute to ship from warehouse. The rules are listed in precedence and sequence order.

**Q: Can I see whether a defaulting rule is seeded by Oracle?**
A: Yes. The Seeded column shows whether the condition is a seeded Oracle condition or a customer-defined one.

**Q: What does the Source Value column show for a profile option rule?**
A: It shows the profile option name that supplies the value. For constants it shows the constant value.

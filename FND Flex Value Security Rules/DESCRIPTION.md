# Executive Summary
The **FND Flex Value Security Rules** report audits the security rules that restrict which segment values a user can see or enter. This is critical for enforcing data access controls (e.g., preventing a US user from booking entries to a UK company code).

# Business Challenge
*   **Security Audit:** Verifying that sensitive cost centers or companies are properly restricted.
*   **Access Troubleshooting:** Investigating why a user cannot see a specific value in a list of values (LOV).
*   **Compliance:** Documenting who has access to what for SOX audits.

# The Solution
This Blitz Report details the security configuration:
*   **Rule Definition:** The name and error message of the rule.
*   **Elements:** The specific Include/Exclude ranges defined in the rule.
*   **Assignments:** Which Responsibilities are assigned this rule.

# Technical Architecture
The report joins `FND_FLEX_VALUE_RULES`, `FND_FLEX_VALUE_RULE_LINES` (for ranges), and `FND_FLEX_VALUE_RULE_USAGES` (for responsibility assignments).

# Parameters & Filtering
*   **Responsibility Name:** Check all rules active for a specific responsibility.
*   **Flex Value Set:** Check all rules protecting a specific segment.
*   **Show Rule Elements:** Toggle to see the detailed ranges.

# Performance & Optimization
*   **Complex Security:** If you have many rules, filter by Responsibility to get a targeted view.

# FAQ
*   **Q: How do Include/Exclude rules work?**
    *   A: Security rules are restrictive. You typically "Include" a broad range and then "Exclude" specific values, or vice versa. The report shows the sequence of these elements.

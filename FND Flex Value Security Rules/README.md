---
layout: default
title: 'FND Flex Value Security Rules | Oracle EBS SQL Report'
description: 'Flexfield value security rules, rule elements (included or excluded flexfield value ranges), flexfields where the secured value set is used and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Flex, Value, Security, fnd_flex_value_sets, fnd_flex_value_rules_vl, fnd_flex_value_rule_lines'
permalink: /FND%20Flex%20Value%20Security%20Rules/
---

# FND Flex Value Security Rules – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-flex-value-security-rules/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Flexfield value security rules, rule elements (included or excluded flexfield value ranges), flexfields where the secured value set is used and responsibilities that the rule is assigned to.

## Report Parameters
Flexfield, Flexfield Code, Rule Name, Flex Value Set, Responsibility Name, Ledger, Show Rule Elements, Show Flexfields, Show Responsibilities

## Oracle EBS Tables Used
[fnd_flex_value_sets](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_sets), [fnd_flex_value_rules_vl](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_rules_vl), [fnd_flex_value_rule_lines](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_rule_lines), [fnd_flex_value_rule_usages](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_rule_usages), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl), [fnd_id_flex_segments_vl](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_segments_vl), [fnd_id_flex_structures_vl](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_structures_vl), [fnd_id_flexs](https://www.enginatics.com/library/?pg=1&find=fnd_id_flexs), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[AR Transaction Upload](/AR%20Transaction%20Upload/ "AR Transaction Upload Oracle EBS SQL Report"), [FND Flex Value Sets, Usages and Values](/FND%20Flex%20Value%20Sets-%20Usages%20and%20Values/ "FND Flex Value Sets, Usages and Values Oracle EBS SQL Report"), [PO Approval Groups](/PO%20Approval%20Groups/ "PO Approval Groups Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Flex Value Security Rules 02-Jul-2022 163119.xlsx](https://www.enginatics.com/example/fnd-flex-value-security-rules/) |
| Blitz Report™ XML Import | [FND_Flex_Value_Security_Rules.xml](https://www.enginatics.com/xml/fnd-flex-value-security-rules/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-flex-value-security-rules/](https://www.enginatics.com/reports/fnd-flex-value-security-rules/) |

## Executive Summary
The **FND Flex Value Security Rules** report audits the security rules that restrict which segment values a user can see or enter. This is critical for enforcing data access controls (e.g., preventing a US user from booking entries to a UK company code).

## Business Challenge
*   **Security Audit:** Verifying that sensitive cost centers or companies are properly restricted.
*   **Access Troubleshooting:** Investigating why a user cannot see a specific value in a list of values (LOV).
*   **Compliance:** Documenting who has access to what for SOX audits.

## The Solution
This Blitz Report details the security configuration:
*   **Rule Definition:** The name and error message of the rule.
*   **Elements:** The specific Include/Exclude ranges defined in the rule.
*   **Assignments:** Which Responsibilities are assigned this rule.

## Technical Architecture
The report joins `FND_FLEX_VALUE_RULES`, `FND_FLEX_VALUE_RULE_LINES` (for ranges), and `FND_FLEX_VALUE_RULE_USAGES` (for responsibility assignments).

## Parameters & Filtering
*   **Responsibility Name:** Check all rules active for a specific responsibility.
*   **Flex Value Set:** Check all rules protecting a specific segment.
*   **Show Rule Elements:** Toggle to see the detailed ranges.

## Performance & Optimization
*   **Complex Security:** If you have many rules, filter by Responsibility to get a targeted view.

## FAQ
*   **Q: How do Include/Exclude rules work?**
    *   A: Security rules are restrictive. You typically "Include" a broad range and then "Exclude" specific values, or vice versa. The report shows the sequence of these elements.


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics

---
layout: default
last_modified_at: 2026-10-19
title: 'FND Cross-Validation Rules | Oracle EBS SQL Report'
description: 'Cross-validation rules of key flexfield structures, one row per rule element (include or exclude range). Show Violating Combinations lists the enabled…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Cross-Validation, Rules, fnd_id_flex_segments_vl, fnd_flex_vdation_rules_vl, fnd_application_vl'
permalink: /FND%20Cross-Validation%20Rules/
report_name: 'FND Cross-Validation Rules'
report_web_name: fnd-cross-validation-rules
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Cross-Validation Rules – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-cross-validation-rules/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Cross-validation rules of key flexfield structures, one row per rule element (include or exclude range).

Show Violating Combinations lists the enabled accounting flexfield combinations that fail an enabled and currently active rule instead, one row per combination and violated element. A combination outside every include range of a rule is shown against element type Include with blank ranges, a combination inside an exclude range with that exclude range. Oracle validates a combination only when it is created, so combinations created before a rule was defined or tightened stay enabled although they violate it.

Segment values are compared with the ranges as text, which matches Oracle's validation for character value sets.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Flexfield, Ledger, Structure, Rule Name, Enabled Only, Show Violating Combinations

## Oracle EBS Tables Used
[fnd_id_flex_segments_vl](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_segments_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules), [fnd_flex_vdation_rules_vl](https://www.enginatics.com/library/?pg=1&find=fnd_flex_vdation_rules_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules), [fnd_id_flexs](https://www.enginatics.com/library/?pg=1&find=fnd_id_flexs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules), [fnd_id_flex_structures_vl](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_structures_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules), [fnd_flex_validation_rule_lines](https://www.enginatics.com/library/?pg=1&find=fnd_flex_validation_rule_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules), [fnd_flex_validation_rules](https://www.enginatics.com/library/?pg=1&find=fnd_flex_validation_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules), [fnd_flex_include_rule_lines](https://www.enginatics.com/library/?pg=1&find=fnd_flex_include_rule_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules), [fnd_flex_exclude_rule_lines](https://www.enginatics.com/library/?pg=1&find=fnd_flex_exclude_rule_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules), [fnd_id_flex_segments](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_segments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules)

## Related Reports
[FND Flex Value Security Rules](/FND%20Flex%20Value%20Security%20Rules/ "FND Flex Value Security Rules Oracle EBS SQL Report"), [AR Transaction Upload](/AR%20Transaction%20Upload/ "AR Transaction Upload Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Analysis 11g](/GL%20Account%20Analysis%2011g/ "GL Account Analysis 11g Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Cross-Validation%20Rules/FND%20Cross-Validation%20Rules.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Cross-Validation Rules 15-Oct-2026 022653.xlsx](https://www.enginatics.com/example/fnd-cross-validation-rules/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules) |
| Blitz Report™ XML Import | [FND_Cross_Validation_Rules.xml](https://www.enginatics.com/xml/fnd-cross-validation-rules/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules) |
| SQL Source | [FND Cross-Validation Rules.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Cross-Validation%20Rules/FND%20Cross-Validation%20Rules.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-cross-validation-rules/](https://www.enginatics.com/reports/fnd-cross-validation-rules/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules) |

## Case Study & Technical Analysis: FND Cross-Validation Rules

### Executive Summary
This report lists the cross-validation rules defined on key flexfield structures, one row per rule element, meaning each include or exclude range. Its second mode lists the enabled accounting flexfield combinations that break an enabled, currently active rule. General ledger administrators and security reviewers use it to audit which account combinations are permitted, and to find combinations that were created before a rule was tightened. The output runs in Excel through Blitz Report™.

### Business Challenge
*   **Account control:** Cross-validation rules restrict which combinations of segments can be used, such as which cost centers can be posted to a given natural account, and these rules must be reviewable as a whole.
*   **Rules that do not apply retrospectively:** Oracle validates a combination only when it is created, so a combination created before a rule was defined or tightened remains enabled while violating the rule.
*   **Audit evidence:** Internal audit needs a list of the rules, their ranges, their active dates and who last changed them.
*   **Multi-structure ledgers:** A ledger can use one chart of accounts structure with several rules, and each rule must be traced to its structure.

### The Solution
*   Lists each rule with its application, flexfield, structure, rule name, description, enabled status, active dates and error message.
*   Shows each element of a rule as an include or exclude range, with the low and high segment values, the element's enabled status and the rule's creator and last update.
*   In violating-combinations mode, lists each enabled account combination that fails an enabled and active rule, one row per combination and violated element.
*   Reports a combination outside every include range against the Include element type with blank ranges, and a combination inside an exclude range against that exclude range.

### Technical Architecture (High Level)
#### Primary Tables
*   `FND_FLEX_VDATION_RULES_VL`: the cross-validation rule definitions, including rule name, active dates and error message.
*   `FND_FLEX_VALIDATION_RULE_LINES`: the rule elements, one row per include or exclude range.
*   `FND_FLEX_INCLUDE_RULE_LINES` and `FND_FLEX_EXCLUDE_RULE_LINES`: the segment low and high values of each include and exclude element.
*   `FND_FLEX_VALIDATION_RULES`: the enabled rule definitions used in the violation check.
*   `GL_CODE_COMBINATIONS_KFV`: the accounting flexfield combinations tested by the violation check.
*   `FND_ID_FLEXS`, `FND_ID_FLEX_STRUCTURES_VL`, `FND_ID_FLEX_SEGMENTS` and `FND_ID_FLEX_SEGMENTS_VL`: the flexfield, structure and segment definitions.
*   `FND_APPLICATION_VL`: the application name for each rule.

#### Logical Relationships
1.  Each rule is joined to its application, flexfield, and structure, which give the names shown in the output.
2.  The rule elements are built by a union of the include lines and the exclude lines, each joined to its range values.
3.  Segment ranges are pivoted into one column pair per segment, so a combination can be compared with each segment in turn.
4.  In violation mode, enabled and currently active accounting combinations of the GL flexfield are paired with every enabled rule of the same structure.
5.  A combination is kept as a violation when it falls outside every include range of a rule, or inside an exclude range.
6.  The output is joined back to the rule definitions and ordered by application, flexfield, structure, rule and account.

### Parameters & Filtering
*   **Flexfield** and **Structure:** restrict the rules to one key flexfield and one structure.
*   **Ledger:** restricts the output to the chart of accounts of one ledger.
*   **Rule Name:** selects one cross-validation rule.
*   **Enabled Only:** limits the output to enabled rules and elements.
*   **Show Violating Combinations:** switches the report from the rule definitions to the account combinations that violate an enabled, active rule.

### Performance & Optimization
*   The violation mode is the expensive path, because every enabled, active, non-summary account combination is compared with every enabled rule of the structure, so the Ledger and Structure parameters are the main levers.
*   The segment comparisons are evaluated only on rules that have elements, and an include match is computed once per combination and rule through an analytic maximum.
*   Active date windows are applied to rules and combinations before the comparison, which keeps retired rules and inactive accounts out of the join.
*   The definition mode reads only rule metadata and does not touch account combinations, so it runs quickly for a whole flexfield.

### FAQ
**Q: Why does an existing account combination violate a rule?**
A: Oracle validates a combination only when it is created, so a combination created before the rule was defined or tightened stays enabled even though it violates the rule.

**Q: How is a combination outside all include ranges reported?**
A: It is reported against element type Include with blank segment ranges, because it matches none of the include ranges of the rule.

**Q: How are segment values compared with the ranges?**
A: The values are compared as text, which matches Oracle's validation for character value sets.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-cross-validation-rules)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

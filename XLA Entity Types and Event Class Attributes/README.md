---
layout: default
last_modified_at: 2026-10-16
title: 'XLA Entity Types and Event Class Attributes | Oracle EBS SQL Report'
description: 'Subledger event types and their attributes, for example reporting view – Oracle EBS Subledger Accounting SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Subledger Accounting, Enginatics, R12 only, XLA, Entity, Types, Event, fnd_application_vl, xla_entity_types_vl, xla_event_class_attrs'
permalink: /XLA%20Entity%20Types%20and%20Event%20Class%20Attributes/
report_name: 'XLA Entity Types and Event Class Attributes'
report_web_name: xla-entity-types-and-event-class-attributes
module: 'Subledger Accounting'
module_url: /modules/subledger-accounting/
---

# XLA Entity Types and Event Class Attributes – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/xla-entity-types-and-event-class-attributes/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-entity-types-and-event-class-attributes) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-entity-types-and-event-class-attributes).
**Oracle EBS module:** [Subledger Accounting](/modules/subledger-accounting/ "Oracle EBS Subledger Accounting reports") · [all Subledger Accounting reports](/modules/subledger-accounting/)  

## Overview
Subledger event types and their attributes, for example reporting view

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-entity-types-and-event-class-attributes) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-entity-types-and-event-class-attributes), [xla_entity_types_vl](https://www.enginatics.com/library/?pg=1&find=xla_entity_types_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-entity-types-and-event-class-attributes), [xla_event_class_attrs](https://www.enginatics.com/library/?pg=1&find=xla_event_class_attrs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-entity-types-and-event-class-attributes)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-entity-types-and-event-class-attributes), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-entity-types-and-event-class-attributes)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/XLA%20Entity%20Types%20and%20Event%20Class%20Attributes/XLA%20Entity%20Types%20and%20Event%20Class%20Attributes.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-entity-types-and-event-class-attributes) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [XLA Entity Types and Event Class Attributes 18-Feb-2026 025927.xlsx](https://www.enginatics.com/example/xla-entity-types-and-event-class-attributes/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-entity-types-and-event-class-attributes) |
| Blitz Report™ XML Import | [XLA_Entity_Types_and_Event_Class_Attributes.xml](https://www.enginatics.com/xml/xla-entity-types-and-event-class-attributes/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-entity-types-and-event-class-attributes) |
| SQL Source | [XLA Entity Types and Event Class Attributes.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/XLA%20Entity%20Types%20and%20Event%20Class%20Attributes/XLA%20Entity%20Types%20and%20Event%20Class%20Attributes.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/xla-entity-types-and-event-class-attributes/](https://www.enginatics.com/reports/xla-entity-types-and-event-class-attributes/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-entity-types-and-event-class-attributes) |

## Case Study & Technical Analysis: XLA Entity Types and Event Class Attributes

### Executive Summary
This report lists the Subledger Accounting (SLA) entity types of each Oracle E-Business Suite application, together with the event classes defined under each entity and the attributes of those event classes. It shows, for each event class, its journal category, its reporting view name, and whether it allows actuals, budgets or encumbrance accounting. Finance systems analysts, accounting configuration specialists and EBS consultants use it to document the subledger events that generate journal entries, to confirm which event classes allow budgetary and encumbrance accounting, and to find the reporting view that a subledger event class uses. It is a configuration reference, so it runs with no parameters and returns the full list for the database.

### Business Challenge
*   **Understanding subledger accounting events:** Each subledger application creates accounting through entity types and event classes, and the mapping must be understood before accounting rules are designed.
*   **Journal categories:** Each event class posts to a journal category, and finance teams need to know which category a subledger transaction uses.
*   **Budgetary and encumbrance control:** Only some event classes allow actuals, budgets or encumbrance accounting, and that restriction must be known before configuring the ledger.
*   **Reporting on subledger data:** Reporting developers need the reporting view of each event class to build queries on subledger data.

### The Solution
*   Lists each application by its short name and its name, so every entity type is tied to the product that owns it.
*   Shows each entity type's name, description and entity code.
*   Shows, for each event class under the entity, the journal category name, the event class code and the reporting view name.
*   Shows the allow flags for actuals, budgets and encumbrance, displayed as Yes or No.
*   Orders the output by application name, entity code and event class code, so the event classes of each entity are grouped together.

### Technical Architecture (High Level)
#### Primary Tables
*   `FND_APPLICATION_VL`: the application short name and name.
*   `XLA_ENTITY_TYPES_VL`: the entity types of each application, with name, description and entity code.
*   `XLA_EVENT_CLASS_ATTRS`: the event class attributes of each entity, with journal category, event class code, reporting view and the allow flags.

#### Logical Relationships
1. `FND_APPLICATION_VL` is joined to `XLA_ENTITY_TYPES_VL` on the application identifier, so each entity type carries its product.
2. `XLA_ENTITY_TYPES_VL` is outer joined to `XLA_EVENT_CLASS_ATTRS` on both the entity code and the application identifier.
3. Entity types with no event class are still listed, with the event class columns blank.
4. The result is ordered by application name, entity code and event class code.

### Parameters & Filtering
This report has no parameters. Every application, entity type and event class attribute in the database is returned, so filters are applied after the download, for example in Excel.

### Performance & Optimization
*   The report reads three configuration views with two joins, so the number of rows is the number of event classes in the database, which is small.
*   The entity-to-event-class join uses both the entity code and the application identifier, so it does not match entities of other products that share a code.
*   The outer join keeps entity types without event classes in the output, which shows the complete entity list.
*   Because the output is a reference list, it can be downloaded once and filtered locally without repeated database runs.

### FAQ
**Q: Which event classes allow encumbrance accounting?**
A: Filter the Allow Encumbrance column to Yes. The rows show the application, entity type and event class of each one.

**Q: How do I find the journal category of a subledger event class?**
A: Read the JE Category Name column for the event class. It is the journal category used when the event class posts accounting.

**Q: What is the reporting view for an event class?**
A: The Reporting View Name column gives the view that holds the accounting data of that event class, when one is defined.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-entity-types-and-event-class-attributes)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-entity-types-and-event-class-attributes)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-entity-types-and-event-class-attributes)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-entity-types-and-event-class-attributes)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-entity-types-and-event-class-attributes)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-entity-types-and-event-class-attributes)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-entity-types-and-event-class-attributes)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

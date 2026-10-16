---
layout: default
last_modified_at: 2026-10-16
title: 'WF Service Components | Oracle EBS SQL Report'
description: 'Workflow service components, such as the notification mailer, agent listeners and web services agents, with their status, startup mode and the concurrent…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Workflow, Enginatics, Service, Components, fnd_svc_components, fnd_svc_comp_types_tl, fnd_concurrent_queues_vl'
permalink: /WF%20Service%20Components/
report_name: 'WF Service Components'
report_web_name: wf-service-components
module: 'Workflow'
module_url: /modules/workflow/
---

# WF Service Components – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/wf-service-components/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-service-components) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-service-components).
**Oracle EBS module:** [Workflow](/modules/workflow/ "Oracle EBS Workflow reports") · [all Workflow reports](/modules/workflow/)  

## Overview
Workflow service components, such as the notification mailer, agent listeners and web services agents, with their status, startup mode and the concurrent manager container running them.

Show Parameters lists the component's configuration parameters, for example the mailer's SMTP and IMAP servers, reply-to and test address. Encrypted values such as passwords are masked.

Schedule the report with Not Running only to get an email when the notification mailer or an agent listener stops.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-service-components) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Component Type, Status, Not Running only, Show Parameters

## Oracle EBS Tables Used
[fnd_svc_components](https://www.enginatics.com/library/?pg=1&find=fnd_svc_components&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-service-components), [fnd_svc_comp_types_tl](https://www.enginatics.com/library/?pg=1&find=fnd_svc_comp_types_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-service-components), [fnd_concurrent_queues_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_queues_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-service-components)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-service-components)

## Related Reports
[CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs by Where Used](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/ "CAC Calculate ICP PII Item Costs by Where Used Oracle EBS SQL Report"), [CAC Item vs. Component Include in Rollup Controls](/CAC%20Item%20vs-%20Component%20Include%20in%20Rollup%20Controls/ "CAC Item vs. Component Include in Rollup Controls Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [EAM PM Schedule Upload](/EAM%20PM%20Schedule%20Upload/ "EAM PM Schedule Upload Oracle EBS SQL Report"), [CST Supply Chain Indented Bills of Material Cost](/CST%20Supply%20Chain%20Indented%20Bills%20of%20Material%20Cost/ "CST Supply Chain Indented Bills of Material Cost Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WF%20Service%20Components/WF%20Service%20Components.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-service-components) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [WF Service Components 12-Oct-2026 061644.xlsx](https://www.enginatics.com/example/wf-service-components/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-service-components) |
| Blitz Report™ XML Import | [WF_Service_Components.xml](https://www.enginatics.com/xml/wf-service-components/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-service-components) |
| SQL Source | [WF Service Components.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WF%20Service%20Components/WF%20Service%20Components.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/wf-service-components/](https://www.enginatics.com/reports/wf-service-components/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-service-components) |

## Case Study & Technical Analysis: WF Service Components

### Executive Summary
The WF Service Components report lists the Oracle Workflow service components, such as the notification mailer, the inbound and outbound agent listeners and the web services agents. For each component it shows its status, startup mode, the concurrent manager container that runs it and, optionally, its configuration parameters. It is written for Oracle EBS technical administrators who depend on workflow notifications and integrations, and who must know when the mailer or an agent has stopped. The Show Parameters option lists the mailer's configuration, for example its SMTP and IMAP servers, reply-to address and test address, with encrypted values such as passwords masked. The report sits in the Workflow module.

### Business Challenge
*   **Notifications not delivered:** Approval notifications and workflow alerts stop reaching users when the notification mailer is down, and the problem may go unnoticed until users complain.
*   **Agent listener failures:** Inbound and outbound agent listeners carry business events and integrations, and a stopped listener silently halts processing.
*   **Configuration drift:** Mailer settings such as the SMTP server, reply-to address and test address must be checked after a migration or a change in mail infrastructure.
*   **Container location:** Each component runs in a concurrent manager container, so the team must know which container to restart when a component fails.

### The Solution
*   **Component status:** Each component's status is shown in readable form, with its status information, so a stopped or failed component is identified.
*   **Startup and container:** The startup mode and the concurrent manager container, with its running process count, show how the component is started and where it runs.
*   **Agent and correlation detail:** The inbound and outbound agent names, correlation identifier and maximum idle time are shown for each component.
*   **Configuration on demand:** The Show Parameters option adds the component's parameters as columns, with encrypted values masked.
*   **Alerting by schedule:** Setting Not Running only means that a scheduled run of the report produces output only when a component is not running, so it can be used to send an email alert.

### Technical Architecture (High Level)
#### Primary Tables
*   `FND_SVC_COMPONENTS`: the service components, with their name, type, status, startup mode, agents and container.
*   `FND_SVC_COMP_TYPES_TL`: the translated display names of the component types.
*   `FND_CONCURRENT_QUEUES_VL`: the concurrent manager containers, with their user name and running process count.

The Show Parameters option adds a parameter table and its columns to the query at run time. The library text refers to that parameter table through a substitution, so its name is not fixed in the SQL shown.

#### Logical Relationships
1. `FND_SVC_COMPONENTS` joins to `FND_SVC_COMP_TYPES_TL` on the component type, as an outer join, filtered to the session language.
2. `FND_SVC_COMPONENTS` joins to `FND_CONCURRENT_QUEUES_VL` on the concurrent queue identifier, as an outer join.
3. When parameters are shown, the parameter table is joined to the component records and its values are added as columns.
4. The result is ordered by component type and component name.

### Parameters & Filtering
*   **Component Type:** Restricts the output to one type of service component, such as the notification mailer or an agent listener.
*   **Status:** Filters the components by their current status.
*   **Not Running only:** Restricts the output to components that are not running, which supports alerting.
*   **Show Parameters:** Adds the configuration parameters of each component as columns, with encrypted values masked.

### Performance & Optimization
*   **Small component register:** The component table holds a short list of services, so the base query is inexpensive.
*   **Language-filtered type names:** The component type names are joined on the session language only, which avoids duplicate translated rows.
*   **Optional parameter join:** Parameters are added only when requested, so the default run does not read the parameter table.
*   **Status filter for alerts:** The Not Running filter reduces the output to the components that need attention, which keeps scheduled alert emails short.

### FAQ
**Q: How do I check whether the Oracle Workflow notification mailer is running?**
A: Run WF Service Components and read the status column for the notification mailer component type. Set Not Running only to Yes to list only components that have stopped.

**Q: How can I see the SMTP server the notification mailer uses?**
A: Set Show Parameters to Yes. The mailer's SMTP and IMAP server settings appear as columns, and encrypted values such as passwords are masked.

**Q: Which concurrent manager runs a service component?**
A: The container column shows the concurrent manager queue that runs the component, and the container processes column shows its running process count.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-service-components)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-service-components)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-service-components)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-service-components)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-service-components)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-service-components)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-service-components)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

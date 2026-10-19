---
layout: default
last_modified_at: 2026-10-19
title: 'WF Queue Backlog | Oracle EBS SQL Report'
description: 'Number of messages per Workflow Business Event System queue table, correlation id and state, with the age of the oldest message. A large number of Ready…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Workflow, Enginatics, Queue, Backlog, wf_deferred, wf_deferred_table_m, wf_error'
permalink: /WF%20Queue%20Backlog/
report_name: 'WF Queue Backlog'
report_web_name: wf-queue-backlog
module: 'Workflow'
module_url: /modules/workflow/
---

# WF Queue Backlog – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/wf-queue-backlog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog).
**Oracle EBS module:** [Workflow](/modules/workflow/ "Oracle EBS Workflow reports") · [all Workflow reports](/modules/workflow/)  

## Overview
Number of messages per Workflow Business Event System queue table, correlation id and state, with the age of the oldest message.

A large number of Ready messages with an old Oldest Message shows that the agent listener, notification mailer or Workflow Background Process serving the queue is down or cannot keep up. The correlation id contains the business event or notification message name, and for WF_DEFERRED_TABLE_M the item type processed by the Workflow Background Process.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Exclude Processed, Message Count From, Oldest Message Hours From, Queue Table

## Oracle EBS Tables Used
[wf_deferred](https://www.enginatics.com/library/?pg=1&find=wf_deferred&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog), [wf_deferred_table_m](https://www.enginatics.com/library/?pg=1&find=wf_deferred_table_m&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog), [wf_error](https://www.enginatics.com/library/?pg=1&find=wf_error&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog), [wf_java_deferred](https://www.enginatics.com/library/?pg=1&find=wf_java_deferred&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog), [wf_java_error](https://www.enginatics.com/library/?pg=1&find=wf_java_error&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog), [wf_notification_out](https://www.enginatics.com/library/?pg=1&find=wf_notification_out&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog), [wf_notification_in](https://www.enginatics.com/library/?pg=1&find=wf_notification_in&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog), [wf_inbound_table](https://www.enginatics.com/library/?pg=1&find=wf_inbound_table&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog), [wf_outbound_table](https://www.enginatics.com/library/?pg=1&find=wf_outbound_table&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog)

## Related Reports
[OKL Termination Quotes](/OKL%20Termination%20Quotes/ "OKL Termination Quotes Oracle EBS SQL Report"), [WF Notifications](/WF%20Notifications/ "WF Notifications Oracle EBS SQL Report"), [ONT Transaction Types and Line WF Processes](/ONT%20Transaction%20Types%20and%20Line%20WF%20Processes/ "ONT Transaction Types and Line WF Processes Oracle EBS SQL Report"), [WF Business Events and Subscriptions](/WF%20Business%20Events%20and%20Subscriptions/ "WF Business Events and Subscriptions Oracle EBS SQL Report"), [FND User Roles](/FND%20User%20Roles/ "FND User Roles Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WF%20Queue%20Backlog/WF%20Queue%20Backlog.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [WF Queue Backlog 12-Oct-2026 061643.xlsx](https://www.enginatics.com/example/wf-queue-backlog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog) |
| Blitz Report™ XML Import | [WF_Queue_Backlog.xml](https://www.enginatics.com/xml/wf-queue-backlog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog) |
| SQL Source | [WF Queue Backlog.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WF%20Queue%20Backlog/WF%20Queue%20Backlog.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/wf-queue-backlog/](https://www.enginatics.com/reports/wf-queue-backlog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog) |

## Case Study & Technical Analysis: WF Queue Backlog

### Executive Summary
WF Queue Backlog counts the messages held in each Oracle Workflow Business Event System queue table, grouped by correlation identifier and message state, and shows the age of the oldest message in each group. It is designed for EBS system administrators and middleware support teams who must confirm that business events, notifications and deferred background work are being processed. A growing backlog of ready messages is the first visible sign that a listener, the notification mailer or the Workflow Background Process has stopped or fallen behind.

### Business Challenge
*   **Stalled Processing:** When the agent listener or the mailer stops, approvals and notifications stop being delivered, and users only notice after the business is affected.
*   **Hidden Queue Growth:** Workflow queues grow quietly, and no single screen shows the message count across all queue tables.
*   **Prioritizing Investigation:** The team needs to know which event or item type is responsible for the backlog before it can act.
*   **Error Queues:** Messages in the error queues need to be counted separately from healthy traffic.

### The Solution
*   **Consolidated Count:** Nine Workflow queue tables are read in one statement, so the backlog is visible in one place.
*   **Correlation Breakdown:** The correlation identifier shows which business event or notification message name, or which item type for the deferred table, owns the messages.
*   **State Decoding:** The numeric state of each message is translated to Ready, Waiting, Processed or Expired.
*   **Age Measurement:** The oldest and newest enqueue times and the age of the oldest message in seconds are shown, so a backlog can be judged by its age.

### Technical Architecture (High Level)
#### Primary Tables
*   `WF_DEFERRED`: the deferred agent messages for the Workflow Background Process.
*   `WF_DEFERRED_TABLE_M`: the multi-consumer deferred queue table.
*   `WF_ERROR`: messages in the error agent queue.
*   `WF_JAVA_DEFERRED`: deferred messages for the Java agent.
*   `WF_JAVA_ERROR`: error messages for the Java agent.
*   `WF_NOTIFICATION_OUT`: outbound notification messages for the notification mailer.
*   `WF_NOTIFICATION_IN`: inbound notification messages.
*   `WF_INBOUND_TABLE`: the inbound business event queue.
*   `WF_OUTBOUND_TABLE`: the outbound business event queue.

#### Logical Relationships
1.  Each queue table is summarized in its own inline branch, grouped by correlation identifier and state.
2.  Each branch returns the queue name, the count of messages, and the minimum and maximum enqueue time.
3.  The nine branches are combined with UNION ALL into one inline result.
4.  The outer query converts the state code to its name and the enqueue times to client time, and computes the age of the oldest message from the current system date.
5.  Rows are ordered by message count in descending order.

### Parameters & Filtering
*   **Exclude Processed:** Removes the processed messages from the count, so only work that is still open is shown.
*   **Message Count From:** Returns only groups with at least this many messages.
*   **Oldest Message Hours From:** Returns only groups whose oldest message is at least this many hours old.
*   **Queue Table:** Restricts the output to one of the Workflow queue tables.

### Performance & Optimization
*   **Full Scans Of Queue Tables:** Each branch aggregates its queue table, so the cost grows with the number of messages in the queues, and running it during a heavy processing window adds load.
*   **Grouping Before Ordering:** Counts are produced in the inline branches and only the grouped rows are sorted, which keeps the outer sort small.
*   **Single Statement:** All queues are read in one query, so the team gets a consistent snapshot without running nine separate checks.
*   **Filter Placement:** The count and age filters are applied to the aggregated rows, not to the raw messages.

### FAQ
**Q: What does a high count of Ready messages with an old Oldest Message mean?**
A: It shows that the agent listener, the notification mailer or the Workflow Background Process serving that queue is down or cannot keep up with the load.

**Q: What does the correlation identifier contain?**
A: It contains the business event or notification message name. For WF_DEFERRED_TABLE_M it is the item type processed by the Workflow Background Process.

**Q: How do I see only the backlog that is old?**
A: Set Oldest Message Hours From to the number of hours you consider acceptable, and only groups whose oldest message is older than that are returned.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wf-queue-backlog)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH

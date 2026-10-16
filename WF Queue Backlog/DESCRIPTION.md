# Case Study & Technical Analysis: WF Queue Backlog

## Executive Summary
WF Queue Backlog counts the messages held in each Oracle Workflow Business Event System queue table, grouped by correlation identifier and message state, and shows the age of the oldest message in each group. It is designed for EBS system administrators and middleware support teams who must confirm that business events, notifications and deferred background work are being processed. A growing backlog of ready messages is the first visible sign that a listener, the notification mailer or the Workflow Background Process has stopped or fallen behind.

## Business Challenge
*   **Stalled Processing:** When the agent listener or the mailer stops, approvals and notifications stop being delivered, and users only notice after the business is affected.
*   **Hidden Queue Growth:** Workflow queues grow quietly, and no single screen shows the message count across all queue tables.
*   **Prioritizing Investigation:** The team needs to know which event or item type is responsible for the backlog before it can act.
*   **Error Queues:** Messages in the error queues need to be counted separately from healthy traffic.

## The Solution
*   **Consolidated Count:** Nine Workflow queue tables are read in one statement, so the backlog is visible in one place.
*   **Correlation Breakdown:** The correlation identifier shows which business event or notification message name, or which item type for the deferred table, owns the messages.
*   **State Decoding:** The numeric state of each message is translated to Ready, Waiting, Processed or Expired.
*   **Age Measurement:** The oldest and newest enqueue times and the age of the oldest message in seconds are shown, so a backlog can be judged by its age.

## Technical Architecture (High Level)
### Primary Tables
*   `WF_DEFERRED`: the deferred agent messages for the Workflow Background Process.
*   `WF_DEFERRED_TABLE_M`: the multi-consumer deferred queue table.
*   `WF_ERROR`: messages in the error agent queue.
*   `WF_JAVA_DEFERRED`: deferred messages for the Java agent.
*   `WF_JAVA_ERROR`: error messages for the Java agent.
*   `WF_NOTIFICATION_OUT`: outbound notification messages for the notification mailer.
*   `WF_NOTIFICATION_IN`: inbound notification messages.
*   `WF_INBOUND_TABLE`: the inbound business event queue.
*   `WF_OUTBOUND_TABLE`: the outbound business event queue.

### Logical Relationships
1.  Each queue table is summarized in its own inline branch, grouped by correlation identifier and state.
2.  Each branch returns the queue name, the count of messages, and the minimum and maximum enqueue time.
3.  The nine branches are combined with UNION ALL into one inline result.
4.  The outer query converts the state code to its name and the enqueue times to client time, and computes the age of the oldest message from the current system date.
5.  Rows are ordered by message count in descending order.

## Parameters & Filtering
*   **Exclude Processed:** Removes the processed messages from the count, so only work that is still open is shown.
*   **Message Count From:** Returns only groups with at least this many messages.
*   **Oldest Message Hours From:** Returns only groups whose oldest message is at least this many hours old.
*   **Queue Table:** Restricts the output to one of the Workflow queue tables.

## Performance & Optimization
*   **Full Scans Of Queue Tables:** Each branch aggregates its queue table, so the cost grows with the number of messages in the queues, and running it during a heavy processing window adds load.
*   **Grouping Before Ordering:** Counts are produced in the inline branches and only the grouped rows are sorted, which keeps the outer sort small.
*   **Single Statement:** All queues are read in one query, so the team gets a consistent snapshot without running nine separate checks.
*   **Filter Placement:** The count and age filters are applied to the aggregated rows, not to the raw messages.

## FAQ
**Q: What does a high count of Ready messages with an old Oldest Message mean?**
A: It shows that the agent listener, the notification mailer or the Workflow Background Process serving that queue is down or cannot keep up with the load.

**Q: What does the correlation identifier contain?**
A: It contains the business event or notification message name. For WF_DEFERRED_TABLE_M it is the item type processed by the Workflow Background Process.

**Q: How do I see only the backlog that is old?**
A: Set Oldest Message Hours From to the number of hours you consider acceptable, and only groups whose oldest message is older than that are returned.

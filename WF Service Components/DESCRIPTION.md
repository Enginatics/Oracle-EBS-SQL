# Case Study & Technical Analysis: WF Service Components

## Executive Summary
The WF Service Components report lists the Oracle Workflow service components, such as the notification mailer, the inbound and outbound agent listeners and the web services agents. For each component it shows its status, startup mode, the concurrent manager container that runs it and, optionally, its configuration parameters. It is written for Oracle EBS technical administrators who depend on workflow notifications and integrations, and who must know when the mailer or an agent has stopped. The Show Parameters option lists the mailer's configuration, for example its SMTP and IMAP servers, reply-to address and test address, with encrypted values such as passwords masked. The report sits in the Workflow module.

## Business Challenge
*   **Notifications not delivered:** Approval notifications and workflow alerts stop reaching users when the notification mailer is down, and the problem may go unnoticed until users complain.
*   **Agent listener failures:** Inbound and outbound agent listeners carry business events and integrations, and a stopped listener silently halts processing.
*   **Configuration drift:** Mailer settings such as the SMTP server, reply-to address and test address must be checked after a migration or a change in mail infrastructure.
*   **Container location:** Each component runs in a concurrent manager container, so the team must know which container to restart when a component fails.

## The Solution
*   **Component status:** Each component's status is shown in readable form, with its status information, so a stopped or failed component is identified.
*   **Startup and container:** The startup mode and the concurrent manager container, with its running process count, show how the component is started and where it runs.
*   **Agent and correlation detail:** The inbound and outbound agent names, correlation identifier and maximum idle time are shown for each component.
*   **Configuration on demand:** The Show Parameters option adds the component's parameters as columns, with encrypted values masked.
*   **Alerting by schedule:** Setting Not Running only means that a scheduled run of the report produces output only when a component is not running, so it can be used to send an email alert.

## Technical Architecture (High Level)
### Primary Tables
*   `FND_SVC_COMPONENTS`: the service components, with their name, type, status, startup mode, agents and container.
*   `FND_SVC_COMP_TYPES_TL`: the translated display names of the component types.
*   `FND_CONCURRENT_QUEUES_VL`: the concurrent manager containers, with their user name and running process count.

The Show Parameters option adds a parameter table and its columns to the query at run time. The library text refers to that parameter table through a substitution, so its name is not fixed in the SQL shown.

### Logical Relationships
1. `FND_SVC_COMPONENTS` joins to `FND_SVC_COMP_TYPES_TL` on the component type, as an outer join, filtered to the session language.
2. `FND_SVC_COMPONENTS` joins to `FND_CONCURRENT_QUEUES_VL` on the concurrent queue identifier, as an outer join.
3. When parameters are shown, the parameter table is joined to the component records and its values are added as columns.
4. The result is ordered by component type and component name.

## Parameters & Filtering
*   **Component Type:** Restricts the output to one type of service component, such as the notification mailer or an agent listener.
*   **Status:** Filters the components by their current status.
*   **Not Running only:** Restricts the output to components that are not running, which supports alerting.
*   **Show Parameters:** Adds the configuration parameters of each component as columns, with encrypted values masked.

## Performance & Optimization
*   **Small component register:** The component table holds a short list of services, so the base query is inexpensive.
*   **Language-filtered type names:** The component type names are joined on the session language only, which avoids duplicate translated rows.
*   **Optional parameter join:** Parameters are added only when requested, so the default run does not read the parameter table.
*   **Status filter for alerts:** The Not Running filter reduces the output to the components that need attention, which keeps scheduled alert emails short.

## FAQ
**Q: How do I check whether the Oracle Workflow notification mailer is running?**
A: Run WF Service Components and read the status column for the notification mailer component type. Set Not Running only to Yes to list only components that have stopped.

**Q: How can I see the SMTP server the notification mailer uses?**
A: Set Show Parameters to Yes. The mailer's SMTP and IMAP server settings appear as columns, and encrypted values such as passwords are masked.

**Q: Which concurrent manager runs a service component?**
A: The container column shows the concurrent manager queue that runs the component, and the container processes column shows its running process count.

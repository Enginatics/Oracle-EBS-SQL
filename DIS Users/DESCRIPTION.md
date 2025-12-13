# Case Study & Technical Analysis

## Abstract
The **DIS Users** report provides a comprehensive directory of all entities granted access to the Discoverer End User Layer (EUL). Unlike standard database user lists, this report distinguishes between Oracle Applications users (`FND_USER`), Responsibilities, and raw Database Schemas, all of which can be granted EUL privileges.

## Technical Analysis

### Core Components
*   **User Type**: Identifies if the grantee is a User, Responsibility, or Group.
*   **EUL Access**: Confirms that the user has the `EUL5_ACCESS_USER` role (or equivalent) allowing them to connect to Discoverer.
*   **Activity**: Correlates the user definition with `EUL5_QPP_STATS` to show the last time they actually ran a report.

### Key Tables
*   `EUL5_EUL_USERS`: The EUL's internal user registry.
*   `EUL5_QPP_STATS`: Usage history.

### Operational Use Cases
*   **License Compliance**: Identifying how many unique users have active Discoverer privileges.
*   **Security Cleanup**: Revoking access for users who haven't logged in for 180 days.
*   **Migration Planning**: Generating a mailing list of active Discoverer users to communicate the migration schedule.

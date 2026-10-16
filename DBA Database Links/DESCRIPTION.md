# Case Study & Technical Analysis: DBA Database Links

## Executive Summary
This report lists the database links defined in the Oracle database that runs Oracle E-Business Suite. For each link it shows the owner schema, the link name, the remote user the link connects as, the connect string, and the date the link was created. It is written for DBAs and technical administrators who must inventory the connections that leave the EBS database, check which accounts hold credentials to other systems, and confirm that the links an integration relies on still exist after a clone, upgrade or security review. Because the output is a plain list, it is easy to compare between environments and to share with security auditors.

## Business Challenge
*   **Unknown outbound connections:** Database links allow one database to query or change objects in another, and an inventory is needed to know which systems the EBS database can reach.
*   **Credentials stored in the database:** Each link holds a remote user name and a connect string, so the accounts that use them must be known and reviewed.
*   **Environment cloning:** After a clone or refresh, links can point at the wrong remote systems, and the list has to be checked against the target environment.
*   **Audit and compliance:** Security reviews ask for a current list of all database connections, with the owner and creation date of each.

## The Solution
*   Reads every database link visible in the data dictionary view `DBA_DB_LINKS`, so all owners are included, not only the current user.
*   Shows the owner, the link name, the remote user, the host string and the created date in one row per link.
*   Sorts the output by owner and then by link name, so links of the same schema are grouped together.
*   Accepts an Owner parameter, so a DBA can focus on the links of one schema, for example an integration account.

## Technical Architecture (High Level)
### Primary Tables
*   `DBA_DB_LINKS`: the data dictionary view of database links, with the owner, the link name, the remote user, the host and the creation date.

### Logical Relationships
1. The report reads `DBA_DB_LINKS` alone, with no joins.
2. The Owner parameter filters the owner column of that view.
3. The result is ordered by owner and then by the link name.

The report is deliberately simple: there is no join to the Oracle EBS application tables, so the output reflects the database dictionary and not the application setup that uses the links.

## Parameters & Filtering
*   **Owner:** restricts the list to the database links owned by one schema. Leave it blank to see every link in the database.

## Performance & Optimization
*   The query has one source view and no joins, so its cost is that of reading the dictionary view for the links in the database.
*   The filter on the owner column reduces the rows returned when a single schema is needed.
*   The sort on owner and link name is applied on a short result set, so it adds little cost even for databases with many links.
*   Because the output does not include connect passwords, it can be shared with reviewers, but the host string and remote user still identify the target systems and should be treated as sensitive.

## FAQ
**Q: How do I list all database links in the EBS database?**
A: Run the report with the Owner parameter blank. Each link is listed with its owner, name, remote user, host and created date.

**Q: How do I find the database links of one schema?**
A: Enter the schema name in the Owner parameter. Only the links owned by that schema are returned.

**Q: Does this report show the passwords of database links?**
A: No. The report shows the remote user and the host, and it does not include any password.

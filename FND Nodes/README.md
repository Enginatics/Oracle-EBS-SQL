---
layout: default
title: 'FND Nodes | Oracle EBS SQL Report'
description: 'FNDNODES stores information about the nodes that are used to install and run Oracle Application at your site. Each row includes the name of the node and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Nodes, fnd_nodes'
permalink: /FND%20Nodes/
---

# FND Nodes – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-nodes/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
FND_NODES stores information about the nodes that are used to
install and run Oracle Application at your site. Each row includes
the name of the node and the platform code. The column name
NODE_NAME is the given name used to refer to the machine or node
at the site. The column PLATFORM_CODE specifies the make of the
machine or node (e.g. DEC VMS, Sequent Ptx, etc.). This
information is used to associate a concurrent manager with a
specific node to support distributed processing.


## Report Parameters


## Oracle EBS Tables Used
[fnd_nodes](https://www.enginatics.com/library/?pg=1&find=fnd_nodes)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report"), [FND User Login History](/FND%20User%20Login%20History/ "FND User Login History Oracle EBS SQL Report"), [FND Profile Option Values](/FND%20Profile%20Option%20Values/ "FND Profile Option Values Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Nodes 25-Aug-2024 000300.xlsx](https://www.enginatics.com/example/fnd-nodes/) |
| Blitz Report™ XML Import | [FND_Nodes.xml](https://www.enginatics.com/xml/fnd-nodes/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-nodes/](https://www.enginatics.com/reports/fnd-nodes/) |

## Executive Summary
The **FND Nodes** report lists the application tier nodes (servers) registered in the Oracle EBS topology. It is a technical infrastructure report.

## Business Challenge
*   **Infrastructure Audit:** Verifying the list of active servers in a multi-node cluster.
*   **Concurrent Processing:** Checking which nodes are configured to run concurrent managers.
*   **Cleanup:** Identifying old or decommissioned nodes that need to be purged from `FND_NODES`.

## The Solution
This Blitz Report queries `FND_NODES`:
*   **Node Name:** The hostname of the server.
*   **Platform:** The operating system (e.g., Linux, Solaris).
*   **Status:** Whether the node is active.
*   **Services:** Which services (Web, Admin, Concurrent) are running on the node.

## Technical Architecture
The report queries `FND_NODES`.

## Parameters & Filtering
*   **None:** Typically lists all nodes.

## Performance & Optimization
*   **Small Data:** Most systems have fewer than 20 nodes.

## FAQ
*   **Q: Why do I see old servers here?**
    *   A: If a server is decommissioned without running the `FND_CONC_CLONE.SETUP_CLEAN` routine, it may remain in this table.


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

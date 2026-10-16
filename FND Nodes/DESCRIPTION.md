# Executive Summary
The **FND Nodes** report lists the application tier nodes (servers) registered in the Oracle EBS topology. It is a technical infrastructure report.

# Business Challenge
*   **Infrastructure Audit:** Verifying the list of active servers in a multi-node cluster.
*   **Concurrent Processing:** Checking which nodes are configured to run concurrent managers.
*   **Cleanup:** Identifying old or decommissioned nodes that need to be purged from `FND_NODES`.

# The Solution
This Blitz Report queries `FND_NODES`:
*   **Node Name:** The hostname of the server.
*   **Platform:** The operating system (e.g., Linux, Solaris).
*   **Status:** Whether the node is active.
*   **Services:** Which services (Web, Admin, Concurrent) are running on the node.

# Technical Architecture
The report queries `FND_NODES`.

# Parameters & Filtering
*   **None:** Typically lists all nodes.

# Performance & Optimization
*   **Small Data:** Most systems have fewer than 20 nodes.

# FAQ
*   **Q: Why do I see old servers here?**
    *   A: If a server is decommissioned without running the `FND_CONC_CLONE.SETUP_CLEAN` routine, it may remain in this table.

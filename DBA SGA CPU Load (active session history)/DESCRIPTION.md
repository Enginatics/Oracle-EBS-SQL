# Case Study & Technical Analysis

## Abstract
The **DBA SGA CPU Load (active session history)** report is a specialized view of ASH data designed to visualize CPU consumption over time. By aggregating the count of active sessions that are `ON CPU` per sample time, it reconstructs a load profile that can be compared against the server's physical CPU core count. This helps identify specific intervals where the database was CPU-bound.

## Technical Analysis

### Core Logic
*   **Filter**: Selects records from `GV$ACTIVE_SESSION_HISTORY` where `SESSION_STATE = 'ON CPU'`.
*   **Aggregation**: Counts distinct session IDs per `SAMPLE_TIME`.
*   **Threshold**: The `CPU Sessions From` parameter allows filtering for spikes where the load exceeded a certain number of concurrent active sessions (e.g., greater than the number of CPU cores).

### Interpretation
*   **Load < Cores**: The system is generally healthy; CPU is not the bottleneck.
*   **Load > Cores**: The system is CPU-bound. Sessions are runnable but waiting for CPU time (run queue). Latency increases.

### Key View
*   `GV$ACTIVE_SESSION_HISTORY`: The source of the CPU usage samples.

### Operational Use Cases
*   **Capacity Planning**: Determining if the server needs more CPUs to handle peak loads.
*   **Spike Analysis**: Correlating a CPU spike at 10:00 AM with a specific SQL_ID or Module.
*   **Resource Manager**: Validating if Resource Manager plans are effectively throttling CPU-hungry consumer groups.

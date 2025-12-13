# ECC Admin - Concurrent Programs

## Description
This report lists all concurrent programs required to synchronize Oracle E-Business Suite data with the Enterprise Command Centers (ECC) WebLogic server. It is based on Oracle Note 2495053.1 and is essential for administering ECC data loads.

The report helps administrators:
- **Identify Programs**: List all data load programs for various ECC datasets.
- **Check Schedules**: View currently scheduled request IDs and responsibilities for incremental and full loads.
- **Manage Access**: Use the program short codes to cross-reference with other reports (like `FND Access Control`) to determine who can schedule these loads.

ECC data loads are critical for keeping the command center dashboards up-to-date. This report simplifies the management of these background processes.

## Parameters
None.

## Used Tables
- `fnd_concurrent_requests`: Concurrent request history and status.
- `fnd_responsibility_vl`: Responsibility definitions.
- `dual`: System table.
- `fnd_concurrent_programs_vl`: Concurrent program definitions.
- `fnd_executables_vl`: Executable definitions.

## Categories
- **Enginatics**: System administration for Enterprise Command Centers.

## Related Reports
- [FND Concurrent Requests 11i](/FND%20Concurrent%20Requests%2011i/)
- [ECC Data Sets](/ECC%20Data%20Sets/)

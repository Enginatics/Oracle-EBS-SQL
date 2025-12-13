# ECC Admin - Data Sets

## Description
This report lists the data sets defined within the Enterprise Command Center (ECC) applications. It provides technical details about the load rules and database procedures responsible for data synchronization.

Key information includes:
- **Dataset Definitions**: Names and codes of datasets associated with each ECC application.
- **Load Procedures**: The specific PL/SQL procedures used for incremental, full, and metadata loads.
- **Source Systems**: Identification of the source system for the data.

This report is essential for developers and administrators who need to understand the backend configuration of ECC data flows.

## Parameters
- **Application**: Filter by ECC application.
- **Data Set**: Filter by specific dataset.

## Used Tables
- `ecc_app_ds_relationships`: Relationships between applications and datasets.
- `ecc_application_tl`: Application names.
- `ecc_source_system`: Source system definitions.
- `ecc_dataset_b`: Dataset base table.
- `ecc_dataset_tl`: Dataset translations.
- `ecc_dataset_load_rules`: Load rules configuration.
- `ecc_security_rules`: Security rules applied to datasets.

## Categories
- **Enginatics**: ECC configuration and development.

## Related Reports
- [ECC Admin - Metadata Attributes](/ECC%20Admin%20-%20Metadata%20Attributes/)

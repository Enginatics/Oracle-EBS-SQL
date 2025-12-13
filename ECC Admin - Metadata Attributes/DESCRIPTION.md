# ECC Admin - Metadata Attributes

## Description
This report provides a detailed view of the metadata attributes defined for Enterprise Command Center (ECC) datasets. It maps the attributes to their respective applications and datasets, offering insight into the data model exposed to the ECC dashboards.

This information is valuable for:
- **Customization**: Understanding available attributes for dashboard customization.
- **Troubleshooting**: Verifying that the correct attributes are being loaded and exposed.
- **Documentation**: Documenting the data elements available in the command center.

## Parameters
- **Application**: Filter by ECC application.
- **Data Set**: Filter by dataset.
- **Attribute Key**: Filter by specific attribute key.

## Used Tables
- `ecc_app_ds_relationships`: Application-dataset links.
- `ecc_application_tl`: Application names.
- `ecc_dataset_b`: Dataset definitions.
- `ecc_dataset_tl`: Dataset names.
- `ecc_dataset_attrs_b`: Attribute base definitions.
- `ecc_dataset_attrs_tl`: Attribute translations.

## Categories
- **Enginatics**: ECC metadata analysis.

## Related Reports
- [ECC Admin - Data Sets](/ECC%20Admin%20-%20Data%20Sets/)

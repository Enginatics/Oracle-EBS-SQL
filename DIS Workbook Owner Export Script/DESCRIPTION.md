# DIS Workbook Owner Export Script

## Description
This script is a utility designed to facilitate the support and migration process from Oracle Discoverer to Blitz Report. It generates a list of workbook owners, which is required to remotely export workbook XML definitions.

When migrating complex Discoverer environments, it is often necessary to export workbook definitions for analysis or conversion. This script provides the necessary user information to target specific owners' workbooks for export, streamlining the migration workflow and ensuring that support teams have the correct context for troubleshooting or conversion tasks.

## Parameters
- **End User Layer**: The Discoverer End User Layer to query for workbook owners.

## Used Tables
- `fnd_user`: Oracle EBS application users table.

## Categories
- **Enginatics**: Utility script for Enginatics' migration and support services.

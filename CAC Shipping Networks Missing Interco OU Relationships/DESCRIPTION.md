# Case Study & Technical Analysis: CAC Shipping Networks Missing Interco OU Relationships

## Executive Summary
The **CAC Shipping Networks Missing Interco OU Relationships** report is a specific configuration validator. In Oracle EBS, defining a "Shipping Network" (physical path) between two organizations is not enough for financial transactions. You must also define the "Intercompany Relations" (financial path) between their respective Operating Units. This report finds the gaps.

## Business Challenge
*   **Transaction Failures**: You can ship the goods (physical), but the financial transaction will fail or get stuck in the interface because the system doesn't know which AR/AP accounts to use.
*   **New Org Setup**: When rolling out a new warehouse, it's easy to forget the inter-company setup, especially if the warehouse belongs to an existing Operating Unit.

## Solution
This report compares two setups.
*   **Source 1**: `mtl_interorg_parameters` (The Shipping Network).
*   **Source 2**: `mtl_intercompany_parameters` (The Financial Relationship).
*   **Logic**: If a Shipping Network exists between Org A (OU 1) and Org B (OU 2), but no Intercompany Relationship exists between OU 1 and OU 2, it flags the error.

## Technical Architecture
*   **Tables**: `mtl_interorg_parameters`, `mtl_intercompany_parameters`, `hr_organization_information`.
*   **Logic**: Uses a `MINUS` or `NOT EXISTS` logic to find the missing links.

## Parameters
*   None. It scans the entire system.

## Performance
*   **Fast**: Configuration tables are small.

## FAQ
**Q: Do I need this for Intracompany (same OU) transfers?**
A: No, transfers within the same Operating Unit do not require Intercompany Relations. This report filters for cross-OU networks.

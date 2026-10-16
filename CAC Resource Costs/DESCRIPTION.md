# Case Study & Technical Analysis: CAC Resource Costs

## Executive Summary
The **CAC Resource Costs** report is a master data management tool for Manufacturing Costing. It lists the setup of all Resources (Labor, Machine, Outside Processing) and their associated Standard Rates. This is the foundation of the "Value Added" portion of a product's standard cost.

## Business Challenge
*   **Cost Accuracy**: If the "Assembly Labor" rate is outdated ($20/hr vs. actual $25/hr), every product made will be under-costed.
*   **Consistency**: Ensuring that similar resources (e.g., "Forklift Driver") have consistent rates across different inventory organizations.
*   **Audit**: Verifying that all active resources have a non-zero cost.

## Solution
This report dumps the resource definition.
*   **Details**: Resource Name, Unit of Measure (HR, EA, DOL), Activity (Run, Setup).
*   **Rates**: The standard rate per unit.
*   **Type**: Cost Element (Labor, Outside Processing, Overhead).

## Technical Architecture
*   **Tables**: `bom_resources`, `cst_resource_costs`, `cst_cost_types`.
*   **Logic**: Joins the resource definition to its cost record for the specified Cost Type.

## Parameters
*   **Cost Type**: (Mandatory) Usually "Frozen" or "AverageRates".
*   **Include Non-Costed Resources**: (Mandatory) Toggle to show scheduling-only resources.

## Performance
*   **Fast**: Master data tables are small.

## FAQ
**Q: What is "Outside Processing" (OSP)?**
A: A resource representing a service performed by a vendor (e.g., Plating). The "Rate" is the standard price we pay the vendor.

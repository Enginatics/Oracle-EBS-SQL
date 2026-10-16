# BOM Common Bill of Materials Upload

## Description
The upload can be used to create Common BOM from the BOMS defined in the specified source organization in one or more target organizations as determined by the Scope Parameter:

All - All Organizations 
BOMs will made Common to all other Organizations that share the same Master Organization as the Source Organization and to which the current responsibility has access to.
 
Hierarchy – Organization Hierarchy
BOMs will made Common to all Organizations the current responsibility has access to and which are below the Source Organization in the specified Hierarchy.

Organization – Specific Organizations
BOMs will be made Common to the specified Target Organizations. The Target Organizations must share the same Master Organization as the Source Organization.

Unlike the Oracle standard Create Common BOM process which requires all sub-component BOMS and substitute component BOMs to be made common individually, this upload process will iterate through the sub-assemblies and substitute assemblies and make them common in the Target Organization if they have not already been defined.

A prerequisite however, as with the BOM Bill of Materials Upload (Amazon), is that all the items are already assigned in the Target Organization.

If any component Items are not defined in the Target Organization, these will be identified in the upload Excel.

Usage
=====
- Specify the Source Organization in which the BOMS are defined
- Specify the Scope to determine the Target Organizations
- Use the Report Parameters to select the BOMS to be made common
- The generated Excel will contain one row per BOM and Target Organization combination

- The generated Excel Identifies if the BOM Item is defined in the Target Organization, if it already exists as a BOM in the Target Organization, if it is a Common BOM in the target organization already, and if the BOM has any component items which are not defined in the Target Organization. These will prevent the BOM upload process from attempting to make the BOM common in the target organization.

- In the generated Excel, set the ‘Create Common Bom’ column to Yes against the BOM/Target Organization combinations to be made Common.
- Save and upload the Excel to process the selections made back into Oracle
- After upload, a new Excel is generated showing the success/error status of the creation of the Common BOMS in each target organization.

Templates
=========
Common BOM Upload Template
In this template, the user must review and manually select the BOM/Target Organization combinations to be made Common. Setting the ‘Create Common Bom’ flag against a BOM/Target Organization combination will trigger the row for update and processing during upload.

Automatic Common BOM Upload Template
In this template, the excel is generated with the ‘Create Common Bom’ flag set against all BOM/Target Organization combinations and the rows already flagged for update and processing. In this template the user can opt out of creating a common BOM for specific BOM/Target Organization combinations by either de-selecting (clearing) the ‘Create Common Bom’ flag column or by deleting the row from the spreadsheet. 

## Parameters
Source Organization Code, Common BOM Scope, Target Hierarchy, Target Organization, Enable Attributes Update, Assembly, Alternate BOM, Show Sub-Assemblies, Show Missing BOMS only, Auto Populate Upload Columns, Implemented Only, Display, Effective Date

## Used tables
bom_bill_of_materials, bom_inventory_components, mtl_parameters, mtl_system_items_kfv, mtl_system_items_vl, bom_tree, bom_substitute_components, bom, org_access_view, bom_subst

## Categories
Enginatics, Upload

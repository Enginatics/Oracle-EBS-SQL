# Executive Summary
The **CSI Installed Base Extended Attributes Summary** report is a master data management tool for the Oracle Installed Base. It lists the "Extended Attributes" (user-defined fields) that have been configured to track additional technical or business data for item instances. This report helps administrators understand the data model extensions that have been applied to the standard Installed Base functionality.

# Business Challenge
Standard fields (Item, Serial Number, Owner) are often insufficient for complex products. Companies use Extended Attributes to track specific data like "Software Version," "Calibration Date," or "IP Address."
*   **Configuration Visibility**: As these attributes are custom-defined, it can be hard to get a clear list of what attributes exist and where they are used.
*   **Data Governance**: Ensuring that attributes are named consistently and applied to the correct item categories.
*   **Reporting**: Knowing the attribute names is a prerequisite for building custom reports that query this data.

# Solution
This report provides a dictionary of the defined Extended Attributes.

**Key Features:**
*   **Attribute Definition**: Lists the Attribute Name, Level, and other definition details.
*   **Value Analysis**: Can potentially show the distribution of values (depending on the specific query implementation) or just the structure.

# Architecture
The report queries `CSI_I_EXTENDED_ATTRIBS` and `CSI_IEA_VALUES`.

**Key Tables:**
*   `CSI_I_EXTENDED_ATTRIBS`: Defines the attribute structure (metadata).
*   `CSI_IEA_VALUES`: Stores the actual values assigned to specific instances.

# Impact
*   **System Documentation**: Acts as a data dictionary for the custom attributes in the Installed Base.
*   **Report Development**: Assists developers in finding the correct column/attribute names when building custom queries.
*   **Standardization**: Helps enforce naming conventions for new attributes.

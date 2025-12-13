# Case Study & Technical Analysis

## Abstract
The **DIS Folders, Business Areas, Items and LOVs** report is a comprehensive reverse-engineering tool for Oracle Discoverer. It extracts the detailed definition of every folder (which maps to a table or view) and every item (column or calculation) within the EUL. This level of detail is indispensable when migrating complex Discoverer logic to SQL, Blitz Report, or BI Publisher.

## Technical Analysis

### Core Components
*   **Folder Definition**: Shows the underlying database object (Table/View) or the Custom SQL used to define the folder.
*   **Item Definition**: Shows the formula for calculated items (e.g., `SUM(Sales) * 1.1`) and the mapping to database columns.
*   **Lists of Values (LOVs)**: Identifies which items have attached LOVs, which is critical for recreating parameter logic.

### Key Tables
*   `EUL5_OBJS`: Stores folder definitions.
*   `EUL5_EXPRESSIONS`: Stores item formulas and calculations.
*   `EUL5_DOMAINS`: Stores LOV definitions.

### Operational Use Cases
*   **Migration**: "I need to recreate the 'Monthly Sales' workbook in SQL. What is the exact formula for the 'Gross Margin' item?"
*   **Dependency Analysis**: "Which folders are based on the view `PO_HEADERS_V`?"
*   **Optimization**: Identifying folders based on inefficient Custom SQL that should be converted to database views.

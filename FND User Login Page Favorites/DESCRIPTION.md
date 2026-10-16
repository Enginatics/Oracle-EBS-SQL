# Executive Summary
The **FND User Login Page Favorites** report lists the "Favorites" (or "Top Ten") links that users have configured on their Oracle EBS home page. This provides insight into which functions are most frequently used or deemed most important by the user base.

# Business Challenge
During system upgrades, UI redesigns, or role changes, it is helpful to know what shortcuts users rely on. Losing these personalizations can cause user frustration. Additionally, administrators may want to analyze usage patterns to see which functions are actually being prioritized by users.

# The Solution
This report extracts the user-defined favorites from the `icx_custom_menu_entries` table. It allows administrators to:
- Backup user favorites before a system refresh.
- Analyze common favorites to improve global menu design.
- Troubleshoot issues where a user claims a favorite link is broken.

# Technical Architecture
The report queries `icx_custom_menu_entries` and joins to `fnd_form_functions_vl` and `fnd_responsibility_vl` to provide the human-readable names of the functions and responsibilities associated with the favorites.

# Parameters & Filtering
- **User Name:** Filter for a specific user to see their favorites.

# Performance & Optimization
This report is lightweight and runs quickly.

# FAQ
**Q: Can I use this to copy favorites from one user to another?**
A: This report *reads* the data. To copy favorites, you would need a separate script or API to insert records into the `icx_custom_menu_entries` table based on this output.

**Q: Does this include the "Navigator" menu?**
A: No, this is specifically for the "Favorites" list usually displayed on the right side or center of the EBS Home Page.

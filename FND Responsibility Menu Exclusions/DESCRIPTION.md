# Executive Summary
The **FND Responsibility Menu Exclusions** report documents the specific functions and menus that have been explicitly excluded from responsibilities. This is a critical component of security auditing, ensuring that broad responsibilities are properly restricted according to the principle of least privilege.

# Business Challenge
Organizations often create generic responsibilities (e.g., "Super User") and then restrict them for specific roles by excluding sensitive functions or menus. However, these exclusions are often hidden in sub-tabs of the responsibility definition form. Without a clear report, it is easy to overlook missing exclusions or fail to document how a responsibility differs from its base menu definition, leading to potential security gaps.

# The Solution
This report provides a clear list of all menu and function exclusions defined at the responsibility level. It helps security teams:
- Verify that intended restrictions are actually in place.
- Document the differences between similar responsibilities.
- Troubleshoot why a user cannot access a function they expect to see (if it was inadvertently excluded).

# Technical Architecture
The report queries the `fnd_resp_functions` table, which stores the exclusion rules, and joins it with `fnd_responsibility_vl`, `fnd_form_functions_vl`, and `fnd_menus_vl` to provide human-readable names for the excluded items.

# Parameters & Filtering
- **Responsibility Name:** Filter for a specific responsibility to see its exclusions.
- **Excluded Function/Menu Name:** Search for a specific function to see which responsibilities have excluded it.

# Performance & Optimization
This report queries a specific set of configuration tables and is generally very fast and lightweight.

# FAQ
**Q: What is the difference between a menu exclusion and a function exclusion?**
A: A menu exclusion hides an entire submenu and all its contents. A function exclusion hides a specific action or screen, regardless of where it appears in the menu structure.

**Q: Does this report show the final resulting menu?**
A: No, it only lists the *exclusions*. To see the full resulting access, use the **FND Responsibility Access** report.

# FND User Login History - Case Study

## Executive Summary
The **FND User Login History** report is an essential security and auditing tool for Oracle E-Business Suite. It provides a detailed historical record of user access to the system, including login times, logout times, and the specific responsibilities accessed. This report is vital for IT security teams, auditors, and system administrators to ensure compliance with regulatory standards (such as SOX or GDPR), monitor user adoption, and investigate potential security breaches.

## Business Challenge
Tracking "who did what and when" is a fundamental requirement for enterprise systems. However, Oracle EBS login data is often scattered across multiple tables depending on the access method (Forms vs. Self-Service Web Applications).
*   **Compliance Gaps:** Auditors require proof of access controls and review of user activity.
*   **Security Monitoring:** Detecting unauthorized access attempts or unusual login patterns (e.g., logins during non-business hours) is difficult without consolidated data.
*   **License Management:** Organizations need to know which users are active to optimize license usage.

## Solution
The **FND User Login History** report bridges the gap between Forms-based and Web-based login auditing. It consolidates data from the underlying FND (Foundation) and ICX (Inter-Cartridge Exchange) tables to provide a unified view of user sessions.

**Key Features:**
*   **Unified Audit Trail:** Combines data for both Forms (Java Applet) and OAF (HTML) sessions.
*   **Detailed Metrics:** Includes User Name, Responsibility, Login Time, Logout Time, and IP Address (if captured).
*   **Flexible Filtering:** Allows searching by User, Date Range, Responsibility, or specific time windows.
*   **Session Context:** Can identify if a session was terminated normally or timed out.

## Technical Architecture
The report's logic handles the complexity of Oracle's dual-layer architecture (Forms vs. Web).

**Primary Tables:**
*   `fnd_logins`: Stores information about Forms-based logins. Populated based on the "Sign-On:Audit Level" profile option.
*   `icx_sessions`: Stores information about web-based sessions (OAF, HTML).
*   `fnd_user`: Master table for user definitions.
*   `fnd_responsibility_vl`: Master table for responsibility definitions.
*   `fnd_login_responsibilities`: Links logins to the specific responsibilities accessed during that session.

**Key Logic:**
*   **Audit Levels:** The report output depends heavily on the `Sign-On:Audit Level` profile option.
    *   *NONE:* No auditing.
    *   *USER:* Tracks logins only.
    *   *RESPONSIBILITY:* Tracks logins and responsibility selection.
    *   *FORM:* Tracks logins, responsibilities, and forms opened.
*   **Join Logic:** The query attempts to correlate `icx_sessions` with `fnd_logins` to present a complete picture of the user's journey from the web login page to the Forms interface.

## Frequently Asked Questions

**Q: Why are some logout times missing?**
A: If a user closes their browser without clicking "Logout," or if the session crashes, the logout time may not be recorded properly. The system eventually marks these as timed out, but the timestamp might be null or delayed.

**Q: Does this report show which specific records a user modified?**
A: No. This report tracks *access* (logins and responsibilities). To track record-level changes (inserts, updates), you need to use **FND Audit Trail** or **Database Auditing** features.

**Q: Why do I see records for the 'GUEST' user?**
A: The 'GUEST' user is used internally by Oracle EBS for anonymous access (like the initial login page). The report typically filters these out or identifies them separately, but they are a normal part of `icx_sessions`.

**Q: How far back does the history go?**
A: It depends on your system's purge policies. The "Purge Signon Audit Data" concurrent program is usually scheduled to remove old records to save space. The report can only show data that hasn't been purged.

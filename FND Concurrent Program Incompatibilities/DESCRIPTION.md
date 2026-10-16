# Executive Summary
The **FND Concurrent Program Incompatibilities** report documents the exclusion rules defined between concurrent programs. It ensures that conflicting jobs (e.g., two programs updating the same table) do not run simultaneously.

# Business Challenge
*   **Data Integrity:** Preventing race conditions where two programs try to modify the same data at the same time.
*   **Performance Protection:** Ensuring that resource-intensive programs do not run in parallel.
*   **Setup Validation:** Verifying that necessary incompatibilities are correctly defined after a new module implementation.

# The Solution
This Blitz Report lists all defined incompatibilities:
*   **Conflict Mapping:** Shows Program A and Program B, and the scope of the incompatibility (Global or Domain).
*   **Scope Clarity:** Identifies if the incompatibility applies to the entire system or just within the same argument set.
*   **Bi-Directional Check:** Helps verify that the rule is effective in both directions if required.

# Technical Architecture
The report queries `FND_CONCURRENT_PROGRAM_SERIAL`, which stores the incompatibility rules. It joins `FND_CONCURRENT_PROGRAMS` twice (once for the running program, once for the incompatible program) to resolve names.

# Parameters & Filtering
*   **Program Name:** Search for a specific program to see what it is incompatible with.
*   **Application:** Filter by module.

# Performance & Optimization
*   **Static Data:** This is a configuration report and runs instantly.

# FAQ
*   **Q: What is a "Global" incompatibility?**
    *   A: It means the two programs can never run at the same time, regardless of who runs them or with what parameters.
*   **Q: Can I set incompatibilities here?**
    *   A: No, this is a reporting tool. Incompatibilities are defined in the "Concurrent Programs" setup form.

# AD Applied Patches R12.2 Report

## Executive Summary
The AD Applied Patches R12.2 report is a targeted tool for verifying the application of specific patches in an Oracle E-Business Suite R12.2 environment. This report is crucial for system administrators and DBAs who need to quickly confirm the patch status of their systems, particularly in the context of the dual filesystem architecture (fs1 and fs2) and online patching (adop).

## Business Challenge
In an R12.2 environment, the complexity of patch management is increased by the online patching mechanism and the need to maintain two synchronized filesystems. This creates several challenges:
- **Patch Verification:** It can be difficult to quickly and accurately determine if a specific patch has been applied to both the run and patch editions of the filesystem.
- **Audit and Compliance:** Auditors often require definitive proof that specific security or functional patches have been applied.
- **Troubleshooting:** When system issues arise, it's essential to be able to quickly rule out or confirm the absence of required patches.
- **Upgrade and Maintenance Planning:** Before undertaking major upgrades or maintenance activities, it's critical to have an accurate inventory of applied patches.

## The Solution
The AD Applied Patches R12.2 report provides a simple and effective solution to these challenges. By providing a specific patch number, administrators can instantly verify its application status. The report helps to:
- **Confirm Patch Application:** Quickly determine if a patch has been successfully applied to the R12.2 instance.
- **Streamline Audits:** Provide auditors with the precise information they need to verify patch compliance.
- **Accelerate Troubleshooting:** Quickly confirm the presence or absence of a patch that may be related to a system issue.
- **Improve Maintenance Planning:** Ensure that you have an accurate understanding of your system's patch level before starting any major maintenance activities.

## Technical Architecture (High Level)
This report is designed to be lightweight and efficient. It primarily relies on the **dual** table to execute a query that checks for the presence of the specified patch in the R12.2 environment. The underlying logic leverages the `ad_patch.is_patch_applied` function to provide a definitive answer.

## Parameters & Filtering
The report is designed for simplicity and requires only a few key parameters:
- **EBS release version:** The specific version of Oracle E-Business Suite being checked.
- **Appl top id:** The ID of the application top.
- **Patch number:** The number of the patch to be verified.
- **Patch language:** The language of the patch.

These parameters allow for a highly targeted query that returns a clear and unambiguous result.

## Performance & Optimization
The report is designed for maximum performance. By querying the `dual` table and using a built-in function, the report avoids complex joins and lengthy table scans, ensuring a near-instantaneous response.

## FAQ
**Q: Why is this report specific to R12.2?**
A: The R12.2 architecture, with its dual filesystem and online patching, requires a different approach to patch verification than previous versions of Oracle E-Business Suite. This report is specifically designed to work with the R12.2 patching mechanism.

**Q: Can I use this report to check for multiple patches at once?**
A: This report is designed to check for a single patch at a time. To check for multiple patches, you would need to run the report for each patch number.

**Q: What is the significance of the "Appl top id" parameter?**
A: The "Appl top id" parameter is used to specify the application top that the patch was applied to. This is important in environments where multiple application tops are in use.
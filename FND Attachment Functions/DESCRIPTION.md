# Executive Summary
The **FND Attachment Functions** report documents the configuration of the attachment feature within EBS forms. It details which attachment categories are available in which forms and at what block level.

# Business Challenge
*   **Customization Management:** Tracking where custom attachment categories have been enabled.
*   **Troubleshooting:** Understanding why a user cannot see the "Paperclip" icon or a specific document category in a form.
*   **Security:** Verifying that sensitive document categories are only exposed in appropriate functions.

# The Solution
This Blitz Report provides a technical map of attachment setups:
*   **Function Mapping:** Shows the relationship between the Form Function and the Attachment Function.
*   **Block Level Detail:** Specifies which block in the form (e.g., `ORDER_HEADERS`) triggers the attachment capability.
*   **Category Usage:** Lists which document categories (e.g., "Misc", "Internal") are assigned to the function.

# Technical Architecture
The report queries `FND_ATTACHMENT_FUNCTIONS`, `FND_ATTACHMENT_BLOCKS`, and `FND_DOC_CATEGORY_USAGES`. It joins with `FND_FORM_FUNCTIONS` to provide the user-friendly function names.

# Parameters & Filtering
*   **Function/Form Name:** To check setup for a specific screen.
*   **Level:** Filter by Site, Application, or Responsibility level assignments.

# Performance & Optimization
*   **Low Impact:** This is a configuration report against small metadata tables; performance is generally instant.

# FAQ
*   **Q: How do I enable attachments on a new form?**
    *   A: You must define the Attachment Function and Block in the "Attachment Functions" setup form. This report validates that setup.
*   **Q: What is the "Primary Key" setup?**
    *   A: The report shows which fields (e.g., `HEADER_ID`) are used as the primary key to link the attachment to the record.

# Polo Count Script: Final Implementation

## Overview

This script marks the final step in the Polo Count process. In the next phase, the data generated here will be pushed to another table and integrated with Microsoft Teams for streamlined collaboration.

### Key Features
- **Stock Math Logic**: The calculation assumes a total of six Polo shirts on hand. If the count is less than six, the script calculates the difference and includes it in the report.
- **Detailed Report**: The script generates a professional inventory report, summarizing stock levels, order recommendations, and color-specific details.

![Script Demo](https://github.com/user-attachments/assets/6a4ab4cc-5356-49ea-bb5e-868f8d725d73)

---

## Script: Polo Inventory Report

```typescript
function main(workbook: ExcelScript.Workbook) {
    // Define the active worksheet and data structure
    const sheet = workbook.getActiveWorksheet();

    // Mapping of shirt sizes to their respective columns
    const sizeColumns = {
        Small: "C",
        Medium: "E",
        Large: "G",
        "1XL": "I",
        "2X": "K", // 2X and 3X are valued higher
        "3X": "M",
    };

    // Fetch color names from column A, skipping the header row
    const colorRange = sheet.getRange("A2:A6"); // Start from row 2 to exclude the header
    const colorNames = colorRange.getValues().map(row => row[0] as string); // Extract color names as strings

    // Initialize the report header
    let reportContent = "INVENTORY REPORT\n\n";
    reportContent += "This report summarizes the inventory status for all sizes and colors.\n";
    reportContent += "----------------------------------------------\n\n";

    // Loop through each size and generate the report content
    for (const [size, column] of Object.entries(sizeColumns)) {
        // Read the count entered by the specialist, skipping the header row
        const countRange = sheet.getRange(`${column}2:${column}6`); // Start from row 2
        const counts = countRange.getValues();

        // Add size header to the report
        reportContent += `Size: ${size}\n`;
        reportContent += "-----------------\n";

        // Loop through rows to add on-hand counts, order amounts, and color names
        counts.forEach((row, index) => {
            let onhand = row[0] as number; // Cast to number for arithmetic operations
            const color = colorNames[index]; // Get the corresponding color name

            // Ensure the on-hand count does not exceed 6
            if (onhand > 6) {
                onhand = 6; // Cap the count at 6
            }

            // Calculate the order amount if on-hand count is less than 4
            let orderAmount = 0;
            if (onhand < 4) {
                orderAmount = 6 - onhand; // Calculate the difference (6 - current on-hand)
            }

            // Add the color, on-hand, and order amount info to the report
            reportContent += `Row ${index + 2}: Color = ${color}, On-hand count = ${onhand}, Order-More count = ${orderAmount}\n`;
        });

        reportContent += "\n"; // Add a blank line after each size
    }

    // Add a footer to the report
    reportContent += "-----------------------------------------------\n";
    reportContent += "End of Report\n";

    // Output the report content to the console
    console.log(reportContent);

    // Optional: Notify the user that the report is ready
    //workbook.getApplication().showNotification("Polo inventory report generated. Copy it from the console.");
}

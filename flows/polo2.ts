function main(workbook: ExcelScript.Workbook) {
    // Define the active worksheet and data structure
    const sheet = workbook.getActiveWorksheet();

    // Mapping of shirt sizes to their respective columns
    const sizeColumns = {
        Small: "C",
        Medium: "E",
        Large: "G",
        "1XL": "I",
        "2X": "K",
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

    // Get the "Report" sheet and the existing table in the sheet
    let reportSheet = workbook.getWorksheet("Report");
    if (!reportSheet) {
        reportSheet = workbook.addWorksheet("Report");
    }

    const reportTable = reportSheet.getTables()[0]; // Get the first table in the "Report" sheet
    if (!reportTable) {
        throw new Error("No table found in the 'Report' sheet.");
    }

    // Get the first row of the table to set the header if needed
    const tableHeader = reportTable.getRange().getCell(0, 0); // A1, which should be the header
    tableHeader.setValue("Inventory Report");

    // Set the report content in the second row (A2 in the table)
    const reportRow = reportTable.getRange().getCell(1, 0); // A2, where the report content should go
    reportRow.setValue(reportContent);

    // Optional: Set the text to wrap in the table
    reportTable.getRange().getFormat().setWrapText(true);

    // Optional: Notify the user
    //workbook.getApplication().showNotification("Report saved to the 'Report' sheet.");
}


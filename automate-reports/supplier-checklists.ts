function main(workbook: ExcelScript.Workbook) {
    // Define the active worksheet
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
    const colorNames = colorRange.getValues().map(row => row[0] as string); // Extract color names

    // Initialize the report header
    let reportContent = "T-SHIRT PRINTING CHECKLIST\n\n";
    reportContent += "This report serves as a printing checklist for Redacted.\n";
    reportContent += "----------------------------------------------\n\n";

    // Loop through each size and generate the order list
    for (const [size, column] of Object.entries(sizeColumns)) {
        // Read the count entered by the specialist, skipping the header row
        const countRange = sheet.getRange(`${column}2:${column}6`); // Start from row 2
        const counts = countRange.getValues();

        // Add size header to the report
        reportContent += `Size: ${size}\n`;
        reportContent += "-----------------\n";

        // Loop through rows to add order quantities (but hide on-hand counts)
        counts.forEach((row, index) => {
            let onhand = row[0] as number; // Extract on-hand count
            const color = colorNames[index]; // Get the corresponding color name

            let orderAmount = 0;
            if (onhand < 4) {
                orderAmount = 6 - onhand; // Calculate the order quantity
            }

            if (orderAmount > 0) {
                // Add an underscore for M&H Awards to check off each item
                reportContent += `Row ${index + 2}: Color = ${color}, Order Amount = _______________\n`;
            }
        });

        reportContent += "\n"; // Add a blank line after each size
    }

    // Add the footer with signature line and date
    const currentDate = new Date().toISOString().split("T")[0]; // YYYY-MM-DD format
    reportContent += "-----------------------------------------------\n";
    reportContent += `Date: ${currentDate}\n`;
    reportContent += "Authorized Signature: ________________________________\n";

    // Output the report content to the console for review
    console.log(reportContent);

    // Notify the user
    //workbook.getApplication().showNotification("Supplier report for M&H Awards generated.");

    // Save report to a new worksheet
    const reportSheet = workbook.addWorksheet(`Supplier Report ${currentDate}`);
    const reportLines = reportContent.split("\n").map(line => [line]); // Convert text to rows
    reportSheet.getRange(`A1:A${reportLines.length}`).setValues(reportLines);
    reportSheet.getRange("A:A").getFormat().autofitColumns();
}

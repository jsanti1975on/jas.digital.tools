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

    let hasOrders = false; // Track if there are any orders

    // Loop through each size and generate the order list
    for (const [size, column] of Object.entries(sizeColumns)) {
        // Read the count entered by the specialist, skipping the header row
        const countRange = sheet.getRange(`${column}2:${column}6`); // Start from row 2
        const counts = countRange.getValues();

        let sizeContent = `Size: ${size}\n-----------------\n`;
        let hasSizeOrders = false;

        // Loop through rows to add order quantities (but hide on-hand counts)
        counts.forEach((row, index) => {
            let onhand = row[0] as number; // Extract on-hand count
            const color = colorNames[index]; // Get the corresponding color name

            let orderAmount = 0;
            if (onhand < 4) {
                orderAmount = Math.min(4 - onhand, 4); // Ensures a max order of 4 polos per size
            }

            if (orderAmount > 0) {
                hasOrders = true;
                hasSizeOrders = true;
                // Add the order with a check-off box
                sizeContent += `Row ${index + 2}: Color = ${color}, Order Amount = ${orderAmount}, Check Off _____\n`;
            }
        });

        if (hasSizeOrders) {
            reportContent += sizeContent + "\n"; // Only add sizes that have orders
        }
    }

    if (!hasOrders) {
        reportContent += "No orders are required at this time.\n\n";
    }

    // Add the footer with signature line and date
    const currentDate = new Date().toISOString().split("T")[0]; // YYYY-MM-DD format
    reportContent += "-----------------------------------------------\n";
    reportContent += `Date: ${currentDate}\n`;
    reportContent += "Authorized Signature: ________________________________\n";

    // Output the report content to the console for review
    console.log(reportContent);

    // Notify the user
    // workbook.getApplication().showNotification("Supplier report for `redacted` generated.");

    // Save report to a new worksheet
    // const reportSheet = workbook.addWorksheet(`Supplier Report ${currentDate}`);
    // const reportLines = reportContent.split("\n").map(line => [line]); // Convert text to rows
    // reportSheet.getRange(`A1:A${reportLines.length}`).setValues(reportLines);
    // reportSheet.getRange("A:A").getFormat().autofitColumns();
}
// Script: Extract Table Data & Generate Report
function main(workbook: ExcelScript.Workbook) {
    // Define the active worksheet
    const sheet = workbook.getActiveWorksheet();

    // Define the range for the user-entered table (A1:M6)
    const dataRange = sheet.getRange("A1:M6"); // Adjust range as needed
    const dataValues = dataRange.getValues(); // Fetch table data

    // Initialize the report header
    let reportContent = "T-SHIRT PRINTING CHECKLIST\n\n";
    reportContent += "This report serves as a printing checklist for M&H Awards.\n";
    reportContent += "----------------------------------------------\n\n";

    // Extract column headers (Sizes) from the first row
    const headers = dataValues[0].map(header => (header ? header.toString() : ""));

    // Process each row in the table (starting from row 2)
    for (let i = 1; i < dataValues.length; i++) {
        let rowData = dataValues[i]; // Get the row data
        const color = rowData[0] as string; // Column A: Color Name

        // Ensure valid color name
        if (!color) continue;

        reportContent += `Color: ${color}\n`;
        reportContent += "-----------------\n";

        // Loop through sizes (Small, Medium, Large, etc.)
        for (let j = 2; j < rowData.length; j += 2) {
            const size = headers[j]; // Get the size name from the header
            const orderAmount = rowData[j] as number; // Order amount from table

            if (orderAmount > 0) {
                reportContent += `${size}: Order Amount = ${orderAmount}, Check Off _____\n`;
            }
        }
        reportContent += "\n"; // Blank line after each color
    }

    // Add the footer with signature lines and date
    const currentDate = new Date().toISOString().split("T")[0]; // YYYY-MM-DD format
    reportContent += "-----------------------------------------------\n";
    reportContent += `Date: ${currentDate}\n`;
    reportContent += "Customer Service Specialist: ________________________________\n";
    reportContent += "Authorized Signature: ________________________________\n";

    // Output the report content to the console for review
    console.log(reportContent);

    // Notify the user
    workbook.getApplication().showNotification("T-Shirt printing report generated.");

    // Save report to a new worksheet
    const reportSheet = workbook.addWorksheet(`Printing Report ${currentDate}`);
    const reportLines = reportContent.split("\n").map(line => [line]); // Convert text to rows
    reportSheet.getRange(`A1:A${reportLines.length}`).setValues(reportLines);
    reportSheet.getRange("A:A").getFormat().autofitColumns();
}


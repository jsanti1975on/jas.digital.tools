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

  // Fetch the color name from column A, row 2
  const colorCell = sheet.getRange("A2");
  const colorName = colorCell.getValue() as string; // Extract the color name

  // Initialize the report header
  let reportContent = "INVENTORY REPORT\n\n";
  reportContent += "This report summarizes the inventory status for all sizes and the color.\n";
  reportContent += "----------------------------------------------\n\n";

  // Loop through each size and generate the report content
  for (const [size, column] of Object.entries(sizeColumns)) {
    // Read the count entered by the specialist in the single row
    const countCell = sheet.getRange(`${column}2`);
    let onhand = countCell.getValue() as number; // Cast to number

    // Check if the count exceeds the cap
    const exceedsCap = onhand > 6;

    // Apply the cap for calculations
    let cappedOnHand = onhand;
    if (exceedsCap) {
      cappedOnHand = 6; // Cap the count at 6 for calculations
    }

    // Calculate the order amount if capped on-hand count is less than 4
    let orderAmount = 0;
    if (cappedOnHand < 4) {
      orderAmount = 6 - cappedOnHand; // Calculate the difference (6 - current on-hand)
    }

    // Add the size, on-hand, and order amount info to the report
    reportContent += `Size: ${size}\n`;
    reportContent += `Color: ${colorName}\n`;
    reportContent += `On-hand count: ${onhand} ${exceedsCap ? "(Exceeds cap!)" : ""}\n`;
    reportContent += `Capped count used for calculations: ${cappedOnHand}\n`;
    reportContent += `Order-More count: ${orderAmount}\n`;
    reportContent += "-----------------\n";
  }

  // Add a footer to the report
  reportContent += "-----------------------------------------------\n";
  reportContent += "End of Report\n";

  // Output the report content to the console
  console.log(reportContent);

  // Optional: Notify the user that the report is ready
  // workbook.getApplication().showNotification("Polo inventory report generated. Copy it from the console.");
}

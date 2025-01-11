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
  
    // Initialize the report header
    let reportContent = "INVENTORY REPORT\n\n";
    reportContent += "This report summarizes the inventory status for all sizes.\n";
    reportContent += "----------------------------------------------\n\n";
  
    // Loop through each size and generate the report content
    for (const [size, column] of Object.entries(sizeColumns)) {
      // Read on-hand counts from the corresponding column
      const countRange = sheet.getRange(`${column}2:${column}5`);
      const counts = countRange.getValues();
  
      // Add size header to the report
      reportContent += `Size: ${size}\n`;
      reportContent += "------------------\n";
  
      // Loop through rows to add on-hand counts
      counts.forEach((row, index) => {
        const onHand = row[0]; // Value from the cell
        reportContent += `Row ${index + 2}: On-hand count = ${onHand}\n`;
      });
  
      reportContent += "\n"; // Add a blank line after each size
    }
  
    // Add a footer to the report
    reportContent += "----------------------------------------------\n";
    reportContent += "End of Report\n";
  
    // Output the report content to the console
    console.log(reportContent);
  
    // (Optional) Notify the user in Excel that the report is ready
    workbook.getApplication().showNotification("Inventory report generated. Copy it from the console.");
  }

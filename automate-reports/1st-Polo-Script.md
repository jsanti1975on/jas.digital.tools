# Below is a quik video to help myself

https://github.com/user-attachments/assets/bfb88516-b363-4e6a-b96a-3c2b0de238a0

## Below is the code block

```
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
  reportContent += "This report is the 1st script in the Polo series of scripts. The report can be copied from the console log\n";
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
      reportContent += `Row ${index + 1}: On-hand count = ${onHand}\n`; // I used Row index of 1 from 2 01-13-2024
    });

    reportContent += "\n"; // Add a blank line after each size
  }

  // Add a footer to the report
  reportContent += "----------------------------------------------\n";
  reportContent += "End of Report\n";

  // Output the report content to the console
  console.log(reportContent);

  // (Optional) Notify the user in Excel that the report is ready
  //workbook.getApplication().showNotification("Inventory report generated. Copy it from the console.");
}


```


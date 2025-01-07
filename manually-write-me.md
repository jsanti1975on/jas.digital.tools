```
function main(workbook: ExcelScript.Workbook) {
    let sheets = workbook.getWorksheets();

    const summarySheetName = "Summary";
    let summarySheet = sheets.find(sheet => sheet.getName() === summarySheetName);
    if (!summarySheet) {
        summarySheet = workbook.addWorksheet(summarySheetName);
        summarySheet.getRange("A1").setValues([["Date", "Account Number", "Total Expense"]]);
    }
    let lastRow = summarySheet.getUsedRange()?.getRowCount() || 1;

    for (let sheet of sheets) {
        if (sheet.getName() === summarySheetName) continue;

        let dataRange = sheet.getUsedRange();
        if (!dataRange) continue;

        let data = dataRange.getValues();
        let headers = data[0];
        let dateIndex = headers.indexOf("Date");
        let avgCostIndex = headers.indexOf("Avg Cost");
        let accountNumberIndex = headers.indexOf("Account Number");
        let quantityIndex = headers.indexOf("Quantity");

        if (dateIndex === -1 || avgCostIndex === -1 || accountNumberIndex === -1 || quantityIndex === -1) {
            console.log(`Sheet "${sheet.getName()}" does not have the required columns.`);
            continue;
        }

        for (let i = 1; i < data.length; i++) {
            let row = data[i];

            let date = row[dateIndex];
            let avgCost = row[avgCostIndex];
            let accountNumber = row[accountNumberIndex];
            let quantity = row[quantityIndex];

            // Skip rows with missing data
            if (!date || !avgCost || !accountNumber || !quantity) continue;

            // Ensure avgCost is a number
            if (typeof avgCost === "string") {
                avgCost = parseFloat(avgCost);
            }

            if (typeof avgCost !== "number" || isNaN(avgCost)) {
                console.log(`Invalid avgCost at row ${i + 1} in sheet "${sheet.getName()}". Skipping row.`);
                continue;
            }

            // Ensure quantity is a number
            if (typeof quantity === "string") {
                quantity = parseFloat(quantity);
            }

            if (typeof quantity !== "number" || isNaN(quantity)) {
                console.log(`Invalid quantity at row ${i + 1} in sheet "${sheet.getName()}". Skipping row.`);
                continue;
            }

            // Calculate Total Expense
            let totalExpense = avgCost * quantity;

            // Append to the summary sheet
            summarySheet.getRange(`A${lastRow + 1}:C${lastRow + 1}`).setValues([
                [date, accountNumber, totalExpense],
            ]);

            lastRow++;
        }
    }

    console.log("Summary sheet updated successfully.");
}
```

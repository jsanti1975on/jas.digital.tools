# Script for Aggregating Non-Sequential SKUs

```typescript
function main(workbook: ExcelScript.Workbook) {
  // Get input and output worksheets
  const wsInput = workbook.getWorksheet("input");
  const wsOutput = workbook.getWorksheet("output");

  // Define the input range for 10 rows (adjust as needed)
  const inputRange = wsInput.getRange("A1:I10");
  const data = inputRange.getValues();

  // Create an object to store SKU data
  const SKUData: { [key: string]: SKUDetails } = {};

  // Loop through the input data to aggregate by SKU (skip the header row)
  for (let i = 1; i < data.length; i++) {
    const row = data[i];
    const sku = String(row[1]); // SKU in Column B
    const qty = parseFloat(String(row[6])) || 0; // Package Qty in Column G
    const cost = parseFloat(String(row[7])) || 0; // Cost per Package in Column H
    const totalFormulaResult = parseFloat(String(row[5])) || 0; // Column F

    // Skip rows with missing SKU
    if (!sku) {
      continue;
    }

    // If SKU exists, update its details; otherwise, create a new entry
    if (SKUData[sku]) {
      SKUData[sku].addData(qty, cost, totalFormulaResult);
    } else {
      SKUData[sku] = new SKUDetails(qty, cost, totalFormulaResult);
    }
  }

  // Clear output sheet and write headers
  wsOutput.getUsedRange()?.clear();
  wsOutput.getRange("A1:D1").setValues([["SKU", "QTY", "Average Cost", "Total Formula Result"]]);

  // Write aggregated data to the output sheet
  let outputRow = 2;
  for (const sku in SKUData) {
    const skuDetails = SKUData[sku];
    wsOutput.getRange(`A${outputRow}:D${outputRow}`).setValues([
      [
        sku,
        skuDetails.qty,
        skuDetails.getAverageCost(),
        skuDetails.totalFormulaResult,
      ],
    ]);
    outputRow++;
  }
}

// Class-like structure for SKU details
class SKUDetails {
  qty: number;
  totalCost: number;
  totalFormulaResult: number;
  weightedCost: number;

  constructor(qty: number, cost: number, totalFormulaResult: number) {
    this.qty = qty;
    this.totalCost = cost;
    this.totalFormulaResult = totalFormulaResult;
    this.weightedCost = qty * cost; // Weighted cost initialized
  }

  // Method to add data
  addData(qty: number, cost: number, totalFormulaResult: number) {
    this.qty += qty;
    this.totalCost += cost;
    this.totalFormulaResult += totalFormulaResult;
    this.weightedCost += qty * cost; // Accumulate weighted cost
  }

  // Method to calculate weighted average cost
  getAverageCost(): number {
    return this.qty > 0 ? this.weightedCost / this.qty : 0; // Weighted average formula
  }
}
```
## Key Features of This Script: => needs testing
- Handles Non-Sequential Rows
- Dynamic SKU Handling
- Output Format
- Error Handling


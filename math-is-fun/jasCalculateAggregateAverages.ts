/**
 * This script was prompted with hours of practice at home using Google Apps Scripts and later VBA.
 * 
 * Key Requirements:
 * - Utilizes an object-oriented approach inspired by VBA Class Modules.
 * - Handles SKU aggregation with methods for calculating totals and averages.
 * 
 * Note:
 * - The arithmetic may need adjustments for a simple average if required (currently uses a count-based average).
 */

function main(workbook: ExcelScript.Workbook) {
  // Get input and output worksheets
  const wsInput = workbook.getWorksheet("input");
  const wsOutput = workbook.getWorksheet("output");

  // Define the input range and read its values (adjust the range as needed)
  const inputRange = wsInput.getRange("A1:I24");
  const data = inputRange.getValues();

  // Create an object to store SKU data
  const SKUData: { [key: string]: SKUDetails } = {};

  // Loop through the input data to aggregate by SKU (skip the header row)
  for (let i = 1; i < data.length; i++) {
    const row = data[i];
    const sku = String(row[1]); // SKU in Column B
    const qty = parseFloat(String(row[6])) || 0; // Package Qty in Column G
    const cost = parseFloat(String(row[7])) || 0; // Cost per Package in Column H
    const totalFormulaResult = parseFloat(String(row[5])) || 0; // Total Formula Result in Column F

    if (SKUData[sku]) {
      // Update existing SKU data
      SKUData[sku].addData(qty, cost, totalFormulaResult);
    } else {
      // Create a new SKU entry
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
        skuDetails.getAverageCost(), // Average Cost = Total Cost / Total QTY
        skuDetails.totalFormulaResult, // Aggregated Total Formula Result
      ],
    ]);
    outputRow++;
  }
}

/**
 * Class-like structure to manage SKU details (inspired by VBA Class Module)
 */
class SKUDetails {
  qty: number; // Total quantity
  totalCost: number; // Total cost
  totalFormulaResult: number; // Aggregated formula result
  count: number; // Number of records for this SKU

  constructor(qty: number, cost: number, totalFormulaResult: number) {
    this.qty = qty;
    this.totalCost = cost;
    this.totalFormulaResult = totalFormulaResult;
    this.count = 1;
  }

  /**
   * Method to add data for the current SKU.
   */
  addData(qty: number, cost: number, totalFormulaResult: number) {
    this.qty += qty;
    this.totalCost += cost * qty; // Total cost now accumulates as weighted cost
    this.totalFormulaResult += totalFormulaResult;
    this.count++;
  }

  /**
   * Method to calculate the average cost.
   * Simple average or weighted average can be applied here.
   */
  getAverageCost(): number {
    // Adjust the arithmetic as needed (currently a weighted average)
    return this.qty > 0 ? this.totalCost / this.qty : 0;
  }
}

# Excel Office Script: SKU Data Aggregation and Analysis | Weighted Mean Average

## "SKU Data Aggregator with Weighted Average Cost"

### Key Features

1. Input Data Parsing: Processes input data from the input worksheet within a predefined range `(A1:I24)`.
2. SKU Aggregation:
   - Calculates total quantity (QTY).
   - Computes weighted average cost (Average Cost) based on cost and quantity.
   - Summarizes total formula result values.
3.  Object-Oriented Approach: Utilizes a `SKUDetails` class to manage SKU-specific data.
4.  Output Results: Writes aggregated data to the `output` worksheet with clear headers and formatted results.

--------------------------------------------------------------------------------------------------------------------

# Script Overview

## Input Sheet:

**The script reads data from the input worksheet in the range `A1:I24`**

- Relevant columns:
  1. Column `B`: SKU
  2. Column `G`: Package Quantity (`QTY`)
  3. Column `H`: Cost per Package
  4. Column `F`: Total Formula Result
 
- Aggregation:
  1. Uses a dictionary to group data by SKU.
  2. Performs weighted average calculations for costs.
 
---------------------------------------------------------------------------------------------------------------------

## Output Sheet:

- Writes results to the output worksheet, starting with headers:
  1. `SKU`, `QTY`, `Average Cost`, and `Total Formula Result`.
 
---------------------------------------------------------------------------------------------------------------------

**Example Input and Output**

# Input Data 

## Example Use Case

## Given the following input & output in the `input` and `output` worksheet: *table shown only for description*

| SKU   | ... | Total Formula Result | Package Qty | Cost per Package |
|-------|-----|-----------------------|-------------|------------------|
| ABC01 | ... | 150                   | 10          | 5.00             |
| ABC01 | ... | 200                   | 15          | 4.50             |
| XYZ99 | ... | 300                   | 20          | 7.00             |

- Output Data
| **Output Data** | **SKU**  | **QTY** | **Average Cost** | **Total Formula Result** |
|------------------|----------|---------|------------------|---------------------------|
|                 | ABC01    | 25      | 4.70            | 350                       |
|                 | XYZ99    | 20      | 7.00            | 300                       |

---------------------------------------------------------------------------------------------------------------------

# Class Structure

## This class handles the aggregation logic for each SKU:
`SKUDetails`

**Attributes:**
- `qty`: Total quantity.
- `totalCost`: Total cost (unweighted).
- `totalFormulaResult`: Cumulative formula results.
- `weightedCost`: Cumulative cost for weighted average calculations.

**Methods:**
- `addData`: Updates the SKU's totals for quantity, cost, and formula results
- `getAverageCost`: Computes the weighted average cost (`weightedCost` / `qty`).

---------------------------------------------------------------------------------------------------------------------

**How to Use**
1. Open your Excel workbook and ensure:
- The `input` worksheet contains your data.
- The `output` worksheet is available for writing results.
- *Jason's. Notes => the workbook handle some work for double checking*
3. Run the script to process and output the aggregated data.

---------------------------------------------------------------------------------------------------------------------

**Why Use This Script?**
- Automates complex SKU data aggregation tasks.
- Ensures accurate calculations with weighted averages.
- Reduces manual effort and minimizes errors in financial or inventory reports.

_____________________________________________________________________________________________________________________

**Future Enhancements**
- Dynamically adjust for varying input ranges and datasets.
- Add error logging for missing or invalid data.
- Optimize performance for larger datasets.

```
function main(workbook: ExcelScript.Workbook) {
  // Get input and output worksheets
  const wsInput = workbook.getWorksheet("input");
  const wsOutput = workbook.getWorksheet("output");

  // Define the input range and read its values
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
    const totalFormulaResult = parseFloat(String(row[5])) || 0; // Column F

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

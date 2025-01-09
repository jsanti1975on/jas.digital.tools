# Excel Office Script: Aggregate SKU Data

This repository contains a TypeScript script designed for use with Excel's Office Scripts feature. The script aggregates data based on SKU (Stock Keeping Unit), calculates totals, and computes a weighted average cost. This was developed through discussions and iterations, building upon concepts learned from Google Apps Script and VBA.

---

## Script Overview

### Purpose
The script processes a dataset containing SKU information and performs the following tasks:
1. Aggregates data by SKU.
2. Calculates the total quantity (`QTY`), weighted average cost (`Average Cost`), and total formula result (`Total Formula Result`).
3. Outputs the results to a designated worksheet in Excel Online.

### Features
- **Weighted Average Calculation**: Uses a weighted formula to ensure accurate average costs.
- **Object-Oriented Approach**: Emulates VBA Class Modules using a custom `SKUDetails` class in TypeScript.
- **Error Handling**: Handles invalid or empty data gracefully by defaulting numeric fields to `0`.

---

## How to Use

### Input Data
The script expects data in the `input` worksheet within the range `A1:I24`:
- **Columns**:
  - Column `B`: SKU
  - Column `F`: Total Formula Result
  - Column `G`: Quantity (Package Qty)
  - Column `H`: Cost (Cost per Package)

### Output Data
The processed data is written to the `output` worksheet with the following columns:
- `SKU`
- `QTY` (Total Quantity)
- `Average Cost` (Weighted Average Cost)
- `Total Formula Result`

### How to Run
1. Copy the script into an Excel Office Script editor.
2. Ensure your workbook has the required `input` and `output` worksheets.
3. Run the script using the "Automate" tab in Excel Online.

---

## File Details

### `aggregate-sku-data.ts`
This TypeScript file contains the main logic for processing and aggregating SKU data.

### `README.md`
The current file provides an explanation of the script, how to use it, and its purpose.

---

## Background and Development

This script was inspired by:
- **Google Apps Script**: Initial experiments with automation for spreadsheets.
- **VBA**: Leveraging Class Modules to manage and aggregate data effectively.
- **TypeScript**: Transitioning the logic to Excel Online's scripting capabilities.

Key Takeaways:
- The arithmetic used for the average is weighted, ensuring precision for financial or inventory calculations.
- TypeScript provides a clean and modern alternative to VBA for online use cases.

---

## Example Use Case

Given the following input in the `input` worksheet:

| SKU   | ... | Total Formula Result | Package Qty | Cost per Package |
|-------|-----|-----------------------|-------------|------------------|
| ABC01 | ... | 150                   | 10          | 5.00             |
| ABC01 | ... | 200                   | 15          | 4.50             |
| XYZ99 | ... | 300                   | 20          | 7.00             |

The output in the `output` worksheet will be:

| SKU   | QTY | Average Cost | Total Formula Result |
|-------|-----|--------------|-----------------------|
| ABC01 | 25  | 4.70         | 350                   |
| XYZ99 | 20  | 7.00         | 300                   |

---

## Future Improvements
- Extend the script to dynamically adjust for varying input ranges.
- Add support for error logging or debugging output.
- Modularize the script for larger datasets or more complex calculations.

---

## License
This project is open-source. Feel free to use, modify, and share it as needed.

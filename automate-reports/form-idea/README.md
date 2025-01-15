## 2. Using Microsoft Power Automate (For a Custom Input Form)

Power Automate can be used to create more sophisticated workflows, such as sending users a form to fill out, and then automatically updating the Excel file with the input values.

### Here's how you can set up Power Automate:

1. **Create a Form (Microsoft Forms):**
    - Go to **Microsoft Forms** and create a simple form where the user can input the inventory count.
    - Include fields like **Item Name** or **Item ID**, and **Count**.

2. **Set Up Power Automate:**
    - In **Power Automate**, create a new flow that triggers when a new response is submitted via **Microsoft Forms**.
    - The flow should include actions to update **Excel Online** with the data from the form submission.
    - Connect the form and **Excel Online** through Power Automate, specifying which cells or rows should be updated based on the form responses.

3. **Notification to User:**
    - Once the flow is set up, users will fill out the form, and the response will automatically update the Excel sheet without the user needing to manually enter values in the spreadsheet.

This solution is more complex but provides a fully customizable, user-friendly form interface.

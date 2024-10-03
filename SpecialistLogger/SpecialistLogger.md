# FinanceLogger

The **FinanceLogger** is an Excel VBA-based tool designed to streamline financial logging processes, including tracking different types of logs such as inventory management, monthly reports, sales reports, and more. It allows users to log entries efficiently, including capturing notes for each entry, and stores the data in a structured Excel worksheet for easy reporting.

## Features

- **Log Type Selection**: Supports various log types such as Inventory, Conversions, Monthly Reports, Pavilion, Anomalies, and Reconcile.
- **Dynamic Form Controls**: Depending on the log type, specific form fields appear, allowing for targeted data entry.
- **Notes Field**: A `txtNotes` field is always visible for all log entries and captures additional information.
- **Timestamping**: Automatically timestamps each log entry when it is submitted.
- **Excel Storage**: Logs data into an Excel worksheet, where each entry is stored with its timestamp, log type, and other relevant data.

## Project Structure


## UserForm Design

The form is designed with dynamic controls that change based on the log type selected. Key form controls include:

- **cmbLogType** (ComboBox): Allows users to select the type of log (e.g., Inventory, Conversions).
- **txtNotes** (TextBox): A multiline text box to capture notes related to any entry. This is always visible.
- **CheckBoxes**: Depending on the log type, users can select additional information such as whether an email was sent or a report was completed.
- **cmdSubmit** (Button): A button that saves the form data into the Excel worksheet.

## Worksheet Data Layout

All log data is saved to a worksheet named `CustomerServiceLogger`. The structure of the worksheet is as follows:

| Column | Description                                  |
|--------|----------------------------------------------|
| A      | Timestamp (Date and Time of the entry)       |
| B      | Log Type (Inventory, Conversions, etc.)      |
| C      | Inventory Type (Food/Non-Food for Inventory) |
| D      | Email Sent (Boolean for relevant log types)  |
| E      | Monthly Report Completed (Boolean)           |
| F      | Added to Daily Sales Report (Boolean)        |
| G      | Refund Requested (Boolean)                   |
| H      | Notes (Text from the txtNotes field)         |

## Setup Instructions

### Prerequisites

- Microsoft Excel with support for VBA.
- Basic understanding of Excel macros and forms.

### How to Set Up

1. Open the `FinanceLogger.xlsm` file in Excel.
2. Press `Alt + F11` to open the VBA Editor.
3. Create a UserForm using the controls described below:
    - **ComboBox** (`cmbLogType`) for selecting the log type.
    - **TextBox** (`txtNotes`) for entering notes (always visible).
    - **CheckBoxes** for additional fields based on the log type (e.g., `chkEmail` for email sent).
    - **CommandButton** (`cmdSubmit`) to submit the form.
4. Paste the following VBA code in the `UserForm` code module:

```vba
Private Sub UserForm_Initialize()
    ' Initialize form controls and setup the UI
    With cmbLogType
        .Clear
        .AddItem "Inventory"
        .AddItem "Conversions"
        .AddItem "Monthly Report"
        .AddItem "Pavilion"
        .AddItem "Anomalies"
        .AddItem "Reconcile"
    End With
    ' Ensure txtNotes is visible for all entries
    txtNotes.Visible = True
    lblNotes.Visible = True
    HideAllControls
End Sub

Private Sub HideAllControls()
    ' Hide all specific form controls
    lblType.Visible = False
    cmbType.Visible = False
    lblEmail.Visible = False
    chkEmail.Visible = False
    lblCompleted.Visible = False
    chkCompleted.Visible = False
    lblDailyReport.Visible = False
    chkDailyReport.Visible = False
    lblRefund.Visible = False
    chkRefund.Visible = False
End Sub

Private Sub cmbLogType_Change()
    ' Show controls based on the selected log type
    HideAllControls
    txtNotes.Visible = True
    lblNotes.Visible = True
    Select Case cmbLogType.Value
        Case "Inventory"
            lblType.Visible = True
            cmbType.Visible = True
            lblEmail.Visible = True
            chkEmail.Visible = True
        Case "Conversions"
            lblEmail.Visible = True
            chkEmail.Visible = True
        Case "Monthly Report"
            lblCompleted.Visible = True
            chkCompleted.Visible = True
        Case "Pavilion"
            lblDailyReport.Visible = True
            chkDailyReport.Visible = True
            lblRefund.Visible = True
            chkRefund.Visible = True
        Case "Anomalies", "Reconcile"
            ' No specific controls other than Notes
    End Select
End Sub

Private Sub cmdSubmit_Click()
    ' Submit the form data to the worksheet
    Dim iRow As Long
    Dim sh As Worksheet
    Set sh = ThisWorkbook.Sheets("CustomerServiceLogger")
    iRow = WorksheetFunction.CountA(sh.Range("A:A")) + 1
    With sh
        .Cells(iRow, 1).Value = Now ' Timestamp
        .Cells(iRow, 2).Value = cmbLogType.Value ' Log Type
        Select Case cmbLogType.Value
            Case "Inventory"
                .Cells(iRow, 3).Value = cmbType.Value ' Food/Non-Food
                .Cells(iRow, 4).Value = chkEmail.Value ' Email Sent
            Case "Conversions"
                .Cells(iRow, 4).Value = chkEmail.Value ' Email Sent
            Case "Monthly Report"
                .Cells(iRow, 5).Value = chkCompleted.Value ' Report Completed
            Case "Pavilion"
                .Cells(iRow, 6).Value = chkDailyReport.Value ' Added to Sales Report
                .Cells(iRow, 7).Value = chkRefund.Value ' Refund Requested
        End Select
        .Cells(iRow, 8).Value = txtNotes.Value ' Notes
    End With
    MsgBox "Data saved successfully!", vbInformation
    ResetForm
End Sub

Private Sub ResetForm()
    ' Reset the form for a new entry
    cmbLogType.Value = ""
    HideAllControls
    txtNotes.Value = ""
    chkEmail.Value = False
    chkCompleted.Value = False
    chkDailyReport.Value = False
    chkRefund.Value = False
    txtNotes.Visible = True
    lblNotes.Visible = True
End Sub

```

### Explanation:
- This markdown file provides an overview of the **FinanceLogger**, its features, setup steps, and a guide on how to create and configure the form in Excel.
- It includes the VBA code needed for initialization, form control, and data logging.
  
![Pavilion](https://github.com/user-attachments/assets/5b2e43af-371b-49c4-a826-f1354ce2c998)
![Inventory](https://github.com/user-attachments/assets/41f52eba-c89d-4972-a6cd-60925b5d5d47)
![Home Debugger - Monthly Report](https://github.com/user-attachments/assets/b72df90d-45b0-4d69-b2fb-d221a8e7a045)
![Home Debug Conversion Image](https://github.com/user-attachments/assets/b2d0b397-cae3-4934-82c8-66fc6794294c)

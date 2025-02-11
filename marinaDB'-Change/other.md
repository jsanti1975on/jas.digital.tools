# Steps to Set Up the `frmOtherNotes` Form


# The SUB is the working sub from home debugger - also note that the name of the form does not matter here
---

## 1. Add the Required Controls to the Form

| **Control Name**         | **Type**         | **Purpose**                                                      |
|---------------------------|------------------|------------------------------------------------------------------|
| `lblSlipNumber`           | Label           | Label for the `txtSlipNumber` field.                             |
| `txtSlipNumber`           | TextBox         | Input field for slip number (optional for "Other" condition).    |
| `lblSpecialist`           | Label           | Label for the `cmbSpecialist` dropdown.                         |
| `cmbSpecialist`           | ComboBox        | Dropdown for selecting the specialist (e.g., "Jason," "Andrew"). |
| `lblSubject`              | Label           | Label for the `cmbSubject` dropdown.                            |
| `cmbSubject`              | ComboBox        | Dropdown for selecting the subject (must include "Other").       |
| `lblNoteType`             | Label           | Label for the `cmbNoteType` dropdown.                           |
| `cmbNoteType`             | ComboBox        | Dropdown for selecting the note type (must include "Other").     |
| `lblSubmitData`           | Label           | Label for the `cmdSubmit` button (hidden when "Other" condition is met). |
| `cmdSubmit`               | CommandButton   | Button for submitting standard notes.                           |
| `lblReadNotes`            | Label           | Label for the `cmdReadNotes` button (hidden when "Other" condition is met). |
| `cmdReadNotes`            | CommandButton   | Button for reading existing notes.                              |
| `txtNotes`                | TextBox         | Input field for entering notes (used when the "Other" condition is met). |
| `lblOtherNote`            | Label           | Label for the `txtNotes` field when "Other" condition is met.    |
| `cmdOtherNoteSubmit`      | CommandButton   | Button to submit data specifically for "Other" notes.           |
| `cmdReset`                | CommandButton   | Button to reset the form to its default state.                  |
| `lstTenantNotes`          | ListBox         | Optional: Displays logged tenant notes.                         |
| `lblEnterNoteBelow`       
---

## 2. Initialize the Form Controls

### In the `UserForm_Initialize` event:
- Set initial visibility and behavior of controls.
- Populate dropdowns (`cmbSubject`, `cmbNoteType`, `cmbSpecialist`).
- Configure the `lstTenantNotes` list box (if used).

```vba
Private Sub UserForm_Initialize()
    cmdReset_Click ' Initialize the form using the reset logic
End Sub
```

---

## 3. Configure Reset Functionality

### The `cmdReset_Click` subroutine:
- Resets all form fields to their default state.
- Populates dropdowns with required values.
- Resets visibility and background colors of controls.

---

## 4. Define "Other" Condition Logic

### In the `CheckOtherCondition` subroutine:
- Use the "Other" condition logic to determine visibility and behavior of controls:
  - If both `cmbSubject` and `cmbNoteType` are set to "Other", call `HideControls`.
  - If either dropdown is changed to a value other than "Other", call `ResetControls`.

---

## 5. Hide and Reset Controls

### `HideControls`:
- Hides irrelevant controls (`lblSlipNumber`, `cmbSpecialist`, etc.).
- Shows relevant controls for the "Other" condition (`txtNotes`, `lblOtherNote`, `cmdOtherNoteSubmit`).
- Changes background color of buttons to white.

### `ResetControls`:
- Restores visibility of all controls to their default state.
- Resets button background colors to the default system color.

---

## 6. Handle Dropdown Changes

- **`cmbSubject_Change` and `cmbNoteType_Change`**:
  - Trigger the `CheckOtherCondition` subroutine to update form behavior dynamically when the dropdown values change.

---

## 7. Submit "Other" Notes

### The `cmdOtherNoteSubmit_Click` subroutine:
- Saves the "Other" note data to the worksheet (`TenantLogger`).
- Confirms successful submission via a `MsgBox`.
- Resets the form using `cmdReset_Click`.

---

## Testing Checklist

### Set Both Dropdowns to "Other":
- Verify that irrelevant controls are hidden.
- Confirm that `txtNotes`, `lblOtherNote`, and `cmdOtherNoteSubmit` are visible.

### Reset Functionality:
- Test the `cmdReset` button to ensure all controls return to their default state.

### Submit Notes:
- Test the `cmdOtherNoteSubmit` button to save "Other" notes and reset the form.

### Dropdown Changes:
- Test dropdown value changes to ensure proper visibility toggling.

```
Option Explicit
' I tweaked some of the labels, added Now() to time stamp other logs outside of slip number
' The form was changed a bit and will be saved as `other` in 365
' Shared Sub to handle visibility and background color logic
Private Sub CheckOtherCondition()
    If cmbSubject.Value = "Other" And cmbNoteType.Value = "Other" Then
        ' Both conditions are met
        MsgBox "Both Subject and Note Type are set to 'Other'. Enter your details in the Notes field.", vbInformation, "Other Notes"
        HideControls
    Else
        ' Reset if either dropdown changes away from "Other"
        ResetControls
    End If
End Sub

' Hide all irrelevant controls
Private Sub HideControls()
    lblSlipNumber.Visible = False
    txtSlipNumber.Visible = False
    lblSpecialist.Visible = False
    cmbSpecialist.Visible = False
    lblSubject.Visible = False
    cmbSubject.Visible = False
    lblNoteType.Visible = False
    cmbNoteType.Visible = False
    lblSubmitData.Visible = False
    lblReadNotes.Visible = False
    lblEnterNoteBelow.Visible = False
    cmdSubmit.Visible = False
    cmdReadNotes.Visible = False
    

    ' Change background color to default for Submit and Read Notes buttons
    cmdSubmit.BackColor = RGB(128, 128, 128) '
    cmdReadNotes.BackColor = RGB(128, 128, 128) '
    

    ' Show only relevant controls for "Other"
    txtNotes.Visible = True
    lblOtherNote.Visible = True
    cmdOtherNoteSubmit.Visible = True

    ' Optional: Gray out Slip Number field instead of hiding it
    txtSlipNumber.BackColor = RGB(211, 211, 211) ' Light gray
End Sub

' Reset all controls to default visibility and styles
Private Sub ResetControls()
    lblSlipNumber.Visible = True
    txtSlipNumber.Visible = True
    txtSlipNumber.BackColor = RGB(255, 255, 255) ' Restore white background
    lblSpecialist.Visible = True
    cmbSpecialist.Visible = True
    lblSubject.Visible = True
    cmbSubject.Visible = True
    lblNoteType.Visible = True
    cmbNoteType.Visible = True
    lblSubmitData.Visible = True
    lblReadNotes.Visible = True
    cmdReadNotes.Visible = True
    ' Restore background color for Submit and Read Notes buttons
    cmdSubmit.BackColor = RGB(240, 240, 240) ' Default system button color
    cmdReadNotes.BackColor = RGB(240, 240, 240) ' Default system button color

    ' Hide "Other" specific controls
    txtNotes.Visible = True
    lblOtherNote.Visible = False
    cmdOtherNoteSubmit.Visible = False
End Sub

' Handle changes in Subject dropdown
Private Sub cmbSubject_Change()
    CheckOtherCondition
End Sub

' Handle changes in Note Type dropdown
Private Sub cmbNoteType_Change()
    CheckOtherCondition
End Sub

Private Sub cmdReadNotes_Click()
    Dim saveNumber As String
    Dim noteText As String
    Dim iRow As Variant
    Dim sh As Worksheet
    
    ' Prompt the user to enter a save number
    ' 10-17-2024 -- Use a txtBox form control for future use of `MaxChar`
    saveNumber = InputBox("Enter the save number to read the note:", "Read Note")
    
    ' Validate the input
    If saveNumber = "" Then Exit Sub
    If Not IsNumeric(saveNumber) Then
        MsgBox "Please enter a valid numeric save number .", vbExclamation, "Invalid Input"
        Exit Sub
    End If
    
    Set sh = ThisWorkbook.Sheets("TenantLogger")
    
    ' Find the corresponding row related to the save number
    On Error Resume Next
    iRow = Application.Match(CLng(saveNumber), sh.Range("A:A"), 0)
    On Error GoTo 0
    
    If IsError(iRow) Then
        MsgBox "Save number not found.", vbExclamation, "Error"
        Exit Sub
    End If
    
    ' Retrieve the note in the corresponding column
    noteText = sh.Cells(iRow, 7).Value
    
    ' Display the note in a message box
    If noteText <> "" Then
        MsgBox "Note for Save Number " & saveNumber & ": " & vbCrLf & vbCrLf & noteText, vbInformation, "Note Details"
    Else
        MsgBox "No note found for Save Number " & saveNumber, vbInformation, "No Note"
    End If
End Sub

' Reset form to default state
Private Sub cmdReset_Click()
    Dim iRow As Long

    iRow = WorksheetFunction.CountA(Sheets("TenantLogger").Range("A:A"))

    With Me
        ' Reset form fields
        .cmbNoteType.Clear
        .cmbSpecialist.Clear
        .txtSlipNumber.Value = ""
        .cmbSubject.Clear
        .txtNotes.Value = ""

        ' Populate the Note Type dropdown
        .cmbNoteType.AddItem "Tenant Note"
        .cmbNoteType.AddItem "Other"

        ' Populate the Specialist dropdown
        .cmbSpecialist.AddItem "Jason"
        .cmbSpecialist.AddItem "redacted"
        .cmbSpecialist.AddItem "redacted"
        .cmbSpecialist.AddItem "Ops.Sup."
        .cmbSpecialist.AddItem "Ops.Manager"

        ' Populate the Subject dropdown
        .cmbSubject.AddItem "Notice of Termination"
        .cmbSubject.AddItem "New Tenant"
        .cmbSubject.AddItem "Overnight Paid"
        .cmbSubject.AddItem "Slip Change"
        .cmbSubject.AddItem "Other" ' Includes "Other"
        
        ' Populate Label
        lblEnterNoteBelow.Visible = True

        ' Reset ListBox setup
        .lstTenantNotes.ColumnCount = 6
        .lstTenantNotes.ColumnHeads = True
        .lstTenantNotes.ColumnWidths = "30,45,30,60,60,15"

        ' Set ListBox RowSource dynamically
        If iRow > 1 Then
            .lstTenantNotes.RowSource = "TenantLogger!A2:F" & iRow
        Else
            .lstTenantNotes.RowSource = "TenantLogger!A2:F2"
        End If

        ' Reset visibility
        ResetControls
    End With
End Sub

' Submit notes for "Other" condition
Private Sub cmdOtherNoteSubmit_Click()
    Dim sh As Worksheet
    Dim iRow As Long

    On Error GoTo ErrorHandler
    Set sh = ThisWorkbook.Sheets("TenantLogger")
    iRow = WorksheetFunction.CountA(sh.Range("A:A")) + 1

    ' Write only "Other" specific fields to the worksheet
    With sh
        .Cells(iRow, 1).Value = iRow - 1 ' Save Number
        .Cells(iRow, 4).Value = "Other" ' Subject
        .Cells(iRow, 2).Value = "Other" ' Note Type
        .Cells(iRow, 6).Value = Now()
        .Cells(iRow, 7).Value = Me.txtNotes.Value ' Notes
    End With

    ' Confirmation message
    MsgBox "Your 'Other' note has been saved.", vbInformation, "Submission Successful"
    cmdReset_Click ' Reset the form

    Exit Sub
ErrorHandler:
    MsgBox "An error occurred while saving the note.", vbCritical, "Error"
End Sub

Private Sub cmdSubmit_Click()
    ' Call the SubmitTenantData subroutine when the button is clicked
    SubmitTenantData
End Sub
Private Sub SubmitTenantData()
    Dim sh As Worksheet
    Dim iRow As Long
    Dim slipNumber As String
    Dim noteText As String
    
    ' Get the slip number from the form
    slipNumber = Me.txtSlipNumber.Value
    
    ' Validate the slip number
    If Not IsValidSlipNumber(slipNumber) Then
        Exit Sub ' If validation fails, exit the subroutine
    End If
    
    ' Get the note text from the form
    noteText = Me.txtNotes.Value
    
    ' Validate the length of the note {^_^}LOOKEY_FLAG since we know the max limit was reached this procedure was not called. 65 changed to 200 on 10-18-2024
    
    If Len(noteText) > 200 Then
        MsgBox "The note exceeds the maximum allowed length of 200 characters.", vbExclamation, "Character Limit Reached"
        Exit Sub ' Exit the subroutine if the note is too long
    End If
    
    On Error GoTo ErrorHandler ' Enable error handling
    
    Set sh = ThisWorkbook.Sheets("TenantLogger")
    iRow = [CountA(TenantLogger!A:A)] + 1
    
    ' Try to write data to the worksheet
    With sh
        .Cells(iRow, 1).Value = iRow - 1                                           ' Save Number
        .Cells(iRow, 2).Value = Me.cmbNoteType                                     ' Note Type (from memory)//8/29/24 update code not call from memory changed back to default
        .Cells(iRow, 3).Value = slipNumber                                         ' Slip Number
        .Cells(iRow, 4).Value = Me.cmbSubject.Value                                ' Subject
        .Cells(iRow, 5).Value = Me.cmbSpecialist.Value                             ' Specialist
        .Cells(iRow, 6).Value = Now()                                              ' Timestamp
        .Cells(iRow, 7).Value = noteText                                           ' Notes
    End With
    
    ' Display confirmation message
    MsgBox "Data has been successfully submitted for Slip Number " & slipNumber & ".", vbInformation, "Submission Confirmed"
    
    ' Unload the form after submission is confirmed
    Unload Me

    ' Optionally, make the Excel application visible again
    Application.Visible = True
    
    Exit Sub ' Exit to avoid triggering the error handler after successful completion

ErrorHandler:
    MsgBox "An error occurred while submitting the data. Please check the Slip Number and try again.", _
           vbCritical, "Error"
End Sub

' Initialize form on load
Private Sub UserForm_Initialize()
    cmdReset_Click ' Reset form on initialize
End Sub




```

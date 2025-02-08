# Part 1 of Call List Project

## Note to future self => Dont waste time on this garbage - get the Sec +

![CallLogUseme](https://github.com/user-attachments/assets/49a833f7-5e12-4757-a30f-0a5380fbe30e)

```vba
Option Explicit

Private Sub lstTenantNote_Click()
    Dim selectedRow As Integer
    Dim noteText As String
    
    ' Ensure a selection is made
    If lstTenantNotes.ListIndex = -1 Then Exit Sub
    
    ' Get the selected row index (ListBox index starts at 0)
    selectedRow = lstTenantNotes.ListIndex
    
    ' Retrieve the note (Column Index 6 is column G in the TenantLogger sheet)
    noteText = lstTenantNotes.List(selectedRow, 6) ' Column 6 contains the notes
    
    ' Display the note
    If Trim(noteText) <> "" Then
        MsgBox "Note: " & vbCrLf & noteText, vbInformation, "Tenant Note Details"
    Else
        MsgBox "No note available for this entry.", vbExclamation, "No Note"
    End If

End Sub

Private Sub UserForm_Initialize()
    Dim ws As Worksheet
    Dim rng As Range
    Dim cell As Range
    
    ' Set reference to Tenant List worksheet
    Set ws = ThisWorkbook.Sheets("TenantList")
    
    ' Clear and populate the tenant dropdown
    cmbTenantList.Clear
    Set rng = ws.Range("A2:A" & ws.Cells(ws.Rows.Count, "A").End(xlUp).Row)
    
    For Each cell In rng
        cmbTenantList.AddItem cell.Value
    Next cell
    
    ' Disable notes field initially
    txtNotes.Enabled = False
End Sub
Private Sub cmbTenantList_Change()
    Dim ws As Worksheet
    Dim rng As Range
    Dim cell As Range
    
    Set ws = ThisWorkbook.Sheets("TenantList")
    Set rng = ws.Range("A2:B" & ws.Cells(ws.Rows.Count, "A").End(xlUp).Row) ' Assuming column B has phone numbers

    ' Search for the selected tenant's phone number
    For Each cell In rng
        If cell.Value = cmbTenantList.Value Then
            txtPhoneNumber.Value = cell.Offset(0, 1).Value ' Get phone number from column B
            Exit For
        End If
    Next cell
End Sub
Private Sub optSpokeToTenant_Click()
    txtNotes.Enabled = True
End Sub

Private Sub optLeftMessage_Click()
    txtNotes.Enabled = False
    txtNotes.Value = "" ' Clear notes if left message
End Sub
Private Sub cmdLogCall_Click()
    Dim ws As Worksheet
    Dim iRow As Long
    Dim callStatus As String
    Dim callTime As String
    
    ' Ensure a tenant is selected
    If cmbTenantList.Value = "" Then
        MsgBox "Please select a tenant.", vbExclamation, "Missing Data"
        Exit Sub
    End If
    
    ' Ensure an option is selected
    If Not (optSpokeToTenant.Value Or optLeftMessage.Value) Then
        MsgBox "Please select whether you spoke to the tenant or left a message.", vbExclamation, "Missing Data"
        Exit Sub
    End If
    
    ' Determine call status
    If optSpokeToTenant.Value Then
        callStatus = "Spoke to Tenant"
    ElseIf optLeftMessage.Value Then
        callStatus = "Left Message"
    End If
    
    ' Capture current time
    callTime = Format(Now(), "MM/DD/YYYY HH:MM AM/PM")

    ' Set reference to Call Log worksheet
    Set ws = ThisWorkbook.Sheets("CallLog")
    
    ' Find the next available row
    iRow = ws.Cells(ws.Rows.Count, "A").End(xlUp).Row + 1
    
    ' Log the call
    With ws
        .Cells(iRow, 1).Value = cmbTenantList.Value ' Tenant Name
        .Cells(iRow, 2).Value = txtPhoneNumber.Value ' Phone Number
        .Cells(iRow, 3).Value = callStatus ' Call Status
        .Cells(iRow, 4).Value = callTime ' Timestamp
        .Cells(iRow, 5).Value = txtNotes.Value ' Notes
        .Cells(iRow, 6).Value = Application.UserName ' Logs the specialist's username

    End With

    ' Confirmation message
    MsgBox "Call logged successfully!", vbInformation, "Success"

    ' Reset the form
    cmbTenantList.Value = ""
    txtPhoneNumber.Value = ""
    txtNotes.Value = ""
    txtNotes.Enabled = False
    optSpokeToTenant.Value = False
    optLeftMessage.Value = False
End Sub
Private Sub cmdCancel_Click()
    Unload Me
End Sub
```

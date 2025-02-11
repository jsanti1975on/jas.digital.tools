# Part 1 of Call List Project

## Note to future self => Dont waste time on this garbage - get the Sec +
Redirect Cyber Lab Projects

## Demo Authentication
- EAP
- 802.1X
- Single sign-on (SSO)
- Security Assertions Markup Language (SAML)
- OAuth
- OpenID
- Kerberos

## Identity Management and Authentication
- Harden Authentication

===========[ Start of Call List - just use a notepad ]===

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
=====



Private Sub cmdExportCSV_Click()
    Dim ws As Worksheet
    Dim lastRow As Long
    Dim rng As Range
    Dim fileName As String
    
    Set ws = ThisWorkbook.Sheets("CallLog")
    lastRow = ws.Cells(ws.Rows.Count, "A").End(xlUp).Row
    Set rng = ws.Range("A1:F" & lastRow)
    
    ' Define file name and location
    fileName = ThisWorkbook.Path & "\CallLog_" & Format(Now, "YYYY-MM-DD") & ".csv"
    
    ' Save as CSV
    rng.Copy
    Workbooks.Add
    ActiveSheet.Paste
    ActiveWorkbook.SaveAs fileName, xlCSV
    ActiveWorkbook.Close False
    
    MsgBox "Call Log exported successfully to " & fileName, vbInformation, "Export Complete"
End Sub

=======
Private Sub lstCallLog_Click()
    Dim selectedRow As Integer
    
    ' Ensure a selection is made
    If lstCallLog.ListIndex = -1 Then Exit Sub
    
    ' Get the selected row index
    selectedRow = lstCallLog.ListIndex
    
    ' Populate form fields
    cmbTenantList.Value = lstCallLog.List(selectedRow, 0) ' Name
    txtPhoneNumber.Value = lstCallLog.List(selectedRow, 1) ' Phone
    
    ' Check contacted status
    If lstCallLog.List(selectedRow, 2) = "Spoke to Tenant" Then
        optSpokeToTenant.Value = True
        txtNotes.Enabled = True
    ElseIf lstCallLog.List(selectedRow, 2) = "Left Message" Then
        optLeftMessage.Value = True
        txtNotes.Enabled = False
    End If
    
    ' Load existing notes (if any)
    txtNotes.Value = lstCallLog.List(selectedRow, 4)
End Sub

====
Private Sub UserForm_Initialize()
    Dim ws As Worksheet
    Dim lastRow As Long
    Dim i As Long
    
    Set ws = ThisWorkbook.Sheets("CallLog")
    
    ' Get the last row in the CallLog sheet
    lastRow = ws.Cells(ws.Rows.Count, "A").End(xlUp).Row
    
    ' Clear the ListBox
    lstCallLog.Clear
    lstCallLog.ColumnCount = 6
    lstCallLog.ColumnWidths = "100,100,80,120,150,100" ' Adjust as needed
    
    ' Load call log data into the ListBox
    For i = 2 To lastRow
        lstCallLog.AddItem ws.Cells(i, 1).Value ' Name
        lstCallLog.List(lstCallLog.ListCount - 1, 1) = ws.Cells(i, 2).Value ' Phone
        lstCallLog.List(lstCallLog.ListCount - 1, 2) = ws.Cells(i, 3).Value ' Contacted Status
        lstCallLog.List(lstCallLog.ListCount - 1, 3) = ws.Cells(i, 4).Value ' Timestamp
        lstCallLog.List(lstCallLog.ListCount - 1, 4) = ws.Cells(i, 5).Value ' Notes
        lstCallLog.List(lstCallLog.ListCount - 1, 5) = ws.Cells(i, 6).Value ' User
    Next i
End Sub
====
use me 



Option Explicit

Private Sub UserForm_Initialize()
    Dim ws As Worksheet
    Dim lastRow As Long
    Dim i As Long
    
    Set ws = ThisWorkbook.Sheets("CallLog")
    
    ' Get the last row in the CallLog sheet
    lastRow = ws.Cells(ws.Rows.Count, "A").End(xlUp).Row
    
    ' Configure ListBox Properties
    With lstCallLog
        .Clear
        .ColumnCount = 6
        .ColumnWidths = "100,100,80,120,150,100" ' Adjust column widths as needed
    End With

    ' Add column headers manually using labels (adjust placement in the UserForm)
    lblHeaderName.Caption = "Name"
    lblHeaderPhone.Caption = "Phone"
    lblHeaderContacted.Caption = "Contacted"
    lblHeaderTimestamp.Caption = "Time Stamp"
    lblHeaderNotes.Caption = "Notes"
    lblHeaderUser.Caption = "User"
    
    ' Load call log data into the ListBox
    For i = 2 To lastRow
        lstCallLog.AddItem ws.Cells(i, 1).Value ' Name
        lstCallLog.List(lstCallLog.ListCount - 1, 1) = ws.Cells(i, 2).Value ' Phone
        lstCallLog.List(lstCallLog.ListCount - 1, 2) = ws.Cells(i, 3).Value ' Contacted Status
        lstCallLog.List(lstCallLog.ListCount - 1, 3) = ws.Cells(i, 4).Value ' Timestamp
        lstCallLog.List(lstCallLog.ListCount - 1, 4) = ws.Cells(i, 5).Value ' Notes
        lstCallLog.List(lstCallLog.ListCount - 1, 5) = ws.Cells(i, 6).Value ' User
    Next i
End Sub


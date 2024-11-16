Option Explicit

' Reset the form to default values
Private Sub cmdReset_Click()
    Dim iRow As Long

    ' Get the last row in the Slip-Change sheet
    iRow = WorksheetFunction.CountA(Sheets("Slip-Change").Range("A:A"))

    With Me
        ' Reset all fields
        .cmbNoteType.Clear
        .cmbSpecialist.Clear
        .txtSlipNumber.Value = ""
        .cmbSubject.Clear
        .txtNotes.Value = ""

        ' Populate the Note Type dropdown
        .cmbNoteType.AddItem "Tenant Note"
        .cmbNoteType.AddItem "Overnight Note"

        ' Populate the Specialist combo box
        .cmbSpecialist.AddItem "Jason"
        .cmbSpecialist.AddItem "Andrew"
        .cmbSpecialist.AddItem "Chris"
        .cmbSpecialist.AddItem "Ops. Sup."
        .cmbSpecialist.AddItem "Ops. Manager"

        ' Populate the Subject dropdown
        .cmbSubject.AddItem "Notice of Termination"
        .cmbSubject.AddItem "New Tenant"
        .cmbSubject.AddItem "Overnight Paid"
        .cmbSubject.AddItem "Slip Change"
        .cmbSubject.AddItem "Other"

        ' Set up the ListBox
        .lstTenantNotes.ColumnCount = 6
        .lstTenantNotes.ColumnHeads = True
        .lstTenantNotes.ColumnWidths = "60,55,30,100,60,15"

        ' Set the RowSource for the ListBox
        If iRow > 1 Then
            .lstTenantNotes.RowSource = "Slip-Change!A2:F" & iRow
        Else
            .lstTenantNotes.RowSource = "Slip-Change!A2:F2"
        End If
    End With
End Sub

' Submit the data to the Slip-Change sheet
Private Sub cmdSubmit_Click()
    ' Call the SubmitSlipChangeData subroutine when the button is clicked
    SubmitSlipChangeData
End Sub

Private Sub SubmitSlipChangeData()
    Dim sh As Worksheet
    Dim iRow As Long
    Dim slipNumber As String
    Dim noteText As String

    ' Get the slip number from the form
    slipNumber = Me.txtSlipNumber.Value

    ' Validate the slip number
    If Not IsValidSlipNumber(slipNumber) Then
        MsgBox "Invalid Slip Number. Please check and try again.", vbExclamation, "Validation Error"
        Exit Sub
    End If

    ' Get the note text from the form
    noteText = Me.txtNotes.Value

    ' Validate the length of the note
    If Len(noteText) > 200 Then
        MsgBox "The note exceeds the maximum allowed length of 200 characters.", vbExclamation, "Character Limit Reached"
        Exit Sub
    End If

    ' Reference the Slip-Change sheet
    On Error GoTo ErrorHandler
    Set sh = ThisWorkbook.Sheets("Slip-Change")
    iRow = WorksheetFunction.CountA(sh.Range("A:A")) + 1

    ' Write data to the Slip-Change sheet
    With sh
        .Cells(iRow, 1).Value = iRow - 1                   ' Save Number
        .Cells(iRow, 2).Value = Me.cmbNoteType.Value       ' Note Type
        .Cells(iRow, 3).Value = slipNumber                 ' Slip Number
        .Cells(iRow, 4).Value = Me.cmbSubject.Value        ' Subject
        .Cells(iRow, 5).Value = Me.cmbSpecialist.Value     ' Specialist
        .Cells(iRow, 6).Value = Now()                      ' Timestamp
        .Cells(iRow, 7).Value = noteText                   ' Notes
    End With

    ' Display confirmation message
    MsgBox "Data has been successfully submitted for Slip Number " & slipNumber & ".", vbInformation, "Submission Confirmed"

    ' Reset the form for further use
    Call cmdReset_Click

    Exit Sub ' Exit the procedure

ErrorHandler:
    MsgBox "An error occurred while submitting the data. Please try again.", vbCritical, "Error"
End Sub

' Validate the slip number (dummy function, replace with actual logic)
Private Function IsValidSlipNumber(slipNumber As String) As Boolean
    IsValidSlipNumber = Len(slipNumber) > 0 ' Basic validation: not empty
End Function

Private Sub UserForm_Initialize()
    ' Initialize the form with default values
    Call cmdReset_Click
End Sub

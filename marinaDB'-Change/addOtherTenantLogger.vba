Option Explicit

Dim otherSelectionCount As Integer ' Tracks how many times "Other" is selected

' Hide all controls except notes
Private Sub HideControls()
    lblSlipNumber.Visible = False
    txtSlipNumber.Visible = False
    lblNoteType.Visible = False
    cmbNoteType.Visible = False
    lblSpecialist.Visible = False
    cmbSpecialist.Visible = False
    lblSubject.Visible = False
    cmbSubject.Visible = False

    ' Show controls related to "Other"
    txtNotes.Visible = True
    lblOtherNote.Visible = True
    lblOtherNote1.Visible = True
    cmdOtherNoteSubmit.Visible = True

    ' Gray out txtSlipNumber (optional, if not hidden)
    txtSlipNumber.BackColor = RGB(211, 211, 211) ' Light gray
End Sub

' Reset controls to default visibility
Private Sub ResetControls()
    lblSlipNumber.Visible = True
    txtSlipNumber.Visible = True
    txtSlipNumber.BackColor = RGB(255, 255, 255) ' Restore white background
    lblNoteType.Visible = True
    cmbNoteType.Visible = True
    lblSpecialist.Visible = True
    cmbSpecialist.Visible = True
    lblSubject.Visible = True
    cmbSubject.Visible = True

    ' Reset additional controls
    txtNotes.Visible = True
    lblOtherNote.Visible = False
    lblOtherNote1.Visible = False
    cmdOtherNoteSubmit.Visible = False
End Sub

' Subject selection logic
Private Sub cmbSubject_Change()
    If cmbSubject.Value = "Other" Then
        otherSelectionCount = otherSelectionCount + 1 ' Increment "Other" selection count

        If otherSelectionCount = 1 Then
            MsgBox "You selected 'Other'. Please provide additional details in the Notes field.", vbInformation, "Additional Details Needed"
        ElseIf otherSelectionCount = 2 Then
            MsgBox "Entering advanced mode for 'Other'. Hiding unrelated fields.", vbExclamation, "Advanced Mode"
            HideControls
        End If
    Else
        ' Reset if "Other" is deselected
        otherSelectionCount = 0
        ResetControls
    End If
End Sub

' Reset the form to its default state
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

        ' Populate the Specialist combo box
        .cmbSpecialist.AddItem "Jason"
        .cmbSpecialist.AddItem "Andrew"
        .cmbSpecialist.AddItem "Chris"
        .cmbSpecialist.AddItem "Ops.Sup."
        .cmbSpecialist.AddItem "Ops.Manager"

        ' Populate the Subject dropdown
        .cmbSubject.AddItem "Notice of Termination"
        .cmbSubject.AddItem "New Tenant"
        .cmbSubject.AddItem "Overnight Paid"
        .cmbSubject.AddItem "Slip Change"
        .cmbSubject.AddItem "Other" ' Includes "Other"

        ' Setup the ListBox
        .lstTenantNotes.ColumnCount = 6
        .lstTenantNotes.ColumnHeads = True
        .lstTenantNotes.ColumnWidths = "30,45,30,60,60,15"

        ' Set RowSource dynamically
        If iRow > 1 Then
            .lstTenantNotes.RowSource = "TenantLogger!A2:F" & iRow
        Else
            .lstTenantNotes.RowSource = "TenantLogger!A2:F2"
        End If

        ' Reset visibility
        ResetControls
        otherSelectionCount = 0 ' Reset "Other" selection counter
    End With
End Sub

' Submit button logic for "Other" advanced mode
Private Sub cmdOtherNoteSubmit_Click()
    Dim sh As Worksheet
    Dim iRow As Long

    On Error GoTo ErrorHandler
    Set sh = ThisWorkbook.Sheets("TenantLogger")
    iRow = WorksheetFunction.CountA(sh.Range("A:A")) + 1

    ' Write only the note and subject for "Other"
    With sh
        .Cells(iRow, 1).Value = iRow - 1 ' Save Number
        .Cells(iRow, 4).Value = "Other" ' Subject
        .Cells(iRow, 7).Value = Me.txtNotes.Value ' Notes
    End With

    ' Confirmation
    MsgBox "Your note has been saved.", vbInformation, "Submission Successful"
    cmdReset_Click ' Reset the form

    Exit Sub
ErrorHandler:
    MsgBox "An error occurred while saving the note.", vbCritical, "Error"
End Sub

Private Sub UserForm_Initialize()
    cmdReset_Click ' Initialize the form
End Sub

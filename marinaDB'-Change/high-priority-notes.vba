Option Explicit
'This setup will allow you to mark notes as high priority, visually distinguishing them in red in the list box for easy identification
Private Sub SubmitTenantData()
' Updated Code for SubmitTenantData with High Priority Prompt
    Dim sh As Worksheet
    Dim iRow As Long
    Dim slipNumber As String
    Dim noteText As String
    Dim isHighPriority As Boolean
    Dim userChoice As VbMsgBoxResult

    ' Get the slip number from the form
    slipNumber = Me.txtSlipNumber.Value
    
    ' Validate the slip number
    If Not IsValidSlipNumber(slipNumber) Then
        Exit Sub ' If validation fails, exit the subroutine
    End If
    
    ' Get the note text from the form
    noteText = Me.txtNotes.Value
    
    ' Validate the length of the note
    If Len(noteText) > 200 Then
        MsgBox "The note exceeds the maximum allowed length of 200 characters.", vbExclamation, "Character Limit Reached"
        Exit Sub ' Exit the subroutine if the note is too long
    End If
    
    ' Prompt user to mark as high-priority
    userChoice = MsgBox("Would you like to mark this as a high priority?", vbYesNo + vbQuestion, "High Priority")
    
    ' Set isHighPriority based on user's choice
    isHighPriority = (userChoice = vbYes)
    
    On Error GoTo ErrorHandler ' Enable error handling
    
    Set sh = ThisWorkbook.Sheets("TenantLogger")
    iRow = [CountA(TenantLogger!A:A)] + 1
    
    ' Write data to the worksheet
    With sh
        .Cells(iRow, 1).Value = iRow - 1                                           ' Save Number
        .Cells(iRow, 2).Value = Me.cmbNoteType                                     ' Note Type
        .Cells(iRow, 3).Value = slipNumber                                         ' Slip Number
        .Cells(iRow, 4).Value = Me.cmbSubject.Value                                ' Subject
        .Cells(iRow, 5).Value = Me.cmbSpecialist.Value                             ' Specialist
        .Cells(iRow, 6).Value = Now()                                              ' Timestamp
        .Cells(iRow, 7).Value = noteText                                           ' Notes
        .Cells(iRow, 8).Value = IIf(isHighPriority, "High Priority", "")           ' High Priority indicator
    End With
    
    ' Display confirmation message
    MsgBox "Data has been successfully submitted for Slip Number " & slipNumber & ".", vbInformation, "Submission Confirmed"
    
    ' Reload the list box to reflect new entry and apply color formatting
    LoadTenantNotesWithColors
    
    ' Optionally, unload the form after submission
    Unload Me

    ' Make Excel visible again if needed
    Application.Visible = True
    
    Exit Sub ' Exit to avoid triggering the error handler after successful completion

ErrorHandler:
    MsgBox "An error occurred while submitting the data. Please check the Slip Number and try again.", _
           vbCritical, "Error"
End Sub

Private Sub LoadTenantNotesWithColors()
' Create LoadTenantNotesWithColors to Apply Color in List Box
    Dim iRow As Long
    Dim ws As Worksheet
    Dim i As Long

    Set ws = ThisWorkbook.Sheets("TenantLogger")
    iRow = WorksheetFunction.CountA(ws.Range("A:A"))

    ' Clear and reload the list box
    With Me.lstTenantNotes
        .Clear
        .ColumnCount = 7 ' Increase to include priority information
        .ColumnWidths = "30,45,30,60,60,60,0" ' Hide last column (priority indicator)
    End With

    ' Populate list box and apply colors based on priority
    For i = 2 To iRow
        With Me.lstTenantNotes
            .AddItem ws.Cells(i, 1).Value  ' Save Number
            .List(.ListCount - 1, 1) = ws.Cells(i, 2).Value  ' Note Type
            .List(.ListCount - 1, 2) = ws.Cells(i, 3).Value  ' Slip Number
            .List(.ListCount - 1, 3) = ws.Cells(i, 4).Value  ' Subject
            .List(.ListCount - 1, 4) = ws.Cells(i, 5).Value  ' Specialist
            .List(.ListCount - 1, 5) = ws.Cells(i, 6).Text   ' Timestamp
            .List(.ListCount - 1, 6) = ws.Cells(i, 8).Value  ' Priority indicator

            ' Apply color if marked as high priority
            If ws.Cells(i, 8).Value = "High Priority" Then
                .List(.ListCount - 1).ForeColor = RGB(255, 0, 0) ' Red text
            End If
        End With
    Next i
End Sub

' Modify UserForm_Initialize to Call LoadTenantNotesWithColors
Private Sub UserForm_Initialize()
    ' Populate dropdowns and reset fields as needed
    
    ' Load and color tenant notes
    LoadTenantNotesWithColors
End Sub

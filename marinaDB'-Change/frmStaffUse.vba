Option Explicit
' This is the process to add multiple slips for follow up or overnight
' This form needs to be seperate from Customer Service use forms
' This form will be used by Waterfront Operations Staff
Private Sub cmdBetaTutarial_Click()
    mainTutorial.Show
End Sub

Private Sub cmdClear_Click()
    ClearAllCheckboxes
End Sub

Private Sub cmdClearAllCheckboxes_Click()
    ClearAllCheckboxes
End Sub

Private Sub ClearAllCheckboxes()
    Dim i As Integer
    Dim chkBoxName As String
    
    ' Loop through checkboxes 1 to 80 and reset them
    For i = 1 To 80
        chkBoxName = "Checkbox" & i
        If Not Me.Controls(chkBoxName) Is Nothing Then
            Me.Controls(chkBoxName).Value = False
            Me.Controls(chkBoxName).BackColor = &H8000000F ' Default system color
        End If
    Next i
End Sub

Private Sub cmdDataRetTool_Click()
    UserForm1.Show
End Sub

Private Sub cmdMarinaTenantLogger_Click()
    frmMarinaTenantLogger.Show
End Sub

Private Sub cmdUpdateForm_Click()
    UserForm_Initialize
End Sub

Private Sub cmdUpdateTestSheet_Click()
    AddOvernightOrFollowUp
End Sub

' This new subroutine prompts the user to select Overnight or Follow-Up and updates accordingly
Private Sub AddOvernightOrFollowUp()
    Dim i As Integer
    Dim chkBoxName As String
    Dim selectedSlipID As Integer
    Dim userChoice As VbMsgBoxResult
    Dim ws As Worksheet
    
    ' Set reference to the worksheet where statuses are stored
    Set ws = ThisWorkbook.Sheets("TestSheet")
    
    ' Prompt the user for status choice: Overnight or Follow-Up
    userChoice = MsgBox("Would you like to mark selected slips as OVERNIGHT (Yes) or FOLLOW-UP (No)?", _
                        vbYesNoCancel + vbQuestion, "Select Status")

    ' Exit if the user cancels
    If userChoice = vbCancel Then Exit Sub
    
    ' Loop through checkboxes to find the selected ones
    For i = 1 To 80
        chkBoxName = "Checkbox" & i
        If Me.Controls(chkBoxName).Value = True Then
            selectedSlipID = i
            
            ' Update status in TestSheet based on user's choice
            Select Case userChoice
                Case vbYes
                    ws.Cells(selectedSlipID, 1).Value = "Overnight"
                Case vbNo
                    ws.Cells(selectedSlipID, 1).Value = "Follow-Up"
            End Select
        End If
    Next i
    
    ' Confirmation message after completion
    MsgBox "Selected slips have been updated as " & IIf(userChoice = vbYes, "Overnight", "Follow-Up") & ".", vbInformation
    
    ' Refresh checkbox colors based on updated TestSheet values
    ApplyCheckboxColors
End Sub

Private Sub ApplyCheckboxColors()
    Dim ws As Worksheet
    Dim i As Integer
    Dim chkBoxName As String
    Dim cellValue As String
    
    ' Reference to the TestSheet
    Set ws = ThisWorkbook.Sheets("TestSheet")
    
    For i = 1 To 80
        chkBoxName = "Checkbox" & i
        If Not Me.Controls(chkBoxName) Is Nothing Then
            cellValue = Trim(ws.Cells(i, 1).Value)
            
            ' Set checkbox color and state based on cell status
            Select Case True
                Case cellValue = "Open_Slip"
                    Me.Controls(chkBoxName).Value = False
                    Me.Controls(chkBoxName).BackColor = RGB(0, 255, 0) ' Green for Open_Slip
                Case cellValue = "COMMERCIAL"
                    Me.Controls(chkBoxName).Value = True
                    Me.Controls(chkBoxName).BackColor = RGB(192, 192, 192) ' Grey for COMMERCIAL
                Case cellValue = "Overnight"
                    Me.Controls(chkBoxName).Value = True
                    Me.Controls(chkBoxName).BackColor = RGB(255, 255, 0) ' Yellow for Overnight
                Case cellValue = "Follow-Up"
                    Me.Controls(chkBoxName).Value = True
                    Me.Controls(chkBoxName).BackColor = RGB(0, 0, 255) ' Blue for Follow-Up
                Case InStr(cellValue, ",") > 0 ' Name format detected (e.g., "Doe, Jane")
                    Me.Controls(chkBoxName).Value = True
                    Me.Controls(chkBoxName).BackColor = RGB(255, 0, 0) ' Red for names
                Case Else
                    Me.Controls(chkBoxName).Value = False
                    Me.Controls(chkBoxName).BackColor = &H8000000F ' Default color
            End Select
        End If
    Next i
End Sub

Private Sub UserForm_Initialize()
    Dim ws As Worksheet
    Dim i As Integer
    Dim chkBoxName As String
    Dim cellValue As String
    
    ' Set reference to TestSheet for initial checkbox setup
    Set ws = Worksheets("TestSheet")
    
    ' Loop through rows to set up checkboxes based on initial data in TestSheet
    For i = 1 To 80
        chkBoxName = "Checkbox" & i
        If Not Me.Controls(chkBoxName) Is Nothing Then
            cellValue = Trim(ws.Cells(i, 1).Value)
            
            ' Set initial color and state for each checkbox
            Select Case True
                Case cellValue = "Open_Slip"
                    Me.Controls(chkBoxName).Value = False
                    Me.Controls(chkBoxName).BackColor = RGB(0, 255, 0) ' Green for Open_Slip
                Case cellValue = "COMMERCIAL"
                    Me.Controls(chkBoxName).Value = True
                    Me.Controls(chkBoxName).BackColor = RGB(192, 192, 192) ' Grey for COMMERCIAL
                Case cellValue = "Overnight"
                    Me.Controls(chkBoxName).Value = True
                    Me.Controls(chkBoxName).BackColor = RGB(255, 255, 0) ' Yellow for Overnight
                Case cellValue = "Follow-Up"
                    Me.Controls(chkBoxName).Value = True
                    Me.Controls(chkBoxName).BackColor = RGB(0, 0, 255) ' Blue for Follow-Up
                Case InStr(cellValue, ",") > 0
                    Me.Controls(chkBoxName).Value = True
                    Me.Controls(chkBoxName).BackColor = RGB(255, 0, 0) ' Red for names
                Case Else
                    Me.Controls(chkBoxName).Value = False
                    Me.Controls(chkBoxName).BackColor = RGB(0, 0, 255) ' Default Blue for unknown
            End Select
        End If
    Next i
End Sub

# Updated Code for `frmOtherNotes`

## Authentication process to be tested

```vba
Option Explicit

' Shared Sub to handle visibility and PIN pad launch
Private Sub CheckOtherCondition()
    If cmbSubject.Value = "Other" And cmbNoteType.Value = "Other" Then
        ' Both conditions are met
        MsgBox "Both Subject and Note Type are set to 'Other'. Enter your PIN to continue.", vbInformation, "Other Notes"
        
        ' Launch PIN pad authentication
        frmSpecialistLoggerPinPad.Show
        ' May need to debug here - uses not hide controls but `unload me` meaning the frmOtherNotes - if authentication is correct then show form frmOtherNotes 
        
        ' Hide irrelevant controls after authentication
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

    ' Change background color to default for Submit and Read Notes buttons
    cmdSubmit.BackColor = RGB(255, 255, 255) ' Default white
    cmdReadNotes.BackColor = RGB(255, 255, 255) ' Default white

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
```

---

## Steps for Testing

### Setup Forms:
1. Ensure that `frmOtherNotes` and `frmSpecialistLoggerPinPad` are correctly designed with the listed controls.
2. Place the Class Module (`ColorCycler`) in the project.

---

### Test the "Other" Condition:
1. Set both `cmbSubject` and `cmbNoteType` to "Other".
2. Verify that:
   - The PIN pad form (`frmSpecialistLoggerPinPad`) launches.
   - Upon successful authentication, the controls in `frmOtherNotes` are hidden, except for the required fields (`txtNotes`, `lblOtherNote`, etc.).

---

### Reset Functionality:
1. Change either dropdown to a value other than "Other".
2. Verify that all controls reset to their default state.

---

### PIN Pad Authentication:
1. Test the PIN pad form to ensure it works as expected:
   - **Correct PIN** unlocks the controls.
   - **Incorrect PIN** denies access.

Private Sub cmbLogType_Change()
    ' Show/Hide controls based on selected log type
    HideAllControls

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
            lblNotes.Visible = True
            txtNotes.Visible = True
        
        Case "Anomalies", "Reconcile"
            lblNotes.Visible = True
            txtNotes.Visible = True
    End Select
End Sub

Private Sub HideAllControls()
    ' Hide all form controls (fields specific to each log type)
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
    lblNotes.Visible = False
    txtNotes.Visible = False
End Sub

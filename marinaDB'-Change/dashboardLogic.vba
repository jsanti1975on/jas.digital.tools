' Dashboard Creation Start Point
Sub ToggleShapeOverlay()
    Dim overlayShp As Shape
    Dim mainShp As Shape
    Dim delay_ms As Double

    ' Set the shape names
    Set overlayShp = ActiveSheet.Shapes("ShapeOverlay1")
    Set mainShp = ActiveSheet.Shapes("Shape1")

    ' Set the delay in milliseconds (e.g., 500 ms for half a second)
    delay_ms = 500

    ' Show the main shape and hide the overlay
    mainShp.Visible = msoTrue
    overlayShp.Visible = msoFalse

    ' Pause briefly before showing the message box
    Pause delay_ms

    ' Display message box after the pause
    MsgBox "Shape1 has been selected!", vbInformation, "Action Triggered"

    ' Reset to default visibility: overlay visible, main shape hidden
    overlayShp.Visible = msoTrue
    mainShp.Visible = msoFalse
End Sub

' Pause subroutine for delay
Sub Pause(duration_ms As Double)
    Dim start_time As Double
    start_time = Timer
    Do
        DoEvents ' Allows Excel to process other tasks
    Loop Until (Timer - start_time) * 1000 >= duration_ms
End Sub

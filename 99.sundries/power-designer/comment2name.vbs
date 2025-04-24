Option Explicit
ValidationMode = True
InteractiveMode = im_Batch

Dim mdl ' the current model

' Get the current active model
Set mdl = ActiveModel
If (mdl Is Nothing) Then
    MsgBox "There is no current Model "
Elseif Not mdl.IsKindOf(PdPDM.cls_Model) Then
    MsgBox "The current model is Not an Physical Data model. "
Else
    ProcessFolder mdl
End If

Private Sub ProcessFolder(folder)
    On Error Resume Next
    Dim Tab ' running table
    For Each Tab In folder.tables
        If Not tab.isShortcut Then
            tab.name = tab.comment
            Dim col ' running column
            For Each col In tab.columns
                If col.comment = "" Then
                Else
                    col.name = col.comment
                End If
                Next
            End If
            Next

            Dim view ' running view
            For Each view In folder.Views
                If Not view.isShortcut Then
                    view.name = view.comment
                End If
                Next

                ' go into the Sub-packages
                Dim f ' running folder
                For Each f In folder.Packages
                    If Not f.IsShortcut Then
                        ProcessFolder f
                    End If
                    Next
End Sub

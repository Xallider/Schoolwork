<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Form1
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.lblpenny = New System.Windows.Forms.Label()
        Me.btncalc = New System.Windows.Forms.Button()
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.AllowDrop = True
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(12, 22)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(251, 26)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "Start with 1 penny and double it every day, " & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "then at the end of a month of 30 da" &
    "ys you will have:"
        '
        'lblpenny
        '
        Me.lblpenny.AutoSize = True
        Me.lblpenny.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.lblpenny.Location = New System.Drawing.Point(269, 33)
        Me.lblpenny.MinimumSize = New System.Drawing.Size(100, 0)
        Me.lblpenny.Name = "lblpenny"
        Me.lblpenny.Size = New System.Drawing.Size(100, 15)
        Me.lblpenny.TabIndex = 1
        '
        'btncalc
        '
        Me.btncalc.Location = New System.Drawing.Point(269, 59)
        Me.btncalc.Name = "btncalc"
        Me.btncalc.Size = New System.Drawing.Size(75, 23)
        Me.btncalc.TabIndex = 2
        Me.btncalc.Text = "Calculate"
        Me.btncalc.UseVisualStyleBackColor = True
        '
        'Form1
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(384, 94)
        Me.Controls.Add(Me.btncalc)
        Me.Controls.Add(Me.lblpenny)
        Me.Controls.Add(Me.Label1)
        Me.Name = "Form1"
        Me.Text = "hw5p2"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents Label1 As Label
    Friend WithEvents lblpenny As Label
    Friend WithEvents btncalc As Button
End Class

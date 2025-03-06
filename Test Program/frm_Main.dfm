object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'frmMain'
  ClientHeight = 446
  ClientWidth = 561
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 121
    Height = 25
    Caption = 'Speech (All)'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 39
    Width = 121
    Height = 25
    Caption = 'Read Memory Bank A'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 70
    Width = 121
    Height = 25
    Caption = 'Write Memory B-01'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 101
    Width = 121
    Height = 25
    Caption = 'Clear Memory B-01'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 8
    Top = 132
    Width = 121
    Height = 25
    Caption = 'Read Memory A-01'
    TabOrder = 4
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 135
    Top = 8
    Width = 121
    Height = 25
    Caption = 'Pre Amp On'
    TabOrder = 5
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 8
    Top = 163
    Width = 121
    Height = 25
    Caption = 'Read Memory Banks'
    TabOrder = 6
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 135
    Top = 39
    Width = 121
    Height = 25
    Caption = 'Pre Amp Off'
    TabOrder = 7
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 135
    Top = 70
    Width = 121
    Height = 25
    Caption = 'NB On'
    TabOrder = 8
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 135
    Top = 101
    Width = 121
    Height = 25
    Caption = 'NB Off'
    TabOrder = 9
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 135
    Top = 132
    Width = 121
    Height = 25
    Caption = 'NR On'
    TabOrder = 10
    OnClick = Button11Click
  end
  object Button12: TButton
    Left = 135
    Top = 163
    Width = 121
    Height = 25
    Caption = 'NR Off'
    TabOrder = 11
    OnClick = Button12Click
  end
  object Button13: TButton
    Left = 262
    Top = 8
    Width = 121
    Height = 25
    Caption = 'AutoNotch On'
    TabOrder = 12
    OnClick = Button13Click
  end
  object Button14: TButton
    Left = 262
    Top = 39
    Width = 121
    Height = 25
    Caption = 'AutoNotch Off'
    TabOrder = 13
    OnClick = Button14Click
  end
  object Button15: TButton
    Left = 262
    Top = 70
    Width = 121
    Height = 25
    Caption = 'ManualNotch On'
    TabOrder = 14
    OnClick = Button15Click
  end
  object Button16: TButton
    Left = 262
    Top = 101
    Width = 121
    Height = 25
    Caption = 'ManualNotch Off'
    TabOrder = 15
    OnClick = Button16Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 328
    Width = 561
    Height = 118
    Align = alBottom
    Lines.Strings = (
      'Memo1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8')
    ScrollBars = ssVertical
    TabOrder = 16
    OnDblClick = Memo1DblClick
  end
  object Button17: TButton
    Left = 0
    Top = 297
    Width = 75
    Height = 25
    Caption = 'Read Signal'
    TabOrder = 17
    OnClick = Button17Click
  end
end

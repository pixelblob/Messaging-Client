object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Instant Messenger'
  ClientHeight = 299
  ClientWidth = 665
  Color = clGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 0
    Top = 272
    Width = 665
    Height = 27
    Align = alBottom
    TabOrder = 0
    TextHint = 'Message'
    ExplicitWidth = 433
  end
  object Button1: TButton
    Left = 616
    Top = 0
    Width = 49
    Height = 272
    Align = alRight
    Caption = 'Send'
    Default = True
    TabOrder = 1
    OnClick = Button1Click
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 616
    Height = 272
    Align = alClient
    Color = clGrayText
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 200
    OnTimer = Timer1Timer
    Left = 632
    Top = 8
  end
end

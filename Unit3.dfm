object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Instant Messenger'
  ClientHeight = 512
  ClientWidth = 998
  Color = clGray
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 998
    Height = 512
    Align = alClient
    ExplicitWidth = 448
    ExplicitHeight = 921
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 32
    OnTimer = Timer1Timer
    Left = 632
    Top = 8
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 32
    OnTimer = Timer2Timer
    Left = 576
    Top = 192
  end
  object deleteInactive: TTimer
    Left = 784
    Top = 432
  end
  object paintCanvas: TTimer
    Interval = 1
    OnTimer = paintCanvasTimer
    Left = 504
    Top = 416
  end
end

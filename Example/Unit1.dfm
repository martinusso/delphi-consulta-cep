object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 201
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonConsultarCEP: TButton
    Left = 8
    Top = 48
    Width = 89
    Height = 25
    Caption = 'Consultar CEP'
    TabOrder = 1
    OnClick = ButtonConsultarCEPClick
  end
  object Memo1: TMemo
    Left = 136
    Top = 16
    Width = 303
    Height = 169
    TabOrder = 2
  end
  object CEP: TEdit
    Left = 9
    Top = 21
    Width = 88
    Height = 21
    TabOrder = 0
  end
end

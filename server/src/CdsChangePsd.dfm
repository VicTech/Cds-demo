object FormChgPsd: TFormChgPsd
  Left = 647
  Top = 284
  Width = 323
  Height = 260
  BorderIcons = [biSystemMenu]
  Caption = #23494#30721#20462#25913
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object m_LabelUserNum: TLabel
    Left = 48
    Top = 40
    Width = 65
    Height = 13
    AutoSize = False
    Caption = #24403#21069#29992#25143':'
  end
  object m_LableOldPsd: TLabel
    Left = 48
    Top = 68
    Width = 65
    Height = 13
    AutoSize = False
    Caption = #26087#30340#23494#30721':'
  end
  object m_LabelNewPsd: TLabel
    Left = 48
    Top = 96
    Width = 65
    Height = 13
    AutoSize = False
    Caption = #26032#30340#23494#30721':'
  end
  object m_LablePsdConfirm: TLabel
    Left = 48
    Top = 128
    Width = 65
    Height = 13
    AutoSize = False
    Caption = #23494#30721#30830#35748':'
  end
  object m_LbUserNum: TsLabel
    Left = 136
    Top = 32
    Width = 153
    Height = 21
    AutoSize = False
    Caption = '1234'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 5786691
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
  end
  object m_EditOldPsd: TsEdit
    Left = 120
    Top = 64
    Width = 121
    Height = 21
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
  end
  object m_EditNewPsd: TsEdit
    Left = 120
    Top = 96
    Width = 121
    Height = 21
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
  end
  object m_EditPsdConfirm: TsEdit
    Left = 120
    Top = 128
    Width = 121
    Height = 21
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
  end
  object m_BtnConfirm: TsBitBtn
    Left = 64
    Top = 176
    Width = 57
    Height = 25
    Caption = #30830#23450
    TabOrder = 3
    OnClick = m_BtnConfirmClick
    SkinData.SkinSection = 'BUTTON'
  end
  object m_BtnCancel: TsBitBtn
    Left = 200
    Top = 176
    Width = 59
    Height = 25
    Caption = #21462#28040
    TabOrder = 4
    OnClick = m_BtnCancelClick
    SkinData.SkinSection = 'BUTTON'
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 192
    Top = 24
  end
end

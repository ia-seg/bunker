object frmRelatorio: TfrmRelatorio
  Left = 0
  Top = 0
  Caption = 'Recursos no Bunker'
  ClientHeight = 681
  ClientWidth = 792
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RLReport1: TRLReport
    Left = 0
    Top = 0
    Width = 794
    Height = 1123
    DataSource = frmPrincipal.DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object RLBand1: TRLBand
      Left = 38
      Top = 73
      Width = 718
      Height = 32
      BandType = btColumnHeader
      object RLLabel_Recurso: TRLLabel
        Left = 16
        Top = 13
        Width = 69
        Height = 19
        Caption = 'Recurso'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel_Quantidade: TRLLabel
        Left = 488
        Top = 13
        Width = 92
        Height = 19
        Caption = 'Quantidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel_Validade: TRLLabel
        Left = 616
        Top = 13
        Width = 70
        Height = 19
        Caption = 'Validade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 35
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      object RLLabel1: TRLLabel
        Left = 296
        Top = 0
        Width = 78
        Height = 28
        Caption = 'Bunker'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Under Authority'
        Font.Style = []
        ParentFont = False
      end
    end
    object RLBand3: TRLBand
      Left = 38
      Top = 105
      Width = 718
      Height = 32
      object RLDBText1: TRLDBText
        Left = 16
        Top = 13
        Width = 52
        Height = 16
        DataField = 'Recurso'
        DataSource = frmPrincipal.DataSource1
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 499
        Top = 13
        Width = 70
        Height = 16
        Alignment = taCenter
        DataField = 'Quantidade'
        DataSource = frmPrincipal.DataSource1
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 623
        Top = 13
        Width = 54
        Height = 16
        Alignment = taCenter
        DataField = 'Validade'
        DataSource = frmPrincipal.DataSource1
        Text = ''
      end
    end
    object RLBand4: TRLBand
      Left = 38
      Top = 137
      Width = 718
      Height = 32
      BandType = btColumnFooter
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = False
      object RLLabel2: TRLLabel
        Left = 580
        Top = 13
        Width = 114
        Height = 14
        Caption = 'by Rayel G. C. Barroso'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 133
        Top = 13
        Width = 39
        Height = 16
        Text = ''
      end
      object RLLabel3: TRLLabel
        Left = 16
        Top = 13
        Width = 121
        Height = 16
        Caption = 'Data de Impress'#227'o: '
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 405
        Top = 13
        Width = 36
        Height = 16
        AutoSize = False
        Info = itLastPageNumber
        Text = ''
      end
      object RLLabel4: TRLLabel
        Left = 312
        Top = 13
        Width = 44
        Height = 16
        Caption = 'P'#225'gina'
      end
      object RLSystemInfo3: TRLSystemInfo
        Left = 360
        Top = 13
        Width = 21
        Height = 16
        AutoSize = False
        Info = itPageNumber
        Text = ''
      end
      object RLLabel5: TRLLabel
        Left = 376
        Top = 13
        Width = 18
        Height = 16
        AutoSize = False
        Caption = 'de'
      end
    end
  end
end

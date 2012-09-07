 {-------------------------------------------------)
 {--�ļ���:        CdsNetSet.pas                   }
 {--����:          �������ý���                    }
 {--�汾��:        1.0                             }
 {--��������:      2012-8-13                       }
 {--IDE ����:      D7                              }
 {--�ַ����룺     UTF-8                           }
 {--����:          VicTech                          }
 {--��Ȩ���У�                                     }
 {--�汾�޸���ʷ��                                 }
 {    2012-8-13 VicTech �����ļ�                    }
 {-------------------------------------------------}
unit CdsNetSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sSkinManager, StdCtrls, Buttons, sBitBtn, sComboBox, sLabel,
  sEdit, sCheckBox, ExtCtrls, sPanel, ComCtrls, sTabControl, sPageControl,
  sSpinEdit, IniFiles;

type
  TFormNetSet = class(TForm)
    sSkinManager1: TsSkinManager;
    sPanel1: TsPanel;
    m_BtnCofirm: TsBitBtn;
    m_BtnCancel: TsBitBtn;
    m_BtnApp: TsBitBtn;
    sPm_PageNetSet: TsPageControl;
    m_SheetLocal: TsTabSheet;
    m_SheetHIS: TsTabSheet;
    sLabel1: TsLabel;
    m_SpEditDPort: TsDecimalSpinEdit;
    sLabel3: TsLabel;
    m_SpEditIPort: TsDecimalSpinEdit;
    sLabel4: TsLabel;
    m_SpEditCPort: TsDecimalSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure m_BtnAppClick(Sender: TObject);
    procedure m_SpEditDPortChange(Sender: TObject);
    procedure m_SpEditIPortChange(Sender: TObject);
    procedure m_SpEditCPortChange(Sender: TObject);
    procedure m_BtnCofirmClick(Sender: TObject);
    procedure m_BtnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormNetSet: TFormNetSet;

implementation
   uses
   CdsCommon;
{$R *.dfm}


{--------------------------------------------
������:
��������:     ���崴��
����������
��������:      2012-8-13
----------------------------------------------}
procedure TFormNetSet.FormCreate(Sender: TObject);
begin
  m_SpEditDPort.Text :=inttostr(g_CDSServerInfo.m_DataServerPort);
  m_SpEditIPort.Text := inttostr(g_CDSServerInfo.m_IntfServerPort);
  m_SpEditCPort.Text := inttostr(g_CDSServerInfo.m_CommunicateServerPort);
end;


{--------------------------------------------
������:
��������:     Ӧ�ð�ť����
����������
��������:      2012-8-13
----------------------------------------------}
procedure TFormNetSet.m_BtnAppClick(Sender: TObject);
var
  m_IniFile: Tinifile;
begin
  if (m_SpEditDPort.text <> '') and (m_SpEditIPort.text <> '') and (m_SpEditCPort.text <> '') then
  begin
    m_IniFile := Tinifile.Create(ExtractFilePath(Application.ExeName) + '\Server.ini');
    try
      m_IniFile.Writestring('ServerPort', 'DataPort', trim(m_SpEditDPort.text));
      m_IniFile.Writestring('ServerPort', 'IntfPort', trim(m_SpEditIPort.text));
      m_IniFile.Writestring('ServerPort', 'Communict', trim(m_SpEditCPort.text));

    finally
      m_IniFile.Free;
    end;

    m_BtnApp.enabled := false;

  end
  else
    MessageBox(Handle, '�˿ڲ���Ϊ�գ�', '����', MB_OK + MB_ICONWARNING);
end;



{--------------------------------------------
������:
��������:     ���ݸı���Ϣ
����������
��������:      2012-8-13
----------------------------------------------}
procedure TFormNetSet.m_SpEditDPortChange(Sender: TObject);
begin
  m_BtnApp.enabled := true;
end;


{--------------------------------------------
������:
��������:     ���ݸı���Ϣ
����������
��������:      2012-8-13
----------------------------------------------}

procedure TFormNetSet.m_SpEditIPortChange(Sender: TObject);
begin
  m_BtnApp.enabled := true;
end;

{--------------------------------------------
������:
��������:     ���ݸı���Ϣ
����������
��������:      2012-8-13
----------------------------------------------}

procedure TFormNetSet.m_SpEditCPortChange(Sender: TObject);
begin
  m_BtnApp.enabled := true;
end;


{--------------------------------------------
������:
��������:     ȷ�ϼ�����
����������
��������:      2012-8-13
----------------------------------------------}
procedure TFormNetSet.m_BtnCofirmClick(Sender: TObject);
var
  m_IniFile: Tinifile;
begin
  if m_BtnApp.enabled then
  begin
    if (m_SpEditDPort.text <> '') and (m_SpEditIPort.text <> '') and (m_SpEditCPort.text <> '') then
    begin
      m_IniFile := Tinifile.Create(ExtractFilePath(Application.ExeName) + '\Server.ini');
      try
        m_IniFile.Writestring('ServerPort', 'DataPort', trim(m_SpEditDPort.text));
        m_IniFile.Writestring('ServerPort', 'IntfPort', trim(m_SpEditIPort.text));
        m_IniFile.Writestring('ServerPort', 'Communict', trim(m_SpEditCPort.text));

      finally
        m_IniFile.Free;
      end;

      m_BtnApp.enabled := false;

    end
    else
      MessageBox(Handle, '�˿ڲ���Ϊ�գ�', '����', MB_OK + MB_ICONWARNING);
  end;

  close;
end;

{--------------------------------------------
������:
��������:     ���ڹر�
����������
��������:      2012-8-13
----------------------------------------------}
procedure TFormNetSet.m_BtnCancelClick(Sender: TObject);
begin
close;
end;

end.


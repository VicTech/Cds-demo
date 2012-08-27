 {-------------------------------------------------)
 {--文件名:        CdsNetSet.pas                   }
 {--描述:          网络配置界面                    }
 {--版本号:        1.0                             }
 {--创建日期:      2012-8-13                       }
 {--IDE 环境:      D7                              }
 {--字符编码：     UTF-8                           }
 {--作者:          VicTech                          }
 {--版权所有：                                     }
 {--版本修改历史：                                 }
 {    2012-8-13 VicTech 创建文件                    }
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
过程名:
功能描述:     窗体创建
参数描述：
创建日期:      2012-8-13
----------------------------------------------}
procedure TFormNetSet.FormCreate(Sender: TObject);
begin
  m_SpEditDPort.Text :=inttostr(g_CDSServerInfo.m_DataServerPort);
  m_SpEditIPort.Text := inttostr(g_CDSServerInfo.m_IntfServerPort);
  m_SpEditCPort.Text := inttostr(g_CDSServerInfo.m_CommunicateServerPort);
end;


{--------------------------------------------
过程名:
功能描述:     应用按钮按下
参数描述：
创建日期:      2012-8-13
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
    MessageBox(Handle, '端口不能为空！', '提醒', MB_OK + MB_ICONWARNING);
end;



{--------------------------------------------
过程名:
功能描述:     数据改变消息
参数描述：
创建日期:      2012-8-13
----------------------------------------------}
procedure TFormNetSet.m_SpEditDPortChange(Sender: TObject);
begin
  m_BtnApp.enabled := true;
end;


{--------------------------------------------
过程名:
功能描述:     数据改变消息
参数描述：
创建日期:      2012-8-13
----------------------------------------------}

procedure TFormNetSet.m_SpEditIPortChange(Sender: TObject);
begin
  m_BtnApp.enabled := true;
end;

{--------------------------------------------
过程名:
功能描述:     数据改变消息
参数描述：
创建日期:      2012-8-13
----------------------------------------------}

procedure TFormNetSet.m_SpEditCPortChange(Sender: TObject);
begin
  m_BtnApp.enabled := true;
end;


{--------------------------------------------
过程名:
功能描述:     确认键按下
参数描述：
创建日期:      2012-8-13
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
      MessageBox(Handle, '端口不能为空！', '提醒', MB_OK + MB_ICONWARNING);
  end;

  close;
end;

{--------------------------------------------
过程名:
功能描述:     窗口关闭
参数描述：
创建日期:      2012-8-13
----------------------------------------------}
procedure TFormNetSet.m_BtnCancelClick(Sender: TObject);
begin
close;
end;

end.


   {
   //�ļ���:         CdsMainFrm.pas
   //����:          ��̨�ӿ�������
   //�汾��:        1.0
   //��������:      2012-8-7
   //IDE ����:      D7
   //�ַ����룺     UTF-8
   //����:          VicTech
   //�汾���У�
   //�汾�޸���ʷ��
   // 2012-8-7 VicTech �����ļ�
   }

unit CdsMainFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sSkinManager, StdCtrls, Buttons, sBitBtn, sComboBox, sLabel,
  sEdit, sCheckBox, ExtCtrls, sPanel, cxSplitter, dxNavBarCollns,
  dxNavBarBase, cxControls, dxNavBar, ImgList, cxGraphics, dxBar, cxClasses,
  Menus, BusinessSkinForm, bsSkinCtrls, TntMenus, sScrollBox, sFrameBar,
  acAlphaHints, acAlphaImageList, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid, ComCtrls,
  sTrackBar, sSpeedButton, sStatusBar, iComponent, iVCLComponent,
  iCustomComponent, iLed, iLedRound, IniFiles, sSkinProvider, AdvMenus;

type
  TMainFrm = class(TForm)
    cxImageList1: TcxImageList;
    sPanel1: TsPanel;
    ImageList24: TsAlphaImageList;
    ImageList16: TsAlphaImageList;
    ImageList32: TsAlphaImageList;
    sAlphaHints1: TsAlphaHints;
    ImgList_MultiState: TsAlphaImageList;
    ImgList_Multi16: TsAlphaImageList;
    sStatusBar1: TsStatusBar;
    sLabel1: TsLabel;
    iLedRound1: TiLedRound;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    GroupBox3: TGroupBox;
    SBStart: TSpeedButton;
    SBStop: TSpeedButton;
    LblStart: TLabel;
    LblStop: TLabel;
    ImgServerState: TImage;
    Label4: TLabel;
    EDConnectInterval: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LblPort: TLabel;
    LblProt: TLabel;
    LblDBType: TLabel;
    LblDataBase: TLabel;
    LblEmployeeCount: TLabel;
    LblOnlineCount: TLabel;
    sAlphaImageList1: TsAlphaImageList;
    MainMenu1: TMainMenu;
    wwww1: TMenuItem;
    m_MenuItemChgPsd: TMenuItem;
    www2: TMenuItem;
    m_MenuItemChgInfo: TMenuItem;
    sSkinManager1: TsSkinManager;
    sSkinProvider1: TsSkinProvider;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure m_MenuItemChgPsdClick(Sender: TObject);
    procedure m_MenuItemChgInfoClick(Sender: TObject);
  private
      { Private declarations }
  public
    procedure Login;
      { Public declarations }
  end;

var
  MainFrm: TMainFrm;

implementation
uses
  CdsCommon,
  CdsChangePsd,
  CdsChgUserInfo,
  CdsLogin;

{$R *.dfm}


{
/****************************************** /
//������:
//��������:      ���崴��
//����������
//��������:      2012-8-10
/**********************************************/
}
procedure TMainFrm.FormCreate(Sender: TObject);
var
  m_IniFile: Tinifile;
  m_Check: string;
begin
  m_IniFile := Tinifile.Create(ExtractFilePath(Application.ExeName) + '\Server.ini');
  try
    g_CDSServerInfo.m_SQLServer.m_StrDataSourceIP := m_IniFile.ReadString('SQL ' +
      'Server', 'DataSourceIP', '');
    g_CDSServerInfo.m_SQLServer.m_StrServerName := m_IniFile.ReadString('SQL ' +
      'Server', 'ServerName', '');
    g_CDSServerInfo.m_SQLServer.m_StrDataBase := m_IniFile.ReadString('SQL Server', 'DataBase', '');
    g_CDSServerInfo.m_SQLServer.m_StrUserName := m_IniFile.ReadString('SQL Server', 'UserName', '');
    g_CDSServerInfo.m_SQLServer.m_StrPassWord := m_IniFile.ReadString('SQL Server', 'PassWord', '');
    g_StrConnectStr := 'Provider=SQLOLEDB.1;Password=' + g_CDSServerInfo.m_SQLServer.m_StrPassWord +
      ';User ID=' + g_CDSServerInfo.m_SQLServer.m_StrUserName +
      ';Initial Catalog=' + g_CDSServerInfo.m_SQLServer.m_StrDataBase +
      ';Data Source=' + g_CDSServerInfo.m_SQLServer.m_StrServerName +
      ';Persist Security Info=True';

    g_CDSLastLoginUser.m_StrUserNum := m_IniFile.ReadString('Last User',
      'LastNum', '');
    g_CDSLastLoginUser.m_StrUserPsd := m_IniFile.ReadString('Last User',
      'LastPsd', '');
    g_CDSLastLoginUser.m_StrUserRole := m_IniFile.ReadString('Last User',
      'LastRole', '');

    m_Check := m_IniFile.ReadString('Last User', 'Checked', '');
    if m_Check = '1' then
      g_CDSLastLoginUser.m_BlPsdChecked := True
    else
      g_CDSLastLoginUser.m_BlPsdChecked := False;

     { TimerTestConnection.Interval := IniFile.ReadInteger('AutoConnect', 'Interval', 1) * 60000;
      EDConnectInterval.Text := IniFile.ReadString('AutoConnect', 'Interval', '1');
      ServerConfig.ServerPort := IniFile.ReadInteger('ServerInfo', 'ServerPort',0);
      ServerConfig.DetectTimeout := IniFile.ReadInteger('ServerDetectTimeout',
        'DetectTimeout',0);
      ServerConfig.DetectInterval := IniFile.ReadInteger('ServerDetectInterval',
        'DetectInterval',0);}
  finally
    m_IniFile.Free;
  end;
    //���ص�¼����
  try
    Login;
  except
    application.Terminate;
  end;
end;

{
/******************************************/
//������:         Login
//��������:      ��¼������غ���
//����������
//��������:      2012-8-11
/******************************************/
}
procedure TMainFrm.Login;
begin
    //���ɵ�½���ڲ���ģʽ���ڷ�ʽ��ʾ
  CdsLogin.FormLogin := TFormLogin.Create(Application);
  CdsLogin.FormLogin.ShowModal;
  if CdsLogin.FormLogin.ModalResult = mrOK then
  begin
    g_CDSCurrentLoginUser.m_StrUserNum := CdsLogin.FormLogin.m_EditUserNum.Text; //ȫ�ֱ������浱ǰ�û���
    g_CDSCurrentLoginUser.m_StrUserRole := CdsLogin.FormLogin.m_ComboBoxRole.Text;
    FreeAndNil(CdsLogin.FormLogin);
  end
  else
    raise Exception.Create('�˳�����!'); //�ֶ�����һ���쳣,����ǰ��������
end;

{
/******************************************/
//������:
//��������:      �����޸Ĵ������
//����������
//��������:      2012-8-12
/******************************************/
}
procedure TMainFrm.m_MenuItemChgPsdClick(Sender: TObject);
begin
  FormChgPsd := TFormChgPsd.Create(self);
  FormChgPsd.showmodal;
end;

{
/******************************************/
//������:         
//��������:      ��Ϣά���������
//����������
//��������:      2012-8-12
/******************************************/
}
procedure TMainFrm.m_MenuItemChgInfoClick(Sender: TObject);
begin
  FormChgUserInfo := TFormChgUserInfo.Create(self);
  FormChgUserInfo.showmodal;
end;

end.


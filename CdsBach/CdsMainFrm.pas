   {
   //文件名:         CdsMainFrm.pas
   //描述:          后台接口主界面
   //版本号:        1.0
   //创建日期:      2012-8-7
   //IDE 环境:      D7
   //字符编码：     UTF-8
   //作者:          VicTech
   //版本所有：
   //版本修改历史：
   // 2012-8-7 VicTech 创建文件
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
//函数名:
//函数描述:      窗体创建
//变量描述：
//创建日期:      2012-8-10
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
    //加载登录窗体
  try
    Login;
  except
    application.Terminate;
  end;
end;

{
/******************************************/
//函数名:         Login
//函数描述:      登录窗体加载函数
//变量描述：
//创建日期:      2012-8-11
/******************************************/
}
procedure TMainFrm.Login;
begin
    //生成登陆窗口并以模式窗口方式显示
  CdsLogin.FormLogin := TFormLogin.Create(Application);
  CdsLogin.FormLogin.ShowModal;
  if CdsLogin.FormLogin.ModalResult = mrOK then
  begin
    g_CDSCurrentLoginUser.m_StrUserNum := CdsLogin.FormLogin.m_EditUserNum.Text; //全局变量保存当前用户名
    g_CDSCurrentLoginUser.m_StrUserRole := CdsLogin.FormLogin.m_ComboBoxRole.Text;
    FreeAndNil(CdsLogin.FormLogin);
  end
  else
    raise Exception.Create('退出程序!'); //手动生成一个异常,以提前结束程序
end;

{
/******************************************/
//函数名:
//函数描述:      密码修改窗体加载
//变量描述：
//创建日期:      2012-8-12
/******************************************/
}
procedure TMainFrm.m_MenuItemChgPsdClick(Sender: TObject);
begin
  FormChgPsd := TFormChgPsd.Create(self);
  FormChgPsd.showmodal;
end;

{
/******************************************/
//函数名:         
//函数描述:      信息维护窗体加载
//变量描述：
//创建日期:      2012-8-12
/******************************************/
}
procedure TMainFrm.m_MenuItemChgInfoClick(Sender: TObject);
begin
  FormChgUserInfo := TFormChgUserInfo.Create(self);
  FormChgUserInfo.showmodal;
end;

end.


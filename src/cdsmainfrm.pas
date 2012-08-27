{-----------------------------------------------------
文件名:         CdsMainFrm.pas
描述:          后台接口主程序
版本号:        1.0
创建日期:      2012-8-7
IDE 环境:      D7
字符编码：     UTF-8
作者:          VicTech
版本所有：
版本修改历史：
   2012-8-7 VicTech: 创建文件
-----------------------------------------------------}

unit CdsMainFrm;

{$INCLUDE RemObjects.inc}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sSkinManager, StdCtrls, Buttons, sBitBtn, sComboBox, sLabel,
  sEdit, sCheckBox, ExtCtrls, sPanel, cxSplitter, ImgList, cxClasses,
  Menus, sScrollBox, sFrameBar, acAlphaHints, acAlphaImageList, ComCtrls,
  sTrackBar, sSpeedButton, sStatusBar, IniFiles, sSkinProvider, AdvMenus,
  uROIpSuperHttpServer, uROSynapseSuperTCPServer, uROClient, uROBINMessage,
  uROClientIntf, uROServer, uROSOAPMessage, uROWinMessageServer, uROEncryption,
  uROPostMessage, uROServerMultiMessage, uROXmlRpcMessage, uROEncryptionEnvelope,
  uROJSONMessage, uROBPDXTCPServer, uROBPDXHTTPServer, uROBaseSuperHttpServer,
  uRPThreadPool, uRPTcpServer, uRPBuffer, uRPSocketEngine, uRPTcpServerEngine, Winsock, DB, ADODB, CdsCommon,
  cxGraphics, RzTray;
{$I IOCP.inc}
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
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    GroupBox3: TGroupBox;
    m_BtnStart: TSpeedButton;
    m_BtnStop: TSpeedButton;
    m_LblStart: TLabel;
    m_LblStop: TLabel;
    ImgServerState: TImage;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    m_LblPort: TLabel;
    LblProt: TLabel;
    LblDBType: TLabel;
    LblDataBase: TLabel;
    m_LblEmployeeCount: TLabel;
    m_LblTermCount: TLabel;
    sAlphaImageList1: TsAlphaImageList;
    MainMenu1: TMainMenu;
    m_SysMnu: TMenuItem;
    m_MenuItemChgPsd: TMenuItem;
    www2: TMenuItem;
    m_MenuItemChgInfo: TMenuItem;
    sSkinManager1: TsSkinManager;
    sSkinProvider1: TsSkinProvider;
    m_MenuItemNetSet: TMenuItem;
    N2: TMenuItem;
    m_AppMinSizw: TMenuItem;
    m_AppClose: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    m_BpdxHttpServer: TROBPDXHTTPServer;
    m_BpdxTcpServer: TROBPDXTCPServer;
    m_BINMessage: TROBinMessage;
    ROSOAPMessage: TROSOAPMessage;
    m_LabelState: TsLabel;
    m_ADOConnectionServer: TADOConnection;
    m_ServerInfoUpdateTimer: TTimer;
    m_PlDock: TsPanel;
    ImageListSmall: TcxImageList;
    Tray: TRzTrayIcon;
    PopupMenu: TPopupMenu;
    PopMenu_ShowMainWindow: TMenuItem;
    PopMenu_HideMainWindow: TMenuItem;
    MenuItem1: TMenuItem;
    PopMenu_Exit: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure m_MenuItemChgPsdClick(Sender: TObject);
    procedure m_MenuItemChgInfoClick(Sender: TObject);
    procedure m_MenuItemNetSetClick(Sender: TObject);
    procedure m_BtnStartClick(Sender: TObject);
    procedure m_BtnStopClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure m_ServerInfoUpdateTimerTimer(Sender: TObject);
    procedure PopMenu_ShowMainWindowClick(Sender: TObject);
    procedure PopMenu_HideMainWindowClick(Sender: TObject);
    procedure PopMenu_ExitClick(Sender: TObject);
    procedure m_AppMinSizwClick(Sender: TObject);
    procedure m_AppCloseClick(Sender: TObject);
  private
    m_SuperHTTPServer: TROIpSuperHttpServer;
    m_SuperTCPServer: TROSynapseSuperTcpServer;


    procedure OnRPNewSocket(m_ClientContext: TRPClientContext);
    procedure OnRPCloseSocket(m_ClientContext: TRPClientContext);
    procedure OnRPRecvCompleted(m_ClientContext: TRPClientContext;
      m_RPBuffer: TRPBuffer;
      m_dwIoSize: DWORD);
    procedure OnRPSendCompleted(m_ClientContext: TRPClientContext;
      m_RPBuffer: TRPBuffer;
      m_dwIoSize: DWORD);

    function OnCreateClient: TRPClientContext;

      { Private declarations }
  public
    g_ThrdlstClientEmployees: TThreadList; {客户端列表}
    g_ThrdlstTermEmployees: TThreadList; {终端列表}
    g_ThrdlstPatientsInfo: TThreadList; {病人列表}
    procedure Login;
    procedure GetClientEmployees();
    procedure GetTermEmployees();
    procedure GetPatientsInfo();
    procedure CdsTCPCommuncationExecute(m_RecvBuf: pchar; m_BufLenth: integer;
      m_Iocpsocket: TRPClientContext);
    procedure CdsTermLogin(m_FrameHead: TCDSTermSendCommFrameHead;
      m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
    procedure CdsTermOnlineCheck(m_FrameHead: TCDSTermSendCommFrameHead;
      m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
    procedure CdsTermPatientCall(m_FrameHead: TCDSTermSendCommFrameHead;
      m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
    procedure CdsTermCheckCard(m_FrameHead: TCDSTermSendCommFrameHead;
      m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
    procedure CdsTermCheckSec(m_FrameHead: TCDSTermSendCommFrameHead;
      m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
    procedure CdsTermDrugScan(m_FrameHead: TCDSTermSendCommFrameHead;
      m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
    procedure CdsTermOrderInquiry(m_FrameHead: TCDSTermSendCommFrameHead;
      m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
    procedure CdsClientOnlineCheck(m_FrameHead: TCDSTermSendCommFrameHead;
      m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
    procedure CdsClientConfirmCall(m_FrameHead: TCDSTermSendCommFrameHead;
      m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
    procedure CdsClientTimeControl(m_FrameHead: TCDSTermSendCommFrameHead;
      m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
    procedure CdsClientLogin(m_FrameHead: TCDSTermSendCommFrameHead;
      m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
    procedure CdsTermTimeControlResult(m_FrameHead: TCDSTermSendCommFrameHead;
      m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
    function FindClientBySocket(m_IocpSocket: TRPClientContext): PCDSClientEmployee;
    function FindTermBySocket(m_IocpSocket: TRPClientContext): PCDSTermEmployee;
    function FindClientByUserNum(m_UserNum: string): PCDSClientEmployee;
    function FindTermByTermNum(m_TermNum: string): PCDSTermEmployee;
    function FindPatientByTermNum(m_TermNum: string): PCDSPatientInfo;
       { Public declarations }
  end;


var
  MainFrm: TMainFrm;
  _RPThreadPool: TRPThreadPool;
  _RPTcpServer: TRPTcpServer;

implementation
uses

  CdsLibrary_Intf,
  CdsChangePsd,
  CdsChgUserInfo,
  CdsNetSet,
  uGlobalLogger,
  uRPProtocol,
  uCircularBuffer,
  frmMonitor,
  CdsLogin;

{$R *.dfm}


{-------------------------------------------------
过程名:
功能描述:      窗体创建
参数描述：
创建日期:      2012-8-7
--------------------------------------------------}

procedure TMainFrm.FormCreate(Sender: TObject);
var
  m_IniFile: Tinifile;
  m_Check: string;
begin
  m_IniFile := Tinifile.Create(ExtractFilePath(Application.ExeName) + '\Server.ini');
  try
    //数据库
    g_CDSServerInfo.m_SQLServer.m_StrDataSourceIP := m_IniFile.ReadString('SQL ' +
      'Server', 'DataSourceIP', '');
    g_CDSServerInfo.m_SQLServer.m_StrServerName := m_IniFile.ReadString('SQL ' +
      'Server', 'ServerName', '');
    g_CDSServerInfo.m_SQLServer.m_StrDataBase := m_IniFile.ReadString('SQL Server', 'DataBase', '');
    g_CDSServerInfo.m_SQLServer.m_StrUserName := m_IniFile.ReadString('SQL Server', 'UserName', '');
    g_CDSServerInfo.m_SQLServer.m_StrPassWord := m_IniFile.ReadString('SQL Server', 'PassWord', '');
    //端口
    g_CDSServerInfo.m_DataServerPort := strtoint(m_IniFile.ReadString('ServerPort', 'DataPort', ''));
    g_CDSServerInfo.m_IntfServerPort := strtoint(m_IniFile.ReadString('ServerPort', 'IntfPort', ''));
    g_CDSServerInfo.m_CommunicateServerPort := strtoint(m_IniFile.ReadString('ServerPort', 'Communict', ''));

    g_CDSServerInfo.m_DetectTimeout := strtoint(m_IniFile.ReadString(
      'ServerDetectTimeout', 'DetectTimeout', ''));
    g_CDSServerInfo.m_DetectInterval := strtoint(m_IniFile.ReadString(
      'ServerDetectInterval', 'DetectInterval', ''));

    g_StrConnectStr := 'Provider=SQLOLEDB.1;Password=' + g_CDSServerInfo.m_SQLServer.m_StrPassWord +
      ';User ID=' + g_CDSServerInfo.m_SQLServer.m_StrUserName +
      ';Initial Catalog=' + g_CDSServerInfo.m_SQLServer.m_StrDataBase +
      ';Data Source=' + g_CDSServerInfo.m_SQLServer.m_StrServerName +
      ';Persist Security Info=True';
    //用户
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

  finally
    m_IniFile.Free;
  end;
    //加载登录窗体
  try
    Login;
  except
    application.Terminate;
  end;

  m_SuperHTTPServer := TROIpSuperHttpServer.Create(Self);
  m_SuperHTTPServer.Dispatchers.Assign(m_BpdxHttpServer.Dispatchers);
  m_SuperTCPServer := TROSynapseSuperTcpServer.Create(Self);
  m_SuperTCPServer.Dispatchers.Assign(m_BpdxTcpServer.Dispatchers);
  m_BpdxHttpServer.Encryption.EncryptionMethod := tetDES;
  m_BpdxTcpServer.Encryption.Assign(m_BpdxHttpServer.Encryption);
  m_SuperHTTPServer.Encryption.Assign(m_BpdxHttpServer.Encryption);
  m_SuperTCPServer.Encryption.Assign(m_BpdxHttpServer.Encryption);
  m_BINMessage.UseCompression := true;

  _GlobalLogger.FileLogger.InitFileLog;
  _RPTcpServer := TRPTcpServer.Create;
  _RPThreadPool := TRPThreadPool.Create(_RPTcpServer);

  m_PlDock.DockSite := TRUE;
  MonitorFrm := TMonitorFrm.Create(m_PlDock, _RPTcpServer);
  MonitorFrm.Show;
  MonitorFrm.ManualDock(m_PlDock, nil, alClient);
  _RPTcpServer.OnNewSocketEvent := OnRPNewSocket;
  _RPTcpServer.OnCloseSocketEvent := OnRPCloseSocket;
  _RPTcpServer.OnRecvCompletedEvent := OnRPRecvCompleted;
  _RPTcpServer.OnSendCompletedEvent := OnRPSendCompleted;
  _RPTcpServer.OnCreateClientContextEvent := OnCreateClient;


  g_ThrdlstClientEmployees := TThreadList.create;
  g_ThrdlstTermEmployees := TThreadList.create;
  g_ThrdlstPatientsInfo := TThreadList.create;
  m_ADOConnectionServer.ConnectionString := g_StrConnectStr;

  m_LblPort.Caption := inttostr(g_CDSServerInfo.m_CommunicateServerPort);
end;

{-------------------------------------------------
过程名:         Login
功能描述:      登录窗体加载函数
参数描述：
创建日期:      2012-8-10
---------------------------------------------------}

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

{-------------------------------------------------
过程名:
功能描述:      密码修改窗体加载
参数描述：
创建日期:      2012-8-12
--------------------------------------------------}

procedure TMainFrm.m_MenuItemChgPsdClick(Sender: TObject);
begin
  FormChgPsd := TFormChgPsd.Create(self);
  FormChgPsd.showmodal;
end;

{-------------------------------------------------
过程名:
功能描述:      信息维护窗体加载
参数描述：
创建日期:      2012-8-12
---------------------------------------------------}

procedure TMainFrm.m_MenuItemChgInfoClick(Sender: TObject);
begin
  FormChgUserInfo := TFormChgUserInfo.Create(self);
  FormChgUserInfo.showmodal;
end;

{--------------------------------------------
过程名:
功能描述:      网络配置窗体加载
参数描述：
创建日期:      2012-8-14
----------------------------------------------}

procedure TMainFrm.m_MenuItemNetSetClick(Sender: TObject);
begin
  FormNetSet := TFormNetSet.Create(self);
  FormNetSet.showmodal;
end;

{--------------------------------------------
过程名:
功能描述:      开启服务功能
参数描述：
创建日期:      2012-8-16
----------------------------------------------}

procedure TMainFrm.m_BtnStartClick(Sender: TObject);
begin
  try
    GetClientEmployees();
    GetTermEmployees();
    GetPatientsInfo();
    m_SuperHTTPServer.Port := g_CDSServerInfo.m_DataServerPort;
    m_SuperHTTPServer.Active := true;
    m_SuperTCPServer.Port := g_CDSServerInfo.m_IntfServerPort;
    m_SuperTCPServer.Active := true;

    try
      m_BtnStop.enabled := _RPTcpServer.StartServer(g_CDSServerInfo.m_CommunicateServerPort,
        _RPTcpServer.m_dMaxConn,
        _RPTcpServer.m_dMaxFreeContext,
        _RPTcpServer.m_dMaxFreeBuffer);
      if not m_BtnStop.enabled then
      begin
        m_LabelState.Caption := '未能打开通信TCP端口：' + IntToStr(g_CDSServerInfo.m_CommunicateServerPort);
        exit;
      end;

    except
    end;

    _RPThreadPool.FIOWorkThreads := _RPTcpServer.m_dWorkThread;
    m_BtnStart.enabled := not _RPThreadPool.StartThreadPool;
    m_LblStart.enabled := m_BtnStart.enabled;
    if not m_LblStart.enabled then
      m_LabelState.Caption := '服务器已经启动'
    else
      m_LabelState.Caption := '服务器已经启动失败，未能建立线程池！';
    m_ServerInfoUpdateTimer.enabled := not m_LblStart.enabled;
    m_BtnStop.enabled := not m_BtnStart.enabled;
    m_LblStop.enabled := m_BtnStop.enabled;

  except
    on e: Exception do
    begin
      m_LabelState.Caption := '服务器启动失败（ -- ' + E.Message + '）';
      Exit;
    end;

  end;

end;

{--------------------------------------------
过程名:
功能描述:      关闭服务
参数描述：
创建日期:      2012-8-16
----------------------------------------------}

procedure TMainFrm.m_BtnStopClick(Sender: TObject);
begin
  try
    m_SuperHTTPServer.Active := false;
    m_SuperTCPServer.Active := false;
    _RPThreadPool.StopThreadPool;
  except
    on e: Exception do
    begin
      m_LabelState.Caption := '服务器关闭失败（ -- ' + E.Message + '）';
      Exit;
    end;

  end;
  m_LabelState.Caption := '服务器已关闭';
  m_BtnStart.enabled := true;
  m_LblStart.enabled := true;
  m_BtnStop.enabled := false;
  m_LblStop.enabled := false;
end;

{--------------------------------------------
过程名:
功能描述:      socket连接事件
参数描述：
创建日期:      2012-8-17
----------------------------------------------}

procedure TMainFrm.OnRPNewSocket(m_ClientContext: TRPClientContext);
begin
  //回射消息
{$IFDEF _ICOP_DEBUG}
  _GlobalLogger.AppendLogMessage('新客户端连接, IP地址: %s, Socket ID: %d, MAP ID: %d, m_iNumberOfActiveConnections: %d.',
    [FClientContext.m_sRemoteIP, FClientContext.FKeyID,
    FClientContext.FMapID, m_iNumberOfActiveConnections]);
{$ENDIF}
end;


{--------------------------------------------
过程名:
功能描述:      socket关闭事件
参数描述：
创建日期:      2012-8-17
----------------------------------------------}

procedure TMainFrm.OnRPCloseSocket(m_ClientContext: TRPClientContext);
begin

end;

{--------------------------------------------
过程名:
功能描述:      TCP异步数据接收
参数描述：
创建日期:      2012-8-17
----------------------------------------------}

procedure TMainFrm.OnRPRecvCompleted(m_ClientContext: TRPClientContext;
  m_RPBuffer: TRPBuffer;
  m_dwIoSize: DWORD);
var
  m_buff: pchar;
begin

  m_buff := pchar(m_RPBuffer.GetBuffer);
  CdsTCPCommuncationExecute(m_buff, m_RPBuffer.GetUsed,
    m_ClientContext);
  // 投递下一个
  _RPTcpServer.SendRecvEvent(m_ClientContext);
end;

{--------------------------------------------
过程名:
功能描述:      TCP异步数据发送结束
参数描述：
创建日期:      2012-8-17
----------------------------------------------}

procedure TMainFrm.OnRPSendCompleted(m_ClientContext: TRPClientContext;
  m_RPBuffer: TRPBuffer;
  m_dwIoSize: DWORD);
begin

end;

{--------------------------------------------
过程名:
功能描述:      创建客户端连接事件
参数描述：
创建日期:      2012-8-17
----------------------------------------------}

function TMainFrm.OnCreateClient: TRPClientContext;
begin
  Result := TRPClientContext.Create(_RPTcpServer);
end;

{--------------------------------------------
过程名:
功能描述:      窗体销毁
参数描述：
创建日期:      2012-8-18
----------------------------------------------}

procedure TMainFrm.FormDestroy(Sender: TObject);
begin
  m_SuperHTTPServer.Active := false;
  m_SuperTCPServer.Active := false;
  MonitorFrm.Timer1.Enabled := False;
  _RPThreadPool.StopThreadPool;
  FreeAndNil(_RPThreadPool);
  FreeAndNil(_RPTcpServer);
  m_SuperHTTPServer.Free;
  m_SuperTCPServer.Free;
  g_ThrdlstClientEmployees.Free;
  g_ThrdlstTermEmployees.Free;
  g_ThrdlstPatientsInfo.Free;
end;

{--------------------------------------------
过程名:
功能描述:      数据通信执行
参数描述：
创建日期:      2012-8-19
----------------------------------------------}

procedure TMainFrm.CdsTCPCommuncationExecute(m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
var
  m_FrameHead: TCDSTermSendCommFrameHead;
begin

  try
    ReadBuffer(m_RecvBuf^, m_FrameHead, SizeOf(m_FrameHead)); //
    {----------------------------------------------------------------------------}
    if (m_FrameHead.m_skType = skTermLogin) then //终端注册
    begin
      CdsTermLogin(m_FrameHead, m_RecvBuf, m_BufLenth, m_Iocpsocket);
      Exit;
    end;

   {----------------------------------------------------------------------------}
    if (m_FrameHead.m_skType = skTermOnlineCheck) then //终端在线检测
    begin
      CdsTermOnlineCheck(m_FrameHead, m_RecvBuf, m_BufLenth, m_Iocpsocket);
      Exit;
    end;

   {----------------------------------------------------------------------------}
    if m_FrameHead.m_skType = skTermCall then //病房呼叫
    begin
      CdsTermPatientCall(m_FrameHead, m_RecvBuf, m_BufLenth, m_Iocpsocket);
      Exit;
    end;

   {----------------------------------------------------------------------------}
    if m_FrameHead.m_skType = skTermCheckCard then //查房
    begin
      CdsTermCheckCard(m_FrameHead, m_RecvBuf, m_BufLenth, m_Iocpsocket);
      Exit;
    end;

   {----------------------------------------------------------------------------}
    if m_FrameHead.m_skType = skTermCheckSec then //二次应答
    begin
      CdsTermCheckSec(m_FrameHead, m_RecvBuf, m_BufLenth, m_Iocpsocket);
      Exit;
    end;
   {----------------------------------------------------------------------------}
    if m_FrameHead.m_skType = skTermDrugScan then //药品扫描
    begin
      CdsTermDrugScan(m_FrameHead, m_RecvBuf, m_BufLenth, m_Iocpsocket);
      Exit;
    end;
   {----------------------------------------------------------------------------}
    if m_FrameHead.m_skType = skTermOrderInquiry then //医嘱查询
    begin
      CdsTermOrderInquiry(m_FrameHead, m_RecvBuf, m_BufLenth, m_Iocpsocket);
      Exit;
    end;

    {----------------------------------------------------------------------------}
    if (m_FrameHead.m_skType = skClientOnlineCheck) then //客户端在线检测
    begin
      CdsClientOnlineCheck(m_FrameHead, m_RecvBuf, m_BufLenth, m_Iocpsocket);
      Exit;
    end;

   {----------------------------------------------------------------------------}
    if m_FrameHead.m_skType = skClientCallReturn then //客户端确认呼叫
    begin
      CdsClientConfirmCall(m_FrameHead, m_RecvBuf, m_BufLenth, m_Iocpsocket);
      exit;
    end;
   {----------------------------------------------------------------------------}
    if m_FrameHead.m_skType = skClientTimeControl then //客户端发送终端显示控制
    begin

      CdsClientTimeControl(m_FrameHead, m_RecvBuf, m_BufLenth, m_Iocpsocket);
      Exit;
    end;

   {----------------------------------------------------------------------------}
    if (m_FrameHead.m_skType = skClientLogin) then //客户端注册
    begin
      CdsClientLogin(m_FrameHead, m_RecvBuf, m_BufLenth, m_Iocpsocket);
      Exit;
    end;
  {----------------------------------------------------------------------------}
    if m_FrameHead.m_skType = skTermTimeControl then //终端反馈客户端
    begin
      CdsTermTimeControlResult(m_FrameHead, m_RecvBuf, m_BufLenth, m_Iocpsocket);
      exit;
    end;

  except
    Sleep(30);
  end; //try

end;

{--------------------------------------------
过程名:
功能描述:      获取所有客户端用户
参数描述：
创建日期:      2012-8-19
----------------------------------------------}

procedure TMainFrm.GetClientEmployees();
var
  m_ADODataSet: TADODataSet;
  m_CDSClientEmployeeData: PCDSClientEmployee;
begin
  m_ADODataSet := TADODataSet.Create(nil);
  g_ThrdlstClientEmployees.LockList;
  try
    m_ADODataSet.Connection := m_ADOConnectionServer;
    m_ADODataSet.CommandText := 'SELECT UserNum,UserName,UserRole,UserPost from cds_user_info';
    m_ADODataSet.Open;
    g_ThrdlstClientEmployees.Clear;
    while not m_ADODataSet.Eof do
    begin
      GetMem(m_CDSClientEmployeeData, SizeOf(TCDSClientEmployee));
      m_CDSClientEmployeeData.m_StrUserNum := m_ADODataSet.FieldByName('UserNum').AsString;
      m_CDSClientEmployeeData.m_StrUserName := m_ADODataSet.FieldByName('UserName').AsString;
      m_CDSClientEmployeeData.m_StrUserRole := m_ADODataSet.FieldByName('UserRole').AsString;
      m_CDSClientEmployeeData.m_StrUserPost := m_ADODataSet.FieldByName('UserPost').AsString;
      m_CDSClientEmployeeData.m_IocpSocket := nil;
      g_ThrdlstClientEmployees.Add(m_CDSClientEmployeeData);
      m_ADODataSet.Next;
    end;
  finally
    FreeMem(m_CDSClientEmployeeData, SizeOf(TCDSClientEmployee));
    g_ThrdlstClientEmployees.UnLockList;
    m_ADODataSet.Close;
    m_ADODataSet.Free;
    m_ADOConnectionServer.Close;
  end;
end;

{--------------------------------------------
过程名:
功能描述:      获取所有终端用户
参数描述：
创建日期:      2012-8-19
----------------------------------------------}

procedure TMainFrm.GetTermEmployees();
var
  m_ADODataSet: TADODataSet;
  m_CDSTermEmployeeData: PCDSTermEmployee;
begin
  m_ADODataSet := TADODataSet.Create(nil);
  g_ThrdlstTermEmployees.LockList;
  try
    m_ADODataSet.Connection := m_ADOConnectionServer;
    m_ADODataSet.CommandText := 'SELECT * from cds_bed_info';
    m_ADODataSet.Open;
    g_ThrdlstTermEmployees.Clear;
    while not m_ADODataSet.Eof do
    begin

      GetMem(m_CDSTermEmployeeData, SizeOf(TCDSTermEmployee));
      m_CDSTermEmployeeData.m_StrTermNum := m_ADODataSet.FieldByName('TermNum').AsString;
      m_CDSTermEmployeeData.m_StrBedNum := m_ADODataSet.FieldByName('BedNum').AsString;
      m_CDSTermEmployeeData.m_StrfloorNum := m_ADODataSet.FieldByName('FloorNum').AsString;
      m_CDSTermEmployeeData.m_StrRoomNum := m_ADODataSet.FieldByName('RoomNum').AsString;
      m_CDSTermEmployeeData.m_StrNurseNum1 := m_ADODataSet.FieldByName('NurseNum1').AsString;
      m_CDSTermEmployeeData.m_StrNurseName1 := m_ADODataSet.FieldByName('NurseName1').AsString;
      m_CDSTermEmployeeData.m_StrNurseNum2 := m_ADODataSet.FieldByName('NurseNum2').AsString;
      m_CDSTermEmployeeData.m_StrNurseName2 := m_ADODataSet.FieldByName('NurseName2').AsString;
      m_CDSTermEmployeeData.m_StrNurseNum3 := m_ADODataSet.FieldByName('NurseNum3').AsString;
      m_CDSTermEmployeeData.m_StrNurseName3 := m_ADODataSet.FieldByName('NurseName3').AsString;
      m_CDSTermEmployeeData.m_StrNurseNum4 := m_ADODataSet.FieldByName('NurseNum4').AsString;
      m_CDSTermEmployeeData.m_StrNurseName4 := m_ADODataSet.FieldByName('NurseName4').AsString;
      m_CDSTermEmployeeData.m_StrHeadNurseNum := m_ADODataSet.FieldByName('HeadNurseNum').AsString;
      m_CDSTermEmployeeData.m_StrHeadNurseName := m_ADODataSet.FieldByName('HeadNurseName').AsString;
      m_CDSTermEmployeeData.m_IocpSocket := nil;
      g_ThrdlstTermEmployees.Add(m_CDSTermEmployeeData);
      m_ADODataSet.Next;
    end;

  finally
    FreeMem(m_CDSTermEmployeeData, SizeOf(TCDSTermEmployee));
    g_ThrdlstTermEmployees.UnLockList;
    m_ADODataSet.Close;
    m_ADODataSet.Free;
    m_ADOConnectionServer.Close;
  end;
end;

{--------------------------------------------
过程名:
功能描述:      获取所有病人信息
参数描述：
创建日期:      2012-8-20
----------------------------------------------}

procedure TMainFrm.GetPatientsInfo();
var
  m_ADODataSet: TADODataSet;
  m_CDSPatientInfoData: PCDSPatientInfo;
begin
  m_ADODataSet := TADODataSet.Create(nil);
  g_ThrdlstPatientsInfo.LockList;
  try
    m_ADODataSet.Connection := m_ADOConnectionServer;
    m_ADODataSet.CommandText := 'SELECT PatientNum,PatientName,BedNum,TermNum from cds_patient_info';
    m_ADODataSet.Open;
    g_ThrdlstPatientsInfo.Clear;
    while not m_ADODataSet.Eof do
    begin
      GetMem(m_CDSPatientInfoData, SizeOf(TCDSPatientInfo));
      m_CDSPatientInfoData.m_StrPatientNum := m_ADODataSet.FieldByName('PatientNum').AsString;
      m_CDSPatientInfoData.m_StrPatientName := m_ADODataSet.FieldByName('PatientName').AsString;
      m_CDSPatientInfoData.m_StrBedNum := m_ADODataSet.FieldByName('BedNum').AsString;
      m_CDSPatientInfoData.m_StrTermNum := m_ADODataSet.FieldByName('TermNum').AsString;

      g_ThrdlstPatientsInfo.Add(m_CDSPatientInfoData);
      m_ADODataSet.Next;
    end;
  finally
    FreeMem(m_CDSPatientInfoData, SizeOf(TCDSPatientInfo));
    g_ThrdlstPatientsInfo.UnLockList;
    m_ADODataSet.Close;
    m_ADODataSet.Free;
    m_ADOConnectionServer.Close;
  end;
end;

{--------------------------------------------
函数名:         FindClientBySocket
功能描述:      通过套接字寻找客户端
参数描述：     Socket-TCP套接字
创建日期:      2012-8-21
----------------------------------------------}

function TMainFrm.FindClientBySocket(m_IocpSocket: TRPClientContext): PCDSClientEmployee;
var
  m_IntiLoop: Integer;
begin
  Result := nil;
  with g_ThrdlstClientEmployees.LockList do
  try
    for m_IntiLoop := 0 to count - 1 do
    begin
      if PCDSClientEmployee(Items[m_IntiLoop]).m_IocpSocket = m_IocpSocket then
      begin
        Result := PCDSClientEmployee(Items[m_IntiLoop]);
        exit;
      end;
    end;
  finally
    g_ThrdlstClientEmployees.UnlockList;
  end;
end;

{--------------------------------------------
函数名:         FindTermBySocket
功能描述:      通过套接字寻找终端
参数描述：     Socket-TCP套接字
创建日期:      2012-8-21
----------------------------------------------}

function TMainFrm.FindTermBySocket(m_IocpSocket: TRPClientContext): PCDSTermEmployee;
var
  m_IntiLoop: Integer;
begin
  Result := nil;
  with g_ThrdlstTermEmployees.LockList do
  try
    for m_IntiLoop := 0 to count - 1 do
    begin
      if PCDSTermEmployee(Items[m_IntiLoop]).m_IocpSocket = m_IocpSocket then
      begin
        Result := PCDSTermEmployee(Items[m_IntiLoop]);
        exit;
      end;
    end;
  finally
    g_ThrdlstTermEmployees.UnlockList;
  end;
end;

{--------------------------------------------
函数名:         FindClientByUserNum
功能描述:      通过用户编号寻找用户
参数描述：     m_UserNum-用户编号
创建日期:      2012-8-21
----------------------------------------------}

function TMainFrm.FindClientByUserNum(m_UserNum: string): PCDSClientEmployee;
var
  m_IntiLoop: Integer;
begin
  Result := nil;
  with g_ThrdlstClientEmployees.LockList do
  try
    for m_IntiLoop := 0 to count - 1 do
    begin
      if PCDSClientEmployee(Items[m_IntiLoop]).m_StrUserNum = m_UserNum then
      begin
        Result := PCDSClientEmployee(Items[m_IntiLoop]);
        exit;
      end;
    end;
  finally
    g_ThrdlstClientEmployees.UnlockList;
  end;
end;

{--------------------------------------------
函数名:         FindClientByUserNum
功能描述:      通过用户编号寻找用户
参数描述：     m_TermNum-终端编号
创建日期:      2012-8-21
----------------------------------------------}

function TMainFrm.FindTermByTermNum(m_TermNum: string): PCDSTermEmployee;
var
  m_IntiLoop: Integer;
begin
  Result := nil;
  with g_ThrdlstTermEmployees.LockList do
  try
    for m_IntiLoop := 0 to count - 1 do
    begin
      if PCDSTermEmployee(Items[m_IntiLoop]).m_StrTermNum = m_TermNum then
      begin
        Result := PCDSTermEmployee(Items[m_IntiLoop]);
        exit;
      end;
    end;
  finally
    g_ThrdlstTermEmployees.UnlockList;
  end;
end;

{--------------------------------------------
函数名:         FindPatientByTermNum
功能描述:      通过终端编号寻找病人
参数描述：     m_TermNum-终端编号
创建日期:      2012-8-21
----------------------------------------------}

function TMainFrm.FindPatientByTermNum(m_TermNum: string): PCDSPatientInfo;
var
  m_IntiLoop: Integer;
begin
  Result := nil;
  with g_ThrdlstPatientsInfo.LockList do
  try
    for m_IntiLoop := 0 to count - 1 do
    begin
      if PCDSPatientInfo(Items[m_IntiLoop]).m_StrTermNum = m_TermNum then
      begin
        Result := PCDSPatientInfo(Items[m_IntiLoop]);
        exit;
      end;
    end;
  finally
    g_ThrdlstPatientsInfo.UnlockList;
  end;
end;


{--------------------------------------------
过程名:
功能描述:      终端注册
参数描述：
创建日期:      2012-8-22
----------------------------------------------}

procedure TMainFrm.CdsTermLogin(m_FrameHead: TCDSTermSendCommFrameHead; m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
var
  m_TermRecvFrameHead: TCDSTermRecvCommFrameHead;
  m_TempTerm: PCDSTermEmployee;
  m_CardCommuDtLength: Cardinal;
  m_SendBuffer: array[1..4096] of Byte;
  m_CRCCheck: Char;
  m_BlCheck: boolean;
begin
  m_BlCheck := true;
  m_CardCommuDtLength := CalCommuDataLength(m_FrameHead.m_WLengthHigh, m_FrameHead.m_WLengthLow);
  if m_CardCommuDtLength <> 0 then
  begin
    m_TermRecvFrameHead.m_sgType := sgIllegalData;
    m_BlCheck := false;
  end
  else
  begin

    ReadBuffer((m_RecvBuf + m_BufLenth - 1)^, m_CRCCheck, 1);
    if (m_CRCCheck <> CalCrc_8(m_RecvBuf, m_BufLenth - 1)) then
    begin
      m_TermRecvFrameHead.m_sgType := sgCRCFailed;
      m_BlCheck := false;
    end
    else
      m_TermRecvFrameHead.m_sgType := sgCommunicationSuccess;
  end;

  if m_BlCheck then
  begin
     //寻找终端
    m_TempTerm := FindTermByTermNum(inttostr(m_FrameHead.m_CarTermNum));
    if m_TempTerm <> nil then
      m_TempTerm.m_Iocpsocket := m_Iocpsocket
    else
      m_TermRecvFrameHead.m_sgType := sgTermNotRegist;

  end;
  m_TermRecvFrameHead.m_skType := m_FrameHead.m_skType;
  m_TermRecvFrameHead.m_CarTermNum := m_FrameHead.m_CarTermNum;
  m_TermRecvFrameHead.m_WLenthHigh := 0;
  m_TermRecvFrameHead.m_WLenthLow := 0;
  CopyMemory(@m_SendBuffer[1], @m_TermRecvFrameHead, SizeOf(m_TermRecvFrameHead));
  m_CRCCheck := CalCrc_8(@m_SendBuffer[1], TermRecvFrameHeadLth);
  CopyMemory(@m_SendBuffer[1 + TermRecvFrameHeadLth], @m_CRCCheck, 1);
  _RPTcpServer.SendData(m_Iocpsocket, @m_SendBuffer[1], 1 +
    TermRecvFrameHeadLth);
end;

{--------------------------------------------
过程名:
功能描述:      终端在线检测
参数描述：
创建日期:      2012-8-22
----------------------------------------------}

procedure TMainFrm.CdsTermOnlineCheck(m_FrameHead: TCDSTermSendCommFrameHead; m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
var
  m_TermRecvFrameHead: TCDSTermRecvCommFrameHead;
  m_TempTerm: PCDSTermEmployee;
  m_CardCommuDtLength: Cardinal;
  m_SendBuffer: array[1..4096] of byte;
  m_CRCCheck: Char;
begin
  m_CardCommuDtLength := CalCommuDataLength(m_FrameHead.m_WLengthHigh, m_FrameHead.m_WLengthLow);
  if m_CardCommuDtLength <> 0 then
  begin
    m_TermRecvFrameHead.m_sgType := sgIllegalData;
  end
  else
  begin

    ReadBuffer((m_RecvBuf + m_BufLenth - 1)^, m_CRCCheck, 1);
    if (m_CRCCheck <> CalCrc_8(m_RecvBuf, m_BufLenth - 1)) then
    begin
      m_TermRecvFrameHead.m_sgType := sgCRCFailed;
    end
    else
    begin
      m_TempTerm := FindTermBySocket(m_Iocpsocket);
      if m_TempTerm = nil then
        m_TermRecvFrameHead.m_sgType := sgTermSocketNotRegist
      else
      begin
        m_TempTerm.m_CrdLastActive := GetTickCount;
        m_TermRecvFrameHead.m_sgType := sgCommunicationSuccess;
      end;

    end;
  end;
  m_TermRecvFrameHead.m_skType := m_FrameHead.m_skType;
  m_TermRecvFrameHead.m_CarTermNum := m_FrameHead.m_CarTermNum;
  m_TermRecvFrameHead.m_WLenthHigh := 0;
  m_TermRecvFrameHead.m_WLenthLow := 0;
  CopyMemory(@m_SendBuffer[1], @m_TermRecvFrameHead, SizeOf(m_TermRecvFrameHead));
  m_CRCCheck := CalCrc_8(@m_SendBuffer[1], TermRecvFrameHeadLth);
  CopyMemory(@m_SendBuffer[1 + TermRecvFrameHeadLth], @m_CRCCheck, 1);
  _RPTcpServer.SendData(m_Iocpsocket, @m_SendBuffer[1], 1 +
    TermRecvFrameHeadLth);

end;

{--------------------------------------------
过程名:
功能描述:      终端病人呼叫
参数描述：
创建日期:      2012-8-22
----------------------------------------------}

procedure TMainFrm.CdsTermPatientCall(m_FrameHead: TCDSTermSendCommFrameHead; m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
var
  m_TermRecvFrameHead: TCDSTermRecvCommFrameHead;
  m_ClientRecvFrameHead: TCDSTermSendCommFrameHead;
  m_TempClient: PCDSClientEmployee;
  m_TempTerm: PCDSTermEmployee;
  m_TempPatientIf: PCDSPatientInfo;
  m_ClientRecvCallDtIf: TCDSClientRecvCallDtInfo;
  m_CardCommuDtLength: Cardinal;
  m_StrTempNum: string;
  m_WLengthHigh, m_WLengthLow: word;
  m_BlCheck: boolean;
  m_SendBuffer: array[1..4096] of byte;
  m_CRCCheck: Char;
  m_IntiLoop: integer;
begin
  m_BlCheck := true;
  m_CardCommuDtLength := CalCommuDataLength(m_FrameHead.m_WLengthHigh, m_FrameHead.m_WLengthLow);
  if m_CardCommuDtLength <> 0 then
  begin
    m_TermRecvFrameHead.m_sgType := sgIllegalData;
    m_BlCheck := false;
  end
  else
  begin

    ReadBuffer((m_RecvBuf + m_BufLenth - 1)^, m_CRCCheck, 1);
    if (m_CRCCheck <> CalCrc_8(m_RecvBuf, m_BufLenth - 1)) then
    begin
      m_TermRecvFrameHead.m_sgType := sgCRCFailed;
      m_BlCheck := false;
    end
    else
      m_TermRecvFrameHead.m_sgType := sgCommunicationSuccess;
  end;

  if m_BlCheck then
  begin
     //寻找管理床位的客户端用户
    m_TempTerm := FindTermByTermNum(inttostr(m_FrameHead.m_CarTermNum));
    for m_IntiLoop := 0 to 3 do
    begin
      case m_IntiLoop of //
        0:
          m_StrTempNum := m_TempTerm.m_StrNurseNum1;
        1:
          m_StrTempNum := m_TempTerm.m_StrNurseNum2;
        2:
          m_StrTempNum := m_TempTerm.m_StrNurseNum3;
        3:
          m_StrTempNum := m_TempTerm.m_StrNurseNum4;
      end; //case
      m_TempClient := FindClientByUserNum(m_StrTempNum);
      if (m_TempClient <> nil) and (m_TempClient.m_Iocpsocket <> nil) then
      begin
          //转发呼叫请求至客户端
        m_TempPatientIf := FindPatientByTermNum(m_TempTerm.m_StrTermNum);
        m_ClientRecvCallDtIf.m_StrBedNum := m_TempPatientIf.m_StrBedNum;
        m_ClientRecvCallDtIf.m_StrPatientNum := m_TempPatientIf.m_StrPatientNum;
        m_ClientRecvCallDtIf.m_StrPatientName := m_TempPatientIf.m_StrPatientName;
        m_ClientRecvCallDtIf.m_DateTCallTime := Now();
        CalLthToWord(m_WLengthHigh, m_WLengthLow, sizeof(m_ClientRecvCallDtIf));
        m_ClientRecvFrameHead := m_FrameHead;
        m_ClientRecvFrameHead.m_WLengthHigh := m_WLengthHigh;
        m_ClientRecvFrameHead.m_WLengthLow := m_WLengthLow;
        CopyMemory(@m_SendBuffer[1], @m_ClientRecvFrameHead, SizeOf(m_ClientRecvFrameHead));
        CopyMemory(@m_SendBuffer[1 + ClientSendFrameHeadLth], @m_ClientRecvCallDtIf, SizeOf(m_ClientRecvCallDtIf));
        m_CRCCheck := CalCrc_8(@m_SendBuffer[1], ClientSendFrameHeadLth + SizeOf(m_ClientRecvCallDtIf));
        CopyMemory(@m_SendBuffer[1 + TermRecvFrameHeadLth + SizeOf(m_ClientRecvCallDtIf)], @m_CRCCheck, 1);
        _RPTcpServer.SendData(m_Iocpsocket, @m_SendBuffer[1], 1 +
          TermRecvFrameHeadLth + SizeOf(m_ClientRecvCallDtIf));
        break;
      end
      else
      begin

        if m_IntiLoop = 3 then //反馈终端
        begin
          m_TermRecvFrameHead.m_sgType := sgCantFindClient;
          m_TermRecvFrameHead.m_skType := m_FrameHead.m_skType;
          m_TermRecvFrameHead.m_CarTermNum := m_FrameHead.m_CarTermNum;
          m_TermRecvFrameHead.m_WLenthHigh := 0;
          m_TermRecvFrameHead.m_WLenthLow := 0;
          CopyMemory(@m_SendBuffer[1], @m_TermRecvFrameHead, SizeOf(m_TermRecvFrameHead));
          m_CRCCheck := CalCrc_8(@m_SendBuffer[1], TermRecvFrameHeadLth);
          CopyMemory(@m_SendBuffer[1 + TermRecvFrameHeadLth], @m_CRCCheck, 1);
          _RPTcpServer.SendData(m_Iocpsocket, @m_SendBuffer[1], 1 +
            TermRecvFrameHeadLth);
        end
        else
          continue;
      end;
    end;
  end
  else
  begin //直接反馈失败信息至终端
    m_TermRecvFrameHead.m_skType := m_FrameHead.m_skType;
    m_TermRecvFrameHead.m_CarTermNum := m_FrameHead.m_CarTermNum;
    m_TermRecvFrameHead.m_WLenthHigh := 0;
    m_TermRecvFrameHead.m_WLenthLow := 0;
    CopyMemory(@m_SendBuffer[1], @m_TermRecvFrameHead, SizeOf(m_TermRecvFrameHead));
    m_CRCCheck := CalCrc_8(@m_SendBuffer[1], TermRecvFrameHeadLth);
    CopyMemory(@m_SendBuffer[1 + TermRecvFrameHeadLth], @m_CRCCheck, 1);
    _RPTcpServer.SendData(m_Iocpsocket, @m_SendBuffer[1], 1 +
      TermRecvFrameHeadLth);
  end;

end;


{--------------------------------------------
过程名:
功能描述:      终端查房
参数描述：
创建日期:      2012-8-22
----------------------------------------------}

procedure TMainFrm.CdsTermCheckCard(m_FrameHead: TCDSTermSendCommFrameHead; m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
var
  m_TermRecvFrameHead: TCDSTermRecvCommFrameHead;
  m_TempClient: PCDSClientEmployee;
  m_TempPatientIf: PCDSPatientInfo;
  m_InspectionTableInfo: TCDSInspectionTableInfo;
  m_TermCheckCardResult: TCDSTermCheckCardResult;
  m_TermCheckCard: TCDSTermCheckCard;
  m_CardCommuDtLength: Cardinal;
  m_StrSql: string;
  m_BlCheck: boolean;
  m_SendBuffer: array[1..4096] of byte;
  m_CRCCheck: Char;
begin
  m_TermCheckCardResult.m_CheckCardReturnResult := CharRoleIllegal; ;
  m_BlCheck := true;
  m_CardCommuDtLength := CalCommuDataLength(m_FrameHead.m_WLengthHigh, m_FrameHead.m_WLengthLow);
  if m_CardCommuDtLength <> (m_BufLenth - 1 - TermSendFrameHeadLth) then
  begin
    m_TermRecvFrameHead.m_sgType := sgIllegalData;
    m_BlCheck := false;
  end
  else
  begin

    ReadBuffer((m_RecvBuf + m_BufLenth - 1)^, m_CRCCheck, 1);
    if (m_CRCCheck <> CalCrc_8(m_RecvBuf, m_BufLenth - 1)) then
    begin
      m_TermRecvFrameHead.m_sgType := sgCRCFailed;
      m_BlCheck := false;
    end
    else
      m_TermRecvFrameHead.m_sgType := sgCommunicationSuccess;
  end;

  if m_BlCheck then
  begin
     //读取终端查房信息
    ReadBuffer((m_RecvBuf + TermSendFrameHeadLth)^, m_TermCheckCard, sizeOf(m_TermCheckCard));
     //寻找病人及用户
    m_TempClient := FindClientByUserNum(inttostr(m_TermCheckCard.m_CardUserNum));
    if m_TempClient.m_StrUserRole = RoleAdmin then
      m_TermCheckCardResult.m_CheckCardReturnResult := CharRoleAdmin
    else if m_TempClient.m_StrUserRole = RoleNurse then
      m_TermCheckCardResult.m_CheckCardReturnResult := CharRoleNurse
    else if m_TempClient.m_StrUserRole = CharRoleDoctor then
      m_TermCheckCardResult.m_CheckCardReturnResult := CharRoleDoctor
    else
      m_TermCheckCardResult.m_CheckCardReturnResult := CharRoleOther;

    m_TempPatientIf := FindPatientByTermNum(inttostr(m_FrameHead.m_CarTermNum));
    m_InspectionTableInfo.m_StrBedNum := m_TempPatientIf.m_StrBedNum;
    m_InspectionTableInfo.m_StrPatientNum := m_TempPatientIf.m_StrPatientNum;
    m_InspectionTableInfo.m_StrPatientName := m_TempPatientIf.m_StrPatientName;
    m_InspectionTableInfo.m_StrExecutorNum := inttostr(m_TermCheckCard.m_CardUserNum);
    m_InspectionTableInfo.m_StrExecutorName := m_TempClient.m_StrUserName;
    m_InspectionTableInfo.m_InspectionResult := m_TermCheckCard.m_CheckResult;
    m_InspectionTableInfo.m_ExecuteTime := m_TermCheckCard.m_CheckCardTime;

    try

    //连接数据库
      m_StrSql := 'insert into cds_inspection_info(BedNum,PatientNum,PatientName,ExecutorNum,ExecutorName,InspectionResult,ExecutTime) values('''
        + m_InspectionTableInfo.m_StrBedNum + ''',''' + m_InspectionTableInfo.m_StrPatientNum + ''',''' + m_InspectionTableInfo.m_StrPatientName + ''','''
        + m_InspectionTableInfo.m_StrExecutorNum + ''',''' +
        m_InspectionTableInfo.m_StrExecutorName + ''',''' +
        m_InspectionTableInfo.m_InspectionResult + ''','
        + DateTimeToStr(m_InspectionTableInfo.m_ExecuteTime) + ')';
      with TADOQuery.Create(nil) do
      begin
        try
        //连接数据库并查找记录
          ConnectionString := g_StrConnectStr;
          Close;
          SQL.Clear;
          SQL.Add(m_StrSql);
          ExecSql;

        finally
          m_TermRecvFrameHead.m_sgType := sgCommunicationSuccess;
          Free; //释放TQuery内存
        end;
      end;

    except
      m_TermRecvFrameHead.m_sgType := sgServerExeCuteFailed
    end;

  end;
      //反馈信息至终端
  m_TermRecvFrameHead.m_skType := m_FrameHead.m_skType;
  m_TermRecvFrameHead.m_CarTermNum := m_FrameHead.m_CarTermNum;
  m_TermRecvFrameHead.m_WLenthHigh := 0;
  m_TermRecvFrameHead.m_WLenthLow := 0;
  CopyMemory(@m_SendBuffer[1], @m_TermRecvFrameHead, SizeOf(m_TermRecvFrameHead));
  CopyMemory(@m_SendBuffer[1 + TermRecvFrameHeadLth], @m_TermCheckCardResult, SizeOf(m_TermCheckCardResult));
  m_CRCCheck := CalCrc_8(@m_SendBuffer[1], TermRecvFrameHeadLth + SizeOf(m_TermCheckCardResult));
  CopyMemory(@m_SendBuffer[1 + TermRecvFrameHeadLth + SizeOf(m_TermCheckCardResult)], @m_CRCCheck, 1);
  _RPTcpServer.SendData(m_Iocpsocket, @m_SendBuffer[1], 1 +
    TermRecvFrameHeadLth + SizeOf(m_TermCheckCardResult));
end;


{--------------------------------------------
过程名:
功能描述:      终端二次应答
参数描述：
创建日期:      2012-8-22
----------------------------------------------}

procedure TMainFrm.CdsTermCheckSec(m_FrameHead: TCDSTermSendCommFrameHead; m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
var
  m_TermRecvFrameHead: TCDSTermRecvCommFrameHead;
  m_TempClient: PCDSClientEmployee;
  m_TempPatientIf: PCDSPatientInfo;
  m_TermCheckSec: TCDSTermCheckSec;
  m_CardCommuDtLength: Cardinal;
  m_StrSql: string;
  m_BlCheck: boolean;
  m_SendBuffer: array[1..4096] of byte;
  m_CRCCheck: Char;
begin
  m_BlCheck := true;
  m_CardCommuDtLength := CalCommuDataLength(m_FrameHead.m_WLengthHigh, m_FrameHead.m_WLengthLow);
  if m_CardCommuDtLength <> (m_BufLenth - 1 - TermSendFrameHeadLth) then
  begin
    m_TermRecvFrameHead.m_sgType := sgIllegalData;
    m_BlCheck := false;
  end
  else
  begin

    ReadBuffer((m_RecvBuf + m_BufLenth - 1)^, m_CRCCheck, 1);
    if (m_CRCCheck <> CalCrc_8(m_RecvBuf, m_BufLenth - 1)) then
    begin
      m_TermRecvFrameHead.m_sgType := sgCRCFailed;
      m_BlCheck := false;
    end
    else
      m_TermRecvFrameHead.m_sgType := sgCommunicationSuccess;
  end;

  if m_BlCheck then
  begin
     //读取终端查房信息
    ReadBuffer((m_RecvBuf + TermSendFrameHeadLth)^, m_TermCheckSec, sizeOf(m_TermCheckSec));
     //寻找病人及用户
    m_TempClient := FindClientByUserNum(inttostr(m_TermCheckSec.m_CardUserNum));
    m_TempPatientIf := FindPatientByTermNum(inttostr(m_FrameHead.m_CarTermNum));

    try

    //连接数据库
      m_StrSql := 'UPDATE cds_call_info SET RespNum = ''' + inttostr(m_TermCheckSec.m_CardUserNum) + ''', RespName = ''' + m_TempClient.m_StrUserName + ''', TwiceRespTime = ' + DateTimeToStr(m_TermCheckSec.m_CheckSecTime) +
        ' WHERE PatientNum =''' + m_TempPatientIf.m_StrPatientNum + '''and TwiceRespTime <> Null';

      with TADOQuery.Create(nil) do
      begin
        try
        //连接数据库并查找记录
          ConnectionString := g_StrConnectStr;
          Close;
          SQL.Clear;
          SQL.Add(m_StrSql);
          ExecSql;

        finally
          m_TermRecvFrameHead.m_sgType := sgCommunicationSuccess;
          Free; //释放TQuery内存
        end;
      end;

    except
      m_TermRecvFrameHead.m_sgType := sgServerExeCuteFailed
    end;

  end;
      //反馈信息至终端
  m_TermRecvFrameHead.m_skType := m_FrameHead.m_skType;
  m_TermRecvFrameHead.m_CarTermNum := m_FrameHead.m_CarTermNum;
  m_TermRecvFrameHead.m_WLenthHigh := 0;
  m_TermRecvFrameHead.m_WLenthLow := 0;
  CopyMemory(@m_SendBuffer[1], @m_TermRecvFrameHead, SizeOf(m_TermRecvFrameHead));
  m_CRCCheck := CalCrc_8(@m_SendBuffer[1], TermRecvFrameHeadLth);
  CopyMemory(@m_SendBuffer[1 + TermRecvFrameHeadLth], @m_CRCCheck, 1);
  _RPTcpServer.SendData(m_Iocpsocket, @m_SendBuffer[1], 1 +
    TermRecvFrameHeadLth);
end;

{--------------------------------------------
过程名:
功能描述:      终端药品扫描
参数描述：
创建日期:      2012-8-22
----------------------------------------------}

procedure TMainFrm.CdsTermDrugScan(m_FrameHead: TCDSTermSendCommFrameHead; m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
var
  m_TermRecvFrameHead: TCDSTermRecvCommFrameHead;
  m_TempPatientIf: PCDSPatientInfo;
  m_DrugScan: TCDSDrugScan;
  m_DrugScanResult: TCDSDrugScanResult;
  m_CardCommuDtLength: Cardinal;
  m_StrSql: string;
  m_BlCheck: boolean;
  m_SendBuffer: array[1..4096] of byte;
  m_CRCCheck: Char;
begin
  m_BlCheck := true;
  m_CardCommuDtLength := CalCommuDataLength(m_FrameHead.m_WLengthHigh, m_FrameHead.m_WLengthLow);
  if m_CardCommuDtLength <> (m_BufLenth - 1 - TermSendFrameHeadLth) then
  begin
    m_TermRecvFrameHead.m_sgType := sgIllegalData;
    m_BlCheck := false;
  end
  else
  begin

    ReadBuffer((m_RecvBuf + m_BufLenth - 1)^, m_CRCCheck, 1);
    if (m_CRCCheck <> CalCrc_8(m_RecvBuf, m_BufLenth - 1)) then
    begin
      m_TermRecvFrameHead.m_sgType := sgCRCFailed;
      m_BlCheck := false;
    end
    else
      m_TermRecvFrameHead.m_sgType := sgCommunicationSuccess;
  end;

  if m_BlCheck then
  begin
     //读取终端查房信息
    ReadBuffer((m_RecvBuf + TermSendFrameHeadLth)^, m_DrugScan, sizeOf(m_DrugScan));
     //寻找病人信息
    m_TempPatientIf := FindPatientByTermNum(inttostr(m_FrameHead.m_CarTermNum));
    try

    // 查询HIS数据库
      m_StrSql := 'select  ';
      with TADOQuery.Create(nil) do
      begin
        try
        //连接数据库并查找记录
          ConnectionString := g_StrConnectStr;
          Close;
          SQL.Clear;
          SQL.Add(m_StrSql);
          open;
          if not IsEmpty then
            m_DrugScanResult.m_StrDrugScanResult := '1'
          else
            m_DrugScanResult.m_StrDrugScanResult := '0';
        finally
          m_TermRecvFrameHead.m_sgType := sgCommunicationSuccess;
          Free; //释放TQuery内存
        end;
      end;

    except
      m_TermRecvFrameHead.m_sgType := sgServerExeCuteFailed
    end;

  end;
      //反馈信息至终端
  m_TermRecvFrameHead.m_skType := m_FrameHead.m_skType;
  m_TermRecvFrameHead.m_CarTermNum := m_FrameHead.m_CarTermNum;
  if m_TermRecvFrameHead.m_sgType = sgCommunicationSuccess then
  begin
    m_TermRecvFrameHead.m_WLenthHigh := 0;
    m_TermRecvFrameHead.m_WLenthLow := sizeOf(m_DrugScanResult);
    CopyMemory(@m_SendBuffer[1], @m_TermRecvFrameHead, SizeOf(m_TermRecvFrameHead));
    CopyMemory(@m_SendBuffer[1 + TermRecvFrameHeadLth], @m_DrugScanResult, SizeOf(m_DrugScanResult));
    m_CRCCheck := CalCrc_8(@m_SendBuffer[1], TermRecvFrameHeadLth);
    CopyMemory(@m_SendBuffer[1 + TermRecvFrameHeadLth + SizeOf(m_DrugScanResult)], @m_CRCCheck, 1);
    _RPTcpServer.SendData(m_Iocpsocket, @m_SendBuffer[1], 1 +
      TermRecvFrameHeadLth + SizeOf(m_DrugScanResult));
  end
  else
  begin
    m_TermRecvFrameHead.m_WLenthHigh := 0;
    m_TermRecvFrameHead.m_WLenthLow := 0;
    CopyMemory(@m_SendBuffer[1], @m_TermRecvFrameHead, SizeOf(m_TermRecvFrameHead));
    m_CRCCheck := CalCrc_8(@m_SendBuffer[1], TermRecvFrameHeadLth);
    CopyMemory(@m_SendBuffer[1 + TermRecvFrameHeadLth], @m_CRCCheck, 1);
    _RPTcpServer.SendData(m_Iocpsocket, @m_SendBuffer[1], 1 +
      TermRecvFrameHeadLth);
  end;
end;

 {--------------------------------------------
过程名:
功能描述:      终端医嘱查询
参数描述：
创建日期:      2012-8-22
----------------------------------------------}

procedure TMainFrm.CdsTermOrderInquiry(m_FrameHead: TCDSTermSendCommFrameHead; m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
var
  m_TermRecvFrameHead: TCDSTermRecvCommFrameHead;
  m_TempPatientIf: PCDSPatientInfo;
  m_OrderInquiry: TCDSOrderInquiry;
  m_CardCommuDtLength: Cardinal;
  m_StrSql, m_StrTempNum: string;
  m_WLengthHigh, m_WLengthLow: word;
  m_BlCheck: boolean;
  m_SendBuffer: array[1..4096] of byte;
  m_CRCCheck: Char;
begin
  m_BlCheck := true;
  m_CardCommuDtLength := CalCommuDataLength(m_FrameHead.m_WLengthHigh, m_FrameHead.m_WLengthLow);
  if m_CardCommuDtLength <> (m_BufLenth - 1 - TermSendFrameHeadLth) then
  begin
    m_TermRecvFrameHead.m_sgType := sgIllegalData;
    m_BlCheck := false;
  end
  else
  begin
    ReadBuffer((m_RecvBuf + m_BufLenth - 1)^, m_CRCCheck, 1);
    if (m_CRCCheck <> CalCrc_8(m_RecvBuf, m_BufLenth - 1)) then
    begin
      m_TermRecvFrameHead.m_sgType := sgCRCFailed;
      m_BlCheck := false;
    end
    else
      m_TermRecvFrameHead.m_sgType := sgCommunicationSuccess;
  end;

  if m_BlCheck then
  begin

     //寻找病人信息
    m_TempPatientIf := FindPatientByTermNum(inttostr(m_FrameHead.m_CarTermNum));
    try

    // 查询HIS数据库
      m_StrSql := 'select doctAdviceContent from cds_doct_advice_info ';
      with TADOQuery.Create(nil) do
      begin
        try
        //连接数据库并查找记录
          ConnectionString := g_StrConnectStr;
          Close;
          SQL.Clear;
          SQL.Add(m_StrSql);
          open;
          if not IsEmpty then
            m_OrderInquiry.m_StrOrderInquiry := fieldbyname(
              'doctAdviceContent').asstring
          else
            m_OrderInquiry.m_StrOrderInquiry := '';
        finally
          m_TermRecvFrameHead.m_sgType := sgCommunicationSuccess;
          Free; //释放TQuery内存
        end;
      end;

    except
      m_TermRecvFrameHead.m_sgType := sgServerExeCuteFailed
    end;

  end;
      //反馈信息至终端
  m_TermRecvFrameHead.m_skType := m_FrameHead.m_skType;
  m_TermRecvFrameHead.m_CarTermNum := m_FrameHead.m_CarTermNum;
  if m_TermRecvFrameHead.m_sgType = sgCommunicationSuccess then
  begin
    m_TermRecvFrameHead.m_WLenthHigh := 0;
    m_TermRecvFrameHead.m_WLenthLow := sizeOf(m_OrderInquiry);
    CopyMemory(@m_SendBuffer[1], @m_TermRecvFrameHead, SizeOf(m_TermRecvFrameHead));
    CopyMemory(@m_SendBuffer[1 + TermRecvFrameHeadLth], @m_OrderInquiry, SizeOf(m_OrderInquiry));
    m_CRCCheck := CalCrc_8(@m_SendBuffer[1], TermRecvFrameHeadLth);
    CopyMemory(@m_SendBuffer[1 + TermRecvFrameHeadLth + SizeOf(m_OrderInquiry)], @m_CRCCheck, 1);
    _RPTcpServer.SendData(m_Iocpsocket, @m_SendBuffer[1], 1 +
      TermRecvFrameHeadLth + SizeOf(m_OrderInquiry));
  end
  else
  begin
    m_TermRecvFrameHead.m_WLenthHigh := 0;
    m_TermRecvFrameHead.m_WLenthLow := 0;
    CopyMemory(@m_SendBuffer[1], @m_TermRecvFrameHead, SizeOf(m_TermRecvFrameHead));
    m_CRCCheck := CalCrc_8(@m_SendBuffer[1], TermRecvFrameHeadLth);
    CopyMemory(@m_SendBuffer[1 + TermRecvFrameHeadLth], @m_CRCCheck, 1);
    _RPTcpServer.SendData(m_Iocpsocket, @m_SendBuffer[1], 1 +
      TermRecvFrameHeadLth);
  end;
end;

{--------------------------------------------
过程名:
功能描述:      客户端在线检测
参数描述：
创建日期:      2012-8-22
----------------------------------------------}

procedure TMainFrm.CdsClientOnlineCheck(m_FrameHead: TCDSTermSendCommFrameHead; m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
var
  m_ClientRecvFrameHead: TCDSClientRecvCommFrameHead;
  m_TempClient: PCDSClientEmployee;
  m_CardCommuDtLength: Cardinal;
  m_SendBuffer: array[1..4096] of byte;
  m_CRCCheck: Char;
begin
  m_CardCommuDtLength := CalCommuDataLength(m_FrameHead.m_WLengthHigh, m_FrameHead.m_WLengthLow);
  if m_CardCommuDtLength <> 0 then
  begin
    m_ClientRecvFrameHead.m_sgType := sgIllegalData;
  end
  else
  begin

    ReadBuffer((m_RecvBuf + m_BufLenth - 1)^, m_CRCCheck, 1);
    if (m_CRCCheck <> CalCrc_8(m_RecvBuf, m_BufLenth - 1)) then
    begin
      m_ClientRecvFrameHead.m_sgType := sgCRCFailed;
    end
    else
    begin
      m_TempClient := FindClientBySocket(m_Iocpsocket);
      if m_TempClient = nil then
        m_ClientRecvFrameHead.m_sgType := sgClientSocketNotRegist
      else
      begin
        m_TempClient.m_CrdLastActive := GetTickCount;
        m_ClientRecvFrameHead.m_sgType := sgCommunicationSuccess;
      end;
    end;
  end;
  m_ClientRecvFrameHead.m_skType := m_FrameHead.m_skType;
  m_ClientRecvFrameHead.m_CarClientNum := m_FrameHead.m_CarTermNum;
  m_ClientRecvFrameHead.m_WLenthHigh := 0;
  m_ClientRecvFrameHead.m_WLenthLow := 0;
  CopyMemory(@m_SendBuffer[1], @m_ClientRecvFrameHead, SizeOf(m_ClientRecvFrameHead));
  m_CRCCheck := CalCrc_8(@m_SendBuffer[1], ClientRecvFrameHeadLth);
  CopyMemory(@m_SendBuffer[1 + ClientRecvFrameHeadLth], @m_CRCCheck, 1);
  _RPTcpServer.SendData(m_Iocpsocket, @m_SendBuffer[1], 1 +
    ClientRecvFrameHeadLth);

end;

{--------------------------------------------
过程名:
功能描述:      客户端确认呼叫
参数描述：
创建日期:      2012-8-22
----------------------------------------------}

procedure TMainFrm.CdsClientConfirmCall(m_FrameHead: TCDSTermSendCommFrameHead; m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
var
  m_TermRecvFrameHead: TCDSTermRecvCommFrameHead;
  m_TempTerm: PCDSTermEmployee;
  m_CardCommuDtLength: Cardinal;
  m_SendBuffer: array[1..4096] of AnsiChar;
  m_sgType, m_CRCCheck: Char;
  m_StrTempNum: Cardinal;
begin
  ReadBuffer((m_RecvBuf + ClientRecvFrameHeadLth)^, m_StrTempNum, sizeof(m_StrTempNum));
  m_TempTerm := FindTermByTermNum(inttostr(m_FrameHead.m_CarTermNum));
  if (m_TempTerm <> nil) and ((m_TempTerm.m_IocpSocket <> nil)) then
  begin
    //判断通信是否成功
    ReadBuffer((m_RecvBuf + ClientSendFrameHeadLth)^, m_sgType, 1);
    if m_sgType = sgCommunicationSuccess then
    begin
    //计算校验
      ReadBuffer((m_RecvBuf + m_BufLenth - 1)^, m_CRCCheck, 1);
      if (m_CRCCheck <> CalCrc_8(m_RecvBuf, m_BufLenth - 1)) then
      begin
        m_TermRecvFrameHead.m_sgType := sgCRCFailed;
      end
      else
        m_TermRecvFrameHead.m_sgType := sgCommunicationSuccess;
    end
    else
      m_TermRecvFrameHead.m_sgType := m_sgType;
    m_TermRecvFrameHead.m_skType := m_FrameHead.m_skType;
    m_TermRecvFrameHead.m_CarTermNum := m_FrameHead.m_CarTermNum;
    m_TermRecvFrameHead.m_WLenthHigh := 0;
    m_TermRecvFrameHead.m_WLenthLow := 0;
    CopyMemory(@m_SendBuffer[1], @m_TermRecvFrameHead, SizeOf(m_TermRecvFrameHead));
    m_CRCCheck := CalCrc_8(@m_SendBuffer[1], TermRecvFrameHeadLth);
    CopyMemory(@m_SendBuffer[1 + TermRecvFrameHeadLth], @m_CRCCheck, 1);
    _RPTcpServer.SendData(m_Iocpsocket, @m_SendBuffer[1], 1 +
      TermRecvFrameHeadLth);
  end;

end;


{--------------------------------------------
过程名:
功能描述:      客户端显示时间控制
参数描述：
创建日期:      2012-8-22
----------------------------------------------}

procedure TMainFrm.CdsClientTimeControl(m_FrameHead: TCDSTermSendCommFrameHead; m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
var
  m_ClientRecvFrameHead: TCDSClientRecvCommFrameHead;
  m_TempTerm: PCDSTermEmployee;
  m_CardCommuDtLength: Cardinal;
  m_SendBuffer: array[1..4096] of byte;
  m_BlCheck: boolean;
  m_CRCCheck: Char;
  m_IntiLoop: integer;
  m_StrTempNum: Cardinal;
begin
  m_BlCheck := true;
  m_CardCommuDtLength := CalCommuDataLength(m_FrameHead.m_WLengthHigh, m_FrameHead.m_WLengthLow);
  if m_CardCommuDtLength <> 0 then
  begin
    m_ClientRecvFrameHead.m_sgType := sgIllegalData;
    m_BlCheck := false;
  end
  else
  begin
    ReadBuffer((m_RecvBuf + m_BufLenth - 1)^, m_CRCCheck, 1);
    if (m_CRCCheck <> CalCrc_8(m_RecvBuf, m_BufLenth - 1)) then
    begin
      m_ClientRecvFrameHead.m_sgType := sgCRCFailed;
      m_BlCheck := false;
    end
    else
      m_ClientRecvFrameHead.m_sgType := sgCommunicationSuccess;
  end;
  if m_BlCheck then
  begin
    ReadBuffer((m_RecvBuf + ClientSendFrameHeadLth)^, m_StrTempNum, sizeof(m_StrTempNum));
      //寻找终端
    m_TempTerm := FindTermByTermNum(inttostr(m_StrTempNum));
    if (m_TempTerm <> nil) and (m_TempTerm.m_Iocpsocket <> nil) then
    begin
          //转发控制请求至终端端

     // m_TempTerm.m_Iocpsocket.AsyncSend(m_RecvBuf, m_BufLenth, 0, 0);
    end
    else
    begin
        //反馈客户端
      m_ClientRecvFrameHead.m_sgType := sgTermNotOnline;
      m_ClientRecvFrameHead.m_skType := m_FrameHead.m_skType;
      m_ClientRecvFrameHead.m_CarClientNum := m_FrameHead.m_CarTermNum;
      m_ClientRecvFrameHead.m_WLenthHigh := 0;
      m_ClientRecvFrameHead.m_WLenthLow := 0;
      CopyMemory(@m_SendBuffer[1], @m_ClientRecvFrameHead, SizeOf(m_ClientRecvFrameHead));
      m_CRCCheck := CalCrc_8(@m_SendBuffer[1], ClientRecvFrameHeadLth);
      CopyMemory(@m_SendBuffer[1 + ClientRecvFrameHeadLth], @m_CRCCheck, 1);
      _RPTcpServer.SendData(m_Iocpsocket, @m_SendBuffer[1], 1 +
        ClientRecvFrameHeadLth);
    end;
  end
  else
  begin //直接反馈失败信息至终端
    m_ClientRecvFrameHead.m_skType := m_FrameHead.m_skType;
    m_ClientRecvFrameHead.m_CarClientNum := m_FrameHead.m_CarTermNum;
    m_ClientRecvFrameHead.m_WLenthHigh := 0;
    m_ClientRecvFrameHead.m_WLenthLow := 0;
    CopyMemory(@m_SendBuffer[1], @m_ClientRecvFrameHead, SizeOf(m_ClientRecvFrameHead));
    m_CRCCheck := CalCrc_8(@m_SendBuffer[1], ClientRecvFrameHeadLth);
    CopyMemory(@m_SendBuffer[1 + ClientRecvFrameHeadLth], @m_CRCCheck, 1);
    _RPTcpServer.SendData(m_Iocpsocket, @m_SendBuffer[1], 1 +
      ClientRecvFrameHeadLth);
  end;

end;

{--------------------------------------------
过程名:
功能描述:      客户端注册
参数描述：
创建日期:      2012-8-22
----------------------------------------------}

procedure TMainFrm.CdsClientLogin(m_FrameHead: TCDSTermSendCommFrameHead; m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
var
  m_ClientRecvFrameHead: TCDSClientRecvCommFrameHead;
  m_TempClient: PCDSClientEmployee;
  m_CardCommuDtLength: Cardinal;
  m_SendBuffer: array[1..4096] of byte;
  m_CRCCheck: Char;
  m_BlCheck: boolean;
begin
  m_BlCheck := true;
  m_CardCommuDtLength := CalCommuDataLength(m_FrameHead.m_WLengthHigh, m_FrameHead.m_WLengthLow);
  if m_CardCommuDtLength <> 0 then
  begin
    m_ClientRecvFrameHead.m_sgType := sgIllegalData;
    m_BlCheck := false;
  end
  else
  begin
    ReadBuffer((m_RecvBuf + m_BufLenth - 1)^, m_CRCCheck, 1);
    if (m_CRCCheck <> CalCrc_8(m_RecvBuf, m_BufLenth - 1)) then
    begin
      m_ClientRecvFrameHead.m_sgType := sgCRCFailed;
      m_BlCheck := false;
    end
    else
      m_ClientRecvFrameHead.m_sgType := sgCommunicationSuccess;
  end;

  if m_BlCheck then
  begin
     //寻找终端
    m_TempClient := FindClientByUserNum(inttostr(m_FrameHead.m_CarTermNum));
    if m_TempClient <> nil then
      m_TempClient.m_Iocpsocket := m_Iocpsocket
    else
      m_ClientRecvFrameHead.m_sgType := sgClientNotRegist;

  end;
  m_ClientRecvFrameHead.m_skType := m_FrameHead.m_skType;
  m_ClientRecvFrameHead.m_CarClientNum := m_FrameHead.m_CarTermNum;
  m_ClientRecvFrameHead.m_WLenthHigh := 0;
  m_ClientRecvFrameHead.m_WLenthLow := 0;
  CopyMemory(@m_SendBuffer[1], @m_ClientRecvFrameHead, SizeOf(m_ClientRecvFrameHead));
  m_CRCCheck := CalCrc_8(@m_SendBuffer[1], ClientRecvFrameHeadLth);
  CopyMemory(@m_SendBuffer[1 + ClientRecvFrameHeadLth], @m_CRCCheck, 1);
  _RPTcpServer.SendData(m_Iocpsocket, @m_SendBuffer[1], 1 +
    ClientRecvFrameHeadLth);
end;


{--------------------------------------------
过程名:
功能描述:     终端反馈显示时间控制
参数描述：
创建日期:      2012-8-22
----------------------------------------------}

procedure TMainFrm.CdsTermTimeControlResult(m_FrameHead: TCDSTermSendCommFrameHead; m_RecvBuf: pchar; m_BufLenth: integer; m_Iocpsocket: TRPClientContext);
var
  m_TermRecvFrameHead: TCDSTermRecvCommFrameHead;
  m_TempClient: PCDSClientEmployee;
  m_SendBuffer: array[1..4096] of byte;
  m_sgType, m_CRCCheck: Char;
begin
  m_TempClient := FindClientByUserNum(inttostr(m_FrameHead.m_CarTermNum));
  if (m_TempClient <> nil) and (m_TempClient.m_IocpSocket <> nil) then
  begin
    //判断通信是否成功
    ReadBuffer((m_RecvBuf + TermSendFrameHeadLth)^, m_sgType, 1);
    if m_sgType = sgCommunicationSuccess then
    begin
    //计算校验
      ReadBuffer((m_RecvBuf + m_BufLenth - 1)^, m_CRCCheck, 1);
      if (m_CRCCheck <> CalCrc_8(m_RecvBuf, m_BufLenth - 1)) then
      begin
        m_TermRecvFrameHead.m_sgType := sgCRCFailed;
      end
      else
      begin
        m_TermRecvFrameHead.m_sgType := sgCommunicationSuccess;
      end;
    end
    else
      m_TermRecvFrameHead.m_sgType := m_sgType;
    m_TermRecvFrameHead.m_skType := m_FrameHead.m_skType;
    m_TermRecvFrameHead.m_CarTermNum := m_FrameHead.m_CarTermNum;
    m_TermRecvFrameHead.m_WLenthHigh := 0;
    m_TermRecvFrameHead.m_WLenthLow := 0;
    CopyMemory(@m_SendBuffer[1], @m_TermRecvFrameHead, SizeOf(m_TermRecvFrameHead));
    m_CRCCheck := CalCrc_8(@m_SendBuffer[1], TermRecvFrameHeadLth);
    CopyMemory(@m_SendBuffer[1 + TermRecvFrameHeadLth], @m_CRCCheck, 1);
    _RPTcpServer.SendData(m_Iocpsocket, @m_SendBuffer[1], 1 +
      TermRecvFrameHeadLth);
  end;
end;


{--------------------------------------------
过程名:
功能描述:     服务器信息监测显示
参数描述：
创建日期:      2012-8-23
----------------------------------------------}

procedure TMainFrm.m_ServerInfoUpdateTimerTimer(Sender: TObject);
var
  m_TempClient: PCDSClientEmployee;
  m_TempTerm: PCDSTermEmployee;
  m_IntjLoop, m_ClientOnLineCount, m_TermOnLineCount: integer;
begin
  with g_ThrdlstClientEmployees.LockList do
  try
    m_ClientOnLineCount := 0;
    for m_IntjLoop := Count - 1 downto 0 do
    begin
      m_TempClient := Items[m_IntjLoop];
      if (GetTickCount - m_TempClient.m_CrdLastActive > m_ServerInfoUpdateTimer.Interval * 2) then
      begin
        m_TempClient.m_IocpSocket := nil;
      end
      else
        Inc(m_ClientOnLineCount);
    end;

    m_LblEmployeeCount.Caption := IntToStr(m_ClientOnLineCount);
  finally
    g_ThrdlstClientEmployees.UnlockList;
  end;

  with g_ThrdlstTermEmployees.LockList do
  try
    m_TermOnLineCount := 0;
    for m_IntjLoop := Count - 1 downto 0 do
    begin
      m_TempTerm := Items[m_IntjLoop];
      if (GetTickCount - m_TempTerm.m_CrdLastActive > m_ServerInfoUpdateTimer.Interval * 2) then
      begin
        m_TempTerm.m_IocpSocket := nil;

      end
      else
        Inc(m_TermOnLineCount);
    end;

    m_LblTermCount.Caption := IntToStr(m_TermOnLineCount);
  finally
    g_ThrdlstTermEmployees.UnlockList;
  end;
end;

{--------------------------------------------
过程名:
功能描述:     窗口显示
参数描述：
创建日期:      2012-8-23
----------------------------------------------}

procedure TMainFrm.PopMenu_ShowMainWindowClick(Sender: TObject);
begin
  Tray.RestoreApp;
end;
{--------------------------------------------
过程名:
功能描述:     窗口隐藏
参数描述：
创建日期:      2012-8-23
----------------------------------------------}

procedure TMainFrm.PopMenu_HideMainWindowClick(Sender: TObject);
begin
  Tray.MinimizeApp;
end;

{--------------------------------------------
过程名:
功能描述:     窗口退出
参数描述：
创建日期:      2012-8-23
----------------------------------------------}

procedure TMainFrm.PopMenu_ExitClick(Sender: TObject);
begin
  close;
end;

{--------------------------------------------
过程名:
功能描述:     窗口隐藏
参数描述：
创建日期:      2012-8-23
----------------------------------------------}

procedure TMainFrm.m_AppMinSizwClick(Sender: TObject);
begin
  Tray.MinimizeApp;
end;

{--------------------------------------------
过程名:
功能描述:     窗口退出
参数描述：
创建日期:      2012-8-23
----------------------------------------------}

procedure TMainFrm.m_AppCloseClick(Sender: TObject);
begin
  close;
end;

initialization
  IsMultiThread := True;

end.


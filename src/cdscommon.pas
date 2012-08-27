 {------------------------------------------------}
 //文件名:         CdsCommon.pas
 //描述:          结构体，全局变量，全局函数定义
 //版本号:        1.0
 //创建日期:      2012-8-11
 //IDE 环境:      D7
 //字符编码：     UTF-8
 //作者:         VicTech
 //版本所有：
 //版本修改历史：
 // 2012-8-11 VicTech 创建文件
 {------------------------------------------------}
unit CdsCommon;


interface
uses
  Forms, Classes, DB, ADODB, SysUtils, winsock, uRPSocketEngine;

const
  //命令字码表

  skTermOnlineCheck: Char = #1; //心跳
  skTermCall: Char = #2; //病房呼叫
  skTermCheckCard: Char = #3; //查房刷卡
  skTermCheckSec: Char = #4; //二次应答刷卡
  skTermTimeControl: Char = #5; //时间控制
  skTermDrugScan: Char = #6; //药品扫描
  skTermOrderInquiry: Char = #7; //医嘱查询
  skTermLogin: Char = #99; //医嘱查询

  skClientLogin: Char = #100;
  skClientOnlineCheck: Char = #101;
  skClientCallReturn: Char = #102;
  skClientTimeControl: Char = #103;
const
  //通信标志字码表
  sgCommunicationSuccess: char = #0; //通信成功
  sgDataSendComplete: char = #1; //数据发送完毕

  sgTermSocketNotRegist: char = #245; //客户端TCP套接字未在服务器登记
  sgClientSocketNotRegist: char = #246; //客户端TCP套接字未在服务器登记
  sgClientNotRegist: char = #247; //客户端用户未在服务器登记
  sgTermNotRegist: char = #248; //终端未在服务器登记
  sgTermNotOnline: char = #249; //终端离线
  sgServerExeCuteFailed: char = #250; //服务器执行失败
  sgClientExeCuteFailed: char = #251; //客户端执行失败
  sgCantFindClient: char = #252; //未找到客户端
  sgIllegalData: char = #253; //非法数据
  sgIllegalCommand: char = #254; //非法命令
  sgCRCFailed: char = #255; //CRC校验失败

const
  TermSendFrameHeadLth = 9;
  TermRecvFrameHeadLth = 10;
  ClientSendFrameHeadLth = 9;
  ClientRecvFrameHeadLth = 10;

const
  RoleAdmin='管理员';
  RoleNurse='护士';
  RoleDoctor='医生';

const
  CharRoleIllegal: char =#0;
  CharRoleNurse: char =#1;
  CharRoleDoctor: char =#2;
  CharRoleAdmin: char =#3;
  CharRoleOther: char =#4;


//结构体定义
type
  TCDSSQLServerInfo =packed record
    m_StrDataSourceIP,
      m_StrServerName,
      m_StrDataBase,
      m_StrUserName,
      m_StrPassWord: string;
  end;

  TCDSServerConfig =packed record //服务器配置
    m_SQLServer: TCDSSQLServerInfo;
    m_DataServerPort: Integer;
    m_IntfServerPort: Integer;
    m_CommunicateServerPort: Integer;
    m_DetectTimeout: Integer;
    m_DetectInterval: Integer;
    m_LocalIP: string;
    m_Started: Boolean;
  end;
  TCDSLastLoginUser =packed record //上次用户信息
    m_BlPsdChecked: boolean;
    m_StrUserNum: string[20];
    m_StrUserPsd: string[20];
    m_StrUserRole: string[20];

  end;

  TCDSCurrentLoginUser =packed record //用户信息
    m_BlPsdChecked: boolean;
    m_StrUserNum: string[20];
    m_StrUserPsd: string[20];
    m_StrUserRole: string[20];
  end;

  PCDSClientEmployee = ^TCDSClientEmployee;
  TCDSClientEmployee =packed record //客户端用户
    m_StrUserNum,
      m_StrUserName,
      m_StrUserRole,
      m_StrUserPost: string[20];
    m_CrdLastActive: Cardinal;
    m_IocpSocket: TRPClientContext;
  end;

  PCDSTermEmployee = ^TCDSTermEmployee;
  TCDSTermEmployee =packed record //终端用户
    m_StrTermNum,
      m_StrBedNum,
      m_StrfloorNum,
      m_StrRoomNum,
      m_StrNurseNum1,
      m_StrNurseName1,
      m_StrNurseNum2,
      m_StrNurseName2,
      m_StrNurseNum3,
      m_StrNurseName3,
      m_StrNurseNum4,
      m_StrNurseName4,
      m_StrHeadNurseNum,
      m_StrHeadNurseName: string[20];
    m_CrdLastActive: Cardinal;
    m_IocpSocket: TRPClientContext;
  end;

  PCDSPatientInfo = ^TCDSPatientInfo;
  TCDSPatientInfo =packed record //病人信息
    m_StrTermNum,
      m_StrBedNum,
      m_StrPatientNum,
      m_StrPatientName: string[20];
  end;

  PCDSTermSendCommFrameHead = ^TCDSTermSendCommFrameHead;
  TCDSTermSendCommFrameHead = packed record //终端发送帧头
    m_skType: char;
    m_CarTermNum: cardinal ;
    m_WLengthHigh: Word;
    m_WLengthLow: Word;
  end;

  PCDSTermRecvCommFrameHead = ^TCDSTermRecvCommFrameHead;
  TCDSTermRecvCommFrameHead =packed record //终端接收帧头
    m_skType: char;
    m_CarTermNum: Cardinal;
    m_WLenthHigh: Word;
    m_WLenthLow: Word;
    m_sgType: char;
  end;

  PCDSClientSendCommFrameHead = ^TCDSClientSendCommFrameHead;
  TCDSClientSendCommFrameHead =packed record //客户端发送帧头
    m_skType: char;
    m_CarClientNum: Cardinal;
    m_WLengthHigh: Word;
    m_WLengthLow: Word;
  end;

  PCDSClientRecvCommFrameHead = ^TCDSClientRecvCommFrameHead;
  TCDSClientRecvCommFrameHead =packed record //客户端接收帧头
    m_skType: char;
    m_CarClientNum: Cardinal;
    m_WLenthHigh: Word;
    m_WLenthLow: Word;
    m_sgType: char;
  end;


  TCDSClientRecvCallDtInfo =packed record //客户端接收呼叫信息
    m_StrBedNum,
      m_StrPatientNum,
      m_StrPatientName: string[20];
    m_DateTCallTime: TDateTime;
  end;

  TCDSTermCheckCard =packed record //终端发送查房信息
    m_CardUserNum: Cardinal;
    m_CheckCardTime: TDateTime;
    m_CheckResult: string[20];
  end;

   TCDSTermCheckCardResult =packed record //查房信息反馈
    m_CheckCardReturnResult:char;
  end;

  TCDSTermCheckSec =packed record //终端发送二次应答信息
    m_CardUserNum: Cardinal;
    m_CheckSecTime: TDateTime;
  end;

  TCDSInspectionTableInfo =packed record //查房数据库表信息
    m_StrBedNum,
      m_StrExecutorNum,
      m_StrExecutorName,
      m_StrPatientNum,
      m_StrPatientName,
      m_InspectionResult: string[20];
    m_ExecuteTime: TDateTime;
  end;

  TCDSTimeControl =packed record //终端开关机时间
    m_CardTermNum: Cardinal;
    m_StartTime: TDateTime;
    m_StoptTime: TDateTime;
  end;

  TCDSDrugScan =packed record //终端药品扫描
    m_StrDrugNum: Cardinal;
  end;

  TCDSDrugScanResult =packed record //返回终端药品扫描结果
    m_StrDrugScanResult: char; //1——匹配成功 0——匹配失败
  end;

  TCDSOrderInquiry =packed record //返回终端药品扫描结果
    m_StrOrderInquiry: string[100]; //1——匹配成功 0——匹配失败
  end;

  //全局函数或过程
function FPExecSQL_Q(m_ADOQuery: TADOQuery; m_SQLStr: string; m_IsOpen: Boolean): string;
function GetLocalIP(var m_LocalIp: string): Boolean; //得到本机的局域网Ip地址
function CalCrc_8(m_ByteArray: pchar; m_ByLen: integer): char;
function CalCommuDataLength(m_WLengthHigh, m_WLengthLow: Word): Cardinal;
function CalLthToWord(var m_WLengthHigh, m_WLengthLow: Word; m_DtSource: Cardinal): boolean;
procedure AddLog(m_Msg: string);
procedure ReadBuffer(var BufferSource; var ABuffer; const AByteCount: Integer);
  //全局变量
var
  g_CDSLastLoginUser: TCDSLastLoginUser; //上次用户相关信息
  g_CDSCurrentLoginUser: TCDSCurrentLoginUser; //用户相关信息
  g_CDSServerInfo: TCDSServerConfig;
  g_StrConnectStr: string; //数据库连接字符串
  g_TermOnlineNum:integer;//在线终端数量

implementation

{--------------------------------------------------------
 函数名:       FPExecSQL_Q
 功能描述:      SQL执行
 参数描述：      AADOQuery；数据库执行组件
                   ASQLStr：  SQL字符串
                   IsOpen：   打开库判断
 函数返回：      返回SQL执行结果
 备注：
 创建日期:      2012-8-11
----------------------------------------------------------}

function FPExecSQL_Q(m_ADOQuery: TADOQuery; m_SQLStr: string; m_IsOpen: Boolean): string;
begin
  result := '';
  m_ADOQuery.Close;
  m_ADOQuery.Sql.Text := m_SQLStr;
  try
    if m_IsOpen = True then
    begin
      m_ADOQuery.Open;
      m_ADOQuery.First;
    end
    else
    begin
      m_ADOQuery.ExecSql;
      m_ADOQuery.Close;
    end;
  except
    on E: Exception do
    begin
      m_ADOQuery.Close;
      result := E.Message;
      exit;
    end;
  end;
end;

{-------------------------------------------------------
 过程名:         AddLog
 功能描述:      添加日志
 参数描述：      Msg；日志消息
 备注：
 创建日期:      2012-8-14
-------------------------------------------------------}

procedure AddLog(m_Msg: string);
var
  m_FileStream: TFileStream;
  m_LogFile: string;
begin
  try
    m_Msg := '[' + DateTimeToStr(Now) + '] ' + m_Msg;

    m_LogFile := ExtractFilePath(Application.ExeName) + '\Logs\' + DateToStr(Now) + '.log';
    if not DirectoryExists(ExtractFilePath(m_LogFile)) then
      CreateDir(ExtractFilePath(m_LogFile));

    if FileExists(m_LogFile) then
      m_FileStream := TFileStream.Create(m_LogFile, fmOpenWrite or fmShareDenyNone)
    else
      m_FileStream := TFileStream.Create(m_LogFile, fmCreate or fmShareDenyNone);
    m_FileStream.Position := m_FileStream.Size;

    m_Msg := m_Msg + #13#10;
    m_FileStream.Write(PChar(m_Msg)^, Length(m_Msg));
    m_FileStream.Free;

  except

  end;
end;


{--------------------------------------------------
  函数名:       GetLocalIP
 功能描述:      返回本机的局域网Ip地址
 参数描述：     无
 函数返回：     成功: True, 并填充LocalIp 失败: False
 备注：
 创建日期:      2012-8-16
---------------------------------------------------}

function GetLocalIP(var m_LocalIp: string): Boolean;
var
  m_HostEnt: PHostEnt;
  m_StrIP: string;
  m_Addr: PChar;
  m_Buffer: array[0..63] of Char;
  m_WSData: TWSADATA;
begin
  Result := False;
  try
    WSAStartUp(2, m_WSData);
    GetHostName(m_Buffer, SizeOf(m_Buffer));
    m_HostEnt := GetHostByName(m_Buffer);
    if m_HostEnt = nil then exit;
    m_Addr := m_HostEnt^.h_addr_list^;
    m_StrIP := Format('%d.%d.%d.%d', [Byte(m_Addr[0]), Byte(m_Addr[1]),
      Byte(m_Addr[2]), Byte(m_Addr[3])]
        );
    m_LocalIp := m_StrIP;
    Result := True;
  finally
    WSACleanup;
  end;
end;

{--------------------------------------------------
  函数名:       CalCrc_8
 功能描述:      计算CRC
 参数描述：     m_ByteArray——Byte数组   m_ByLen——数组长度
 函数返回：    CRC值
 备注：
 创建日期:      2012-8-19
---------------------------------------------------}

function CalCrc_8(m_ByteArray: pchar; m_ByLen: integer): char;
var
  m_Byj, m_ByCbit, m_ByAout, m_ByCrc, m_ByCrc_a, m_ByCrc_b: Byte;
  m_Inti: integer;
begin
  m_ByCrc := 0;
  m_Inti := 0;

// 取移位的位
  repeat
    m_ByCrc_a := ord((m_ByteArray + m_Inti)^);
    inc(m_Inti);
    m_Byj := 8;
    m_ByCbit := 1;
    repeat
      m_ByCrc_b := m_ByCrc_a;
      m_ByCrc_b := m_ByCrc_b xor m_ByCrc;
      m_ByAout := m_ByCrc_b and m_ByCbit;
      if m_ByAout <> 0 then begin
        m_ByCrc := m_ByCrc xor $18;
        m_ByCrc := m_ByCrc shr 1;
        m_ByCrc := m_ByCrc or $80;
      end else begin
        m_ByCrc := m_ByCrc shr 1;
      end;
      m_ByCrc_a := m_ByCrc_a shr 1;
      dec(m_Byj);
    until m_Byj = 0;
    dec(m_ByLen);
  until m_ByLen = 0;

  result := chr(m_ByCrc);
end;


{--------------------------------------------------
  函数名:       CalCommuDataLength
 功能描述:      计算CRC通信帧数据字节长度
 参数描述：     m_WLengthHigh——高位   m_WLengthLow——低位
 函数返回：    CRC值
 备注：
 创建日期:      2012-8-19
---------------------------------------------------}

function CalCommuDataLength(m_WLengthHigh, m_WLengthLow: Word): Cardinal;
var
  m_DtLength: Cardinal;
  m_HighLow: array[0..1] of Word absolute m_DtLength;
begin
  m_HighLow[0] := m_WLengthHigh;
  m_HighLow[1] := m_WLengthLow;
  result := m_DtLength;
end;

{--------------------------------------------------
  函数名:       CalLthToWord
 功能描述:      将4byte字节分解成二字节
 参数描述：      m_WLengthHigh——高位   m_WLengthLow——低位, m_DtSource——数据源
 函数返回：    True——成功，false——失败
 备注：
 创建日期:      2012-8-21
---------------------------------------------------}

function CalLthToWord(var m_WLengthHigh, m_WLengthLow: Word; m_DtSource: Cardinal): boolean;
var
  m_DtLength: Cardinal;
  m_HighLow: array[0..1] of Word absolute m_DtLength;
begin
  result := true;
  try
    m_DtLength := m_DtSource;
    m_WLengthHigh := m_HighLow[0];
    m_WLengthLow := m_HighLow[1];

  except
    result := false;

  end;
end;

{--------------------------------------------------
  过程名:       ReadBuffer
 功能描述:      将4byte字节分解成二字节
 参数描述：      m_WLengthHigh——高位   m_WLengthLow——低位, m_DtSource——数据源
 函数返回：    True——成功，false——失败
 备注：
 创建日期:      2012-8-22
---------------------------------------------------}

procedure ReadBuffer(var BufferSource; var ABuffer; const AByteCount: Integer);
begin
  if (AByteCount > 0) and (@ABuffer <> nil) and (@BufferSource <> nil) then begin
    Move(BufferSource, ABuffer, AByteCount);
  end;
end;


end.


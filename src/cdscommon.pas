 {------------------------------------------------}
 //�ļ���:         CdsCommon.pas
 //����:          �ṹ�壬ȫ�ֱ�����ȫ�ֺ�������
 //�汾��:        1.0
 //��������:      2012-8-11
 //IDE ����:      D7
 //�ַ����룺     UTF-8
 //����:         VicTech
 //�汾���У�
 //�汾�޸���ʷ��
 // 2012-8-11 VicTech �����ļ�
 {------------------------------------------------}
unit CdsCommon;


interface
uses
  Forms, Classes, DB, ADODB, SysUtils, winsock, uRPSocketEngine;

const
  //���������

  skTermOnlineCheck: Char = #1; //����
  skTermCall: Char = #2; //��������
  skTermCheckCard: Char = #3; //�鷿ˢ��
  skTermCheckSec: Char = #4; //����Ӧ��ˢ��
  skTermTimeControl: Char = #5; //ʱ�����
  skTermDrugScan: Char = #6; //ҩƷɨ��
  skTermOrderInquiry: Char = #7; //ҽ����ѯ
  skTermLogin: Char = #99; //ҽ����ѯ

  skClientLogin: Char = #100;
  skClientOnlineCheck: Char = #101;
  skClientCallReturn: Char = #102;
  skClientTimeControl: Char = #103;
const
  //ͨ�ű�־�����
  sgCommunicationSuccess: char = #0; //ͨ�ųɹ�
  sgDataSendComplete: char = #1; //���ݷ������

  sgTermSocketNotRegist: char = #245; //�ͻ���TCP�׽���δ�ڷ������Ǽ�
  sgClientSocketNotRegist: char = #246; //�ͻ���TCP�׽���δ�ڷ������Ǽ�
  sgClientNotRegist: char = #247; //�ͻ����û�δ�ڷ������Ǽ�
  sgTermNotRegist: char = #248; //�ն�δ�ڷ������Ǽ�
  sgTermNotOnline: char = #249; //�ն�����
  sgServerExeCuteFailed: char = #250; //������ִ��ʧ��
  sgClientExeCuteFailed: char = #251; //�ͻ���ִ��ʧ��
  sgCantFindClient: char = #252; //δ�ҵ��ͻ���
  sgIllegalData: char = #253; //�Ƿ�����
  sgIllegalCommand: char = #254; //�Ƿ�����
  sgCRCFailed: char = #255; //CRCУ��ʧ��

const
  TermSendFrameHeadLth = 9;
  TermRecvFrameHeadLth = 10;
  ClientSendFrameHeadLth = 9;
  ClientRecvFrameHeadLth = 10;

const
  RoleAdmin='����Ա';
  RoleNurse='��ʿ';
  RoleDoctor='ҽ��';

const
  CharRoleIllegal: char =#0;
  CharRoleNurse: char =#1;
  CharRoleDoctor: char =#2;
  CharRoleAdmin: char =#3;
  CharRoleOther: char =#4;


//�ṹ�嶨��
type
  TCDSSQLServerInfo =packed record
    m_StrDataSourceIP,
      m_StrServerName,
      m_StrDataBase,
      m_StrUserName,
      m_StrPassWord: string;
  end;

  TCDSServerConfig =packed record //����������
    m_SQLServer: TCDSSQLServerInfo;
    m_DataServerPort: Integer;
    m_IntfServerPort: Integer;
    m_CommunicateServerPort: Integer;
    m_DetectTimeout: Integer;
    m_DetectInterval: Integer;
    m_LocalIP: string;
    m_Started: Boolean;
  end;
  TCDSLastLoginUser =packed record //�ϴ��û���Ϣ
    m_BlPsdChecked: boolean;
    m_StrUserNum: string[20];
    m_StrUserPsd: string[20];
    m_StrUserRole: string[20];

  end;

  TCDSCurrentLoginUser =packed record //�û���Ϣ
    m_BlPsdChecked: boolean;
    m_StrUserNum: string[20];
    m_StrUserPsd: string[20];
    m_StrUserRole: string[20];
  end;

  PCDSClientEmployee = ^TCDSClientEmployee;
  TCDSClientEmployee =packed record //�ͻ����û�
    m_StrUserNum,
      m_StrUserName,
      m_StrUserRole,
      m_StrUserPost: string[20];
    m_CrdLastActive: Cardinal;
    m_IocpSocket: TRPClientContext;
  end;

  PCDSTermEmployee = ^TCDSTermEmployee;
  TCDSTermEmployee =packed record //�ն��û�
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
  TCDSPatientInfo =packed record //������Ϣ
    m_StrTermNum,
      m_StrBedNum,
      m_StrPatientNum,
      m_StrPatientName: string[20];
  end;

  PCDSTermSendCommFrameHead = ^TCDSTermSendCommFrameHead;
  TCDSTermSendCommFrameHead = packed record //�ն˷���֡ͷ
    m_skType: char;
    m_CarTermNum: cardinal ;
    m_WLengthHigh: Word;
    m_WLengthLow: Word;
  end;

  PCDSTermRecvCommFrameHead = ^TCDSTermRecvCommFrameHead;
  TCDSTermRecvCommFrameHead =packed record //�ն˽���֡ͷ
    m_skType: char;
    m_CarTermNum: Cardinal;
    m_WLenthHigh: Word;
    m_WLenthLow: Word;
    m_sgType: char;
  end;

  PCDSClientSendCommFrameHead = ^TCDSClientSendCommFrameHead;
  TCDSClientSendCommFrameHead =packed record //�ͻ��˷���֡ͷ
    m_skType: char;
    m_CarClientNum: Cardinal;
    m_WLengthHigh: Word;
    m_WLengthLow: Word;
  end;

  PCDSClientRecvCommFrameHead = ^TCDSClientRecvCommFrameHead;
  TCDSClientRecvCommFrameHead =packed record //�ͻ��˽���֡ͷ
    m_skType: char;
    m_CarClientNum: Cardinal;
    m_WLenthHigh: Word;
    m_WLenthLow: Word;
    m_sgType: char;
  end;


  TCDSClientRecvCallDtInfo =packed record //�ͻ��˽��պ�����Ϣ
    m_StrBedNum,
      m_StrPatientNum,
      m_StrPatientName: string[20];
    m_DateTCallTime: TDateTime;
  end;

  TCDSTermCheckCard =packed record //�ն˷��Ͳ鷿��Ϣ
    m_CardUserNum: Cardinal;
    m_CheckCardTime: TDateTime;
    m_CheckResult: string[20];
  end;

   TCDSTermCheckCardResult =packed record //�鷿��Ϣ����
    m_CheckCardReturnResult:char;
  end;

  TCDSTermCheckSec =packed record //�ն˷��Ͷ���Ӧ����Ϣ
    m_CardUserNum: Cardinal;
    m_CheckSecTime: TDateTime;
  end;

  TCDSInspectionTableInfo =packed record //�鷿���ݿ����Ϣ
    m_StrBedNum,
      m_StrExecutorNum,
      m_StrExecutorName,
      m_StrPatientNum,
      m_StrPatientName,
      m_InspectionResult: string[20];
    m_ExecuteTime: TDateTime;
  end;

  TCDSTimeControl =packed record //�ն˿��ػ�ʱ��
    m_CardTermNum: Cardinal;
    m_StartTime: TDateTime;
    m_StoptTime: TDateTime;
  end;

  TCDSDrugScan =packed record //�ն�ҩƷɨ��
    m_StrDrugNum: Cardinal;
  end;

  TCDSDrugScanResult =packed record //�����ն�ҩƷɨ����
    m_StrDrugScanResult: char; //1����ƥ��ɹ� 0����ƥ��ʧ��
  end;

  TCDSOrderInquiry =packed record //�����ն�ҩƷɨ����
    m_StrOrderInquiry: string[100]; //1����ƥ��ɹ� 0����ƥ��ʧ��
  end;

  //ȫ�ֺ��������
function FPExecSQL_Q(m_ADOQuery: TADOQuery; m_SQLStr: string; m_IsOpen: Boolean): string;
function GetLocalIP(var m_LocalIp: string): Boolean; //�õ������ľ�����Ip��ַ
function CalCrc_8(m_ByteArray: pchar; m_ByLen: integer): char;
function CalCommuDataLength(m_WLengthHigh, m_WLengthLow: Word): Cardinal;
function CalLthToWord(var m_WLengthHigh, m_WLengthLow: Word; m_DtSource: Cardinal): boolean;
procedure AddLog(m_Msg: string);
procedure ReadBuffer(var BufferSource; var ABuffer; const AByteCount: Integer);
  //ȫ�ֱ���
var
  g_CDSLastLoginUser: TCDSLastLoginUser; //�ϴ��û������Ϣ
  g_CDSCurrentLoginUser: TCDSCurrentLoginUser; //�û������Ϣ
  g_CDSServerInfo: TCDSServerConfig;
  g_StrConnectStr: string; //���ݿ������ַ���
  g_TermOnlineNum:integer;//�����ն�����

implementation

{--------------------------------------------------------
 ������:       FPExecSQL_Q
 ��������:      SQLִ��
 ����������      AADOQuery�����ݿ�ִ�����
                   ASQLStr��  SQL�ַ���
                   IsOpen��   �򿪿��ж�
 �������أ�      ����SQLִ�н��
 ��ע��
 ��������:      2012-8-11
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
 ������:         AddLog
 ��������:      �����־
 ����������      Msg����־��Ϣ
 ��ע��
 ��������:      2012-8-14
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
  ������:       GetLocalIP
 ��������:      ���ر����ľ�����Ip��ַ
 ����������     ��
 �������أ�     �ɹ�: True, �����LocalIp ʧ��: False
 ��ע��
 ��������:      2012-8-16
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
  ������:       CalCrc_8
 ��������:      ����CRC
 ����������     m_ByteArray����Byte����   m_ByLen�������鳤��
 �������أ�    CRCֵ
 ��ע��
 ��������:      2012-8-19
---------------------------------------------------}

function CalCrc_8(m_ByteArray: pchar; m_ByLen: integer): char;
var
  m_Byj, m_ByCbit, m_ByAout, m_ByCrc, m_ByCrc_a, m_ByCrc_b: Byte;
  m_Inti: integer;
begin
  m_ByCrc := 0;
  m_Inti := 0;

// ȡ��λ��λ
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
  ������:       CalCommuDataLength
 ��������:      ����CRCͨ��֡�����ֽڳ���
 ����������     m_WLengthHigh������λ   m_WLengthLow������λ
 �������أ�    CRCֵ
 ��ע��
 ��������:      2012-8-19
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
  ������:       CalLthToWord
 ��������:      ��4byte�ֽڷֽ�ɶ��ֽ�
 ����������      m_WLengthHigh������λ   m_WLengthLow������λ, m_DtSource��������Դ
 �������أ�    True�����ɹ���false����ʧ��
 ��ע��
 ��������:      2012-8-21
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
  ������:       ReadBuffer
 ��������:      ��4byte�ֽڷֽ�ɶ��ֽ�
 ����������      m_WLengthHigh������λ   m_WLengthLow������λ, m_DtSource��������Դ
 �������أ�    True�����ɹ���false����ʧ��
 ��ע��
 ��������:      2012-8-22
---------------------------------------------------}

procedure ReadBuffer(var BufferSource; var ABuffer; const AByteCount: Integer);
begin
  if (AByteCount > 0) and (@ABuffer <> nil) and (@BufferSource <> nil) then begin
    Move(BufferSource, ABuffer, AByteCount);
  end;
end;


end.


 {
 //�ļ���:         CdsCommon.pas
 //����:          �ṹ�壬ȫ�ֱ�����ȫ�ֺ�������
 //�汾��:        1.0
 //��������:      2012-8-11
 //IDE ����:      D7
 //�ַ����룺     UTF-8
 //����:          VicTech
 //�汾���У�
 //�汾�޸���ʷ��
 // 2012-8-11 VicTech �����ļ�
 }
unit CdsCommon;


interface
uses
  DB, ADODB, SysUtils;

//�ṹ�嶨��
type
  TCDSSQLServerInfo = record
    m_StrDataSourceIP,
      m_StrServerName,
      m_StrDataBase,
      m_StrUserName,
      m_StrPassWord: string;
  end;

  TCDSServerConfig = record     //����������
    m_SQLServer: TCDSSQLServerInfo;
    m_DataServerPort: Integer;
    m_CommunicateServerPort: Integer;
    m_DetectTimeout: Integer;
    m_DetectInterval: Integer;
    m_Started: Boolean;
  end;
  TCDSLastLoginUser = record //�ϴ��û���Ϣ
    m_BlPsdChecked: boolean;
    m_StrUserNum: string[20];
    m_StrUserPsd: string[20];
    m_StrUserRole: string[20];

  end;

  TCDSCurrentLoginUser = record //�û���Ϣ
    m_BlPsdChecked: boolean;
    m_StrUserNum: string[20];
    m_StrUserPsd: string[20];
    m_StrUserRole: string[20];
  end;
  //ȫ�ֺ���
  function FPExecSQL_Q(AADOQuery: TADOQuery; ASQLStr: string; IsOpen:Boolean):string;
  //ȫ�ֱ���
var
  g_CDSLastLoginUser: TCDSLastLoginUser; //�ϴ��û������Ϣ
  g_CDSCurrentLoginUser: TCDSCurrentLoginUser; //�û������Ϣ
  g_CDSServerInfo: TCDSServerConfig;
  g_StrConnectStr: string; //���ݿ������ַ���


implementation

{/****************************************** /
 //������:       FPExecSQL_Q
 //��������:      SQLִ��
 //����������      AADOQuery�����ݿ�ִ�����
                   ASQLStr��  SQL�ַ���
                   IsOpen��   �򿪿��ж�
 //�������أ�      ����SQLִ�н��
 //��������:      2012-8-11
/**********************************************/}
function FPExecSQL_Q(AADOQuery: TADOQuery; ASQLStr: string; IsOpen: Boolean): string;
begin
  result := '';
  AADOQuery.Close;
  AADOQuery.Sql.Text := ASQLStr;
  try
    if IsOpen = True then
    begin
      AADOQuery.Open;
      AADOQuery.First;
    end
    else
    begin
      AADOQuery.ExecSql;
      AADOQuery.Close;
    end;
  except
    on E: Exception do
    begin
      AADOQuery.Close;
      result := E.Message;
      exit;
    end;
  end;
end;



end.


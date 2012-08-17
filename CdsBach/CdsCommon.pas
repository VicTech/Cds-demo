 {
 //文件名:         CdsCommon.pas
 //描述:          结构体，全局变量，全局函数定义
 //版本号:        1.0
 //创建日期:      2012-8-11
 //IDE 环境:      D7
 //字符编码：     UTF-8
 //作者:          VicTech
 //版本所有：
 //版本修改历史：
 // 2012-8-11 VicTech 创建文件
 }
unit CdsCommon;


interface
uses
  DB, ADODB, SysUtils;

//结构体定义
type
  TCDSSQLServerInfo = record
    m_StrDataSourceIP,
      m_StrServerName,
      m_StrDataBase,
      m_StrUserName,
      m_StrPassWord: string;
  end;

  TCDSServerConfig = record     //服务器配置
    m_SQLServer: TCDSSQLServerInfo;
    m_DataServerPort: Integer;
    m_CommunicateServerPort: Integer;
    m_DetectTimeout: Integer;
    m_DetectInterval: Integer;
    m_Started: Boolean;
  end;
  TCDSLastLoginUser = record //上次用户信息
    m_BlPsdChecked: boolean;
    m_StrUserNum: string[20];
    m_StrUserPsd: string[20];
    m_StrUserRole: string[20];

  end;

  TCDSCurrentLoginUser = record //用户信息
    m_BlPsdChecked: boolean;
    m_StrUserNum: string[20];
    m_StrUserPsd: string[20];
    m_StrUserRole: string[20];
  end;
  //全局函数
  function FPExecSQL_Q(AADOQuery: TADOQuery; ASQLStr: string; IsOpen:Boolean):string;
  //全局变量
var
  g_CDSLastLoginUser: TCDSLastLoginUser; //上次用户相关信息
  g_CDSCurrentLoginUser: TCDSCurrentLoginUser; //用户相关信息
  g_CDSServerInfo: TCDSServerConfig;
  g_StrConnectStr: string; //数据库连接字符串


implementation

{/****************************************** /
 //函数名:       FPExecSQL_Q
 //函数描述:      SQL执行
 //变量描述：      AADOQuery；数据库执行组件
                   ASQLStr：  SQL字符串
                   IsOpen：   打开库判断
 //函数返回：      返回SQL执行结果
 //创建日期:      2012-8-11
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


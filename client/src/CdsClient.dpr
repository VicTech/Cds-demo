{-------------------------------------------------------
文件名:        CdsClient.dpr
描述:          工程文件
版本号:        1.0
创建日期:      2012-9-2
IDE 环境:      D7
字符编码：     UTF-8
作者:          张志鹏
版本所有：
版本修改历史：
 2012-8-7 张志鹏 创建文件
------------------------------------------------------------}
program CdsClient;

uses
 fastmm4,
  Forms,
  MainClientForm in 'MainClientForm.pas';


{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TClientForm, ClientForm);
  Application.Run;
end.

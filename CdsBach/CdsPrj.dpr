 {/******************************************/
 //文件名:        CdsPrj.dpr
 //描述:          工程文件
 //版本号:        1.0
 //创建日期:      2012-8-7
 //IDE 环境:      D7
 //字符编码：     UTF-8
 //作者:          VicTech
 //版本所有：
 //版本修改历史：
 // 2012-8-7 VicTech 创建文件
 /**********************************************/}
program CdsPrj;

uses
  Forms,
  CdsMainFrm in 'CdsMainFrm.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainFrm, MainFrm);
  Application.Run;
end.

锘?{/******************************************/
 //鏂囦欢鍚?        CdsPrj.dpr
 //鎻忚堪:          宸ョ▼鏂囦欢
 //鐗堟湰鍙?        1.0
 //鍒涘缓鏃ユ湡:      2012-8-7
 //IDE 鐜:      D7
 //瀛楃缂栫爜锛?    UTF-8
 //浣滆€?          寮犲織楣?
 //鐗堟湰鎵€鏈夛細
 //鐗堟湰淇敼鍘嗗彶锛?
 // 2012-8-7 寮犲織楣?鍒涘缓鏂囦欢
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

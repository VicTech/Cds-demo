 {/******************************************/
 //�ļ���:        CdsPrj.dpr
 //����:          �����ļ�
 //�汾��:        1.0
 //��������:      2012-8-7
 //IDE ����:      D7
 //�ַ����룺     UTF-8
 //����:          ��־��
 //�汾���У�
 //�汾�޸���ʷ��
 // 2012-8-7 ��־�� �����ļ�
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

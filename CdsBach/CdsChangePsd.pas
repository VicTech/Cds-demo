 {/******************************************/
 //�ļ���:        CdsChangePsd.pas
 //����:          �����޸Ľ���
 //�汾��:        1.0
 //��������:      2012-8-10
 //IDE ����:      D7
 //�ַ����룺     UTF-8
 //����:          VicTech
 //�汾���У�
 //�汾�޸���ʷ��
 // 2012-8-10 VicTech �����ļ�
 /**********************************************/}
unit CdsChangePsd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sSkinManager, StdCtrls, Buttons, sBitBtn, sComboBox, sLabel,
  sEdit, sCheckBox, ExtCtrls, sPanel, ComCtrls, sTabControl, DB, ADODB;

type
  TFormChgPsd = class(TForm)
    m_LabelUserNum: TLabel;
    m_LableOldPsd: TLabel;
    m_LabelNewPsd: TLabel;
    m_LablePsdConfirm: TLabel;
    m_EditOldPsd: TsEdit;
    m_EditNewPsd: TsEdit;
    m_EditPsdConfirm: TsEdit;
    m_LbUserNum: TsLabel;
    m_BtnConfirm: TsBitBtn;
    m_BtnCancel: TsBitBtn;
    ADOQuery1: TADOQuery;
    procedure FormCreate(Sender: TObject);
    procedure m_BtnConfirmClick(Sender: TObject);
    procedure m_BtnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormChgPsd: TFormChgPsd;

implementation
uses
  CdsCommon;
{$R *.dfm}

{/****************************************** /
 //������:
 //��������:      ���崴��
 //����������
 //��������:      2012-8-11
/**********************************************/}
procedure TFormChgPsd.FormCreate(Sender: TObject);
begin
  m_LbUserNum.Caption := g_CDSCurrentLoginUser.m_StrUserNum;
end;

{/****************************************** /
 //������:
 //��������:      �����޸�ȷ��
 //����������
 //��������:      2012-8-11
/**********************************************/}
procedure TFormChgPsd.m_BtnConfirmClick(Sender: TObject);
var
  m_StrSql: string;
  m_BlPsdChgOK: boolean;
begin
  m_BlPsdChgOK := false;
  if (trim(m_EditNewPsd.text) <> '') and (trim(m_EditOldPsd.text) <> '') and (trim(m_EditPsdConfirm.text) <> '') then
  begin
    m_StrSql := 'select * from cds_user_info where UserNum=''' + m_LbUserNum.Caption + ''' and UserPsd=''' + m_EditOldPsd.text + '''';
    with TADOQuery.Create(nil) do
    begin
      try
        //�������ݿⲢ���Ҽ�¼
        ConnectionString := g_StrConnectStr;
        Close;
        SQL.Clear;
        SQL.Add(m_StrSql);
        Open;
        //�ж��Ƿ��ж�Ӧ�ʻ�
        if not IsEmpty then
        begin
          First;
          if trim(m_EditNewPsd.text) = trim(m_EditPsdConfirm.text) then
          begin
            m_StrSql := 'UPDATE cds_user_info SET UserPsd = ''' + trim(m_EditNewPsd.text) + ''' WHERE UserNum = ''' + trim(m_LbUserNum.Caption) + '''';
            try
              with TADOQuery.Create(nil) do
              begin
                try
        //�������ݿⲢ���Ҽ�¼
                  ConnectionString := g_StrConnectStr;
                  Close;
                  SQL.Clear;
                  SQL.Add(m_StrSql);
                  ExecSQL;
                  //Open;
                finally
                  MessageBox(Handle, '������³ɹ�', '����', MB_OK); //+ MB_ICONWARNING
                  //freenil();
                  m_BlPsdChgOK := True;
                  Free; //�ͷ�TQuery�ڴ�

                end;
              end;
            except
              MessageBox(Handle, '�������ʧ�ܣ�����ϵ����Ա', '����', MB_OK + MB_ICONWARNING);
            end;
          end
          else
            MessageBox(Handle, '�����벻һ��', '����', MB_OK + MB_ICONWARNING);
        end
        else
          MessageBox(Handle, '�����벻��ȷ', '����', MB_OK + MB_ICONWARNING);
      finally
        Free; //�ͷ�TQuery�ڴ�
      end;
    end;
  end
  else
    MessageBox(Handle, '��ȷ�����벻Ϊ��', '����', MB_OK + MB_ICONWARNING);
  if m_BlPsdChgOK then
    close;
end;


{/****************************************** /
 //������:
 //��������:      ����ȡ�����˳�����
 //����������
 //��������:      2012-8-11
/**********************************************/}
procedure TFormChgPsd.m_BtnCancelClick(Sender: TObject);
begin
  close;
end;

end.


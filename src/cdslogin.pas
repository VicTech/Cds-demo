 {/******************************************/
 //�ļ���:        CdsLogin.pas
 //����:          ��½����
 //�汾��:        1.0
 //��������:      2012-8-7
 //IDE ����:      D7
 //�ַ����룺     UTF-8
 //����:          VicTech
 //�汾���У�
 //�汾�޸���ʷ��
 // 2012-8-7 VicTech �����ļ�
 /**********************************************/}
unit CdsLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sSkinManager, StdCtrls, Buttons, sBitBtn, sComboBox, sLabel,
  sEdit, sCheckBox, sSkinProvider, acMagn, ImgList, acAlphaImageList, DB,
  ADODB, DBCtrls, IniFiles;

type
  TFormLogin = class(TForm)
    m_BtnDetermine: TsBitBtn;
    m_BtnCancel: TsBitBtn;
    m_EditUserNum: TsEdit;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    m_EditUserPsd: TsEdit;
    sLabel3: TsLabel;
    m_CheckPsd: TsCheckBox;
    ImageList24: TsAlphaImageList;
    m_ConnUser: TADOConnection;
    m_ADOTableRole: TADOTable;
    m_DataSourceRole: TDataSource;
    sSkinManager1: TsSkinManager;
    sSkinProvider1: TsSkinProvider;
    m_ADOQueryRole: TADOQuery;
    m_ComboBoxRole: TsComboBox;
    procedure m_BtnDetermineClick(Sender: TObject);
    procedure m_BtnCancelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLogin: TFormLogin;

implementation
uses
  CdsCommon;
{$R *.dfm}


{/****************************************** /
 //������:
 //��������:      ��½ȷ��
 //����������
 //��������:      2012-8-11
/**********************************************/}
procedure TFormLogin.m_BtnDetermineClick(Sender: TObject);
var
  m_StrUrNum: string;
  m_StrUrPsd: string;
  m_StrUrRole: string;
  m_IniFile: Tinifile;
  sqlstr: string;
begin
  //��֤�û���������
  m_StrUrRole := Trim(m_ComboBoxRole.Text);
  m_StrUrNum := Trim(m_editUserNum.Text);
  m_StrUrPsd := Trim(m_edituserpsd.Text);
  if Length(m_StrUrPsd) > 0 then
  begin
    sqlstr := 'select * from cds_user_info where UserNum=''' + m_StrUrNum + ''' and UserPsd=''' + m_StrUrPsd + '''and UserRole=''' + m_StrUrRole + '''';
    with TADOQuery.Create(nil) do
    begin
      try
        //�������ݿⲢ���Ҽ�¼
        ConnectionString := g_StrConnectStr;
        Close;
        SQL.Clear;
        SQL.Add(sqlstr);
        Open;
        //�ж��Ƿ��ж�Ӧ�ʻ�
        if not IsEmpty then
        begin
          First;
          m_IniFile := Tinifile.Create(ExtractFilePath(Application.ExeName) + '\Server.ini');
          try
            m_IniFile.Writestring('Last User', 'LastRole', m_StrUrRole);
            m_IniFile.Writestring('Last User', 'LastNum', m_StrUrNum);
            m_IniFile.Writestring('Last User', 'LastPsd', m_StrUrPsd);
            if m_checkPsd.Checked then
              m_IniFile.Writestring('Last User', 'Checked', '1')
            else
              m_IniFile.Writestring('Last User', 'Checked', '0');

          finally
            m_IniFile.Free;
          end;
          Self.ModalResult := mrOk; //��½�ɹ�����½���ڷ���mrOK=1�����������˳���½����
        end
        else
        begin
          MessageBox(Handle, '��ȷ�������Ƿ���ȷ', '����', MB_OK + MB_ICONWARNING);
          m_EditUserPsd.SetFocus;
          m_EditUserPsd.SelectAll;
        end;
      finally
        Free; //�ͷ�TQuery�ڴ�
      end;
    end;
  end
  else
  begin
    MessageBox(Handle, '��������ȷ������', '����', MB_OK + MB_ICONWARNING);
  end;

end;

{/****************************************** /
 //������:
 //��������:      ȡ����½
 //����������
 //��������:      2012-8-11
/**********************************************/}
procedure TFormLogin.m_BtnCancelClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel; //mrCancel=2,
 //�������巵�ظ�ֵ�Դ����쳣��ǰ��������
end;

{/****************************************** /
 //������:
 //��������:      ��������
 //����������
 //��������:      2012-8-11
/**********************************************/}

procedure TFormLogin.FormDestroy(Sender: TObject);
begin

end;


{//****************************************** //
 //������:
 //��������:      ���崴��
 //����������
 //��������:      2012-8-11
//**********************************************//}

procedure TFormLogin.FormCreate(Sender: TObject);
var
  i: integer;
  m_StrSql: string;
begin

  try
    m_ConnUser.Connected := False;
    m_ConnUser.ConnectionString := g_StrConnectStr;
    m_ConnUser.Connected := True;
    //�������ݿ�
    m_StrSql := 'select * from cds_role_info';
    with m_ADOQueryRole do
    begin
      try
        //�������ݿⲢ���Ҽ�¼
        ConnectionString := g_StrConnectStr;
        Close;
        SQL.Clear;
        SQL.Add(m_StrSql);
        Open;
        if not IsEmpty then
        begin
          First;
          for i := 0 to m_ADOQueryRole.RecordCount - 1 do
          begin
            m_ComboBoxRole.Items.Add(trim(m_ADOQueryRole.fieldbyname(
              'RoleName').AsString));
            m_ADOQueryRole.Next;
          end;
          for i := 0 to m_ComboBoxRole.Items.Count - 1 do
          begin

            if m_ComboBoxRole.Items.Strings[i] = g_CDSLastLoginUser.m_StrUserRole then
              m_ComboBoxRole.ItemIndex := i;

          end;
        end;
      finally
        Free; //�ͷ�TQuery�ڴ�
      end;
    end;
    m_EditUserNum.Text := g_CDSLastLoginUser.m_StrUserNum;
    if g_CDSLastLoginUser.m_BlPsdChecked then
    begin
      m_EditUserPsd.Text := g_CDSLastLoginUser.m_StrUserPsd;
      m_CheckPsd.Checked := true;
    end;

  except
    tag := 1;
    m_ADOTableRole.Close;
    MessageBox(Handle, '���ӷ�����ʧ��,�����������ӻ�������Ƿ�����������', '����', MB_OK + MB_ICONWARNING);
  end;
end;

end.


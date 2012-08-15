 {/******************************************/
 //�ļ���:        CdsChgUserInfo.pas
 //����:          ��Ϣά������
 //�汾��:        1.0
 //��������:      2012-8-12
 //IDE ����:      D7
 //�ַ����룺     UTF-8
 //����:          ��־��
 //�汾���У�
 //�汾�޸���ʷ��
 // 2012-8-12 ��־�� �����ļ�
 /**********************************************/}
unit CdsChgUserInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sSkinManager, StdCtrls, Buttons, sBitBtn, sComboBox, sLabel,
  sEdit, sCheckBox, ExtCtrls, sPanel, ComCtrls, sTabControl, cxControls,
  cxContainer, cxEdit, cxImage, cxDBEdit, RzEdit, RzDBEdit, Mask, DBCtrls,
  sMemo, DB, ADODB;

type
  TFormChgUserInfo = class(TForm)
    sPanel1: TsPanel;
    m_LabelNum: TLabel;
    m_LabelUserNUm: TsLabel;
    m_LabelEmail: TLabel;
    m_LabelName: TLabel;
    m_LabelPost: TLabel;
    m_LabelSex: TLabel;
    m_LabelDpt: TLabel;
    m_LableMobile: TLabel;
    m_Label1AddInfo: TLabel;
    sPanel2: TsPanel;
    m_BtnSave: TsBitBtn;
    m_BtnEdit: TsBitBtn;
    m_BtnCancel: TsBitBtn;
    sSkinManager1: TsSkinManager;
    m_DBEditName: TDBEdit;
    m_DBEditPost: TDBEdit;
    m_DBEditSex: TDBEdit;
    m_DBEditDpt: TDBEdit;
    m_DBEditEmail: TDBEdit;
    m_DBEditMobile: TDBEdit;
    m_DBMemoAddInfo: TDBMemo;
    m_DataSourceUserInfo: TDataSource;
    m_ADOQueryUserInfo: TADOQuery;
    m_AdoConnUserInfo: TADOConnection;
    m_DBImageUser: TcxDBImage;
    ADOTable1: TADOTable;
    procedure FormCreate(Sender: TObject);
    procedure m_BtnEditClick(Sender: TObject);
    procedure m_BtnSaveClick(Sender: TObject);
    procedure m_BtnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormChgUserInfo: TFormChgUserInfo;

implementation
uses
  CdsCommon;
{$R *.dfm}


{/****************************************** /
 //������:
 //��������:      ���崴��
 //����������
 //��������:      2012-8-12
/**********************************************/}
procedure TFormChgUserInfo.FormCreate(Sender: TObject);
var
  m_StrSql: string;
begin
  m_LabelUserNUm.caption := g_CDSCurrentLoginUser.m_StrUserNum;
  m_AdoConnUserInfo.Connected := False;
  m_AdoConnUserInfo.ConnectionString := g_StrConnectStr;
  m_AdoConnUserInfo.Connected := True;
  m_StrSql := 'SELECT * FROM cds_user_info WHERE UserNum=''' + g_CDSCurrentLoginUser.m_StrUserNum + '''';
  FPExecSQL_Q(m_ADOQueryUserInfo, m_StrSql, True);
  m_BtnEdit.enabled := true;
  m_BtnSave.enabled := false;
end;


{/****************************************** /
 //������:
 //��������:      ����༭״̬����
 //����������
 //��������:      2012-8-12
/**********************************************/}
procedure TFormChgUserInfo.m_BtnEditClick(Sender: TObject);
begin
  m_DataSourceUserInfo.autoEdit := true;
  m_DBEditName.readOnly := false;
  m_DBEditPost.readOnly := false;
  m_DBEditSex.readOnly := false;
  m_DBEditDpt.readOnly := false;
  m_DBEditEmail.readOnly := false;
  m_DBEditMobile.readOnly := false;
  m_DBMemoAddInfo.readOnly := false;
  m_BtnEdit.enabled := false;
  m_BtnSave.enabled := true;
end;

{/****************************************** /
 //������:
 //��������:      ���°���
 //����������
 //��������:      2012-8-12
/**********************************************/}
procedure TFormChgUserInfo.m_BtnSaveClick(Sender: TObject);
var
  m_StrSql: string;
  m_StreamImage: TMemoryStream;
begin
  try
    m_StreamImage := TMemoryStream.create;
    m_DBImageUser.Picture.Graphic.SaveToStream(m_StreamImage);
    m_StrSql := 'UPDATE cds_user_info SET UserName = ''' + trim(m_DBEditName.text) + ''', UserPost = ''' + trim(m_DBEditPost.text) + ''', UserSex = ''' + trim(m_DBEditSex.text) +
      ''', Department = ''' + trim(m_DBEditDpt.text) + ''', Mobilephone = ''' + trim(m_DBEditMobile.text) + ''', Email = ''' + trim(m_DBEditEmail.text) +
      ''', AddInformation = ''' + trim(m_DBMemoAddInfo.text) + ''',UserImage=:UserImage WHERE UserNum = ''' + trim(m_LabelUserNUm.Caption) + '''';
    m_AdoConnUserInfo.Connected := False;
    m_AdoConnUserInfo.ConnectionString := g_StrConnectStr;
    m_AdoConnUserInfo.Connected := True;
    m_ADOQueryUserInfo.SQL.Add(m_StrSql);
    m_ADOQueryUserInfo.Parameters.ParamByName('UserImage').LoadFromStream(m_StreamImage, ftBlob); //�xȡ����ăȴ�D
    FPExecSQL_Q(m_ADOQueryUserInfo, m_StrSql, false);
    m_StrSql := 'SELECT * FROM cds_user_info WHERE UserNum=''' + g_CDSCurrentLoginUser.m_StrUserNum + '''';
    FPExecSQL_Q(m_ADOQueryUserInfo, m_StrSql, True);
  finally
    m_StreamImage.Free;
    m_DBEditName.readOnly := true;
    m_DBEditPost.readOnly := true;
    m_DBEditSex.readOnly := true;
    m_DBEditDpt.readOnly := true;
    m_DBEditEmail.readOnly := true;
    m_DBEditMobile.readOnly := true;
    m_DBMemoAddInfo.readOnly := true;
    m_BtnEdit.enabled := true;
    m_BtnSave.enabled := false;
    MessageBox(Handle, '���ݸ��³ɹ���', '֪ͨ', MB_OK);
  end;
end;

{/****************************************** /
 //������:
 //��������:      �رյ�ǰ����
 //����������
 //��������:      2012-8-11
/**********************************************/}
procedure TFormChgUserInfo.m_BtnCancelClick(Sender: TObject);
begin
close;
end;

end.


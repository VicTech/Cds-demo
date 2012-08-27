 {/******************************************/
 //文件名:        CdsChangePsd.pas
 //描述:          密码修改界面
 //版本号:        1.0
 //创建日期:      2012-8-10
 //IDE 环境:      D7
 //字符编码：     UTF-8
 //作者:          VicTech
 //版本所有：
 //版本修改历史：
 // 2012-8-10 VicTech 创建文件
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
 //函数名:
 //函数描述:      窗体创建
 //变量描述：
 //创建日期:      2012-8-11
/**********************************************/}
procedure TFormChgPsd.FormCreate(Sender: TObject);
begin
  m_LbUserNum.Caption := g_CDSCurrentLoginUser.m_StrUserNum;
end;

{/****************************************** /
 //函数名:
 //函数描述:      密码修改确认
 //变量描述：
 //创建日期:      2012-8-11
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
        //连接数据库并查找记录
        ConnectionString := g_StrConnectStr;
        Close;
        SQL.Clear;
        SQL.Add(m_StrSql);
        Open;
        //判断是否有对应帐户
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
        //连接数据库并查找记录
                  ConnectionString := g_StrConnectStr;
                  Close;
                  SQL.Clear;
                  SQL.Add(m_StrSql);
                  ExecSQL;
                  //Open;
                finally
                  MessageBox(Handle, '密码更新成功', '提醒', MB_OK); //+ MB_ICONWARNING
                  //freenil();
                  m_BlPsdChgOK := True;
                  Free; //释放TQuery内存

                end;
              end;
            except
              MessageBox(Handle, '密码更新失败，请联系管理员', '提醒', MB_OK + MB_ICONWARNING);
            end;
          end
          else
            MessageBox(Handle, '新密码不一致', '提醒', MB_OK + MB_ICONWARNING);
        end
        else
          MessageBox(Handle, '旧密码不正确', '提醒', MB_OK + MB_ICONWARNING);
      finally
        Free; //释放TQuery内存
      end;
    end;
  end
  else
    MessageBox(Handle, '请确认输入不为空', '提醒', MB_OK + MB_ICONWARNING);
  if m_BlPsdChgOK then
    close;
end;


{/****************************************** /
 //函数名:
 //函数描述:      操作取消，退出窗口
 //变量描述：
 //创建日期:      2012-8-11
/**********************************************/}
procedure TFormChgPsd.m_BtnCancelClick(Sender: TObject);
begin
  close;
end;

end.


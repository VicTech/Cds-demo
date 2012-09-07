 {------------------------------------------------}
 //文件名:         UAdminSysFrm.pas
 //描述:          客户端管理员"系统"菜单导航
 //版本号:        1.0
 //创建日期:      2012-9-3
 //IDE 环境:      D7
 //字符编码：     UTF-8
 //作者:          VicTech
 //版本所有：
 //版本修改历史：
 // 2012-9-3 VicTech 创建文件
 {------------------------------------------------}
unit UAdminSysFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, Buttons, sSpeedButton, RzPanel, dxGDIPlusClasses;

type
  TAdminSysFrm = class(TFrame)
    m_ImageNavigation: TImage;
    m_RzPnlNavigation: TRzPanel;
    sSpeedButton4: TsSpeedButton;
    sSpeedButton3: TsSpeedButton;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton5: TsSpeedButton;
    sSpeedButton6: TsSpeedButton;
    RzPanel1: TRzPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.

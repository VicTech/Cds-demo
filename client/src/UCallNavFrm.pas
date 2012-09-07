 {------------------------------------------------}
 //文件名:         UCallNavFrm.pas
 //描述:          呼叫管理菜单导航
 //版本号:        1.0
 //创建日期:      2012-9-5
 //IDE 环境:      D7
 //字符编码：     UTF-8
 //作者:          VicTech
 //版本所有：
 //版本修改历史：
 // 2012-9-5 VicTech 创建文件
 {------------------------------------------------}
unit UCallNavFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, Buttons, sSpeedButton, dxGDIPlusClasses, RzPanel;

type
  TCallNavFrm = class(TFrame)
    m_RzPnlNavigation: TRzPanel;
    RzPanel1: TRzPanel;
    sSpeedButton4: TsSpeedButton;
    sSpeedButton3: TsSpeedButton;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton5: TsSpeedButton;
    sSpeedButton6: TsSpeedButton;
    m_ImageNavigation: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.

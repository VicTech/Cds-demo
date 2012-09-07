 {------------------------------------------------}
 //文件名:         MainClientForm.pas
 //描述:          客户端主程序
 //版本号:        1.0
 //创建日期:      2012-9-2
 //IDE 环境:      D7
 //字符编码：     UTF-8
 //作者:          VicTech
 //版本所有：
 //版本修改历史：
 // 2012-9-2 VicTech 创建文件
 {------------------------------------------------}
unit MainClientForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sSkinManager, StdCtrls, Buttons, sBitBtn, sComboBox, sLabel,
  sEdit, sCheckBox, cxControls, cxSplitter, sScrollBox, sFrameBar,
  sSpeedButton, cxGraphics, acAlphaHints, ImgList, acAlphaImageList,
  ExtCtrls, sPanel, ComCtrls, sStatusBar, dxDockControl, dxDockPanel,
  AdvSmoothPanel, sPageControl, RzTabs, jpeg, RzPanel, sSplitter,
  dxGDIPlusClasses,cdsclientglobal;

type
  TClientForm = class(TForm)
    ImgList_Multi16: TsAlphaImageList;
    ImgList_MultiState: TsAlphaImageList;
    sAlphaHints1: TsAlphaHints;
    ImageList32: TsAlphaImageList;
    ImageList24: TsAlphaImageList;
    ImageList16: TsAlphaImageList;
    cxImageList1: TcxImageList;
    dxDockPanel1: TdxDockPanel;
    dxFloatDockSite1: TdxFloatDockSite;
    Timer1: TTimer;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel1: TPanel;
    sSplitter1: TsSplitter;
    m_PnlNavigation: TPanel;
    Panel10: TPanel;
    sPanel3: TsPanel;
    sPanel4: TsPanel;
    m_SpdBtn: TsSpeedButton;
    sPanel6: TsPanel;
    m_SpdBtnInspect: TsSpeedButton;
    sPanel7: TsPanel;
    sBitBtn1: TsSpeedButton;
    sPanel8: TsPanel;
    sSpeedButton3: TsSpeedButton;
    Panel11: TPanel;
    sPanel2: TsPanel;
    sPageControl1: TsPageControl;
    sSkinManager1: TsSkinManager;
    sAlphaImageList1: TsAlphaImageList;
    Image2: TImage;
    m_SpdBtnSys: TsSpeedButton;
    sPanel5: TsPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel12: TPanel;
    Image3: TImage;
    Panel13: TPanel;
    Panel14: TPanel;
    Image4: TImage;
    procedure m_SpdBtnSysClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure m_SpdBtnClick(Sender: TObject);
    procedure m_SpdBtnInspectClick(Sender: TObject);
  private
    FFrame: TFrame;   //声明一个通用的框架实例引用
    TempFFrameClass: TFrameClassRef;      //声明一个临时框架类引用，存放当前框架实例所属的类
    procedure CreateFrame(m_FrameClass: TFrameClassRef); //创件框架实例并显示
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ClientForm: TClientForm;

implementation
uses
UAdminSysFrm,
UCallNavFrm,
UInspectNavFrm

;
//DockUtils;

{$R *.dfm}

{-------------------------------------------------
过程名:
功能描述:      创件框架实例并在导航Panel上显示
参数描述：
创建日期:      2012-9-3
--------------------------------------------------}
 
procedure TClientForm.CreateFrame(m_FrameClass: TFrameClassRef);
begin
  if FFrame<>nil then
  begin
    (FFrame as TempFFrameClass).Visible:= False;
    (FFrame as TempFFrameClass).Free;
    FFrame:= nil;
  end;
  FFrame:= m_FrameClass.Create(Application);

  with FFrame do
  begin
    Application.ProcessMessages;
    Enabled:= False;
    Parent:=Self.m_PnlNavigation;  //指定Parent属性即可显示
    Align:=alClient;
    Enabled:= True;
  end;
  TempFFrameClass:=m_FrameClass;
end;

{-------------------------------------------------
过程名:
功能描述:      "系统"按钮打开导航
参数描述：
创建日期:      2012-9-3
--------------------------------------------------}
procedure TClientForm.m_SpdBtnSysClick(Sender: TObject);
begin
  try
    Self.Enabled := false;
    CreateFrame(TAdminSysFrm);
    (FFrame as TAdminSysFrm).Visible:=False;

  finally
    Self.Enabled := True;
    (FFrame as TAdminSysFrm).Visible:=True;
  end;
end;

{-------------------------------------------------
过程名:
功能描述:      对panel进行重绘
参数描述：
创建日期:      2012-9-3
--------------------------------------------------}
procedure TClientForm.FormPaint(Sender: TObject);
var   mycanvas:tcanvas; 
      bit:TBitmap;
begin
    {mycanvas:=TCanvas.Create; 
    mycanvas.Handle:=getdc(m_RzPnlNavigation.Handle);
    bit:=TBitmap.Create;
    bit.LoadFromFile( '.\image\dh.bmp');
    mycanvas.StretchDraw(rect(0,0,Panel1.Width,Panel1.Height),bit);
    mycanvas.Free;
    bit.free; }
 end;

 {-------------------------------------------------
过程名:
功能描述:      "呼叫"按钮打开导航栏
参数描述：
创建日期:      2012-9-4
--------------------------------------------------}
procedure TClientForm.m_SpdBtnClick(Sender: TObject);
begin
    try
    Self.Enabled := false;
    CreateFrame(TCallNavFrm);
    (FFrame as TCallNavFrm).Visible:=False;
   finally
    Self.Enabled := True;
    (FFrame as TCallNavFrm).Visible:=True;
  end;
end;

 {-------------------------------------------------
过程名:
功能描述:      "查房"按钮打开导航栏
参数描述：
创建日期:      2012-9-5
--------------------------------------------------}
procedure TClientForm.m_SpdBtnInspectClick(Sender: TObject);
begin
    try
    Self.Enabled := false;
    CreateFrame(TInspectNavFrm);
    (FFrame as TInspectNavFrm).Visible:=False;
   finally
    Self.Enabled := True;
    (FFrame as TInspectNavFrm).Visible:=True;
  end;
end;




end.

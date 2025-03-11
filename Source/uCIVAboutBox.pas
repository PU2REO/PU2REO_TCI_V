unit uCIVAboutBox;

interface

uses
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.Classes, uCIVGlobalConstants;

type
  TfrmCIVAboutBox = class(TForm)
    pnImage: TPanel;
    imgIcom: TImage;
    lbTitle: TLabel;
    lbDescription: TLabel;
    btnClose: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCIVAboutBox: TfrmCIVAboutBox;

implementation

{$R *.dfm}

procedure TfrmCIVAboutBox.btnCloseClick(Sender: TObject);
begin
  // close this form
  Close;
end;

procedure TfrmCIVAboutBox.FormCreate(Sender: TObject);
begin
  // adjust name and version
  lbTitle.Caption := CIV_COMPONENT_NAME + ' - ' + CIV_COMPONENT_VERSION;
end;

procedure TfrmCIVAboutBox.FormKeyPress(Sender: TObject; var Key: Char);
begin
  // escape key
  if Key = Chr(27) then Close;
end;

end.

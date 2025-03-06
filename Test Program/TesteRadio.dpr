program TesteRadio;

uses
  Vcl.Forms,
  frm_Main in 'frm_Main.pas' {frmMain},
  uDBUtils in '..\Globais\uDBUtils.pas',
  uDataModule in 'uDataModule.pas' {frmDataModule: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmDataModule, frmDataModule);
  Application.Run;
end.

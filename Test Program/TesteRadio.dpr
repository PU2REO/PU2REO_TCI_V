program TesteRadio;

uses
  Vcl.Forms,
  frm_Main in 'frm_Main.pas' {frmMain},
  uDataModule in 'uDataModule.pas' {frmDataModule: TDataModule},
  uDBUtils in '..\..\PU2REO_MemoryManager\Globals\uDBUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmDataModule, frmDataModule);
  Application.Run;
end.

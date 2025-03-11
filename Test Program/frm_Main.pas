unit frm_Main;

interface

uses
  {$IFDEF DEBUG}
    CodeSiteLogging,
  {$ENDIF}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uIcomCIV, Data.DB, DBAccess, Uni, UniProvider,
  SQLiteUniProvider, MemDS, Data.FmtBcd;

type
  TfrmMain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Memo1: TMemo;
    Button17: TButton;
    IcomCIV1: TIcomCIV;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure IcomCIV1ReadMemoryBank(Sender: TObject; MemoryData: TMemoryData);
    procedure Button6Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IcomCIV1ErrorSerialDevice(Sender: TObject; ErrorCode,
      Detail: Cardinal; ErrorMsg: string; var RaiseException: Boolean);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Memo1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses uDBUtils;

var
  mdMemData:        TMemoryData;

{$R *.dfm}

procedure TfrmMain.Button10Click(Sender: TObject);
begin
  // turn off NoiseBlanker
  Self.IcomCIV1.SetNoiseBlanker(nbNoiseBlkOff);
end;

procedure TfrmMain.Button11Click(Sender: TObject);
begin
  // turn off Noise Reduction
  Self.IcomCIV1.SetNoiseReduction(nrNoiseRedOn);
end;

procedure TfrmMain.Button12Click(Sender: TObject);
begin
  // turn off Noise Reduction
  Self.IcomCIV1.SetNoiseReduction(nrNoiseRedOff);
end;

procedure TfrmMain.Button13Click(Sender: TObject);
begin
  // turn on AutoNotch
  Self.IcomCIV1.SetAutoNotch(anAutoNotchOn);
end;

procedure TfrmMain.Button14Click(Sender: TObject);
begin
  // turn off AutoNotch
  Self.IcomCIV1.SetAutoNotch(anAutoNotchOff);
end;

procedure TfrmMain.Button15Click(Sender: TObject);
begin
  // turn on ManualNotch
  Self.IcomCIV1.SetManualNotch(mnManualNotchOn);
end;

procedure TfrmMain.Button16Click(Sender: TObject);
begin
  // turn off ManualNotch
  Self.IcomCIV1.SetManualNotch(mnManualNotchOff);
end;

procedure TfrmMain.Button17Click(Sender: TObject);
begin
  IcomCIV1.UpdateLevelReadings;
  Memo1.Lines.Add('Squelch: ' + IntToStr(Self.IcomCIV1.LevelReadings.Squelch));
  Memo1.Lines.Add('Signal: ' + IntToStr(Self.IcomCIV1.LevelReadings.SMeter));
  Memo1.Lines.Add('Power Output: ' + IntToStr(Self.IcomCIV1.LevelReadings.PowerOutput));
  Memo1.Lines.Add('SWR: ' + FloatToStr(Extended(Self.IcomCIV1.LevelReadings.SWR)));
  Memo1.Lines.Add('ALC: ' + IntToStr(Self.IcomCIV1.LevelReadings.ALC));
  Memo1.Lines.Add('Compression: ' + IntToStr(Self.IcomCIV1.LevelReadings.Compression));
  Memo1.Lines.Add('VD: ' + IntToStr(Self.IcomCIV1.LevelReadings.VD));
  Memo1.Lines.Add('ID: ' + IntToStr(Self.IcomCIV1.LevelReadings.ID));
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  IcomCIV1.Speech(smAllData);
end;

procedure TfrmMain.Button2Click(Sender: TObject);
var i: Byte;
begin
  for I:=1 to 109 do IcomCIV1.ReadMemory(mbBank_A, i);
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin
  mdMemData.Bank := Ord(mbBank_B);
//  mdMemData.MemoryNumber := 1;
//  mdMemData.ScanSelected := False;
//  mdMemData.Frequency1 := 146910;
//  mdMemData.Mode1 := 5;
//  mdMemData.Filter1 := 1;
//  mdMemData.Flags1 := 11;
//  mdMemData.TXSubtone1  := 82.5;
//  mdMemData.RXSubtone1 := 88.5;
//  mdMemData.DTCS1Polarity := 0;
//  mdMemData.DTCS1Code := 23;
//  mdMemData.Frequency2 := 146910;
//  mdMemData.Mode2 := 5;
//  mdMemData.Filter2 := 1;
//  mdMemData.Flags2 := 11;
//  mdMemData.TXSubtone2  := 82.5;
//  mdMemData.RXSubtone2 := 88.5;
//  mdMemData.DTCS2Polarity := 0;
//  mdMemData.DTCS2Code := 23;
//  mdMemData.Name := 'POWER CH1';

  // write data
  IcomCIV1.WriteMemory(mdMemData);
end;

procedure TfrmMain.Button4Click(Sender: TObject);
begin
  IcomCIV1.ClearMemory(mbBank_B, 1);
end;

procedure TfrmMain.Button5Click(Sender: TObject);
begin
  // Read a Single Memory Channel
  IcomCIV1.ReadMemory(mbBank_B, 1);
end;

procedure TfrmMain.Button6Click(Sender: TObject);
begin
   // set PreAmp On
   IcomCIV1.SetPreAmp(paOne);
end;

procedure TfrmMain.Button7Click(Sender: TObject);
var
  I, J: Integer;
begin
   // disable button
   Button7.Enabled := False;
   Self.Repaint;

   // read 99 per bank
   for I:= Ord(mbBank_A) to Ord(mbBank_E) do begin
    for J:=1 to 99 do IcomCIV1.ReadMemory(TMemoryBanks(I), J);
   end;

   // read scan edges & Call Channel (Last 8 positions af each bank repeats themselves in each bank)
   for J:=100 to 107 do IcomCIV1.ReadMemory(mbBank_E, J);

   // enable button
   Button7.Enabled := True;
end;

procedure TfrmMain.Button8Click(Sender: TObject);
begin
   // set PreAmp Off
   IcomCIV1.SetPreAmp(paOff);
end;

procedure TfrmMain.Button9Click(Sender: TObject);
begin
  // turn on NoiseBlanker
  Self.IcomCIV1.SetNoiseBlanker(nbNoiseBlkOn);
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Self.IcomCIV1.Active := False;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Self.Caption := 'Test of Icom''s CI-V Protocol - ' + IcomCIV1.Version;
  Memo1.Lines.Clear;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  // activate serial communications
  Self.IcomCIV1.Active := True;
end;

procedure TfrmMain.IcomCIV1ErrorSerialDevice(Sender: TObject; ErrorCode,
  Detail: Cardinal; ErrorMsg: string; var RaiseException: Boolean);
begin
  RaiseException := False;
  MessageDlg(ErrorMsg, mtError, [mbOk], 0);
  Application.Terminate;
end;

procedure TfrmMain.IcomCIV1ReadMemoryBank(Sender: TObject;
  MemoryData: TMemoryData);
begin
  // update database
  InsertOrUpdateRecord(MemoryData);

  // copy data to a global variable
  mdMemData := MemoryData;
end;

procedure TfrmMain.Memo1DblClick(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

initialization
  ReportMemoryLeaksOnShutdown := true;

end.

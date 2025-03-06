unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, UniProvider, SQLiteUniProvider, Data.DB,
  DBAccess, Uni, VCL.Forms, DASQLMonitor, UniSQLMonitor;

type
  TfrmDataModule = class(TDataModule)
    uniConnection: TUniConnection;
    uniProvider: TSQLiteUniProvider;
    uniMonitor: TUniSQLMonitor;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure CreateNewDataBase(uniConnection: TUniConnection; sDBName: String);
  public
    { Public declarations }
  end;

var
  frmDataModule: TfrmDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TfrmDataModule.DataModuleCreate(Sender: TObject);
var
  sDBName:      String;
begin
  // monitor SQL only in debug mode
  {$IFDEF DEBUG}
    uniMonitor.Active := True;
  {$ENDIF}

  // set database name
  sDBName := ExtractFilePath(Application.ExeName) + 'Database.db';
  uniConnection.Database := sDBName;

  // Test for database
  if not FileExists(sDBName) then begin
    // creates new database
    CreateNewDataBase(uniConnection, sDBName);
  end;

  // connects and open database
  Self.uniConnection.Connect;
end;


procedure TfrmDataModule.DataModuleDestroy(Sender: TObject);
begin
    // close connection
    uniConnection.Disconnect;
end;

procedure TfrmDataModule.CreateNewDataBase(uniConnection: TUniConnection; sDBName: String);
begin
    //create new database
    uniConnection.Database := sDBName;
    uniConnection.SpecificOptions.Values['ForceCreateDatabase'] := 'True'; // In UniDAC 4.5.9 and higher
    uniConnection.Connect;
    uniConnection.ExecSQL('PRAGMA auto_vacuum = 1');
    uniConnection.ExecSQL('CREATE TABLE [MemoryData](' +
                          '[bank] SMALLINT NOT NULL,' +
                          '[mem_number] SMALLINT NOT NULL,' +
                          '[mem_name] TEXT(9),' +
                          '[scan_sel] BOOL NOT NULL,' +
                          '[freq1] FLOAT,' +
                          '[mode] SMALLINT,' +
                          '[filter1] SMALLINT,' +
                          '[flags1] SMALLINT,' +
                          '[tx_subtone1] FLOAT,' +
                          '[rx_subtone1] FLOAT,' +
                          '[DTCSPolarity1] SMALLINT,' +
                          '[DTCSCode1] INT,' +
                          '[freq2] FLOAT,' +
                          '[mode2] SMALLINT,' +
                          '[filter2] SMALLINT,' +
                          '[flags2] SMALLINT,' +
                          '[tx_subtone2] FLOAT,' +
                          '[rx_subtone2] FLOAT,' +
                          '[DTCSPolarity2] SMALLINT,' +
                          '[DTCSCode2] INT,' +
                          '[IsBlank] BOOL);' +
                          'CREATE UNIQUE INDEX idx_bank_mem_number ON MemoryData(bank, mem_number);'
                          );
end;

end.

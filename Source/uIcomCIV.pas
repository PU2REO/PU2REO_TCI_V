unit uIcomCIV;

interface

uses
  System.SysUtils, System.Classes, Windows, Forms, nrComm, nrDataProc, uCIVGlobalConstants,
  Data.FmtBcd, System.Math
  {$IFDEF DEBUG}
    , CodeSiteLogging
  {$ENDIF}
  ;

type
  // enumeration types
  TCIVAboutInfo                             = (civAboutInfo);
  TDoubleConverionType                      = (ctFrequency, ctSubTone);
  TMemoryBanks                              = (mbBank_A=1, mbBank_B, mbBank_C, mbBank_D, mbBank_E);
  TModulationMode                           = (vmLSB, vmUSB, vmAM, vmCW, vmRTTY_FSK, vmFM, vmWFM, vmCW_R, vmRTTY_R);
  TPowerState                               = (psPowerOff, psPowerOn);
  TNoiseBlankerState                        = (nbNoiseBlkOff, nbNoiseBlkOn);
  TNoiseReductionState                      = (nrNoiseRedOff, nrNoiseRedOn);
  TAutoNotchState                           = (anAutoNotchOff, anAutoNotchOn);
  TManualNotchState                         = (mnManualNotchOff, mnManualNotchOn);
  TPreAmpSetting                            = (paOff, paOne, paTwo);
  TProtocolState                            = (psIdle, psWaitingDevice);
  TRadioModel                               = (rmIC_706, rmIC_7000);       // see function TIcomCIV.GetRadioAddress
  TSpeechMode                               = (smAllData, smFreqAndSignal, smReceiveMode, smErrorTest);

  // structures
  TVFO_Data = record
    Frequency:    Double;
    Mode:         TModulationMode;
    Filter:       Byte;
  end;

  TMemoryData = record
    Bank:           Byte;
    MemoryNumber:   Byte;
    ScanSelected:   Boolean;
    Frequency1:     Double;
    Mode1:          Byte;
    Filter1:        Byte;
    Flags1:         Byte;
    TXSubtone1:     Double;
    RXSubtone1:     Double;
    DTCS1Polarity:  Byte;
    DTCS1Code:      Word;
    Frequency2:     Double;
    Mode2:          Byte;
    Filter2:        Byte;
    Flags2:         Byte;
    TXSubtone2:     Double;
    RXSubtone2:     Double;
    DTCS2Polarity:  Byte;
    DTCS2Code:      Word;
    Name:           AnsiString;
    IsBlank:        Boolean;
  end;

  TLevelReadings = record
    Squelch:        Byte; 
    SMeter:         Byte; 
    PowerOutput:    Byte; 
    SWR:            Single; 
    ALC:            Byte; 
    Compression:    Byte; 
    Vd:             Byte; 
    Id:             Byte; 
  end;

  // events
  TEventNrCommError               = procedure (Sender: TObject; ErrorCode, Detail: Cardinal;
                                               ErrorMsg: string; var RaiseException: Boolean)   of object;
  TEventDataProcessorError        = procedure (Sender: TObject; ErrorCode, Detail: Cardinal;
                                               ErrorMsg: string; var RaiseException: Boolean)   of object;
  TEventNewDataPacket             = procedure (Sender: TObject; Packet: TnrDataPacket)          of object;
  TEventReadMemoryBank            = procedure (Sender: TObject; MemoryData: TMemoryData)        of object;


  TIcomCIV = class(TComponent)
  private
    { Private declarations }
    // events
    FOnNrCommError:               TEventNrCommError;
    FOnDataProcessorError:        TEventDataProcessorError;
    FOnNewDataPacket:             TEventNewDataPacket;
    FOnReadMemoryBank:            TEventReadMemoryBank;
    procedure                     NrCommFatalError(Sender: TObject; ErrorCode, Detail: Cardinal; ErrorMsg: string; var RaiseException: Boolean);
    procedure                     DataProcessorFatalError(Sender: TObject; ErrorCode, Detail: Cardinal; ErrorMsg: string; var RaiseException: Boolean);
    procedure                     NewDataPacket(Sender: TObject; Packet: TnrDataPacket);
    function                      MapRange(Value, InStart, InEnd:Byte; OutStart, OutEnd:Single): Single;
  protected
    { Protected declarations }
    // objects
    FPort:                        TnrComm;
    FDataProcessor:               TnrDataProcessor;
    FProtocolState:               TProtocolState;
    FRadioModel:                  TRadioModel;
    FVFO_A:                       TVFO_Data;
    // misc
    FAbout:                       TCIVAboutInfo;         // About info
    procedure                     SetPortActive(Value: Boolean);
    function                      GetPortActive: Boolean;
    function                      GetRadioAddress: Byte;
    procedure                     SetRadioModel(Value: TRadioModel);
    function                      GetRadioModel: TRadioModel;
    procedure                     ProcessDataPacket(Packet: Ansistring);
    function                      GetVFOA: TVFO_Data;
    procedure                     SendPacket(sIn: AnsiString);
    function                      ByteToBCD(Value: Byte): AnsiChar;
    function                      BCDToByte(Value: AnsiChar): Byte;
    function                      CharStrToHexStr(sIn: AnsiString): AnsiString;
    function                      CharToHex(cIn: AnsiChar): AnsiString;
    function                      HexStrToCharStr(sIn: AnsiString): AnsiString;
    function                      BCDToDouble(sIn: AnsiString; ConversionType: TDoubleConverionType): Double;
    procedure                     SetPortNumber(Value: Word);
    function                      GetPortNumber: Word;
    procedure                     SetBaudRate(Value: Cardinal);
    function                      GetBaudRate: Cardinal;
    function                      DoubleToBCD(Value: Double; ConversionType: TDoubleConverionType): AnsiString;
    function                      IntToBCD(Value: Word): AnsiString;
    function                      GetVersion: String;

  public
    LevelReadings:                TLevelReadings;
    { Public declarations }
    constructor                   Create(AOwner: TComponent); override;
    destructor                    Destroy; override;
    procedure                     Speech(Mode: TSpeechMode);
    procedure                     ReadMemory(Bank: TMemoryBanks; Position: SmallInt);
    procedure                     WriteMemory(MemoryData: TMemoryData);
    procedure                     SetPowerState(Value: TPowerState);
    procedure                     SetPreAmp(Value: TPreAmpSetting);
    procedure                     SetNoiseBlanker(Value: TNoiseBlankerState);
    procedure                     SetNoiseReduction(Value: TNoiseReductionState);
    procedure                     SetAutoNotch(Value: TAutoNotchState);
    procedure                     SetManualNotch(Value: TManualNotchState);
    procedure                     SetModulationMode(Value: TModulationMode);
    procedure                     ClearMemory(Bank: TMemoryBanks; Position: SmallInt);
    procedure                     UpdateLevelReadings;   
  published
    { Published declarations }
    property About:                   TCIVAboutInfo                 read FAbout write FAbout;
    property Active:                  Boolean                       read  GetPortActive write SetPortActive;
    property BaudRate:                Cardinal                      read  GetBaudRate write SetBaudRate;
    property PortNumber:              Word                          read  GetPortNumber write SetPortNumber;
    property RadioModel:              TRadioModel                   read  GetRadioModel write SetRadioModel;
    property Version:                 String                        read  GetVersion;
    property VFO_A:                   TVFO_Data                     read  GetVFOA;
    property OnErrorDataProcessor:    TEventDataProcessorError      read  FOnDataProcessorError
                                                                    write FOnDataProcessorError;
    property OnErrorSerialDevice:     TEventNrCommError             read  FOnNrCommError
                                                                    write FOnNrCommError;
    property OnNewDataPacket:         TEventNewDataPacket           read  FOnNewDataPacket
                                                                    write FOnNewDataPacket;
    property OnReadMemoryBank:        TEventReadMemoryBank          read  FOnReadMemoryBank
                                                                    write FOnReadMemoryBank;
  end;

implementation

//----------------------------------------------------------------------------
// Protected Routines
//----------------------------------------------------------------------------
procedure TIcomCIV.ProcessDataPacket(Packet: AnsiString);
var
  bCommand, bSubCommand:              AnsiChar;
  mdMemory:                           TMemoryData;
  bTemp:                              Byte;
begin
  {$IFDEF DEBUG}
    CodeSite.EnterMethod('ProcessDataPacket');
    CodeSite.Send(csmInfo, Format('Packet: %s', [Self.CharStrToHexStr(Packet)]));
  {$ENDIF}

  // get sender, receiver, command and subcommand values
  bCommand         := Packet[CIV_PACKET_POSITION_COMMAND];
  bSubCommand      := Packet[CIV_PACKET_POSITION_SUBCOMMAND];

  // process command
  case bCommand of
    // frequency data
    CIV_COMMAND_TRANSF_OPERATING_FREQ_DATA:
      begin
        // update new dialed frequency
        FVFO_A.Frequency := Self.BCDToDouble(AnsiString(Copy(string(Packet), 6, 5)), ctFrequency);
      end;

    // mode data
    CIV_COMMAND_TRANSF_OPERATING_MODE_DATA:
      begin
        // update new dialed mode
        FVFO_A.Mode   := TModulationMode(Ord(Packet[6]));
        FVFO_A.Filter := Ord(Packet[7]);
      end;

    // level readings
    CIV_COMMAND_LEVEL_READINGS:
      begin
        case bSubCommand of
          // squelch status
          CIV_SUB_CMD_READING_SQUELCH_STATUS:
            begin
              Self.LevelReadings.Squelch := Byte(StrToInt(String(Self.CharStrToHexStr(AnsiString(Copy(string(Packet), 7, 1))))));
            end;
        
          // signal strength
          CIV_SUB_CMD_READING_SIGNAL_STRENGTH:
            begin
              bTemp := Byte(StrToInt(String(Self.CharStrToHexStr(AnsiString(Copy(string(Packet), 7, 2))))));
              case bTemp of
                  0 .. 120: Self.LevelReadings.SMeter := Byte(Floor(Self.MapRange(bTEmp,   0, 120, 0.00,  9.00)));
                121 .. 241: Self.LevelReadings.SMeter := Byte(Floor(Self.MapRange(bTEmp, 121, 241, 9.01, 60.00)));
              end;
            end;

          // power output
          CIV_SUB_CMD_READING_RF_POWER_OUTPUT:
            begin
              Self.LevelReadings.PowerOutput := Byte(StrToInt(String(Self.CharStrToHexStr(AnsiString(Copy(string(Packet), 7, 2))))));
            end;

          // SWR
          CIV_SUB_CMD_READING_SWR_METER:
            begin
              bTemp := Byte(StrToInt(String(Self.CharStrToHexStr(AnsiString(Copy(string(Packet), 7, 2))))));
              case bTemp of
                 0 .. 120: Self.LevelReadings.SWR := Self.MapRange(bTEmp,  0,  120, 1.000, 3.000);
//                 0 .. 48: Self.LevelReadings.SWR := Self.MapRange(bTEmp,  0,  48, 1.000, 1.500);
//                49 .. 80: Self.LevelReadings.SWR := Self.MapRange(bTEmp, 49,  80, 1.501, 2.000);
//                81 ..120: Self.LevelReadings.SWR := Self.MapRange(bTEmp, 81, 120, 2.001, 3.000);
              end;
              
            end;

          // ALC
          CIV_SUB_CMD_READING_ALC_METER:
            begin
              Self.LevelReadings.ALC := Byte(StrToInt(String(Self.CharStrToHexStr(AnsiString(Copy(string(Packet), 7, 2))))));
            end;

          // compressor
          CIV_SUB_CMD_READING_COMPRESSOR_METER:
            begin
              Self.LevelReadings.Compression := Byte(StrToInt(String(Self.CharStrToHexStr(AnsiString(Copy(string(Packet), 7, 2))))));
            end;

          // signal Vd value
          CIV_SUB_CMD_READING_VD_VALUE:
            begin
              Self.LevelReadings.Vd := Byte(StrToInt(String(Self.CharStrToHexStr(AnsiString(Copy(string(Packet), 7, 2))))));
            end;

          // signal Id value
          CIV_SUB_CMD_READING_ID_VALUE:
            begin
              Self.LevelReadings.Id := Byte(StrToInt(String(Self.CharStrToHexStr(AnsiString(Copy(string(Packet), 7, 2))))));
            end;
        end;
      end;

    // memory contents
    CIV_COMMAND_MEMORY_CONTENTS:
      begin
        case bSubCommand of
          // read memory contents
          CIV_MEMORY_READ_WRITE:
            begin
              // initialize struct
              FillChar(mdMemory, SizeOf(mdMemory), $00);

              // decode memory packet contents
              mdMemory.Bank         := Self.BCDToByte(Packet[7]);
              mdMemory.MemoryNumber := Self.BCDToByte(Packet[8]) * 100 + Self.BCDToByte(Packet[9]);

              // check for blank memory position
              if Packet[CIV_PACKET_POSITION_BLANK] <> CIV_PACKET_MEMORY_BLANK then begin
                // decode remaining memory packet contentss
                mdMemory.ScanSelected := Self.BCDToByte(Packet[10]) <> 0;
                mdMemory.Frequency1   := Self.BCDToDouble(AnsiString(Copy(String(Packet), 11, 5)), ctFrequency);
                mdMemory.Mode1        := Self.BCDToByte(Packet[16]);
                mdMemory.Filter1      := Self.BCDToByte(Packet[17]);
                mdMemory.Flags1       := Self.BCDToByte(Packet[18]);
                mdMemory.TXSubtone1   := Self.BCDToByte(Packet[19])*1000 +
                                         Self.BCDToByte(Packet[20])*10   +
                                         Self.BCDToByte(Packet[21])*0.1;
                mdMemory.RXSubtone1   := Self.BCDToByte(Packet[22])*1000 +
                                         Self.BCDToByte(Packet[23])*10   +
                                         Self.BCDToByte(Packet[24])*0.1;
                mdMemory.DTCS1Polarity:= Self.BCDToByte(Packet[25]);
                mdMemory.DTCS1Code    := Self.BCDToByte(Packet[26])*100 +
                                         Self.BCDToByte(Packet[27]);
                mdMemory.Frequency2   := Self.BCDToDouble(AnsiString(Copy(String(Packet), 28, 5)), ctFrequency);
                mdMemory.Mode2        := Self.BCDToByte(Packet[33]);
                mdMemory.Filter2      := Self.BCDToByte(Packet[34]);
                mdMemory.Flags2       := Self.BCDToByte(Packet[35]);
                mdMemory.TXSubtone2   := Self.BCDToByte(Packet[36])*1000 +
                                         Self.BCDToByte(Packet[37])*10   +
                                         Self.BCDToByte(Packet[38])*0.1;
                mdMemory.RXSubtone2   := Self.BCDToByte(Packet[39])*1000 +
                                         Self.BCDToByte(Packet[40])*10   +
                                         Self.BCDToByte(Packet[41])*0.1;
                mdMemory.DTCS2Polarity:= Self.BCDToByte(Packet[42]);
                mdMemory.DTCS2Code    := Self.BCDToByte(Packet[43])*100 +
                                         Self.BCDToByte(Packet[44]);
                mdMemory.Name         := AnsiString(Copy(Packet, 45, 9));
              end else begin
                // blank memory position
                mdMemory.IsBlank := True;
              end;

              // call event, if assigned
              if Assigned(Self.FOnReadMemoryBank) then begin
                Self.FOnReadMemoryBank(Self, mdMemory);
              end;
            end;

          //
          CIV_MEMORY_BAND_STACK_REG:
            begin

            end;

          CIV_MEMORY_KEYER:
            begin

            end;

          CIV_MEMORY_SELECTED_FILTER:
            begin

            end;

          CIV_MEMORY_AGC_TIMER:
            begin

            end;

          CIV_MEMORY_SETUP_VALUES:
            begin

            end;
        end;
      end;
  end;

  // codesite debug
  {$IFDEF DEBUG}
    CodeSite.ExitMethod('ProcessDataPacket');
  {$ENDIF}
end;

// ---------------------------------------------------------------------------

procedure TIcomCIV.SendPacket(sIn: AnsiString);
var
  sPacket:  AnsiString;
begin
  {$IFDEF DEBUG}
     CodeSite.EnterMethod('SendPacket');
  {$ENDIF}

  // assemble packet: prefix + command and parameters + suffix
  sPacket := AnsiString(CIV_PACKET_BEGIN +
                     AnsiChar(Chr(Self.GetRadioAddress)) +
                     CIV_COMPUTER_ADDRESS +
                     sIn +
                     CIV_PACKET_END);

  // adjust echo packet detector
  Self.FDataProcessor.DataPackets[0].PacketBegin := sPacket;
  Self.FDataProcessor.DataPackets[0].PacketLength := Length(Self.FDataProcessor.DataPackets[0].PacketBegin);
  Self.FDataProcessor.DataPackets.Reset;

  // change protocol status if needed
  if not (sPacket[CIV_PACKET_POSITION_COMMAND] in CIV_RESPONSELESS_COMMANDS) then begin
    // wait for command response
    Self.FProtocolState := psWaitingDevice;
  end;

  // send packet to the serial port
  Self.FPort.SendString(sPacket);

  // codesite debug
  {$IFDEF DEBUG}
    CodeSite.Send(csmInfo, Format('Packet Sent: %s', [Self.CharStrToHexStr(sPacket)]));
  {$ENDIF}

  // wait for response when needed
  while Self.FProtocolState <> psIdle do Application.ProcessMessages;

  // codesite debug
  {$IFDEF DEBUG}
    CodeSite.ExitMethod('SendPacket');
  {$ENDIF}
end;

// ---------------------------------------------------------------------------

function TIcomCIV.CharToHex(cIn: AnsiChar): AnsiString;
var
  sAux:   AnsiString;
begin
  // cria AnsiString hexa
  sAux := AnsiString(Format('%02x',[Ord(Byte(cIn))]));

  // formata AnsiString hexa
  if ( sAux[1] = ' ' ) then sAux[1] := '0';

  // devolve o valor formatado
  Result := sAux;
end;

//------------------------------------------------------------------------------

function TIcomCIV.CharStrToHexStr(sIn: AnsiString): AnsiString;
var
  I:        Integer;
begin
  // initializes result
  Result := '';

  // Converts AnsiString
  for I := 1 to Length(sIn) do begin
    Result := Result + CharToHex(sIn[i]);
  end;
end;

//------------------------------------------------------------------------------

function TIcomCIV.HexStrToCharStr(sIn: AnsiString): AnsiString;
var
  iAux: SmallInt;
begin
  // convert hex str to char str
  iAux := 1;
  while iAux < Length(sIn) do begin
    Result := Result + AnsiChar(Chr(StrToInt('$'+Copy(String(sIn), iAux, 2))));
    Inc(iAux, 2);
  end;
end;

//------------------------------------------------------------------------------

function TIcomCIV.BCDToDouble(sIn: AnsiString; ConversionType: TDoubleConverionType): Double;
begin
  {$IFDEF DEBUG}
    CodeSite.EnterMethod('BCDToDouble');
  {$ENDIF}

  // initializes
  Result := 0.0;

  // choose conversion type
  case ConversionType of
    // frequency
    ctFrequency:
      begin
        // converts frequency from BCD format to floating-point
        Result := StrToInt(string(CharToHex(sIn[1]))) * 0.001 +
                  StrToInt(string(CharToHex(sIn[2]))) * 0.1   +
                  StrToInt(string(CharToHex(sIn[3]))) * 10     +
                  StrToInt(string(CharToHex(sIn[4]))) * 1000      +
                  StrToInt(string(CharToHex(sIn[5]))) * 100000;
      end;

    // SubTone
    ctSubTone:
      begin
        // converts subtone to floating point
        Result := StrToInt(String(CharToHex(sIn[1]) + CharToHex(sIn[2]) + CharToHex(sIn[3]))) / 10;
      end;
  end;

  {$IFDEF DEBUG}
    case ConversionType of
      // frequency
      ctFrequency:
        begin
          CodeSite.Send(csmInfo, 'Frequencia = ', Format('%9.2f MHz', [Result]));
        end;

      // SubTone
      ctSubTone:
        begin
          CodeSite.Send(csmInfo, 'SubTom = ', Format('%5.1f kHz', [Result]));
        end;
    end;
    CodeSite.ExitMethod('BCDToDouble');
  {$ENDIF}
end;

//------------------------------------------------------------------------------

function TIcomCIV.DoubleToBCD(Value: Double; ConversionType: TDoubleConverionType): AnsiString;
var
  sAux:         AnsiString;
begin
  {$IFDEF DEBUG}
    CodeSite.EnterMethod('DoubleToBCD');
  {$ENDIF}

  // choose conversion type
  case ConversionType of
    // frequency
    ctFrequency:
    begin
      // format string with leading zeroes
      sAux := AnsiString(StringReplace(FormatFloat('0#####.#0', Value), FormatSettings.DecimalSeparator, '', [rfReplaceAll, rfIgnoreCase]));

      // Assembly ICOM pattern for frequency
      // Freq = 123456.78 -> Result = 8067452301
      Result := Copy(sAux, 8, 1) + '0';
      Result := Result + Copy(sAux, 6, 2);
      Result := Result + Copy(sAux, 4, 2);
      Result := Result + Copy(sAux, 2, 2);
      Result := Result + '0' + Copy(sAux, 1, 1);
    end;

    // SubTone
    ctSubTone:
    begin
      // format string with leading zeroes and assembly ICOM pattern for Subtones
      // Subtone = 82.5 -> Result = 0825
      Result := AnsiString(StringReplace(FormatFloat('0####.0', Value), FormatSettings.DecimalSeparator, '', [rfReplaceAll, rfIgnoreCase]));
    end;
  end;

  // transform into HexString
  Result := Self.HexStrToCharStr(Result);

  {$IFDEF DEBUG}
    case ConversionType of
      // frequency
      ctFrequency:
        begin
          CodeSite.Send(csmInfo, Format('Freq = %9.2f', [Self.BCDToDouble(Result, ConversionType)]));
        end;

      // SubTone
      ctSubTone:
        begin
          CodeSite.Send(csmInfo, Format('SubTom = %5.1f kHz', [Self.BCDToDouble(Result, ConversionType)]));
        end;
    end;
    CodeSite.ExitMethod('DoubleToBCD');
  {$ENDIF}
end;

//------------------------------------------------------------------------------
function TIcomCIV.IntToBCD(Value: Word): AnsiString;
begin
  {$IFDEF DEBUG}
    CodeSite.EnterMethod('IntToBCD');
  {$ENDIF}

  // Transforms into CharString
  Result := Self.HexStrToCharStr(AnsiString(Format('%0.4d', [Value])));
  
  {$IFDEF DEBUG}
    CodeSite.Send(csmInfo, Format('Packet: %s', [Self.CharStrToHexStr(Result)]));
    CodeSite.ExitMethod('IntToBCD');
  {$ENDIF}
end;

//------------------------------------------------------------------------------

function TIcomCIV.ByteToBCD(Value: Byte): AnsiChar;
begin
  // Transforms byte into BCD format
  Result := AnsiChar(Chr(Byte((16*(Value div 10))+ (Value mod 10))));
end;

//------------------------------------------------------------------------------

function TIcomCIV.BCDToByte(Value: AnsiChar): Byte;
begin
  // Transforms BCD into byte format
  Result := 10*(Ord(Value) div 16) + (Ord(Value) mod 16);
end;

// ---------------------------------------------------------------------------

function TIcomCIV.MapRange(Value, InStart, InEnd:Byte; OutStart, OutEnd:Single): Single;
begin
  // map a range
  Result := OutStart + ((OutEnd - OutStart) / (InEnd - InStart)) * (Value - InStart);
end;

//----------------------------------------------------------------------------
// Public Routines
//----------------------------------------------------------------------------

constructor TIcomCIV.Create(AOwner: TComponent);
begin
  // creates the component
  inherited Create(AOwner);

  // code site enable
  {$IFDEF DEBUG}
    CodeSite.Enabled := True;
    CodeSite.Clear;
  {$ENDIF}

  // create objects
  FPort := TnrComm.Create(Self);
  FDataProcessor := TnrDataProcessor.Create(Self);

  // set port events
  Self.FPort.OnFatalError          := Self.NrCommFatalError;
  Self.FDataProcessor.OnFatalError := Self.DataProcessorFatalError;
  Self.FDataProcessor.OnDataPacket := Self.NewDataPacket;

  // set initial values
  Self.FPort.ComPortNo := CIV_PORT_DEFAULT_PORT_NO;
  Self.FPort.BaudRate  := CIV_PORT_DEFAULT_BAUD_RATE;
  Self.FProtocolState  := psIdle;
  Self.FRadioModel     := rmIC_7000;

  // command ECHO - Index 0
  with Self.FDataProcessor.DataPackets.Add do begin
    Caption      := 'Command Echo';
    Active       := True;
    PacketBegin  := CIV_PACKET_BEGIN;   // this value is set dinamically
    PacketLength := 1;                  // this value is set dinamically
    ResetOthers  := True;
  end;

  // command Command OK - Index 1
  with Self.FDataProcessor.DataPackets.Add do begin
    Caption      := 'Command OK';
    Active       := True;
    PacketBegin  := AnsiString(CIV_PACKET_BEGIN + CIV_COMPUTER_ADDRESS + AnsiChar(Chr(Self.GetRadioAddress)) + CIV_COMMAND_OK + CIV_PACKET_END);
    PacketLength := Length(PacketBegin);
    ResetOthers  := True;
  end;

  // command Command NOT OK - Index 2
  with Self.FDataProcessor.DataPackets.Add do begin
    Caption      := 'Command NOT OK';
    Active       := True;
    PacketBegin  := AnsiString(CIV_PACKET_BEGIN + CIV_COMPUTER_ADDRESS + AnsiChar(Chr(Self.GetRadioAddress)) + CIV_COMMAND_NOT_OK + CIV_PACKET_END);
    PacketLength := Length(PacketBegin);
    ResetOthers  := True;
  end;

  // automatic packet for incomming data - Index 3
  with Self.FDataProcessor.DataPackets.Add do begin
    Caption      := 'Automatic Data Packet';
    Active       := True;
    PacketBegin  := CIV_PACKET_BEGIN;
    PacketEnd    := CIV_PACKET_END;
    ResetOthers  := False;
  end;

  // set port's data processor
  Self.FPort.DataProcessor := Self.FDataProcessor;
end;

// ---------------------------------------------------------------------------

destructor TIcomCIV.Destroy;
begin
  // destroy objects
  Self.FPort.Active := False;
  Self.FDataProcessor.Active := False;
  Self.FPort.Free;
  Self.FDataProcessor.Free;
  inherited;
end;

// ---------------------------------------------------------------------------

procedure TIcomCIV.Speech(Mode: TSpeechMode);
var
  sAux:     AnsiString;
begin
  // send speech command
  sAux := AnsiString(CIV_COMMAND_SPEECH + AnsiChar(Chr(Ord(Mode))));
  Self.SendPacket(sAux);
end;

// ---------------------------------------------------------------------------

procedure TIcomCIV.ReadMemory(Bank: TMemoryBanks; Position: SmallInt);
var
  sAux:            AnsiString;
  bHigh, bLow:     Byte;
begin
  // codesite debug
  {$IFDEF DEBUG}
    // not necessary to show echo commands
    CodeSite.EnterMethod('ReadMemory');
  {$ENDIF}

  // check memory indexes
  if Position > 99 then begin
    // set aditional index
    bHigh := 1;
    bLow  := (Position - 100) and $00FF;
  end else begin
    // no additional index need
    bHigh := 0;
    bLow  := Position and $00FF;
  end;

  // assembly command string
  sAux := AnsiString(CIV_COMMAND_MEMORY_CONTENTS +
                     CIV_MEMORY_READ_WRITE +
                     AnsiChar(Chr(Byte(Bank) and $FF)) +
                     AnsiChar(Chr(bHigh)) +
                     Self.ByteToBCD(bLow));

  // codesite debug
  {$IFDEF DEBUG}
    CodeSite.Send(csmInfo, Format('Position: %d - Packet: %s', [Position, Self.CharStrToHexStr(sAux)]));
  {$ENDIF}

  // send string to the serial port
  Self.SendPacket(sAux);

  // codesite debug
  {$IFDEF DEBUG}
    CodeSite.ExitMethod('ReadMemory');
  {$ENDIF}
end;

// ---------------------------------------------------------------------------

procedure TIcomCIV.WriteMemory(MemoryData: TMemoryData);
var
  sAux:            AnsiString;
  bHigh, bLow:     Byte;
begin
  // codesite debug
  {$IFDEF DEBUG}
    // not necessary to show echo commands
    CodeSite.EnterMethod('WriteMemory');
  {$ENDIF}

  // check memory indexes
  if MemoryData.MemoryNumber > 99 then begin
    // set aditional index
    bHigh := 1;
    bLow  := (MemoryData.MemoryNumber - 100) and $00FF;
  end else begin
    // no additional index need
    bHigh := 0;
    bLow  := MemoryData.MemoryNumber and $00FF;
  end;

  // assembly comand line with channel data to be stored
  sAux := AnsiString(CIV_COMMAND_MEMORY_CONTENTS +
                     CIV_MEMORY_READ_WRITE +
                     AnsiChar(Chr(Byte(MemoryData.Bank) and $FF)) +
                     AnsiChar(Chr(bHigh)) +
                     Self.ByteToBCD(bLow) +
                     AnsiChar(Chr(Ord(MemoryData.ScanSelected))) +
                     Self.DoubleToBCD(MemoryData.Frequency1, ctFrequency) +
                     Self.ByteToBCD(MemoryData.Mode1) +
                     Self.ByteToBCD(MemoryData.Filter1) +
                     Self.ByteToBCD(MemoryData.Flags1) +
                     Self.DoubleToBCD(MemoryData.TXSubtone1, ctSubTone) +
                     Self.DoubleToBCD(MemoryData.RXSubtone1, ctSubTone) +
                     Self.ByteToBCD(MemoryData.DTCS1Polarity) +
                     Self.IntToBCD(MemoryData.DTCS1Code) +
                     Self.DoubleToBCD(MemoryData.Frequency2, ctFrequency) +
                     Self.ByteToBCD(MemoryData.Mode2) +
                     Self.ByteToBCD(MemoryData.Filter2) +
                     Self.ByteToBCD(MemoryData.Flags2) +
                     Self.DoubleToBCD(MemoryData.TXSubtone2, ctSubTone) +
                     Self.DoubleToBCD(MemoryData.RXSubtone2, ctSubTone) +
                     Self.ByteToBCD(MemoryData.DTCS2Polarity) +
                     Self.IntToBCD(MemoryData.DTCS2Code) +
                     MemoryData.Name);

  // send data to the radio
  Self.SendPacket(sAux);

  // codesite debug
  {$IFDEF DEBUG}
    CodeSite.Send(csmInfo, Format('Write Packet: %s', [Self.CharStrToHexStr(sAux)]));
    CodeSite.ExitMethod('WriteMemory');
  {$ENDIF}
end;

// ---------------------------------------------------------------------------

procedure TIcomCIV.SetPowerState(Value: TPowerState);
var
  sAux:     AnsiString;
begin
  // send power off command
  sAux := AnsiString(CIV_COMMAND_TURN_RECEIVER_POWER + AnsiChar(Chr(Ord(Value))));
  Self.SendPacket(sAux);
end;


// ---------------------------------------------------------------------------

procedure TIcomCIV.SetPreAmp(Value: TPreAmpSetting);
var
  sAux:     AnsiString;
begin
  // send PreAmp command
  sAux := AnsiString(CIV_COMMAND_ON_OFF_SETTINGS + CIV_SUB_CMD_SET_PREAMP + AnsiChar(Chr(Ord(Value))));
  Self.SendPacket(sAux);
end;

// ---------------------------------------------------------------------------

procedure TIcomCIV.SetNoiseBlanker(Value: TNoiseBlankerState);
var
  sAux:     AnsiString;
begin
  // send PreAmp command
  sAux := AnsiString(CIV_COMMAND_ON_OFF_SETTINGS + CIV_SUB_CMD_SET_NOISE_BLANKER + AnsiChar(Chr(Ord(Value))));
  Self.SendPacket(sAux);
end;

// ---------------------------------------------------------------------------

procedure TIcomCIV.SetNoiseReduction(Value: TNoiseReductionState);
var
  sAux:     AnsiString;
begin
  // send PreAmp command
  sAux := AnsiString(CIV_COMMAND_ON_OFF_SETTINGS + CIV_SUB_CMD_SET_NOISE_REDUCTION + AnsiChar(Chr(Ord(Value))));
  Self.SendPacket(sAux);
end;

// ---------------------------------------------------------------------------

procedure TIcomCIV.SetAutoNotch(Value: TAutoNotchState);
var
  sAux:     AnsiString;
begin
  // send PreAmp command
  sAux := AnsiString(CIV_COMMAND_ON_OFF_SETTINGS + CIV_SUB_CMD_SET_AUTO_NOTCH + AnsiChar(Chr(Ord(Value))));
  Self.SendPacket(sAux);
end;

// ---------------------------------------------------------------------------

procedure TIcomCIV.SetManualNotch(Value: TManualNotchState);
var
  sAux:     AnsiString;
begin
  // send PreAmp command
  sAux := AnsiString(CIV_COMMAND_ON_OFF_SETTINGS + CIV_SUB_CMD_SET_MANUAL_NOTCH + AnsiChar(Chr(Ord(Value))));
  Self.SendPacket(sAux);
end;


// ---------------------------------------------------------------------------

procedure TIcomCIV.SetModulationMode(Value: TModulationMode);
var
  sAux:     AnsiString;
begin
  // send ModulationMode command
  sAux := AnsiString(CIV_COMMAND_TRANSF_OPERATING_MODE_DATA + AnsiChar(Chr(Ord(Value))));
  Self.SendPacket(sAux);
end;

// ---------------------------------------------------------------------------

procedure TIcomCIV.ClearMemory(Bank: TMemoryBanks; Position: SmallInt);
var
  sAux:             AnsiString;
  bHigh, bLow:      Byte;
begin
  // codesite debug
  {$IFDEF DEBUG}
    // not necessary to show echo commands
    CodeSite.EnterMethod('ClearMemory');
  {$ENDIF}

  // select memory bank
  sAux := AnsiString(CIV_COMMAND_SELECT_MEMORY_MODE + 
                     CIV_SUB_CMD_SELECT_MEMORY_BANK + 
                     AnsiChar(Chr(Ord(Bank))));
  Self.SendPacket(sAux);
  
  // assembly memory position
  if Position > 99 then begin
    // set aditional index
    bHigh := 1;
    bLow  := (Position - 100) and $00FF;
  end else begin
    // no additional index need
    bHigh := 0;
    bLow  := Position and $00FF;
  end;

  // select channel
  sAux := AnsiString(CIV_COMMAND_SELECT_MEMORY_MODE +
                     AnsiChar(Chr(bHigh)) +
                     Self.ByteToBCD(bLow));
  Self.SendPacket(sAux);  

  // Clear selected bank position
  sAux := AnsiString(CIV_COMMAND_CLEAR_SELECTED_MEMORY);
  Self.SendPacket(sAux);  

  // codesite debug
  {$IFDEF DEBUG}
    // not necessary to show echo commands
    CodeSite.ExitMethod('ClearMemory');
  {$ENDIF}
end;

// ---------------------------------------------------------------------------
// Events Routines
// ---------------------------------------------------------------------------

procedure TIcomCIV.NrCommFatalError(Sender: TObject; ErrorCode, Detail: Cardinal; ErrorMsg: string; var RaiseException: Boolean);
begin
  // dispatch if assigned
  if Assigned(Self.FOnNrCommError) then begin
    Self.FOnNrCommError(Sender, ErrorCode, Detail, ErrorMsg, RaiseException);
  end;
end;

// ---------------------------------------------------------------------------

procedure TIcomCIV.DataProcessorFatalError(Sender: TObject; ErrorCode, Detail: Cardinal; ErrorMsg: string; var RaiseException: Boolean);
begin
  // dispatch if assigned
  if Assigned(Self.FOnDataProcessorError) then begin
    Self.FOnDataProcessorError(Sender, ErrorCode, Detail, ErrorMsg, RaiseException);
  end;
end;

// ---------------------------------------------------------------------------

procedure TIcomCIV.NewDataPacket(Sender: TObject; Packet: TnrDataPacket);
begin
  // codesite debug
  {$IFDEF DEBUG}
    // Show all incomming packets and types
    CodeSite.EnterMethod('NewDataPacket');
    CodeSite.Send(csmInfo, Format('Packet Received: %s - Packet Index: %d - %s', [Self.CharStrToHexStr(Packet.Data), Packet.Index, Self.FDataProcessor.DataPackets.Items[Packet.Index].Caption]));

    // echo commands are discarded!
    if (Packet.Index = 0) then begin
       CodeSite.Send(csmWarning, 'Echo Packet Discarded!');
    end;
  {$ENDIF}

  // check for assigned event
  if Assigned(Self.FOnNewDataPacket) then begin
    // chama o evento
    Self.FOnNewDataPacket(Sender, Packet);
  end;

  // process data packet - echoed data packets are discarded
  if Packet.Index > 0 then begin
    Self.ProcessDataPacket(Packet.Data);
    Self.FProtocolState := psIdle;
  end;

  // codesite debug
  {$IFDEF DEBUG}
    CodeSite.ExitMethod('NewDataPacket');
  {$ENDIF}
end;

// ---------------------------------------------------------------------------
// Get & Set Routines
// ---------------------------------------------------------------------------

function TIcomCIV.GetVersion: String;
begin
  // returns actual version
  Result := CIV_COMPONENT_VERSION;
end;

// ---------------------------------------------------------------------------

procedure TIcomCIV.SetPortActive(Value: Boolean);
begin
  // change to value only if needed
  if Value <> Self.FPort.Active then begin
      // change port state
      if (Value) then begin
        Self.FPort.Active := Value;
        FDataProcessor.Active := Value;
      end else begin
        FDataProcessor.Active := Value;
        Self.FPort.Active := Value;
      end;
  end;
  {$IFDEF DEBUG}
    if Value then
      CodeSite.Send(csmInfo, 'Port Is Active')
    else
      CodeSite.Send(csmInfo, 'Port Is Inactive');
  {$ENDIF}
end;

// ---------------------------------------------------------------------------

function TIcomCIV.GetPortActive: Boolean;
begin
  // returns actual port number
  Result := Self.FPort.Active;
end;

// ---------------------------------------------------------------------------

procedure TIcomCIV.SetPortNumber(Value: Word);
begin
  // change to value only if needed
  if Value <> Self.FPort.ComPortNo then Self.FPort.ComPortNo := Value;
end;

// ---------------------------------------------------------------------------

function TIcomCIV.GetPortNumber: Word;
begin
  // returns actual port number
  Result := Self.FPort.ComPortNo;
end;

// ---------------------------------------------------------------------------

procedure TIcomCIV.SetBaudRate(Value: Cardinal);
begin
  // change to value only if needed
  if Value <> Self.FPort.BaudRate then Self.FPort.BaudRate := Value;
end;

// ---------------------------------------------------------------------------

function TIcomCIV.GetBaudRate: Cardinal;
begin
  // returns actual baud rate
  Result := Self.FPort.BaudRate;
end;

// ---------------------------------------------------------------------------

procedure TIcomCIV.SetRadioModel(Value: TRadioModel);
begin
  // change to value only if needed
  if Value <> Self.FRadioModel then Self.FRadioModel := Value;
end;

// ---------------------------------------------------------------------------

function TIcomCIV.GetRadioModel: TRadioModel;
begin
  // returns actual radio model
  Result := Self.FRadioModel;
end;

// ---------------------------------------------------------------------------

function TIcomCIV.GetRadioAddress: Byte;
begin
  // returns radio address accordingly to the model
  case Self.RadioModel of
    rmIC_706:     Result := $58;
    rmIC_7000:    Result := $70;
  else
    // exception
    raise Exception.Create('Invalid Radio Model') at @TIcomCIV.GetRadioAddress;
  end
end;

// ---------------------------------------------------------------------------

function TIcomCIV.GetVFOA: TVFO_Data;
begin
  // return VFO Data
  Result := FVFO_A;
end;

// ---------------------------------------------------------------------------

procedure TIcomCIV.UpdateLevelReadings;
var
  sAux:     AnsiString;
begin
  // send read squelch status
  sAux := AnsiString(CIV_COMMAND_LEVEL_READINGS + CIV_SUB_CMD_READING_SQUELCH_STATUS);
  Self.SendPacket(sAux);
  
  // send read signal command
  sAux := AnsiString(CIV_COMMAND_LEVEL_READINGS + CIV_SUB_CMD_READING_SIGNAL_STRENGTH);
  Self.SendPacket(sAux);

  // send read Power output
  sAux := AnsiString(CIV_COMMAND_LEVEL_READINGS + CIV_SUB_CMD_READING_RF_POWER_OUTPUT);
  Self.SendPacket(sAux);
  
  // send read SWR meter
  sAux := AnsiString(CIV_COMMAND_LEVEL_READINGS + CIV_SUB_CMD_READING_SWR_METER);
  Self.SendPacket(sAux);
  
  // send read ALC 
  sAux := AnsiString(CIV_COMMAND_LEVEL_READINGS + CIV_SUB_CMD_READING_ALC_METER);
  Self.SendPacket(sAux);
  
  // send read audio compressor
  sAux := AnsiString(CIV_COMMAND_LEVEL_READINGS + CIV_SUB_CMD_READING_COMPRESSOR_METER);
  Self.SendPacket(sAux);
  
  // send read Vd
  sAux := AnsiString(CIV_COMMAND_LEVEL_READINGS + CIV_SUB_CMD_READING_VD_VALUE);
  Self.SendPacket(sAux);

  // send read Id
  sAux := AnsiString(CIV_COMMAND_LEVEL_READINGS + CIV_SUB_CMD_READING_ID_VALUE);
  Self.SendPacket(sAux);  
end;

end.

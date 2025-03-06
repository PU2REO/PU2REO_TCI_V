unit uCIVEditors;

interface

uses
  {$WARN UNIT_PLATFORM OFF}
  VCL.FileCtrl,
  {$WARN UNIT_PLATFORM ON}
  SysUtils, DesignEditors, DesignIntf;

type
  // About box dialog
  TCIVAboutBoxProperty = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

implementation

uses
  Dialogs, Forms, uCIVAboutBox, uCIVGlobalConstants;

// ---------------------------------------------------------------------------------------------

function TCIVAboutBoxProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [ paDialog, paReadOnly ];
end;

// ---------------------------------------------------------------------------------------------

function TCIVAboutBoxProperty.GetValue: string;
begin
  // default return
  Result := 'About this component...';
end;

// ---------------------------------------------------------------------------------------------

procedure TCIVAboutBoxProperty.Edit;
var
  Dialog: TfrmCIVAboutBox;
begin
  // Create and shows AboutBox frome
  Dialog := TfrmCIVAboutBox.Create(Application);
  try
    Dialog.ShowModal;
  finally
    Dialog.Free;
  end;
end;

end.


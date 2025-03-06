unit uCIVRegistration;

interface

uses System.Classes, DesignEditors, DesignIntf, ToolsAPI, System.SysUtils,
     uCIVGlobalConstants, uCIVEditors, Vcl.Graphics;

procedure Register;
procedure RegisterWithSplashScreen;

implementation

uses uIcomCIV;

//----------------------------------------------------------------------------

procedure RegisterWithSplashScreen;
var
  Bmp: TBitmap;
begin
  // Register Component Icon on Delphi Splash Screen
  Bmp := TBitmap.Create;
  Bmp.LoadFromResourceName( HInstance, 'TIcomCIV' );

  try
    SplashScreenServices.AddPluginBitmap( 'Comunications Interface V for Icom Radios ' + CIV_COMPONENT_VERSION,
                                          Bmp.Handle, False, 'Still Under Development', '' );
  finally
    Bmp.Free;
  end;
end;

//----------------------------------------------------------------------------

procedure Register;
begin
  // Register at Delphi Splashscreen
  RegisterWithSplashScreen;

  // Register at delphi component pallet
  RegisterPropertyEditor(TypeInfo(TCIVAboutInfo), nil, 'About', TCIVAboutBoxProperty);
  RegisterComponents(CIV_COMPONENT_PAGE, [TIcomCIV]);
end;


end.

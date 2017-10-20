program Pointer_GB_GBC;

uses
  Forms,
  Unit1 in 'Unit1.pas' {frmMain},
  VCLFixPack in 'VCLFixPack.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Calculation of the pointers (NES, GameBoy, GameBoy Color)';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

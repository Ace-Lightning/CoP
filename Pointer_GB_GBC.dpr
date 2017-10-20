program Pointer_GB_GBC;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  VCLFixPack in 'VCLFixPack.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Calculation of the pointers (NES, GameBoy, GameBoy Color)';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

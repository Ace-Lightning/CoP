unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons, VistaAltFixUnit, XPMan;

type
  TForm1 = class(TForm)
    btnAbout: TButton;
    btnGo: TButton;
    grbGBx: TGroupBox;
    rbt2byte: TRadioButton;
    rbt3byte: TRadioButton;
    cobPlatform: TComboBox;
    grbNES: TGroupBox;
    cobMapper: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    editBank: TEdit;
    Label3: TLabel;
    editComposed: TEdit;
    Label4: TLabel;
    editOffset: TMemo;
    editPointer: TMemo;
    Label5: TLabel;
    Label6: TLabel;
    prbProgress: TProgressBar;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    XPManifest1: TXPManifest;
    procedure btnGoClick(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure cobPlatformClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure cobMapperClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  DataNES: array of array of string;

implementation

{$R *.dfm}

procedure TForm1.btnGoClick(Sender: TObject);
Var Offset, Pointer: longint;
  Q, i: integer;
begin
  if editOffset.Text='' then begin
    editPointer.Text:='You must enter the values into "Offsets"!';
    exit;
  end;
  editPointer.Lines.Clear;
  Q:=editOffset.Lines.Count-1;
  prbProgress.Position:=0;
  for i:=0 to Q do begin
    prbProgress.Min:=0;
    prbProgress.Max:=Q;
    Offset:=0;
    Pointer:=0;
    Offset:=StrToInt(editOffset.Lines.Strings[i]);
    if cobPlatform.Text='GBx' then begin
      if rbt2byte.Checked=True then begin
        Pointer:=(Offset and $3FFF) + $4000;
        Pointer:=((Pointer and $FF) shl 8) + (Pointer shr 8) and $FF;
        editPointer.Lines.Add(IntToHex(Pointer,4));
        prbProgress.Position:=i;
      end;
      if rbt3byte.Checked=True then begin
        Pointer:=(Offset and $3FFF) + $4000;
        Pointer:=(trunc(Offset/$4000) shl 16) + ((Pointer and $FF) shl 8) + (Pointer shr 8) and $FF;
        editPointer.Lines.Add(IntToHex(Pointer,6));
        prbProgress.Position:=i;
      end;
    end;
    if cobPlatform.Text='NES' then begin
      Pointer:=((Offset-$10) and StrToInt(editBank.Text)) + StrToInt(editComposed.Text);
      Pointer:=((Pointer and $FF) shl 8) + (Pointer shr 8) and $FF;
      editPointer.Lines.Add(IntToHex(Pointer,4));
      prbProgress.Position:=i;
    end;
  end;
end;

procedure TForm1.btnAboutClick(Sender: TObject);
begin
  Application.MessageBox('The programm calculates the pointers.'+
  #13#10'Version - 1.3'+
  #13#10'Platform: NES, GameBoy, GameBoy Color.'+
  #13#10'Created by Ace Lightning.'+
  #13#10'July, 2011-2014.','About',MB_OK);
end;

procedure TForm1.cobPlatformClick(Sender: TObject);
begin
  if cobPlatform.Text='GBx' then begin
    grbGBx.Visible:=True;
    grbNES.Visible:=False;
  end;
  if cobPlatform.Text='NES' then begin
    grbGBx.Visible:=False;
    grbNES.Visible:=True;
  end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
Var FName: String;
begin
  if OpenDialog1.Execute then begin
    FName:=OpenDialog1.FileName;
    editOffset.Lines.LoadFromFile(FName);
  end;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
Var FName: String;
begin
  if SaveDialog1.Execute then begin
    FName:=SaveDialog1.FileName;
    EditPointer.Lines.SaveToFile(FName);
  end;
end;

procedure TForm1.cobMapperClick(Sender: TObject);
begin
  if cobMapper.ItemIndex<>High(DataNES)+1 then begin
    editBank.Text:=DataNES[cobMapper.ItemIndex,1];
    editComposed.Text:=DataNES[cobMapper.ItemIndex,2];
  end else begin
    editBank.Text:='';
    editComposed.Text:='';
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
Var F: TextFile;
  S1: string[1];
  i, j: integer;
begin
  TVistaAltFix.Create(Self);
  AssignFile(F, 'NES.cop');
  Reset(F);
  i:=0;
   while not EOF(F) do begin
    Name:='';
    Inc(i);
    SetLength(DataNES,i,3);
    j:=0;
    while not EOLn(F) do begin
      read(F, S1);
      if S1<>'/' then
        DataNES[i-1,j]:= DataNES[i-1,j] + S1
      else begin
        read(F);
        if j=0 then cobMapper.Items.Add(DataNES[i-1,j]);
        Inc(j);
      end;
    end;
    readln(F);
   end;
  CloseFile(F);
  cobMapper.Items.Add('Other');
end;

end.

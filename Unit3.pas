unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls;

type
  TForm3 = class(TForm)
    Timer1: TTimer;
    Edit1: TEdit;
    Button1: TButton;
    RichEdit1: TRichEdit;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  messageTxt, username, filename: string;
  lastTime: integer;

implementation

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
var Txt: TextFile;
begin
    AssignFile(Txt, filename);
  Rewrite(Txt);
writeln(Txt, username+': '+Edit1.Text);
  CloseFile(Txt);
  Edit1.Text := '';
end;

procedure TForm3.FormCreate(Sender: TObject);
var Txt: TextFile;
begin

while not FileExists(filename) do begin
    filename := Dialogs.InputBox('Server Selection', 'Please enter your the servers file location:', './test.txt');
    if filename = '' then break;
end;

if filename = '' then Application.Terminate;

if FileExists('name') then begin
  AssignFile(Txt, 'name');
  Reset(Txt);
  Readln(Txt, username);
  CloseFile(Txt);
end
else begin
    username := Dialogs.InputBox('Username Selection', 'Please enter your username:', 'test');
    if username = '' then Application.Terminate;

end;

lastTime := FileAge(filename);

Timer1.Enabled := True;

end;

procedure TForm3.Timer1Timer(Sender: TObject);
var Txt: TextFile;
s : String;

begin

if FileAge(filename) <> lastTime then begin

  AssignFile(Txt, filename);
  Reset(Txt);
  Readln(Txt, s);
    RichEdit1.Lines.Add(s);
  messageTxt := s;
  CloseFile(Txt);

end;

lastTime := FileAge(filename);

end;

end.

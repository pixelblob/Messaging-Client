unit Unit3;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, superobject, DateUtils, IOUtils;

type
  Tplayer = class(Tobject)
  var
    x, y, oldX, oldY, lastPing: Real;
    id: String;
  end;

type
  TForm3 = class(TForm)
    Timer1: TTimer;
    Timer2: TTimer;
    Image1: TImage;
    deleteInactive: TTimer;
    paintCanvas: TTimer;
    procedure FormCreate(Sender: Tobject);
    procedure Timer1Timer(Sender: Tobject);
    procedure Button1Click(Sender: Tobject);
    procedure Timer2Timer(Sender: Tobject);
    procedure writeData(data: String);
    procedure Button2Click(Sender: Tobject);
    procedure FormClose(Sender: Tobject; var Action: TCloseAction);
    function lerp(start: Real; endd: Real; amt: Real): Real;
    function addPlayer(id: String): Tplayer;
    function playerExists(id: String): Bool;
    function getPlayer(id: String): Tplayer;
    procedure FormResize(Sender: Tobject);
    procedure paintCanvasTimer(Sender: Tobject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  messageTxt, username, filename: string;
  lastTime: TDateTime;
  playerId: string;
  playerArray: array of Tplayer;

implementation

{$R *.dfm}

function TForm3.addPlayer(id: String): Tplayer;
var
  player: Tplayer;
begin
  player := Tplayer.Create;
  player.x := 0;
  player.y := 0;
  player.id := id;
  player.lastPing := DateUtils.MilliSecondsBetween(Now, 0);

  SetLength(playerArray, Length(playerArray) + 1);
  playerArray[ High(playerArray)] := player;

  result := player;
end;

procedure TForm3.Button1Click(Sender: Tobject);
var
  Txt: TextFile;
begin
  // AssignFile(Txt, filename);
  // Rewrite(Txt);
  // writeln(Txt, username+': '+Edit1.Text);
  // CloseFile(Txt);
  // Edit1.Text := '';
end;

procedure TForm3.Button2Click(Sender: Tobject);
begin
  Timer2.Enabled := True;
end;

procedure TForm3.FormClose(Sender: Tobject; var Action: TCloseAction);
begin
  DeleteFile(filename + playerId);
end;

procedure TForm3.FormCreate(Sender: Tobject);
var
  path: string;
begin

  AllocConsole;



    playerId := inttostr(DateUtils.MilliSecondsBetween(Now, 0));

  addPlayer(playerId);

  // playerId := '3902146727059';



  filename := 'G:\players\';

  while not DirectoryExists(filename) do
  begin
    filename := Dialogs.InputBox('Server Selection',
      'Please enter your the servers file location:', '');
    filename := StringReplace(filename, '"', '', [rfReplaceAll]);
    if filename = '' then
      break;
  end;

   if filename = '' then
   Application.Terminate;

  // lastTime := FileAge(filename);

  Timer1.Enabled := True;
  Timer2.Enabled := True;

end;

procedure TForm3.FormResize(Sender: Tobject);
begin
  Image1.Picture.Bitmap.Width := Image1.Width;
  Image1.Picture.Bitmap.Height := Image1.Height;
end;

function TForm3.getPlayer(id: String): Tplayer;
var
  I: Integer;
begin
  for I := 0 to Length(playerArray) - 1 do
  begin
    if playerArray[I].id = id then
    begin
      result := playerArray[I];
    end;
  end;
end;

function TForm3.lerp(start, endd, amt: Real): Real;
begin
  result := (1 - amt) * start + amt * endd;
end;

procedure TForm3.paintCanvasTimer(Sender: Tobject);
var
  I: Integer;
  path, id: string;
  time: Real;
  x, y, oldX, oldY, size: Real;
begin

  Image1.Canvas.Brush.Color := clWhite;

  Image1.Canvas.Rectangle(-1, -1, Form3.ClientWidth + 1,
    Form3.ClientHeight + 1);

  size := 30;

  for I := 0 to Length(playerArray) - 1 do
  begin
    RandSeed := StrToInt64(playerArray[I].id);

    oldX := playerArray[I].oldX;
    oldY := playerArray[I].oldY;

    // playerArray[I].x := newX;

    x := playerArray[I].x;
    y := playerArray[I].y;

    time := 0.4;

    writeln(time);

    playerArray[I].oldX := lerp(oldX, x, time);
    playerArray[I].oldY := lerp(oldY, y, time);

    Image1.Canvas.Brush.Color := rgb(155 + round(random * 100),
      155 + round(random * 100), 155 + round(random * 100));

    Image1.Canvas.Rectangle(round(oldX - size / 2), round(oldY - size / 2),
      round(oldX + size / 2), round(oldY + size / 2));

  end;
end;

function TForm3.playerExists(id: String): Bool;
var
  I: Integer;
begin
  result := false;
  for I := 0 to Length(playerArray) - 1 do
  begin
    if playerArray[I].id = id then
    begin
      result := True;
    end;
  end;
end;

procedure TForm3.Timer1Timer(Sender: Tobject);
var
  Txt: TextFile;
  FileDateTime: TDateTime;
  s: String;
  slFile: TStrings;
  stream: TStream;
  obj: ISuperObject;
var
  path, id: string;
  I, x, y, size: Integer;
  player: Tplayer;
begin

  I := 0;

  for path in TDirectory.GetFiles(filename) do
  begin
    id := TPath.GetFileNameWithoutExtension(path);
    // writeln(id);
    // if not FileExists(path) then exit end;

    // writeln(Length(playerArray));
    // writeln(playerExists(id));

    if id <> playerId then
    begin

      if not playerExists(id) then
      begin
        addPlayer(id);
      end;

      player := getPlayer(id);

      slFile := TStringList.Create;

      stream := TFileStream.Create(path, fmOpenRead or fmShareDenyNone);

      slFile.LoadFromStream(stream);

      if slFile.Count <> 0 then
      begin

        obj := SO(slFile.Text);

        player.y := obj.AsObject.I['y'];
        player.x := obj.AsObject.I['x'];

        // RandSeed := StrToInt64(id);

        // Image1.Canvas.Brush.Color := rgb(155 + round(random * 100),
        // 155 + round(random * 100), 155 + round(random * 100));

        // Image1.Canvas.Rectangle(round(x - size / 2), round(y - size / 2),
        // round(x + size / 2), round(y + size / 2));

        // writeln(slFile.Text);
        inc(I);
      end;
    end;
  end;

end;

procedure TForm3.Timer2Timer(Sender: Tobject);
var
  pt: TPoint;
  ypos, xpos: Integer;
  FileDateTime: TDateTime;
begin
  // cum
  GetCursorPos(pt);
  pt := ScreenToClient(pt);
  xpos := pt.x;
  ypos := pt.y;

  getPlayer(playerId).y := ypos;
  getPlayer(playerId).x := xpos;

  FileAge(filename, FileDateTime);
  writeData('{"x":' + inttostr(xpos) + ',"y":' + inttostr(ypos) + '}');
end;

procedure TForm3.writeData(data: String);
var
  Txt: TextFile;
begin

  AssignFile(Txt, filename + playerId);
  Rewrite(Txt);
  writeln(Txt, data);
  CloseFile(Txt);

end;

end.

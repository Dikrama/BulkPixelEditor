unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ExtDlgs, Grids;

type

  { TFMain }

  TFMain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Dia: TOpenPictureDialog;
    Memo1: TMemo;
    Panel1: TPanel;
    grid: TStringGrid;
    dir: TSelectDirectoryDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FMain: TFMain;

implementation

{$R *.lfm}

{ TFMain }

procedure TFMain.Button1Click(Sender: TObject);
begin
  if dia.Execute then begin
     edit1.Text := dia.FileName;
     image1.Picture.LoadFromFile(dia.FileName);

  end;
end;

procedure TFMain.Button2Click(Sender: TObject);
var i,xWidth,xHeight:integer; bmp:TBitmap;
begin
 if (edit1.Text<>'') and (edit2.Text<>'') then begin
 try

 bmp := TBitmap.Create;

 for i:= 1 to grid.rowcount - 1 do begin
  if (grid.Cells[1,i]<>'') and (grid.Cells[0,i]<>'') then begin
    xWidth := strtoint(grid.Cells[1,i]);
    xHeight := strtoint(grid.Cells[0,i]);
    bmp.SetSize(xwidth,xheight);
    bmp.Canvas.StretchDraw(rect(0,0,xwidth,xheight),image1.Picture.Bitmap);
    bmp.SaveToFile(edit2.Text+'\'+extractfilename(edit1.Text)+grid.Cells[1,i]+grid.Cells[0,i]+'.png');
    memo1.Lines.Add('File created :'+edit2.Text+extractfilename(edit1.Text)+grid.Cells[1,i]+grid.Cells[0,i]+'.png');
   end;
 end;

 finally
   bmp.Free;
 end;

 end else showmessage('Lengkapi data dulu');
end;

procedure TFMain.Button3Click(Sender: TObject);
begin
  if dir.Execute then edit2.Text:= dir.FileName;
end;

procedure TFMain.Edit2Change(Sender: TObject);
var i : integer;
begin

end;

procedure TFMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  grid.SaveToFile(extractfilepath(application.ExeName)+'\temp');
end;

procedure TFMain.FormShow(Sender: TObject);
begin
  if fileexists(extractfilepath(application.ExeName)+'\temp') then
  grid.LoadFromFile(extractfilepath(application.ExeName)+'\temp');
  dir.InitialDir:= extractfilepath(application.ExeName);
  edit2.Text:=extractfilepath(application.ExeName);
end;

end.


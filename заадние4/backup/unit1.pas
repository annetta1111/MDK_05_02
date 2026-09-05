unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Label2Click(Sender: TObject);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
     var
       a, b, h, x, y: real;
begin
  a := StrToFloat(Edit1.Text);
  b := StrToFloat(Edit2.Text);
  h := StrToFloat(Edit3.Text);
  x := a;
  while x <= b do
  begin
    y := x * x;
    Memo1.Lines.Add(FloatToStr(x) + '     ' + FloatToStr(y));
    x := x + h;
  end;
end;

end.


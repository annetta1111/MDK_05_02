unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  x, y, f: real;
begin
     x := StrToFloat(Edit1.Text);
     y := StrToFloat(Edit2.Text);
  if x = 1 then
  begin
    Memo1.Lines.Add('Ошибка: x не может быть равен 1');
    exit;
  end;
    f := Power((x + 1) / (x - 1), x) + 18 * x * Power(y, 2);
    Memo1.Lines.Add('Результат: ' + FloatToStr(f));

end;

end.


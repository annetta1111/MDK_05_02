unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
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

procedure TForm1.Edit1Change(Sender: TObject);
begin

end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var i,t,k,k1:integer;
begin
    try
      k:=StrToInt(Edit1.Text);
      k1:=StrToInt(Edit2.Text);
      if k1 < 0 then
    begin
      Memo1.Lines.Add('Ошибка: Ваш алгоритм работает только с положительной степенью!');
      Exit;
    end;

    i := 1;
    t := 1;

    while i <= k1 do
    begin
      t := t * k;
      i := i + 1;
    end;

    Memo1.Lines.Add('число ' + Edit1.Text + ' в степени ' + Edit2.Text + ' равно: ' + IntToStr(t));

  except
    on E: EConvertError do
      Memo1.Lines.Add('Ошибка: Введите целые числа!');
  end;
end;

end.


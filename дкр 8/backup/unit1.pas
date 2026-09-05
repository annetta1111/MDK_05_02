unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    rashet: TMemo;
    sum: TEdit;
    stavka: TEdit;
    let: TEdit;
    tip: TEdit; // здесь будет выбор типа процентов (простые/сложные)
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  summa, stavka_proc, result_simple, result_compound: real;
  years, i: integer;
  tip_procent: string;
begin
  // Считываем входные данные
  summa := StrToFloat(sum.Text);
  stavka_proc := StrToFloat(stavka.Text) / 100; // переводим в десятичную дробь
  years := StrToInt(let.Text);
  tip_procent := tip.Text;

  rashet.Clear; // очищаем мемо перед выводом

  // Расчёт простых процентов
  if tip_procent = 'простые' then
  begin
    result_simple := summa + (summa * stavka_proc * years);
    rashet.Lines.Add('Расчёт простых процентов:');
    rashet.Lines.Add(Format('Сумма: %.2f', [summa]));
    rashet.Lines.Add(Format('Годовая ставка: %.2f%%', [stavka_proc * 100]));
    rashet.Lines.Add(Format('Количество лет: %d', [years]));
    rashet.Lines.Add(Format('Итоговая сумма: %.2f', [result_simple]));
  end

  // Расчёт сложных процентов
  else if tip_procent = 'сложные' then
  begin
    result_compound := summa;
    for i := 1 to years do
      result_compound := result_compound * (1 + stavka_proc);
    rashet.Lines.Add('Расчёт сложных процентов:');
    rashet.Lines.Add(Format('Сумма: %.2f', [summa]));
    rashet.Lines.Add(Format('Годовая ставка: %.2f%%', [stavka_proc * 100]));
    rashet.Lines.Add(Format('Количество лет: %d', [years]));
    rashet.Lines.Add(Format('Итоговая сумма: %.2f', [result_compound]));
  end
  else
    rashet.Lines.Add('Ошибка: выберите тип процентов (простые/сложные)!');
end;

end.


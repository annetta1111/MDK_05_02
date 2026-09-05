unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton; // Кнопка «Рассчитать»
    Edit1: TEdit;     // Сумма
    Edit2: TEdit;     // Годовая ставка (%)
    Edit3: TEdit;     // Количество лет
    ComboBox1: TComboBox; // Выбор типа процентов («Простые» / «Сложные»)
    Memo1: TMemo;     // Вывод результатов
    Label1, Label2, Label3, Label4: TLabel; // Подписи
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
  summa, stavka, result: real;
  years, i: integer;
  procent_type: string;
begin
  // Считываем входные данные
  summa := StrToFloat(Edit1.Text);
  stavka := StrToFloat(Edit2.Text) / 100; // Переводим в десятичную дробь (например, 5% → 0.05)
  years := StrToInt(Edit3.Text);
  procent_type := ComboBox1.Text;

  Memo1.Clear; // Очищаем мемо перед выводом

  // Расчёт простых процентов: S = P * (1 + r * t)
  if procent_type = 'Простые' then
  begin
    result := summa * (1 + stavka * years);
    Memo1.Lines.Add('Расчёт простых процентов:');
    Memo1.Lines.Add(Format('Исходная сумма: %.2f руб.', [summa]));
    Memo1.Lines.Add(Format('Годовая ставка: %.2f %%', [stavka * 100]));
    Memo1.Lines.Add(Format('Срок: %d лет', [years]));
    Memo1.Lines.Add(Format('Итоговая сумма: %.2f руб.', [result]));
    Memo1.Lines.Add(Format('Доход: %.2f руб.', [result - summa]));
  end

  // Расчёт сложных процентов: S = P * (1 + r)^t
  else if procent_type = 'Сложные' then
  begin
    result := summa;
    for i := 1 to years do
      result := result * (1 + stavka);
    Memo1.Lines.Add('Расчёт сложных процентов:');
    Memo1.Lines.Add(Format('Исходная сумма: %.2f руб.', [summa]));
    Memo1.Lines.Add(Format('Годовая ставка: %.2f %%', [stavka * 100]));
    Memo1.Lines.Add(Format('Срок: %d лет', [years]));
    Memo1.Lines.Add(Format('Итоговая сумма: %.2f руб.', [result]));
    Memo1.Lines.Add(Format('Доход: %.2f руб.', [result - summa]));
  end
  else
    Memo1.Lines.Add('Ошибка: выберите тип процентов!');
end;

end.


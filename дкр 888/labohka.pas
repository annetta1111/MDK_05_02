unit labohka;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Math;

type

  { Tlololo }

  Tlololo = class(TForm)
    rashetiki: TMemo;
    result: TEdit;
    res: TLabel;
    ras: TButton;
    clojn: TCheckBox;
    prost: TCheckBox;
    tip: TLabel;
    prprocent: TLabel;
    clprocent: TLabel;
    let: TEdit;
    stavka: TEdit;
    sum: TEdit;
    suuum: TLabel;
    procent: TLabel;
    kollet: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure rasClick(Sender: TObject);
    procedure prprocentClick(Sender: TObject);
    procedure prostClick(Sender: TObject);
    procedure clojnClick(Sender: TObject);
  private

  public

  end;

var
  lololo: Tlololo;

implementation

{$R *.lfm}

{ Tlololo }

procedure Tlololo.FormCreate(Sender: TObject);
begin
  // Очищаем все поля ввода
  sum.Text := '';
  stavka.Text := '';
  let.Text := '';
  result.Text := '';
  rashetiki.Text := '';

  // тип процентов по умолчанию - простые проценты
  prost.Checked := True;   // простых процентов
  clojn.Checked := False;  // сложных процентов
end;
procedure Tlololo.prostClick(Sender: TObject);
begin
  if prost.Checked then  //если простые проценты
  begin
    clojn.Checked := False;
  end
  else
  begin
    if not clojn.Checked then
      clojn.Checked := True;
  end;
end;
procedure Tlololo.clojnClick(Sender: TObject);
begin
  if clojn.Checked then  //сложные проценты
  begin
    prost.Checked := False;
  end
  else
  begin
    if not prost.Checked then
      prost.Checked := True;
  end;
end;

procedure Tlololo.rasClick(Sender: TObject);
var P, r, A: Double;
years,i: Integer;
begin
  result.Text := '';
  rashetiki.Clear;
  if (sum.Text = '') or (stavka.Text = '') or (let.Text = '') then
  begin
    // Если какое-то поле пустое - выводим предупреждение
    rashetiki.Lines.Add('Ошибка: Заполните все поля (сумму, ставку и количество лет)!');
    Exit;  // Выходим из процедуры, не выполняя расчет
  end;
  try
    P := StrToFloat(sum.Text);
    r := StrToFloat(stavka.Text);
    years := StrToInt(let.Text);
  except
    rashetiki.Lines.Add('Ошибка: Введите корректные числа (цифры, а не буквы)!');
    Exit;
  end;
  if (P <= 0) then
  begin
    rashetiki.Lines.Add('Ошибка: Сумма должна быть больше нуля!');
    Exit;
  end;

  if (r < 0) then
  begin
    rashetiki.Lines.Add('Ошибка: Ставка не может быть отрицательной!');
    Exit;
  end;

  if (years <= 0) then
  begin
    rashetiki.Lines.Add('Ошибка: Количество лет должно быть больше нуля!');
    Exit;
  end;

  rashetiki.Lines.Add('Исходные данные:');
  rashetiki.Lines.Add('Начальная сумма (P) = ' + FloatToStr(P) + ' руб.');
  rashetiki.Lines.Add('Годовая ставка = ' + FloatToStr(r) + '%');
  rashetiki.Lines.Add('Срок (лет) = ' + IntToStr(years));
  rashetiki.Lines.Add('');

  // Проверяем, какой тип процентов выбран
  if prost.Checked then
  begin
    rashetiki.Lines.Add('Расчет ПРОСТЫХ процентов:');
    rashetiki.Lines.Add('Формула: A = P * (1 + r/100 * n)');
    rashetiki.Lines.Add('Подставляем значения:');
    rashetiki.Lines.Add('  A = ' + FloatToStr(P) + ' * (1 + ' + FloatToStr(r) + '/100 * ' + IntToStr(years) + ')');
    A := P * (1 + (r / 100) * years); //итоговая сумма

    rashetiki.Lines.Add('Вычисляем r/100 = ' + FloatToStr(r) + '/100 = ' + FloatToStr(r/100));
    rashetiki.Lines.Add('Вычисляем (r/100) * n = ' + FloatToStr(r/100) + ' * ' + IntToStr(years) + ' = ' + FloatToStr((r/100) * years));
    rashetiki.Lines.Add('Вычисляем 1 + (r/100) * n = 1 + ' + FloatToStr((r/100) * years) + ' = ' + FloatToStr(1 + (r/100) * years));
    rashetiki.Lines.Add('Умножаем P на результат = ' + FloatToStr(P) + ' * ' + FloatToStr(1 + (r/100) * years) + ' = ' + FloatToStr(A));
    rashetiki.Lines.Add('Начисленные проценты за весь период: ' + FloatToStr(A - P) + ' руб.');
  end
  else if clojn.Checked then
  begin
    rashetiki.Lines.Add('Расчет СЛОЖНЫХ процентов (с ежегодной капитализацией):');
    rashetiki.Lines.Add('Формула: A = P * (1 + r/100)^n');
    rashetiki.Lines.Add('Подставляем значения:');
    rashetiki.Lines.Add('A = ' + FloatToStr(P) + ' * (1 + ' + FloatToStr(r) + '/100)^' + IntToStr(years));

    A := P * Power(1 + (r / 100), years);
    rashetiki.Lines.Add('Вычисляем (1 + r/100) = 1 + ' + FloatToStr(r) + '/100 = 1 + ' + FloatToStr(r/100) + ' = ' + FloatToStr(1 + r/100));
    rashetiki.Lines.Add('Возводим в степень ' + IntToStr(years) + ': (' + FloatToStr(1 + r/100) + ')^' + IntToStr(years) + ' = ' + FloatToStr(Power(1 + r/100, years)));
    rashetiki.Lines.Add('Умножаем на начальную сумму: ' + FloatToStr(P) + ' * ' + FloatToStr(Power(1 + r/100, years)) + ' = ' + FloatToStr(A));

    rashetiki.Lines.Add('');
    rashetiki.Lines.Add('  Расчет по годам (чтобы было понятнее):');
    for i := 1 to years do
    begin
      rashetiki.Lines.Add('    Год ' + IntToStr(i) + ': ' + FloatToStr(P * Power(1 + r/100, i)) + ' руб.');
    end;

    rashetiki.Lines.Add('  Начисленные проценты за весь период: ' + FloatToStr(A - P) + ' руб.');
  end
  else
  begin
    rashetiki.Lines.Add('Ошибка: Выберите тип процентов (простые или сложные)!');
    Exit;
  end;

  result.Text := FloatToStr(A) + ' руб.';
  rashetiki.Lines.Add('');
  rashetiki.Lines.Add('ИТОГОВАЯ СУММА: ' + FloatToStr(A) + ' руб.');
end;

procedure Tlololo.prprocentClick(Sender: TObject);
begin
  prost.Checked := True;   // Включаем простые проценты
  clojn.Checked := False;  // Выключаем сложные проценты
end;

end.

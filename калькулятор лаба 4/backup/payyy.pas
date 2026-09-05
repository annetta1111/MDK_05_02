unit payyy;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons, Math;

type
  TForm1 = class(TForm)
    plus: TButton;
    seven: TButton;
    five: TButton;
    dwa: TButton;
    fo: TButton;
    odin: TButton;
    minys: TButton;
    ymnoj: TButton;
    del: TButton;
    night: TButton;
    six: TButton;
    tri: TButton;
    zapyt: TButton;
    eght: TButton;
    ce: TButton;
    cbros: TButton;
    kop: TButton;
    stepen: TButton;
    lala: TButton;
    rovno: TButton;
    strelka: TButton;
    edtResult: TEdit;
    nol: TButton;
    procedure ceClick(Sender: TObject);
    procedure cbrosClick(Sender: TObject);
    procedure kopClick(Sender: TObject);
    procedure strelkaClick(Sender: TObject);
    procedure stepenClick(Sender: TObject);
    procedure lalaClick(Sender: TObject);
    procedure rovnoClick(Sender: TObject);
    procedure plusClick(Sender: TObject);
    procedure minysClick(Sender: TObject);
    procedure ymnojClick(Sender: TObject);
    procedure delClick(Sender: TObject);
    procedure zapytClick(Sender: TObject);
    procedure nolClick(Sender: TObject);
    procedure odinClick(Sender: TObject);
    procedure dwaClick(Sender: TObject);
    procedure triClick(Sender: TObject);
    procedure foClick(Sender: TObject);
    procedure fiveClick(Sender: TObject);
    procedure sixClick(Sender: TObject);
    procedure sevenClick(Sender: TObject);
    procedure eghtClick(Sender: TObject);
    procedure nightClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    FCurrentInput: string;
    FFirstNumber: Double;
    FOperator: string;
    FIsNewInput: Boolean;
    procedure UpdateDisplay;
    procedure ProcessOperator(op: string);
    procedure CalculateResult;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}
// начальные значения
procedure TForm1.FormCreate(Sender: TObject);
begin
  FCurrentInput := '0';
  FFirstNumber := 0;
  FOperator := '';
  FIsNewInput := True;
  UpdateDisplay;
end;

// обновление поля вывода
procedure TForm1.UpdateDisplay;
begin
  edtResult.Text := FCurrentInput;
end;
// Добавляет цифру 0
procedure TForm1.nolClick(Sender: TObject);
begin
  if FIsNewInput then
  begin
    FCurrentInput := '0';
    FIsNewInput := False;
  end
  else
    FCurrentInput := FCurrentInput + '0';
  UpdateDisplay;
end;

//цифра 1
procedure TForm1.odinClick(Sender: TObject);
begin
  if FIsNewInput then
  begin
    FCurrentInput := '1';
    FIsNewInput := False;
  end
  else
    FCurrentInput := FCurrentInput + '1';
  UpdateDisplay;
end;

// цифра 2
procedure TForm1.dwaClick(Sender: TObject);
begin
  if FIsNewInput then
  begin
    FCurrentInput := '2';
    FIsNewInput := False;
  end
  else
    FCurrentInput := FCurrentInput + '2';
  UpdateDisplay;
end;

//цифра 3
procedure TForm1.triClick(Sender: TObject);
begin
  if FIsNewInput then
  begin
    FCurrentInput := '3';
    FIsNewInput := False;
  end
  else
    FCurrentInput := FCurrentInput + '3';
  UpdateDisplay;
end;

//цифра 4
procedure TForm1.foClick(Sender: TObject);
begin
  if FIsNewInput then
  begin
    FCurrentInput := '4';
    FIsNewInput := False;
  end
  else
    FCurrentInput := FCurrentInput + '4';
  UpdateDisplay;
end;

//цифра 5
procedure TForm1.fiveClick(Sender: TObject);
begin
  if FIsNewInput then
  begin
    FCurrentInput := '5';
    FIsNewInput := False;
  end
  else
    FCurrentInput := FCurrentInput + '5';
  UpdateDisplay;
end;

//цифра 6
procedure TForm1.sixClick(Sender: TObject);
begin
  if FIsNewInput then
  begin
    FCurrentInput := '6';
    FIsNewInput := False;
  end
  else
    FCurrentInput := FCurrentInput + '6';
  UpdateDisplay;
end;

//цифра 7
procedure TForm1.sevenClick(Sender: TObject);
begin
  if FIsNewInput then
  begin
    FCurrentInput := '7';
    FIsNewInput := False;
  end
  else
    FCurrentInput := FCurrentInput + '7';
  UpdateDisplay;
end;

//цифра 8
procedure TForm1.eghtClick(Sender: TObject);
begin
  if FIsNewInput then
  begin
    FCurrentInput := '8';
    FIsNewInput := False;
  end
  else
    FCurrentInput := FCurrentInput + '8';
  UpdateDisplay;
end;

//цифра 9
procedure TForm1.nightClick(Sender: TObject);
begin
  if FIsNewInput then
  begin
    FCurrentInput := '9';
    FIsNewInput := False;
  end
  else
    FCurrentInput := FCurrentInput + '9';
  UpdateDisplay;
end;
// Добавляет запятую, проверяя чтобы не было двух точек
procedure TForm1.zapytClick(Sender: TObject);
begin
  if FIsNewInput then
  begin
    FCurrentInput := '0,';
    FIsNewInput := False;
  end
  else if Pos(DecimalSeparator, FCurrentInput) = 0 then
    FCurrentInput := FCurrentInput + DecimalSeparator;
  UpdateDisplay;
end;

//оператор +
procedure TForm1.plusClick(Sender: TObject);
begin
  ProcessOperator('+');
end;

//оператор -
procedure TForm1.minysClick(Sender: TObject);
begin
  ProcessOperator('-');
end;

//оператор *
procedure TForm1.ymnojClick(Sender: TObject);
begin
  ProcessOperator('*');
end;

//оператор /
procedure TForm1.delClick(Sender: TObject);
begin
  ProcessOperator('/');
end;

//процедура для операторов
procedure TForm1.ProcessOperator(op: string);
begin
  try
    if not FIsNewInput then
    begin
      if FOperator = '' then
        FFirstNumber := StrToFloat(FCurrentInput)
      else
        CalculateResult;
    end;
    FOperator := op;
    FIsNewInput := True;
  except
    on E: Exception do
    begin
      edtResult.Text := 'Ошибка';
      FCurrentInput := '0';
      FFirstNumber := 0;
      FOperator := '';
      FIsNewInput := True;
    end;
  end;
end;
//арифметическое вычисление
procedure TForm1.CalculateResult;
var
  secondNumber: Double;
  resultValue: Double;
begin
  try
    secondNumber := StrToFloat(FCurrentInput);
    case FOperator of
      '+': resultValue := FFirstNumber + secondNumber;
      '-': resultValue := FFirstNumber - secondNumber;
      '*': resultValue := FFirstNumber * secondNumber;
      '/':
        if secondNumber = 0 then
          raise EZeroDivide.Create('Деление на ноль')
        else
          resultValue := FFirstNumber / secondNumber;
      else
        resultValue := secondNumber;
    end;
    FCurrentInput := FloatToStr(resultValue);
    UpdateDisplay;
    FFirstNumber := resultValue;
  except
    on E: EZeroDivide do
      edtResult.Text := 'Ошибка: деление на 0';
    on E: Exception do
      edtResult.Text := 'Ошибка вычисления';
  end;
end;

// Кнопка равно
procedure TForm1.rovnoClick(Sender: TObject);
begin
  if FOperator <> '' then
    CalculateResult;
  FOperator := '';
  FIsNewInput := True;
end;

// CE - очистка текущего ввода
procedure TForm1.ceClick(Sender: TObject);
begin
  FCurrentInput := '0';
  FIsNewInput := True;
  UpdateDisplay;
end;

// C - полная очистка
procedure TForm1.cbrosClick(Sender: TObject);
begin
  FCurrentInput := '0';
  FFirstNumber := 0;
  FOperator := '';
  FIsNewInput := True;
  UpdateDisplay;
end;

// Kop - удаление последнего символа
procedure TForm1.kopClick(Sender: TObject);
begin
  if FIsNewInput then
    Exit;

  if Length(FCurrentInput) > 1 then
  begin
    Delete(FCurrentInput, Length(FCurrentInput), 1);
    UpdateDisplay;
  end
  else
  begin
    FCurrentInput := '0';
    FIsNewInput := True;
    UpdateDisplay;
  end;
end;

// Стрелка - тоже удаление
procedure TForm1.strelkaClick(Sender: TObject);
begin
  if FIsNewInput then
    Exit;

  if Length(FCurrentInput) > 1 then
  begin
    Delete(FCurrentInput, Length(FCurrentInput), 1);
    UpdateDisplay;
  end
  else
  begin
    FCurrentInput := '0';
    FIsNewInput := True;
    UpdateDisplay;
  end;
end;

//возведение в квадрат
procedure TForm1.stepenClick(Sender: TObject);
var num: Double;
begin
  try
    num := StrToFloat(FCurrentInput);
    num := num * num;
    FCurrentInput := FloatToStr(num);
    FFirstNumber := num;
    FIsNewInput := True;
    UpdateDisplay;
  except
    on E: Exception do
      edtResult.Text := 'Ошибка';
  end;
end;

//обратное число
procedure TForm1.lalaClick(Sender: TObject);
var num: Double;
begin
  try
    num := StrToFloat(FCurrentInput);
    if num = 0 then
      raise EZeroDivide.Create('Деление на ноль');
    num := 1 / num;
    FCurrentInput := FloatToStr(num);
    FFirstNumber := num;
    FIsNewInput := True;
    UpdateDisplay;
  except
    on E: EZeroDivide do
      edtResult.Text := 'Ошибка: деление на 0';
    on E: Exception do
      edtResult.Text := 'Ошибка';
  end;
end;

end.

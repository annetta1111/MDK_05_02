unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Calendar, EditBtn,
  StdCtrls;

type

  { Tlol }

  Tlol = class(TForm)
    lal: TButton;
    lol: TButton;
    lel: TButton;
    Calendar1: TCalendar;
    DateEdit1: TDateEdit;
    procedure Calendar1Change(Sender: TObject);
    procedure DateEdit1Change(Sender: TObject);
    procedure lalClick(Sender: TObject);
    procedure lelClick(Sender: TObject);
    procedure lolClick(Sender: TObject);
  private
  public
  end;

var
  lol: Tlol;

implementation

{$R *.lfm}

{ Tlol }

procedure Tlol.Calendar1Change(Sender: TObject);
begin
  DateEdit1.Date := Calendar1.DateTime;
end;

procedure Tlol.DateEdit1Change(Sender: TObject);
begin
  Calendar1.DateTime := DateEdit1.Date;
end;

procedure Tlol.lalClick(Sender: TObject);
var dt:TDateTime;
  y,m,d:Word;
begin
    ShowMessage('Сегодня: ' + DateToStr(Date));
    ShowMessage('Время: ' + TimeToStr(Time));
    DecodeDate(Now, y, m, d);
    ShowMessage('Год: ' + IntToStr(y) + ', Месяц: ' + IntToStr(m) + ', День: ' + IntToStr(d));
     if IsLeapYear(y) then
    ShowMessage(IntToStr(y) + ' - високосный год')
  else
    ShowMessage(IntToStr(y) + ' - не високосный год');

end;

procedure Tlol.lolClick(Sender: TObject);
begin
  ShowMessage('Дата из календаря: ' + Calendar1.Date);
end;


procedure Tlol.lelClick(Sender: TObject);
begin
  ShowMessage(DateToStr(DateEdit1.Date));
end;

end.

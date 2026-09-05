unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Calendar, EditBtn,
  StdCtrls;

type

  { Tlol }

  Tlol = class(TForm)
    lol: TButton;
    lel: TButton;
    Calendar1: TCalendar;
    DateEdit1: TDateEdit;
    procedure Calendar1Change(Sender: TObject);
    procedure DateEdit1Change(Sender: TObject);
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

// Синхронизация: календарь → DateEdit
procedure Tlol.Calendar1Change(Sender: TObject);
begin
  DateEdit1.Date := Calendar1.DateTime;
end;

// Синхронизация: DateEdit → календарь
procedure Tlol.DateEdit1Change(Sender: TObject);
begin
  Calendar1.DateTime := DateEdit1.Date;
end;

// Первая кнопка (lol) - показать даты
procedure Tlol.lolClick(Sender: TObject);
begin
  ShowMessage('Дата из календаря: ' + Calendar1.Date);
end;

// Вторая кнопка (lel) - форматированный вывод
procedure Tlol.lelClick(Sender: TObject);
begin
  ShowMessage(DateToStr(DateEdit1.Date));
end;

end.

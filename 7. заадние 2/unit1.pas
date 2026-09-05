unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnCreate: TButton;
    btnRead: TButton;
    lbNumbers: TListBox;
    Label1: TLabel;
    procedure btnCreateClick(Sender: TObject);
    procedure btnReadClick(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

// Кнопка "Сформировать файл" - записывает 10 случайных чисел
procedure TForm1.btnCreateClick(Sender: TObject);
var
  f: file of integer;
  i: integer;
begin
  try
    AssignFile(f, 'numbers.dat');
    Rewrite(f);

    for i := 1 to 10 do
      Write(f, Random(1000));

    ShowMessage('10 случайных чисел записаны в файл numbers.dat');

  finally
    CloseFile(f);
  end;
end;

// Кнопка "Читать из файла" - читает числа и показывает в списке
procedure TForm1.btnReadClick(Sender: TObject);
var
  f: file of integer;
  num: integer;
begin
  if not FileExists('numbers.dat') then
  begin
    ShowMessage('Файл numbers.dat не существует! Сначала нажмите "Сформировать файл".');
    Exit;
  end;

  lbNumbers.Clear;

  try
    AssignFile(f, 'numbers.dat');
    Reset(f);

    while not Eof(f) do
    begin
      Read(f, num);
      lbNumbers.Items.Add(IntToStr(num));
    end;

    ShowMessage('Загружено чисел: ' + IntToStr(lbNumbers.Items.Count));

  finally
    CloseFile(f);
  end;
end;

end.

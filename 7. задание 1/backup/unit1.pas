unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnAdd: TButton;
    btnRead: TButton;
    edtInput: TEdit;
    Label1: TLabel;
    mmOutput: TMemo;
    procedure btnAddClick(Sender: TObject);
    procedure btnReadClick(Sender: TObject);

  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

// Кнопка "Добавить в файл" - сохраняет строку в файл
procedure TForm1.btnAddClick(Sender: TObject);
var
  tf: TextFile;
  s: string;
begin
  // Если пользователь ничего не ввел - выходим
  if edtInput.Text = '' then
  begin
    ShowMessage('Введите текст!');
    Exit;
  end;

  s := edtInput.Text;

  // Работа с файлом
  try
    AssignFile(tf, 'mytext.txt');

    // Если файла нет - создаём, если есть - открываем для дозаписи
    if not FileExists('mytext.txt') then
      Rewrite(tf)      // Создать новый файл
    else
      Append(tf);      // Открыть для добавления в конец

    // Записываем строку в файл
    WriteLn(tf, s);

    // Очищаем поле ввода
    edtInput.Text := '';

    ShowMessage('Строка добавлена в файл!');

  finally
    CloseFile(tf);
  end;
end;

// Кнопка "Считать из файла" - читает все строки из файла
procedure TForm1.btnReadClick(Sender: TObject);
var
  tf: TextFile;
  s: string;
begin
  // Если файла нет - выходим
  if not FileExists('mytext.txt') then
  begin
    ShowMessage('Файл mytext.txt не существует! Сначала добавьте строки.');
    Exit;
  end;

  // Очищаем Memo перед выводом
  mmOutput.Clear;

  // Работа с файлом
  try
    AssignFile(tf, 'mytext.txt');
    Reset(tf);  // Открываем для чтения

    // Читаем все строки из файла
    while not Eof(tf) do
    begin
      ReadLn(tf, s);
      mmOutput.Lines.Add(s);
    end;

  finally
    CloseFile(tf);
  end;

  if mmOutput.Lines.Count = 0 then
    ShowMessage('Файл пуст!')
  else
    ShowMessage('Загружено строк: ' + IntToStr(mmOutput.Lines.Count));
end;

end.


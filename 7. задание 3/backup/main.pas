unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, FileUtil, EditBtn;

type
  TfMain = class(TForm)
    btnCopy: TButton;
    deDest: TDirectoryEdit;
    feSource: TFileNameEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnCopyClick(Sender: TObject);
  private
  public
  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

// Копирование файла
procedure TfMain.btnCopyClick(Sender: TObject);
var
  fIn, fOut: File;
  Buffer: array[1..2048] of byte;
  NumRead, NumWritten: Word;
  DestFileName: string;
begin
  // Проверка 1: выбран ли исходный файл?
  if feSource.FileName = '' then
  begin
    ShowMessage('Выберите файл для копирования!');
    feSource.SetFocus;
    Exit;
  end;

  // Проверка 2: существует ли исходный файл?
  if not FileExists(feSource.FileName) then
  begin
    ShowMessage('Исходный файл не существует!');
    feSource.SetFocus;
    Exit;
  end;

  // Проверка 3: выбрана ли папка назначения?
  if deDest.Directory = '' then
  begin
    ShowMessage('Выберите папку для копии!');
    deDest.SetFocus;
    Exit;
  end;

  // Формируем полный путь к файлу-копии
  DestFileName := deDest.Directory + '\' + ExtractFileName(feSource.FileName);

  // Проверка 4: не совпадают ли исходный и конечный файлы?
  if feSource.FileName = DestFileName then
  begin
    ShowMessage('Нельзя копировать файл сам в себя!');
    Exit;
  end;

  // Копирование файла
  try
    // Связываем файлы с переменными
    AssignFile(fIn, feSource.FileName);
    AssignFile(fOut, DestFileName);

    // Открываем файлы
    Reset(fIn, 1);
    Rewrite(fOut, 1);

    // Меняем курсор на "песочные часы"
    Screen.Cursor := crHourGlass;

    // Копируем блоками по 2048 байт
    repeat
      BlockRead(fIn, Buffer, SizeOf(Buffer), NumRead);
      BlockWrite(fOut, Buffer, NumRead, NumWritten);
    until (NumRead = 0);

    // Сообщение об успехе
    ShowMessage('Файл успешно скопирован!' + #13#10 +
                'Источник: ' + feSource.FileName + #13#10 +
                'Копия: ' + DestFileName);

  finally
    CloseFile(fIn);
    CloseFile(fOut);
    Screen.Cursor := crDefault;
  end;
end;

end.

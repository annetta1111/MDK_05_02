unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, ExtCtrls, Edit;

type
  // Структура для хранения контакта
  Contacts = record
    Name: string[100];
    Telephon: string[20];
    Note: string[20];
  end;

  { TfMain }

  TfMain = class(TForm)
    Panel1: TPanel;
    bAdd: TButton;
    bEdit: TButton;
    bDel: TButton;
    bSort: TButton;
    SG: TStringGrid;
    procedure bAddClick(Sender: TObject);
    procedure bDelClick(Sender: TObject);
    procedure bEditClick(Sender: TObject);
    procedure bSortClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  fMain: TfMain;
  adres: string;  // Путь к программе

implementation

{$R *.lfm}

// Создание формы - загрузка данных из файла
procedure TfMain.FormCreate(Sender: TObject);
var
  MyCont: Contacts;
  f: file of Contacts;
begin
  // Получаем путь к программе
  adres := ExtractFilePath(ParamStr(0));

  // Настройка заголовков таблицы
  SG.Cells[0, 0] := 'Имя';
  SG.Cells[1, 0] := 'Телефон';
  SG.Cells[2, 0] := 'Примечание';

  // Настройка ширины колонок
  SG.ColWidths[0] := 300;
  SG.ColWidths[1] := 150;
  SG.ColWidths[2] := 120;

  // Если файл с данными не существует - выходим
  if not FileExists(adres + 'telephones.dat') then Exit;

  // Загрузка данных из файла
  try
    AssignFile(f, adres + 'telephones.dat');
    Reset(f);

    while not Eof(f) do
    begin
      Read(f, MyCont);
      SG.RowCount := SG.RowCount + 1;
      SG.Cells[0, SG.RowCount-1] := MyCont.Name;
      SG.Cells[1, SG.RowCount-1] := MyCont.Telephon;
      SG.Cells[2, SG.RowCount-1] := MyCont.Note;
    end;
  finally
    CloseFile(f);
  end;
end;

// Закрытие формы - сохранение данных в файл
procedure TfMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  MyCont: Contacts;
  f: file of Contacts;
  i: integer;
begin
  // Если нет данных - выходим
  if SG.RowCount <= 1 then Exit;

  // Сохранение данных в файл
  try
    AssignFile(f, adres + 'telephones.dat');
    Rewrite(f);

    for i := 1 to SG.RowCount - 1 do
    begin
      MyCont.Name := SG.Cells[0, i];
      MyCont.Telephon := SG.Cells[1, i];
      MyCont.Note := SG.Cells[2, i];
      Write(f, MyCont);
    end;
  finally
    CloseFile(f);
  end;
end;

// Добавление нового контакта
procedure TfMain.bAddClick(Sender: TObject);
begin
  // Очищаем поля в форме редактора
  fEdit.eName.Text := '';
  fEdit.eTelephone.Text := '';
  fEdit.CBNote.ItemIndex := 0;
  fEdit.ModalResult := mrNone;

  // Показываем форму редактора
  fEdit.ShowModal;

  // Проверяем, что пользователь ввёл данные и нажал "Сохранить"
  if (fEdit.eName.Text = '') or (fEdit.eTelephone.Text = '') then Exit;
  if fEdit.ModalResult <> mrOk then Exit;

  // Добавляем новую строку в таблицу
  SG.RowCount := SG.RowCount + 1;
  SG.Cells[0, SG.RowCount-1] := fEdit.eName.Text;
  SG.Cells[1, SG.RowCount-1] := fEdit.eTelephone.Text;
  SG.Cells[2, SG.RowCount-1] := fEdit.CBNote.Text;

  ShowMessage('Контакт добавлен!');
end;

// Редактирование выбранного контакта
procedure TfMain.bEditClick(Sender: TObject);
begin
  // Проверяем, выбран ли контакт
  if SG.RowCount <= 1 then
  begin
    ShowMessage('Нет контактов для редактирования');
    Exit;
  end;
  if SG.Row < 1 then
  begin
    ShowMessage('Выберите контакт для редактирования');
    Exit;
  end;

  // Загружаем данные выбранного контакта в форму редактора
  fEdit.eName.Text := SG.Cells[0, SG.Row];
  fEdit.eTelephone.Text := SG.Cells[1, SG.Row];
  fEdit.CBNote.Text := SG.Cells[2, SG.Row];
  fEdit.ModalResult := mrNone;

  // Показываем форму редактора
  fEdit.ShowModal;

  // Если пользователь нажал "Сохранить" - обновляем данные
  if fEdit.ModalResult = mrOk then
  begin
    SG.Cells[0, SG.Row] := fEdit.eName.Text;
    SG.Cells[1, SG.Row] := fEdit.eTelephone.Text;
    SG.Cells[2, SG.Row] := fEdit.CBNote.Text;
    ShowMessage('Контакт изменён!');
  end;
end;

// Удаление выбранного контакта
procedure TfMain.bDelClick(Sender: TObject);
begin
  // Проверяем, выбран ли контакт
  if SG.RowCount <= 1 then
  begin
    ShowMessage('Нет контактов для удаления');
    Exit;
  end;
  if SG.Row < 1 then
  begin
    ShowMessage('Выберите контакт для удаления');
    Exit;
  end;

  // Подтверждение удаления
  if MessageDlg('Удаление контакта',
    'Вы действительно хотите удалить контакт "' + SG.Cells[0, SG.Row] + '"?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    SG.DeleteRow(SG.Row);
    ShowMessage('Контакт удалён');
  end;
end;

// Сортировка контактов по имени
procedure TfMain.bSortClick(Sender: TObject);
begin
  if SG.RowCount <= 1 then
  begin
    ShowMessage('Нет контактов для сортировки');
    Exit;
  end;

  SG.SortColRow(True, 0);
  ShowMessage('Список отсортирован по имени');
end;

end.

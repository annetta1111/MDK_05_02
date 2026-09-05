unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { Tzam }

  Tzam = class(TForm)
    btnAdd: TButton;
    btnDel: TButton;
    btnSave: TButton;
    cmbCat: TComboBox;
    Edit1: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lstTitle: TListBox;
    mmText: TMemo;
    procedure btnAddClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure cmbCatChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lstTitleClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  zam: Tzam;

implementation

{$R *.lfm}

var
  hd:TstringList;   //заголовки записей
  tx:TstringList;   //тексты записей
  cFile:string;     //имя файла текущей категории

//загружает категорию из файла
procedure loadcategory;
var lst:TStringList;
  i:integer;
  begin
    hd.Clear;
    tx.Clear;
    if FileExists(cFile) then      //если файл существует
    begin
     lst:=TStringList.Create;    //сохдаеть временный списко
    lst.LoadFromFile(cFile);    //загрузить весь файл
    i:=0;
    while i<lst.Count do
begin
  hd.Add(lst[i]);    //заголовок
  if i+1<lst.Count then
  tx.Add(lst[i+1])  //текст записи (след строка)
  else
    tx.Add('');    //если текста нет - пустая строка
  i:=i+2;
    end;
    lst.Free;
    end;
    // обновляем визуальный список
  zam.lstTitle.Clear;
  zam.lstTitle.Items.Assign(hd);
  end;

//сохраняет текущие данные в файл
procedure savecategory;
var lst:TStringList;
  i:integer;
  begin
    lst:=TStringList.Create;
    for i:=0 to hd.Count-1 do
     begin
       lst.Add(hd[i]); //заголовок
       lst.Add(tx[i]); //текст записи
     end;
    lst.SaveToFile(cFile);
    lst.Free;
  end;

{ Tzam }

procedure Tzam.FormCreate(Sender: TObject);
begin
  //создаем списки
  hd:=TStringList.Create;
  tx:=TStringList.Create;
  //заполняем выпадающий список категорий
  cmbCat.Items.Add('Личное');
  cmbCat.Items.Add('Работа');
  cmbCat.Items.Add('Учёба');
  cmbCat.Items.Add('Идеи');
  cmbCat.ItemIndex := 0;
  cmbCat.Style:=csDropDownList;  //запрет ручного ввода
  cFile := 'personal.txt';
  loadcategory;
  //внешний вид
  mmText.ScrollBars := ssVertical;     //вертикальная прокрутка
  mmText.WordWrap := True;       //перенос слов
  Edit1.Text := '';
end;

//смена категории
procedure Tzam.cmbCatChange(Sender: TObject);
begin
  case cmbCat.ItemIndex of
    0: cFile := 'personal.txt';
    1: cFile := 'work.txt';
    2: cFile := 'study.txt';
    3: cFile := 'ideas.txt';
  end;
  loadcategory; //перезагружаем заголовки и тексты из файла
  lstTitle.ItemIndex:=-1;
  mmText.Text := ''; //очищаем поле текста (пока ничего не выбрано)
end;

//выбор записи из списка
procedure Tzam.lstTitleClick(Sender: TObject);
var
  idx: integer;
begin
  idx:=lstTitle.ItemIndex;
  if (idx>=0) and (idx<tx.Count) then
  mmText.Text:=tx[idx]  //показываем сохраненный текст
  else
    mmText.Text:='';
end;

//добавить новую запись
procedure Tzam.btnAddClick(Sender: TObject);
var
  newT: string;
begin
  newT := Trim(Edit1.Text);
  if newT = '' then
    ShowMessage('Введите заголовок')
  else
   begin
   hd.Add(newT);
   tx.Add('');   //пустой текст для новой записи
   lstTitle.Items.Assign(hd);
   savecategory;
   lstTitle.ItemIndex := hd.Count-1;
   mmText.Text := '';  //новый текст пуст
   Edit1.Text := '';
   end;
end;

//удалить выбранную запись
procedure Tzam.btnDelClick(Sender: TObject);
var
  idx: integer;
begin
  idx := lstTitle.ItemIndex;
  if idx < 0 then
    ShowMessage('Выберите запись для удаления')
  else
   begin
   hd.Delete(idx);
   tx.Delete(idx);
   lstTitle.Items.Assign(hd);
   savecategory;
   if hd.Count > 0 then
   begin
     lstTitle.ItemIndex := 0;
   mmText.Text:=tx[0];
   end
   else
      mmText.Text := '';
   end;
end;

//сохранить изменения в текущей записи
procedure Tzam.btnSaveClick(Sender: TObject);
var
  idx: integer;
begin
  idx := lstTitle.ItemIndex;
  if idx < 0 then
    ShowMessage('Выберите запись для сохранения')
  else
   begin
    tx[idx] := mmText.Text;  //сохраняем текст из Memo в список
    savecategory;
    ShowMessage('Сохранено');
   end;
end;

end.


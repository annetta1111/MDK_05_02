unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
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

procedure TForm1.btnAddClick(Sender: TObject);
var
  tf: TextFile;
begin
  if edtInput.Text = '' then
  begin
    ShowMessage('Введите текст!');
    Exit;
  end;

  AssignFile(tf, 'mytext.txt');

  try
    if not FileExists('mytext.txt') then
      Rewrite(tf)
    else
      Append(tf);

    WriteLn(tf, edtInput.Text);
    edtInput.Text := '';
    ShowMessage('Добавлено!');
  finally
    CloseFile(tf);
  end;
end;

procedure TForm1.btnReadClick(Sender: TObject);
var
  tf: TextFile;
  s: string;
begin
  if not FileExists('mytext.txt') then
  begin
    ShowMessage('Файл не существует!');
    Exit;
  end;

  mmOutput.Clear;
  AssignFile(tf, 'mytext.txt');

  try
    Reset(tf);
    while not Eof(tf) do
    begin
      ReadLn(tf, s);
      mmOutput.Lines.Add(s);
    end;
  finally
    CloseFile(tf);
  end;

  ShowMessage('Загружено строк: ' + IntToStr(mmOutput.Lines.Count));
end;

end.

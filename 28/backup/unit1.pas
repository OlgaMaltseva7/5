unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Sort: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SortClick(Sender: TObject);
  private
   {private declarations}
  public
   {public declarations}
  end;
  type
    //базовый класс
    TPerson = class
    fName: string; // имя
    constructor Create (name:string);
    function info:string; virtual;
    end;
  //класс Студент

  { TStud }

  TStud = class(TPerson)
  fGr:integer; //номер группы
  constructor Create (name:string;gr:integer);
  function info:string;
  override; end;
//класс Преподаватель
TProf = class (TPerson)
fdep:string; //название кафедры
constructor Create (name:string;dep:string);
function info:string;
override;
end;
const
  SZL = 10; //размер списка
  I=25;
var
  Form1: TForm1;
  List:array[1..SZL] of TPerson; //список
  n:integer = 0; //кол-во людей в списке
implementation

{$R *.lfm}
 constructor TPerson.Create(name:string);
 begin
   fName:=name;
   end;
 constructor TStud.Create (name:string;gr:integer);
 begin
   inherited create (name); //вызвать конструктор базового класса
   fGr:=gr;
   end;

 function TStud.info: string;
begin
  result:=fname + 'гp.' + IntToStr(fGr);;
end;

 constructor TProf.create (name:string; dep:string);
 begin
   inherited create (name); //вызвать конструктор базового класса
   fDep:=dep;
   end;
 function TPerson.info:string;
 begin
     result:=fName;
   end;
 function TProf.info: string;
 begin
   result:=fname + 'каф.' + fDep;
   end;
 //щелчок на кнопке Добавить
{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
 if n < SZL then
 begin
   //добавить объект в список
   n:=n+1;
   if RadioButton1.Checked
   then //создадим объект TStud
   List [n]:=TStud.Create(Edit1.Text,StrToInt(Edit2.Text))
   else //создать объект TProf
   List [n]:=TProf.Create (Edit1.Text,Edit2.Text); //очистить поля ввода
   Edit1.Text:=' ';
   Edit2.Text:=' ';
   Edit1.SetFocus; //курсор в поле Фамилия
   end
 else ShowMessage('Список заполнен!');
end;
//щелчок на кнопке Список
procedure TForm1.Button2Click(Sender: TObject);
var
  i:integer; //индекс
  st:string; //список
begin
  for i:=1 to SZL do
  if List[i] <> NIL then st:=st + list[i].info + #13;
  ShowMessage('Список'+#13+st);
end;

procedure TForm1.SortClick(Sender: TObject);
var
i, n, j: Integer;
st,f1,f2:string;
tmp:TPerson;
begin
for i:=1 to SZL do
if List[i] <> nil then st:=st+List[i].info+#13;
ShowMessage('Список'+#13 + st);
for i:=0 to n do
for j:=0 to n-1 do
begin
  f1:=list[j].fName;
  f2:=list[j+1].fName;
  if ord(f1[1])>ord(f2[1]) then
  begin
    tmp:=list[j];
    list[j]:=list[j+1];
    list[j+1]:=tmp;
  end;
end;

end.

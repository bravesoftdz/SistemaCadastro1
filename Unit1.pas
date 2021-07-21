unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSAcc, FireDAC.Phys.MSAccDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    txt_ID: TEdit;
    txt_Nome: TEdit;
    txt_Email: TEdit;
    txt_Telefone: TEdit;
    txt_OBS: TMemo;
    FDConnection1: TFDConnection;
    FDContatos: TFDTable;
    DataSource1: TDataSource;
    BtnNovo: TButton;
    BtnSalvar: TButton;
    Status: TLabel;
    BtnAvancar: TButton;
    BtnVoltar: TButton;
    BtnDelete: TButton;
    BtnEdit: TButton;
    BtnCancelar: TButton;
    txt_Procura: TEdit;
    SpeedButton1: TSpeedButton;
    DBGrid1: TDBGrid;
    SpeedButton2: TSpeedButton;
    img_Foto: TImage;
    SpeedButton3: TSpeedButton;
    OpenDialog1: TOpenDialog;
    procedure SairClick(Sender: TObject);
    procedure carrega;
    procedure bloqueia;
    procedure limpar;
    procedure FormCreate(Sender: TObject);
    procedure BtnAvancarClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure FDContatosBeforePost(DataSet: TDataSet);
    procedure BtnDeleteClick(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  estado: integer;

implementation

{$R *.dfm}

uses Unit2;

procedure TForm1.bloqueia;
begin
  txt_NOME.Enabled        := not txt_NOME.Enabled;
  txt_EMAIL.Enabled       := not txt_EMAIL.Enabled;
  txt_Telefone.Enabled    := not txt_Telefone.Enabled;
  txt_OBS.Enabled         := not txt_OBS.Enabled;
end;

procedure TForm1.limpar;
begin
  txt_ID.Text           := '';
  txt_NOME.Text         := '';
  txt_EMAIL.Text        := '';
  txt_Telefone.Text     := '';
  txt_OBS.Text          := '';
  txt_NOME.SetFocus;
end;

procedure TForm1.BtnNovoClick(Sender: TObject);
begin
  fdcontatos.Insert;
  bloqueia;
  limpar;
  estado := 1;        //1 = post.

end;

procedure TForm1.BtnSalvarClick(Sender: TObject);
begin
  fdcontatos.Post;
  bloqueia;
  showmessage ('Dados Gravados');
end;

procedure TForm1.BtnAvancarClick(Sender: TObject);
begin
  fdcontatos.Next;
  carrega;
end;

procedure TForm1.BtnCancelarClick(Sender: TObject);
begin
  limpar;
if estado = 1 then
    fdcontatos.Prior;
  carrega;
  bloqueia;
  estado := 0;
end;

procedure TForm1.BtnDeleteClick(Sender: TObject);
begin
  fdcontatos.Delete;
  carrega;
end;

procedure TForm1.BtnEditClick(Sender: TObject);
begin
  bloqueia;
  fdcontatos.Edit;

end;

procedure TForm1.BtnVoltarClick(Sender: TObject);
begin
  fdcontatos.Prior;
  carrega;
end;

procedure TForm1.carrega;
begin
  txt_ID.Text         := fdcontatos.FieldByName('id').Value;
  txt_NOME.Text       := fdcontatos.FieldByName('nome').Value;
  txt_EMAIL.Text      := fdcontatos.FieldByName('email').Value;
  txt_Telefone.Text   := fdcontatos.FieldByName('telefone').Value;

if fdcontatos.FieldByName('Observações').Value = NULL then
    txt_OBS.Text := ''
else
  txt_OBS.Text        := fdcontatos.FieldByName('observações').Value;

  if fdcontatos.fieldByName('foto').Value <> null then
    begin
      if fileexists(fdcontatos.fieldByName('foto').Value) then
        img_FOTO.Picture.LoadFromFile(fdcontatos.fieldByName('foto').Value)
    end
else
        img_FOTO.picture := nil;

end;






procedure TForm1.DBGrid1DblClick(Sender: TObject);
begin
  carrega;
end;

procedure TForm1.FDContatosBeforePost(DataSet: TDataSet);
begin
  fdcontatos.FieldByName('NOME').Value          := txt_NOME.Text;
  fdcontatos.FieldByName('EMAIL').Value         := txt_EMAIL.Text;
  fdcontatos.FieldByName('Telefone').Value      := txt_Telefone.Text;
  fdcontatos.FieldByName('Observações').Value   := txt_NOME.Text;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  fdconnection1.Params.Database := GetCurrentDir + '\assets\contatos.mdb' ;
  fdconnection1.Connected       := true;
  fdcontatos.TableName          := 'contatos';
  fdcontatos.Active             := true;

  if fdconnection1.Connected = true then
  begin
    status.Caption              := 'Conectado';
    carrega;
  end;
end;

procedure TForm1.SairClick(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
 if not fdcontatos.FindKey([txt_Procura.Text]) then
       carrega
 else
  ShowMessage('Não encontrado')
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  Form1.hide;
  Form2.Show;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  opendialog1.Execute();
  //ShowMessage (opendialog1.FileName);
  img_FOTO.Picture.LoadFromFile(opendialog1.FileName);
  fdcontatos.Edit;
  fdcontatos.FieldByName('foto').Value := opendialog1.FileName;
  fdcontatos.Post;


end;

end.

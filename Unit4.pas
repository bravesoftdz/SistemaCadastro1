unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSAcc, FireDAC.Phys.MSAccDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TForm4 = class(TForm)
    txt_Login: TEdit;
    txt_Senha: TEdit;
    brt_Acesso: TButton;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    Image1: TImage;
    procedure brt_AcessoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

uses Unit2;

procedure TForm4.brt_AcessoClick(Sender: TObject);
begin

fdquery1.SQL.Text := 'select * from contatos where usuario = :parm_login and senha = :parm_senha';
fdquery1.ParamByName('parm_login').AsString :=  txt_Login.text ;
fdquery1.ParamByName('parm_senha').AsString :=  txt_Senha.text ;
fdquery1.Open;
if fdquery1.RowsAffected > 0 then
   Form2.Show
else
  showmessage ('Entre com usuario e senha correto');
end;

end.

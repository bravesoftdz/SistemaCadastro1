unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus,
  Vcl.Imaging.jpeg;

type
  TForm2 = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    MenuPrincipal1: TMenuItem;
    MenuPrincipal2: TMenuItem;
    Sada1: TMenuItem;
    procedure Sada1Click(Sender: TObject);
    procedure MenuPrincipal2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses Unit1;

procedure TForm2.MenuPrincipal2Click(Sender: TObject);
begin
  Form1.Show;
end;

procedure TForm2.Sada1Click(Sender: TObject);
begin
  Form2.close;
end;

end.

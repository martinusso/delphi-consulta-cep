unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    ButtonConsultarCEP: TButton;
    Memo1: TMemo;
    CEP: TEdit;
    procedure ButtonConsultarCEPClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  COnsultaCEP;

{$R *.dfm}

procedure TForm1.ButtonConsultarCEPClick(Sender: TObject);
var
  ws: AtendeCliente;
  Endereco: TEndereco;
begin
  Memo1.Clear;

  ws := GetAtendeCliente();
  try
    Endereco := ws.consultaCEP(CEP.Text);

    Memo1.Lines.Add(Endereco.bairro);
    Memo1.Lines.Add(Endereco.cep);
    Memo1.Lines.Add(Endereco.cidade);
    Memo1.Lines.Add(Endereco.complemento);
    Memo1.Lines.Add(Endereco.complemento2);
    Memo1.Lines.Add(Endereco.uf);
  except
    on E: SigepClienteException do
      Memo1.Lines.Add(E.Value);
  end;
end;

end.

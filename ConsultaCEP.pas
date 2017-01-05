unit ConsultaCEP;

interface

uses
  Soap.InvokeRegistry,
  Soap.SOAPHTTPClient,
  Soap.XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_NLBL = $0004;
  IS_UNQL = $0008;

type
  TEndereco = class;

  TUnidadePostagem = class(TRemotable)
  private
    FdiretoriaRegional: string;
    FdiretoriaRegional_Specified: Boolean;
    Fendereco: TEndereco;
    Fendereco_Specified: Boolean;
    Fid: string;
    Fid_Specified: Boolean;
    Fnome: string;
    Fnome_Specified: Boolean;
    Fstatus: string;
    Fstatus_Specified: Boolean;
    Ftipo: string;
    Ftipo_Specified: Boolean;
    procedure SetdiretoriaRegional(Index: Integer; const Astring: string);
    function  diretoriaRegional_Specified(Index: Integer): Boolean;
    procedure Setendereco(Index: Integer; const AenderecoERP: TEndereco);
    function  endereco_Specified(Index: Integer): Boolean;
    procedure Setid(Index: Integer; const Astring: string);
    function  id_Specified(Index: Integer): Boolean;
    procedure Setnome(Index: Integer; const Astring: string);
    function  nome_Specified(Index: Integer): Boolean;
    procedure Setstatus(Index: Integer; const Astring: string);
    function  status_Specified(Index: Integer): Boolean;
    procedure Settipo(Index: Integer; const Astring: string);
    function  tipo_Specified(Index: Integer): Boolean;
  public
    destructor Destroy; override;
  published
    property diretoriaRegional: string       Index (IS_OPTN or IS_UNQL) read FdiretoriaRegional write SetdiretoriaRegional stored diretoriaRegional_Specified;
    property endereco:          TEndereco  Index (IS_OPTN or IS_UNQL) read Fendereco write Setendereco stored endereco_Specified;
    property id:                string       Index (IS_OPTN or IS_UNQL) read Fid write Setid stored id_Specified;
    property nome:              string       Index (IS_OPTN or IS_UNQL) read Fnome write Setnome stored nome_Specified;
    property status:            string       Index (IS_OPTN or IS_UNQL) read Fstatus write Setstatus stored status_Specified;
    property tipo:              string       Index (IS_OPTN or IS_UNQL) read Ftipo write Settipo stored tipo_Specified;
  end;
  Array_Of_unidadePostagem = array of TUnidadePostagem;

  TEndereco = class(TRemotable)
  private
    Fbairro: string;
    Fbairro_Specified: Boolean;
    Fcep: string;
    Fcep_Specified: Boolean;
    Fcidade: string;
    Fcidade_Specified: Boolean;
    Fcomplemento: string;
    Fcomplemento_Specified: Boolean;
    Fcomplemento2: string;
    Fcomplemento2_Specified: Boolean;
    Flogradouro: string;
    Flogradouro_Specified: Boolean;
    Fid: Int64;
    Fuf: string;
    Fuf_Specified: Boolean;
    FunidadesPostagem: Array_Of_unidadePostagem;
    FunidadesPostagem_Specified: Boolean;
    procedure Setbairro(Index: Integer; const Astring: string);
    function  bairro_Specified(Index: Integer): Boolean;
    procedure Setcep(Index: Integer; const Astring: string);
    function  cep_Specified(Index: Integer): Boolean;
    procedure Setcidade(Index: Integer; const Astring: string);
    function  cidade_Specified(Index: Integer): Boolean;
    procedure Setcomplemento(Index: Integer; const Astring: string);
    function  complemento_Specified(Index: Integer): Boolean;
    procedure Setcomplemento2(Index: Integer; const Astring: string);
    function  complemento2_Specified(Index: Integer): Boolean;
    procedure Setlogradouro(Index: Integer; const Astring: string);
    function  logradouro_Specified(Index: Integer): Boolean;
    procedure Setuf(Index: Integer; const Astring: string);
    function  uf_Specified(Index: Integer): Boolean;
    procedure SetunidadesPostagem(Index: Integer; const AArray_Of_unidadePostagemERP: Array_Of_unidadePostagem);
    function  unidadesPostagem_Specified(Index: Integer): Boolean;
  public
    destructor Destroy; override;
  published
    property bairro:           string                       Index (IS_OPTN or IS_UNQL) read Fbairro write Setbairro stored bairro_Specified;
    property cep:              string                       Index (IS_OPTN or IS_UNQL) read Fcep write Setcep stored cep_Specified;
    property cidade:           string                       Index (IS_OPTN or IS_UNQL) read Fcidade write Setcidade stored cidade_Specified;
    property complemento:      string                       Index (IS_OPTN or IS_UNQL) read Fcomplemento write Setcomplemento stored complemento_Specified;
    property complemento2:     string                       Index (IS_OPTN or IS_UNQL) read Fcomplemento2 write Setcomplemento2 stored complemento2_Specified;
    property logradouro:       string                       Index (IS_OPTN or IS_UNQL) read Flogradouro write Setlogradouro stored logradouro_Specified;
    property id:               Int64                        Index (IS_UNQL) read Fid write Fid;
    property uf:               string                       Index (IS_OPTN or IS_UNQL) read Fuf write Setuf stored uf_Specified;
    property unidadesPostagem: Array_Of_unidadePostagem  Index (IS_OPTN or IS_UNBD or IS_NLBL or IS_UNQL) read FunidadesPostagem write SetunidadesPostagem stored unidadesPostagem_Specified;
  end;

  SigepClienteException = class(ERemotableException)
  private
    FValue: string;
  published
    property Value: string  read FValue write FValue;
  end;

  // ************************************************************************ //
  // Namespace : http://cliente.bean.master.sigep.bsb.correios.com.br/
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : AtendeClienteServiceSoapBinding
  // service   : AtendeClienteService
  // port      : AtendeClientePort
  // URL       : https://apps.correios.com.br/SigepMasterJPA/AtendeClienteService/AtendeCliente
  // ************************************************************************ //
  AtendeCliente = interface(IInvokable)
  ['{06395354-FEDE-FDC9-368D-51C37A49D0E0}']
    function consultaCEP(const cep: string): TEndereco; stdcall;
  end;

function GetAtendeCliente: AtendeCliente;

implementation

uses
  SysUtils;

function GetAtendeCliente: AtendeCliente;
const
  defWSDL = 'https://apps.correios.com.br/SigepMasterJPA/AtendeClienteService/AtendeCliente?wsdl';
  defSvc  = 'AtendeClienteService';
  defPrt  = 'AtendeClientePort';
var
  RIO: THTTPRIO;
begin
  RIO := THTTPRIO.Create(nil);
  try
    Result := (RIO as AtendeCliente);
    RIO.WSDLLocation := defWSDL;
    RIO.Service := defSvc;
    RIO.Port := defPrt;
  finally
    if (Result = nil) then
      RIO.Free;
  end;
end;

destructor TUnidadePostagem.Destroy;
begin
  FreeAndNil(Fendereco);
  inherited Destroy;
end;

procedure TUnidadePostagem.SetdiretoriaRegional(Index: Integer; const Astring: string);
begin
  FdiretoriaRegional := Astring;
  FdiretoriaRegional_Specified := True;
end;

function TUnidadePostagem.diretoriaRegional_Specified(Index: Integer): Boolean;
begin
  Result := FdiretoriaRegional_Specified;
end;

procedure TUnidadePostagem.Setendereco(Index: Integer; const AenderecoERP: TEndereco);
begin
  Fendereco := AenderecoERP;
  Fendereco_Specified := True;
end;

function TUnidadePostagem.endereco_Specified(Index: Integer): Boolean;
begin
  Result := Fendereco_Specified;
end;

procedure TUnidadePostagem.Setid(Index: Integer; const Astring: string);
begin
  Fid := Astring;
  Fid_Specified := True;
end;

function TUnidadePostagem.id_Specified(Index: Integer): Boolean;
begin
  Result := Fid_Specified;
end;

procedure TUnidadePostagem.Setnome(Index: Integer; const Astring: string);
begin
  Fnome := Astring;
  Fnome_Specified := True;
end;

function TUnidadePostagem.nome_Specified(Index: Integer): Boolean;
begin
  Result := Fnome_Specified;
end;

procedure TUnidadePostagem.Setstatus(Index: Integer; const Astring: string);
begin
  Fstatus := Astring;
  Fstatus_Specified := True;
end;

function TUnidadePostagem.status_Specified(Index: Integer): Boolean;
begin
  Result := Fstatus_Specified;
end;

procedure TUnidadePostagem.Settipo(Index: Integer; const Astring: string);
begin
  Ftipo := Astring;
  Ftipo_Specified := True;
end;

function TUnidadePostagem.tipo_Specified(Index: Integer): Boolean;
begin
  Result := Ftipo_Specified;
end;

destructor TEndereco.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FunidadesPostagem)-1 do
    FreeAndNil(FunidadesPostagem[I]);
  System.SetLength(FunidadesPostagem, 0);
  inherited Destroy;
end;

procedure TEndereco.Setbairro(Index: Integer; const Astring: string);
begin
  Fbairro := Astring;
  Fbairro_Specified := True;
end;

function TEndereco.bairro_Specified(Index: Integer): Boolean;
begin
  Result := Fbairro_Specified;
end;

procedure TEndereco.Setcep(Index: Integer; const Astring: string);
begin
  Fcep := Astring;
  Fcep_Specified := True;
end;

function TEndereco.cep_Specified(Index: Integer): Boolean;
begin
  Result := Fcep_Specified;
end;

procedure TEndereco.Setcidade(Index: Integer; const Astring: string);
begin
  Fcidade := Astring;
  Fcidade_Specified := True;
end;

function TEndereco.cidade_Specified(Index: Integer): Boolean;
begin
  Result := Fcidade_Specified;
end;

procedure TEndereco.Setcomplemento(Index: Integer; const Astring: string);
begin
  Fcomplemento := Astring;
  Fcomplemento_Specified := True;
end;

function TEndereco.complemento_Specified(Index: Integer): Boolean;
begin
  Result := Fcomplemento_Specified;
end;

procedure TEndereco.Setcomplemento2(Index: Integer; const Astring: string);
begin
  Fcomplemento2 := Astring;
  Fcomplemento2_Specified := True;
end;

function TEndereco.complemento2_Specified(Index: Integer): Boolean;
begin
  Result := Fcomplemento2_Specified;
end;

procedure TEndereco.Setlogradouro(Index: Integer; const Astring: string);
begin
  Flogradouro := Astring;
  Flogradouro_Specified := True;
end;

function TEndereco.logradouro_Specified(Index: Integer): Boolean;
begin
  Result := Flogradouro_Specified;
end;

procedure TEndereco.Setuf(Index: Integer; const Astring: string);
begin
  Fuf := Astring;
  Fuf_Specified := True;
end;

function TEndereco.uf_Specified(Index: Integer): Boolean;
begin
  Result := Fuf_Specified;
end;

procedure TEndereco.SetunidadesPostagem(Index: Integer; const AArray_Of_unidadePostagemERP: Array_Of_unidadePostagem);
begin
  FunidadesPostagem := AArray_Of_unidadePostagemERP;
  FunidadesPostagem_Specified := True;
end;

function TEndereco.unidadesPostagem_Specified(Index: Integer): Boolean;
begin
  Result := FunidadesPostagem_Specified;
end;

initialization
  { AtendeCliente }
  InvRegistry.RegisterInterface(TypeInfo(AtendeCliente), 'http://cliente.bean.master.sigep.bsb.correios.com.br/', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(AtendeCliente), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(AtendeCliente), ioDocument);
  { AtendeCliente.consultaCEP }
  InvRegistry.RegisterMethodInfo(TypeInfo(AtendeCliente), 'consultaCEP', '',
                                 '[ReturnName="return"]', IS_OPTN or IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(AtendeCliente), 'consultaCEP', 'cep', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(AtendeCliente), 'consultaCEP', 'return', '',
                                '', IS_UNQL);

  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_unidadePostagem), 'http://cliente.bean.master.sigep.bsb.correios.com.br/', 'Array_Of_unidadePostagemERP');
  RemClassRegistry.RegisterXSClass(TUnidadePostagem, 'http://cliente.bean.master.sigep.bsb.correios.com.br/', 'unidadePostagemERP');
  RemClassRegistry.RegisterXSClass(TEndereco, 'http://cliente.bean.master.sigep.bsb.correios.com.br/', 'enderecoERP');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TEndereco), 'logradouro', '[ExtName="end"]');

  { Exceptions }
  RemClassRegistry.RegisterXSClass(SigepClienteException, 'http://cliente.bean.master.sigep.bsb.correios.com.br/', 'SigepClienteException');
  RemClassRegistry.RegisterSerializeOptions(SigepClienteException, [xoSimpleTypeWrapper]);
end.

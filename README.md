# delphi-consulta-cep
Consulta de CEP, e Caixa Postal, usando webservice dos Correios com Delphi

## Using

```Delphi
uses ConsultaCEP;
```

```Delphi
var
  WS: AtendeCliente;
  Endereco: TEndereco;
begin
  WS := GetAtendeCliente();
  try
    Endereco := WS.consultaCEP(CEP); // <<< Informe o CEP aqui

    Bairro      := Endereco.bairro;
    CEP         := Endereco.cep;
    Cidade      := Endereco.cidade;
    Complemento := Endereco.complemento;
    UF          := Endereco.uf;
    Logradouro  := Endereco.logradouro;
  except
    on E: SigepClienteException do
      DoAnything(E.Value);
  end;
end;
```

### Out

`> consultaCEP('90035170');`

```Delphi
Endereco.bairro      = Floresta
Endereco.cep         = 90.035-170
Endereco.cidade      = Porto Alegre
Endereco.complemento =
Endereco.uf          = RS
Endereco.logradouro  = Rua Gonçalo de Carvalho
```

### Delphi 2010

```Delphi
RIO.OnBeforeExecute := HTTPRIOBeforeExecute;
```

```Delphi
procedure HTTPRIOBeforeExecute(const MethodName: string; SOAPRequest: TStream);
const
  FirstTag = '<cep>';
  LastTag = '</cep>';
  FmtRequest = '<?xml version="1.0" encoding="UTF-8"?>' +
               '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://cliente.bean.master.sigep.bsb.correios.com.br/">' +
               '<SOAP-ENV:Body>' +
               '<ns1:consultaCEP>' +
               '<cep>%s</cep>' +
               '</ns1:consultaCEP>' +
               '</SOAP-ENV:Body>' +
               '</SOAP-ENV:Envelope>';
var
  CEP: string;
  PosInicioCEP, TamanhoCEP: Integer;
  TmpSteam: TStringStream;
  TmpStrings: TStrings;
begin
  TmpStream := TStringStream.Create('');
  try
    TmpSteam.CopyFrom(SOAPRequest, 0);
    PosInicioCEP := Pos(FirstTag, TmpSteam.DataString) + 5;
    TamanhoCEP := Pos(LastTag, TmpSteam.DataString) - _PosInicioCEP;
    CEP := Copy(TmpSteam.DataString, PosInicioCEP, TamanhoCEP);
  finally
    TmpSteam.Free;
  end;

  TmpStrings := TStringList.Create;
  try
    TmpStrings.Text := Format(FmtRequest, [CEP]);
    SOAPRequest.Size := 0;
    SOAPRequest.Position := 0;
    TmpStrings.SaveToStream(SOAPRequest);
  finally
    TmpStrings.Free;
  end;
end;
```

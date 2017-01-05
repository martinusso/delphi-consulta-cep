# delphi-consulta-cep
Consulta de CEP usando webservice dos Correios com Delphi

# Using

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

## Out

`> consultaCEP('90035170');`

```Delphi
Endereco.bairro      = Floresta
Endereco.cep         = 90.035-170
Endereco.cidade      = Porto Alegre
Endereco.complemento =
Endereco.uf          = RS
Endereco.logradouro  = Rua Gonçalo de Carvalho
```

# probabilidade_api

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]
[![Powered by Dart Frog](https://img.shields.io/endpoint?url=https://tinyurl.com/dartfrog-badge)](https://dartfrog.vgv.dev)

An example application built with dart_frog

---

## Documentação da API

Esta API possui um único endpoint para análise de probabilidades.

### Endpoint: `POST /analisar`

Este endpoint recebe um JSON para realizar uma análise de dados.

#### Corpo da Requisição (Request Body)

O corpo da requisição deve ser um JSON com a seguinte estrutura:
```
{
"numeros": [10,20,36], -> Lista de inteiros
"limiteNumeros": 100, -> inteiro
"minimoPorcento": 50 -> inteiro
}
```

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
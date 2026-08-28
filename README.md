# Meus Gastos

Aplicativo de controle financeiro desenvolvido em Flutter.

O objetivo do projeto é permitir que o usuário informe seu saldo inicial e
registre entradas e saídas para acompanhar suas movimentações financeiras.

<p align="center">
  <img src="assets/Tela01.png" width="180"/>
  <img src="assets/Tela02.png" width="180"/>
  <img src="assets/Tela03.png" width="180"/>
  <img src="assets/Tela04.png" width="180"/>
  <img src="assets/Tela05.png" width="180"/>
  <img src="assets/Tela06.png" width="180"/>
</p>

## Funcionalidades

- Cadastro do saldo inicial;
- Cadastro de entradas e saídas;
- Cálculo do saldo atual;
- Exibição do total de entradas e saídas;
- Histórico de movimentações ordenado por data;
- Categorias representadas por ícones;
- Tela com a explicação das categorias;
- Tela de detalhes de cada movimentação.

## Categorias

As categorias disponíveis nesta primeira versão são:

- Alimentação;
- Contas;
- Lazer;
- Mercado;
- Outros;
- Salário;
- Transporte.

## Tecnologias utilizadas

- Flutter;
- Dart;
- Material Design.

## Como executar o projeto

Primeiro, clone o repositório:

```bash
git clone https://github.com/julianosgarbossa/MyExpenses.git
```

Entre na pasta do aplicativo:

```bash
cd MyExpenses/my_expenses
```

Baixe as dependências:

```bash
flutter pub get
```

Execute o aplicativo:

```bash
flutter run
```

## Organização do projeto

Os principais arquivos estão dentro da pasta `lib`:

```text
lib/
├── main.dart
├── models/
└── screens/
```

- `main.dart`: inicia o aplicativo;
- `models`: contém o modelo das movimentações;
- `screens`: contém as telas e o formulário de nova movimentação.

## Observação

Nesta primeira versão, os dados ficam armazenados apenas enquanto o aplicativo
está aberto. Ao fechar o app, o saldo e as movimentações são apagados.

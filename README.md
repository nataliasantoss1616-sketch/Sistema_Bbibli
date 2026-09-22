# Sistema Biblioteca

Sistema de gestão de biblioteca desenvolvido em Dart para controle de usuários, títulos, exemplares, empréstimos, reservas e multas.

## Objetivo

O projeto simula um sistema básico de biblioteca acadêmica, permitindo:

- cadastro de usuários;
- cadastro de títulos e obras;
- inclusão de exemplares;
- registro de empréstimos;
- controle de devoluções;
- cálculo de multas por atraso;
- registro de reservas;
- baixa de exemplares;
- consulta de cadastros e movimentações.

## Funcionalidades

### 1. Cadastro
- Usuários
- Títulos
- Exemplares

### 2. Movimentação
- Empréstimo de livros/exemplares
- Devolução com situação:
  - normal
  - danificado
  - perdido
- Reserva de obra sem exemplares disponíveis
- Baixa de exemplar
- Pagamento de multa

### 3. Consultas
- Listagem de usuários
- Listagem de títulos
- Listagem de exemplares
- Listagem de empréstimos
- Listagem de reservas

## Estrutura do projeto

```text
Sistema_Bibli/
├── main.dart
├── Enums/
│   ├── StatusExemplar.dart
│   ├── TipoObra.dart
│   ├── TipoUsuario.dart
├── Models/
│   ├── Emprestimo.dart
│   ├── Exemplar.dart
│   ├── Reserva.dart
│   ├── Titulo.dart
│   └── Usuario.dart
├── Services/
│   ├── emprestimo_services.dart
│   ├── exemplar_services.dart
│   ├── reserva_services.dart
│   ├── titulo_services.dart
│   └── usuario_services.dart
└── README.md
```

## Regras de negócio

- Usuários podem ter tipos como:
  - aluno
  - professor
  - comunidade externa
- Títulos podem ser:
  - comum
  - consulta
- Cada tipo de usuário possui limite de empréstimos e prazo de devolução.
- Usuários com pendência ficam bloqueados para novos empréstimos.
- Empréstimos com atraso geram multa.
- Exemplares danificados ou perdidos também geram cobrança.
- Não é permitido adicionar dois IDs iguais para os mesmos cadastros.

## Menu principal

Ao executar o programa, será exibido um menu com as opções:

1. Cadastrar usuário
2. Cadastrar título
3. Adicionar exemplar
4. Realizar empréstimo
5. Realizar devolução
6. Fazer reserva
7. Dar baixa
8. Pagar multa
9. Listar usuários
10. Listar títulos
11. Listar exemplares
12. Listar empréstimos
13. Listar reservas
0. Sair

## Como executar

Na pasta raiz do projeto, execute:

```bash
dart run main.dart
```

Se o ambiente estiver configurado corretamente, o menu interativo da biblioteca será exibido no terminal.

## Observações

- O sistema foi implementado como aplicação de console.
- A interação é feita por entrada de texto e números no terminal.
- Os dados ficam em memória durante a execução do programa, ou seja, não há persistência em banco de dados.

## Tecnologias

- Dart
- Console application

## Desenvolvedor

Projeto acadêmico para disciplina de programação para dispositivos móveis.

import 'dart:io';

import 'Enums/TipoObra.dart';
import 'Enums/TipoUsuario.dart';
import 'Services/emprestimo_services.dart';
import 'Services/exemplar_services.dart';
import 'Services/reserva_services.dart';
import 'Services/titulo_services.dart';
import 'Services/usuario_services.dart';

final usuarios = UsuarioService();
final titulos = TituloService();
final exemplares = ExemplarService();
final emprestimos = EmprestimoService(
  usuarios: usuarios,
  titulos: titulos,
  exemplares: exemplares,
);
final reservas = ReservaService(
  usuarios: usuarios,
  titulos: titulos,
  exemplares: exemplares,
);

void main() {
  String opcao = '';

  while (opcao != '0') {
    mostrarMenu();
    opcao = lerTexto('Escolha uma opção: ');

    try {
      switch (opcao) {
        case '1': cadastrarUsuario();
        case '2': cadastrarTitulo();
        case '3': adicionarExemplar();
        case '4': realizarEmprestimo();
        case '5': realizarDevolucao();
        case '6': fazerReserva();
        case '7': darBaixa();
        case '8': pagarMulta();
        case '9': listar(usuarios.usuarios, 'USUÁRIOS');
        case '10': listar(titulos.titulos, 'TÍTULOS');
        case '11': listar(exemplares.exemplares, 'EXEMPLARES');
        case '12': listar(emprestimos.emprestimos, 'EMPRÉSTIMOS');
        case '13': listar(reservas.reservas, 'RESERVAS');
        case '0': print('Programa encerrado.');
        default: print('Opção inválida.');
      }
    } catch (erro) {
      print('Erro: $erro');
    }

    if (opcao != '0') pausar();
  }
}

class MenuGrupo {
  final String titulo;
  final List<Map<String, String>> itens;

  const MenuGrupo(this.titulo, this.itens);
}

void mostrarMenu() {
  final grupos = [
    const MenuGrupo('CADASTRO', [
      {'numero': '1', 'descricao': 'Cadastrar usuário'},
      {'numero': '2', 'descricao': 'Cadastrar título'},
      {'numero': '3', 'descricao': 'Adicionar exemplar'},
    ]),
    const MenuGrupo('MOVIMENTAÇÃO', [
      {'numero': '4', 'descricao': 'Realizar empréstimo'},
      {'numero': '5', 'descricao': 'Realizar devolução'},
      {'numero': '6', 'descricao': 'Fazer reserva'},
      {'numero': '7', 'descricao': 'Dar baixa em exemplar'},
      {'numero': '8', 'descricao': 'Pagar multa'},
    ]),
    const MenuGrupo('CONSULTAS', [
      {'numero': '9', 'descricao': 'Listar usuários'},
      {'numero': '10', 'descricao': 'Listar títulos'},
      {'numero': '11', 'descricao': 'Listar exemplares'},
      {'numero': '12', 'descricao': 'Listar empréstimos'},
      {'numero': '13', 'descricao': 'Listar reservas'},
    ]),
    const MenuGrupo('SAIR', [
      {'numero': '0', 'descricao': 'Sair'},
    ]),
  ];

  final linha = '═' * 62;
  print('\n$linha');
  print('        ${corTexto('SISTEMA BIBLIOTECA', '\x1b[1;36m')}');
  print('      ${corTexto('GESTÃO DE ACERVOS E EMPRÉSTIMOS', '\x1b[32m')}');
  print(linha);

  for (final grupo in grupos) {
    print('\n${corTexto(grupo.titulo, '\x1b[33m')}');
    print('${'─' * 62}');

    for (final item in grupo.itens) {
      final numero = item['numero']!;
      final descricao = item['descricao']!;
      final numeroFormatado = corTexto(numero.padLeft(2, ' '), '\x1b[36m');
      print('  $numeroFormatado  - ${descricao.padRight(28)}');
    }
  }

  print('\n$linha');
}

String corTexto(String texto, String codigoCor) {
  return stdout.hasTerminal ? '$codigoCor$texto\x1b[0m' : texto;
}

void cadastrarUsuario() {
  final usuario = usuarios.cadastrar(
    id: lerInt('ID: '),
    nome: lerTexto('Nome: '),
    tipo: escolherTipoUsuario(),
  );
  print('Usuário cadastrado: $usuario');
}

void cadastrarTitulo() {
  final titulo = titulos.cadastrar(
    id: lerInt('ID: '),
    nome: lerTexto('Nome da obra: '),
    autor: lerTexto('Autor: '),
    tipo: escolherTipoObra(),
  );
  print('Título cadastrado: $titulo');
}

void adicionarExemplar() {
  final titulo = titulos.buscar(lerInt('ID do título: '));
  if (titulo == null) throw Exception('Título não encontrado.');

  final exemplar = exemplares.adicionar(
    id: lerInt('ID do exemplar: '),
    titulo: titulo,
  );
  print('Exemplar cadastrado: $exemplar');
}

void realizarEmprestimo() {
  final emprestimo = emprestimos.realizar(
    usuarioId: lerInt('ID do usuário: '),
    tituloId: lerInt('ID do título: '),
  );
  print('Empréstimo realizado: $emprestimo');
}

void realizarDevolucao() {
  final id = lerInt('ID do empréstimo: ');
  print('1 - Devolvido normalmente\n2 - Danificado\n3 - Perdido');
  final situacao = switch (lerInt('Situação: ')) {
    1 => 'normal',
    2 => 'danificado',
    3 => 'perdido',
    _ => throw Exception('Situação inválida.'),
  };

  final multa = emprestimos.devolver(id: id, situacao: situacao);
  print('Devolução registrada. Multa: R\$ ${multa.toStringAsFixed(2)}');
}

void fazerReserva() {
  final reserva = reservas.criar(
    usuarioId: lerInt('ID do usuário: '),
    tituloId: lerInt('ID do título: '),
  );
  print('Reserva realizada: $reserva');
}

void darBaixa() {
  exemplares.darBaixa(lerInt('ID do exemplar: '));
  print('Exemplar baixado com sucesso.');
}

void pagarMulta() {
  final usuario = usuarios.buscar(lerInt('ID do usuário: '));
  if (usuario == null) throw Exception('Usuário não encontrado.');

  usuarios.pagar(usuario, lerDouble('Valor do pagamento: R\$ '));
  print('Pagamento realizado. Pendência: R\$ ${usuario.pendencia.toStringAsFixed(2)}');
}

TipoUsuario escolherTipoUsuario() {
  print('1 - Aluno\n2 - Professor\n3 - Comunidade externa');
  return switch (lerInt('Tipo: ')) {
    1 => TipoUsuario.aluno,
    2 => TipoUsuario.professor,
    3 => TipoUsuario.comunidadeExterna,
    _ => throw Exception('Tipo de usuário inválido.'),
  };
}

TipoObra escolherTipoObra() {
  print('1 - Comum\n2 - Consulta');
  return switch (lerInt('Tipo: ')) {
    1 => TipoObra.comum,
    2 => TipoObra.consulta,
    _ => throw Exception('Tipo de obra inválido.'),
  };
}

void listar(Iterable<Object> itens, String titulo) {
  print('\n--- $titulo ---');
  if (itens.isEmpty) {
    print('Nenhum registro encontrado.');
    return;
  }
  for (final item in itens) print(item);
}

String lerTexto(String mensagem) {
  stdout.write(mensagem);
  final valor = stdin.readLineSync()?.trim() ?? '';
  if (valor.isEmpty) throw Exception('O campo não pode ficar vazio.');
  return valor;
}

int lerInt(String mensagem) {
  final valor = int.tryParse(lerTexto(mensagem));
  if (valor == null) throw Exception('Digite um número inteiro válido.');
  return valor;
}

double lerDouble(String mensagem) {
  final valor = double.tryParse(lerTexto(mensagem).replaceAll(',', '.'));
  if (valor == null) throw Exception('Digite um valor válido.');
  return valor;
}

void pausar() {
  stdout.write('\nPressione ENTER para continuar...');
  stdin.readLineSync();
}

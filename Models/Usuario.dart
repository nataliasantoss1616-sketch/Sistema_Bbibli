import '../Enums/TipoUsuario.dart';

class Usuario {
  final int id;
  final String nome;
  final TipoUsuario tipo;
  bool bloqueado;
  double pendencia;

  Usuario({
    required this.id,
    required this.nome,
    required this.tipo,
    this.bloqueado = false,
    this.pendencia = 0,
  });

  @override
  String toString() => '$id - $nome | ${tipo.nome} | '
      '${bloqueado ? 'Bloqueado' : 'Liberado'} | '
      'Pendência: R\$ ${pendencia.toStringAsFixed(2)}';
}

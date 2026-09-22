import '../Enums/TipoObra.dart';

class Titulo {
  final int id;
  final String nome;
  final String autor;
  final TipoObra tipo;

  Titulo({
    required this.id,
    required this.nome,
    required this.autor,
    required this.tipo,
  });

  @override
  String toString() => '$id - $nome | Autor: $autor | Tipo: ${tipo.nome}';
}

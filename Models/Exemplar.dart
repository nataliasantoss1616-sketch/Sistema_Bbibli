import '../Enums/StatusExemplar.dart';
import 'Titulo.dart';

class Exemplar {
  final int id;
  final Titulo titulo;
  StatusExemplar status;

  Exemplar({
    required this.id,
    required this.titulo,
    this.status = StatusExemplar.disponivel,
  });

  @override
  String toString() => '$id - ${titulo.nome} | Status: ${status.nome}';
}

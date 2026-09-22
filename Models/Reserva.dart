import 'Titulo.dart';
import 'Usuario.dart';

class Reserva {
  final int id;
  final Usuario usuario;
  final Titulo titulo;
  final DateTime data;

  Reserva({
    required this.id,
    required this.usuario,
    required this.titulo,
    required this.data,
  });

  @override
  String toString() => '$id - ${usuario.nome} | ${titulo.nome} | '
      'Data: ${data.day}/${data.month}/${data.year}';
}

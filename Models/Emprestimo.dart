import 'Exemplar.dart';
import 'Usuario.dart';

class Emprestimo {
  final int id;
  final Usuario usuario;
  final Exemplar exemplar;
  final DateTime dataEmprestimo;
  final DateTime dataPrevista;
  DateTime? dataDevolucao;
  double multa;

  Emprestimo({
    required this.id,
    required this.usuario,
    required this.exemplar,
    required this.dataEmprestimo,
    required this.dataPrevista,
    this.multa = 0,
  });

  bool get devolvido => dataDevolucao != null;

  @override
  String toString() => '$id - ${usuario.nome} | ${exemplar.titulo.nome} | '
      'Previsto: ${dataPrevista.day}/${dataPrevista.month}/${dataPrevista.year} | '
      '${devolvido ? 'Devolvido' : 'Em aberto'}';
}

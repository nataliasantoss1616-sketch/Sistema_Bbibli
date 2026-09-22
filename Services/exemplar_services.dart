import '../Enums/StatusExemplar.dart';
import '../Models/Exemplar.dart';
import '../Models/Titulo.dart';

class ExemplarService {
  final List<Exemplar> exemplares = [];

  Exemplar adicionar({required int id, required Titulo titulo}) {
    if (buscar(id) != null) throw Exception('ID de exemplar já cadastrado.');
    final exemplar = Exemplar(id: id, titulo: titulo);
    exemplares.add(exemplar);
    return exemplar;
  }

  Exemplar? buscar(int id) {
    for (final exemplar in exemplares) {
      if (exemplar.id == id) return exemplar;
    }
    return null;
  }

  Exemplar? disponivel(Titulo titulo) {
    for (final exemplar in exemplares) {
      if (exemplar.titulo.id == titulo.id && exemplar.status == StatusExemplar.disponivel) {
        return exemplar;
      }
    }
    return null;
  }

  void darBaixa(int id) {
    final exemplar = buscar(id);
    if (exemplar == null) throw Exception('Exemplar não encontrado.');
    if (exemplar.status == StatusExemplar.emprestado) {
      throw Exception('Exemplar emprestado não pode receber baixa.');
    }
    exemplar.status = StatusExemplar.baixado;
  }
}

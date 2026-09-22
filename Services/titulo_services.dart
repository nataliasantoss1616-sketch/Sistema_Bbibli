import '../Enums/TipoObra.dart';
import '../Models/Titulo.dart';

class TituloService {
  final List<Titulo> titulos = [];

  Titulo cadastrar({required int id, required String nome, required String autor, required TipoObra tipo}) {
    if (buscar(id) != null) throw Exception('ID de título já cadastrado.');
    final titulo = Titulo(id: id, nome: nome, autor: autor, tipo: tipo);
    titulos.add(titulo);
    return titulo;
  }

  Titulo? buscar(int id) {
    for (final titulo in titulos) {
      if (titulo.id == id) return titulo;
    }
    return null;
  }
}

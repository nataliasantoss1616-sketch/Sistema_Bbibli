import '../Models/Reserva.dart';
import 'exemplar_services.dart';
import 'titulo_services.dart';
import 'usuario_services.dart';

class ReservaService {
  final List<Reserva> reservas = [];
  final UsuarioService usuarios;
  final TituloService titulos;
  final ExemplarService exemplares;
  int proximoId = 1;

  ReservaService({required this.usuarios, required this.titulos, required this.exemplares});

  Reserva criar({required int usuarioId, required int tituloId}) {
    final usuario = usuarios.buscar(usuarioId);
    if (usuario == null) throw Exception('Usuário não encontrado.');
    final titulo = titulos.buscar(tituloId);
    if (titulo == null) throw Exception('Título não encontrado.');
    if (exemplares.disponivel(titulo) != null) {
      throw Exception('Existe exemplar disponível para empréstimo.');
    }
    final reserva = Reserva(
      id: proximoId++,
      usuario: usuario,
      titulo: titulo,
      data: DateTime.now(),
    );
    reservas.add(reserva);
    return reserva;
  }
}

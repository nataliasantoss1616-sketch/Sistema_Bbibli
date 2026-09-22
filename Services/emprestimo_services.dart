import '../Enums/StatusExemplar.dart';
import '../Enums/TipoObra.dart';
import '../Enums/TipoUsuario.dart';
import '../Models/Emprestimo.dart';
import '../Models/Usuario.dart';
import 'exemplar_services.dart';
import 'titulo_services.dart';
import 'usuario_services.dart';

class EmprestimoService {
  final List<Emprestimo> emprestimos = [];
  final UsuarioService usuarios;
  final TituloService titulos;
  final ExemplarService exemplares;
  int proximoId = 1;

  EmprestimoService({required this.usuarios, required this.titulos, required this.exemplares});

  int ativos(Usuario usuario) => emprestimos
      .where((emprestimo) => emprestimo.usuario.id == usuario.id && !emprestimo.devolvido)
      .length;

  Emprestimo realizar({required int usuarioId, required int tituloId}) {
    final usuario = usuarios.buscar(usuarioId);
    if (usuario == null) throw Exception('Usuário não encontrado.');
    final titulo = titulos.buscar(tituloId);
    if (titulo == null) throw Exception('Título não encontrado.');
    if (usuario.bloqueado) throw Exception('Usuário bloqueado por pendência.');
    if (ativos(usuario) >= usuario.tipo.limiteEmprestimos) {
      throw Exception('Limite de empréstimos atingido.');
    }
    final exemplar = exemplares.disponivel(titulo);
    if (exemplar == null) throw Exception('Sem exemplar disponível. Faça uma reserva.');

    final hoje = DateTime.now();
    final emprestimo = Emprestimo(
      id: proximoId++,
      usuario: usuario,
      exemplar: exemplar,
      dataEmprestimo: hoje,
      dataPrevista: hoje.add(Duration(days: usuario.tipo.prazoDias)),
    );
    exemplar.status = StatusExemplar.emprestado;
    emprestimos.add(emprestimo);
    return emprestimo;
  }

  double devolver({required int id, required String situacao}) {
    Emprestimo? emprestimo;
    for (final item in emprestimos) {
      if (item.id == id) {
        emprestimo = item;
        break;
      }
    }
    if (emprestimo == null) throw Exception('Empréstimo não encontrado.');
    if (emprestimo.devolvido) throw Exception('Empréstimo já devolvido.');

    final hoje = DateTime.now();
    emprestimo.dataDevolucao = hoje;
    emprestimo.exemplar.status = situacao == 'normal'
        ? StatusExemplar.disponivel
        : StatusExemplar.baixado;

    final atraso = hoje.difference(emprestimo.dataPrevista).inDays;
    if (atraso > 0) {
      emprestimo.multa = atraso * emprestimo.exemplar.titulo.tipo.multaPorDia;
      usuarios.adicionarPendencia(emprestimo.usuario, emprestimo.multa);
    }
    if (situacao == 'danificado') usuarios.adicionarPendencia(emprestimo.usuario, 50);
    if (situacao == 'perdido') usuarios.adicionarPendencia(emprestimo.usuario, 100);
    return emprestimo.multa;
  }
}

import '../Enums/TipoUsuario.dart';
import '../Models/Usuario.dart';

class UsuarioService {
  final List<Usuario> usuarios = [];

  Usuario cadastrar({required int id, required String nome, required TipoUsuario tipo}) {
    if (buscar(id) != null) throw Exception('ID de usuário já cadastrado.');
    final usuario = Usuario(id: id, nome: nome, tipo: tipo);
    usuarios.add(usuario);
    return usuario;
  }

  Usuario? buscar(int id) {
    for (final usuario in usuarios) {
      if (usuario.id == id) return usuario;
    }
    return null;
  }

  void adicionarPendencia(Usuario usuario, double valor) {
    usuario.pendencia += valor;
    usuario.bloqueado = true;
  }

  void pagar(Usuario usuario, double valor) {
    if (usuario.pendencia <= 0) throw Exception('Usuário sem pendência.');
    if (valor <= 0 || valor > usuario.pendencia) {
      throw Exception('Valor de pagamento inválido.');
    }
    usuario.pendencia -= valor;
    if (usuario.pendencia == 0) usuario.bloqueado = false;
  }
}

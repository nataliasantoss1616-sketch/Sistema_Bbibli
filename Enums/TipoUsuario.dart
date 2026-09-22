enum TipoUsuario {
  aluno,
  professor,
  comunidadeExterna,
}

extension TipoUsuarioInfo on TipoUsuario {
  String get nome {
    switch (this) {
      case TipoUsuario.aluno:
        return 'Aluno';
      case TipoUsuario.professor:
        return 'Professor';
      case TipoUsuario.comunidadeExterna:
        return 'Comunidade externa';
    }
  }

  int get limiteEmprestimos {
    switch (this) {
      case TipoUsuario.aluno:
        return 3;
      case TipoUsuario.professor:
        return 5;
      case TipoUsuario.comunidadeExterna:
        return 2;
    }
  }

  int get prazoDias {
    switch (this) {
      case TipoUsuario.aluno:
        return 7;
      case TipoUsuario.professor:
        return 15;
      case TipoUsuario.comunidadeExterna:
        return 5;
    }
  }
}

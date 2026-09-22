enum StatusExemplar {
  disponivel,
  emprestado,
  baixado,
}

extension StatusExemplarInfo on StatusExemplar {
  String get nome {
    switch (this) {
      case StatusExemplar.disponivel:
        return 'Disponível';
      case StatusExemplar.emprestado:
        return 'Emprestado';
      case StatusExemplar.baixado:
        return 'Baixado';
    }
  }
}

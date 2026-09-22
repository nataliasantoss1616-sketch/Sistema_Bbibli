enum TipoObra {
  comum,
  consulta,
}

extension TipoObraInfo on TipoObra {
  String get nome => this == TipoObra.comum ? 'Comum' : 'Consulta';

  double get multaPorDia => this == TipoObra.comum ? 2.0 : 3.0;
}

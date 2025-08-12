
enum ModelProbType {
  sectors,
  decade,
  columns,
  colors,
  evenOdd,
  highLow,
  terminals;

  String label(){
    switch(this){
      case ModelProbType.sectors:
        return 'SETORES';
      case ModelProbType.decade:
        return 'DEZENAS';
      case ModelProbType.columns:
        return 'COLUNAS';
      case ModelProbType.colors:
        return 'CORES';
      case ModelProbType.evenOdd:
        return 'PARES E ÍMPARES';
      case ModelProbType.highLow:
        return 'ALTOS E BAIXOS';
      case ModelProbType.terminals:
        return 'TERMINALS';
    }
  }
}

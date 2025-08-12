extension MaxKeyOnMap<K, V extends num> on Map<K, V> {
  K? keyWithMaxValue() {
    if (isEmpty) return null;

    // Encontrar o maior valor
    var maxValue = values.reduce((a, b) => a > b ? a : b);

    // Verificar quantas vezes o maior valor aparece
    var keysWithMaxValue =
        entries.where((entry) => entry.value == maxValue).map((entry) => entry.key).toList();

    // Se houver mais de uma chave com o maior valor, retorna null
    return keysWithMaxValue.length == 1 ? keysWithMaxValue.first : null;
  }

  V? valueWithMaxValue() {
    if (isEmpty) return null;

    // Encontrar o maior valor
    var maxValue = values.reduce((a, b) => a > b ? a : b);

    // Verificar quantas vezes o maior valor aparece
    var valuesWithMaxValue =
        entries.where((entry) => entry.value == maxValue).map((entry) => entry.value).toList();

    // Se houver mais de uma chave com o maior valor, retorna null
    return valuesWithMaxValue.length == 1 ? valuesWithMaxValue.first : null;
  }

  Map<K, double> toPercentage() {
    if (isEmpty) return {};

    var total = 0;
    values.map((value) => total += (value as int)).toList();
    // Retorna um novo mapa com os valores convertidos para porcentagens
    return map((key, value) {
      var percentage = (value / total) * 100;
      return MapEntry(key, double.parse(percentage.toStringAsFixed(2)));
    });
  }
}

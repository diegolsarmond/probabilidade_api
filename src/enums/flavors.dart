enum FlavorEnvType {
  dev('Desenvolvimento', 'DEV'),
  prod('Produçao', 'PROD');

  final String name;
  final String abbreviation;
  String get nameUpper => name.toUpperCase();
  const FlavorEnvType(this.name, this.abbreviation);
}
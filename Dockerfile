# Estágio de build
FROM dart:stable AS build

WORKDIR /app

# Copiar arquivos de dependência
COPY pubspec.* ./
RUN dart pub get

# Copiar todo o código fonte
COPY . .

# Instalar a CLI do Dart Frog e fazer o build
RUN dart pub global activate dart_frog_cli
RUN dart pub global run dart_frog_cli:dart_frog build

# Compilar o servidor para um executável nativo
RUN dart compile exe build/bin/server.dart -o build/bin/server

# Estágio de produção
FROM debian:stable-slim

# Instalar dependências mínimas se necessário (ca-certificates para HTTPS)
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copiar o executável do estágio de build
COPY --from=build /app/build/bin/server /app/bin/server

# Expor a porta padrão do Dart Frog
EXPOSE 8080

# Comando para iniciar o servidor
CMD ["/app/bin/server"]

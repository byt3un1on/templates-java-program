SHELL := /bin/bash
# templates-java-program

Um template minimalista para projetos Java baseados em Maven (Java 17). Este repositório
serve como ponto de partida para aplicações e bibliotecas Java simples e contém exemplos
de build, testes e cobertura com JaCoCo.

## Status
- Java 17
- Maven build
- Testes com JUnit 5
- Cobertura com JaCoCo (regra de 80% instruções configurada)

## Estrutura principal
- `src/main/java` — código fonte da aplicação
- `test/java` — testes (nota: este template usa `test/java` em vez do padrão `src/test/java`)
- `pom.xml` — configuração Maven (dependências, plugins, JaCoCo)
- `Makefile` — atalhos convenientes (`make build`, `make test`, `make verify`, `make run`, etc.)

## Como usar (comandos rápidos)
Recomendado: use os alvos do `Makefile` que encapsulam flags e comportamento esperado:

```bash
# Compila e empacota
make build

# Executa toda a suíte de testes
make test

# Executa o ciclo completo (inclui geração de relatório JaCoCo)
make verify

# Gera apenas o relatório JaCoCo (útil quando você já executou testes)
make report

# Executa a aplicação detectando automaticamente a classe com main()
make run

# Executa um teste específico (ex: TEST=com.base.core.domain.UserTest)
make test-single TEST=com.base.core.domain.UserTest
```

O `Makefile` usa `mvn -B` (batch) por padrão para builds não interativos.

## Cobertura e qualidade
- JaCoCo está configurado em `pom.xml`. O relatório é gerado em `target/site/jacoco/index.html`.
- Existe uma regra de cobertura (INSTRUCTION >= 80%). Localmente, execute `make verify` para
  reproduzir o comportamento de CI e inspecionar o relatório.

## Convenções do projeto
- Testes seguem o layout de pacotes dos sources; por exemplo, teste de
  `com.base.core.domain.User` deve ficar em `test/java/com/base/core/domain/UserTest.java`.
- Evite adicionar múltiplas classes `public static void main` sem atualizar a lógica
  de detecção do `Makefile` (o primeiro `main` encontrado é usado por `make run`).
- Ao adicionar dependências que requerem rede, inclua testes que possam ser executados
  em CI sem acesso externo (use mocks ou stubs).

## Guia rápido para contribuidores
1. Branches: crie branches curtos e com escopo claro (`feature/...`, `fix/...`).
2. Commit messages: explicativos, em inglês ou português claro, referenciando issue/PR quando existir.
3. Tests: sempre adicione/atualize testes quando alterar comportamento.
4. Coverage: mantenha a cobertura próxima ou acima do limite configurado; se for reduzir,
   explique na PR e adicione testes compensatórios quando apropriado.



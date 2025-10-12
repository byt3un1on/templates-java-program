SHELL := /bin/bash
MVN := mvn -B

# Detecta automaticamente a classe com método main()
MAIN_CLASS := $(shell grep -rl "public static void main" src/main/java | \
	sed -E 's/src\/main\/java\/|\.java//g' | tr '/' '.' | head -n 1)

# Cores
RESET := \033[0m
BLUE := \033[34m
GREEN := \033[32m
YELLOW := \033[33m

.PHONY: help build test verify package install clean run report coverage ci test-single

help:
	@echo "make [target]"
	@echo
	@echo "Targets:"
	@echo "  build       -> clean + package"
	@echo "  test        -> run tests"
	@echo "  verify      -> full lifecycle + report"
	@echo "  package     -> build jar only"
	@echo "  install     -> install locally"
	@echo "  clean       -> remove target/"
	@echo "  run         -> run detected MAIN_CLASS"
	@echo "  report      -> generate JaCoCo report"
	@echo "  coverage    -> verify + show report path"
	@echo "  ci          -> verify with CI profile"
	@echo "  test-single TEST=Class -> run single test"
	@echo
	@echo "Detected main: $(MAIN_CLASS)"

build:
	@echo -e "$(BLUE)> build$(RESET)"
	@$(MVN) clean package
	@echo -e "$(GREEN)✓ done$(RESET)"

test:
	@echo -e "$(BLUE)> test$(RESET)"
	@$(MVN) test
	@echo -e "$(GREEN)✓ done$(RESET)"

verify:
	@echo -e "$(BLUE)> verify$(RESET)"
	@$(MVN) verify
	@echo -e "$(GREEN)✓ done$(RESET)"

package:
	@$(MVN) package

install:
	@$(MVN) install

clean:
	@$(MVN) clean

run: build
	@if [ -z "$(MAIN_CLASS)" ]; then \
		echo "❌ Nenhuma classe com 'public static void main' encontrada."; \
		exit 1; \
	fi
	@echo -e "$(YELLOW)> running $(MAIN_CLASS)$(RESET)"
	@java -cp target/classes $(MAIN_CLASS)

report:
	@$(MVN) org.jacoco:jacoco-maven-plugin:report
	@echo -e "$(GREEN)✓ report generated at target/site/jacoco$(RESET)"

coverage: verify
	@echo "report: file://$(CURDIR)/target/site/jacoco/index.html"

ci:
	@$(MVN) -DskipTests=false -Pci verify

test-single:
	@if [ -z "$(TEST)" ]; then echo "usage: make test-single TEST=MyTest"; exit 1; fi
	@$(MVN) -Dtest=$(TEST) test

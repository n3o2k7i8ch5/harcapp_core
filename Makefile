.PHONY: install

install:
	flutter pub get
	dart run lefthook_dart install
	flutter pub global activate lefthook_dart

# Generate all code (including Isar adapters)
.PHONY: generate
generate:
	flutter pub get
	dart run build_runner build --delete-conflicting-outputs

.PHONY: import_spraw_book

# Defaults (can be overridden on the make command line)
BOOK_DIR?=assets/sprawnosci/zhr_harc_c_sim_2023
ISAR_DIR?=assets/sprawnosci/sprawnosci.isar

import_spraw_book:
	@if [ -z "$(BOOK_DIR)" ]; then echo "Error: BOOK_DIR is required. Example: make import_spraw_book BOOK_DIR=assets/sprawnosci/zhr_harc_c_sim_2023 ISAR_DIR=.dart_tool/isar"; exit 2; fi
	@if [ -z "$(ISAR_DIR)" ]; then echo "Error: ISAR_DIR is required. Example: make import_spraw_book BOOK_DIR=assets/sprawnosci/zhr_harc_c_sim_2023 ISAR_DIR=.dart_tool/isar"; exit 2; fi
	@echo "Importing from: $(BOOK_DIR) -> Isar dir: $(ISAR_DIR)"
	dart run lib/sprawnosci/generator.dart "$(BOOK_DIR)" "$(ISAR_DIR)"
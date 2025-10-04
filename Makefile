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

.PHONY: import_spraw_books

# Defaults (can be overridden on the make command line)
ISAR_DIR?=assets/sprawnosci_db.isar

# Import all sprawnosci books from assets/sprawnosci
# Note: Run 'make generate' first if you've modified the models
import_spraw_books:
	mkdir -p "$(ISAR_DIR)"
	@echo "Importing all sprawnosci books -> Isar dir: $(ISAR_DIR)"
	dart run lib/sprawnosci/generator.dart "$(ISAR_DIR)"

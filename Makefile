.PHONY: install

install:
	@flutter pub get
	@cp scripts/pre-commit .git/hooks/pre-commit
	@chmod +x .git/hooks/pre-commit
	@echo "Git hooks installed."

# Generate all code (including Isar adapters)
.PHONY: generate
generate:
	@flutter pub get
	dart run build_runner build --delete-conflicting-outputs

.PHONY: import_spraw_books

# Defaults (can be overridden on the make command line)
ISAR_DIR?=assets/sprawnosci_db.isar

# Import all sprawnosci books from assets/sprawnosci
# Note: Run 'make generate' first if you've modified the models
import_spraw_books:
	mkdir -p "$(ISAR_DIR)"
	@echo "Importing all sprawnosci books -> Isar dir: $(ISAR_DIR)"
	dart run lib/sprawnosci/generator.dart --tar "$(ISAR_DIR)"

.PHONY: count_spraws

# Count the number of sprawności in the database
count_spraws:
	@echo "Counting sprawności in database: $(ISAR_DIR)"
	dart run tool/count_spraws.dart "$(ISAR_DIR)"

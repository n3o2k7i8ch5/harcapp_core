.PHONY: install

install:
	@flutter pub get
	@cp scripts/pre-commit .git/hooks/pre-commit
	@chmod +x .git/hooks/pre-commit
	@echo "Git hooks installed."

# Generate all code (build_runner)
.PHONY: generate
generate:
	@flutter pub get
	dart run build_runner build --delete-conflicting-outputs

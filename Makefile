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

# Generate AppMdiIcons font + Dart class from SVGs in assets/app_mdi_icons/.
# Drop kebab-case SVGs there (e.g. pdf-multi.svg) and run `make icons`.
# Filenames map to camelCase identifiers (pdf-multi.svg -> AppMdiIcons.pdfMulti).
.PHONY: icons
icons:
	dart run icon_font_generator:generator \
		assets/app_mdi_icons/ \
		fonts/AppMdiIcons.otf \
		--output-class-file=lib/app_mdi_icons.dart \
		--class-name=AppMdiIcons \
		--font-name=AppMdiIcons \
		--package=harcapp_core \
		--format
	dart run tool/post_process_icons.dart

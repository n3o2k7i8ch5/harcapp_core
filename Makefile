.PHONY: install

install:
	flutter pub get
	dart run lefthook_dart install
	flutter pub global activate lefthook_dart

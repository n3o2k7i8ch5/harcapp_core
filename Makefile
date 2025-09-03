.PHONY: install

install:
	flutter pub get
	dart run lefthook_dart install
	flutter pub global activate lefthook_dart

make generate_all_people_list:
	dart run build_runner build --delete-conflicting-outputs
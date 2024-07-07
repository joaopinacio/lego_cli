ROOT_DIR = $(realpath .)
BIN_DIR = $(ROOT_DIR)/bin
CYAN=\033[1;96m
COLOR_OFF=\033[0m

install:
	@rm -rf $(BIN_DIR)/lego
	@flutter clean && flutter pub get
	@dart format .
	@dart compile exe bin/lego.dart -o bin/lego
	@dart pub global activate --source path $(ROOT_DIR)
	@dart run build_runner build --delete-conflicting-outputs
	@echo "$(CYAN)Done!$(COLOR_OFF)"

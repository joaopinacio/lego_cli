extension StringExtension on String {
  String get snakeCase => replaceAll(RegExp(r'\s+'), '_').toLowerCase();

  String get camelCase => split('_').map((e) {
        return e[0].toUpperCase() + e.substring(1);
      }).join();

  String get properCase => split(' ').map((e) {
        return e[0].toUpperCase() + e.substring(1);
      }).join(' ');
}

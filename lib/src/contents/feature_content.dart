import 'package:lego/src/extensions/string_extension.dart';

class Feature {
  Feature({
    required String name,
    required String project,
  })  : _snakeCase = name.snakeCase,
        _camelCase = name.camelCase,
        _projectName = project;

  final String _snakeCase;
  final String _camelCase;
  final String _projectName;

  String get _projectMain => 'package:$_projectName';
  String get _projectPath => '$_projectMain/src/features/$_snakeCase';
  String get _basePath => 'lib/src/features/$_snakeCase';

  String get dataSourceFilePath =>
      '$_basePath/data/data_sources/${_snakeCase}_datasource.dart';
  String get repositoryFilePath =>
      '$_basePath/data/repositories/${_snakeCase}_repository_impl.dart';
  String get abstractRepositoryFilePath =>
      '$_basePath/domain/repositories/${_snakeCase}_repository.dart';
  String get exceptionFilePath =>
      '$_basePath/domain/exceptions/${_snakeCase}_expcetions.dart';
  String get moduleFilePath =>
      '$_basePath/presentation/module/${_snakeCase}_module.dart';
  String get pagesFilePath =>
      '$_basePath/presentation/module/${_snakeCase}_pages.dart';
  String get routesFilePath =>
      '$_basePath/presentation/module/${_snakeCase}_routes.dart';
  String get pageFilePath =>
      '$_basePath/presentation/pages/${_snakeCase}_page.dart';
  String get controllerFilePath =>
      '$_basePath/presentation/controller/${_snakeCase}_controller.dart';

  String get dataSourceContent => '''
abstract class ${_camelCase}Datasource {
  Future<dynamic> fetch();
}

class ${_camelCase}DatasourceImpl implements ${_camelCase}Datasource {
  ${_camelCase}DatasourceImpl();

  @override
  Future fetch() {
    // TODO: implement fetch
    throw UnimplementedError();
  }
}
''';

  String get repositoryContent => '''
import 'package:fpdart/fpdart.dart';

import '$_projectPath/domain/repositories/${_snakeCase}_repository.dart';
import '$_projectPath/domain/exceptions/${_snakeCase}_expcetions.dart';

class ${_camelCase}RepositoryImpl implements ${_camelCase}Repository {
  @override
  Future<Either<${_camelCase}Exception, dynamic>> fetch() {
    // TODO: implement fetch
    throw UnimplementedError();
  }
}
''';

  String get abstractRepositoryContent => '''
import 'package:fpdart/fpdart.dart';

import '$_projectPath/domain/exceptions/${_snakeCase}_expcetions.dart';

abstract class ${_camelCase}Repository {
  Future<Either<${_camelCase}Exception, dynamic>> fetch();
}
''';

  String get exceptionContent => '''
sealed class ${_camelCase}Exception implements Exception {
  const ${_camelCase}Exception({this.message});
  final String? message;
}

class ${_camelCase}ExceptionGeneric extends ${_camelCase}Exception {
  const ${_camelCase}ExceptionGeneric({super.message});
}

extension ${_camelCase}When on ${_camelCase}Exception {
  T when<T>({
    required T Function() generic,
  }) {
    if (this is ${_camelCase}ExceptionGeneric) {
      return generic.call();
    }
    throw Exception('Unknown exception: \$this');
  }
}
''';

  String get moduleContent => '''
import 'package:flutter_modular/flutter_modular.dart';
import '$_projectMain/src/core/binds/core_bindings.dart';
import '$_projectPath/presentation/controller/${_snakeCase}_controller.dart';
import '$_projectPath/presentation/module/${_snakeCase}_pages.dart';
import '$_projectPath/presentation/pages/${_snakeCase}_page.dart';

class ${_camelCase}Module extends Module {
  @override
  List<Module> get imports => [
        CoreBindings(),
      ];

  @override
  void binds(Injector i) {
    i.addLazySingleton<${_camelCase}Controller>(${_camelCase}Controller.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(${_camelCase}Pages.main, child: (context) => const ${_camelCase}Page());
  }
}
''';

  String get pagesContent => '''
class ${_camelCase}Pages {
  const ${_camelCase}Pages._();

  static const String main = '/';
}
''';

  String get routesContent => '''
import 'package:flutter_modular/flutter_modular.dart';
import '$_projectPath/presentation/module/${_snakeCase}_pages.dart';

typedef Json = Map<String, dynamic>;

/// The routes of $_camelCase
///
/// The routes are used to navigate between the pages of the $_camelCase.
///
/// The routes are:
/// * [${_camelCase}Routes.module] - The main page
class ${_camelCase}Routes {
  const ${_camelCase}Routes._();

  static const String module = '/$_snakeCase';

  /// Navigates to the main page.
  ///
  /// The [args] is the arguments passed to page.
  static void toMain({Json? args}) => Modular.to.navigate('\$module\${${_camelCase}Pages.main}', arguments: args);
}
''';

  String get pageContent => '''
import 'package:flutter/widgets.dart';

class ${_camelCase}Page extends StatefulWidget {
  const ${_camelCase}Page({super.key});

  @override
  State<${_camelCase}Page> createState() => _${_camelCase}PageState();
}

class _${_camelCase}PageState extends State<${_camelCase}Page> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
''';

  String get controllerContent => '''
class ${_camelCase}Controller {}
''';
}

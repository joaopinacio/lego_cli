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

  String get _projectPath => 'package:$_projectName/src/features/$_snakeCase';
  String get _basePath => 'lib/src/features/$_snakeCase';

  String get dataSourceFilePath => '$_basePath/data/data_sources/${_snakeCase}_datasource.dart';
  String get repositoryFilePath => '$_basePath/data/repositories/${_snakeCase}_repository_impl.dart';
  String get abstractRepositoryFilePath => '$_basePath/domain/repositories/${_snakeCase}_repository.dart';
  String get exceptionFilePath => '$_basePath/domain/exceptions/${_snakeCase}_expcetions.dart';

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
import 'package:dartz/dartz.dart';

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
import 'package:dartz/dartz.dart';

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

extension When on ${_camelCase}Exception {
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
}

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:lego/src/contents/feature_content.dart';
import 'package:mason_logger/mason_logger.dart';

/// {@template sample_command}
///
/// `vitrine_cli sample`
/// A [Command] to exemplify a sub command
/// {@endtemplate}
class CreateCommand extends Command<int> {
  /// {@macro sample_command}
  CreateCommand({
    required Logger logger,
  }) : _logger = logger;

  @override
  String get description => 'Creates a new feature';

  @override
  String get name => 'create';

  final Logger _logger;

  @override
  Future<int> run() async {
    if (argResults == null || argResults!.arguments.isEmpty) {
      _logger.err('Feature name is required');
      return ExitCode.usage.code;
    }

    if (argResults!.arguments.length <= 1 || argResults!.arguments[1].isEmpty) {
      _logger.err('Project name is required');
      return ExitCode.usage.code;
    }

    final featureName = argResults!.arguments.first;
    final projectName = argResults!.arguments[1];

    final component = Feature(
      name: featureName,
      project: projectName,
    );

    try {
      File(component.mainFilePath)
        ..createSync(recursive: true)
        ..writeAsStringSync(component.mainContent);
      File(component.dataSourceFilePath)
        ..createSync(recursive: true)
        ..writeAsStringSync(component.dataSourceContent);
      File(component.repositoryFilePath)
        ..createSync(recursive: true)
        ..writeAsStringSync(component.repositoryContent);
      File(component.abstractRepositoryFilePath)
        ..createSync(recursive: true)
        ..writeAsStringSync(component.abstractRepositoryContent);
      File(component.exceptionFilePath)
        ..createSync(recursive: true)
        ..writeAsStringSync(component.exceptionContent);
      File(component.moduleFilePath)
        ..createSync(recursive: true)
        ..writeAsStringSync(component.moduleContent);
      File(component.pagesFilePath)
        ..createSync(recursive: true)
        ..writeAsStringSync(component.pagesContent);
      File(component.routesFilePath)
        ..createSync(recursive: true)
        ..writeAsStringSync(component.routesContent);
      File(component.pageFilePath)
        ..createSync(recursive: true)
        ..writeAsStringSync(component.pageContent);
      File(component.controllerFilePath)
        ..createSync(recursive: true)
        ..writeAsStringSync(component.controllerContent);
    } catch (e) {
      _logger.err('Error creating feature: $e');
      return ExitCode.usage.code;
    }

    _logger.info('Feature created successfully!');

    return ExitCode.success.code;
  }
}

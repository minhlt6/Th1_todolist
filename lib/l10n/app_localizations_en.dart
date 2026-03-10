// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'TodoList';

  @override
  String get addTask => 'Add Task';

  @override
  String get editTask => 'Edit Task';

  @override
  String get deleteTask => 'Delete Task';

  @override
  String get taskCompleted => 'Task completed! Congratulations!';

  @override
  String get chooseBackgroundColor => 'Choose background color';

  @override
  String get taskHint => 'Enter your task...';

  @override
  String get descHint => 'Description (optional)';

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';
}

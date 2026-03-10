import 'package:flutter/widgets.dart';
import 'main_impl.dart' as impl;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await impl.startApp();
}

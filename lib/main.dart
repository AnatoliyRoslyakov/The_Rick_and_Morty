import 'package:flutter/material.dart';
import 'package:the_rick_and_morty/locator_service.dart' as di;
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

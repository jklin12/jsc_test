import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jsc_test/model/news/article_model_adapter.dart';
import 'package:jsc_test/routes/routes.dart';
import 'package:jsc_test/ui/home_screen/home_screen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive
    ..init(appDocumentDir.path)
    ..registerAdapter(ArticleModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSC Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: HomeScreen.id,
      onGenerateRoute: Routes().generateRoute,
    );
  }
}

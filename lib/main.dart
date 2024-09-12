import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/constants/providers.dart';
import 'package:news_app/pages/login_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providerDeclaration,
      child: const GetMaterialApp(
        title: 'Flutter',
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}

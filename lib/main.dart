import 'package:flutter/material.dart';
import 'package:test_drive/screens/home_page.dart';
import 'package:test_drive/service_locator.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}




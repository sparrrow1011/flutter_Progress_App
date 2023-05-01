import 'package:flutter/material.dart';
import 'package:viswal/component/circular.dart';
import 'package:viswal/pages/frontPage.dart';
import 'package:provider/provider.dart';
import 'package:viswal/provider/country.dart';
import 'package:viswal/provider/progess.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProgressProvider()),
          ChangeNotifierProvider(create: (_) => CountriesProvider())
        ],
          child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FrontPage(),
    );
  }
}


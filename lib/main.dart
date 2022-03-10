import 'package:cadastro_de_usuario/signup.dart';
import 'package:flutter/material.dart';
import 'package:cadastro_de_usuario/resources/strings.dart';
import 'package:cadastro_de_usuario/resources/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode currentThemeMode = ThemeMode.light;

  void toggleThemeMode() {
    setState(() {
      currentThemeMode = currentThemeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      themeMode: currentThemeMode,
      theme: SignUpTheme.light,
      darkTheme: SignUpTheme.dark,
      home: SignUp(onThemeModePressed: toggleThemeMode),
    );
  }
}

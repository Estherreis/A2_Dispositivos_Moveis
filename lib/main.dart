import 'package:flutter/material.dart';
import 'screens/auth/login_page.dart';
import 'screens/dashboard/dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portal do Aluno',
      debugShowCheckedModeBanner: false,

      home: const LoginPage(),

      routes: {
        '/login': (context) => const LoginPage(),

        '/dashboard': (context) {

          final alunoId = ModalRoute.of(context)!.settings.arguments as String;
          final alunoNome = ModalRoute.of(context)!.settings.arguments as String;
          return DashboardPage(
            alunoId: alunoId,
            alunoNome: alunoNome,
          );
        },
      },
    );
  }
}
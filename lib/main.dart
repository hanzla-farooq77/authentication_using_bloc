import 'package:authentication_using_bloc/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'bloc/auth_bloc/auth_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AuthScreen());
  }
}

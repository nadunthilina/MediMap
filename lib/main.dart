import 'package:flutter/material.dart';
import 'config/app_theme.dart';
import 'config/routes.dart';

void main() {
  runApp(const MediMapApp());
}

class MediMapApp extends StatelessWidget {
  const MediMapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediMap',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      onGenerateRoute: AppRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
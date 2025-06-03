import 'package:flutter/material.dart';
import 'package:flutter_application_1/role_selection_screen.dart';
import 'package:flutter_application_1/welcome_screen.dart';
import 'package:flutter_application_1/login_signup_screen.dart';
import 'package:flutter_application_1/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.light,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login_signup': (context) => const LoginSignupScreen(),
        '/role_selection': (context) => const RoleSelectionScreen(),
        '/login': (context) => const LoginScreen(),
        // Add more routes here
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pushReplacementNamed(context, '/welcome');
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Centered logo and text
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Logo image
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: Image.asset(
                      'assets/logo.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // MediMap text
                  RichText(
                    text: const TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Medi',
                          style: TextStyle(
                            color: Color(0xFF23B1A4),
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        TextSpan(
                          text: 'Map',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 28,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Bottom indicator bar
            const Positioned(
              left: 0,
              right: 0,
              bottom: 32,
              child: Center(
                child: SizedBox(
                  width: 80,
                  height: 6,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color(0xFF232F47),
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

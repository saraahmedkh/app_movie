import 'package:flutter/material.dart';
import 'package:flutter_application/screens/forget_password/forget_password_screen.dart';
import 'package:flutter_application/screens/login/login_screen.dart';
import 'package:flutter_application/screens/onboarding/onboarding_view.dart';
import 'package:flutter_application/screens/register/language_provider.dart';
import 'package:flutter_application/screens/register/register_screen.dart';
import 'package:flutter_application/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart'; // لازم تعمل Import للمكتبة
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: const MovieApp(),
    ),
  );
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    // بنجيب اللغة الحالية من الـ Provider
    var langProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      locale: langProvider.currentLocale, // هنا بنربط لغة التطبيق بالبروفايدر
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash',
      routes: {
        'splash': (context) => const SplashScreen(),
        'onboarding': (context) => const OnboardingView(),
        'register': (context) => const RegisterScreen(),
        'login': (context) => const LoginScreen(),
        'forget_password': (context) => const ForgetPasswordScreen(),
      },
    );
  }
}

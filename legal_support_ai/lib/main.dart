import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/signin_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const LegalSupportAIApp());
}

class LegalSupportAIApp extends StatelessWidget {
  const LegalSupportAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LegalSupportAI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const SignInScreen(),
    );
  }
}

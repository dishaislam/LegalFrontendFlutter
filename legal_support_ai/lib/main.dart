import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'theme/app_theme.dart';
import 'screens/signin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }

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

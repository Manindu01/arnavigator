import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_ui/ar_navigator_screen.dart';
import 'package:login_signup_ui/forgot_password_screen';
import 'package:login_signup_ui/home_screen.dart';
import 'package:login_signup_ui/login_screen.dart';
import 'package:login_signup_ui/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  List<CameraDescription> cameras = [];
  try {
    cameras = await availableCameras();
  } catch (e) {
    print('Error initializing cameras: $e');
  }

  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.cameras});

  final List<CameraDescription> cameras;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
          title: 'Login & Sinup UI',
      theme: ThemeData(primarySwatch: Colors.teal),
          initialRoute: '/home', // Changed to home for testing
      routes: {
        '/login': (_) => const LoginScreen(),
        '/signup': (_) => const SignUpScreen(),
        '/forgot-password': (_) => const ForgotPasswordScreen(),
        '/home': (_) => const HomeScreen(),
        '/ARNavigator': (_) => NavigationScreen(cameras: cameras),
      },
    );
  }
}

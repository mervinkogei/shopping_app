import 'package:flutter/material.dart';
import 'package:shopping_app/Utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Container(
          child: Image.asset('images/shopping.jpg'),
        ),
      ),
    );
  }
}
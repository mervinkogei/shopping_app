import 'package:flutter/material.dart';
import 'package:shopping_app/UI/home_screen.dart';
import 'package:shopping_app/Utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    launchApp();
    
  }
  void launchApp() async{
    await Future.delayed(const Duration(seconds: 4));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Container(
          child: Image.asset('images/shopping.jpg'),
        ),
      ),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/OnBoardingScreen/on_boarding_screen.dart';
import 'package:movie_app/Wedgits/bottomBar/bottom_bar.dart';
import 'package:movie_app/auth/Login/login_screen.dart';
import 'package:movie_app/generated/assets.dart';
import 'package:movie_app/screens/HomeScreen/home_screen.dart';
import 'package:movie_app/utiles/const/appColors.dart';
import 'package:movie_app/utiles/const/appStyles.dart';
import 'package:movie_app/utiles/remote/end_points.dart';
import 'package:movie_app/utiles/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    super.initState();

  nextScreen();
  }

  nextScreen()async{
    SharedPreferences pref =await SharedPreferences.getInstance();
   bool isOnb= await pref.getBool(EndPoints.onBoarding)??false;
    Future.delayed(const Duration(seconds: 2), () {
      var screen = isOnb ==true ? FirebaseAuth.instance.currentUser!=null?BottomBar(): LoginScreen():OnBoardingScreen();
    Utils.navigateToAndFinish(screen, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.Black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 220),
            Image.asset(Assets.images1.upperLogo.path),
            const SizedBox(height: 175),
            Image.asset(Assets.images1.bottomLogo.path),
            Text("Supervised by Mohamed Nabil", style: AppStyles.Reguler16),
          ],
        ),
      ),
    );
  }
}
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/OnBoardingScreen/cubit/cubit.dart';
import 'package:movie_app/Splash/splashScreen.dart';
import 'package:movie_app/Wedgits/bottomBar/cubit/bottom_bar_cubit.dart';
import 'package:movie_app/auth/ForgetPassword/cubit/forget_password_cubit.dart';
import 'package:movie_app/auth/Login/cubit.dart';
import 'package:movie_app/auth/Register/cubit.dart';
import 'package:movie_app/firebase_options.dart';
import 'package:movie_app/screens/HomeScreen/cubit/home_screen_cubit.dart';
import 'package:movie_app/screens/MovieDetailsScreen/cubit/movie_details_screen_cubit.dart';
import 'package:movie_app/screens/browseScreen/cubit/browse_cubit.dart';
import 'package:movie_app/screens/profileScreen/cubit/profile_cubit.dart';
import 'package:movie_app/screens/searchScreen/cubit/search_cubit.dart';
import 'package:movie_app/utiles/const/app_observer.dart';

void main()async{
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Movie());
}
class Movie extends StatelessWidget {
  const Movie({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OnboardingCubit(),),
        BlocProvider(create: (context) => RegisterCubit(),),
        BlocProvider(create: (context) => LoginCubit(),),
        BlocProvider(create: (context) => ForgetPasswordCubit(),),
        BlocProvider(create: (context) => HomeScreenCubit(),),
        BlocProvider(create: (context) => BottomBarCubit(),),
        BlocProvider(create: (context) => SearchCubit(),),
        BlocProvider(create: (context) => ProfileCubit()..getUserData(),),
        BlocProvider(create: (context) => BrowseCubit()..getInitialData()),
        BlocProvider(create: (context) => MovieDetailsCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splashscreen(),
      ),
    );
  }
}

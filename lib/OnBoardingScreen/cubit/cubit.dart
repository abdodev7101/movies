import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/OnBoardingScreen/cubit/state.dart';
import 'package:movie_app/OnBoardingScreen/onBoardingModel/on_boarding_model.dart';
import 'package:movie_app/generated/assets.dart';


class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitialState()) {}

  static OnboardingCubit get(context) => BlocProvider.of<OnboardingCubit>(context);
  int currentIndex =0;
  List<OnBoardingModel> onboardingList = [
    OnBoardingModel(
      image: Assets.onBoarding1.onBoarding1.path,
      title: 'Discover Movies',
      description: 'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
    ),
    OnBoardingModel(
      image: Assets.onBoarding1.onBoarding2.path,
      title: 'Explore All Genres',
      description: 'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
    ),
    OnBoardingModel(
      image: Assets.onBoarding1.onBoarding3.path,
      title: 'Create Watchlists',
      description:
      'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.',
    ),
    OnBoardingModel(
      image: Assets.onBoarding1.onBoarding4.path,
      title: 'Rate, Review, and Learn',
      description: 'Share your thoughts on the movies you have watched. Dive deep into film details and help others discover great movies with your reviews.',
    ),
    OnBoardingModel(
      image: Assets.onBoarding1.onBoarding5.path,
      title: 'Start Watching Now',
      description: '',
    ),
  ];

  late PageController pageController=PageController(initialPage: currentIndex);
  // إجمالي الصفحات (الصفحة الأولى + القائمة)
  int get totalPages => onboardingList.length + 1;

  void changePageIndex(int index) {
    currentIndex = index;
    emit(ChangeIndexState());
  }

  void nextPage() {
    if (currentIndex < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (currentIndex > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}

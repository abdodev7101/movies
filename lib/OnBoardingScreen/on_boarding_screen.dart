import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/OnBoardingScreen/cubit/cubit.dart';
import 'package:movie_app/OnBoardingScreen/cubit/state.dart';

import 'package:movie_app/generated/assets.dart';
import 'package:movie_app/auth/Login/login_screen.dart';
import 'package:movie_app/utiles/const/appColors.dart';
import 'package:movie_app/utiles/const/appStyles.dart';
import 'package:movie_app/utiles/remote/end_points.dart';
import 'package:movie_app/utiles/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          var cubit = OnboardingCubit.get(context);
          return Scaffold(
            body: PageView.builder(
              controller: cubit.pageController,
              itemCount: cubit.totalPages,
              onPageChanged: (index) {
                cubit.changePageIndex(index);
              },
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Assets.onBoarding1.onBoardingTitle.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Find Your Next Favorite Movie Here",
                            style: AppStyles.Medium36,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Get access to a huge library of movies to suit all tastes. You will surely like it.",
                            style: AppStyles.Reguler20.copyWith(
                              color: AppColors.White.withValues(alpha: 0.6),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                cubit.nextPage();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.Yellow,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Text(
                                "Explore Now",
                                style: AppStyles.BoldBlack20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                final item = cubit.onboardingList[index - 1];
                final isLastPage = index == cubit.totalPages - 1;
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(item.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsetsGeometry.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.Black,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(28),
                            topRight: Radius.circular(28),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item.title,
                              style: AppStyles.Medium36,
                              textAlign: TextAlign.center,
                            ),

                              Text(
                                item.description,
                                style: AppStyles.Reguler20,
                                textAlign: TextAlign.center,
                              ),

                            const SizedBox(height: 10),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async{
                                  if (isLastPage) {
                                    SharedPreferences pref =await SharedPreferences.getInstance();
                                  await pref.setBool(EndPoints.onBoarding, true);
                                  Utils.navigateToAndFinish(LoginScreen(), context);
                                  } else {
                                    cubit.nextPage();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.Yellow,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Text(
                                  isLastPage ? "Finish" : "Next",
                                  style: AppStyles.BoldBlack20,
                                ),
                              ),
                            ),

                            // زرار Back (يظهر بداية من الشاشة الثالثة وتحت زرار Next/Finish)
                            if (index > 1) ...[
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () {
                                    cubit.previousPage();
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: AppColors.Yellow,
                                      width: 1.5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: Text(
                                    "Back",
                                    style: AppStyles.BoldBlack20.copyWith(
                                      color: AppColors.Yellow,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,)
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
    );
  }
}
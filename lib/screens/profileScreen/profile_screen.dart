import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/auth/Login/login_screen.dart';
import 'package:movie_app/generated/assets.dart';
import 'package:movie_app/screens/HomeScreen/Home_wedgit/home_card.dart';
import 'package:movie_app/screens/MovieDetailsScreen/movie_details_screen.dart';
import 'package:movie_app/screens/profileScreen/EditProfileScreen/edit_profile_screen.dart';
import 'package:movie_app/screens/profileScreen/TabBar/custom_tab_bar.dart';
import 'package:movie_app/screens/profileScreen/cubit/profile_cubit.dart';
import 'package:movie_app/screens/profileScreen/cubit/state.dart';
import 'package:movie_app/utiles/const/appColors.dart';
import 'package:movie_app/utiles/const/appStyles.dart';
import 'package:movie_app/utiles/utils.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: AppColors.Black,
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    width: double.infinity,
                    color: AppColors.Grey,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(cubit.avatarPath),
                                ),
                                Text(
                                  cubit.userModel?.name ?? 'Demo',
                                  style: AppStyles.BoldWhite20.copyWith(
                                    color: AppColors.White,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${cubit.wishList.length}", style: AppStyles.BoldWhite24),
                                Text("Watch List", style: AppStyles.BoldWhite24),
                              ],
                            ),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${cubit.historyList.length}", style: AppStyles.BoldWhite24),
                                Text("History", style: AppStyles.BoldWhite24),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: ElevatedButton(
                                onPressed: () {
                                  Utils.navigateTo(
                                    EditProfileScreen(),
                                    context,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.Yellow,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Text(
                                  "Edit Profile",
                                  style: AppStyles.RegulerBlack20,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: ProfileCubit.get(context).state is SignOutLoadingState
                                    ? null
                                    : () {
                                  cubit.signOut();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.Red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: ProfileCubit.get(context).state is SignOutLoadingState
                                    ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: AppColors.White,
                                    strokeWidth: 2,
                                  ),
                                )
                                    : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Exit", style: AppStyles.Reguler20),
                                    const SizedBox(width: 3),
                                    const Icon(
                                      Icons.exit_to_app,
                                      color: AppColors.White,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        CustomTabBar(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        cubit.wishList.isEmpty
                            ? Center(
                          child: Image.asset(Assets.images1.popcorn.path, width: 120),
                        )
                            : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: cubit.wishList.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.65,
                            ),
                            itemBuilder: (context, index) {
                              return HomeCard(
                                moviesmodel: cubit.wishList[index],
                                onTap: () {
                                  Utils.navigateTo(
                                    MovieDetailsScreen(movieId: cubit.wishList[index].id?.toInt() ?? 0),
                                    context,
                                  );
                                },
                              );
                            },
                          ),
                        ),

                        cubit.historyList.isEmpty
                            ? Center(
                          child: Image.asset(Assets.images1.popcorn.path, width: 120),
                        )
                            : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: cubit.historyList.length,
                            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.65,
                            ),
                            itemBuilder: (context, index) {
                              return HomeCard(
                                moviesmodel: cubit.historyList[index],
                                onTap: () {
                                  Utils.navigateTo(
                                    MovieDetailsScreen(movieId: cubit.historyList[index].id?.toInt() ?? 0),
                                    context,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is SignOutSuccessState) {
          Utils.navigateToAndFinish(LoginScreen(), context);
        }

        if (state is UpdateUserSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data updated successfully!'), backgroundColor: AppColors.Green),
          );
        }
      },
    );
  }
}

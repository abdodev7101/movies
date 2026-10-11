import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/OnBoardingScreen/on_boarding_screen.dart';
import 'package:movie_app/Wedgits/bottomBar/bottom_bar.dart';
import 'package:movie_app/generated/assets.dart';
import 'package:movie_app/screens/profileScreen/cubit/profile_cubit.dart';
import 'package:movie_app/screens/profileScreen/cubit/state.dart';
import 'package:movie_app/utiles/const/appColors.dart';
import 'package:movie_app/utiles/const/appStyles.dart';
import 'package:movie_app/utiles/utils.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return Scaffold(
          backgroundColor: AppColors.Black,
          appBar: AppBar(
            backgroundColor: AppColors.Black,
            leading: IconButton(
              onPressed: () {
                Utils.navigateToAndFinish(BottomBar(), context);
              },
              icon: Icon(Icons.arrow_back, color: AppColors.Yellow),
            ),
            title: Text("Pick Avatar", style: AppStyles.RegulerYellow15),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(cubit.avatarPath),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsetsGeometry.only(
                    left: 5,
                    right: 5,
                    top: 10,
                    bottom: 10,
                  ),
                  child: TextFormField(
                    controller: cubit.nameController,
                    style: AppStyles.Reguler16,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.person,
                        color: AppColors.White,
                      ),
                      filled: true,
                      fillColor: AppColors.Grey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsGeometry.only(left: 5, right: 5),
                  child: TextFormField(
                    controller: cubit.phoneController,
                    style: AppStyles.Reguler16,
                    decoration: InputDecoration(
                      prefixIcon: Image.asset(Assets.images1.callIcon.path),
                      filled: true,
                      fillColor: AppColors.Grey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Reset Password",
                        style: AppStyles.Reguler20,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 140),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.Red,
                      minimumSize: Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      cubit.deleteAccount();
                    },
                    child: Text("Delete Account", style: AppStyles.Reguler20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.Yellow,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: ProfileCubit.get(context).state is UpdateUserLoadingState
                        ? null
                        : () {
                      ProfileCubit.get(context).updateUserData();
                    },
                    child: ProfileCubit.get(context).state is UpdateUserLoadingState
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: AppColors.Black,
                        strokeWidth: 2,
                      ),
                    )
                        : Text("Update Data", style: AppStyles.RegulerBlack20),
                  ),
                )
              ],
            ),
          ),
        );
      },
        listener: (context, state) {
          if (state is DeleteUserSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Deleted successfully'),
                backgroundColor: AppColors.Green,
              ),
            );
            Utils.navigateToAndFinish(const OnBoardingScreen(), context);
          } else if (state is DeleteUserErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: AppColors.Red,
              ),
            );
          }
        }
    );
  }
}

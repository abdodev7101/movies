import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Wedgits/CustomTextField/custom_text_field.dart';
import 'package:movie_app/Wedgits/bottomBar/bottom_bar.dart';
import 'package:movie_app/auth/Login/login_screen.dart';
import 'package:movie_app/auth/Register/cubit.dart';
import 'package:movie_app/auth/Register/state.dart';
import 'package:movie_app/generated/assets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_app/utiles/const/appColors.dart';
import 'package:movie_app/utiles/const/appStyles.dart';
import 'package:movie_app/utiles/utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      builder: (context, state) {
        final cubit = RegisterCubit.get(context);
        return Scaffold(
          backgroundColor: AppColors.Black,
          appBar: AppBar(
            backgroundColor: AppColors.Black,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              icon: Icon(Icons.arrow_back, color: AppColors.Yellow),
            ),
            title: Text("Register", style: AppStyles.RegulerYellow15),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                CarouselSlider(
                  items: List.generate(cubit.Profiles.length, (index) {
                    return CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(cubit.Profiles[index]),
                    );
                  }),
                  carouselController: cubit.carouselController,
                  options: CarouselOptions(
                    height: 100,
                    viewportFraction: 0.3,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    initialPage: 0,
                    onPageChanged: (index, reason) {
                      cubit.changeAvatar(index);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Center(child: Text("Avatar", style: AppStyles.Reguler16)),
                CustomTextField(
                  hint: "Name",
                  icon: Assets.images1.identificationIcon.path,
                  controller: cubit.nameController,
                ),
                CustomTextField(
                  hint: "Email",
                  icon: Assets.images1.emailIcon.path,
                  controller: cubit.emailController,
                ),
                CustomTextField(
                  hint: "Password",
                  icon: Assets.images1.passwordIcon.path,
                  isPassword: true,
                  controller: cubit.passwordController,
                ),
                CustomTextField(
                  hint: "Confirm Password",
                  icon: Assets.images1.passwordIcon.path,
                  isPassword: true,
                  controller: cubit.confirmPasswordController,
                ),
                CustomTextField(
                  hint: "Phone Number",
                  icon: Assets.images1.callIcon.path,
                  controller: cubit.phoneController,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: state is RegisterLoadingState
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.Yellow,
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () async{
                            await cubit.registerUser();
                            cubit.nameController.clear();
                            cubit.emailController.clear();
                            cubit.passwordController.clear();
                            cubit.confirmPasswordController.clear();
                            cubit.phoneController.clear();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.Yellow,
                            minimumSize: const Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            "Create Account",
                            style: AppStyles.RegulerBlack20,
                          ),
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already Have Account ? ',
                      style: TextStyle(color: AppColors.White, fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Text('Login', style: AppStyles.RegulerYellow14),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: 90,
                  height: 38,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.Yellow, width: 3),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            cubit.isAmericaSelected = true;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: cubit.isAmericaSelected
                                ? AppColors.Yellow
                                : Colors.transparent,
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              Assets.images1.america.path,
                              height: 26,
                              width: 27,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            cubit.isAmericaSelected = false;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: cubit.isAmericaSelected
                                ? AppColors.Yellow
                                : Colors.transparent,
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              Assets.images1.eG.path,
                              height: 26,
                              width: 27,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          Utils.navigateToAndFinish(BottomBar(), context);
        }
        if (state is RegisterErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error Register : ${state.Errormessage}')),
          );
        }
      },
    );
  }
}

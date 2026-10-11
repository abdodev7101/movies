import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/Wedgits/CustomTextField/custom_text_field.dart';
import 'package:movie_app/Wedgits/bottomBar/bottom_bar.dart';
import 'package:movie_app/auth/ForgetPassword/forget_password.dart';
import 'package:movie_app/auth/Login/cubit.dart';
import 'package:movie_app/auth/Login/state.dart';
import 'package:movie_app/auth/Register/register_screen.dart';
import 'package:movie_app/generated/assets.dart';
import 'package:movie_app/screens/HomeScreen/home_screen.dart';
import 'package:movie_app/utiles/const/appColors.dart';
import 'package:movie_app/utiles/const/appStyles.dart';
import 'package:movie_app/utiles/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isAmericaSelected = true;
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit,LoginState>(
      listener: (context, state) {
        if (state is GetUserSuccessState) {
          Utils.navigateToAndFinish(BottomBar(), context);
        }
        if (state is LoginErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error Register : ${state.Errormessage}')),
          );
        } if (state is GetUserErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error Register : ${state.error}')),
          );
        }
      },

      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          backgroundColor: AppColors.Black,
          body: Container(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Image.asset(Assets.images1.upperLogo.path,height: 150,),
                  CustomTextField(
                      hint:"Email",
                      icon: Assets.images1.emailIcon.path,
                    controller:cubit. emailController,
                  ),CustomTextField(
                      hint:"Password",
                      icon: Assets.images1.passwordIcon.path,
                    controller:cubit. passwordController,
                    isPassword: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ForgetPassword()),
                        );
                      },
                      child: Text(
                        'Forget Password ?',
                        style: AppStyles.RegulerYellow14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(onPressed: ()async{
                       await cubit.userLogin();
                        cubit.emailController.clear();
                        cubit.passwordController.clear();
                    },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.Yellow,
                            minimumSize: Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(15),
                            ),
                          ),
                        child: Text("Login",style: AppStyles.RegulerBlack20,)
                    ),
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don’t Have Account ? ',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterScreen()),
                          );
                        },
                        child: Text(
                          'Create One',
                          style: AppStyles.RegulerYellow14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text("OR",style: AppStyles.RegulerYellow15,),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.Yellow,
                          minimumSize: Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(15),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           SvgPicture.asset(Assets.images1.google.path,),
                            SizedBox(width: 8,),
                            Text("Login With Google",style: AppStyles.RegulerBlack16,),
                          ],
                        )
                    ),
                  ),
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
                          isAmericaSelected = true;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isAmericaSelected ? AppColors.Yellow : Colors.transparent,
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
                          isAmericaSelected = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: !isAmericaSelected ? AppColors.Yellow : Colors.transparent,
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
            ]
              ),
            ),
          )
        );
      }
    );
  }
}


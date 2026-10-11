import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Wedgits/CustomTextField/custom_text_field.dart';
import 'package:movie_app/auth/ForgetPassword/cubit/forget_password_cubit.dart';
import 'package:movie_app/auth/Login/login_screen.dart';

import 'package:movie_app/generated/assets.dart';
import 'package:movie_app/utiles/const/appColors.dart';
import 'package:movie_app/utiles/const/appStyles.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}
class _ForgetPasswordState extends State<ForgetPassword> {

@override
void dispose() {
super.dispose();
}
  Widget build(BuildContext context) {
    return BlocConsumer(builder: (context, state) {
      var cubit = ForgetPasswordCubit.get(context);
      return Scaffold(
        backgroundColor: AppColors.Black,
        appBar: AppBar(
          backgroundColor: AppColors.Black,
          leading: IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }, icon: Icon(Icons.arrow_back,color: AppColors.Yellow,)),
          title: Text("Forget Password",style: AppStyles.RegulerYellow15,),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(Assets.images1.forgotPasswordBro1.path),
              CustomTextField(
                hint:"Email",
                icon: Assets.images1.emailIcon.path,
                controller: cubit.emailController,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(onPressed: (){

                },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.Yellow,
                      minimumSize: Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(15),
                      ),
                    ),
                    child: Text("Verify Email",style: AppStyles.RegulerBlack20,)
                ),
              ),
            ],
          ),
        ),
      );
    }, listener: (context, state) {

    },);
  }
}

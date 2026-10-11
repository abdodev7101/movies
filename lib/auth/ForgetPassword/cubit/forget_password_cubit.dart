import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/auth/ForgetPassword/cubit/state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState>{
  ForgetPasswordCubit() : super(ForgetPasswordInitialState());
  static ForgetPasswordCubit get(context) => BlocProvider.of<ForgetPasswordCubit>(context);
  final emailController = TextEditingController();
}
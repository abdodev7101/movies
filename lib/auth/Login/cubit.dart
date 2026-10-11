import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/auth/Login/state.dart';
import 'package:movie_app/utiles/models/user_model.dart';
import 'package:movie_app/utiles/remote/end_points.dart';
import 'package:movie_app/utiles/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);
  var db = FirebaseFirestore.instance;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

   userLogin() async {
    emit(LoginLoadingState());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      await getUserData();
    } catch (e) {
      print(e);
      emit(LoginErrorState(e.toString()));
    }
  }
  getUserData() async {
    emit(GetUserLoadingState());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userPref = await prefs.getString('user');
      Map<String, dynamic>? userData;
      if(userPref != null)
        userData = jsonDecode(userPref);
      UserModel? userDataModel;
      if(userData != null) {
        userDataModel = UserModel.fromJson(userData);
      }
      db
          .collection(EndPoints.userCollection)
          .doc(FirebaseAuth.instance.currentUser?.uid ?? '')
          .get()
          .then((v) {
            if(v.data()!=null)
            userModel = UserModel.fromJson(v.data()!);
              prefs.setString('user', jsonEncode(userModel?.toJson()));
      });
      emit(GetUserSuccessState());
    } catch (e) {
      print(e.toString());
      emit(GetUserErrorState(e.toString()));
    }
  }
}

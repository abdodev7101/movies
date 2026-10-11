import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/generated/assets.dart';
import 'package:movie_app/utiles/models/user_model.dart';
import 'package:movie_app/utiles/remote/end_points.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of<RegisterCubit>(context);
  List<String> Profiles = [
    Assets.images1.gamer1.path,
    Assets.images1.gamer2.path,
    Assets.images1.gamer3.path,
  ];
  int selectedAvatar = 0;

  void changeAvatar(int index) {
    selectedAvatar = index;
    emit(RegisterAvatarChangedState());
  }

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var phoneController = TextEditingController();
  CarouselSliderController? carouselController;
  var db = FirebaseFirestore.instance;
  bool isAmericaSelected = true;
  UserModel? currentUser;

  Future<void> registerUser() async {
    emit(RegisterLoadingState());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      final String? uid = userCredential.user?.uid;
      if (uid == null) {
        throw Exception("Failed to retrieve user ID after registration.");
      }
currentUser = UserModel(
    avatar: selectedAvatar,
    name: nameController.text.trim(),
    email: emailController.text.trim(),
    id: uid,
    phone: phoneController.text.trim(),
);
      await db
          .collection(EndPoints.userCollection)
          .doc(uid)
          .set(currentUser!.toJson());
      await db
          .collection(EndPoints.userCollection)
          .doc(uid)
          .set(currentUser!.toJson());

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("user", jsonEncode(currentUser!.toJson()));

      emit(RegisterSuccessState());

      emit(RegisterSuccessState());

    } on FirebaseAuthException catch (e) {
      // Auth-specific errors
      String errorMessage = _getAuthErrorMessage(e.code);
      print('FirebaseAuthException [${e.code}]: ${e.message}');
      emit(RegisterErrorState(errorMessage));

    } on FirebaseException catch (e) {
      // Database or other Firebase service errors
      print('FirebaseException [${e.code}]: ${e.message}');
      emit(RegisterErrorState("Database error: ${e.message ?? 'Operation failed.'}"));

    } catch (e) {
      // Any other unexpected errors (e.g., NullPointerException, network issues)
      print('Unexpected Exception: ${e.toString()}');
      emit(RegisterErrorState("An unexpected error occurred. Please try again."));
    }
  }

  /// Helper method to map Firebase Auth error codes to user-friendly messages
  String _getAuthErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return 'The email address is already registered by another account.';
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled in Firebase.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'network-request-failed':
        return 'A network error occurred. Please check your connection.';
      default:
        return 'Authentication failed ($errorCode). Please try again.';
    }
  }
}
